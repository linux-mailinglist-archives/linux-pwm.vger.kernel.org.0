Return-Path: <linux-pwm+bounces-969-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71C83C1C4
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E35290D38
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB24502B;
	Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C323F8CA
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184650; cv=none; b=u2TVw7RXWy9Rnc3Z9nWNvmfzcw8EC62VgNe4YOL2+w6e8YzzKQ//rxVx75W7IJlvfGXmYsR0A5Vs22RJcPK+sQ/xtsfIk0l4HUV9m4IHzyveVkLN4pJULgY2F4MQEpBIVpySMJ8WvkpPx7Lu8Ce2amo6iZzdHn1JW1Rby7lwdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184650; c=relaxed/simple;
	bh=DYvqfTqENk16A4KlpGQN9yUJm5r3OjrI/v9vK4Lp4UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB/BJTSqVbQnlvqV3Pz0RRi8A1DB578xJQiiGSlsxBlHpae9MaUKceW3SZ+m9vGQj8g8ggubUoE/DaSrMMRCiBtc/vW3CVLISAdw82yUNMRqimWauUWSDamSh3DO4Ibs83Bz8DOw1gIKWhqKI2hbuvGfJDtJJKrBB/yOufz5MmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-0003ov-3u; Thu, 25 Jan 2024 13:10:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZB-002HQQ-7O; Thu, 25 Jan 2024 13:10:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZB-007mzt-0U;
	Thu, 25 Jan 2024 13:10:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-pwm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 027/111] pwm: sifive: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:49 +0100
Message-ID:  <6987fafe69071c2f91a19b79a688c51f38be3853.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=DYvqfTqENk16A4KlpGQN9yUJm5r3OjrI/v9vK4Lp4UE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9Z6WxidC+q10uGRzkSEunktXEDpLIL3nt/9 OECs9SYk8eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPWQAKCRCPgPtYfRL+ TnxpB/4myeH3GhvtWa4I8obN5rm2g+L040e/o3EReiWARmsV9z97K0W0vp2mOOEsMXcGFYJJhOH NQGhfRkwcDm/nnKH/WcXUpv9x1Vgk8ib5lZLN7pDSVNnoYuGRozomv2i03XnNBwuhfKrl/0KE6n eVhM7CAbiSdnZAReuf0PSeVaezi4Qlpob7bYbhfKCOd3xTOeSVVTl0qVO6aaG7U/978BFCFPd69 QlX9WWBRXUP/uCgkvU2VCDuLY2KTp3y44DV9e9228hRac1I2Fkx9K7umEH/sUSd49TaKZ8Vsafm RsiURvhQ/jagsgfRbZQJmA83n/bthqd0cOptez2nJyP9I3Or
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 089e50bdbbf0..c1b412905d9e 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -102,7 +102,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
 	ddata->real_period = div64_ul(num, rate);
-	dev_dbg(ddata->chip.dev,
+	dev_dbg(pwmchip_parent(&ddata->chip),
 		"New real_period = %u ns\n", ddata->real_period);
 }
 
@@ -185,7 +185,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!enabled) {
 		ret = clk_enable(ddata->clk);
 		if (ret) {
-			dev_err(ddata->chip.dev, "Enable clk failed\n");
+			dev_err(pwmchip_parent(chip), "Enable clk failed\n");
 			return ret;
 		}
 	}
-- 
2.43.0


