Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286256AB918
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 10:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCFJA6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 04:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCFJAz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 04:00:55 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8564F83FA;
        Mon,  6 Mar 2023 01:00:50 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,236,1673881200"; 
   d="scan'208";a="154992617"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Mar 2023 18:00:50 +0900
Received: from localhost.localdomain (unknown [10.226.93.39])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2FD4941C9BA3;
        Mon,  6 Mar 2023 18:00:46 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [DO NOT APPLY PATCH v6 08/13] pinctrl: renesas: rzg2l-poeg: Add support for GPT Output-Disable Request
Date:   Mon,  6 Mar 2023 09:00:09 +0000
Message-Id: <20230306090014.128732-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch supports output-disable requests from GPT.

Added sysfs to enable/disable request from GPT when both outputs
are high.

When both outputs are high, gpt detects the condition and triggers
an interrupt to POEG. POEG handles the interrupt and send notification
to userspace. userspace handles the fault and issue a write call to
cancel the disable output request.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 206 +++++++++++++++++++++-
 include/linux/pinctrl/pinctrl-rzg2l.h     |   9 +
 2 files changed, 212 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index 30f4352e257d..b6f01065c058 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -4,27 +4,45 @@
  *
  * Copyright (C) 2022 Renesas Electronics Corporation
  */
+#include <linux/cdev.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/pinctrl-rzg2l.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwm/rzg2l-gpt.h>
+#include <linux/poll.h>
 #include <linux/reset.h>
+#include <linux/wait.h>
 
+#define POEGG_IOCE	BIT(5)
+#define POEGG_PIDE	BIT(4)
 #define POEGG_SSF	BIT(3)
+#define POEGG_IOCF	BIT(1)
+#define POEGG_PIDF	BIT(0)
 
 #define RZG2L_POEG_MAX_INDEX		3
 
 #define RZG2L_GPT_MAX_HW_CHANNELS	8
 #define RZG2L_GPT_INVALID_CHANNEL	0xff
 
+static struct class *poeg_class;
+static dev_t g_poeg_dev;
+static int minor_n;
+
 struct rzg2l_poeg_chip {
 	struct device *gpt_dev;
 	struct reset_control *rstc;
 	void __iomem *mmio;
 	u8 index;
+	DECLARE_BITMAP(gpt_irq, 3);
+	struct cdev poeg_cdev;
+	wait_queue_head_t events_wait;
+	DECLARE_KFIFO_PTR(events, struct poeg_event);
 	u8 gpt_channels[RZG2L_GPT_MAX_HW_CHANNELS];
 };
 
@@ -65,6 +83,20 @@ static int rzg2l_poeg_output_disable_user(struct rzg2l_poeg_chip *chip,
 	return 0;
 }
 
+static int rzg2l_poeg_output_disable_both_high(struct rzg2l_poeg_chip *chip,
+					       bool enable)
+{
+	if (enable)
+		set_bit(RZG2L_GPT_OABHF, chip->gpt_irq);
+	else
+		clear_bit(RZG2L_GPT_OABHF, chip->gpt_irq);
+
+	rzg2l_gpt_poeg_disable_req_both_high(chip->gpt_dev, chip->index,
+					     test_bit(RZG2L_GPT_OABHF, chip->gpt_irq));
+
+	return 0;
+}
+
 static int rzg2l_poeg_cb(void *context, const char *fname, const char *gname,
 			 enum pin_output_disable_conf conf,
 			 unsigned int conf_val)
@@ -88,6 +120,8 @@ static int rzg2l_poeg_cb(void *context, const char *fname, const char *gname,
 		ret = rzg2l_poeg_output_disable_user(context, !!conf_val);
 		break;
 	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_PIN_OUTPUT_HIGH:
+		ret = rzg2l_poeg_output_disable_both_high(context, !!conf_val);
+		break;
 	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_PIN_OUTPUT_LOW:
 	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_DEAD_TIME_ERROR:
 	default:
@@ -97,6 +131,111 @@ static int rzg2l_poeg_cb(void *context, const char *fname, const char *gname,
 	return ret;
 }
 
+static irqreturn_t rzg2l_poeg_irq(int irq, void *ptr)
+{
+	struct rzg2l_poeg_chip *chip = ptr;
+	struct poeg_event ev;
+	u32 val;
+
+	val = rzg2l_gpt_poeg_disable_req_irq_status(chip->gpt_dev, chip->index);
+	ev.channel = chip->index;
+	ev.gpt_disable_irq_status = val;
+	kfifo_in(&chip->events, &ev, 1);
+	wake_up_poll(&chip->events_wait, EPOLLIN);
+
+	val = rzg2l_poeg_read(chip);
+	if (val & POEGG_IOCF)
+		val &= ~POEGG_IOCF;
+
+	if (val & POEGG_PIDF)
+		val &= ~POEGG_PIDF;
+
+	rzg2l_poeg_write(chip, val);
+	rzg2l_gpt_poeg_disable_req_clr(chip->gpt_dev, chip->index);
+
+	return IRQ_HANDLED;
+}
+
+static __poll_t rzg2l_poeg_chrdev_poll(struct file *filp,
+				       struct poll_table_struct *pollt)
+{
+	struct rzg2l_poeg_chip *const chip = filp->private_data;
+	__poll_t events = 0;
+
+	poll_wait(filp, &chip->events_wait, pollt);
+	if (!kfifo_is_empty(&chip->events))
+		events = EPOLLIN | EPOLLRDNORM;
+
+	return events;
+}
+
+static ssize_t rzg2l_poeg_chrdev_read(struct file *filp, char __user *buf,
+				      size_t len, loff_t *f_ps)
+{
+	struct rzg2l_poeg_chip *const chip = filp->private_data;
+	unsigned int copied;
+	int err;
+
+	if (len < sizeof(struct poeg_event))
+		return -EINVAL;
+
+	do {
+		if (kfifo_is_empty(&chip->events)) {
+			if (filp->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			err = wait_event_interruptible(chip->events_wait,
+						       !kfifo_is_empty(&chip->events));
+			if (err < 0)
+				return err;
+		}
+
+		err = kfifo_to_user(&chip->events, buf, len, &copied);
+		if (err < 0)
+			return err;
+	} while (!copied);
+
+	return copied;
+}
+
+static ssize_t rzg2l_poeg_chrdev_write(struct file *filp,
+				       const char __user *buf,
+				       size_t len, loff_t *f_ps)
+{
+	struct rzg2l_poeg_chip *const chip = filp->private_data;
+
+	rzg2l_gpt_pin_reenable(chip->gpt_dev, chip->index);
+
+	return len;
+}
+
+static int rzg2l_poeg_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct rzg2l_poeg_chip *const chip = container_of(inode->i_cdev,
+							  typeof(*chip),
+							  poeg_cdev);
+
+	filp->private_data = chip;
+
+	return nonseekable_open(inode, filp);
+}
+
+static int rzg2l_poeg_chrdev_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+
+	return 0;
+}
+
+static const struct file_operations poeg_fops = {
+	.owner = THIS_MODULE,
+	.read = rzg2l_poeg_chrdev_read,
+	.write = rzg2l_poeg_chrdev_write,
+	.poll = rzg2l_poeg_chrdev_poll,
+	.open = rzg2l_poeg_chrdev_open,
+	.release = rzg2l_poeg_chrdev_release,
+};
+
 static bool rzg2l_poeg_get_linked_gpt_channels(struct platform_device *pdev,
 					       struct rzg2l_poeg_chip *chip,
 					       struct device_node *gpt_np,
@@ -168,6 +307,7 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 	struct device_node *np;
 	u32 val;
 	int ret;
+	int irq;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -199,10 +339,20 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->mmio))
 		return PTR_ERR(chip->mmio);
 
-	if (gpt_linked)
+	if (gpt_linked) {
 		rzg2l_output_disable_cb_register(chip->gpt_dev,
 						 rzg2l_poeg_cb, chip);
 
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
+
+		ret = devm_request_irq(&pdev->dev, irq, rzg2l_poeg_irq, 0,
+				       dev_name(&pdev->dev), chip);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret, "cannot get irq\n");
+	}
+
 	chip->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(chip->rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(chip->rstc),
@@ -220,8 +370,24 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	return 0;
+	if (gpt_linked)
+		rzg2l_poeg_write(chip, POEGG_IOCE | POEGG_PIDE);
+
+	init_waitqueue_head(&chip->events_wait);
+	cdev_init(&chip->poeg_cdev, &poeg_fops);
+	chip->poeg_cdev.owner = THIS_MODULE;
+	ret = cdev_add(&chip->poeg_cdev,  MKDEV(MAJOR(g_poeg_dev), minor_n), 1);
+	if (ret)
+		goto err_pm;
+
+	device_create(poeg_class, NULL, MKDEV(MAJOR(g_poeg_dev), minor_n),
+		      NULL, "poeg%d", minor_n);
+	minor_n++;
+
+	return kfifo_alloc(&chip->events, 64, GFP_KERNEL);
 
+err_pm:
+	pm_runtime_put(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(chip->rstc);
@@ -232,6 +398,10 @@ static int rzg2l_poeg_remove(struct platform_device *pdev)
 {
 	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
 
+	kfifo_free(&chip->events);
+	device_destroy(poeg_class,
+		       MKDEV(MAJOR(g_poeg_dev), MINOR(chip->poeg_cdev.dev)));
+	cdev_del(&chip->poeg_cdev);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(chip->rstc);
@@ -247,7 +417,37 @@ static struct platform_driver rzg2l_poeg_driver = {
 	.probe = rzg2l_poeg_probe,
 	.remove = rzg2l_poeg_remove,
 };
-module_platform_driver(rzg2l_poeg_driver);
+
+static int rzg2l_poeg_device_init(void)
+{
+	int err;
+
+	err = alloc_chrdev_region(&g_poeg_dev, 0, 1, "poeg");
+	if (err)
+		goto out;
+
+	poeg_class = class_create(THIS_MODULE, "poeg");
+	if (IS_ERR(poeg_class)) {
+		err = PTR_ERR(poeg_class);
+		goto err_free_chrdev;
+	}
+
+	return platform_driver_register(&rzg2l_poeg_driver);
+
+err_free_chrdev:
+	unregister_chrdev_region(g_poeg_dev, 1);
+out:
+	return err;
+}
+
+static void rzg2l_poeg_device_exit(void)
+{
+	class_destroy(poeg_class);
+	unregister_chrdev_region(g_poeg_dev, 1);
+}
+
+module_init(rzg2l_poeg_device_init);
+module_exit(rzg2l_poeg_device_exit);
 
 MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L POEG Driver");
diff --git a/include/linux/pinctrl/pinctrl-rzg2l.h b/include/linux/pinctrl/pinctrl-rzg2l.h
index a49b4c5f8908..94d1b12d84c8 100644
--- a/include/linux/pinctrl/pinctrl-rzg2l.h
+++ b/include/linux/pinctrl/pinctrl-rzg2l.h
@@ -4,6 +4,15 @@
 
 #include <linux/pinctrl/output-disable.h>
 
+#define RZG2L_GPT_DTEF	0
+#define RZG2L_GPT_OABHF	1
+#define RZG2L_GPT_OABLF	2
+
+struct poeg_event {
+	__u32 gpt_disable_irq_status;
+	__u8 channel;
+};
+
 typedef int (*output_disable_cb) (void *context,
 				  const char *fname,
 				  const char *gname,
-- 
2.25.1

