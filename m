Return-Path: <linux-pwm+bounces-950-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA783C1B6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DEA290E26
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2743A1B6;
	Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832F3D558
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184646; cv=none; b=CRgi+oHd6WOPKxZevdahJ2ibyTtPI9TXd8/YHR2oHgFC8UWbbF8ebdevkA+D9UwMgJ/9Eicb8GqbPe3CND7HEF0tWjylwnzmdOc+DbKczPy/whovYG9VnwxLQ5Ku70XPz/DeATwkx2Tx2d+WELlYPFEBcvZIdOAuaQD3fNnwwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184646; c=relaxed/simple;
	bh=9fRxhtYIv+8dNdPKFjVdE0/oqwvKrTqfCQCejiapaBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0C8RugFStn8PS4wGO1iRsyOpCRCG6FVqSUcb5NQhg+0wYojhWa2dMrtaWZ2sYzlCx7nZWc/f5S0IXK/cHn+ifwk9Dix2MwHMuVpTzL5X6hEb56QE8rqIO9DqQzyq+Dx4J/pJGlqvHmSUPW7jvmFY1VNnfo/F5nGK9teI+X40hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-0003h5-6a; Thu, 25 Jan 2024 13:10:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-002HPd-On; Thu, 25 Jan 2024 13:10:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-007mz7-2D;
	Thu, 25 Jan 2024 13:10:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	linux-pwm@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v5 015/111] pwm: jz4740: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:37 +0100
Message-ID:  <b23bd3235e04e6181dac8d3309d33330a59bc72d.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9fRxhtYIv+8dNdPKFjVdE0/oqwvKrTqfCQCejiapaBs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9LDBRXb8V16ytbBWxUdPjO9nZMbBylJRyeM 16GDgKhSbaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPSwAKCRCPgPtYfRL+ Tq1nB/42yj6g2AGGySh52gqicZ1X/F+l4Nq3rpjyws8RAb443ENalaB3xiW/b4K1potNlUxT38p iTlsMElU2AmS0V9ZrK9kArWxKbKgD3TG/D6YIBOJa4mfSYkbNNzMtAURPEB1iSjSYHqHruhrIwK 9tnyueWm2DqXLTKiBWSnTb8QEG2mv0pFAFFzOUROufKCumFpZS3pJwMo60I3Sq28MySSP+mZ7MX +eAymzTF1FKOb7E3jKeQ5ZXTc97k+PgaZAd94Z79WzdzjVf+r/viTnCkNA2j7FHqiEeiAx6ozBT MMPFaFT6eeysZ5klt/xvP5ua7uIfmRSuuCRkxd36KPm36YpO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3933418e551b..4d39f61b86ff 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -35,13 +35,12 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 	return container_of(chip, struct jz4740_pwm_chip, chip);
 }
 
-static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
-				   unsigned int channel)
+static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
 {
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
-	u32 pwm_channels_mask = GENMASK(jz->chip.npwm - 1, 2);
+	u32 pwm_channels_mask = GENMASK(chip->npwm - 1, 2);
 
-	device_property_read_u32(jz->chip.dev->parent,
+	device_property_read_u32(pwmchip_parent(chip)->parent,
 				 "ingenic,pwm-channels-mask",
 				 &pwm_channels_mask);
 
@@ -55,14 +54,15 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char name[16];
 	int err;
 
-	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
+	if (!jz4740_pwm_can_use_chn(chip, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
-	clk = clk_get(chip->dev, name);
+	clk = clk_get(pwmchip_parent(chip), name);
 	if (IS_ERR(clk)) {
-		dev_err(chip->dev, "error %pe: Failed to get clock\n", clk);
+		dev_err(pwmchip_parent(chip),
+			"error %pe: Failed to get clock\n", clk);
 		return PTR_ERR(clk);
 	}
 
@@ -150,7 +150,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	rate = clk_round_rate(clk, tmp);
 	if (rate < 0) {
-		dev_err(chip->dev, "Unable to round rate: %ld\n", rate);
+		dev_err(pwmchip_parent(chip), "Unable to round rate: %ld\n", rate);
 		return rate;
 	}
 
@@ -171,7 +171,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_set_rate(clk, rate);
 	if (err) {
-		dev_err(chip->dev, "Unable to set rate: %d\n", err);
+		dev_err(pwmchip_parent(chip), "Unable to set rate: %d\n", err);
 		return err;
 	}
 
-- 
2.43.0


