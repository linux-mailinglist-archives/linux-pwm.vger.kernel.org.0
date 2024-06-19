Return-Path: <linux-pwm+bounces-2552-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C764690E807
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 12:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F021F232EA
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2024 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77713AD22;
	Wed, 19 Jun 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/e4f2nR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07F136664
	for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791939; cv=none; b=IPHT5P6Djm0MGp6nF5ISuJ8XXGmrUOhjbvJgVCrJtLtt7fX1GOle5yM/HpIWqnAKXvXm3IkFotnPgSHQ+mSZB87botqACOffBE2lXzG5uEM0X7LrPwmE4GFnzC14uHUAgSYfIwTsA86IlsH3N+e9tHoPJwDBSq4BZMn1/i4myt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791939; c=relaxed/simple;
	bh=I3iLNPbAvcDPk6Nw1QUlh23HxzYQPmXbPfOcTvZTTEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe/mpWMq2DPGE+cmP5vdfWHW/5HATSRJ5mO1ryZSajOeoUcJm96/d4B+JZKN81YAxe6AHNxp9lqsFJMefx1CbxbnKZwaX33ShBov5u9h2S+iVM5PDwecMyQ1yW3drSDYvf+BLfLAZQnIwSDiKF7sucE/JdN/nQwlFsSx/Gdh4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/e4f2nR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso8532981e87.1
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jun 2024 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718791935; x=1719396735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy65aQubSD4tbmjRxefZecoIq4GXZIdFH64RPRpuevk=;
        b=r/e4f2nRL/TLpK7+y71IbGd0fozip5whzjgE0EUL/WYPx7edHPslGtRN2K7fW2DtzS
         6R50gqT/WMaCkQhNeiO0z4uu+EErpVgAEOsLAFzOfNmIAyqj7+cE6h2yfpnFSmqjH3F6
         dyurt451EOHx0oKZX+Fzvv3SKaxQV2Xjk65EFqN0UR+dP6+5VE2iLLTrJjFfcdit22nK
         +hnw2cBZrTSyHftlliviRtqJ1N3T4EBkq5VcLwdw8PE/WSZCatOGWSAJQhDbX3I5DJuY
         CYDJodMTtvNiLKZyqg+yDBrE02tAKuDHj2W3ZvU8cgxz/eUniRTpldVz9wZLAFOL21F0
         j0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791935; x=1719396735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy65aQubSD4tbmjRxefZecoIq4GXZIdFH64RPRpuevk=;
        b=qMZMps441sBqHxfKFgQLVdJYXwMyzyJmPJfhhem6UwHHWbIG4dv3erp9kMSRIlxBIN
         F3wcUoYjVXNTzJXllUuiuBo9ZhFP30FT93jG7r59OOtI471S54Zmd+ku0DWSRnCZQ3F2
         dh0Tol1i424HltUBf011riw116DuMavYaGUzz9b5uc2LnOQRY+tgAoRgM5m2HjSFo6zJ
         onQmo9uq6aRW1Tkb6mErvWhQ6BbW1QN6EFwSKHLSC6ngwe8kVrgeSNYte2jA/Ttg9wne
         YlFIzMLyiLAhWxK6AjFfzoArnPzl8i7BLNlQsibByTTgHn0G44/8wB3wjlYuVMb2vs8i
         pHWw==
X-Gm-Message-State: AOJu0YzCGMjKYC/bU15B/sTpU/PLXVRoRj9T45VG2ayJvFv9eoRdaYrX
	joG+la9dfjdMt1dqYzD1ynEZnDRjDXlCBRrs/AZVPfeDxCbcLhnLT1DPCPNcxzo=
X-Google-Smtp-Source: AGHT+IElXV90COGxqoASkehEGVkVUJcHtIY55Qg2BOMAPU5KAnXGT3gOKzusHP31PljuwUXHfU62qQ==
X-Received: by 2002:a05:6512:448:b0:52c:80fb:ee76 with SMTP id 2adb3069b0e04-52ccaa594ecmr1527652e87.58.1718791934559;
        Wed, 19 Jun 2024 03:12:14 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9184sm255060585e9.13.2024.06.19.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:12:14 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: [PATCH v2 5/5] pwm-stm32: Make use of parametrised register definitions
Date: Wed, 19 Jun 2024 12:11:46 +0200
Message-ID:  <d7ef7a6158df4ba6687233b0e00d37796b069fb3.1718791090.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3795; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=I3iLNPbAvcDPk6Nw1QUlh23HxzYQPmXbPfOcTvZTTEE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcq7q8zY1OOIGZ/eP/4KeEUhCpX1HQd4lcfMiE qgoW7JMHLiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKu6gAKCRCPgPtYfRL+ Toq4B/43LSGZu83nHMjrJj4MVPM4vtZms21eY4jgIjU0Gvcs7NtU61MHYKGY3AQOsxCPCNc9EvE t9VLqpH3lK2V4Haw2olqbsodrKWM508IzC24LQtqaqS8f1FqyzXuKaocLu4LYI2GsxUSURmkZh9 wRXRlhUikcxngpax3XlBNCaZ5ciBR68PmvbY+C2R7MgF6K4LkKRFYLr9PvvT9Gizpxp3hfYTAvP k1TXOVJaY2Tjv7E5t+9Advu+4qK49FdWMUpbx+/GfU21s6WTNwPLWCw7Rd14FtsQ/G8ymng3Vux Ga/FXD/DKAYkCorgEQiWt4mZDuWDWL/lOX6/6dpm/p8Lg+zi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There is no semantic change, but it is a nicer on the eyes of a reader,
because

	TIM_CCR1 + 4 * ch

encodes internal register knowledge, while

	TIM_CCRx(ch + 1)

keeps that information completely in the header defining the registers.

While I expected this to not result in any changes in the binary, gcc 13
(as provided by Debian in the gcc-13-arm-linux-gnueabihf 13.2.0-12cross1
package) compiles the new version with an allmodconfig to more compact
code:

	$ source/scripts/bloat-o-meter drivers/pwm/pwm-stm32.o-pre drivers/pwm/pwm-stm32.o
	add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-488 (-488)
	Function                                     old     new   delta
	stm32_pwm_get_state                          968     936     -32
	stm32_pwm_apply_locked                      1920    1464    -456

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index a2f231d13a9f..49a76514b83e 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -360,7 +360,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 	dty = mul_u64_u64_div_u64(duty_ns, clk_get_rate(priv->clk),
 				  (u64)NSEC_PER_SEC * (prescaler + 1));
 
-	regmap_write(priv->regmap, TIM_CCR1 + 4 * ch, dty);
+	regmap_write(priv->regmap, TIM_CCRx(ch + 1), dty);
 
 	/* Configure output mode */
 	shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
@@ -382,9 +382,9 @@ static int stm32_pwm_set_polarity(struct stm32_pwm *priv, unsigned int ch,
 {
 	u32 mask;
 
-	mask = TIM_CCER_CC1P << (ch * 4);
+	mask = TIM_CCER_CCxP(ch + 1);
 	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CC1NP << (ch * 4);
+		mask |= TIM_CCER_CCxNP(ch + 1);
 
 	regmap_update_bits(priv->regmap, TIM_CCER, mask,
 			   polarity == PWM_POLARITY_NORMAL ? 0 : mask);
@@ -402,9 +402,9 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
 		return ret;
 
 	/* Enable channel */
-	mask = TIM_CCER_CC1E << (ch * 4);
+	mask = TIM_CCER_CCxE(ch + 1);
 	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CC1NE << (ch * 4);
+		mask |= TIM_CCER_CCxNE(ch);
 
 	regmap_set_bits(priv->regmap, TIM_CCER, mask);
 
@@ -422,9 +422,9 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, unsigned int ch)
 	u32 mask;
 
 	/* Disable channel */
-	mask = TIM_CCER_CC1E << (ch * 4);
+	mask = TIM_CCER_CCxE(ch + 1);
 	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CC1NE << (ch * 4);
+		mask |= TIM_CCER_CCxNE(ch + 1);
 
 	regmap_clear_bits(priv->regmap, TIM_CCER, mask);
 
@@ -493,8 +493,8 @@ static int stm32_pwm_get_state(struct pwm_chip *chip,
 	if (ret)
 		goto out;
 
-	state->enabled = ccer & (TIM_CCER_CC1E << (ch * 4));
-	state->polarity = (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
+	state->enabled = ccer & TIM_CCER_CCxE(ch + 1);
+	state->polarity = (ccer & TIM_CCER_CCxP(ch + 1)) ?
 			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
 	ret = regmap_read(priv->regmap, TIM_PSC, &psc);
 	if (ret)
@@ -502,7 +502,7 @@ static int stm32_pwm_get_state(struct pwm_chip *chip,
 	ret = regmap_read(priv->regmap, TIM_ARR, &arr);
 	if (ret)
 		goto out;
-	ret = regmap_read(priv->regmap, TIM_CCR1 + 4 * ch, &ccr);
+	ret = regmap_read(priv->regmap, TIM_CCRx(ch + 1), &ccr);
 	if (ret)
 		goto out;
 
@@ -702,7 +702,7 @@ static int stm32_pwm_suspend(struct device *dev)
 	ccer = active_channels(priv);
 
 	for (i = 0; i < chip->npwm; i++) {
-		mask = TIM_CCER_CC1E << (i * 4);
+		mask = TIM_CCER_CCxE(i + 1);
 		if (ccer & mask) {
 			dev_err(dev, "PWM %u still in use by consumer %s\n",
 				i, chip->pwms[i].label);
-- 
2.43.0


