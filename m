Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507116CBC1C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 12:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjC1KLP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 06:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjC1KLC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 06:11:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFAAB6A68;
        Tue, 28 Mar 2023 03:10:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,297,1673881200"; 
   d="scan'208";a="157440661"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Mar 2023 19:10:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id F13B240071EC;
        Tue, 28 Mar 2023 19:10:28 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v7 04/10] pinctrl: renesas: rzg2l-poeg: Add support for GPT Output-Disable Request
Date:   Tue, 28 Mar 2023 11:10:05 +0100
Message-Id: <20230328101011.185594-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
References: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch supports output-disable requests from GPT.

When both outputs are high, gpt detects the condition and triggers
an interrupt to POEG. POEG handles the interrupt and send notification
to userspace. userspace handles the fault and issue a write call to
cancel the disable output request.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 165 +++++++++++++++++++++-
 include/linux/pinctrl/rzg2l-poeg.h        |   9 ++
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index 30e75954af76..2683930309ca 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -5,16 +5,23 @@
  * Copyright (C) 2023 Renesas Electronics Corporation
  */
 #include <linux/cdev.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/rzg2l-poeg.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwm/rzg2l-gpt.h>
+#include <linux/poll.h>
 #include <linux/reset.h>
+#include <linux/wait.h>
 
+#define POEGG_IOCE	BIT(5)
 #define POEGG_SSF	BIT(3)
+#define POEGG_IOCF	BIT(1)
 
 #define RZG2L_POEG_MAX_INDEX		3
 
@@ -41,7 +48,10 @@ struct rzg2l_poeg_chip {
 	struct device *gpt_dev;
 	struct reset_control *rstc;
 	void __iomem *mmio;
+	DECLARE_BITMAP(gpt_irq, 3);
 	struct cdev poeg_cdev;
+	wait_queue_head_t events_wait;
+	DECLARE_KFIFO_PTR(events, struct poeg_event);
 	u8 gpt_channels[RZG2L_GPT_MAX_HW_CHANNELS];
 	u8 index;
 	u32 cfg;
@@ -74,6 +84,76 @@ static int rzg2l_poeg_output_disable_user(struct rzg2l_poeg_chip *chip,
 	return 0;
 }
 
+static void rzg2l_poeg_config_irq(struct rzg2l_poeg_chip *chip)
+{
+	if (test_bit(RZG2L_GPT_OABHF, chip->gpt_irq))
+		rzg2l_gpt_poeg_disable_req_both_high(chip->gpt_dev, chip->index, true);
+}
+
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
+	rzg2l_gpt_poeg_disable_req_clr(chip->gpt_dev, chip->index);
+	val = rzg2l_poeg_read(chip);
+	if (val & POEGG_IOCF)
+		val &= ~POEGG_IOCF;
+
+	rzg2l_poeg_write(chip, val);
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
 static ssize_t rzg2l_poeg_chrdev_write(struct file *filp,
 				       const char __user *buf,
 				       size_t len, loff_t *f_ps)
@@ -91,6 +171,12 @@ static ssize_t rzg2l_poeg_chrdev_write(struct file *filp,
 	case RZG2L_POEG_USR_CTRL_DISABLE_CMD:
 		rzg2l_poeg_output_disable_user(chip, false);
 		break;
+	case RZG2L_POEG_GPT_CFG_IRQ_CMD:
+		rzg2l_poeg_config_irq(chip);
+		break;
+	case RZG2L_POEG_GPT_FAULT_CLR_CMD:
+		rzg2l_gpt_pin_reenable(chip->gpt_dev, chip->index);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -118,11 +204,63 @@ static int rzg2l_poeg_chrdev_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations poeg_fops = {
 	.owner = THIS_MODULE,
+	.read = rzg2l_poeg_chrdev_read,
 	.write = rzg2l_poeg_chrdev_write,
+	.poll = rzg2l_poeg_chrdev_poll,
 	.open = rzg2l_poeg_chrdev_open,
 	.release = rzg2l_poeg_chrdev_release,
 };
 
+static bool rzg2l_poeg_get_linked_gpt_channels(struct platform_device *pdev,
+					       struct rzg2l_poeg_chip *chip,
+					       struct device_node *gpt_np,
+					       u8 poeg_id)
+{
+	struct of_phandle_args of_args;
+	bool ret = false;
+	unsigned int i;
+	u32 poeg_grp;
+	int cells;
+	int err;
+
+	cells = of_property_count_u32_elems(gpt_np, "renesas,poegs");
+	if (cells == -EINVAL)
+		return ret;
+
+	for (i = 0 ; i < RZG2L_GPT_MAX_HW_CHANNELS; i++)
+		chip->gpt_channels[i] = RZG2L_GPT_INVALID_CHANNEL;
+
+	cells >>= 1;
+	for (i = 0; i < cells; i++) {
+		err = of_parse_phandle_with_fixed_args(gpt_np,
+						       "renesas,poegs", 1, i,
+						       &of_args);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to parse 'renesas,poegs' property\n");
+			break;
+		}
+
+		if (of_args.args[0] >= RZG2L_GPT_MAX_HW_CHANNELS) {
+			dev_err(&pdev->dev, "Invalid channel %d >= %d\n",
+				of_args.args[0], RZG2L_GPT_MAX_HW_CHANNELS);
+			of_node_put(of_args.np);
+			break;
+		}
+
+		if (!of_property_read_u32(of_args.np, "renesas,poeg-id", &poeg_grp)) {
+			if (poeg_grp == poeg_id) {
+				chip->gpt_channels[of_args.args[0]] = poeg_id;
+				ret = true;
+			}
+		}
+
+		of_node_put(of_args.np);
+	}
+
+	return ret;
+}
+
 static const struct of_device_id rzg2l_poeg_of_table[] = {
 	{ .compatible = "renesas,rzg2l-poeg", },
 	{ /* Sentinel */ }
@@ -140,10 +278,11 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 {
 	struct platform_device *gpt_pdev = NULL;
 	struct rzg2l_poeg_chip *chip;
+	bool gpt_linked = false;
 	struct device_node *np;
 	struct device *cdev;
 	u32 cfg, val;
-	int ret;
+	int ret, irq;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -159,6 +298,8 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 	if (np)
 		gpt_pdev = of_find_device_by_node(np);
 
+	gpt_linked = rzg2l_poeg_get_linked_gpt_channels(pdev, chip, np,
+							chip->index);
 	of_node_put(np);
 	if (!gpt_pdev)
 		return -ENODEV;
@@ -172,6 +313,17 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->mmio))
 		return PTR_ERR(chip->mmio);
 
+	if (gpt_linked) {
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
@@ -194,13 +346,20 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		case POEG_USER_CTRL:
 			rzg2l_poeg_write(chip, POEGG_SSF);
 			break;
+		case POEG_GPT_BOTH_HIGH:
+			assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
+			break;
 		default:
 			ret = -EINVAL;
 			goto err_pm;
 		}
 
+		if (cfg & POEG_GPT_ALL)
+			rzg2l_poeg_write(chip, POEGG_IOCE);
+
 		chip->cfg = cfg;
 
+		init_waitqueue_head(&chip->events_wait);
 		cdev_init(&chip->poeg_cdev, &poeg_fops);
 		chip->poeg_cdev.owner = THIS_MODULE;
 		ret = cdev_add(&chip->poeg_cdev, MKDEV(MAJOR(g_poeg_dev), minor_n), 1);
@@ -218,6 +377,9 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 			goto free_cdev;
 		}
 		chip->minor_n = minor_n;
+		ret = kfifo_alloc(&chip->events, 64, GFP_KERNEL);
+		if (ret)
+			goto free_cdev;
 	}
 
 	minor_n++;
@@ -238,6 +400,7 @@ static int rzg2l_poeg_remove(struct platform_device *pdev)
 {
 	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
 
+	kfifo_free(&chip->events);
 	device_destroy(poeg_class, MKDEV(MAJOR(g_poeg_dev), chip->minor_n));
 	cdev_del(&chip->poeg_cdev);
 	pm_runtime_put(&pdev->dev);
diff --git a/include/linux/pinctrl/rzg2l-poeg.h b/include/linux/pinctrl/rzg2l-poeg.h
index 32e7d07fc00e..d21b70c219e6 100644
--- a/include/linux/pinctrl/rzg2l-poeg.h
+++ b/include/linux/pinctrl/rzg2l-poeg.h
@@ -4,8 +4,17 @@
 
 #include <linux/types.h>
 
+#define RZG2L_GPT_OABHF	1
+
 #define RZG2L_POEG_USR_CTRL_ENABLE_CMD	0
 #define RZG2L_POEG_USR_CTRL_DISABLE_CMD	1
+#define RZG2L_POEG_GPT_CFG_IRQ_CMD		2
+#define RZG2L_POEG_GPT_FAULT_CLR_CMD		3
+
+struct poeg_event {
+	__u32 gpt_disable_irq_status;
+	__u8 channel;
+};
 
 struct poeg_cmd {
 	__u32 val;
-- 
2.25.1

