Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8161A8334
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440541AbgDNPiB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 11:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440529AbgDNPhx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 14 Apr 2020 11:37:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217052075E;
        Tue, 14 Apr 2020 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878671;
        bh=wsnp91rcwdxYBpYao46YELhWn6oIvD6jIFh28S6ADA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eaPNXm0eBthNtlwBsPDfapYe+Lln6DcD+Fs92BFAyuuJ6c8XZ+IMegeGcMfBWcPOf
         UaMKwqoNjvUXSXYI/GatTtDnNYZ+Q8guQSDr701azEr1WhvnRDeT9uDU0typ7VXcna
         P3BXeGoNg2eXfaGm6h9+Q0lnYCMLyknBkMBDsiTo=
Date:   Tue, 14 Apr 2020 16:37:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Marc Zyngier <maz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Applied "regmap-irq: make it possible to add irq_chip do a specific device node" to the regmap tree
In-Reply-To:  <20200402203656.27047-5-michael@walle.cc>
Message-Id:  <applied-20200402203656.27047-5-michael@walle.cc>
X-Patchwork-Hint: ignore
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The patch

   regmap-irq: make it possible to add irq_chip do a specific device node

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 12479382877dcf6623af4676caa8d3c647469a1b Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Thu, 2 Apr 2020 22:36:44 +0200
Subject: [PATCH] regmap-irq: make it possible to add irq_chip do a specific
 device node

Add a new function regmap_add_irq_chip_np() with its corresponding
devm_regmap_add_irq_chip_np() variant. Sometimes one want to register
the IRQ domain on a different device node that the one of the regmap
node. For example when using a MFD where there are different interrupt
controllers and particularly for the generic regmap gpio_chip/irq_chip
driver. In this case it is not desireable to have the IRQ domain on
the parent node.

Signed-off-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20200402203656.27047-5-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 84 ++++++++++++++++++++++++++------
 include/linux/regmap.h           | 10 ++++
 2 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 3d64c9331a82..4340e1d268b6 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -541,8 +541,9 @@ static const struct irq_domain_ops regmap_domain_ops = {
 };
 
 /**
- * regmap_add_irq_chip() - Use standard regmap IRQ controller handling
+ * regmap_add_irq_chip_np() - Use standard regmap IRQ controller handling
  *
+ * @np: The device_node where the IRQ domain should be added to.
  * @map: The regmap for the device.
  * @irq: The IRQ the device uses to signal interrupts.
  * @irq_flags: The IRQF_ flags to use for the primary interrupt.
@@ -556,9 +557,10 @@ static const struct irq_domain_ops regmap_domain_ops = {
  * register cache.  The chip driver is responsible for restoring the
  * register values used by the IRQ controller over suspend and resume.
  */
-int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
-			int irq_base, const struct regmap_irq_chip *chip,
-			struct regmap_irq_chip_data **data)
+int regmap_add_irq_chip_np(struct device_node *np, struct regmap *map, int irq,
+			   int irq_flags, int irq_base,
+			   const struct regmap_irq_chip *chip,
+			   struct regmap_irq_chip_data **data)
 {
 	struct regmap_irq_chip_data *d;
 	int i;
@@ -769,12 +771,10 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	}
 
 	if (irq_base)
-		d->domain = irq_domain_add_legacy(map->dev->of_node,
-						  chip->num_irqs, irq_base, 0,
-						  &regmap_domain_ops, d);
+		d->domain = irq_domain_add_legacy(np, chip->num_irqs, irq_base,
+						  0, &regmap_domain_ops, d);
 	else
-		d->domain = irq_domain_add_linear(map->dev->of_node,
-						  chip->num_irqs,
+		d->domain = irq_domain_add_linear(np, chip->num_irqs,
 						  &regmap_domain_ops, d);
 	if (!d->domain) {
 		dev_err(map->dev, "Failed to create IRQ domain\n");
@@ -808,6 +808,30 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	kfree(d);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(regmap_add_irq_chip_np);
+
+/**
+ * regmap_add_irq_chip() - Use standard regmap IRQ controller handling
+ *
+ * @map: The regmap for the device.
+ * @irq: The IRQ the device uses to signal interrupts.
+ * @irq_flags: The IRQF_ flags to use for the primary interrupt.
+ * @irq_base: Allocate at specific IRQ number if irq_base > 0.
+ * @chip: Configuration for the interrupt controller.
+ * @data: Runtime data structure for the controller, allocated on success.
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * This is the same as regmap_add_irq_chip_np, except that the device
+ * node of the regmap is used.
+ */
+int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
+			int irq_base, const struct regmap_irq_chip *chip,
+			struct regmap_irq_chip_data **data)
+{
+	return regmap_add_irq_chip_np(map->dev->of_node, map, irq, irq_flags,
+				      irq_base, chip, data);
+}
 EXPORT_SYMBOL_GPL(regmap_add_irq_chip);
 
 /**
@@ -875,9 +899,10 @@ static int devm_regmap_irq_chip_match(struct device *dev, void *res, void *data)
 }
 
 /**
- * devm_regmap_add_irq_chip() - Resource manager regmap_add_irq_chip()
+ * devm_regmap_add_irq_chip_np() - Resource manager regmap_add_irq_chip_np()
  *
  * @dev: The device pointer on which irq_chip belongs to.
+ * @np: The device_node where the IRQ domain should be added to.
  * @map: The regmap for the device.
  * @irq: The IRQ the device uses to signal interrupts
  * @irq_flags: The IRQF_ flags to use for the primary interrupt.
@@ -890,10 +915,11 @@ static int devm_regmap_irq_chip_match(struct device *dev, void *res, void *data)
  * The &regmap_irq_chip_data will be automatically released when the device is
  * unbound.
  */
-int devm_regmap_add_irq_chip(struct device *dev, struct regmap *map, int irq,
-			     int irq_flags, int irq_base,
-			     const struct regmap_irq_chip *chip,
-			     struct regmap_irq_chip_data **data)
+int devm_regmap_add_irq_chip_np(struct device *dev, struct device_node *np,
+				struct regmap *map, int irq, int irq_flags,
+				int irq_base,
+				const struct regmap_irq_chip *chip,
+				struct regmap_irq_chip_data **data)
 {
 	struct regmap_irq_chip_data **ptr, *d;
 	int ret;
@@ -903,8 +929,8 @@ int devm_regmap_add_irq_chip(struct device *dev, struct regmap *map, int irq,
 	if (!ptr)
 		return -ENOMEM;
 
-	ret = regmap_add_irq_chip(map, irq, irq_flags, irq_base,
-				  chip, &d);
+	ret = regmap_add_irq_chip_np(np, map, irq, irq_flags, irq_base,
+				     chip, &d);
 	if (ret < 0) {
 		devres_free(ptr);
 		return ret;
@@ -915,6 +941,32 @@ int devm_regmap_add_irq_chip(struct device *dev, struct regmap *map, int irq,
 	*data = d;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip_np);
+
+/**
+ * devm_regmap_add_irq_chip() - Resource manager regmap_add_irq_chip()
+ *
+ * @dev: The device pointer on which irq_chip belongs to.
+ * @map: The regmap for the device.
+ * @irq: The IRQ the device uses to signal interrupts
+ * @irq_flags: The IRQF_ flags to use for the primary interrupt.
+ * @irq_base: Allocate at specific IRQ number if irq_base > 0.
+ * @chip: Configuration for the interrupt controller.
+ * @data: Runtime data structure for the controller, allocated on success
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * The &regmap_irq_chip_data will be automatically released when the device is
+ * unbound.
+ */
+int devm_regmap_add_irq_chip(struct device *dev, struct regmap *map, int irq,
+			     int irq_flags, int irq_base,
+			     const struct regmap_irq_chip *chip,
+			     struct regmap_irq_chip_data **data)
+{
+	return devm_regmap_add_irq_chip_np(dev, map->dev->of_node, map, irq,
+					   irq_flags, irq_base, chip, data);
+}
 EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip);
 
 /**
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 40b07168fd8e..ae5034b2d7c3 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -21,6 +21,7 @@
 struct module;
 struct clk;
 struct device;
+struct device_node;
 struct i2c_client;
 struct i3c_device;
 struct irq_domain;
@@ -1310,12 +1311,21 @@ struct regmap_irq_chip_data;
 int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			int irq_base, const struct regmap_irq_chip *chip,
 			struct regmap_irq_chip_data **data);
+int regmap_add_irq_chip_np(struct device_node *np, struct regmap *map, int irq,
+			   int irq_flags, int irq_base,
+			   const struct regmap_irq_chip *chip,
+			   struct regmap_irq_chip_data **data);
 void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *data);
 
 int devm_regmap_add_irq_chip(struct device *dev, struct regmap *map, int irq,
 			     int irq_flags, int irq_base,
 			     const struct regmap_irq_chip *chip,
 			     struct regmap_irq_chip_data **data);
+int devm_regmap_add_irq_chip_np(struct device *dev, struct device_node *np,
+				struct regmap *map, int irq, int irq_flags,
+				int irq_base,
+				const struct regmap_irq_chip *chip,
+				struct regmap_irq_chip_data **data);
 void devm_regmap_del_irq_chip(struct device *dev, int irq,
 			      struct regmap_irq_chip_data *data);
 
-- 
2.20.1

