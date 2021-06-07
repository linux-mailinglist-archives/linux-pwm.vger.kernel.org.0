Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6839DC2C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFGM0i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 08:26:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:57549 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhFGM0h (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 08:26:37 -0400
IronPort-SDR: /oOR1/zpf2RvcPSG/9xqoUpxZjh8KwD9vovr5SAHKOJUUr/cH6wYMxmk/vpJA3i5OPwOC3jkOk
 Y8y97Kg5BiAQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="268466120"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="268466120"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:24:45 -0700
IronPort-SDR: /BnpQELrFgD7EelUh8e5waCyyXSA0pk/7S4Zet0m+z2MOlWiHiD3pbrpAQ0nvYQXJLiJvAp3hI
 pUssNbgtKwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="476187979"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2021 05:24:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF93218E; Mon,  7 Jun 2021 15:25:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v3 3/6] pwm: core: Reuse fwnode_to_pwmchip() in ACPI case
Date:   Mon,  7 Jun 2021 15:24:55 +0300
Message-Id: <20210607122458.40073-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In ACPI case we may use matching by fwnode as provided via
fwnode_to_pwmchip(). This makes device_to_pwmchip() not needed
anymore.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: rebased on the tree without dropped patch 2/7
v2: no change
 drivers/pwm/core.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f26da1a6a376..c63626c5266c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -820,28 +820,6 @@ struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_pwm_get);
 
-#if IS_ENABLED(CONFIG_ACPI)
-static struct pwm_chip *device_to_pwmchip(struct device *dev)
-{
-	struct pwm_chip *chip;
-
-	mutex_lock(&pwm_lock);
-
-	list_for_each_entry(chip, &pwm_chips, list) {
-		struct acpi_device *adev = ACPI_COMPANION(chip->dev);
-
-		if ((chip->dev == dev) || (adev && &adev->dev == dev)) {
-			mutex_unlock(&pwm_lock);
-			return chip;
-		}
-	}
-
-	mutex_unlock(&pwm_lock);
-
-	return ERR_PTR(-EPROBE_DEFER);
-}
-#endif
-
 /**
  * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
  * @fwnode: firmware node to get the "pwm" property from
@@ -862,9 +840,7 @@ static struct pwm_chip *device_to_pwmchip(struct device *dev)
 static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 {
 	struct pwm_device *pwm = ERR_PTR(-ENODEV);
-#if IS_ENABLED(CONFIG_ACPI)
 	struct fwnode_reference_args args;
-	struct acpi_device *acpi;
 	struct pwm_chip *chip;
 	int ret;
 
@@ -874,14 +850,10 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	acpi = to_acpi_device_node(args.fwnode);
-	if (!acpi)
-		return ERR_PTR(-EINVAL);
-
 	if (args.nargs < 2)
 		return ERR_PTR(-EPROTO);
 
-	chip = device_to_pwmchip(&acpi->dev);
+	chip = fwnode_to_pwmchip(args.fwnode);
 	if (IS_ERR(chip))
 		return ERR_CAST(chip);
 
@@ -894,7 +866,6 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 
 	if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
-#endif
 
 	return pwm;
 }
-- 
2.30.2

