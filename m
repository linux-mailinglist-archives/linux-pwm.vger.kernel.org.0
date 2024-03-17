Return-Path: <linux-pwm+bounces-1790-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940C87E087
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE121C20C0A
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10F20B0E;
	Sun, 17 Mar 2024 21:52:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC80208D7
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710712360; cv=none; b=gHmg4SaKpN0JMPdZtFYwi/RGO5VYVpKoQbrUEZJA1LMnCqvH7Z7naL4ZXDIJXquLyl0Lfzb+pvfrXlGmOIYgLU47Jh1m3qryXx/5rhe1djngDy7/iNis9ZF/qDfC0i5pcdIRXMrUzVjIqwkebIwzm9UQ/EIzlfJ1zemibKl/LzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710712360; c=relaxed/simple;
	bh=rEQVgXxWi/ELpI3VBppPiQpewrscwVr8g8zdSA8buoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJ9lrSUy+3GwsI81AWZJgD3xQaI1cHxkpPabFUVSozKf2uTGHyfi/bGlvn/TGrZWgD2pBQS6HfQBAbseleWk1R/4BtwVnaLAF+AMoR99LycWjvdM5upUzSz19az7HUfhBMJpPnCVArLL4JBveu+xQ6hHT/zN/2Ot3hoWBw9sbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQk-0002kn-4u; Sun, 17 Mar 2024 22:52:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQj-006xGq-2A; Sun, 17 Mar 2024 22:52:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlyQi-007fnz-3A;
	Sun, 17 Mar 2024 22:52:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 1/3] pwm: stm32: Improve precision of calculation in .apply()
Date: Sun, 17 Mar 2024 22:52:14 +0100
Message-ID:  <7628ecd8a7538aa5a7397f0fc4199a077168e8a6.1710711976.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rEQVgXxWi/ELpI3VBppPiQpewrscwVr8g8zdSA8buoQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl92YScoxX1h3+nr521TOsRmlHYsPPfgDdPHW8Q pC6dqgrkMSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfdmEgAKCRCPgPtYfRL+ TiP+CACXUE7O4GXr8UzfgtBC/6Wj+KUUjMdf1rrenLU1/M/tMQE9nNEhyU9e9Pn1aFfYPGIodc6 E9Xy0xx7eXfbvQ7bJ+R3sreGbcCWPe+4ROfwti7Xo4iV2o7gkazSz6uboiLSWmuXKZNhR6YbRTJ 1eq25Ap59RyJlPchI6cZ2kUcFryfuTVn2CnYra4lRrOf3qPulR7R6ls2ZUqLxHihICreugwz9aN idiAbN6XqvN6fZxf4YtwIGwdNich/7kuuPi8TVyKX7V0qNba0Av5185vvcDzE2/UXFvWoSw3Ovh 84BYlrhbjAu2uIAZn8Isuwu+zoYN8BIeP9iJ3STNeMRdIGHl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

While mathematically it's ok to calculate the number of cyles for the
duty cycle as:

	duty_cycles = period_cycles * duty_ns / period_ns

this doesn't always give the right result when doing integer math. This
is best demonstrated using an example: With the input clock running at
208877930 Hz a request for duty_cycle = 383 ns and period = 49996 ns
results in

	period_cycles = clkrate * period_ns / NSEC_PER_SEC = 10443.06098828

Now calculating duty_cycles with the above formula gives:

	duty_cycles = 10443.06098828 * 383 / 49996 = 80.00024719

However with period_cycle truncated to an integer results in:

	duty_cycles = 10443 * 383 / 49996 = 79.99977998239859

So while a value of (a little more than) 80 would be the right result,
only 79 is used here. The problem here is that 14443 is a rounded result
that should better not be used to do further math. So to fix that use
the exact formular similar to how period_cycles is calculated.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index ffe572b76174..fb714936ff8f 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -351,8 +351,9 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
 
 	/* Calculate the duty cycles */
-	dty = prd * duty_ns;
-	do_div(dty, period_ns);
+	dty = (unsigned long long)clk_get_rate(priv->clk) * duty_ns;
+	do_div(dty, prescaler + 1);
+	do_div(dty, NSEC_PER_SEC);
 
 	regmap_write(priv->regmap, TIM_CCR1 + 4 * ch, dty);
 
-- 
2.43.0


