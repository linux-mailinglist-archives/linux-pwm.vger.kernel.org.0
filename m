Return-Path: <linux-pwm+bounces-407-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C0806ED3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0B7B20F56
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA43588F;
	Wed,  6 Dec 2023 11:49:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C4A10F1
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOR-0007mj-3f; Wed, 06 Dec 2023 12:48:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00DwyV-NT; Wed, 06 Dec 2023 12:48:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00FR3z-Ef; Wed, 06 Dec 2023 12:48:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 113/115] pwm: Add more locking
Date: Wed,  6 Dec 2023 12:45:07 +0100
Message-ID:  <1784bd01564c9ac13e16c564c54132ec1755587d.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6204; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=YOohh7sbEwcIfkQsrVWg+Jeq1UFsC2+N8oIBKWXnxrQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9xMDZlL1HfuN35ajYosZmql0A2bSObR847i faLAdq1eRCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfcQAKCRCPgPtYfRL+ TlgYB/9W5rSl9weuuS1eDdFHfXwOzKvOg8exEEfxvWwV40xqyL2TbqIMLsV8OjOJsgNtO+UXjba nJ+zXnBl6ubTdlYbD+8QxnoD+KIeUcxV3xK3Vawxyt5JIcdriFQ6evoiA5p3a6+egKnkpa5Zzjb nr1kM3QkGQBfnELWS/YSdZmw05ph8JD+omEsW5w787TEkpa5YozDiy7+AWygasvxsLl0EiHeTHp 5Gu5ayxHaEQ1qPWBSZwBUaelBZ1g1++QZfcOa+27ahvbLksDeFIQTeNryBNqPaRi/wbYtw83EnA 3kOo+jQfsZkbak4P9lWArzTCxyJlrgahI5VR0HiPVLAuZCNV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This ensures that a pwm_chip that has no corresponding driver isn't used
and that a driver doesn't go away while a callback is still running.

As with the previous commit this is not needed yet, but once we have PWM
character device support this is required for race-free operation.

To not serialize all pwm_apply_state() calls, this introduces a per chip
lock. To prepare for a more sophisticated locking scheme involving spin
locks instead of mutexes for "fast" chips, there are (for now trivial)
functions introduced for locking and unlocking.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 76 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/pwm.h |  5 +++
 2 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4805ccff5970..9cbbf675a84c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -32,6 +32,16 @@ static DEFINE_MUTEX(pwm_lock);
 
 static DEFINE_IDR(pwmchip_idr);
 
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
@@ -232,6 +242,7 @@ static struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm,
 
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
+	chip->operational = false;
 
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
@@ -314,23 +325,29 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
+	mutex_init(&chip->lock);
+
 	ret = device_add(&chip->dev);
 	if (ret)
 		goto err_device_add;
 
+	pwmchip_lock(chip);
+	chip->operational = true;
+	pwmchip_unlock(chip);
+
 	mutex_unlock(&pwm_lock);
 
 	return 0;
 
 err_device_add:
 
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_remove(chip);
+	of_pwmchip_remove(chip);
 
 	idr_remove(&pwmchip_idr, chip->id);
 err_idr_alloc:
 
 	mutex_unlock(&pwm_lock);
+
 	module_put(owner);
 
 	return ret;
@@ -346,12 +363,27 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
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
 	idr_remove(&pwmchip_idr, chip->id);
 
 	mutex_unlock(&pwm_lock);
@@ -527,7 +559,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
-	int err;
+	int err = 0;
 
 	/*
 	 * Some lowlevel driver's implementations of .apply() make use of
@@ -544,17 +576,24 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
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
 
@@ -564,7 +603,10 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	pwm_apply_state_debug(pwm, state);
 
-	return 0;
+out_unlock:
+	pwmchip_unlock(chip);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_apply_state);
 
@@ -588,7 +630,12 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
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
@@ -995,23 +1042,28 @@ EXPORT_SYMBOL_GPL(pwm_get);
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
index 8b4aca36c35f..1860225ab45b 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -287,6 +287,9 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
+ * @lock: mutex protecting .operational and serializing ops and chip unregistration
+ * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
+ * @operational: tracks if the chip is operational
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -301,7 +304,9 @@ struct pwm_chip {
 	unsigned int of_pwm_n_cells;
 
 	/* only used internally by the PWM framework */
+	struct mutex lock;
 	bool uses_pwmchip_alloc;
+	bool operational;
 	void *driver_data;
 	struct pwm_device pwms[] __counted_by(npwm);
 };
-- 
2.42.0


