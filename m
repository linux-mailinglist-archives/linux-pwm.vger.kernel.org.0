Return-Path: <linux-pwm+bounces-4955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C5A3D5C3
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64C67A668E
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837C1F4720;
	Thu, 20 Feb 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I47cAUjo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB081F4182
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045450; cv=none; b=guvAVf4kJA3NVF3+94e38xrgXL+opTGQZDiWkQcw+aCwVfhDZuSsbRbIkVbi34oP+oCCEmC/odaOiy9xdi8G8lc7bHJz/E8vhv07jrqK2YPyjvHZ82iibr5mSJKni5sA4mtSEjyRHN+/6R2L3gEtxcpSJyXzSvJFe7yAiGNqLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045450; c=relaxed/simple;
	bh=Enef4cJKJS09Gj6WI9qsS02j1I+VlFZmtf1bwlaQO2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPjedz68kwr9VIlnLq22/UJm/l1Xzu5mqWyBRRY8j/VuCzN4bon/C2NqL6qX/I1NQauqsrQ9o2q/7EHC46JmLQyQFVNqIcgelzv1XPDQ9w5nNxKyjOv1Vp/7mRAUTdKwr2px/v5YZsOMdR4UkOGcRppH0GtqrsgznocBNpZoTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I47cAUjo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439950a45daso4010155e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045446; x=1740650246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFj3TAoXlLf9as8kjepaZLFMmsnL8wmxW74MRLbaHG4=;
        b=I47cAUjod9XpoGxsStU9teiqtTdTY2/DAHu+Xud9TBbt0LbfN50XYWOINACsYNh4HN
         Iu92HaU7PuusVkXRpG1W/Nej17c5RNkln1I06saCEpKaUmbyM/ke3EQoM18kxMsK6470
         C0eknDd6UyhwQKXV5YAsU/B57ztRXH+Rnk4kiQZVFBamcQe5vYkAAM/hq3wtZK7oZWt/
         qHF+v2XpHVjz+m22cKgDLBlGQtdfXhRbESqaFt80n8eSejQF6xRY0qCl1CXicDPdm7fC
         qEhGHBIXa0S+6fWqKCV33rMqPkANwenjuKgWL19PLGl2RJFrPYlhGaWFTceRMn2Lv6sV
         B+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045446; x=1740650246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFj3TAoXlLf9as8kjepaZLFMmsnL8wmxW74MRLbaHG4=;
        b=gY0GvijZX0JarvSLTFPsMFuQo90dfdCAoxRJzXc9fvNYiBg07PyzXsDJj6c9GHIRzh
         vXsqyb+D6+8pUNWMUXrgmQqgVg7P3G3mxuDPLEJ+8cTOWWvKKEywjvYVkUw4znQnUReC
         e+ue/1Sfh5EBAHR0OI0n38ZMW6oTlx5E9bIN8aI82V+DeTA56veWdTwPMbX+DOSkiPKH
         /SGmjqXWxWwvt8ulU/njcxsQenBEa/8XMduTNAF8KROvgMYE+92hDyq1vblwTLwJoBew
         MjhRpBeZjPx9cX5NqjUIEApY9BEAd0kICYKcmZe3ioN6SqZPyfbSmSvQiswI8Ds+heYz
         gIgA==
X-Forwarded-Encrypted: i=1; AJvYcCXPx/NyggU+yOnE5Y1SU4NewcUADM01kIDoG1q6YZ+sEewUrIVUZPMIrzzJ4jUmAspExLIlsmoGv+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWhGGl+UqjVQszrsYEg+op9J/dnw2+Hhf7y7eRkWH76CDWsbY
	+sSZVDIJ/eGU//vB+iXeuW5/bX2NJnN7vbNBG+GfDQeZEeMPd66SzngvQK8iBRM=
X-Gm-Gg: ASbGnctdZ8VCupzjoAGmzy6HOM3zxGWm7of7IeH7Wlw/ZpFNHtJNjrWT6HyNLrYI8s7
	Ap9r2v1cV5NIqot+Y9hqPVR9IEDbzaSjY7LRBHBBc23z+u//1Q6bqTZYCoX33sH7YzrVPGodZEI
	RUQXh7HUFH3J8PxAWe+TZKCNxuBZYQYJHIp5gk3GKoA5tgMOBbl4OOGGsvMro+yBSPe1yQ6k7mN
	jayCSBQfWa38DxB9h8alnSjhSMvVG2x6pkJV/rlqUum5UBEyshgBfU3Q7BroskvU70Rxj4h53Qq
	NtJf4Ts=
X-Google-Smtp-Source: AGHT+IHZ/4ypng7/Mf7BbqmPLwdiwtlI2cnP9YvswrAy4gvWNgi3caTDM9umvq55d4WsrVVwRuSdaw==
X-Received: by 2002:a5d:6484:0:b0:38f:4c30:7cdd with SMTP id ffacd0b85a97d-38f4c307ec0mr12116273f8f.37.1740045446427;
        Thu, 20 Feb 2025 01:57:26 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:08 +0100
Subject: [PATCH v2 11/15] gpio: max77650: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-11-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ud09vHY02XViXfaw2eD51Q7LQfSy2x8XEgnHffEdPlg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx43gFxRicC6+87AczX0jflaVhzn/pJ1X/Yl
 opHyNglcAuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8eAAKCRARpy6gFHHX
 cj33EADiL6KzJWR2xcC82uIKj9EZSjz7C8AjeaQwc2mKPIROG9GioV6OMq2j86QkRiJQnvkiD/i
 2hWL8lgmpiZFmQETu5W3ai9InFTFYQQvFerXo0RRrQwqVU8lcMPiHik7AgnVhWVYwUCKCo6hYnT
 r4xoc2iyt4ntv6w5eGTuwSvYuJ2p1h7wFsD0YKH/Dm3kcPNpOnRdDBM5fRVCZYb4PYODF8AGPkp
 rYXGaubNMdHXC5fiMlF81+aNnsEi66/6gUwMbqHrk/yJxSGOxLHEGWouEYDZYG+ppPJpnYb380R
 QH+njw9t3PkK9BlAAMoKC1uyP3LyqupMURWDts/z9Ii9GxSq/FX9CUaFm5qqA6BrtNs+cISrDeg
 TFlwwLv5wmawBjv17Pl4OxD9zEptFilB/yWdq5iXQKL6tGkjesuafFaSViWT89OF9+ppi37Jm5d
 76frI2dD+X9fkbxEf2FdJlu5e3Xi12HmU2cQpb7gQ1W7DY8TBg2j4muuHaTInEP1MCu6JpUGdCQ
 bXk1FIvPJfrtkx4AcnxPQ4+SPasoh9UFeG5JvOKxQuz2X3M2zX79BUY9EZO6JmZTot1XibuKlwn
 QzGEc8F3ACLDGoRk92hnWp5T2Gi0PocBr/lDatZ6iw7AOW2YJ123bh/+FA7zMs5tboXiN6xYbVc
 3ivtZzaqOKWgH3w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-max77650.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
index 3075f2513c6f..a553e141059f 100644
--- a/drivers/gpio/gpio-max77650.c
+++ b/drivers/gpio/gpio-max77650.c
@@ -62,18 +62,16 @@ static int max77650_gpio_direction_output(struct gpio_chip *gc,
 				  MAX77650_REG_CNFG_GPIO, mask, regval);
 }
 
-static void max77650_gpio_set_value(struct gpio_chip *gc,
-				    unsigned int offset, int value)
+static int max77650_gpio_set_value(struct gpio_chip *gc,
+				   unsigned int offset, int value)
 {
 	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
-	int rv, regval;
+	int regval;
 
 	regval = value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW;
 
-	rv = regmap_update_bits(chip->map, MAX77650_REG_CNFG_GPIO,
-				MAX77650_GPIO_OUTVAL_MASK, regval);
-	if (rv)
-		dev_err(gc->parent, "cannot set GPIO value: %d\n", rv);
+	return regmap_update_bits(chip->map, MAX77650_REG_CNFG_GPIO,
+				  MAX77650_GPIO_OUTVAL_MASK, regval);
 }
 
 static int max77650_gpio_get_value(struct gpio_chip *gc,
@@ -168,7 +166,7 @@ static int max77650_gpio_probe(struct platform_device *pdev)
 
 	chip->gc.direction_input = max77650_gpio_direction_input;
 	chip->gc.direction_output = max77650_gpio_direction_output;
-	chip->gc.set = max77650_gpio_set_value;
+	chip->gc.set_rv = max77650_gpio_set_value;
 	chip->gc.get = max77650_gpio_get_value;
 	chip->gc.get_direction = max77650_gpio_get_direction;
 	chip->gc.set_config = max77650_gpio_set_config;

-- 
2.45.2


