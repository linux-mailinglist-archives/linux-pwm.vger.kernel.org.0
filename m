Return-Path: <linux-pwm+bounces-4952-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D18CA3D5B3
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 11:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A00189EBE9
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5321F3FF1;
	Thu, 20 Feb 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nHhsFy4J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC61F1927
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045447; cv=none; b=AIEmAdP48SSdyTbVeRo8h24N8M0UzHP2qP5+a9EXGrPSFwQG1FBzqiZGKlr7yDrar/ism0Y6HWLMAb4Hp0VpZEqrDIhTcs/yq8a0/5RALJJE7U5rofmmTmGI7fqEfbKOK8rNTooVEo6dx+5kJtaQ1oL3N4lIFZnaCs20f18M6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045447; c=relaxed/simple;
	bh=Qr5pwyTIYbjk01m1nWcOh0U6ARWx1aMge7VsSHImj44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qcpsUohAwdcnbTvIypn0DkkwsBWU6bNK4SkJbl9es/gPMEE4LKu8o50Yv2c+PO84Pv2WXl2BftPzM8kWk9RLrIIiQ4fzXiwq0jL/Pk5HGphmRaEr2016peF7q+qP/RIJHGqZopMIGf3HpR9T0B1eVaoKCAaXzRLrIAbxehobLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nHhsFy4J; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f378498c9so619846f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045443; x=1740650243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRQWT/40wRe1LtAoTuTfhDYRu3pa+ZoZ5Qsdiw8EHU0=;
        b=nHhsFy4JI79kmd4iL4AD7OBAsAkwW0aN5v2bH5E4XtuhwuKW8YKv5CMCbB2S5amq4N
         i77fqUm+UMOPwtE2BrO3//gnHZWIcIPSjVBRoVlPJJmydRH6bVGeKmy5Q2ApO7PSjRjq
         Bhk+EzqJzgauAeuDyP6ZP5gYZovVY2cpaFQEDIc8dhuLda02pmnvtvMhKzFEe9OFvlBf
         EVgm3blWi8d+GCK8L6KIgXHfJiGOqt2Jj8n+5wGaef8Lcby0U1boxW/gYCGBKFrITsfD
         Up3tNB7UEkGI0Q8vbeyHgCSPJ0UGSpeN5wbZCp0so1a0vtoX2DfXcrgYeeoylCs7V8Bz
         U+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045443; x=1740650243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRQWT/40wRe1LtAoTuTfhDYRu3pa+ZoZ5Qsdiw8EHU0=;
        b=lCcEqq0I9OZ7Cfa1iyX1dX067OXRBFhjeiLBZ4ts1pUzh4WtVQQ+Rqt2Ytvrl9x/is
         7zxwDUmiWA0JGBdKS9Su1wr6pqbkn80jgqD68o8BgvkuyJf08a6tfnzNTMFWo0JdM3zk
         ye/ZQgxzvyqAiiQLzd7knAuui4gxp2agTaZ/MMG9UVBZfH8i5LRSMozY7bqTrFFBe5ve
         V0JDx4wEJF7b2jWYk9xTzEAnobfCNCh0vxFUB/LtmUgV2B8NIU7QxTsOVqNXZFts0HGz
         bUEkhcwur8pFIOZ4dm+Jyir3nyHup3WbOhWJvyhdUlAZTqrRdbIvvl9S+MUyeikF8MfT
         qZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUqj9EGgrpexzMJ2z1vNCZM78efYVqFGVD6EvX318nmBzI3LYIVovXm7pdWEVGPr0sh9Qc26o3ZxuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCVI7uH44UUUAGe5wwwvcNNnzT+08JFlmlG8B5XpfYCbFJxGD
	ZRcjX04T6b03/vDr+KTwa2S6fI94EauX/tygKtr8BBQpCrpnx+CdYSJ3nvnqveY=
X-Gm-Gg: ASbGncvtQr5x8mJw1Kv+0Yohiqcc3OeMJQ9OEc3VbdeyZKrOg7JTa0/ymr+fYYTXUik
	MfYJMKfkspjryrJ2bxufr50qsBee117ThsZsXqiE9gzbOW6w4nlVVkZy0MjPy2DWBITQV0Fj5qQ
	X7j9JEYqwBT1g32h7kDErcD+6bUrMr4F61WwUEApLcgiQEAQ6nY4awbzoSdiy8D1xv5h5YLkDMv
	tvh1rDEkFsGAZ8CtYQKW08HfMBjEOPQkwMLSdMfHtZCoUrwTTNIAYFqNEa9WWO6QOJG10Q3Ko0J
	W8UkCMo=
X-Google-Smtp-Source: AGHT+IGMc8a6w4j0f9UkXAHVvmbrKOHEpblOMX6FMz7z4xWAnlIvmn6QVgRsrx0JWETrLFKa3k15Jg==
X-Received: by 2002:a5d:6d01:0:b0:38f:4e30:6bbb with SMTP id ffacd0b85a97d-38f4e30bc4amr16083443f8f.25.1740045443567;
        Thu, 20 Feb 2025 01:57:23 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:22 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:05 +0100
Subject: [PATCH v2 08/15] gpio: pca953x: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-8-bc4cfd38dae3@linaro.org>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
In-Reply-To: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=PWWwH3jWRDV+J2gbtwA4aaIaSxrs8feWIIuZBq3fKwk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx3La0AzR0/zW3p7Qhs7aYoHGhxKh42MsNbm
 LsTtWxTEKyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8dwAKCRARpy6gFHHX
 ckOhEACN03Lw2yVsYZ1UNUGUueclAo4JL7Ybm0VydAuE6evO7Ddce1rWKs5G0KCpFo4YtWTZa8q
 jE27Z2CRomApbwE3pWb+6JJkpH6eIHffkCFSbc7dMxDDefWudTptxm0ao1ZCm7ciRaeEXZuhbfP
 BgYgy7NruPadKiG/Y2usyqAzK6fD6QNcQ4137+j1RS5K0nkar8MzWBcDN9r8kHw7+nSbel6ljTm
 cnSFpxmjOPIzCfLfIblUhx/n2gQqjQNmbeg6aDqNGvCPSu2wrT7VfXRF9/cRaYsnpESCcwIIng2
 aqNCLmIoD3/ikP4F5FCdouk5xNN8Twoo27OzL9lvaQs/cGNpA3naXPbNXBAIBszz08Ly5Cq8/g8
 kbgHXe80goK2hh3xrNLBz331GFiYppaUeJBvx4p4g+8BUMvcycxgNCG9ge+xSou+iwkDJ37HbWV
 oDMT/PGslPLJTPM1P0qiz0777fN/xePWI3oWjCEj0YLLZB4R5W3VsJrM08+/PO5dJahGyLDIfr9
 jrxclJ+9VZQlew1hztiWhgdRE84sioe2hEU9Qe6NKiil1D6StJzW4JKR4korc/JTNUTWO9G6iDl
 I46IJR08nzAoIGq1azqdYk7TzC/s1ztVF5A+pNWzedZ20sTOsz6pArtNOeed/JcURlnRUsxTY5N
 MFiNwJUSmSKmn4w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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


