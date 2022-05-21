Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795652FAC9
	for <lists+linux-pwm@lfdr.de>; Sat, 21 May 2022 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiEULCP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 21 May 2022 07:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiEULCO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 21 May 2022 07:02:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D480219
        for <linux-pwm@vger.kernel.org>; Sat, 21 May 2022 04:02:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsMs5-0003jf-Q3; Sat, 21 May 2022 13:02:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsMs6-003fOX-3T; Sat, 21 May 2022 13:02:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nsMs3-00B9xE-VH; Sat, 21 May 2022 13:02:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Drop support for legacy drivers
Date:   Sat, 21 May 2022 13:02:03 +0200
Message-Id: <20220521110203.790597-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5091; h=from:subject; bh=lKRYBy+lZjLxhefEwU6vW08/ky5PjLkWuPlrIpcSqBc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiiMan+v89UNQVnROa6J7tZgqN/ZRu4noWLsG/ub+T 951g926JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYojGpwAKCRDB/BR4rcrsCSNMB/ 9R4rbdOaw54INOMerghLJn5jf5M/4kI/4FGa7RWE+ClURr39FiK1XpODKCBg6L6TfEfETkWOLkk+7B y3tiinUqiOz5qBfdSeQdL57QREkVg5iJJ8+ETplDnsynoFhScRZ2cLY0rDErCwp8pogUGHDHeZRLa6 jkxK8BMn7AKertiX3sPQRpzDumauDsdx3E6aDzzIcpxYDTjfG6PGW8/NLK+wAlNl48F+R861nE3yDY jMI9AUm7N+8w63F0UfJLZc/uxc+f7sQ+DFgC7TJflqjLgE8ztm65Nldx1eIp7WCWdgnPoCnj61GeLC Rg8OwTl/9h+NvBOaWIEnxbYvGZvdUu
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no drivers left providing the legacy callbacks. So drop
support for these.

If this commit breaks your out-of-tree pwm driver, look at e.g. commit
ec00cd5e63f0 ("pwm: renesas-tpu: Implement .apply() callback") for an
example of the needed conversion for your driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

on top of current Thierry's for-next branch this compiles just fine
an allmodconfig on arm64, m68k, powerpc, riscv, s390, sparc64 and x86_64
after cherry-picking 357ad4d89828 ("sound/oss/dmasound: fix
'dmasound_setup' defined but not used") to fix an unrelated problem.

Still I think it would be nice to have this cooking in next for some
time after the next merge window closes.

Best regards
Uwe

 drivers/pwm/core.c  | 82 +--------------------------------------------
 include/linux/pwm.h | 12 -------
 2 files changed, 1 insertion(+), 93 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c7552df32082..0e042410f6b9 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -235,18 +235,8 @@ EXPORT_SYMBOL_GPL(pwm_get_chip_data);
 
 static bool pwm_ops_check(const struct pwm_chip *chip)
 {
-
 	const struct pwm_ops *ops = chip->ops;
 
-	/* driver supports legacy, non-atomic operation */
-	if (ops->config && ops->enable && ops->disable) {
-		if (IS_ENABLED(CONFIG_PWM_DEBUG))
-			dev_warn(chip->dev,
-				 "Driver needs updating to atomic API\n");
-
-		return true;
-	}
-
 	if (!ops->apply)
 		return false;
 
@@ -548,73 +538,6 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	}
 }
 
-static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
-{
-	int err;
-	struct pwm_state initial_state = pwm->state;
-
-	if (state->polarity != pwm->state.polarity) {
-		if (!chip->ops->set_polarity)
-			return -EINVAL;
-
-		/*
-		 * Changing the polarity of a running PWM is only allowed when
-		 * the PWM driver implements ->apply().
-		 */
-		if (pwm->state.enabled) {
-			chip->ops->disable(chip, pwm);
-
-			/*
-			 * Update pwm->state already here in case
-			 * .set_polarity() or another callback depend on that.
-			 */
-			pwm->state.enabled = false;
-		}
-
-		err = chip->ops->set_polarity(chip, pwm, state->polarity);
-		if (err)
-			goto rollback;
-
-		pwm->state.polarity = state->polarity;
-	}
-
-	if (!state->enabled) {
-		if (pwm->state.enabled)
-			chip->ops->disable(chip, pwm);
-
-		return 0;
-	}
-
-	/*
-	 * We cannot skip calling ->config even if state->period ==
-	 * pwm->state.period && state->duty_cycle == pwm->state.duty_cycle
-	 * because we might have exited early in the last call to
-	 * pwm_apply_state because of !state->enabled and so the two values in
-	 * pwm->state might not be configured in hardware.
-	 */
-	err = chip->ops->config(pwm->chip, pwm,
-				state->duty_cycle,
-				state->period);
-	if (err)
-		goto rollback;
-
-	pwm->state.period = state->period;
-	pwm->state.duty_cycle = state->duty_cycle;
-
-	if (!pwm->state.enabled) {
-		err = chip->ops->enable(chip, pwm);
-		if (err)
-			goto rollback;
-	}
-
-	return 0;
-
-rollback:
-	pwm->state = initial_state;
-	return err;
-}
-
 /**
  * pwm_apply_state() - atomically apply a new state to a PWM device
  * @pwm: PWM device
@@ -647,10 +570,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	    state->usage_power == pwm->state.usage_power)
 		return 0;
 
-	if (chip->ops->apply)
-		err = chip->ops->apply(chip, pwm, state);
-	else
-		err = pwm_apply_legacy(chip, pwm, state);
+	err = chip->ops->apply(chip, pwm, state);
 	if (err)
 		return err;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 9771a0761a40..76463b71ad4e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -261,10 +261,6 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  *	       called once per PWM device when the PWM chip is
  *	       registered.
  * @owner: helps prevent removal of modules exporting active PWMs
- * @config: configure duty cycles and period length for this PWM
- * @set_polarity: configure the polarity of this PWM
- * @enable: enable PWM output toggling
- * @disable: disable PWM output toggling
  */
 struct pwm_ops {
 	int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);
@@ -276,14 +272,6 @@ struct pwm_ops {
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
 	struct module *owner;
-
-	/* Only used by legacy drivers */
-	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
-		      int duty_ns, int period_ns);
-	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
-			    enum pwm_polarity polarity);
-	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
-	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
 };
 
 /**

base-commit: 3d593b6e80ad2c911b5645af28d83eabb96e7c1b
-- 
2.35.1

