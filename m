Return-Path: <linux-pwm+bounces-644-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391E81E1F6
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Dec 2023 19:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A501F220E2
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Dec 2023 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752853E1C;
	Mon, 25 Dec 2023 18:13:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B3537EC
	for <linux-pwm@vger.kernel.org>; Mon, 25 Dec 2023 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS2-00024Y-Ur; Mon, 25 Dec 2023 19:13:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS0-001TaU-OR; Mon, 25 Dec 2023 19:13:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpS1-000xT8-2T;
	Mon, 25 Dec 2023 19:13:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v2 1/2] bus: ts-nbus: Convert to atomic pwm API
Date: Mon, 25 Dec 2023 19:12:52 +0100
Message-ID:  <ca6d8b6de73ac4b2b612b04eb8ea85cdc3aebc0e.1703527372.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703527372.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703527372.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=61dg6kJV4BhcvrrnMUjQLyQd3kNaWCq2zXIx0/k9U3g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlicYrApVp2AghnOZRenfLlyNCDj11FmxSGu9Tm SyzdkyY+PeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYnGKwAKCRCPgPtYfRL+ ToNKCACAbl7r+yqdYqOTwZnl/WI1HPX8dJjgKDztfwqjRdX289u0rz3IxHS+WV3yldixYTSV/zD cAzGJxECh7drgCgzQG89WyYnL3Jm71lmEqD/ax77fxCcWWHVCqvgTIOz6Jp9Bu8cpSL3NQ5iUzM lP9IoTAmIz0nXyZEJKgW80W/K7c3XI6N35mYz9N1xoqVOdvoluXCvOPywN2lxPIy1dNvt/tRL0g m2Z+HhGb0c2+oaU1fWh6Wezew7lVtOzxq7R1/UmwRJcMby79Y8tRkaRjt1kU3aZ94E6ZThG2q3H F6DyWXl20cCqaMPIkmwMkhJNODzL3oFKGFrnmn98IwRnJQv4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

With this change the PWM hardware is only configured once (instead of
three times).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/ts-nbus.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 4fa932cb0915..19c5d1f4e4d7 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -273,7 +273,7 @@ EXPORT_SYMBOL_GPL(ts_nbus_write);
 static int ts_nbus_probe(struct platform_device *pdev)
 {
 	struct pwm_device *pwm;
-	struct pwm_args pargs;
+	struct pwm_state state;
 	struct device *dev = &pdev->dev;
 	struct ts_nbus *ts_nbus;
 	int ret;
@@ -296,25 +296,22 @@ static int ts_nbus_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pwm_get_args(pwm, &pargs);
-	if (!pargs.period) {
+	pwm_init_state(pwm, &state);
+	if (!state.period) {
 		dev_err(&pdev->dev, "invalid PWM period\n");
 		return -EINVAL;
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(pwm);
-	ret = pwm_config(pwm, pargs.period, pargs.period);
+	state.duty_cycle = state.period;
+	state.enabled = true;
+
+	ret = pwm_apply_state(pwm, &state);
 	if (ret < 0)
 		return ret;
 
 	/*
 	 * we can now start the FPGA and populate the peripherals.
 	 */
-	pwm_enable(pwm);
 	ts_nbus->pwm = pwm;
 
 	/*
-- 
2.43.0


