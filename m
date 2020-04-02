Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF96719CB51
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbgDBUhS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 16:37:18 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38613 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389004AbgDBUhP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 16:37:15 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 342CC2327F;
        Thu,  2 Apr 2020 22:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585859831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4xIKefrMl1An1xXqkufnjbYFHb0nt7JLp19eTtgVZE=;
        b=ePtUa0XrNMVg9FL/1zsW2Ut0BpPG91fXQdm64hIltKMUY31s1VL4HlSRAv+LbhYGuxznz3
        DFQjJ+v/EwD7iKp0yxeC3QVK4bMpKTicXAZlFJ+cS0eJXjV6XRRG4lXFNDb1Dj9tRrcZmn
        SafrxST4Z/HTBr2nPSOTC9fygHKKcrQ=
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
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 04/16] regmap-irq: make it possible to add irq_chip do a specific device node
Date:   Thu,  2 Apr 2020 22:36:44 +0200
Message-Id: <20200402203656.27047-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402203656.27047-1-michael@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 342CC2327F
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.157];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a new function regmap_add_irq_chip_np() with its corresponding
devm_regmap_add_irq_chip_np() variant. Sometimes one want to register
the IRQ domain on a different device node that the one of the regmap
node. For example when using a MFD where there are different interrupt
controllers and particularly for the generic regmap gpio_chip/irq_chip
driver. In this case it is not desireable to have the IRQ domain on
the parent node.

Signed-off-by: Michael Walle <michael@walle.cc>
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

