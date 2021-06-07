Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4A39DC3C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 14:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFGM0r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 08:26:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:5348 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFGM0o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 08:26:44 -0400
IronPort-SDR: 8AHKoG/vhYz6SByWEGNbcJ8sFr4Os+coKjkSAwmF53YavrYxpOXklf4P29WP7xwvU2Mqmm1CQv
 A/pGHwNGKUog==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="204632406"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="204632406"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:24:45 -0700
IronPort-SDR: nk7mFwZw0urwRzAXPFLsAc5obYE7cvQHM/9Bl13BYBDMsO1FFSioME0B7u6bdA9hGln/5bK748
 db0sFLgWySQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="418493327"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2021 05:24:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E0B991EA; Mon,  7 Jun 2021 15:25:05 +0300 (EEST)
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
Subject: [PATCH v3 5/6] pwm: core: Remove unused devm_pwm_put()
Date:   Mon,  7 Jun 2021 15:24:57 +0300
Message-Id: <20210607122458.40073-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no users and seems no will come of the devm_pwm_put().
Remove the function.

While at it, slightly update documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v3: added Rb tag (Uwe)
v2: new patch

 .../driver-api/driver-model/devres.rst        |  3 ++-
 Documentation/driver-api/pwm.rst              |  3 ++-
 drivers/pwm/core.c                            | 25 -------------------
 include/linux/pwm.h                           |  5 ----
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e7e209232246..d2948139411e 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -409,7 +409,8 @@ POWER
 
 PWM
   devm_pwm_get()
-  devm_pwm_put()
+  devm_of_pwm_get()
+  devm_fwnode_pwm_get()
 
 REGULATOR
   devm_regulator_bulk_get()
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 750734a7f874..ccb06e485756 100644
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
index 05a86060d430..4133abb74798 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1165,31 +1165,6 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
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
index 5a73251d28e3..91af518d5037 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -423,7 +423,6 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
-void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
 #else
 static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
 {
@@ -530,10 +529,6 @@ devm_fwnode_pwm_get(struct device *dev, struct fwnode_handle *fwnode,
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

