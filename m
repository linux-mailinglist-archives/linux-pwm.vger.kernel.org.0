Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CCB4F99CC
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Apr 2022 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiDHPrt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Apr 2022 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiDHPrd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Apr 2022 11:47:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A53C6815
        for <linux-pwm@vger.kernel.org>; Fri,  8 Apr 2022 08:45:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqnf-0002ti-Iv; Fri, 08 Apr 2022 17:45:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqnf-001pOD-QE; Fri, 08 Apr 2022 17:45:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqnd-001zyb-3y; Fri, 08 Apr 2022 17:45:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: clps71xx: Implement .apply() callback
Date:   Fri,  8 Apr 2022 17:45:20 +0200
Message-Id: <20220408154520.173148-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3519; h=from:subject; bh=2HgEUA/Cc63pHtE3BmYITTqH7XR5skoXVyNuotFs2to=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSQFRPTMZmg+7u509fyReywyH/03RyXqvz/5q/L1JMb9GaWK 19bwdzIaszAwcjHIiimy1BVpiU2QWPPfrmQJN8wgViaQKQxcnAIwEXcODoYJZ5WmiPtqJngtYmftqo qMWpnINf1WtGaJV8IuiYKNx32s96yoMqi/r1QtriCvr/7aV6rsud0Dhi4Rpylbt7Jfv1904/3V/n++ vnrvw0L8Av4snSS951ZLLG8nx7PfjteSM38YTGaau148OC4rtONsoHes4w49qfBQFov+JJOqec2eGq JM61b+WtCzY3vX8z0r1id936n4dg6fXtdBhqTr17wl10TENuvq1piWTnOvsOA9GKsaosPTUzhn0quV HEyt8w/ulNT7k9o4N6jgB8Pu91omx79NkJRe3nFf+JP9w0eZHuVHt335skQ9u9vhx4+pMqEcs3xaxW xKqxNmi2fqC1zmlLq+0WCGbSIDAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().

This fixes a small issue in clps711x_get_duty() en passant: the
multiplication v * 0xf might have overflown.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clps711x.c | 68 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 47 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index d7ad88685830..b0d91142da8d 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -23,29 +23,6 @@ static inline struct clps711x_chip *to_clps711x_chip(struct pwm_chip *chip)
 	return container_of(chip, struct clps711x_chip, chip);
 }
 
-static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
-{
-	/* PWM0 - bits 4..7, PWM1 - bits 8..11 */
-	u32 shift = (n + 1) * 4;
-	unsigned long flags;
-	u32 tmp;
-
-	spin_lock_irqsave(&priv->lock, flags);
-
-	tmp = readl(priv->pmpcon);
-	tmp &= ~(0xf << shift);
-	tmp |= v << shift;
-	writel(tmp, priv->pmpcon);
-
-	spin_unlock_irqrestore(&priv->lock, flags);
-}
-
-static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
-{
-	/* Duty cycle 0..15 max */
-	return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
-}
-
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct clps711x_chip *priv = to_clps711x_chip(chip);
@@ -60,44 +37,41 @@ static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	return 0;
 }
 
-static int clps711x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       int duty_ns, int period_ns)
+static int clps711x_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
 {
 	struct clps711x_chip *priv = to_clps711x_chip(chip);
-	unsigned int duty;
+	/* PWM0 - bits 4..7, PWM1 - bits 8..11 */
+	u32 shift = (pwm->hwpwm + 1) * 4;
+	unsigned long flags;
+	u32 pmpcon, val;
 
-	if (period_ns != pwm->args.period)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
-	duty = clps711x_get_duty(pwm, duty_ns);
-	clps711x_pwm_update_val(priv, pwm->hwpwm, duty);
-
-	return 0;
-}
+	if (state->period != pwm->args.period)
+		return -EINVAL;
 
-static int clps711x_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct clps711x_chip *priv = to_clps711x_chip(chip);
-	unsigned int duty;
+	if (state->enabled)
+		val = mul_u64_u64_div_u64(state->duty_cycle, 0xf, state->period);
+	else
+		val = 0;
 
-	duty = clps711x_get_duty(pwm, pwm_get_duty_cycle(pwm));
-	clps711x_pwm_update_val(priv, pwm->hwpwm, duty);
+	spin_lock_irqsave(&priv->lock, flags);
 
-	return 0;
-}
+	pmpcon = readl(priv->pmpcon);
+	pmpcon &= ~(0xf << shift);
+	pmpcon |= val << shift;
+	writel(pmpcon, priv->pmpcon);
 
-static void clps711x_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct clps711x_chip *priv = to_clps711x_chip(chip);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
-	clps711x_pwm_update_val(priv, pwm->hwpwm, 0);
+	return 0;
 }
 
 static const struct pwm_ops clps711x_pwm_ops = {
 	.request = clps711x_pwm_request,
-	.config = clps711x_pwm_config,
-	.enable = clps711x_pwm_enable,
-	.disable = clps711x_pwm_disable,
+	.apply = clps711x_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

