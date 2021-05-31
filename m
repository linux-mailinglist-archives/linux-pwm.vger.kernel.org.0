Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8792B396871
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhEaTvT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 15:51:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:6903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhEaTvS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 15:51:18 -0400
IronPort-SDR: llgHi44og4euXMoGje9G5HJUcfP+D62CPMMSq4BlmGXi6VDK1vpG6F596kwawZQgw9ZUvlEpxj
 McsPxp5Nvjjg==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="289027850"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="289027850"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 12:49:35 -0700
IronPort-SDR: V7ODrX3xLgQyAgWRdFqSl+psciNKF2/BbgM4EGLlNy0C6Qg7uBmF0wcNEQA7/7utGJmctNSwBw
 kRlVu71KxxqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="399062437"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2021 12:49:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E0655B6; Mon, 31 May 2021 22:49:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 7/7] pwm: core: Simplify some devm_*pwm*() functions
Date:   Mon, 31 May 2021 22:49:47 +0300
Message-Id: <20210531194947.10770-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/pwm/core.c | 60 +++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6d4410bd9793..9f643414676b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1059,9 +1059,9 @@ void pwm_put(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_put);
 
-static void devm_pwm_release(struct device *dev, void *res)
+static void devm_pwm_release(void *pwm)
 {
-	pwm_put(*(struct pwm_device **)res);
+	pwm_put(pwm);
 }
 
 /**
@@ -1077,19 +1077,16 @@ static void devm_pwm_release(struct device *dev, void *res)
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
@@ -1110,19 +1107,16 @@ EXPORT_SYMBOL_GPL(devm_pwm_get);
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
@@ -1144,23 +1138,19 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
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

