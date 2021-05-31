Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4C396875
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhEaTvU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 15:51:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:46675 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhEaTvS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 15:51:18 -0400
IronPort-SDR: YdJHNsOPYgYCxG+x3O49BQJqYrYjTz9f5tNH3DVqNNoyH/Il+JIgqkTDidTFOvgFmJdOu31I0F
 mnk+2OS55Z2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="203448751"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="203448751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 12:49:32 -0700
IronPort-SDR: vdQPZP1UmIhzvYrCbZnYJclHUXuLl7dqvk1nSpXfzACXPBGcwid9C/R6uKevuYsMSngTKYeFsi
 uDBNkUv+c6vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="616612686"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2021 12:49:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3324F53E; Mon, 31 May 2021 22:49:51 +0300 (EEST)
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
Subject: [PATCH v2 5/7] pwm: core: Unify fwnode checks in the module
Date:   Mon, 31 May 2021 22:49:45 +0300
Message-Id: <20210531194947.10770-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Historically we have two different approaches on how to check type of fwnode.
Unify them using the latest and greatest fwnode related APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: corrected property name in kernel doc
 drivers/pwm/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2223a9b6644b..a27d7c2aa6fe 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -821,7 +821,7 @@ EXPORT_SYMBOL_GPL(of_pwm_get);
 
 /**
  * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
- * @fwnode: firmware node to get the "pwm" property from
+ * @fwnode: firmware node to get the "pwms" property from
  *
  * Returns the PWM device parsed from the fwnode and index specified in the
  * "pwms" property or a negative error-code on failure.
@@ -838,7 +838,7 @@ EXPORT_SYMBOL_GPL(of_pwm_get);
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
+static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
 {
 	struct pwm_device *pwm = ERR_PTR(-ENODEV);
 	struct fwnode_reference_args args;
@@ -922,6 +922,7 @@ void pwm_remove_table(struct pwm_lookup *table, size_t num)
  */
 struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 {
+	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct pwm_device *pwm;
 	struct pwm_chip *chip;
@@ -932,12 +933,12 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
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

