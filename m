Return-Path: <linux-pwm+bounces-2739-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A192B500
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFBD1C22AA7
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473514EC61;
	Tue,  9 Jul 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MOyvE1Hb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EA1FA3
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jul 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520312; cv=none; b=Uq9jBCvZNZhgIrt0AuHncuaYo+9yIkYm4RtFePSdrhCGL6C6sSlfOQaCHKxZDvueo2NXkZG/cGRDKxYxlyOPD25+SVKG5qS2nw4QGv7Rp7p68jbWbGAlTlwcxucWZdziRGrlUQGJ7ikTMPJRdj3T5dwsS3UDKpBwnH5yiT10dUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520312; c=relaxed/simple;
	bh=mXyUzOkvkfb+kJ85JoB+gVRy5JglbPng3lB2rtsWqsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQ34+K/y7YbsrjPfA0DOk8U8lEiboPubgaKey9+C+rpAuVJIschRHFCcZxcb0/ek29c5TIoDfQLFT0C9V551i4f0o8LrKK1jRqAO1UznUxzs/dSZPeKz1CnnDaoCN6uMnYvl6r6pXwDZ2IY/R1EeQ36fOo/OsfxNAGqSzxZWC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MOyvE1Hb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso7314159a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jul 2024 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720520307; x=1721125107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55skElxOMrOCjPUV7UX9C7ptFLmqKM5oP3GtZJKO37w=;
        b=MOyvE1HbUyy8UlYvFnREv+CAKwPMd0rBpPyGUqWoBs31ikdj7+VK97P82KHmz9ZjF7
         1mt4Tq65BSZAl4tDNFMs9L3Tx3VE/HlRtymCpb+cRtLdaQghfs6CMJw1ZnsKm+g2ZJdK
         YEBxC+N/pPcDaBkDki3YyXDROShQqE/dNf0EW/cA6yqzPuR+/GBh1lWSPfsjdXLDeQwI
         27k/1QGDfITdWUMtHL6V+rlks8B6Cdyq8Zt1TXuhNyByR2a+dQsH3/vHybVpSJNEj0Xz
         lUY+/27WJpo9bMjxhQuQgFLEoG/8YzGlYgGOKSc9FzjF+4qNizSESTsW4VXT4hwIGanf
         TC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520307; x=1721125107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55skElxOMrOCjPUV7UX9C7ptFLmqKM5oP3GtZJKO37w=;
        b=UBiSsj0rElEwdT54SNv4CSlqPEors8E34ThxLcLgisGSKRnIxXSTzCV8lvhnLr97+0
         ch9TDoJloyWzqh9EF7UHvsiogV9tT8mULvCSUO8DB70neP2LNxY7y6XSZOiUmhNHRkwv
         tRLLgEXcCeL27KfoqRKEyNcSBCw0yOs0PP+/yFoekyK5OaM7jqEWaPgy3mD9KKKqHWel
         0WLih3MUGjwbJNDsUvf14MxPT9/8YgRv+xaw1e67i4NpPbS/RlafTcU3dajHtnNo+7cz
         F/3YrGMXDfFowItAeIzD5iwAh6SRKOV8TRCtYfOJTRaOXi2sLcYqSqK94uz0Vpk0RVXq
         Q+Mg==
X-Gm-Message-State: AOJu0YzCj9iBATD8h32+RK497mc+09GFBqodxPVkvSkz/mpwBvC80LPH
	fvjqEzHsmKGvs5YSGOiaJvt6aGGBPoBe0YIT4qM0p84TLWdexx0FvxKhZeOWr1U=
X-Google-Smtp-Source: AGHT+IFKicBvL2WppGJx9Wp7stHGuv3aT4Zjx+F3UAzn59KIF3x/7SLjKWmnyoCEK+rfT5yAZNwixg==
X-Received: by 2002:aa7:da8b:0:b0:57c:5fcf:b570 with SMTP id 4fb4d7f45d1cf-594bc7ca0fbmr1260673a12.32.1720520307223;
        Tue, 09 Jul 2024 03:18:27 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2d338sm901811a12.39.2024.07.09.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:18:26 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] pwm: atmel-tcb: Fix race condition and convert to guards
Date: Tue,  9 Jul 2024 12:18:05 +0200
Message-ID: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3472; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=mXyUzOkvkfb+kJ85JoB+gVRy5JglbPng3lB2rtsWqsQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmjQ5eGS57zLE42aid3aguQbgn0NuMDGAxKRy/n 3iaE1X9mMuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZo0OXgAKCRCPgPtYfRL+ TvG1CACmwn+592GoOBW/oopHdgC+X0LAPRPOFcx/zX94/es7aEaPFsG3x/6RvQ1hDMYU06Ol61S l64ePJvBLXBYg/IPONdjY+cNm1GVIRn2QprIOGVdEVRxBj52RG7xRAWBJSXz5mmyuHV9qsc6mUW 5ZgVB0ULWJ1vOBSNV3juB0xGqBUgE7+iBYQNlD2wihw1kOEve4KkZAzkHsrtGvzupWvbYf6DMZ5 iADh5ZZveyvNxdJqAdh8p6UafPaznR1NsOCcFtfZUocCQ/VvSip8fxg1zHnI25noA2haqgJD+8S K11Kzl5GrQcDEYmIVER1gNlAUCLlv6GwXvlYH19FxSTOCcuC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The hardware only supports a single period length for both PWM outputs. So
atmel_tcb_pwm_config() checks the configuration of the other output if it's
compatible with the currently requested setting. The register values are
then actually updated in atmel_tcb_pwm_enable(). To make this race free
the lock must be held during the whole process, so grab the lock in
.apply() instead of individually in atmel_tcb_pwm_disable() and
atmel_tcb_pwm_enable() which then also covers atmel_tcb_pwm_config().

To simplify handling, use the guard helper to let the compiler care for
unlocking. Otherwise unlocking would be more difficult as there is more
than one exit path in atmel_tcb_pwm_apply().

Fixes: 9421bade0765 ("pwm: atmel: add Timer Counter Block PWM driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 528e54c5999d..aca11493239a 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -81,7 +81,8 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	tcbpwm->period = 0;
 	tcbpwm->div = 0;
 
-	spin_lock(&tcbpwmc->lock);
+	guard(spinlock)(&tcbpwmc->lock);
+
 	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
 	/*
 	 * Get init config from Timer Counter registers if
@@ -107,7 +108,6 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 
 	cmr |= ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO | ATMEL_TC_EEVT_XC0;
 	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), cmr);
-	spin_unlock(&tcbpwmc->lock);
 
 	return 0;
 }
@@ -137,7 +137,6 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (tcbpwm->duty == 0)
 		polarity = !polarity;
 
-	spin_lock(&tcbpwmc->lock);
 	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
 
 	/* flush old setting and set the new one */
@@ -172,8 +171,6 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
 			     ATMEL_TC_SWTRG);
 		tcbpwmc->bkup.enabled = 0;
 	}
-
-	spin_unlock(&tcbpwmc->lock);
 }
 
 static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,7 +191,6 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (tcbpwm->duty == 0)
 		polarity = !polarity;
 
-	spin_lock(&tcbpwmc->lock);
 	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
 
 	/* flush old setting and set the new one */
@@ -256,7 +252,6 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CCR),
 		     ATMEL_TC_SWTRG | ATMEL_TC_CLKEN);
 	tcbpwmc->bkup.enabled = 1;
-	spin_unlock(&tcbpwmc->lock);
 	return 0;
 }
 
@@ -341,9 +336,12 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			       const struct pwm_state *state)
 {
+	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	int duty_cycle, period;
 	int ret;
 
+	guard(spinlock)(&tcbpwmc->lock);
+
 	if (!state->enabled) {
 		atmel_tcb_pwm_disable(chip, pwm, state->polarity);
 		return 0;

base-commit: 120a528213b6693214e3cbc24a9c3052a4b1024b
-- 
2.43.0


