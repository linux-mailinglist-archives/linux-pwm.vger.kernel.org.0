Return-Path: <linux-pwm+bounces-1089-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349FF83D839
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FE92A42F0
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 10:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C371DA23;
	Fri, 26 Jan 2024 10:16:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1D1DA22
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264199; cv=none; b=tohyv75Ess8o1lMuejMny2oHQVWvSwrfWvHs8geEDX+aF02AILcRzIE2Q65s24PevzocQ541TT303i+2VnrBUV4OZt1rAmG1dD14Kh0X4PHSXgFeNfGXwKKcnIKj+UBdmZ2fVtmfjMmVII721xsvfvMIaAkoUSp4dmQkDYN2eX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264199; c=relaxed/simple;
	bh=fjbKOVG66+WxbaK9GxsYY+6eRxG1cctV5fyQikmboFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p9DzKTKdc/LzRmnx4U5xGh27CCPf48fpOt3tKbHdaHARoFun6hzqVArwOC9uQ63v+toEpS0UdO+MmI2UaMjLMzjEOetQPq991N67AWmicKhCvBtgoKSokNjKvmi4PyPTqXrCWWwKLVfYjeQmQESKmr44gKFD84uw6eBQIG5wDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTJG9-0002pn-4U; Fri, 26 Jan 2024 11:16:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTJG8-002UII-HG; Fri, 26 Jan 2024 11:16:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTJG8-008XkV-1R;
	Fri, 26 Jan 2024 11:16:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] pwm: imx27: Don't use pwm consumer API
Date: Fri, 26 Jan 2024 11:16:25 +0100
Message-ID: <20240126101624.2056801-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fjbKOVG66+WxbaK9GxsYY+6eRxG1cctV5fyQikmboFo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBls4Z4XBs/VXfbME39KMjJKVqYE32p1EC7kp1cK +MUWqD7EO2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbOGeAAKCRCPgPtYfRL+ TrX0B/4lJDRuTc51EmpO8AwB+9bXH3uNVa7me0Bi7vKdMi0fctoIISv2phyWh7yXb702QLy2BR2 BcRXCdGXSXghFPvpwoJWpHeaJ93pR+iPoJokzKQBACcSjKqhm5WHkIcN8YYYOY52VR96F+yBr2m 35kzhh7KsQDPPACgKm37ynIgUjNN7kl1JYeA4Pe8W1t8Yrt/YYWKu4LdiI9P+LvFYHld08Ex4eL 8ec+j7Mb1LWEqr0jvwtDgSU+zffADY6HIOTAyAp+WrP9smT5OWa6IPPVMylcS2BsuCwDD7+Rs+7 /GatuZAd+YArn6wW1jfItJkcj4COeV9VAIGLZle+3epC3Pma
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Lowlevel driver callbacks are not supposed to use the consumer API
functions. Currently this works, but with the upcoming locking changes
this maybe results in dead locks. So directly access pwm->state.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..c825d3bcb329 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -204,8 +204,8 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
-					 NSEC_PER_MSEC);
+		period_ms = DIV_ROUND_UP_ULL(pwm->state.period,
+					     NSEC_PER_MSEC);
 		msleep(period_ms);
 
 		sr = readl(imx->mmio_base + MX3_PWMSR);
@@ -219,14 +219,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	unsigned long period_cycles, duty_cycles, prescale;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct pwm_state cstate;
 	unsigned long long c;
 	unsigned long long clkrate;
 	int ret;
 	u32 cr;
 
-	pwm_get_state(pwm, &cstate);
-
 	clkrate = clk_get_rate(imx->clk_per);
 	c = clkrate * state->period;
 
@@ -254,7 +251,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
 	 * the FIFO if the PWM was disabled and is about to be enabled.
 	 */
-	if (cstate.enabled) {
+	if (pwm->state.enabled) {
 		pwm_imx27_wait_fifo_slot(chip, pwm);
 	} else {
 		ret = pwm_imx27_clk_prepare_enable(imx);

base-commit: 7be3ba1e5644170feb2cb587860015de97fc7d8a
-- 
2.43.0


