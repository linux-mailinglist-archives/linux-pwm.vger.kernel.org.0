Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CEE39DC30
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFGM0i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 08:26:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:5348 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhFGM0g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 08:26:36 -0400
IronPort-SDR: Te+NDoBrmJ+PZ8oX7ByXX7MOjWmJOelAUr/0nHvvJEd4TphxkFeRhSFrO0igwWlDKADyUOeEvf
 Cg5y/zwoBYpA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="204632410"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="204632410"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:24:45 -0700
IronPort-SDR: UFOGLPxF5iZ7NZEeW5+x4A5cBVgKFeq828jFVXh1/oG9rsBry/voFp5zqnuBo4McPCDcRlyr8r
 xkZvCsSeexUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="418493326"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2021 05:24:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7D181CB; Mon,  7 Jun 2021 15:25:05 +0300 (EEST)
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
Subject: [PATCH v3 4/6] pwm: core: Unify fwnode checks in the module
Date:   Mon,  7 Jun 2021 15:24:56 +0300
Message-Id: <20210607122458.40073-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Historically we have two different approaches on how to check type of fwnode.
Unify them using the latest and greatest fwnode related APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no change
v2: corrected property name in kernel doc

 drivers/pwm/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c63626c5266c..05a86060d430 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -822,7 +822,7 @@ EXPORT_SYMBOL_GPL(of_pwm_get);
 
 /**
  * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
- * @fwnode: firmware node to get the "pwm" property from
+ * @fwnode: firmware node to get the "pwms" property from
  *
  * Returns the PWM device parsed from the fwnode and index specified in the
  * "pwms" property or a negative error-code on failure.
@@ -837,7 +837,7 @@ EXPORT_SYMBOL_GPL(of_pwm_get);
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
+static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
 {
 	struct pwm_device *pwm = ERR_PTR(-ENODEV);
 	struct fwnode_reference_args args;
@@ -921,6 +921,7 @@ void pwm_remove_table(struct pwm_lookup *table, size_t num)
  */
 struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 {
+	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct pwm_device *pwm;
 	struct pwm_chip *chip;
@@ -931,12 +932,12 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	int err;
 
 	/* look up via DT first */
-	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
-		return of_pwm_get(dev, dev->of_node, con_id);
+	if (is_of_node(fwnode))
+		return of_pwm_get(dev, to_of_node(fwnode), con_id);
 
 	/* then lookup via ACPI */
-	if (dev && is_acpi_node(dev->fwnode)) {
-		pwm = acpi_pwm_get(dev->fwnode);
+	if (is_acpi_node(fwnode)) {
+		pwm = acpi_pwm_get(fwnode);
 		if (!IS_ERR(pwm) || PTR_ERR(pwm) != -ENOENT)
 			return pwm;
 	}
-- 
2.30.2

