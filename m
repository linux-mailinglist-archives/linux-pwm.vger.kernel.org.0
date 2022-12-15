Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77C064E329
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Dec 2022 22:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLOVcd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Dec 2022 16:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLOVca (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Dec 2022 16:32:30 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502105C750;
        Thu, 15 Dec 2022 13:32:28 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; 
   d="scan'208";a="143493772"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2022 06:32:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.26])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 08EC240062B3;
        Fri, 16 Dec 2022 06:32:24 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v5 4/9] pinctrl: renesas: rzg2l-poeg: Add support for GPT Output-Disable Request
Date:   Thu, 15 Dec 2022 21:32:01 +0000
Message-Id: <20221215213206.56666-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
References: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
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
 .../ABI/testing/sysfs-platform-rzg2l-poeg     |  23 ++
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c     | 252 +++++++++++++++++-
 include/linux/soc/renesas/rzg2l-poeg.h        |  16 ++
 3 files changed, 288 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/soc/renesas/rzg2l-poeg.h

diff --git a/Documentation/ABI/testing/sysfs-platform-rzg2l-poeg b/Documentation/ABI/testing/sysfs-platform-rzg2l-poeg
index 157c98c49940..598fca265aad 100644
--- a/Documentation/ABI/testing/sysfs-platform-rzg2l-poeg
+++ b/Documentation/ABI/testing/sysfs-platform-rzg2l-poeg
@@ -16,3 +16,26 @@ Description:
 
 		- "1" - Output-disable request from software occurred.
 		- "0" - No output-disable request from software occurred.
+
+What:		/sys/devices/platform/<rzg2l-poeg's name>/gpt_req_both_high
+Date:		November 2022
+KernelVersion:	6.3
+Contact:	Biju Das <biju.das.jz@bp.renesas.com>
+Description:
+		This file can be read and write.
+		The file used to configure the output disable request from
+		gpt when same time output level high.
+
+		Write the following string to control the output disable:
+
+		- "1" - Enables output-disable request from gpt when same time
+		        output level high.
+		- "0" - Disables output-disable request from gpt when same time
+		        output level high.
+
+		Read the file, then it shows the following strings:
+
+		- "1" - Output-disable request from gpt when same time
+		        output level high is enabled.
+		- "0" - Output-disable request from gpt when same time
+		        output level high is disabled.
diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index 3788191bc2f1..2a66dc869fd3 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -4,19 +4,40 @@
  *
  * Copyright (C) 2022 Renesas Electronics Corporation
  */
-
+#include <linux/cdev.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/poll.h>
 #include <linux/reset.h>
+#include <linux/soc/renesas/rzg2l-gpt.h>
+#include <linux/soc/renesas/rzg2l-poeg.h>
+#include <linux/wait.h>
 
+#define POEGG_IOCE	BIT(5)
+#define POEGG_PIDE	BIT(4)
 #define POEGG_SSF	BIT(3)
+#define POEGG_IOCF	BIT(1)
+#define POEGG_PIDF	BIT(0)
+
+static struct class *poeg_class;
+static dev_t g_poeg_dev;
+static int minor_n;
 
 struct rzg2l_poeg_chip {
+	struct device *gpt_dev;
 	struct reset_control *rstc;
 	void __iomem *mmio;
+	u8 index;
+	DECLARE_BITMAP(gpt_irq, 3);
+	struct cdev poeg_cdev;
+	wait_queue_head_t events_wait;
+	DECLARE_KFIFO_PTR(events, struct poeg_event);
 };
 
 static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32 data)
@@ -66,10 +87,46 @@ static ssize_t output_disable_show(struct device *dev,
 	return sysfs_emit(buf, "%u\n", (reg & POEGG_SSF) ? 1 : 0);
 }
 
+static ssize_t gpt_req_both_high_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct rzg2l_poeg_chip *chip;
+	unsigned int val;
+	int ret;
+
+	chip = dev_get_drvdata(dev);
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val)
+		set_bit(RZG2L_GPT_OABHF, chip->gpt_irq);
+	else
+		clear_bit(RZG2L_GPT_OABHF, chip->gpt_irq);
+
+	rzg2l_gpt_poeg_disable_req_both_high(chip->gpt_dev, chip->index,
+					     test_bit(RZG2L_GPT_OABHF, chip->gpt_irq));
+
+	return count;
+}
+
+static ssize_t gpt_req_both_high_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct rzg2l_poeg_chip *chip;
+
+	chip = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", test_bit(RZG2L_GPT_OABHF, chip->gpt_irq));
+}
+
 static DEVICE_ATTR_RW(output_disable);
+static DEVICE_ATTR_RW(gpt_req_both_high);
 
 static struct attribute *poeg_attrs[] = {
 	&dev_attr_output_disable.attr,
+	&dev_attr_gpt_req_both_high.attr,
 	NULL,
 };
 
@@ -83,19 +140,161 @@ static const struct of_device_id rzg2l_poeg_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_poeg_of_table);
 
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
+static void rzg2l_poeg_cleanup(void *data)
+{
+	struct rzg2l_poeg_chip *chip = data;
+
+	put_device(chip->gpt_dev);
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
 static int rzg2l_poeg_probe(struct platform_device *pdev)
 {
+	struct platform_device *gpt_pdev = NULL;
 	struct rzg2l_poeg_chip *chip;
+	struct device_node *np;
+	u32 val;
+	int irq;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
+	np = of_parse_phandle(pdev->dev.of_node, "renesas,gpt", 0);
+	if (np)
+		gpt_pdev = of_find_device_by_node(np);
+
+	of_node_put(np);
+	if (!gpt_pdev)
+		return -ENODEV;
+
+	if (!of_property_read_u32(pdev->dev.of_node, "renesas,poeg-id", &val))
+		chip->index = val;
+
+	chip->gpt_dev = &gpt_pdev->dev;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rzg2l_poeg_cleanup, chip);
+	if (ret < 0)
+		return ret;
+
 	chip->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->mmio))
 		return PTR_ERR(chip->mmio);
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, rzg2l_poeg_irq, 0,
+			       dev_name(&pdev->dev), chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "cannot get irq\n");
+
 	chip->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(chip->rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(chip->rstc),
@@ -113,13 +312,26 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	rzg2l_poeg_write(chip, POEGG_IOCE | POEGG_PIDE);
+
 	ret = sysfs_create_group(&pdev->dev.kobj, &poeg_groups);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to create sysfs: %d\n", ret);
 		goto err_pm;
 	}
 
-	return 0;
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
 
 err_pm:
 	pm_runtime_put(&pdev->dev);
@@ -134,6 +346,10 @@ static int rzg2l_poeg_remove(struct platform_device *pdev)
 {
 	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
 
+	kfifo_free(&chip->events);
+	device_destroy(poeg_class,
+		       MKDEV(MAJOR(g_poeg_dev), MINOR(chip->poeg_cdev.dev)));
+	cdev_del(&chip->poeg_cdev);
 	sysfs_remove_group(&pdev->dev.kobj, &poeg_groups);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -150,7 +366,37 @@ static struct platform_driver rzg2l_poeg_driver = {
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
diff --git a/include/linux/soc/renesas/rzg2l-poeg.h b/include/linux/soc/renesas/rzg2l-poeg.h
new file mode 100644
index 000000000000..0b3d47d80af8
--- /dev/null
+++ b/include/linux/soc/renesas/rzg2l-poeg.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SOC_RENESAS_RZG2L_POEG_H__
+#define __LINUX_SOC_RENESAS_RZG2L_POEG_H__
+
+#include <linux/types.h>
+
+#define RZG2L_GPT_DTEF	0
+#define RZG2L_GPT_OABHF	1
+#define RZG2L_GPT_OABLF	2
+
+struct poeg_event {
+	__u32 gpt_disable_irq_status;
+	__u8 channel;
+};
+
+#endif /* __LINUX_SOC_RENESAS_RZG2L_POEG_H__ */
-- 
2.25.1

