Return-Path: <linux-pwm+bounces-1115-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCD8400B3
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jan 2024 09:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C741C225F1
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jan 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A121654BEB;
	Mon, 29 Jan 2024 08:56:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5991DFCB
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jan 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518600; cv=none; b=enDa5yY9pF8Faf5ZT+sUXwT4MyQGHsRkwEAeu7UItK274Q1fUW817nElmRF+cK0BK+EL3xf4tPzs6jDMJuhJvOF2bb7n1qoFn6+9pyNLjmI2P8x+Pr+o6z2zRTLQ9FZ8uPyONs0r4o4AMcZZbEV2qSE1zUpvzCL0RTeHVFCqbQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518600; c=relaxed/simple;
	bh=JHogV1trNXAXd7KQiAOevqso4YRtz3t2b9NmFznYtGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IZTXaCK5VbcJ9PiRnjEcZ6MaCcVPS7WvrvETqaVK6n3QSGiXBB96jkv4ajujnnYEfte1rnTdVauV/0XaUbAL/7avtkaq4jaDsEF834/ZuaosDlNlAP16TZ0bJAWTDK6bpuEWo9YsukZJqyyz2cCKG/GH4+wx4eRPc9Zk1scFZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUNRP-00025t-D5; Mon, 29 Jan 2024 09:56:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUNRO-00381G-Fj; Mon, 29 Jan 2024 09:56:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rUNRO-00Ak4t-1H;
	Mon, 29 Jan 2024 09:56:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: atmel: Don't use pwm consumer API
Date: Mon, 29 Jan 2024 09:56:25 +0100
Message-ID: <20240129085627.2386470-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JHogV1trNXAXd7KQiAOevqso4YRtz3t2b9NmFznYtGk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlt2g74GFyPCTtWB/ohcWS27hDSdZBbmGSsC8Kg xE/aBX1ZDCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbdoOwAKCRCPgPtYfRL+ Til8CAC3Y3MGZLlsJCB0Huk4NCSnFKJtk2BVRbqC9NuklecvhAmuVhzUKC1lwWN5HEJ2kUDWYtu Nt+5V6Epb+yzfKSY1Q7g1tl1yFMoB2mSj66ESVnG5PASUGC50O0C8cvbchASq5XfwODnbCWG417 4HA85oFfubvYsG0Qn9iTSF3ltlAj1E+myVU833Q4YLn6u8poZIIJQRlsLorFdDAlOyzy4MBs3uV 89FC0aur9bKdeMC8BI0VQLf+fi1A0Q9T3Ex1p93Q9wu24Uy5ffHQ4ZYEuLYMavly2ZZrgubU+CW ydR/igSO1tZGhWA6RN34YGM7u1wa5Ai7hj45kbuVc3HwC0Aq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Lowlevel driver callbacks are not supposed to use the consumer API
functions. Currently this works, but with the upcoming locking changes
this probably results in dead locks.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 47bcc8a3bf9d..26573829e391 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -294,19 +294,16 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	struct pwm_state cstate;
 	unsigned long cprd, cdty;
 	u32 pres, val;
 	int ret;
 
-	pwm_get_state(pwm, &cstate);
-
 	if (state->enabled) {
 		unsigned long clkrate = clk_get_rate(atmel_pwm->clk);
 
-		if (cstate.enabled &&
-		    cstate.polarity == state->polarity &&
-		    cstate.period == state->period) {
+		if (pwm->state.enabled &&
+		    pwm->state.polarity == state->polarity &&
+		    pwm->state.period == state->period) {
 			u32 cmr = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
 
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
@@ -328,7 +325,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		atmel_pwm_calculate_cdty(state, clkrate, cprd, pres, &cdty);
 
-		if (cstate.enabled) {
+		if (pwm->state.enabled) {
 			atmel_pwm_disable(chip, pwm, false);
 		} else {
 			ret = clk_enable(atmel_pwm->clk);
@@ -348,7 +345,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
 		atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
-	} else if (cstate.enabled) {
+	} else if (pwm->state.enabled) {
 		atmel_pwm_disable(chip, pwm, true);
 	}
 
-- 
2.43.0


