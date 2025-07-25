Return-Path: <linux-pwm+bounces-6887-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F73B1212E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BCA3AB9CE
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C812B9A4;
	Fri, 25 Jul 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NAnKsZ++"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583D24677E
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458347; cv=none; b=WNbqtOVJ/uxzT2qanUP5mXMsLjHOGC5FJvHISTbcRachyM0N4kl8eKqy+2XoEShbtX62J3D1bNNhZLTpxW3MnqDPyutkQjSJXZDA2hLkfhFifOMsAkT2X4uqa0ykV9FMpmVcGhYDAEJwYklYUK7E6QsWzfXam53Wun9+i4j+0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458347; c=relaxed/simple;
	bh=PtQNGC5WTp/+D0m4ok5SnO37pwnEBONW7hAjkEA3ZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3X2ZtKGY/9o/jDOOBsy7TGeff+KxgR5UyJ1h/FE9/0QnSFRLWuSA8ISZ/v4uuvRFHTsTcS5OBraJHuC1lQALLg6fAdmeQqFvHXGyS1D4SgM6KhuGduzRgnC3h6uVHA9/tr5423XaP81ce44S3XVbbCjirkH52Z24fGwmXDzl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NAnKsZ++; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45610582d07so16214685e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458344; x=1754063144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqeYbISRrV+5hnivpZpzP4dFlpiY5AyOca5fuPF0H+g=;
        b=NAnKsZ++9tNamPq8GZwTj30+KZ0rRUg8LThQxbk6tY8gyALNIVhLellgI5DeEeEm+j
         2lpn0bjHo/94cqd9KoJgb8Wh7Z03xuca0UZOHIWlZa5G5SF8GmWqjMy6Bb6tX15cCnT/
         4MAeHA0CB8z0l4h/u/WHikv69vEiNok8VIUadEf9QmcZql49KrEFfuurRx1fqfvTm0tt
         WgJfbYUN6MQIOZbFbaErwmTLmD4aPGcCd0HXU07bgeAVaAfIhfVyMuwF38vDZceeW5hz
         t3tI05fD508uI2rji/B8xcxKeL/kjGqL3Oxm3p4FrRK6rBWedjRWIPwumKo4o6Pbw7mX
         kVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458344; x=1754063144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqeYbISRrV+5hnivpZpzP4dFlpiY5AyOca5fuPF0H+g=;
        b=AlGUdMRuLInVWhYTKlo+LVoO1xPvpcbiQgHETCOW6ZlLg3SxxhZS7j7fMLCdPikHch
         cW5XhIjPyGkhJKhTGPhBs60+Dw6NyZwIEi/xQvmMBTMIqAIBtlP8yRZhwCQ2ckKYYT+i
         ZT5u81RnBlV2x1eQYU41Ll3SLcxyO1s4CaE/VldkdTuymSn9amsUNYCSFTyBj/Yh1QcF
         B+/ub8ViWk+5yNFEf5/MDhTlZ7oYNDu3TUA7mXmr864ZkGTWyIadLJuc9WbDXuT2KbBR
         XaSC5eENyvH0RKnfMbnK7RXJ7OrYOaew7O2LDtr9yX8DuDWJNr+hfg+QBwVHBnAdq242
         cHKA==
X-Gm-Message-State: AOJu0Yw6EtbNbOqXEUNmDwjjTr65eilMZYSgvAHoJEiZg8dIsCYE4LRz
	0XYFidyLKlzLWvcBS4Ec/TRSM8xDYA/iY8dVvNVqut7unLSh81u1JfApkh8t+/Fg3+fFw8sDrWn
	+J47X
X-Gm-Gg: ASbGncuBSrujy4YOCfXN6oN/+cTimMI788wcPn6U/29iJTAfN9/So7+QlxFffdd0fv5
	uAmGmbHBzhnlvt5FB2wvntdomMEf2Hq7zl4lOX0TT7Ge9KSOul3psRQKoTUhY59jKQz0wJuwttR
	/2fYhWfuXBAecl3+jipD4tkqdEjV5uHSwH6dOSr0AP8vETKPBaDBkEToCTYyLXwVnAuYu4F/CBG
	AXz9OI/Admcm9IDQr8Xp91fIqaYGPAKs0lh/KZZgejVr5AU2JOdQxaDHgI2kPFuqA3eGuc8kgCB
	KpmXKRHXSMJgFZZtPJMp0LpQBGUg9lY1UkPBWlp9E3yU8kAivPNHsDFZRoMSNCqIIHcGr/8GOu+
	S4feTlJfEnQKxor+yiIFR4RGm1E6E3nVKTNfdEShHyYysHPpR2PZMBJPfL1cmsWlG
X-Google-Smtp-Source: AGHT+IEMnAm6eYYt9SA3EJ8JWzNNY5j+6Cpu8KzMEyMYJ2IvVKEGwQY13ienYQElwLk7H6kJ0bsUCQ==
X-Received: by 2002:a05:600c:8b84:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-458762f06e8mr21186475e9.6.1753458343593;
        Fri, 25 Jul 2025 08:45:43 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705c4d91sm60022475e9.23.2025.07.25.08.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/8] pwm: mediatek: Rework parameters for clk helper function
Date: Fri, 25 Jul 2025 17:45:07 +0200
Message-ID: <20250725154506.2610172-13-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3249; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=PtQNGC5WTp/+D0m4ok5SnO37pwnEBONW7hAjkEA3ZYs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aLlPuS7y/RNmSqedFUfPOp4sAURXh27DoSc YAtimGPSe2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmiwAKCRCPgPtYfRL+ TpERB/93FL3shXv1VmXPqWboo8y55DrR1DGf8oBZW8af/IuwAB2ot2HsO6CkJdGBEK60Ny9hg0g GC6ttlYHDUuuHd6tVWjgXEaLpPZZAoAwbW5vI/kiEuYeDUzcp/T8AbWVK1Q+1XU9o3dfhwwyF2u RjSpF4fGRNTOT3Rs5UEeC0ehmKiOuG7PKSUP1qvsHqwOC28CyMads8jqJAS6VEcdP1gncrb0Ckl f+tDyPyY+HW75yZVA1ePa89In3BdWqc68j/ANObSii7uTLwWOFcYHLCknHz+yRHNzvMrH9agq8Y qj7pBariENJwlEF7adHtiYeF4YovzhyN4YfVYMf7EZAEZpxv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert pwm_mediatek_clk_enable() and pwm_mediatek_clk_disable() to take
lower level parameters. This enables these functions to be used in the next
commit when there is no valid pwm_chip and pwm_device yet.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb348337454d..16ea42be4c18 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -65,10 +65,9 @@ to_pwm_mediatek_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
-				   struct pwm_device *pwm)
+static int pwm_mediatek_clk_enable(struct pwm_mediatek_chip *pc,
+				   unsigned int hwpwm)
 {
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	int ret;
 
 	ret = clk_prepare_enable(pc->clk_top);
@@ -79,7 +78,7 @@ static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
 	if (ret < 0)
 		goto disable_clk_top;
 
-	ret = clk_prepare_enable(pc->clk_pwms[pwm->hwpwm]);
+	ret = clk_prepare_enable(pc->clk_pwms[hwpwm]);
 	if (ret < 0)
 		goto disable_clk_main;
 
@@ -93,12 +92,10 @@ static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
 	return ret;
 }
 
-static void pwm_mediatek_clk_disable(struct pwm_chip *chip,
-				     struct pwm_device *pwm)
+static void pwm_mediatek_clk_disable(struct pwm_mediatek_chip *pc,
+				     unsigned int hwpwm)
 {
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-
-	clk_disable_unprepare(pc->clk_pwms[pwm->hwpwm]);
+	clk_disable_unprepare(pc->clk_pwms[hwpwm]);
 	clk_disable_unprepare(pc->clk_main);
 	clk_disable_unprepare(pc->clk_top);
 }
@@ -141,7 +138,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 resolution;
 	int ret;
 
-	ret = pwm_mediatek_clk_enable(chip, pwm);
+	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
 	if (ret < 0)
 		return ret;
 
@@ -198,7 +195,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 out:
-	pwm_mediatek_clk_disable(chip, pwm);
+	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 
 	return ret;
 }
@@ -206,6 +203,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	int err;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -214,7 +212,7 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!state->enabled) {
 		if (pwm->state.enabled) {
 			pwm_mediatek_disable(chip, pwm);
-			pwm_mediatek_clk_disable(chip, pwm);
+			pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 		}
 
 		return 0;
@@ -225,7 +223,7 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return err;
 
 	if (!pwm->state.enabled) {
-		err = pwm_mediatek_clk_enable(chip, pwm);
+		err = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
 		if (err < 0)
 			return err;
 	}
-- 
2.50.0


