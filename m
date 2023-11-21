Return-Path: <linux-pwm+bounces-104-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4B7F2FBB
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001301C2195B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD63537F5;
	Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E05D6E
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAf-0006jJ-N3; Tue, 21 Nov 2023 14:52:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAe-00Ab3D-5U; Tue, 21 Nov 2023 14:52:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAd-004xiF-SV; Tue, 21 Nov 2023 14:52:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 107/108] pwm: Add more locking
Date: Tue, 21 Nov 2023 14:50:49 +0100
Message-ID: <20231121134901.208535-108-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6255; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fv4owEAX/3VhLfGfvMYUehaVu71r4UF5pOS7YdjGEv8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLXC2DSCIGiZqSbfEkw7x0cuGpOo1iJAH3TZN BtqAYjv6OWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1wgAKCRCPgPtYfRL+ TgxoB/9qwzu9w281fQakPINT27GfpiGYLyz86aENTAZjgGfom6ZAZBAODrq7Vcvegxcc6DmNCRd 3meNbTgWFxOqos99Kcn7/j3/BsQgbLWIvTvtHkxG77LbYCJKCUS6jWIO4umW91uug+Ycv0wJOJ5 V7/QUY+1WBBC1vORv4n42U50uSRdio45gTdRdLnm/uOAW7BUgPWV7F3ZsOzUBcVVsx+00a9XFBf DQPqg6VaWz1255zytdIVnHCzvjPd3ED5zec+hGXUi1HeFymhVmwTNlNr1/D2exz8T9MKNX/jW7B 1EQ2nNqT74ui5za/F9LTgppJlgXtaN4OIxWJ80lnXIc3/EIk
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
 include/linux/pwm.h |  6 +++-
 2 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dd376fe9e265..8dbc79f7218c 100644
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
@@ -231,6 +241,7 @@ static struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm,
 
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
+	chip->operational = false;
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
@@ -311,23 +322,29 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
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
@@ -343,12 +360,27 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
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
@@ -524,7 +556,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
-	int err;
+	int err = 0;
 
 	/*
 	 * Some lowlevel driver's implementations of .apply() make use of
@@ -541,17 +573,24 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
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
 
@@ -561,7 +600,10 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	pwm_apply_state_debug(pwm, state);
 
-	return 0;
+out_unlock:
+	pwmchip_unlock(chip);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_apply_state);
 
@@ -585,7 +627,12 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
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
@@ -992,23 +1039,28 @@ EXPORT_SYMBOL_GPL(pwm_get);
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
index 081c8402155d..4e81e8819f8c 100644
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


