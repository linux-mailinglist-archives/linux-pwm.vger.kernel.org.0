Return-Path: <linux-pwm+bounces-4953-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FECA3D5A8
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 10:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B0173095
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A879B1F4635;
	Thu, 20 Feb 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yesm87V2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8141F3FCB
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045449; cv=none; b=HwTzvZQDBAzPKqDrP0qOOPxaszG0z5zIjBuCPvC36PShR7lHK5/6GYlY2kPcU20epdkeHZspPv87FHz4Do+qODtwrTFveXfmQweesZZgVqfmXDDE8l6bSOll4zEuFZYERhAE1SWlhTaOcVa82viIR1dDupdW9J7aCByp1+AAjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045449; c=relaxed/simple;
	bh=TmP0k5HPQCdqL389PpvIw7B7tK6qz9kZjvgEhu4fMyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hU/cjFHFOTCEYc7jjNstR5Lc6PnhoTnwuOD3t1kGVM/pnciKZPeujkyeAO8WW/+u6xxQCFCONHp0whc3de7HK3PQVE2w2L36jxKxwdEWExTzgBlj7xa0h18+uqDRfmnIFCvCrdR46NyrWml03gGY+X1RvDwDF/nMH2MURfOB1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yesm87V2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f378498c9so619860f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045445; x=1740650245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuziGQJzOkugtw86e7xiCP6KsOvSbeOt4TTE+TF82Rk=;
        b=yesm87V2/4/5djCYvasUBC4tBdaf7+9aOGOOe9ik+Kzb29LD5AncW8kVsp+fubBRQK
         N1wPttEJ0r3vJ5OGMPn458b3VBlzIquFidfXVC4FbJ4oqtdrIiq47dwhrWZG0okLWCrD
         2aVo3VtbGPlyz3+MCOw9TD2b2aim6hu2vQJ/Y/RlmrFtZoTgOaZ/HK+fHNLGOkPLpDpw
         qSO3gNiHuWkpXwkxoLyVdZu9umSfzlSykaA5lj2/su4nfrOfIpowXqooofdLnGNmzzi/
         SGnl5vkcgbRec2Rd+4a4zfRJnCCuX64frf6gQxHaMq3G8QEFMHPcHTwxLw5cnE2u0sST
         aPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045445; x=1740650245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuziGQJzOkugtw86e7xiCP6KsOvSbeOt4TTE+TF82Rk=;
        b=GWLBI4k6X0B1N5l5Gy8ZoQdsk63KeGUPdFg8OFj6NsP9la5KStcOap72LjvJGSOvT/
         d12m2LYg9Cpoq9e6MH4ddyt+4lgHdGWkkIsdVEGV9HWFfWqfKYcLx6cnr0VFuFRmvPIa
         GXPUHEemE/D+zbjrea2+k6rlTOcxwScqEDGICqKlorUGRJrqshlejwNgOmUl9kTwUuu2
         CsH1S8Sd/m3K7t3tnRtk/VjY+6xVikp64YpB1FeP3bXZRm8ocA+k06+Gh38L/tEgEawy
         kARdxyeBEVKC8lzBJv0gs+fhcy/LiNHKjTxtEnJD1Yz0Jceoru1EyWCP3gVKMlKGB9Qr
         1pcg==
X-Forwarded-Encrypted: i=1; AJvYcCWuwtYlWOhDNud8onknxG1eGxS2cbd3RQr6oxTyfmYncKZsrdRkvKHkfk8htwWeclUkmnjsPvULZXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsNXzwb7tuq4IHO3VlxiUQriK3fypy2wzv1biNe4c+XYR3bWU
	fF/kxxHDHFP/EYZ6wjMitESWXf0JN/3+iqBTarNdxni5hQUCx9eY9atsBNT0Tl8=
X-Gm-Gg: ASbGncsevijV9iY9GuKWRAT657+/bNmYWxdFdubYNQ1GmTn1mc1KrQDO5fa/13o0vef
	c9xThh/ZgtjJV7PYWsowIwxz+EhlhPfJS2IMcY1V6a8cQ9f24PbT1DA7US/fipMKWc9YMfmUGRO
	7VUb5+IF1I8/H8sabHO+/HYky9rc6NkUaXmD0hJyb8qouSOCWPt41OU954efjXHv88fB4MvduJG
	VHTeixvknESXt+g8ai7Wn9szmPXIQ/2oCd43mzIz05mArbOEL5GxsIXkJjT4LLpg3E/Ox65J0Sp
	KSHKspU=
X-Google-Smtp-Source: AGHT+IFOrPsNvEbI/Noy1nmxNX4rgXj6wcOKeR3h7rQc3D1++qnkx4fkWCuudcUVv84PvYBRkH3+og==
X-Received: by 2002:a5d:5f4a:0:b0:38f:4244:68cb with SMTP id ffacd0b85a97d-38f42446bfbmr15072009f8f.12.1740045445473;
        Thu, 20 Feb 2025 01:57:25 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:07 +0100
Subject: [PATCH v2 10/15] gpio: aggregator: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-10-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=OqXkJ8DPtuYa+TTJfkSkhfgfLmb1fOijT4/aUsZYin4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx4lc+rIQA1AST2W7JzHn5CdLSLvvk/qQor8
 PiwjxZXolmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8eAAKCRARpy6gFHHX
 cvNmD/9VdT4q1IFgjnloyALjT1AZSjG7reetkWWQFXORYbCj26z5DqIA29dlYo0PNWjXAz5SiH1
 hfZV8gDBtup7shnRcgPu4aAXMJUjG12GsxjfM/NrnpPWzVlwABvlNptGgFjXrkGb1Y/bBED26fZ
 0NRVY7xE1Wn+wXJMaLT/J6692rp3T164No03/2EgCT8jHCyUd83h66t3JirzUNTv1mdNpowdP83
 zWaD751xUgfA4BE3g4fYZejxtTamrz2VyT845mHdZ6O3EAvJdBuKhaSOufxeI74zcN62faeRib6
 qrqX2hft/gFtsZP3VFGf1V8DRnN6LTa3yioMTviOUTmJU5dSOUKsliuenttcxEXTc8+AyeMDe2Z
 RAYsZ1yEds5Q0t7dvgAbVn4uVpA+20FeelfxGzFFPbKwlP6ttvj3K0QhTxEynPAYWmSZVhFOFFA
 fPnHMyMEZtTqbrUF5wPAoXjFz989kvzggV7KFxARaPV8icz4vBzNv0tU7hPsXJsTdbGyMt1iJoO
 Rs0HWIGElzTfAEeUs7aRahlndrZvzwQzbo0tvN8RY9AfuJzl1lJd3h39bbj4+4BlF2jCfGc17qU
 /e3AIIT+8eqV3z6bhOdhN1PiA7N6y3r2aQI9ojjQXyRCiCqBS/aHMs/MTuT5is7jWBWfLGBIsR+
 tw6uqZ0FKEqovwg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aggregator.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 65f41cc3eafc..e799599a06a1 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -358,25 +358,30 @@ static void gpio_fwd_delay(struct gpio_chip *chip, unsigned int offset, int valu
 		udelay(delay_us);
 }
 
-static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
+static int gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
+	int ret;
 
 	if (chip->can_sleep)
-		gpiod_set_value_cansleep(fwd->descs[offset], value);
+		ret = gpiod_set_value_cansleep(fwd->descs[offset], value);
 	else
-		gpiod_set_value(fwd->descs[offset], value);
+		ret = gpiod_set_value(fwd->descs[offset], value);
+	if (ret)
+		return ret;
 
 	if (fwd->delay_timings)
 		gpio_fwd_delay(chip, offset, value);
+
+	return ret;
 }
 
-static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
-				  unsigned long *bits)
+static int gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
+				 unsigned long *bits)
 {
 	struct gpio_desc **descs = fwd_tmp_descs(fwd);
 	unsigned long *values = fwd_tmp_values(fwd);
-	unsigned int i, j = 0;
+	unsigned int i, j = 0, ret;
 
 	for_each_set_bit(i, mask, fwd->chip.ngpio) {
 		__assign_bit(j, values, test_bit(i, bits));
@@ -384,26 +389,31 @@ static void gpio_fwd_set_multiple(struct gpiochip_fwd *fwd, unsigned long *mask,
 	}
 
 	if (fwd->chip.can_sleep)
-		gpiod_set_array_value_cansleep(j, descs, NULL, values);
+		ret = gpiod_set_array_value_cansleep(j, descs, NULL, values);
 	else
-		gpiod_set_array_value(j, descs, NULL, values);
+		ret = gpiod_set_array_value(j, descs, NULL, values);
+
+	return ret;
 }
 
-static void gpio_fwd_set_multiple_locked(struct gpio_chip *chip,
-					 unsigned long *mask, unsigned long *bits)
+static int gpio_fwd_set_multiple_locked(struct gpio_chip *chip,
+					unsigned long *mask, unsigned long *bits)
 {
 	struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
 	unsigned long flags;
+	int ret;
 
 	if (chip->can_sleep) {
 		mutex_lock(&fwd->mlock);
-		gpio_fwd_set_multiple(fwd, mask, bits);
+		ret = gpio_fwd_set_multiple(fwd, mask, bits);
 		mutex_unlock(&fwd->mlock);
 	} else {
 		spin_lock_irqsave(&fwd->slock, flags);
-		gpio_fwd_set_multiple(fwd, mask, bits);
+		ret = gpio_fwd_set_multiple(fwd, mask, bits);
 		spin_unlock_irqrestore(&fwd->slock, flags);
 	}
+
+	return ret;
 }
 
 static int gpio_fwd_set_config(struct gpio_chip *chip, unsigned int offset,
@@ -533,8 +543,8 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 	chip->direction_output = gpio_fwd_direction_output;
 	chip->get = gpio_fwd_get;
 	chip->get_multiple = gpio_fwd_get_multiple_locked;
-	chip->set = gpio_fwd_set;
-	chip->set_multiple = gpio_fwd_set_multiple_locked;
+	chip->set_rv = gpio_fwd_set;
+	chip->set_multiple_rv = gpio_fwd_set_multiple_locked;
 	chip->to_irq = gpio_fwd_to_irq;
 	chip->base = -1;
 	chip->ngpio = ngpios;

-- 
2.45.2


