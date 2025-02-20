Return-Path: <linux-pwm+bounces-4959-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C1A3D5BD
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 11:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE1E170F5E
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA031F891F;
	Thu, 20 Feb 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3VjTw9Dj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3681F0E2C
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045455; cv=none; b=Bv57KdOxlCuLgX2sQQhUdiQ6rKjS0Pj0Z2hTAKJvCAED70GxSAZajSoyimYbwYO9glaq28rB+vFmWpss87js4DLUDx9fI9B6eG82S6EWc9jBgAGoXEn6CZodynCa35n1flzeTJGCMtpTc7NPqeOo42i2puIWDAkZp51pasuLG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045455; c=relaxed/simple;
	bh=5q+ozCGvBlVKS0bQz6pJVL03Ts8jJDfVfcDaV/932UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9Fbb536XLTvhjgIrLerI4PxWi8oRho0TNBJCv7sjMi9oeweBWh5LRfC7SbsmV8Jt24yadTsvRKrC4wXEsEyjf8x3aYF2F4EkbX+jTd9RWOsQIKKkxLvrKipchn+8bLrqJQj4eNWJHdGHFnL/sB1DLImqFUjHlw9WhjyKfaQrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3VjTw9Dj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so381578f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045451; x=1740650251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lu5UW1vhx5BjNJKHUqstOFRRMZJhr1Zsm1iPcXqqQ0=;
        b=3VjTw9Dj1KCllwIcUdImXroqnN0VmcNiRUcAxwE9UCCfWpuFpvNDMnh4Co46E/kAS/
         wdfljYB5Balf4WfHyWEGIGY40TRr0nrFuvwsWfwzK53MEkaA5lPY3jet/7Du9zA8KnYo
         +Q4/WS3iJ3kQfrqUyNyOEd57VEHcIhM1+kXV1qGe06XlycsJfmYO1Ah6kty2cf3W20EL
         xpRABssOBIjxY/0S7JCXjYZIf5Nm1sKNrh9/qgIYxzLO5xs6vw+3jOVjP8OmLZFzBpj6
         4cjeuG0i9fCm6rbQQiSQISqCbiFBdR1UUb5jJH7qVK4ANrQiy7LmzhoZQqpC2xZBOkYS
         e6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045451; x=1740650251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lu5UW1vhx5BjNJKHUqstOFRRMZJhr1Zsm1iPcXqqQ0=;
        b=QaTZJBoHrwQzJt1C/IVPRYDaq1VqPW17qzCa6mi6pyoTTEy1s4T0kU4o4u7QAFQFIg
         R6lgtpY/BLtg95/jRs0aMtCzRFDmUQhd+VM5BRI7D9AYNDgw2HWpz/yORldYknucLo5N
         YIjaoVs/w3kVzePmgb2J8XMXQxewx4ybD1grH6hUFDwqe1hke03nZcBX5LsWejTEjs3W
         kwTjnnKVRQ2N/lgGwAXl0OPiOiS0x8pW4EmiVbP2kQrIwqCKgj0VxjBhuDWAxSs0JYZt
         X2YpBmg+dttZJPihNY8lvuQSEcylVginqDZSvcuDhvPRoYbVQmRp03I/SRtX5/7f1K4J
         u8nA==
X-Forwarded-Encrypted: i=1; AJvYcCV/yv9zDQGeOSgkPudu886k0cKEtSYncqNpQHr+YxcpONCz9wMqfFfwd/csg9zQyJFWEfZJy0KnAvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6hdtM8wQvSVWd+k32/zO4WAQy4+Wcp8kPEMpFUT8DuI1XQOM
	SseHIBZWOluWOVxjyjTRw+10ZG1y3p/gGshYFTW+qcCeHzGBCpsVshgHJpiXGso=
X-Gm-Gg: ASbGncsSOsd0DOP9ccqU3z9lSLY9ynMC+1G8jcJYe/mVNFh8THsznxHzDpIohNVtbk8
	1bwu6vFX4u9s3Ane3xSwlt2dykYaePzg94lNurEyZtCtqM1DiLjQgqKjZOuUc2afMrgVf8DwUBx
	5880scx7Nss1fVKP2iLR25am4BwGKlkjS147GP6TJT8kMZAI/Njf6nOhDfmpYpYtewxvUeiV9y8
	f+f3SB9IO4Rb4Y9bT3Jr8fCtIKPKitZSklRlUelU0gQE1nuqmNq1sp1PY2fFN59M9QDxegZmwi4
	xDWjT8w=
X-Google-Smtp-Source: AGHT+IHb1/ED6JU7/ktNUR0J94Bg2Zy3TWE3fvNC/JsHAq0gU0pnKj87k9wLwuouk1T7gFwq11Eipg==
X-Received: by 2002:a5d:4f0d:0:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38f3417149emr17792955f8f.54.1740045449816;
        Thu, 20 Feb 2025 01:57:29 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:12 +0100
Subject: [PATCH v2 15/15] gpio: mvebu: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-15-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=YB2ETZzeSuK+oO9OalIOyMZ8Kn0vhHKwlZK7hmcN1ck=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx50Z/qtp4HVTkNMOwSdS2Uq1in7tcnTkFkZ
 SFXTXNCsOCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8eQAKCRARpy6gFHHX
 chpKD/9PfUAL5jRXD8svFFPSWC3ozmUvcSqjB921UX/5orReLzAcrYLgy0gExzwMVJocX42+nxV
 1x2PcEcjWOnT7lOO9qyDHyq62rHVgKcqsbJbDV9AQf6D5G7MsfZGLmMmt4nD99hT0p77+V6Ki1B
 iKkruCcOxQZLKyPUpLNDILH1sKdsDDTvYUDh+11sLyDcrM0xfB3+2OOxbIqNBMijpY/3qdEokX4
 tG6XWTsyzF5H3RCno4GFkBBy/LS9vcx2AFpNo2+uFs8c+Avy6aiu/MSmVf3gyKkZyKwuGVFQl+5
 1drSIMnr3xbuR+JnVZfjvXQySqV8XAJJHB1LjN0hoP5cFO6Xz8unPMR8U/Xi/xIEcKuPLD2eGYg
 H3OMzO+6ik5Ze049zDV+728tT6AV7o8khI+Lxhk9ITtDIzoFf8mFVCaEimdUxVx4dLlI3YIXVBo
 PXyh3/+npyr3+FS4FLFGODM9xfvUmTxWXRyvMvmX7i4H08tVB3oLYJmXD7GCfYs2fpQy64USE8/
 h/wVyQZ5gypJI0AdkBMA29Od7rU/XAis5kuJIHmz61c+OtlM64kJA58MwHJFHdwci7+7jBX90FR
 gGhWMq4eFgYZFCoDYV1uteqpLBQEHtRgb/h6E2NARirlPF9RkNlaKP+43kIC4LopEXdOn+HVG/R
 larCpF3f0JX8QKg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mvebu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 363bad286c32..3604abcb6fec 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -298,12 +298,12 @@ static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
 /*
  * Functions implementing the gpio_chip methods
  */
-static void mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
+static int mvebu_gpio_set(struct gpio_chip *chip, unsigned int pin, int value)
 {
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
 
-	regmap_update_bits(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
-			   BIT(pin), value ? BIT(pin) : 0);
+	return regmap_update_bits(mvchip->regs, GPIO_OUT_OFF + mvchip->offset,
+				  BIT(pin), value ? BIT(pin) : 0);
 }
 
 static int mvebu_gpio_get(struct gpio_chip *chip, unsigned int pin)
@@ -1173,7 +1173,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.direction_input = mvebu_gpio_direction_input;
 	mvchip->chip.get = mvebu_gpio_get;
 	mvchip->chip.direction_output = mvebu_gpio_direction_output;
-	mvchip->chip.set = mvebu_gpio_set;
+	mvchip->chip.set_rv = mvebu_gpio_set;
 	if (have_irqs)
 		mvchip->chip.to_irq = mvebu_gpio_to_irq;
 	mvchip->chip.base = id * MVEBU_MAX_GPIO_PER_BANK;

-- 
2.45.2


