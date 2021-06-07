Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02139DC35
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 14:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFGM0n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 08:26:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:65295 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhFGM0k (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 08:26:40 -0400
IronPort-SDR: AliqJcRWE7itQHSaQe/9fU7lBt7VEfn/Ceslk3rxpFBvzEuw41/t+epa+L7PqKBAamOwzo8+BC
 ZfrPCiJhaaQg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290236976"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="290236976"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:24:48 -0700
IronPort-SDR: QxMDOwLtopDRIWr/Vc+dYp7KzDLTMgoLFnPuOK/hdLSJDcbnSe8ZEOxMp7Xcc7w2PUvekS/4/a
 8GjKj0WEC5Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="634692060"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2021 05:24:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA27D361; Mon,  7 Jun 2021 15:25:05 +0300 (EEST)
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
Subject: [PATCH v3 6/6] pwm: core: Simplify some devm_*pwm*() functions
Date:   Mon,  7 Jun 2021 15:24:58 +0300
Message-Id: <20210607122458.40073-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v3: added Rb tag (Uwe)
v2: new patch

 drivers/pwm/core.c | 60 +++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4133abb74798..f74c2f7cd46c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1058,9 +1058,9 @@ void pwm_put(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_put);
 
-static void devm_pwm_release(struct device *dev, void *res)
+static void devm_pwm_release(void *pwm)
 {
-	pwm_put(*(struct pwm_device **)res);
+	pwm_put(pwm);
 }
 
 /**
@@ -1076,19 +1076,16 @@ static void devm_pwm_release(struct device *dev, void *res)
  */
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id)
 {
-	struct pwm_device **ptr, *pwm;
-
-	ptr = devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct pwm_device *pwm;
+	int ret;
 
 	pwm = pwm_get(dev, con_id);
-	if (!IS_ERR(pwm)) {
-		*ptr = pwm;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (IS_ERR(pwm))
+		return pwm;
+
+	ret = devm_add_action_or_reset(dev, devm_pwm_release, pwm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return pwm;
 }
@@ -1109,19 +1106,16 @@ EXPORT_SYMBOL_GPL(devm_pwm_get);
 struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 				   const char *con_id)
 {
-	struct pwm_device **ptr, *pwm;
-
-	ptr = devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct pwm_device *pwm;
+	int ret;
 
 	pwm = of_pwm_get(dev, np, con_id);
-	if (!IS_ERR(pwm)) {
-		*ptr = pwm;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (IS_ERR(pwm))
+		return pwm;
+
+	ret = devm_add_action_or_reset(dev, devm_pwm_release, pwm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return pwm;
 }
@@ -1143,23 +1137,19 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id)
 {
-	struct pwm_device **ptr, *pwm = ERR_PTR(-ENODEV);
-
-	ptr = devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct pwm_device *pwm = ERR_PTR(-ENODEV);
+	int ret;
 
 	if (is_of_node(fwnode))
 		pwm = of_pwm_get(dev, to_of_node(fwnode), con_id);
 	else if (is_acpi_node(fwnode))
 		pwm = acpi_pwm_get(fwnode);
+	if (IS_ERR(pwm))
+		return pwm;
 
-	if (!IS_ERR(pwm)) {
-		*ptr = pwm;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	ret = devm_add_action_or_reset(dev, devm_pwm_release, pwm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return pwm;
 }
-- 
2.30.2

