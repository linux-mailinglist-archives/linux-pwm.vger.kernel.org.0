Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC319BE8F
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfHXPha (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 11:37:30 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45400 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfHXPha (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 11:37:30 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 23E3677EAE4; Sat, 24 Aug 2019 17:37:29 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Patrick Havelange <patrick.havelange@essensium.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 1/6] pwm: introduce local struct pwm_chip in pwm_apply_state()
Date:   Sat, 24 Aug 2019 17:37:02 +0200
Message-Id: <20190824153707.13746-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824153707.13746-1-uwe@kleine-koenig.org>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm->chip is dereferenced several times in the pwm_apply_state()
function. Introducing a local variable for it helps keeping some lines a
bit shorter.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8edfac17364e..72347ca4a647 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -455,6 +455,7 @@ EXPORT_SYMBOL_GPL(pwm_free);
 int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 {
 	int err;
+	struct pwm_chip *chip;
 
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
@@ -466,8 +467,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	    state->enabled == pwm->state.enabled)
 		return 0;
 
-	if (pwm->chip->ops->apply) {
-		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
+	chip = pwm->chip;
+	if (chip->ops->apply) {
+		err = chip->ops->apply(chip, pwm, state);
 		if (err)
 			return err;
 
@@ -477,7 +479,7 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 		 * FIXME: restore the initial state in case of error.
 		 */
 		if (state->polarity != pwm->state.polarity) {
-			if (!pwm->chip->ops->set_polarity)
+			if (!chip->ops->set_polarity)
 				return -ENOTSUPP;
 
 			/*
@@ -486,12 +488,12 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 			 * ->apply().
 			 */
 			if (pwm->state.enabled) {
-				pwm->chip->ops->disable(pwm->chip, pwm);
+				chip->ops->disable(chip, pwm);
 				pwm->state.enabled = false;
 			}
 
-			err = pwm->chip->ops->set_polarity(pwm->chip, pwm,
-							   state->polarity);
+			err = chip->ops->set_polarity(chip, pwm,
+						      state->polarity);
 			if (err)
 				return err;
 
@@ -500,9 +502,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
-			err = pwm->chip->ops->config(pwm->chip, pwm,
-						     state->duty_cycle,
-						     state->period);
+			err = chip->ops->config(pwm->chip, pwm,
+						state->duty_cycle,
+						state->period);
 			if (err)
 				return err;
 
@@ -512,11 +514,11 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 		if (state->enabled != pwm->state.enabled) {
 			if (state->enabled) {
-				err = pwm->chip->ops->enable(pwm->chip, pwm);
+				err = chip->ops->enable(chip, pwm);
 				if (err)
 					return err;
 			} else {
-				pwm->chip->ops->disable(pwm->chip, pwm);
+				chip->ops->disable(chip, pwm);
 			}
 
 			pwm->state.enabled = state->enabled;
-- 
2.20.1

