Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F27D0305
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Oct 2023 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjJSUH4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Oct 2023 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjJSUHz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Oct 2023 16:07:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6912A
        for <linux-pwm@vger.kernel.org>; Thu, 19 Oct 2023 13:07:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-0000Ak-Ve; Thu, 19 Oct 2023 22:07:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-002rg1-IZ; Thu, 19 Oct 2023 22:07:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-001veP-96; Thu, 19 Oct 2023 22:07:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 4/5] pwm: stm32: Implement .get_state()
Date:   Thu, 19 Oct 2023 22:07:03 +0200
Message-ID: <20231019200658.1754190-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=a4YNJqVWNTjxoPeyBz51eWsONkN24HxJQfsK5S4fI0Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlMYxnKf54sdPYpj7Bgncogp6hM/NyHjZw69SfO FSnOf0uohGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTGMZwAKCRCPgPtYfRL+ ThuCB/9mwyjU5PRSSr25d3bJVQKHaWtBscZmvI1Zs52otx8OlSjsHRP1hUp0MKRDAkytj/es2u1 psm3LpcY5LaVIOFl+Htk/TCLSEkOkR84cTgpTmgusK0qn25w0silPqpESu5V8bDNL2/iGnbOGSd mIIObFx3L/kzRBdURzo3HYsWUk3yOjs3Vm9zE8YbL2O9G96Vnc98QhxP/SR9rOCGkeI8qC6W5iZ B1zi6gDpdl9JHkbURETO1OBCRdRlGMUCDTshWOVNwUFVuJ6J5gpxuc3xsbluOxGKvPdmWLGziqr EYKLdWPfllQVuPlcyKaa5jj0m47+pc9/ozvbhrntRiPPQMB1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

Implement the &pwm_ops->get_state callback so drivers can inherit PWM
state set by the bootloader.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[ukl: split off from a patch that also fixes clk enable count in .probe()]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index cc6cae07c02c..68239567a564 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -471,8 +471,50 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int stm32_pwm_get_state(struct pwm_chip *chip,
+			       struct pwm_device *pwm, struct pwm_state *state)
+{
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	int ch = pwm->hwpwm;
+	unsigned long rate;
+	u32 ccer, psc, arr, ccr;
+	u64 dty, prd;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ret)
+		goto out;
+
+	state->enabled = ccer & (TIM_CCER_CC1E << (ch * 4));
+	state->polarity = (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	ret = regmap_read(priv->regmap, TIM_PSC, &psc);
+	if (ret)
+		goto out;
+	ret = regmap_read(priv->regmap, TIM_ARR, &arr);
+	if (ret)
+		goto out;
+	ret = regmap_read(priv->regmap, TIM_CCR1 + 4 * ch, &ccr);
+	if (ret)
+		goto out;
+
+	rate = clk_get_rate(priv->clk);
+
+	prd = (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
+	state->period = DIV_ROUND_UP_ULL(prd, rate);
+	dty = (u64)NSEC_PER_SEC * (psc + 1) * ccr;
+	state->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
+
+out:
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
 static const struct pwm_ops stm32pwm_ops = {
 	.apply = stm32_pwm_apply_locked,
+	.get_state = stm32_pwm_get_state,
 	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
 };
 
-- 
2.42.0

