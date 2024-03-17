Return-Path: <linux-pwm+bounces-1791-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E8687E088
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016BA1C20CFB
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D06208B0;
	Sun, 17 Mar 2024 21:52:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A8208CA
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710712361; cv=none; b=WorqgWr2Y8BFel67Vw1PGTxvwkQJ8j5MURxOip67kd2T3f6RUV+e43Db5PvjahDPfmdFSneUY9Q0RUEGZU3zCw0/8V1oVGhQk0Me3u//TXnxewyuCOqjSNKGJPmC2UmbiJdT1ck/N75nXOSshnPGmSsY7X0EkC7VdyULGPzGBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710712361; c=relaxed/simple;
	bh=LC/LLRqDr9Z7kf3kDVEv9tMRdoh326PaTq2N/xGKxhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+yhTOhs2dO4EjUglGCHYoP0VZLhGIB41iqS9W+EL4cCeV0oZe0xlRkmQKVj+fcZ6Dp0ZnA2EaLphp0trDUPN/9mNBsGB0mGrNRazSFEv5MizhtvLTnLZQeC0geCa3iF1SXaJE0tJq0rbzLcdned7mEZxjus7cXDMSGnZevaxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQk-0002ko-4u; Sun, 17 Mar 2024 22:52:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQj-006xGt-8J; Sun, 17 Mar 2024 22:52:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQj-007fo3-0Z;
	Sun, 17 Mar 2024 22:52:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 2/3] pwm: stm32: Fix for settings using period > UINT32_MAX
Date: Sun, 17 Mar 2024 22:52:15 +0100
Message-ID:  <06b4a650a608d0887d934c1b2b8919e0f78e4db2.1710711976.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710711976.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710711976.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=LC/LLRqDr9Z7kf3kDVEv9tMRdoh326PaTq2N/xGKxhs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl92YTQOFkCl9hltuvWQRPORMGwXSAVvQaSYFEj cT5yRnj8+yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfdmEwAKCRCPgPtYfRL+ Tu8hCACpDquxqwbpdvKPAX/vz7ulv7aFcH25NgqtFXF6p8zu0AZZC+Wswk7hzAfwFb5F5USnqNm gbYkpbMLUUspazJvo4Hg6MTBK4ievd3U49DSl08ewTQ43bt/v0GgxHy8vInkCV/gj8Xae4e45WU X06nYnEIE6FqjAZ5klzHgehS7Pqp8ymnlFMZ6tpInbNYG0mnMNL5YmjtGJQ8scrMAsj53YvR5PJ WFCeqZ96g/4bUKeKo3ZtgeMLWF9WjstBhaza0xbODMDAfB7WgL9NOOnr3SqHOa93RDiG+NG2R75 4p4FHzGaI//h4LHMMrbk1/Ap+b14PrF6uUA8IgtmU3NcPdUz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

stm32_pwm_config() took the duty_cycle and period values with the type
int, however stm32_pwm_apply() passed u64 values there. Expand the
function parameters to u64 to not discard relevant bits and adapt the
calculations to the wider type.

To ensure the calculations won't overflow, check in .probe() the input
clk doesn't run faster than 1 GHz.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index fb714936ff8f..b20d43408e61 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -309,17 +309,18 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
-			    int duty_ns, int period_ns)
+			    u64 duty_ns, u64 period_ns)
 {
 	unsigned long long prd, div, dty;
 	unsigned int prescaler = 0;
 	u32 ccmr, mask, shift;
 
-	/* Period and prescaler values depends on clock rate */
-	div = (unsigned long long)clk_get_rate(priv->clk) * period_ns;
-
-	do_div(div, NSEC_PER_SEC);
-	prd = div;
+	/*
+	 * .probe() asserted that clk_get_rate() is not bigger than 1 GHz, so
+	 * this won't overflow.
+	 */
+	div = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
+				  NSEC_PER_SEC);
 
 	while (div > priv->max_arr) {
 		prescaler++;
@@ -351,9 +352,8 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 
 	/* Calculate the duty cycles */
-	dty = (unsigned long long)clk_get_rate(priv->clk) * duty_ns;
-	do_div(dty, prescaler + 1);
-	do_div(dty, NSEC_PER_SEC);
+	dty = mul_u64_u64_div_u64(duty_ns, clk_get_rate(priv->clk),
+				  (u64)NSEC_PER_SEC * (prescaler + 1));
 
 	regmap_write(priv->regmap, TIM_CCR1 + 4 * ch, dty);
 
@@ -659,6 +659,17 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	stm32_pwm_detect_complementary(priv);
 
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to lock clock\n");
+
+	/*
+	 * With the clk running with not more than 1 GHz the calculations in
+	 * .apply() won't overflow.
+	 */
+	if (clk_get_rate(priv->clk) > 1000000000)
+		return dev_err_probe(dev, -EINVAL, "Failed to lock clock\n");
+
 	chip->ops = &stm32pwm_ops;
 
 	/* Initialize clock refcount to number of enabled PWM channels. */
-- 
2.43.0


