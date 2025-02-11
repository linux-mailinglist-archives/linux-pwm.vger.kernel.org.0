Return-Path: <linux-pwm+bounces-4849-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8461EA30B44
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A9C3A6461
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3421E0AF;
	Tue, 11 Feb 2025 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VcCQe2g5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFB214A7D
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275812; cv=none; b=o+fFgAbUzoY2p4VD2/nDNveojIj1talIiiQWVWbBRnbBdU0rbfa995TD3eyUv2KbxgyU6swFJ+MT+04Hgk5fBP0R+uotxkpdR0frP4663B0WkjB6DvnVrD7Ofyu8LU/gzoLPwW6MBG4NxNPEh+6h7nGyNf5VDrdoJrthbt+7Aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275812; c=relaxed/simple;
	bh=n7e1bRvIwDbJsC3TZV7mm+jegTR9TSB109s8PxAei5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZX2+biKBVJoCjLRkuAomvFVT8mSRX1f7Y3/ZYHYt9nezNk+5iujNnFPrWkZRgP+Rhzo6p7b9Qj+tI7XgQZmLFIO6gK2o39szPDqDV+5V6RRyWP2aAsK7VMeuGACiW7kR5n6PcBuABPPY9735bLegZd5rZqsLb0gDV68GVADEhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VcCQe2g5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438a39e659cso37876445e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275808; x=1739880608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quvfEdCC90sqn/TMYew/ubIOyPOJqPZJFKX/f1unqbw=;
        b=VcCQe2g5SVdGNzdqTRKQOsl+igwW0brDA8OGOwsapOnJwGP0CPmtnwT8Jk+GXoQYsT
         PmmrykH5gRph4PmIJ4go87EUwAQ/tQlQeHANoHo3lBIM60m2GstDGawfYbeRmr3ZB06S
         D4faRMv2SbHexs4Xrkk6Yru67886Q5XRZLRyEDSFZeQQWd+oEmOzwca1KjIGZ6sds5uh
         j7QVWiuMYWZDwNpGTbK4hzqvD1kIyS1djBM4SM6VSNSjy5qBF2dssbOtHPoL6k2l40x1
         ML+YBK+Q24LEPIlhB9xpR2ZUsouJZYLyprgt+sKuToR4KOlcHlZc72kG1zdwwiw55ORA
         k99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275808; x=1739880608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quvfEdCC90sqn/TMYew/ubIOyPOJqPZJFKX/f1unqbw=;
        b=BcOyMX1dlJsX5Nzl/YT0Cuc/Mni2Y30z8ZfcD9Q7jnuJ/e1lJLJ78vT1P/BmybxPrR
         feu13pOucZrdpJfxuxhvqORKvaiOgNMV6oxkk9q3o+JBRIbAtznGd51zVy1qWrhuCYC5
         U/dcyZgNpJ3mAnz/AGFxSoCovwCeZ0zKkra/Iay7hF52RgjaZwbYDZdVgGZHQwkMaIkQ
         GT6kTtkmPsUQHUl07iiZpQmxDQ7cnLV566XpfVUqKTA2UYz0gRxfYFfo4aaVWtYxbf6J
         goiL+g4aSKH/ZMHThtGM51mUKqHrCsYb8yNmpMVBnbZH0t6XWkzTqPKRU2Jl8O0/rlTK
         QFjw==
X-Forwarded-Encrypted: i=1; AJvYcCUTGFPNpPWsFMd1g5IoHqwYrqkRwlUgu5dTv0hvv7PkfVD+umo6OdjMoag3gKJeMCEcXeRiHNxunzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDyao4QOCvj6WPq2YNDlgPpRcFZGgI8MMLjnQLem0y1XefIDc
	ubnh5YDbCY4klZ/3hq1hJPP4k8P8LVwIEg+or5LR758pga8U7RxsVKOqGkSef5Q=
X-Gm-Gg: ASbGncswNvl9zYdRl/EMrU16KL/fq2LvyqD4jqNOh4XXQWz4zsaSjjVLstBLlpLPjVm
	42TPcBydhrCJwsSqWMvnTAGT4gl8G5EJNI1sDtabAx2p1YWz3N+cQGveV292ArC+ugoGxilD6SZ
	ez8whQLIbGkAaLqWV3iMnRKdJP2gvzPN22I4ELVBfsuQ2cNzvohTZe9ySDEQu9p3skUxxd+kamo
	26E6vEEJxZ1yLdkxkQ+zgaxRJE6Jt+HHTBzithvY1EKCQ/rUAfQSeQoW+cVIOtYNV1TKburuKtW
	iuNsAQ4=
X-Google-Smtp-Source: AGHT+IFFWsBDXUIhUnTK0Jc/gjJWtKAcXr7csTld6YJ7dLpzJy6WB9rdlWOzy1pJ6THp3Tu8nQYncA==
X-Received: by 2002:a5d:64ef:0:b0:38d:e6f4:5a88 with SMTP id ffacd0b85a97d-38de6f45ebemr1250827f8f.12.1739275808376;
        Tue, 11 Feb 2025 04:10:08 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:41 +0100
Subject: [PATCH 07/14] gpio: pca953x: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-7-52d3d613d7d3@linaro.org>
References: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
In-Reply-To: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=yTjxL9oj03YB8rj+0Yr3COMJxOa60Pm0eOul5x0rP3Y=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4Xxed/JiS9ru6Dza4dboG846bTEV9IzRV6m
 Ln9O4uXOsyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FwAKCRARpy6gFHHX
 cszcD/9SlHyaBySPFpZFfk8U4HfZDjFSzdzmXpCWmAL6IePTYbDVbk1ESrU1nA5ENit5yAgv833
 63xBCYyULqlZzBtIxvbJiLO7pG6K7peyNg50Sh2XAPF0AwcreWx6yI5/8UDqqfM7PUupNizmoEM
 5fmvwHa3gVyos+YbzWaK9/eGh+k4ksY3LtvRupDyzN3h9uMZOpmviTMWeuW2H3TcLC7c/jSrMhn
 keMARfcvphGdpYcd+UOQD5G1DeaJZXKOpXLFTqQp/CyPOLChQLv8wrGwEkBYP5sNyPbdmmYlHIt
 SzhHuOBQP+xE+Oay7m04VvQBPSevtOgsp4RAIfmrNah5enDFpwM/kZWmCK45fbVJVYSfhxJ9wyQ
 bHB0HmOGacYFgaxfaoZUYqwxqA53DW8VlLDMKU5tQx8s0AsLEBkctsIJkj66rqH4P2PdnRE0tU8
 7JHN1YNKfn9vrY2e1hrcMzD/b5ILCVWHk4O5XnllR0VAKNyDc5mD4ap992y9cLpCSm01pauVWfd
 H5S3f0R6OMPLU3+jL6Gb7wXIPMdpaQg4nmfWGaO1v1/hX6CoLbGawDcrZ14wn9jGEvMYfYTFrlR
 TwyOkcAzr1ue88ESJHyArhWgHDEn3e9Xw1+qwcraFIcz9XXK1VT27Y37Cr1/wHcYC4oMooOBJEp
 xdmwocXr8J58Qqw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-pca953x.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d63c1030e6ac..442435ded020 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -570,7 +570,8 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 	return !!(reg_val & bit);
 }
 
-static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
+static int pca953x_gpio_set_value(struct gpio_chip *gc, unsigned int off,
+				  int val)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	u8 outreg = chip->recalc_addr(chip, chip->regs->output, off);
@@ -578,7 +579,7 @@ static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 
 	guard(mutex)(&chip->i2c_lock);
 
-	regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
+	return regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
 }
 
 static int pca953x_gpio_get_direction(struct gpio_chip *gc, unsigned off)
@@ -616,8 +617,8 @@ static int pca953x_gpio_get_multiple(struct gpio_chip *gc,
 	return 0;
 }
 
-static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
-				      unsigned long *mask, unsigned long *bits)
+static int pca953x_gpio_set_multiple(struct gpio_chip *gc,
+				     unsigned long *mask, unsigned long *bits)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	DECLARE_BITMAP(reg_val, MAX_LINE);
@@ -627,11 +628,11 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
 
 	ret = pca953x_read_regs(chip, chip->regs->output, reg_val);
 	if (ret)
-		return;
+		return ret;
 
 	bitmap_replace(reg_val, reg_val, bits, mask, gc->ngpio);
 
-	pca953x_write_regs(chip, chip->regs->output, reg_val);
+	return pca953x_write_regs(chip, chip->regs->output, reg_val);
 }
 
 static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
@@ -693,10 +694,10 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 	gc->direction_input  = pca953x_gpio_direction_input;
 	gc->direction_output = pca953x_gpio_direction_output;
 	gc->get = pca953x_gpio_get_value;
-	gc->set = pca953x_gpio_set_value;
+	gc->set_rv = pca953x_gpio_set_value;
 	gc->get_direction = pca953x_gpio_get_direction;
 	gc->get_multiple = pca953x_gpio_get_multiple;
-	gc->set_multiple = pca953x_gpio_set_multiple;
+	gc->set_multiple_rv = pca953x_gpio_set_multiple;
 	gc->set_config = pca953x_gpio_set_config;
 	gc->can_sleep = true;
 

-- 
2.45.2


