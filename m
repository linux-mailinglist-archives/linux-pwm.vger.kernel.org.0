Return-Path: <linux-pwm+bounces-1792-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0C87E08A
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 22:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D7280D9F
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2703208CA;
	Sun, 17 Mar 2024 21:52:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5641B7F7
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710712361; cv=none; b=bVMwsI6KvzrsOzZwg6vcnSBVq9ivpOgmpXLRgsw0OMU2OOugZsT7My8nq2d5gPA6jG58m4zXRbFM6VeFUZ1hhsi27SGva5iy5rMOxiJELYidEdSplyVYuIothJzp5VDUYn2P/Z8UjGOXzkrm1N9EBGZwp+RYT+gJGbO9zuJHXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710712361; c=relaxed/simple;
	bh=+gWyc/Xr/gKt2ssnUmtJ3znJ8evskyjFlYjxtuQFMak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYQ9VQNKNdMsS7mc4F3w5Cw7YodPyn8t8kzaidhoBqCDNQEKTE3bM1ziFKBkvai59Kum3ndhVN25jze4o5qhUJZc7nUbASiNA7XVYqKXofzyC8pVnosdQ4FyWdf67yy6h/u4SPfxxWzQ5TBhcrozB2Yq91qmOzWPhRvb7BPTuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQk-0002kp-4u; Sun, 17 Mar 2024 22:52:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQj-006xGw-EU; Sun, 17 Mar 2024 22:52:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQj-007fo7-1A;
	Sun, 17 Mar 2024 22:52:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] pwm: stm32: Calculate prescaler with a division instead of a loop
Date: Sun, 17 Mar 2024 22:52:16 +0100
Message-ID:  <498a44b313a6c0a84ccddd03cd67aadaaaf7daf2.1710711976.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+gWyc/Xr/gKt2ssnUmtJ3znJ8evskyjFlYjxtuQFMak=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl92YUyRkkcP0unmpy4kqNjkBTg3KN6NxlE50gB egGrTLT8IWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfdmFAAKCRCPgPtYfRL+ TpFGB/9urgmvkMV9IFZToy3OTLf3mepNXYqCUGpkeRpS9GWqA3c/yZqMGEorYh4Y7C1udikWjCw VYV3KAvGRAF9i56fRD5kpGDDoF9AeZh2ikZjCw2Ge3rnAxNQPxRzZ6WuXN0rl5qXUdC0Vvh1yDj CP5/EYj/9NL4Bgqpi9s5UeziZCpjOpJLcJjxk6momz1zko18AR8IUWkrVSgWts5AuhfOO1lJlQJ 4YaXMlS/aFLJfJPQjNmrYsUH/iJ2CGcZFTlLAm3nBD8BZDbM/eO/g/1k9hOJhSkHw521KlXvN6v iEBTzrPLRdX4xyfWlO/+G7V3w4b+DvI23bfK7DGzD4RMXiYE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Instead of looping over increasing values for the prescaler and testing
if it's big enough, calculate the value using a single division.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index b20d43408e61..a2f231d13a9f 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -311,28 +311,33 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 			    u64 duty_ns, u64 period_ns)
 {
-	unsigned long long prd, div, dty;
-	unsigned int prescaler = 0;
+	unsigned long long prd, dty;
+	unsigned long long prescaler;
 	u32 ccmr, mask, shift;
 
 	/*
 	 * .probe() asserted that clk_get_rate() is not bigger than 1 GHz, so
-	 * this won't overflow.
+	 * the calculations here won't overflow.
+	 * First we need to find the minimal value for prescaler such that
+	 *
+	 *        period_ns * clkrate
+	 *   ------------------------------
+	 *   NSEC_PER_SEC * (prescaler + 1)
+	 *
+	 * isn't bigger than max_arr.
 	 */
-	div = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
-				  NSEC_PER_SEC);
 
-	while (div > priv->max_arr) {
-		prescaler++;
-		div = prd;
-		do_div(div, prescaler + 1);
-	}
-
-	prd = div;
+	prescaler = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
+					(u64)NSEC_PER_SEC * priv->max_arr);
+	if (prescaler > 0)
+		prescaler -= 1;
 
 	if (prescaler > MAX_TIM_PSC)
 		return -EINVAL;
 
+	prd = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
+				  (u64)NSEC_PER_SEC * (prescaler + 1));
+
 	/*
 	 * All channels share the same prescaler and counter so when two
 	 * channels are active at the same time we can't change them
-- 
2.43.0


