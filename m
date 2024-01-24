Return-Path: <linux-pwm+bounces-902-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45783A3CA
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 09:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9008C1C293D7
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558081754D;
	Wed, 24 Jan 2024 08:12:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A8168DA
	for <linux-pwm@vger.kernel.org>; Wed, 24 Jan 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083960; cv=none; b=ZrV2UMWukVCI47qbQgIhiFg3LT840SJ5NU9vS1buAtRC5goowskn5CUOI3Qjjul0fYDBxWLw0G7/O6J5SEqoCe8cwnsrs+4cesIqVF/f0FIqzxI6+QVprKqjegN34qIbQ/URudwbhml3xF5n9Ve2kWwm/xcIi1sTKq4gh6/HiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083960; c=relaxed/simple;
	bh=61dg6kJV4BhcvrrnMUjQLyQd3kNaWCq2zXIx0/k9U3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppCs8o/Cqzyte+s2b/aalLpT9Fc5zo5ms9BF2BR8SR77r/I/7cKwC6AkeFEItNU2UKY7MWCmj/AdLUskW8oxeovjBc05pMsOc8neicbxnWbGIBJkn2edyI1Zrg21Cslyss9tR5M2GNRsUXzALI0j2/Tqhy6EzhUKN7Bt3fzmkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYN2-0005Lx-2P; Wed, 24 Jan 2024 09:12:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYN1-0020vP-LW; Wed, 24 Jan 2024 09:12:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYN1-006z9q-1s;
	Wed, 24 Jan 2024 09:12:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Subject: [PATCH v3 1/2] bus: ts-nbus: Convert to atomic pwm API
Date: Wed, 24 Jan 2024 09:12:04 +0100
Message-ID:  <4c9621d72bf6a7dc427e174edde6c1b0ae7a0469.1706083174.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706083174.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706083174.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=61dg6kJV4BhcvrrnMUjQLyQd3kNaWCq2zXIx0/k9U3g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsMZWF1DSFYTy/INHYTUKoolpuICB1d242jI87 XOdP26vtgKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbDGVgAKCRCPgPtYfRL+ Trt9B/9HFBycopmSADO6lpJHTnQ20qenZLqzsmvUa84D1ZL7gwQf47ei1LsQ+Gf1DcK3ZGISEvV H2IEJP1EjCK91kw89jA6+fAZDbi9Pykcn81RWh+HUW/j/gu4vN4dA6Xk1c6jHhh17STC9pKRRLV MoOFea5PsBonii9uCaW1McyGVG5pjz3Z30AB6iI0RgmQYHUwvDUsdGKYJEJdzlEDNhWgQWHtlrQ ei6rVQC72wn4lHqcPQW90BiUfM+wWo3vnJ3Z9jbkON/j3pJSduk63ncCl2Ws/dM6cB39DiyM/6a /bxFNr/q2o+IT8dYsFRr9kIn0UMHJw7kOpq+2brfK8Y9Wque
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


