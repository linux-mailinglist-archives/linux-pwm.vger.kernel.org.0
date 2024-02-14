Return-Path: <linux-pwm+bounces-1316-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E831885457D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A470D2873FF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5091642A;
	Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A61755E
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903264; cv=none; b=lxTb3zSOpZ4gsCAGrPguwUAk76HgLY+mgFgRTzsQW1+vJzilFtfM78kC1HhFdTZOMS2i6akO4dSVc1/I99dnTE5y0RbkJlVl/I9LYzpN9KprlucyYTmbg3YLzSvM5vxIWDhO9JFha2JZ2s+kRAdnSFdBKT+4YJl45IGhssydFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903264; c=relaxed/simple;
	bh=23C0zswHFbohCvcAG64YSEJS8Mf75jYiZ0e59VSUXJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnoAezrrIhqDTXBwWuWdRVmLQ88O9sBpI9uQXn7G6HrDwGvAdALuRYy/lPCw8Sc4Pstz+W6I0ArFjHxbKW7l7/IbB616ENsuZniRSDC2WyGDyk9m0sWFEc2Cv7te++gaTF8rhWs51r1Vc8rUXgRSllOgNAKEcJ++FWWS+sCym8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-0004On-J5; Wed, 14 Feb 2024 10:34:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-000f7C-64; Wed, 14 Feb 2024 10:34:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-004Y0F-0L;
	Wed, 14 Feb 2024 10:34:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 009/164] pwm: atmel: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:30:56 +0100
Message-ID:  <f8ca10033204111e4eb2e7a4dad0bd1f7586c735.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=23C0zswHFbohCvcAG64YSEJS8Mf75jYiZ0e59VSUXJs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhV/W2P+HdgVcZyMYogjnFY0gx1xBm8GEPrC gxgZWUsezaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIVQAKCRCPgPtYfRL+ TnNACACPKROLmSTvBrx/ljyGq2XQpSZvl+A2g+nTl4ucQqryKvHGMNd0e0wmUtUxMI5qGrmP/MH IfpSzly1LPlgOJXoicaTHZfOxXOw+B5Mi2JditW1pe1gXIQODI9zGjKESHzgyzyQ1av2Z0nGI9L vOQ09WYVTt5BWTpGDaY/TRM+AXg5u647fp/Df7aM5644tXWzih7S/2dwHFp2rju9cCDWHNFP2yt v6V/864IVbRG327vnxkGeUPprbg1tmASowLs9vU9wgP/EAvI7c9sY9V8EmaELEQWYOpZ/Zz9c45 pYHpudXs95L8SiN4mvga7Ap58ot+0vlrZ8LJS0rFWwNQEGZd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 2f7d6c43be85..96e1676a5c51 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -210,7 +210,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	shift = fls(cycles) - atmel_pwm->data->cfg.period_bits;
 
 	if (shift > PWM_MAX_PRES) {
-		dev_err(chip->dev, "pres exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");
 		return -EINVAL;
 	} else if (shift > 0) {
 		*pres = shift;
@@ -321,7 +321,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = atmel_pwm_calculate_cprd_and_pres(chip, clkrate, state, &cprd,
 							&pres);
 		if (ret) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to calculate cprd and prescaler\n");
 			return ret;
 		}
@@ -333,7 +333,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		} else {
 			ret = clk_enable(atmel_pwm->clk);
 			if (ret) {
-				dev_err(chip->dev, "failed to enable clock\n");
+				dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 				return ret;
 			}
 		}
@@ -481,7 +481,7 @@ static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to enable clock for pwm %pe\n",
 				ERR_PTR(ret));
 
-- 
2.43.0


