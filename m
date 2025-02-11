Return-Path: <linux-pwm+bounces-4848-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C2A30B42
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B32188B787
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37321D00B;
	Tue, 11 Feb 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="io664Vv/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFD204092
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275811; cv=none; b=QEtRAeBTl7VQ/pAUOAJM2emt+1X/vAT4H0L/ccfae/GcOA5hFtJ5jrgNilzFI2lL01JxDLVOSM9XIyHzC3o9SJoRz2Y482aGA1jL7vOFTi+hMGBbrYjNZDlon/fMRjVXjIZbiyqplng5aKBVs/SMjvyHF+IHfZTM3ML4/uzO4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275811; c=relaxed/simple;
	bh=rcQ3T4zyuVTiLHp6WubPsE1Ox/Kf0sce+luCScWqL2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNIb6j51gVeyhG4lmzLLXFV+zNNEjmp7iD2zxkPSQEZOg364rRC+V5CMKMI+w7FWhoB1m6trCx2umaGqYvxkmiWGlcPiVcKIuaQX964f/eJE6OGLEjttwdX09XSzjDG0Pj6h3V8B0YTsJUqHX8ygbRt8kHp6N7gsVXO/M0WG3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=io664Vv/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dcb33cba1so2053785f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275807; x=1739880607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qv4UcbRwOmRlH2+uAuWjapg2vatXtKfR9XWqAYZihX0=;
        b=io664Vv/LA3m1D+HqphHb7+XixEoKf6cudiFt8mvGfbEfyfrw3jYeAWVTXbuC7Bvyo
         IvFn5o7u81GCqYy/lBEz/cbuAt59JrrdkZBqJvOEqsvTFUqvWTBsrvnUxyYxVivxc2Dn
         h5fQaZ/3fSogacZqGWeOte2jJ4nSmUYgNK8UPOaqjV1gLD1klzEjQ2IKCc3i+74lJ1TP
         NQrYwqa3vpuhWW+uGb5ICo1cwRGQL5D0dzsrFnzCfhQN0GGlz/G/9nr4uzSqfTJQ+OrL
         hiyOodOSJqJShb4ezX958C1039W9ogS+UVFExz02CNVpZw7gAzYFgKH+/JUfas0QJl1w
         rCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275807; x=1739880607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qv4UcbRwOmRlH2+uAuWjapg2vatXtKfR9XWqAYZihX0=;
        b=cwkG0m6mttHdVs1aJvN8R8Q7LYjeZ/77fWWtW6xQWor6DKWbtqT88XvBxQn/U6yfFO
         vjOrM8A+mtfTAwgAL6ZSal+xxodMqSdZG9bodbM7y2VORV+ZJWAxm+Ex9zOSutvH8sQM
         Yxn2rGSDuXWs23X/JvFR/OCbjVoZKx85BPonqaoZCzH8vmnP920Lq83pmWrJO0y7CqYI
         llUAjlb8+L2SJLO9oMkiZOu59TdJMvqTLLaQi6ONIjReavE3LLQhUdDFcG0yEq2QZCb+
         xFHS3U2RiJNGs10+132CNBmH+iDRk1V4caxo1ZOabIIhdmTbVhe16PTXFMcX9v8SlSR6
         CqUA==
X-Forwarded-Encrypted: i=1; AJvYcCXwvUQr6vfpojHwT3rRGkGZ2TnwU3kM5tMo94EXoWwTPZCAtYSMCBvM+Br/7zeljkawuQaG8G3qgPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyx+3reomCs8sVVFYBeZYFI0VBzC6q9usjaj862sSp1NczwM42
	I90bk/AH1wbL6qvFShVyUWTO6+E7KPMEMBFaVCPXyq6GapNSGXzjOBMy6SkvAEY=
X-Gm-Gg: ASbGncsFH4njns/FLs5e4AI0aRhAlle4bMKsqRlUvSjj+blBlIqWNEwuHc9y1BxZJbN
	P9zDFS3aXmWbRfocdl43KXpPBUzhbsxRagqyeV2Zimf9rbIP/Kplxq4P8SaBBhlW2PdvJ7/hiLF
	PMlUbSUjtxOaAdRGQ0Ezo35znzwwLaoQAVN3xNRLLciHjkPLBJ1Lw0nTIwDxnXXWzfYZD3pGcQh
	nbHssr5bjcsI+X1a5VlOHmY/x9PBNzCzSe2pWeaLF8TfoH3rDreyJmp6FZMc1ypA7q47vksrdWZ
	/qwdEuQ=
X-Google-Smtp-Source: AGHT+IHkVqDLdYwsVh8ly6zb88ftBd8nzBW0TKTiQWoX9p36nv3SkqvCkBYK4KMPQa6FfU7orjX5mg==
X-Received: by 2002:adf:e902:0:b0:38d:a90c:d489 with SMTP id ffacd0b85a97d-38dc949183emr10597002f8f.45.1739275807409;
        Tue, 11 Feb 2025 04:10:07 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:40 +0100
Subject: [PATCH 06/14] gpio: regmap: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-6-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=eWOghmch4gRKbyww4eGVXx2g3hb1VNBqan3sQradlTc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4W+FiAtGlk/jzwkziUhGzXfeS7YMWImGMLo
 ugBDszcM8aJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FgAKCRARpy6gFHHX
 cvuVEADUXBlmSbVqQSk4NioNfFKInxWpOcufjfsxrszO9Ck8OJobklQH9VjOqCVLcLSuN6cjU+v
 r5XEifDQ2zV/Ni7oLbexCpuaoykv+k/sZDa83/U4+4FmO7tpzoGZyT8/l7nAR/A8U3OQNzcvFae
 5m+W6ZW9xlKkwShus8lBKm2L4H4pxHJvgVYPall8/hjMf7uIl5mbbi6NQNnbol84ccRpm20YUJN
 lIfsoJruOAu3zjXuOZL5O19BRseTj/YmaAEAzwPVK95WKf27jK74pCFsTiTYUGQCTiWAePioTs6
 jsrklOfEV/aHmjyfIHuCRpMjIqnErvESL8h2yQJEm70lTUkJLCxB42cUSUU227Xsjh4Q5cfQJYD
 vz4Yua4ybr8XSUmH5wT8sK474crHEVFkT4YzHyX8ziXVnBDi2JOhPpxYLUEF6zr1g9gklW0OVW7
 exfqPu8KdmX6LvvhbdpNsUQtdYOObJ6BPTe/hTAODR9cs1XN+nuye0gpDmUwjoFuFKPLIgMlY9x
 Sr8i+nPlJehjUeDDS7q50FxoRtpabE7Kr2p4QAQvED5qMtUKFEdwQ61kLOzEG3UebSVBLi0BK8O
 IMUIj3vHNKEFmYqN1zToGGeqrzf1HW82+rkwGIOF0gQNEK1N+lVH/xzmlyiUlN3bb2wSvBU8Ao+
 rwA2IqRWwaS0xIw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-regmap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 05f8781b5204..e3b4e392549b 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -81,22 +81,25 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(val & mask);
 }
 
-static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
-			    int val)
+static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
+			   int val)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	unsigned int base = gpio_regmap_addr(gpio->reg_set_base);
 	unsigned int reg, mask;
+	int ret;
 
 	gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (val)
-		regmap_update_bits(gpio->regmap, reg, mask, mask);
+		ret = regmap_update_bits(gpio->regmap, reg, mask, mask);
 	else
-		regmap_update_bits(gpio->regmap, reg, mask, 0);
+		ret = regmap_update_bits(gpio->regmap, reg, mask, 0);
+
+	return ret;
 }
 
-static void gpio_regmap_set_with_clear(struct gpio_chip *chip,
-				       unsigned int offset, int val)
+static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
+				      unsigned int offset, int val)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	unsigned int base, reg, mask;
@@ -107,7 +110,7 @@ static void gpio_regmap_set_with_clear(struct gpio_chip *chip,
 		base = gpio_regmap_addr(gpio->reg_clr_base);
 
 	gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
-	regmap_write(gpio->regmap, reg, mask);
+	return regmap_write(gpio->regmap, reg, mask);
 }
 
 static int gpio_regmap_get_direction(struct gpio_chip *chip,
@@ -266,9 +269,9 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	chip->free = gpiochip_generic_free;
 	chip->get = gpio_regmap_get;
 	if (gpio->reg_set_base && gpio->reg_clr_base)
-		chip->set = gpio_regmap_set_with_clear;
+		chip->set_rv = gpio_regmap_set_with_clear;
 	else if (gpio->reg_set_base)
-		chip->set = gpio_regmap_set;
+		chip->set_rv = gpio_regmap_set;
 
 	chip->get_direction = gpio_regmap_get_direction;
 	if (gpio->reg_dir_in_base || gpio->reg_dir_out_base) {

-- 
2.45.2


