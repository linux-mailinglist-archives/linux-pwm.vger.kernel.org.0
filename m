Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C7215D85
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2020 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgGFR5e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jul 2020 13:57:34 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55605 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbgGFR5d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 13:57:33 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 419CC22FA7;
        Mon,  6 Jul 2020 19:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594058248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7LW/eI8YbctTo76n912stHGHfBPgnLPBHt7/yzZRBc=;
        b=h02ibAcmWeKbv/xUuxYAnZjzQGWkg4kBokAFcMp+/4geySFAFQumnXa+MO6BZEQmDQ55QC
        o9CnYyqwhVchdssszVQokRbiBwItJ9704qccLCLVzhrEyWi5uGaaZrv8MG6FupnhY3XD9f
        8514gR6YRNP+4sVcz8iPsev3ahACcRw=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 01/13] regmap-irq: use fwnode instead of device node in add_irq_chip()
Date:   Mon,  6 Jul 2020 19:53:41 +0200
Message-Id: <20200706175353.16404-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706175353.16404-1-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the argument to the newer fwnode_handle instead a device tree
node. Fortunately, there are no users for now. So this is an easy
change.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Mark, after this patch is reviewed, could already pick it, so it is
less likely, others will use the old regmap_add_irq_chip_np() variant?

Changes since v4:
 - new patch, suggested by Andy

 drivers/base/regmap/regmap-irq.c | 53 +++++++++++++++++---------------
 include/linux/regmap.h           | 21 +++++++------
 2 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 4340e1d268b6..369a57e6f89d 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -541,9 +541,9 @@ static const struct irq_domain_ops regmap_domain_ops = {
 };
 
 /**
- * regmap_add_irq_chip_np() - Use standard regmap IRQ controller handling
+ * regmap_add_irq_chip_fwnode() - Use standard regmap IRQ controller handling
  *
- * @np: The device_node where the IRQ domain should be added to.
+ * @fwnode: The firmware node where the IRQ domain should be added to.
  * @map: The regmap for the device.
  * @irq: The IRQ the device uses to signal interrupts.
  * @irq_flags: The IRQF_ flags to use for the primary interrupt.
@@ -557,10 +557,11 @@ static const struct irq_domain_ops regmap_domain_ops = {
  * register cache.  The chip driver is responsible for restoring the
  * register values used by the IRQ controller over suspend and resume.
  */
-int regmap_add_irq_chip_np(struct device_node *np, struct regmap *map, int irq,
-			   int irq_flags, int irq_base,
-			   const struct regmap_irq_chip *chip,
-			   struct regmap_irq_chip_data **data)
+int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
+			       struct regmap *map, int irq,
+			       int irq_flags, int irq_base,
+			       const struct regmap_irq_chip *chip,
+			       struct regmap_irq_chip_data **data)
 {
 	struct regmap_irq_chip_data *d;
 	int i;
@@ -771,10 +772,12 @@ int regmap_add_irq_chip_np(struct device_node *np, struct regmap *map, int irq,
 	}
 
 	if (irq_base)
-		d->domain = irq_domain_add_legacy(np, chip->num_irqs, irq_base,
+		d->domain = irq_domain_add_legacy(to_of_node(fwnode),
+						  chip->num_irqs, irq_base,
 						  0, &regmap_domain_ops, d);
 	else
-		d->domain = irq_domain_add_linear(np, chip->num_irqs,
+		d->domain = irq_domain_add_linear(to_of_node(fwnode),
+						  chip->num_irqs,
 						  &regmap_domain_ops, d);
 	if (!d->domain) {
 		dev_err(map->dev, "Failed to create IRQ domain\n");
@@ -808,7 +811,7 @@ int regmap_add_irq_chip_np(struct device_node *np, struct regmap *map, int irq,
 	kfree(d);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regmap_add_irq_chip_np);
+EXPORT_SYMBOL_GPL(regmap_add_irq_chip_fwnode);
 
 /**
  * regmap_add_irq_chip() - Use standard regmap IRQ controller handling
@@ -822,15 +825,15 @@ EXPORT_SYMBOL_GPL(regmap_add_irq_chip_np);
  *
  * Returns 0 on success or an errno on failure.
  *
- * This is the same as regmap_add_irq_chip_np, except that the device
+ * This is the same as regmap_add_irq_chip_fwnode, except that the firmware
  * node of the regmap is used.
  */
 int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			int irq_base, const struct regmap_irq_chip *chip,
 			struct regmap_irq_chip_data **data)
 {
-	return regmap_add_irq_chip_np(map->dev->of_node, map, irq, irq_flags,
-				      irq_base, chip, data);
+	return regmap_add_irq_chip_fwnode(dev_fwnode(map->dev), map, irq,
+					  irq_flags, irq_base, chip, data);
 }
 EXPORT_SYMBOL_GPL(regmap_add_irq_chip);
 
@@ -899,10 +902,10 @@ static int devm_regmap_irq_chip_match(struct device *dev, void *res, void *data)
 }
 
 /**
- * devm_regmap_add_irq_chip_np() - Resource manager regmap_add_irq_chip_np()
+ * devm_regmap_add_irq_chip_fwnode() - Resource managed regmap_add_irq_chip_fwnode()
  *
  * @dev: The device pointer on which irq_chip belongs to.
- * @np: The device_node where the IRQ domain should be added to.
+ * @fwnode: The firmware node where the IRQ domain should be added to.
  * @map: The regmap for the device.
  * @irq: The IRQ the device uses to signal interrupts
  * @irq_flags: The IRQF_ flags to use for the primary interrupt.
@@ -915,11 +918,12 @@ static int devm_regmap_irq_chip_match(struct device *dev, void *res, void *data)
  * The &regmap_irq_chip_data will be automatically released when the device is
  * unbound.
  */
-int devm_regmap_add_irq_chip_np(struct device *dev, struct device_node *np,
-				struct regmap *map, int irq, int irq_flags,
-				int irq_base,
-				const struct regmap_irq_chip *chip,
-				struct regmap_irq_chip_data **data)
+int devm_regmap_add_irq_chip_fwnode(struct device *dev,
+				    struct fwnode_handle *fwnode,
+				    struct regmap *map, int irq,
+				    int irq_flags, int irq_base,
+				    const struct regmap_irq_chip *chip,
+				    struct regmap_irq_chip_data **data)
 {
 	struct regmap_irq_chip_data **ptr, *d;
 	int ret;
@@ -929,8 +933,8 @@ int devm_regmap_add_irq_chip_np(struct device *dev, struct device_node *np,
 	if (!ptr)
 		return -ENOMEM;
 
-	ret = regmap_add_irq_chip_np(np, map, irq, irq_flags, irq_base,
-				     chip, &d);
+	ret = regmap_add_irq_chip_fwnode(fwnode, map, irq, irq_flags, irq_base,
+					 chip, &d);
 	if (ret < 0) {
 		devres_free(ptr);
 		return ret;
@@ -941,7 +945,7 @@ int devm_regmap_add_irq_chip_np(struct device *dev, struct device_node *np,
 	*data = d;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip_np);
+EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip_fwnode);
 
 /**
  * devm_regmap_add_irq_chip() - Resource manager regmap_add_irq_chip()
@@ -964,8 +968,9 @@ int devm_regmap_add_irq_chip(struct device *dev, struct regmap *map, int irq,
 			     const struct regmap_irq_chip *chip,
 			     struct regmap_irq_chip_data **data)
 {
-	return devm_regmap_add_irq_chip_np(dev, map->dev->of_node, map, irq,
-					   irq_flags, irq_base, chip, data);
+	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(map->dev), map,
+					       irq, irq_flags, irq_base, chip,
+					       data);
 }
 EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip);
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f4917efed5c3..e3817c097791 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -18,6 +18,7 @@
 #include <linux/bug.h>
 #include <linux/lockdep.h>
 #include <linux/iopoll.h>
+#include <linux/fwnode.h>
 
 struct module;
 struct clk;
@@ -1376,21 +1377,23 @@ struct regmap_irq_chip_data;
 int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			int irq_base, const struct regmap_irq_chip *chip,
 			struct regmap_irq_chip_data **data);
-int regmap_add_irq_chip_np(struct device_node *np, struct regmap *map, int irq,
-			   int irq_flags, int irq_base,
-			   const struct regmap_irq_chip *chip,
-			   struct regmap_irq_chip_data **data);
+int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
+			       struct regmap *map, int irq,
+			       int irq_flags, int irq_base,
+			       const struct regmap_irq_chip *chip,
+			       struct regmap_irq_chip_data **data);
 void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *data);
 
 int devm_regmap_add_irq_chip(struct device *dev, struct regmap *map, int irq,
 			     int irq_flags, int irq_base,
 			     const struct regmap_irq_chip *chip,
 			     struct regmap_irq_chip_data **data);
-int devm_regmap_add_irq_chip_np(struct device *dev, struct device_node *np,
-				struct regmap *map, int irq, int irq_flags,
-				int irq_base,
-				const struct regmap_irq_chip *chip,
-				struct regmap_irq_chip_data **data);
+int devm_regmap_add_irq_chip_fwnode(struct device *dev,
+				    struct fwnode_handle *fwnode,
+				    struct regmap *map, int irq,
+				    int irq_flags, int irq_base,
+				    const struct regmap_irq_chip *chip,
+				    struct regmap_irq_chip_data **data);
 void devm_regmap_del_irq_chip(struct device *dev, int irq,
 			      struct regmap_irq_chip_data *data);
 
-- 
2.20.1

