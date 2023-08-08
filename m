Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1D774BC4
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjHHUyx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjHHUyi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:54:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9876477996
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNI-0007mS-6e; Tue, 08 Aug 2023 19:20:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNH-0022Ap-IO; Tue, 08 Aug 2023 19:20:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-00BTGj-OW; Tue, 08 Aug 2023 19:20:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 101/101] pwm: Add more locking
Date:   Tue,  8 Aug 2023 19:19:31 +0200
Message-Id: <20230808171931.944154-102-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5094; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=62w9lG59x0ebWrSUPquQfya80qlvH8LZL6IxbNQGe0k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkiIs5VowWnRpj2BgV+Oq6t0vpuiM/f65Zjr 53NV3g61g+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5IgAKCRCPgPtYfRL+ TkKbB/4xkEkcLUhnLOdzx2eRKPH8xrP7Yi+xyrjh6QH9SZh1DAccsKnrecZ+TTXDmLETzjMymbs oEiCKggGgyX+8u58BDnh7eFFBCEIlYTg7yP1TnrwrKyhIbgQEya0/eLObtmHPNKyJm6KpgvgQku e9YIvHSfeOh3TlYjTer4L8TpvjUCMTBu8AD8aIdaQpqpTJycOPsyeHJ8NRJVqJp9kSL21l33vtq dHGpk5YBjZKAuNG9yy5WPF5ASHyUe/zcead7L6jcL3nsC7T+FoljSf3EdKpacISks6B7py2hN8n yEVqUukXeiISdvcwotGD0Nq+uGE4w4r1D+DHhUUM9zPjgk+r
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

A not so nice side effect is that all calls to the PWM API are
serialized now. If this turns out to be problematic this can be replaced
by per-pwm_chip locking later. As long as this bottleneck isn't known to
be a problem in practise, the simpler approach of a single lock is used
here.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 50 ++++++++++++++++++++++++++++++++++++---------
 include/linux/pwm.h |  2 ++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index fcf30f77da34..66743ded66f6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -230,6 +230,7 @@ static struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm,
 	dev->release = pwmchip_release;
 
 	chip->npwm = npwm;
+	chip->ready = false;
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
@@ -309,6 +310,8 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 		module_put(owner);
 	}
 
+	chip->ready = true;
+
 	mutex_unlock(&pwm_lock);
 
 	return ret;
@@ -324,12 +327,25 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
 void pwmchip_remove(struct pwm_chip *chip)
 {
 	pwmchip_sysfs_unexport(chip);
+	unsigned int i;
 
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
 	mutex_lock(&pwm_lock);
 
+	for (i = 0; i < chip->npwm; ++i) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+			dev_alert(&chip->dev, "Freeing requested pwm #%u\n", i);
+			if (pwm->chip->ops->free)
+				pwm->chip->ops->free(pwm->chip, pwm);
+		}
+	}
+
+	chip->ready = false;
+
 	idr_remove(&pwmchip_idr, chip->id);
 
 	mutex_unlock(&pwm_lock);
@@ -505,7 +521,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
-	int err;
+	int err = 0;
 
 	/*
 	 * Some lowlevel driver's implementations of .apply() make use of
@@ -522,17 +538,24 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 	chip = pwm->chip;
 
+	mutex_lock(&pwm_lock);
+
+	if (!chip->ready) {
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
 
@@ -542,7 +565,10 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	pwm_apply_state_debug(pwm, state);
 
-	return 0;
+out_unlock:
+	mutex_unlock(&pwm_lock);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_apply_state);
 
@@ -566,7 +592,12 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		return -ENOSYS;
 
 	mutex_lock(&pwm_lock);
-	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+
+	if (pwm->chip->ready)
+		err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	else
+		err = -ENXIO;
+
 	mutex_unlock(&pwm_lock);
 
 	return err;
@@ -978,18 +1009,17 @@ void pwm_put(struct pwm_device *pwm)
 
 	mutex_lock(&pwm_lock);
 
-	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
-		pr_warn("PWM device already freed\n");
+	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags))
 		goto out;
-	}
 
-	if (pwm->chip->ops->free)
+	if (pwm->chip->ready && pwm->chip->ops->free)
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
index 3dd46b89ab8b..f5b65994a30e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -289,6 +289,7 @@ struct pwm_ops {
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
  * @list: list node for internal use
  * @pwms: array of PWM devices allocated by the framework
+ * @ready: tracks if the chip is operational
  */
 struct pwm_chip {
 	struct device dev;
@@ -302,6 +303,7 @@ struct pwm_chip {
 	unsigned int of_pwm_n_cells;
 
 	/* only used internally by the PWM framework */
+	bool ready;
 	struct pwm_device pwms[];
 };
 
-- 
2.40.1

