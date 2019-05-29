Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103402DCA5
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2019 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfE2MZf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 May 2019 08:25:35 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:53048 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfE2MZf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 08:25:35 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 141D84CD2D;
        Wed, 29 May 2019 14:18:41 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 2/3] PWM framework: add support referencing PWMs from ACPI
Date:   Wed, 29 May 2019 14:18:21 +0200
Message-Id: <254cc03d5467ba7db0f5677646266768e5b24127.1559127603.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In analogy to referencing a GPIO using the "gpios" property from ACPI,
support referencing a PWM using the "pwms" property.

ACPI entries must look like
 Package () {"pwms", Package ()
     { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}

In contrast to the DT implementation, only _one_ PWM entry in the "pwms"
property is supported. As a consequence "pwm-names"-property and
con_id lookup aren't supported.

Support for ACPI is added via the firmware-node framework which is an
abstraction layer on top of ACPI/DT. To keep this patch clean, DT and
ACPI paths are kept separate. The firmware-node framework could be used
to unify both paths in a future patch.

To support leds-pwm driver, an additional method devm_fwnode_pwm_get()
which supports both ACPI and DT configuration is exported.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/pwm/core.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h |   9 ++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 275b5f399a1a..1d788c05193e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2011-2012 Avionic Design GmbH
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/pwm.h>
 #include <linux/radix-tree.h>
@@ -700,6 +701,75 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 }
 EXPORT_SYMBOL_GPL(of_pwm_get);
 
+static struct pwm_chip *device_to_pwmchip(struct device *dev)
+{
+	struct pwm_chip *chip;
+
+	mutex_lock(&pwm_lock);
+
+	list_for_each_entry(chip, &pwm_chips, list) {
+		struct acpi_device *adev = ACPI_COMPANION(chip->dev);
+
+		if ((chip->dev == dev) || (adev && &adev->dev == dev)) {
+			mutex_unlock(&pwm_lock);
+			return chip;
+		}
+	}
+
+	mutex_unlock(&pwm_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
+ * @fwnode: firmware node to get the "pwm" property from
+ *
+ * Returns the PWM device parsed from the fwnode and index specified in the
+ * "pwms" property or a negative error-code on failure.
+ * Values parsed from the device tree are stored in the returned PWM device
+ * object.
+ *
+ * This is analogous to of_pwm_get() except con_id is not yet supported.
+ * ACPI entries must look like
+ * Package () {"pwms", Package ()
+ *     { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}
+ *
+ * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
+ * error code on failure.
+ */
+struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
+{
+	struct fwnode_reference_args args;
+	struct pwm_chip *chip;
+	struct pwm_device *pwm = ERR_PTR(-ENODEV);
+	int ret;
+
+	memset(&args, 0, sizeof(args));
+	ret = __acpi_node_get_property_reference(fwnode, "pwms", 0, 3, &args);
+
+	if (!to_acpi_device_node(args.fwnode))
+		return ERR_PTR(-EINVAL);
+	if (args.nargs < 2)
+		return ERR_PTR(-EPROTO);
+
+	chip = device_to_pwmchip(&to_acpi_device_node(args.fwnode)->dev);
+	if (IS_ERR(chip))
+		return ERR_CAST(chip);
+
+	pwm = pwm_request_from_chip(chip, args.args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args.args[1];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+
+	if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
+		pwm->args.polarity = PWM_POLARITY_INVERSED;
+
+	return pwm;
+}
+
 /**
  * pwm_add_table() - register PWM device consumers
  * @table: array of consumers to register
@@ -763,6 +833,10 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
 		return of_pwm_get(dev->of_node, con_id);
 
+	/* then lookup via ACPI */
+	if (dev && is_acpi_node(dev->fwnode))
+		return acpi_pwm_get(dev->fwnode);
+
 	/*
 	 * We look up the provider in the static table typically provided by
 	 * board setup code. We first try to lookup the consumer device by
@@ -942,6 +1016,44 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(devm_of_pwm_get);
 
+/**
+ * devm_fwnode_pwm_get() - request a resource managed PWM from firmware node
+ * @dev: device for PWM consumer
+ * @fwnode: firmware node to get the PWM from
+ * @con_id: consumer name
+ *
+ * Returns the PWM device parsed from the firmware node. See of_pwm_get() and
+ * acpi_pwm_get() for a detailed description.
+ *
+ * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
+ * error code on failure.
+ */
+struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       const char *con_id)
+{
+	struct pwm_device **ptr, *pwm = ERR_PTR(-ENODEV);
+
+	ptr = devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	if (is_of_node(fwnode))
+		pwm = of_pwm_get(to_of_node(fwnode), con_id);
+	else if (is_acpi_node(fwnode))
+		pwm = acpi_pwm_get(fwnode);
+
+	if (!IS_ERR(pwm)) {
+		*ptr = pwm;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return pwm;
+}
+EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
+
 static int devm_pwm_match(struct device *dev, void *res, void *data)
 {
 	struct pwm_device **p = res;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index eaa5c6e3fc9f..1a635916cdfb 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -411,6 +411,9 @@ void pwm_put(struct pwm_device *pwm);
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 				   const char *con_id);
+struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
+				       struct fwnode_handle *fwnode,
+				       const char *con_id);
 void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
@@ -516,6 +519,12 @@ static inline struct pwm_device *devm_of_pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct pwm_device *devm_fwnode_pwm_get(
+	struct device *dev, struct fwnode_handle *fwnode, const char *con_id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
 {
 }
-- 
2.17.1

