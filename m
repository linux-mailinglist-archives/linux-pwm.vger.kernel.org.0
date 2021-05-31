Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5C396879
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhEaTvV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 15:51:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:39812 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhEaTvS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 15:51:18 -0400
IronPort-SDR: RnpqX1aVFeCWtdTjJ3GqBU/PSjhIsi0I+BNJ8KSBkPKEGOvR+KlaJUku+8XtrhqDvIhLWi44q+
 SMYoMIkOmtKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190528034"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="190528034"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 12:49:35 -0700
IronPort-SDR: BpUMOXnWRLq/Luqgqw2ZyRnaXxetWYCJQYTFx2dtERc8lNCuiYjt/jcxdTKib+Sa90FgpfpBWx
 6x6vmzhmEafA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="548829862"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2021 12:49:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 46DAC6BC; Mon, 31 May 2021 22:49:51 +0300 (EEST)
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
Subject: [PATCH v2 6/7] pwm: core: Remove unused devm_pwm_put()
Date:   Mon, 31 May 2021 22:49:46 +0300
Message-Id: <20210531194947.10770-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no users and seems no will come of the devm_pwm_put().
Remove the function.

While at it, slightly update documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 .../driver-api/driver-model/devres.rst        |  3 ++-
 Documentation/driver-api/pwm.rst              |  3 ++-
 drivers/pwm/core.c                            | 25 -------------------
 include/linux/pwm.h                           |  5 ----
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index b2645870ef7e..cc1e0138ba9f 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -410,7 +410,8 @@ POWER
 
 PWM
   devm_pwm_get()
-  devm_pwm_put()
+  devm_of_pwm_get()
+  devm_fwnode_pwm_get()
 
 REGULATOR
   devm_regulator_bulk_get()
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index a7ca4f58305a..251e3f7be230 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -40,7 +40,8 @@ after usage with pwm_free().
 
 New users should use the pwm_get() function and pass to it the consumer
 device or a consumer name. pwm_put() is used to free the PWM device. Managed
-variants of these functions, devm_pwm_get() and devm_pwm_put(), also exist.
+variants of the getter, devm_pwm_get(), devm_of_pwm_get(),
+devm_fwnode_pwm_get(), also exist.
 
 After being requested, a PWM has to be configured using::
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a27d7c2aa6fe..6d4410bd9793 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1166,31 +1166,6 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
 
-static int devm_pwm_match(struct device *dev, void *res, void *data)
-{
-	struct pwm_device **p = res;
-
-	if (WARN_ON(!p || !*p))
-		return 0;
-
-	return *p == data;
-}
-
-/**
- * devm_pwm_put() - resource managed pwm_put()
- * @dev: device for PWM consumer
- * @pwm: PWM device
- *
- * Release a PWM previously allocated using devm_pwm_get(). Calling this
- * function is usually not needed because devm-allocated resources are
- * automatically released on driver detach.
- */
-void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
-{
-	WARN_ON(devres_release(dev, devm_pwm_release, devm_pwm_match, pwm));
-}
-EXPORT_SYMBOL_GPL(devm_pwm_put);
-
 #ifdef CONFIG_DEBUG_FS
 static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 5bb90af4997e..1eaded57c666 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -417,7 +417,6 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
-void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
 {
@@ -524,10 +523,6 @@ devm_fwnode_pwm_get(struct device *dev, struct fwnode_handle *fwnode,
 {
 	return ERR_PTR(-ENODEV);
 }
-
-static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
-{
-}
 #endif
 
 static inline void pwm_apply_args(struct pwm_device *pwm)
-- 
2.30.2

