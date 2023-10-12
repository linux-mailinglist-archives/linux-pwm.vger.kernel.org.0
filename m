Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61797C72C4
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379642AbjJLQbP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379612AbjJLQbC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DCA9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-0004zq-08; Thu, 12 Oct 2023 18:30:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-001C7h-D8; Thu, 12 Oct 2023 18:30:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-00F5Od-3t; Thu, 12 Oct 2023 18:30:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 038/109] pwm: Provide devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:06 +0200
Message-ID: <20231012162827.1002444-149-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5470; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DTWoJWdN5T5VpEEuVMwi1r4sJRsWULSA244ls+YR5c0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7ZF6xjE2bHcVcK0vKxYJMT1uU7cOY+r9jvY GHF8W48MseJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge2QAKCRCPgPtYfRL+ TnTVB/41U83dS9DACJdoDqqLsz/+xF+DasnfAUiTyIBCwRWNDDsIKHjLWSQmRNiFLegXke1KggW qTTogOLeHm7KcNoB6OeJT0R71JXOgnjumSuK60/71SjQRy44AV0I65Og9SUux3L8O4/1qRUdXH9 bhO9mFSgBEyN4bCLuh5p5DVDYlKU35X1YtsOp96X+A4mlbjdSTNM8wdcBbRfZNiRp6L78Ghzv2J W/50jltLHSqLu4gGGwDab0DBoQKhfoWX0vImwdDtSFo+5I5oy/EgFyPwCGQdGrGpkJ5tSQbr4rn oEN1A93j+7ojjRlgHEyg9y3Dfc/7oT6MXeSUoKijA2bUn9ow
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This function allocates a struct pwm_chip and driver data. Compared to
the status quo the split into pwm_chip and driver data is new, otherwise
it doesn't change anything relevant (yet).

The intention is that after all drivers are switched to use this
allocation function, its possible to add a struct device to struct
pwm_chip to properly track the latter's lifetime without touching all
drivers again. Proper lifetime tracking is a necessary precondition to
introduce character device support for PWMs (that implements atomic
setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
userspace support).

The new function pwmchip_priv() (obviously?) only works for chips
allocated with devm_pwmchip_alloc().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 Documentation/driver-api/pwm.rst              | 10 +++---
 drivers/pwm/core.c                            | 32 ++++++++++++++++---
 include/linux/pwm.h                           |  5 +++
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 8be086b3f829..73a9ee074737 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -414,6 +414,7 @@ POWER
   devm_reboot_mode_unregister()
 
 PWM
+  devm_pwmchip_alloc()
   devm_pwmchip_add()
   devm_pwm_get()
   devm_fwnode_pwm_get()
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index bb264490a87a..994ea5368805 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -134,11 +134,11 @@ to implement the pwm_*() functions itself. This means that it's impossible
 to have multiple PWM drivers in the system. For this reason it's mandatory
 for new drivers to use the generic PWM framework.
 
-A new PWM controller/chip can be added using pwmchip_add() and removed
-again with pwmchip_remove(). pwmchip_add() takes a filled in struct
-pwm_chip as argument which provides a description of the PWM chip, the
-number of PWM devices provided by the chip and the chip-specific
-implementation of the supported PWM operations to the framework.
+A new PWM controller/chip can be allocated using devm_pwmchip_alloc, then added
+using pwmchip_add() and removed again with pwmchip_remove(). pwmchip_add()
+takes a filled in struct pwm_chip as argument which provides a description of
+the PWM chip, the number of PWM devices provided by the chip and the
+chip-specific implementation of the supported PWM operations to the framework.
 
 When implementing polarity support in a PWM driver, make sure to respect the
 signal conventions in the PWM framework. By definition, normal polarity
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3ef65bac7fef..065e68bc39ca 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -196,6 +196,30 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 	return true;
 }
 
+void *pwmchip_priv(struct pwm_chip *chip)
+{
+	return (void *)chip + sizeof(*chip);
+}
+EXPORT_SYMBOL_GPL(pwmchip_priv);
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
+{
+	struct pwm_chip *chip;
+	size_t alloc_size;
+
+	alloc_size = size_add(sizeof(*chip), sizeof_priv);
+
+	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
+	if (!chip)
+		return ERR_PTR(-ENOMEM);
+
+	chip->dev = parent;
+	chip->npwm = npwm;
+
+	return chip;
+}
+EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
+
 /**
  * __pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -208,9 +232,8 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	struct pwm_device *pwm;
-	unsigned int i;
 	int ret;
+	unsigned i;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
@@ -220,7 +243,7 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
+	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
 	if (!chip->pwms)
 		return -ENOMEM;
 
@@ -234,9 +257,8 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	}
 
 	chip->id = ret;
-
 	for (i = 0; i < chip->npwm; i++) {
-		pwm = &chip->pwms[i];
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		pwm->chip = chip;
 		pwm->hwpwm = i;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index cb2c122ed84a..9d1ed1a13b38 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/compiler_attributes.h>
 
 struct pwm_chip;
 
@@ -385,6 +386,10 @@ static inline void pwm_disable(struct pwm_device *pwm)
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
 
+void *pwmchip_priv(struct pwm_chip *chip) __attribute_const__;
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
+
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
 #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
 void pwmchip_remove(struct pwm_chip *chip);
-- 
2.42.0

