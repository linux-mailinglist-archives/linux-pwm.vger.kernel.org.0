Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA87C7317
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379515AbjJLQdE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347329AbjJLQc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:32:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9BCDD
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycK-0000hd-1Q; Thu, 12 Oct 2023 18:32:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycJ-001CCS-JB; Thu, 12 Oct 2023 18:32:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycJ-00F5Vw-A5; Thu, 12 Oct 2023 18:32:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 108/109] pwm: Add more locking
Date:   Thu, 12 Oct 2023 18:32:37 +0200
Message-ID: <20231012163227.1004288-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6471; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nft5jCJfhdk/wxpN5j93QnovAI2y0NZphbcjvUqFjQU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQN+WUyGTt3OmSu+9dpN9n7FmvgjWnuqab/LcX+yovLV FdPeXSsk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJnPnHwbC09MwXseQJ/ywl bReVrJv+ntX+2+N/m/Pc+Eo4l397KRMVveT199PSG6c5x0uJxT+6KjAn9CzLHd24x9e9wt0/sgo piR3LDBS7M6MszzzwWE5tybsvjQ6G1+7O9ZJ+luxpcGuq3NsO91jDPSE2NZc+BrJ4s6cna3sE3k r//DA/S91qyxPR27Vf2ZW7eyrdm3Mm9Ivy98qd16tYYeDMVXHyiNuLpCNunzmnXIv325HO1H9n1 q3sOyqskReal/r+q4oqnZQQ7P3ccM1B37LWXcbdASvOu0j9lw02rghSlD6+UCr4x8339wwWLZhw 28UtL5j5/WH/EP7nC0119dbMijGc4NXTWfWsc7O3uOdVAA==
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

This ensures that a pwm_chip that has no corresponding driver isn't used
and that a driver doesn't go away while a callback is still running.

As with the previous commit this was not expected to be a problem in the
presence of device links, but still it can happen with the command
sequence mentioned in the previous commit. Even if this should turn out
to be a problem that could be fixed by improving device links, this is a
necessary preparation to create race-free pwmchip character devices.

To not serialize all pwm_apply_state() calls, this introduces a per chip
lock. To prepare for a more sophisticated locking scheme involving spin
locks instead of mutexes for "fast" chips, there are (for now trivial)
functions introduced for locking and unlocking.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 89 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/pwm.h |  6 ++-
 2 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ddb873a20dd3..957d57e3d41d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -32,6 +32,16 @@ static DEFINE_MUTEX(pwm_lock);
 
 static DEFINE_IDR(pwm_chips);
 
+static void pwmchip_lock(struct pwm_chip *chip)
+{
+	mutex_lock(&chip->lock);
+}
+
+static void pwmchip_unlock(struct pwm_chip *chip)
+{
+	mutex_unlock(&chip->lock);
+}
+
 static struct pwm_chip *pwmchip_find_by_name(const char *name)
 {
 	struct pwm_chip *chip;
@@ -231,6 +241,7 @@ static struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm,
 
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
+	chip->operational = false;
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
@@ -311,13 +322,28 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
+	mutex_init(&chip->lock);
+
 	ret = device_add(&chip->dev);
-	if (ret) {
-		idr_remove(&pwm_chips, chip->id);
+	if (ret)
+		goto err_device_add;
+
+	pwmchip_lock(chip);
+	chip->operational = true;
+	pwmchip_unlock(chip);
+
+	mutex_unlock(&pwm_lock);
+
+	return 0;
+
+err_device_add:
+
+	of_pwmchip_remove(chip);
+
+	idr_remove(&pwm_chips, chip->id);
 err_idr_alloc:
 
-		module_put(owner);
-	}
+	module_put(owner);
 
 	mutex_unlock(&pwm_lock);
 
@@ -334,12 +360,27 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
 void pwmchip_remove(struct pwm_chip *chip)
 {
 	pwmchip_sysfs_unexport(chip);
+	unsigned int i;
 
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
 	mutex_lock(&pwm_lock);
 
+	pwmchip_lock(chip);
+	chip->operational = false;
+	pwmchip_unlock(chip);
+
+	for (i = 0; i < chip->npwm; ++i) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+			dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);
+			if (pwm->chip->ops->free)
+				pwm->chip->ops->free(pwm->chip, pwm);
+		}
+	}
+
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
@@ -515,7 +556,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
-	int err;
+	int err = 0;
 
 	/*
 	 * Some lowlevel driver's implementations of .apply() make use of
@@ -532,17 +573,24 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 	chip = pwm->chip;
 
+	pwmchip_lock(chip);
+
+	if (!chip->operational) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
 	    state->polarity == pwm->state.polarity &&
 	    state->enabled == pwm->state.enabled &&
 	    state->usage_power == pwm->state.usage_power)
-		return 0;
+		goto out_unlock;
 
 	err = chip->ops->apply(chip, pwm, state);
 	trace_pwm_apply(pwm, state, err);
 	if (err)
-		return err;
+		goto out_unlock;
 
 	pwm->state = *state;
 
@@ -552,7 +600,10 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	pwm_apply_state_debug(pwm, state);
 
-	return 0;
+out_unlock:
+	pwmchip_unlock(chip);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_apply_state);
 
@@ -576,7 +627,12 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		return -ENOSYS;
 
 	mutex_lock(&pwm_lock);
-	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+
+	if (pwm->chip->operational)
+		err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	else
+		err = -ENXIO;
+
 	mutex_unlock(&pwm_lock);
 
 	return err;
@@ -983,23 +1039,28 @@ EXPORT_SYMBOL_GPL(pwm_get);
  */
 void pwm_put(struct pwm_device *pwm)
 {
+	bool operational;
+
 	if (!pwm)
 		return;
 
 	mutex_lock(&pwm_lock);
 
-	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
-		pr_warn("PWM device already freed\n");
+	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags))
 		goto out;
-	}
 
-	if (pwm->chip->ops->free)
+	pwmchip_lock(pwm->chip);
+	operational = pwm->chip->operational;
+	pwmchip_unlock(pwm->chip);
+
+	if (operational && pwm->chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
 	pwm->label = NULL;
 
-	put_device(&pwm->chip->dev);
 out:
+	put_device(&pwm->chip->dev);
+
 	mutex_unlock(&pwm_lock);
 }
 EXPORT_SYMBOL_GPL(pwm_put);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0be2409a3b64..8e3e579deea2 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -287,7 +287,9 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
- * @list: list node for internal use
+ * @lock: mutex protecting .operational and serializing ops and chip unregistration
+ * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
+ * @operational: tracks if the chip is operational
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -302,7 +304,9 @@ struct pwm_chip {
 	unsigned int of_pwm_n_cells;
 
 	/* only used internally by the PWM framework */
+	struct mutex lock;
 	bool uses_pwmchip_alloc;
+	bool operational;
 	struct pwm_device pwms[] __counted_by(npwm);
 };
 
-- 
2.42.0

