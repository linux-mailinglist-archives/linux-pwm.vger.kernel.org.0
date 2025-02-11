Return-Path: <linux-pwm+bounces-4852-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA3A30B52
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A913A40CA
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E714D24C663;
	Tue, 11 Feb 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NQr9i1gu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D85221D8B
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275815; cv=none; b=hlRPlSvGZEwbvLiUwfdBq4SUaprcUl10NY0X7A2ugVBwepQPSbk2tP5Wy/97rHdrLVhomnUJA8GhjdoklAJeHgmkiR0JMeFHdWltNRoaMhD9VkptinsJaIkOCcYHmaJqP54+lOcGyLyx3PqGdLvFl5ydqYKmTl/gWX4dFlF1Opo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275815; c=relaxed/simple;
	bh=U32O6gpHaPHK23/7gdVmxwYFuZ9Da+Dn1al7zxctPU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFbTv3dkRpQcDk3JO/+WW26YOtMNaHAOkznSL7/N1nLU9U/5HubDOiNFL2YQcWbAAjU2SF2GWPPkYi38mJ0t7m+xF7wd3V3EOmZxA1UuyWfMWUgLnFCxdAKBvUAFfaajQdd3EmxvlnrWVy9XlfVKHRlLlw/HZQ6Q7r/TSE6sJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NQr9i1gu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso55058425e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275811; x=1739880611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6s/3Qc5kj61ZYPHh1DjfYym66L0t2z7xf+S0LPTqjrM=;
        b=NQr9i1guaRZ21li6lhJGJcRwCw+fMrVW+qxYCy5iKeyCpu2Ye7GkbNJmdiE5JPRvEh
         nqkHKccJIIGqu7MQ/1KoJqPnndpFjx6t430IqJGD/i5n8WBfCw0DwtW2RXU8Ybj5kKyD
         ihkC6nU/mgJap1vzJR+Yogau/eDGpbd0A2NIl7z5lB+ZGIFfE6wF3qtry9hQtA2yKyuQ
         pZVBUVTWbNGgftWyQ7lUfDq6Eucq5m1O46n5FZWqZYUjlh2Gq527DbJuj2Huy6iJpuw/
         koiI4t1vJinIWJBTGDxe3Fjj6oEWjEpixay948dMi45HkIOOWzC6LkwDpR7iw8jeF0Fj
         cY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275811; x=1739880611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s/3Qc5kj61ZYPHh1DjfYym66L0t2z7xf+S0LPTqjrM=;
        b=Y5AC0llFUEXBGMuINO9wPvO+IspRqZ4mr6oU+++1tpnKyR7IRzyLU/5pS5QFOV9meW
         y6wgIsdrrljyl5Ud87z4o9zIhjFiT4gt6OPGd/C8oNQ3ARzryo0baNmDc6FvwdWdamz2
         J0Br7G+uAUqFEw2jhxuc83d4xd6QMX5pq5wdQI45KkCMHLGRm2SE8njq1UZZz6XcYAI4
         ueQPkhe4E0vHQpt+78RT0mI/uonKh9dNLEHWl0ylKus/eXe1xq8/ew4qjLv+StU2+3WZ
         XY0i97Z6KXkt//EicnbZyHQzPZ896vbIz1yIoC0FPLYk8LpKm8rFkTOUz930793xOFI0
         wIlA==
X-Forwarded-Encrypted: i=1; AJvYcCXdEU+1yUt8TrBFNhdtW3qkQJ8/QfgCXaKcK81AcGLetjJ1tw11lrvOISJ0YMJ9jVOrgOsR81GVZWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCchnFnMv/kpWbaMzgg84iGT+5l8UYTRY8uWqyV0GBYFLBbhn
	f/Zhk175K7HZoqnSnaNAzJEsjEokNChEJ8c4zQrz1e65kgHnMTscYN4Jmk9yVKg=
X-Gm-Gg: ASbGncu8fj63Ce/7ygx4e4x8G4kMeRQ3TLHVga+HQM9yGDxuvovUMapy4TIq4ZiRJUz
	v2jMImVMQkgjYammLkwM+1U4+gVDpLX4hrDjQ7kbSrk9zn+ROWviOSE9kM4Y9rlDFUxU4oa/Wax
	nZuVvjiXhBiZ6rL8kJM1vt0zqFXc7vOoGN7Ux9Ji28o24U9uC102NbkK+rrqHE24RS6Rktk9AEH
	xAfJSk7XuWmSa9r4a32W2S0VnJEO9nkDyVYinXKXX5b4143L0MEK+VLuGQ4InzDnqbMuFVngERI
	ikSo4t4=
X-Google-Smtp-Source: AGHT+IEAg/pd03kYibzlfvSIvaqSVi+PbHjfA0+hJLFu7VnMhfg+SjjsM8kKANNRe9M0XCJR/yb96Q==
X-Received: by 2002:a05:600c:1911:b0:439:3f09:9f57 with SMTP id 5b1f17b1804b1-4393f09a24emr71567815e9.28.1739275811521;
        Tue, 11 Feb 2025 04:10:11 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:44 +0100
Subject: [PATCH 10/14] gpio: max77650: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-10-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=7Yn+9j8mSRoVcG++9lBVBUXAn3Cu9Rh2EzIAuG2CoYU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4XuECycR3qhOz/OYu84vZrJcUgcvNbq5Tw/
 AiFsff0T9mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FwAKCRARpy6gFHHX
 csV1EACd44PZNfM4fIZiQchYANBJsGiF5TjH6x92VBA9EbWxUhZHbq0f2O4Ts6dA9ax0RAGSIS9
 wvQdN6uEu+kWvZwFHQ/rl3WSMK+7hOkjHhd0oMNttZFzo2ZNtcZl0wK01L5joMszeWMDUtZSnoS
 kRXQQzk4mAlwbB6ptn7UXFyKiBmVJmQiuiiDDrVuoKLgpBZKqdv7hQD48slwxlchf3kgS0KIXFZ
 OdzSgZGr7f9XE4q2SSAxAD99q4aER6nZUpyY/ufo9rpY7xrcj7zNr0bii3QLdNLFlCbjROBl+mn
 7mtA+ctGns2QHZvZ4BVt/FVdDsIci4JkpHSR/luLp5/jLnMC11pyA+Z8sR1+ICDRCVVLoDufjBG
 awKgUEjiKWj0c7GLdN44qS2F3LU/+6E98ESik/eC6MBgo26o97V8xUIpKG/F7dtaYaqvUnomZx8
 HhGDOd6KWvJC+pr4/m4dUV4IEGJ7g/XouYcWL33Zv9HfkvX9TNiqCyIE9fMXq9aajYWS+2MJjLa
 nMYkFbSZKBx3STNd2niNXLth8tXt3r4ywbG9dcY7KTfjv8Pynj57ahcwj5ZFQV6huDX6IuvmZ9l
 9mun4hkh4bbkdeFMsHLVYbicg/UIGZYQWxu9vYYeJC+nMmMk/cIwrLU6FffkT9zo8WsnHeX2gS5
 3G+BFNOoyuFy0FA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

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


