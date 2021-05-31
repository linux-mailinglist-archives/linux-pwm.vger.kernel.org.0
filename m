Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F31396469
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhEaP55 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 11:57:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:56056 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhEaPzy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 11:55:54 -0400
IronPort-SDR: s0FTc/YbxE7QzVi/bTxlK4RSQRdK+yP/N2Rypjl0kq1qvt9HOusIUm8pnoC/BZ6uMwS0CU7AZ/
 9qVrB8dBsdOw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="201505433"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="201505433"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 08:43:45 -0700
IronPort-SDR: TXtl/zScOFPmQNPQ8sezJRx5zr1/C0bV8LKZJwh8ibbvi946550nEEK5gsUhzGa/2NbP2pls4Y
 7wQnRp/8iy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="635194189"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2021 08:43:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3AFA73B6; Mon, 31 May 2021 18:44:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 4/5] pwm: core: Reuse fwnode_to_pwmchip() in ACPI case
Date:   Mon, 31 May 2021 18:43:50 +0300
Message-Id: <20210531154351.53614-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
References: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pwm/core.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 338d8ee369db..2223a9b6644b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -819,28 +819,6 @@ struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
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
@@ -863,9 +841,7 @@ static struct pwm_chip *device_to_pwmchip(struct device *dev)
 static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 {
 	struct pwm_device *pwm = ERR_PTR(-ENODEV);
-#if IS_ENABLED(CONFIG_ACPI)
 	struct fwnode_reference_args args;
-	struct acpi_device *acpi;
 	struct pwm_chip *chip;
 	int ret;
 
@@ -875,14 +851,10 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	acpi = to_acpi_device_node(args.fwnode);
-	if (!acpi)
-		return ERR_PTR(-EINVAL);
-
 	if (args.nargs < 3)
 		return ERR_PTR(-EPROTO);
 
-	chip = device_to_pwmchip(&acpi->dev);
+	chip = fwnode_to_pwmchip(args.fwnode);
 	if (IS_ERR(chip))
 		return ERR_CAST(chip);
 
@@ -895,7 +867,6 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
 
 	if (args.args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
-#endif
 
 	return pwm;
 }
-- 
2.30.2

