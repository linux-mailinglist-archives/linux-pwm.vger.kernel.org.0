Return-Path: <linux-pwm+bounces-4855-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3654EA30B5E
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F723A97F9
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9302505A2;
	Tue, 11 Feb 2025 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="C5ULmwlL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948024CEDC
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275819; cv=none; b=qmWszMDhWQkEHLWgCbO4Z/Ff4q0aWM2MO43iZ2BGA3UajrkUe7veToONS88ZTxVDSZ2HUYn4mEJEzFv5HL5yeu6S2rVl2/ORnGg9B7sv1LhbzNaRjtjsjUyXbgfICrGb4MtDrlXYNcwALlPVIEO/NiQGiqb5qDx8xIh0mUHGZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275819; c=relaxed/simple;
	bh=hYAYiepkLifuXDe4dZFy1Ie1vUXArX8PbVUCRbZM54s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFyvWPweIcmLq3ZuklRlGwHek9cOwLDoKnH7/5+TLJm7kAlcH9ZO1gt4JmE0TMqIVRRN2jg+QbfpeDEKcTiG8rIE7Os/Zg36iWvrE83D6ORNSyoUYNGTgOppcbdd4WD9DS/iTjhFHN0HK/7Jg9aGBiqOR4ETyZoGbF8bYWFKTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=C5ULmwlL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so4122547f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275814; x=1739880614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KToW2+Iuwbkj7Tb9LD01jCq8o7gpbrPrNmCFjVQZ3rk=;
        b=C5ULmwlLH41Fg2RfGHmFVEw+5YyiKHz4+QZT9nWG1PyItMo2FA9Cz7Rb75E6LUEpyj
         3+DI71cLv1PQ78A2epdI0naUGgqj+2WdY+MtmIF65lh3snhXV2iDq4Wn6nfG5EJUSOSJ
         RSQLxmzGIGdnqPiz8zZFEDFVS7lmJNK90tCuzdVboU8PKYoKc1B2Qv+gRvXHkI83F3ow
         05GWhue7FTfXK33FSje0urNIBlKmPjU5t/pmdtCa0HD0a76VhiNiO6DGour7EULEc19U
         1bkGa2XHhwY90hZtO8hI7hvY9GAFxxCvEwz5ex+micoitNjSvDI1hX9u6QgosWUwDe+Q
         E9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275814; x=1739880614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KToW2+Iuwbkj7Tb9LD01jCq8o7gpbrPrNmCFjVQZ3rk=;
        b=h+42fiv6JtGh09AGIwZDdlCslyMt8WgvWjoaOMNNFUGirSkW9OWIduGVvxSV+mVQnl
         7+1W/B+OHBXTSwV/MgyjMbNkqqi9PT/2cE47TRRQtGnPj3rUCSUusqyxojXj+YjvG1XG
         OwHbMVpbuTSMC0/VDewABX4XmyUEMY+EqkInGTHIlU/Y7biIYJpV2JVFHASjveJgPLn3
         HINTAhLmH9GTUeKcHmsjwmH+uCAqo6ys1h1CyL8+aX5O+nqw+0GenAteID6bRiqHqnnR
         P/m5dNEGS8y213FLwgugIHY+Tr1bMNCcOpPgb+2jdlo2kFVQGzVwvfUxhvBNcRXWIbnP
         q07w==
X-Forwarded-Encrypted: i=1; AJvYcCUnYwMYKnZuKfmpKQJuNUXx6u2P5cn4GHzzYJ/Z+r/UQECWeZrP2OfsgxSCPO9x6DUMeIQbY+SlKZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIjsztGKayzUrcwdJ22ZHPmD9E12bpRlnFlcdSvJEmHNTWb0q
	yEuTjimGhTnc/vodf1CjFP3ryJZjgcgn8zo+Uew17KXFJ/nMucXzF/Mho88EOT8=
X-Gm-Gg: ASbGncsRJXOQLEKzkLtOoihfsxgvr1jRGV1ia8sH0X8W2+L/58ygZPAFIuM18V3f+gJ
	sw2F81su3HEF0fGx8celcgfYDwds6wIiHptwGYAbFaZwl2rPGiL4ZHi5hl2/DniM0616JAywnCR
	JKpnZZXY8gFh63WyYVgiAbvHcaEUDWZGFPYmshqgsoGRcUKWBy1WKbxf5XX3tLddj7o4HAdVIET
	EdtNXaMaP+uE0bmiAtpT6LgGbBMhwNFAVYNsuVB7zPuAiK9de98nEVSAwrFB4JOarsDLNpanbp9
	1anm+50=
X-Google-Smtp-Source: AGHT+IHJ6iBxA6sKexsgFUuQe5kxoHmgCMwAZzbU3s1dj6rDjh0p2Dy+H3J23xXGryvIcW6W8LbGkQ==
X-Received: by 2002:a5d:5847:0:b0:38d:dd8c:51db with SMTP id ffacd0b85a97d-38ddd8c53d1mr7954281f8f.53.1739275813588;
        Tue, 11 Feb 2025 04:10:13 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:46 +0100
Subject: [PATCH 12/14] gpio: latch: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-12-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3126;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Q4wKnGN06mVNx83+jVe38nMnlEIw9AMAxQkGAiO4jL8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4YHvbrzPRog6+3l62ZLwv8JdJos+QTKG6Qn
 HfGHOzYgkiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+GAAKCRARpy6gFHHX
 cr2rEACwQK7T4mktMuHRmDpsb+OIcAdWyH25v0hXERhYnpMpctyE75kKnS9rnjYYqYA/IyDdzEX
 VeOc3YzTta/FkNK0x+L9K/SxGI9LH27W0RtraqHDu3nThmh6UXmDe9ecfRrjW9aUS1krlwHer1d
 EsL5WUlGiRagCwuD1K1rXw5rNq0EnZpFG9H7z6HasFRH2Z0cJ9+d9Ld5FNqdIuk9mUK78XLiZbs
 GqjB8bL9MADczFMVbwv1ElqkN72A2LSoWCORcPXQreOFcGSABiAZV829jLrIkRwA3/WZEf3AF1N
 C7W/NS7QhILUbFBa6Fq0ifHa80M6nSHNoRjQUw+82xkuE7WgWLVrO8h8B6jD+t+Jt3EaX6V7b49
 tfd7fTBGlLiPVIghiqKn/NTUXc9oWZ9GAN3DM5J1Yp/RwyeAPStbPb6X/IZ8yaF9bfFXruRCWFy
 xXAtujaCWcsHpHVWA7PjQqGiRg+Hz9gNccweZtlRtXsoKVowCND/NRzMCoYT9w5mhnikTOMXHlV
 iaE55DLOV849XbHTf/5YaFbAbr/wh97gTPAdUcL9BW23JxKD/rucOon8rXpmdTQoigoX+lpSFxY
 FBzcLaFu2S4swsMFxQb6XV4kPul8zp++bG59p++rBmndSC3Q/bUh0N6jEcXMDAh8hx2p9OOMOMU
 e26DuOjSzD2eqwg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index d5d3817eea67..184b7dd17425 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -72,41 +72,46 @@ static int gpio_latch_get_direction(struct gpio_chip *gc, unsigned int offset)
 	return GPIO_LINE_DIRECTION_OUT;
 }
 
-static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
-				    int (*set)(struct gpio_desc *desc, int value),
-				    unsigned int offset, bool val)
+static int gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
+				   int (*set)(struct gpio_desc *desc, int value),
+				   unsigned int offset, bool val)
 {
-	int latch = offset / priv->n_latched_gpios;
-	int i;
+	int latch = offset / priv->n_latched_gpios, i, ret;
 
 	assign_bit(offset, priv->shadow, val);
 
-	for (i = 0; i < priv->n_latched_gpios; i++)
-		set(priv->latched_gpios->desc[i],
-		    test_bit(latch * priv->n_latched_gpios + i, priv->shadow));
+	for (i = 0; i < priv->n_latched_gpios; i++) {
+		ret = set(priv->latched_gpios->desc[i],
+			  test_bit(latch * priv->n_latched_gpios + i,
+				   priv->shadow));
+		if (ret)
+			return ret;
+	}
 
 	ndelay(priv->setup_duration_ns);
 	set(priv->clk_gpios->desc[latch], 1);
 	ndelay(priv->clock_duration_ns);
 	set(priv->clk_gpios->desc[latch], 0);
+
+	return 0;
 }
 
-static void gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
+static int gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
 
 	guard(spinlock_irqsave)(&priv->spinlock);
 
-	gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
+	return gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
 }
 
-static void gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
+static int gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
 
 	guard(mutex)(&priv->mutex);
 
-	gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
+	return gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
 }
 
 static bool gpio_latch_can_sleep(struct gpio_latch_priv *priv, unsigned int n_latches)
@@ -160,11 +165,11 @@ static int gpio_latch_probe(struct platform_device *pdev)
 
 	if (gpio_latch_can_sleep(priv, n_latches)) {
 		priv->gc.can_sleep = true;
-		priv->gc.set = gpio_latch_set_can_sleep;
+		priv->gc.set_rv = gpio_latch_set_can_sleep;
 		mutex_init(&priv->mutex);
 	} else {
 		priv->gc.can_sleep = false;
-		priv->gc.set = gpio_latch_set;
+		priv->gc.set_rv = gpio_latch_set;
 		spin_lock_init(&priv->spinlock);
 	}
 

-- 
2.45.2


