Return-Path: <linux-pwm+bounces-4847-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5397A30B40
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B820A3A61F9
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42BC215793;
	Tue, 11 Feb 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lEoUAoGy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB52010E6
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275810; cv=none; b=tzFv8JL4EF98LbMAHa7EliG49BeMO7my7UFM/KBJvuv2fTohf9gvlDZMzqdfFbvn7YuSk3wL1XM+bex2fePu33U1SLxOjjuTcbXYCfH1eE0ECwajHCzfzrJ48zNw+8WiijPtYwk+dIOKGzINHp4RlZ34Np1SR4Y9lwEdUTZeU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275810; c=relaxed/simple;
	bh=zsSWhWJja5bjynEs4UeWrPkKMTggjfp9Yk48/oxvSbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTwzznGXgABB1IhbnP2fDC74Fsd8iGI3DT1So19HDPJmoo13xVOEyzeYsFI+quDRaAiqxwtyjqML78LToiOhMe4y8vVVgR2NrrNH5Xd9FVmtBvBi7eb/qFZqniBDlkr6wbwWxBf8SwpPFzPixHav3wN4SNa+B/Zh7nk2bZwkuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lEoUAoGy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439566c991dso1471815e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275806; x=1739880606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flGMeg5VushkPeMvEbQ8kx2w4d/f13NaDyOkOchHg9U=;
        b=lEoUAoGyb48BIo27r8qgfQKsPF48/7OYnHiIp5q941FoQRIpAplVsm67wGtgOJ1HDo
         dDUJyBKzKwBrZhEkFcrPH4w+WL/mzy9XBwgIbsQgGxSRf7SUEl+7Pq7k84PPZ0b+H6nK
         jJ/sHJRA+74FYoOBmVAu8/bo6NTP8NkzvSzlN4Ufkr/syZJ67f8kag7DYChrZ1kT//Ln
         DDO9Nff+w/o8oY+ngl7uLzUoF5kcSe3fndC191TGV3RVPkK56VLVaI3PPOXLQaoqOEh6
         OvtsSv8ndlnsNwMPf9KZppOcwA5/Cw8Yjfid2GGHq7QiKzK6778VwHxhh8niydlOetds
         ABJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275806; x=1739880606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flGMeg5VushkPeMvEbQ8kx2w4d/f13NaDyOkOchHg9U=;
        b=L5nX3ONgjaKbjZg7LVcvWK1gZfTavKu4iClW5kg3gdzjWFVurYwUsHn1EW+VM7SL/w
         6/a6xkIBE/Oi4FxM33nN+xEDvnqdUvGci7tsiQ09+I8KnKYmXwvBz8EomSXxnbaALI8z
         eRqQB5kacKdZbqx1yuZkL5XrmwbALgpDYbCSjjhRskUVVj6iQ9l+luyB8i3ozNrZQZdB
         C2xN2JILZqmlk8J5L6BqdqAWaPiaxvDxpZoVU98m6OtLzqF6KUaK37Nyb7dg0rA+QX2H
         KAXYPBYqE5sQWRNNnNKgfkkncqO6fOZ1YPH/m++gWVV0BP2fWmq0hll14G0Q0EpDZ4EC
         mflA==
X-Forwarded-Encrypted: i=1; AJvYcCWqigqysN/LenPM0wnuHb4jGlUEGDxiKtebRXKj/ak9TPpfg9ypLukCfiRDdZLwVQIkgbYRsFKsJNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQ31he5t+drkyRTQMciZtmtsbLj41adhKNt1zhWepnAz8B9Eb
	WE/XRhV1UXa47txjKIgfF58pY6U6Kk7UhpHpTRKIiK7IZGkg9MI+ZvDrRQT8ECY=
X-Gm-Gg: ASbGncv3GcPpB9PKaaMo99fJcWiLJycfn1cz7nWOdEoyuksdOYUEffJhrtZGEiWoN/t
	qNNCQA8NtXszYvGRsd2ONq4tXaLYB3ggEUwsqXZidz67LTXGJx0raWu+C9Sp+ZCd2EdefleSYZL
	Vnm/ZE9yS+USF8lKidB3WBPgGxFDogJb4ShyWqxmEQ5WxCwY9bLomSUO/JIGY2L7syqLtMbjbe9
	z7hS4yNH2d8TYFMsRYrNH8o3dAXgzoSgsOPIbWLFFsZi05pLjjZ5hsPnAWkWlcBwy60a80X6PSv
	cGbVs5w=
X-Google-Smtp-Source: AGHT+IHTtUOjwp2MTisEoq2qXc8kpIkQePo/nqKya2pkK2EtTcQmJ7kE6tNedkI1/cyWmwMVryFVRQ==
X-Received: by 2002:a5d:64af:0:b0:38d:d0ca:fbd5 with SMTP id ffacd0b85a97d-38dd0cb6a75mr12035035f8f.22.1739275806467;
        Tue, 11 Feb 2025 04:10:06 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:39 +0100
Subject: [PATCH 05/14] gpio: sim: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-5-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=qgip9bWI/vEDIjIxM48q+Vgy3ZpuucV2NIkQXo3Sfzw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4WLpbRPKvx2jxe9bpfi1dULTAbOwUCmEDdB
 m+aroirElqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FgAKCRARpy6gFHHX
 ctTsD/9hMGs8OBSM9c9QKMIU2N3W76nYowAseouI1RyUA+FmKsmnaU3/CjwEsNWSIRf2x2yciiz
 Vm97XxNXAsA1okzFjOPiKohXvzs5Ky0icjQZ0YNa62rWPGkDoHxukLyBpo6wJB/zZ0y2yiEML9z
 QRSZqM2RSVlJTnMLkF4anwAzg1M6fxekE/7LCvRLVcLOEEdDJvqZxT2YJcnsTWROiLDitisSejF
 zzVo+ez96hnJ5EKZitr8wZtpdiOMDDbwxQ0H6uiIKxaFspsTKqhDym2FhIhuOs43+MjgDT4iGeD
 rLpGRBi6feGA6xeG21X7XDzt3KtTGTWn3q5cpFwesaQ1cnYU64wMNlMZnu5NHPA56S4HAyUeisN
 b3w3ghuwseF1cPCygDHekCzQ5aSP8tfwaMou8mxUTJEL1CMfnqyoHzoxr5b8k3CPhAsgFhaiHSW
 dc5kQvu1a38iNssF11z24EqtRaw21yUZiMS2s3M5spL5RVJPtui4eqFX3+HK3IGIbKApgZU6sNP
 OHGZ/+mnO1nPcum/PvH+a2YjJlZiQwThnPXvMh3fWadt9K2RaUcG0BZfd5dWuPg9weH8wQXLK7N
 E5U0pdUYhRA2/nLG1s4Tsr93VxyxYXC1gw2lXCIoej+/rAj8INQgbfTNDFoZbXRlCGHLRZVT/yL
 dMcI6BRNXB752mg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index b6c230fab840..b3baa7e872bd 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -119,12 +119,14 @@ static int gpio_sim_get(struct gpio_chip *gc, unsigned int offset)
 	return !!test_bit(offset, chip->value_map);
 }
 
-static void gpio_sim_set(struct gpio_chip *gc, unsigned int offset, int value)
+static int gpio_sim_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
 	scoped_guard(mutex, &chip->lock)
 		__assign_bit(offset, chip->value_map, value);
+
+	return 0;
 }
 
 static int gpio_sim_get_multiple(struct gpio_chip *gc,
@@ -138,14 +140,16 @@ static int gpio_sim_get_multiple(struct gpio_chip *gc,
 	return 0;
 }
 
-static void gpio_sim_set_multiple(struct gpio_chip *gc,
-				  unsigned long *mask, unsigned long *bits)
+static int gpio_sim_set_multiple(struct gpio_chip *gc,
+				 unsigned long *mask, unsigned long *bits)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
 	scoped_guard(mutex, &chip->lock)
 		bitmap_replace(chip->value_map, chip->value_map, bits, mask,
 			       gc->ngpio);
+
+	return 0;
 }
 
 static int gpio_sim_direction_output(struct gpio_chip *gc,
@@ -481,9 +485,9 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->parent = dev;
 	gc->fwnode = swnode;
 	gc->get = gpio_sim_get;
-	gc->set = gpio_sim_set;
+	gc->set_rv = gpio_sim_set;
 	gc->get_multiple = gpio_sim_get_multiple;
-	gc->set_multiple = gpio_sim_set_multiple;
+	gc->set_multiple_rv = gpio_sim_set_multiple;
 	gc->direction_output = gpio_sim_direction_output;
 	gc->direction_input = gpio_sim_direction_input;
 	gc->get_direction = gpio_sim_get_direction;

-- 
2.45.2


