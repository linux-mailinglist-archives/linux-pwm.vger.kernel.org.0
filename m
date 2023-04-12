Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB46DF466
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDLL4s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDLL4s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 07:56:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28ED5272
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 04:56:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmZ5e-0006dd-8v; Wed, 12 Apr 2023 13:56:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmZ5c-00Aj3J-T7; Wed, 12 Apr 2023 13:56:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmZ5c-00CXN2-AK; Wed, 12 Apr 2023 13:56:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Delete deprecated functions pwm_request() and pwm_free()
Date:   Wed, 12 Apr 2023 13:56:36 +0200
Message-Id: <20230412115636.3533366-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4814; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hzKsQ1DTmxiHUKxJhvF26EcXojJEHrYLTc0GIc/ud2E=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhSzOUXVTjsq+j0136+6L95YErtE9oVhcKPicdZjHs37i hPK/+/tZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi4Rrs/2PmbrH68EP46IrD X2W+HeXfEvpJNSVyzed4WSOxwtqifyxP0z8XCCxdr7o4Wuh9a/RDv/wuD6UJM6N9X+79u1Jb2vo 765R5BhWXNJ4s/X6va5+4z1ZGI9O+edeFvCqk2vTZ/v/vFciLddywYJJ+hv15585+9RyPGQsElZ isIxfUPs96xm3z+/TyxLj3ibbumx0NVnFxH1basuvq3q5Xf+UPMv6Pmp57y3L/RNmORZ6N/mvum bReFY70VWDTidapap25LtI1KKrjb0xi36lrFs+2RbML8Dj57Fp2Onpeyr7Psw9s19w/L92G5Xcw u8CNGZuuMwrGK9su1OIrX7FbYU3W3NwMt7ee/mriHFvqAQ==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 5a7fbe452ad9 ("backlight: pwm_bl: Drop support for legacy PWM
probing") the last user of pwm_request() and pwm_free() is gone. So remove
these functions that were deprecated over 10 years ago in commit
8138d2ddbcca ("pwm: Add table-based lookup for static mappings").

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/pwm.rst | 13 ++++-----
 drivers/pwm/core.c               | 49 --------------------------------
 include/linux/pwm.h              | 13 ---------
 3 files changed, 5 insertions(+), 70 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 8c71a2055d27..3fdc95f7a1d1 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -35,12 +35,9 @@ consumers to providers, as given in the following example::
 Using PWMs
 ----------
 
-Legacy users can request a PWM device using pwm_request() and free it
-after usage with pwm_free().
-
-New users should use the pwm_get() function and pass to it the consumer
-device or a consumer name. pwm_put() is used to free the PWM device. Managed
-variants of the getter, devm_pwm_get() and devm_fwnode_pwm_get(), also exist.
+Consumers use the pwm_get() function and pass to it the consumer device or a
+consumer name. pwm_put() is used to free the PWM device. Managed variants of
+the getter, devm_pwm_get() and devm_fwnode_pwm_get(), also exist.
 
 After being requested, a PWM has to be configured using::
 
@@ -165,8 +162,8 @@ consumers should implement it as described in the "Using PWMs" section.
 Locking
 -------
 
-The PWM core list manipulations are protected by a mutex, so pwm_request()
-and pwm_free() may not be called from an atomic context. Currently the
+The PWM core list manipulations are protected by a mutex, so pwm_get()
+and pwm_put() may not be called from an atomic context. Currently the
 PWM core does not enforce any locking to pwm_enable(), pwm_disable() and
 pwm_config(), so the calling context is currently driver specific. This
 is an issue derived from the former barebone API and should be fixed soon.
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e01147f66e15..c60a6d93d666 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -362,43 +362,6 @@ int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(devm_pwmchip_add);
 
-/**
- * pwm_request() - request a PWM device
- * @pwm: global PWM device index
- * @label: PWM device label
- *
- * This function is deprecated, use pwm_get() instead.
- *
- * Returns: A pointer to a PWM device or an ERR_PTR()-encoded error code on
- * failure.
- */
-struct pwm_device *pwm_request(int pwm, const char *label)
-{
-	struct pwm_device *dev;
-	int err;
-
-	if (pwm < 0 || pwm >= MAX_PWMS)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&pwm_lock);
-
-	dev = pwm_to_device(pwm);
-	if (!dev) {
-		dev = ERR_PTR(-EPROBE_DEFER);
-		goto out;
-	}
-
-	err = pwm_device_request(dev, label);
-	if (err < 0)
-		dev = ERR_PTR(err);
-
-out:
-	mutex_unlock(&pwm_lock);
-
-	return dev;
-}
-EXPORT_SYMBOL_GPL(pwm_request);
-
 /**
  * pwm_request_from_chip() - request a PWM device relative to a PWM chip
  * @chip: PWM chip
@@ -431,18 +394,6 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 }
 EXPORT_SYMBOL_GPL(pwm_request_from_chip);
 
-/**
- * pwm_free() - free a PWM device
- * @pwm: PWM device
- *
- * This function is deprecated, use pwm_put() instead.
- */
-void pwm_free(struct pwm_device *pwm)
-{
-	pwm_put(pwm);
-}
-EXPORT_SYMBOL_GPL(pwm_free);
-
 static void pwm_apply_state_debug(struct pwm_device *pwm,
 				  const struct pwm_state *state)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7b7b93b6fb81..04ae1d9073a7 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -309,8 +309,6 @@ struct pwm_chip {
 
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
-struct pwm_device *pwm_request(int pwm_id, const char *label);
-void pwm_free(struct pwm_device *pwm);
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
@@ -410,17 +408,6 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
-static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
-{
-	might_sleep();
-	return ERR_PTR(-ENODEV);
-}
-
-static inline void pwm_free(struct pwm_device *pwm)
-{
-	might_sleep();
-}
-
 static inline int pwm_apply_state(struct pwm_device *pwm,
 				  const struct pwm_state *state)
 {

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

