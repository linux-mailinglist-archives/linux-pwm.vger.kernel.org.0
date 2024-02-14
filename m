Return-Path: <linux-pwm+bounces-1436-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CE7854603
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B626C28A7E9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD815134B7;
	Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075A1AAB9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903289; cv=none; b=tS/AaaxroRzVvMchUkWmYfT/qkUxp3Le7whwGx/U8gpkWeXmBZ7HvMrHsjW2KT9+0tZrnKylgByNze/vN18pWSnXAVBil6P5jkdZura67GCGbUZrqCOV2qbrSvleSCK24RzT19hE8sGp3F1f1drBykt5x2m0jkFw7JLDfztktTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903289; c=relaxed/simple;
	bh=JuNIuFD3c6qnif44oMxmUb/F4xNQLrQPLEXkRb5EGmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taR8Y7MzzS1B9N6nPOsHA5sdtNcdODjBServlVmvbbNEWklITp5juYN9yE1P94rou8g9kfQsuZMMxfvcxIiK60873skSQfhSFSe10wbaPbBNSfJ51Ab4nA1sTvObycJfjy8SZh4m8uFItzoiJx6Q4T5hTw1BkskKhw3uCtJUIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-0005oV-DH; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-000fGA-A6; Wed, 14 Feb 2024 10:34:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-004Y7t-0k;
	Wed, 14 Feb 2024 10:34:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 120/164] pwm: stm32-lp: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:47 +0100
Message-ID:  <d79148ed49389c657b72df05758032be2b516ceb.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JuNIuFD3c6qnif44oMxmUb/F4xNQLrQPLEXkRb5EGmU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjVynmgDVimgALzofCoefgRqxjoLBMzDm0q4 BFybHUdSlKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI1QAKCRCPgPtYfRL+ Thj0B/9IxCbgrkAdV5rjSFQDUYgZsFWWSrgYuSRJhnVLmxRbQ5kyeQtq18sDsG3cnfT9QHycDcF lGalFo47OkBmtNJrP5nqjMJGQurX5ud2ENkNSCbf2t2+ESWKaMmmc9jJeo6pWKp6GAWxKrxdqjW NGNoMg2jNk28RQLI8AGd7Bs/3hq8AOFfaSpRJ3CgnhtrXf/s9dMg0EMfKSg802+WGy53TndqA5k ZeocdsiUev4PMGe9fgY6hmfmUpULm3y8Um/N1i/biuXseuAuf0Z58QNreroE+YVBpsUcXi/Jvak G4i0YCbZr0HFNWlHbxXW27TdMIpIMm8IA555DwzvoYUB/NG2
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
 drivers/pwm/pwm-stm32-lp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index b46d8193dd0f..958043bc5c92 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(chip->dev, "Can't reach %llu ns\n", state->period);
+		dev_dbg(pwmchip_parent(chip), "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
@@ -69,7 +69,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
 		if ((1 << presc) > STM32_LPTIM_MAX_PRESCALER) {
-			dev_err(chip->dev, "max prescaler exceeded\n");
+			dev_err(pwmchip_parent(chip), "max prescaler exceeded\n");
 			return -EINVAL;
 		}
 		div = prd >> presc;
@@ -130,7 +130,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret) {
-		dev_err(chip->dev, "ARR/CMP registers write issue\n");
+		dev_err(pwmchip_parent(chip), "ARR/CMP registers write issue\n");
 		goto err;
 	}
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
-- 
2.43.0


