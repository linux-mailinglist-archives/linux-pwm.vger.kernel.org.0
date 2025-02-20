Return-Path: <linux-pwm+bounces-4946-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E47A3D5A5
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 10:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4AA7A64FB
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C31F0E3D;
	Thu, 20 Feb 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LZE7nVQs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3191F03DE
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045441; cv=none; b=H6m8WcpvVud7sJ2OVJBR3FMf7VWshOcSD9EQY55kU/994ZwhgNrPD+SNVAzLtsS9XbmQluCA1lh6Hj3uVX95GO4Oj0m8EyYuH7JUt2hMoKn/nswZ9OPRjy8aIjDbFFQYd/pSBEy/NixdiBOJWLzJwF3KZUjbZEOqmeNYmLlnJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045441; c=relaxed/simple;
	bh=iO/ZbpMvZ02JRqCkfPBpteZT3vWeK7OdysnNM0BDtZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvoP+6QwTyzDDtCOp1/3r/uNq2XLFVRgzwM7xeCxVbyDdZukuSjtbmLA0v/M57flq9QGOgzWMjw5DCOrY1Kfo4G8qieCVcX4yh1tyrOifAgCUR3afJC4jt3QKic/WEeApnykB7EEBOs8vrDBO5Y74E5lBimCw3t8Ptot44o2w1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LZE7nVQs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so348473f8f.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045437; x=1740650237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAbjZEsyovWHnhnuIRi16DbT8cLgW12JjjHyyk7tJPo=;
        b=LZE7nVQs7IFhPcSCZ0CZeEm8zasfDud0HXRQVRKFoZWlrp4qcE6ilLtuLoz5EX+8JZ
         8gz/VZ+rOXZSMTQvEZOaV/nI2iUjQunYRJN6KA0YGbPnklEwIuWNIO72za8iiZ/ayyXd
         dq4OGQPyRFjNKn94qOXOo2Fq2TKFN1Jfs5ZSjJcReCzqR998AfSUFPUix9MD0GWnt3wC
         BqwApHG2ZWHtHUwdF2SfD+KD+sctgXeQepO3/1M7rBZoUC7ur1Pok9hPlnXkTZ6h87wU
         2UNfYtjb92VQK3MDc3FG//Il2B9OvpLrncF3nM3AlbwU7tU+Pg1EMVViHl5ZITgGCfvk
         Xlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045437; x=1740650237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAbjZEsyovWHnhnuIRi16DbT8cLgW12JjjHyyk7tJPo=;
        b=DzF2UmIfx6mXW/niLGsJX2JoZX/CzrjmhC9FXU8rtDRqBaAAoTpZI5txGP3/0YeV8Y
         BJwrBywZkCIrpVyXJENS9WmdzvykMLuKQpb2i5pT/uKH7ZaBbdYO69HDOfRlRlw0BcOb
         3DuCw3JGNcEqPq1Jf+Rz2pamGm84oKDHRCs9uCbYoa2Li+ULiWdiNWlKDNfxGQqRLq/3
         sQ6dcM2fzCs3PTz9ORKZCO+RI+o59S8jMonL8jo3xJyYXizg4cFkgzNAJQ6M64upXqv5
         N3YfKyhouLp3pIMd4+MItFsFdxTlDoFoYYAF91eEhkn3iiuL8rIvprfENUlgZEMIxiZI
         AzMA==
X-Forwarded-Encrypted: i=1; AJvYcCV7INN5hmsBU3ypY9OQakYNHoBXZxASS0uTCQk3krWA0c7NDrQM6EU2p8yUydfkQrlBO+Qzf5gSaYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzfj9K5tf9tHKv72rPJwvAx8x+HQGM0tT7Jg6itgXQ7WQbInzF
	/RFPEONc359EkJT+EnjTYHb8+l/H32a5dy4HU1cvLRWvkIHJN5rHAkrFhqKV47g=
X-Gm-Gg: ASbGnctRh8HkKKOWeG9+3QEdfmMoQOeubIT9Jr5x7UaKJovex5rCyHWV+Rdnh8siy98
	xVhD0c7Z263g0zqa93tU+A30VlTHAKMRxhEs75qfNb5bhpzNO9zxCcEvJASvLIcqzrY3qTwbG1P
	McVKwFP9SS30kOnrZdMwPzj0y4nzmnQ8HUYDrdLMYkOEHs2rfaPqQsUjQXTOwBuqMnkSxikxFyL
	gET+IYHW6xJDCisnf5D1fmohNo+qiVvBhr3rhiRnM0c3mO7DqZAnsYv9lPIKDeH40SbEI98uuqt
	hvCsRcE=
X-Google-Smtp-Source: AGHT+IG5BbyoigVPB4H90q685mzj9qEeNBW2m9Kp/DNWxK7ykBjIOJ5A2hfa/IcK//xPSW2E7ZnkZQ==
X-Received: by 2002:adf:e8d2:0:b0:38d:d603:ff46 with SMTP id ffacd0b85a97d-38f33f1c86fmr15011096f8f.14.1740045437112;
        Thu, 20 Feb 2025 01:57:17 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:56:59 +0100
Subject: [PATCH v2 02/15] gpiolib: make value setters have return values
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-2-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11632;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=gHQNRRs7OqLd+yRQPCZEx3EYSJvoT3gylIXinac1eso=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx2XKvoHEC22D24BWdlPEFovVL26UxJ5fipn
 kNJXttemTWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8dgAKCRARpy6gFHHX
 cooHEADGQUNaICr47kZlYSbFnf1TF9rYgWpKy3wu9evpIF2GrZWUNoF59nooKLAyRKNf/WnaZ4N
 xN5xMQYrdHldE7NocU43m8UaC9k6QW0eVhs0TwW76PSK2jpPYMCUK/0dc4N0f617mrYSY3x4Hlo
 eZhZwpyclDrh98dlFa9GkVkb9aBE85fdOqDBtDdqzOuCM/90hbxT5Op1+UQyfwFSG82+xP3Wssf
 U9XrIzSFVprFb7SeHz4CF93a8CbRfHWLb2P2v39IOa5afUAE8w5xSp7N5WYqT5uINXj//Xm6QmL
 qMVB4xw+FoAWMdEC4CuH+BxD53CZzlO+QBGjVnR8cWfEpBwI/PNthZwmXmYuXQPsVNvJQ2UESjh
 opICYQ3aC2AY76Q21sbL+Qg9ixW1hd3F2R0MWw0HFIU5jZkk4HMftSOQjY0EQ7e+nR36vCU2QRf
 vp75fTlbq3h7AHgCQZLrpqNjeHeKNwjObC2+ciRHhmv6fGIooSpDallwNSZCmm/xuuv96bUcQW6
 E9JhiK8wS5MGP4LsXtXWHXnHFWzQaX/osqc1tzsRQh1DXMckSeabVCvnviEwK6fDzORkIGzXmaR
 SPyKKGHWdTGRhot/mTfN8GEImkDlrkU3hJG5H01sYfG1rfW5mRl+7vW3f63RAVVsd8OmrFlGaQ9
 dcjXjvmk/wqYudQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Change the in-kernel consumer interface for GPIOs: make all variants of
value setters that don't have a return value, return a signed integer
instead. That will allow these routines to indicate failures to callers.

This doesn't change the implementation just yet, we'll do it in
subsequent commits.

We need to update the gpio-latch module as it passes the address of
value setters as a function pointer argument and thus cares about its
type.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c     |  2 +-
 drivers/gpio/gpiolib.c        | 53 ++++++++++++++++++++++++-------------------
 include/linux/gpio.h          |  4 ++--
 include/linux/gpio/consumer.h | 22 ++++++++++--------
 4 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index 46cdfb08747a..64174ea7d008 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -73,7 +73,7 @@ static int gpio_latch_get_direction(struct gpio_chip *gc, unsigned int offset)
 }
 
 static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
-				    void (*set)(struct gpio_desc *desc, int value),
+				    int (*set)(struct gpio_desc *desc, int value),
 				    unsigned int offset, bool val)
 {
 	int latch = offset / priv->n_latched_gpios;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 704452fd94bb..0a47fb38dd61 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3405,13 +3405,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value);
  * @desc: gpio descriptor whose state need to be set.
  * @value: Non-zero for setting it HIGH otherwise it will set to LOW.
  */
-static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
+static int gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 {
 	int ret = 0, offset = gpio_chip_hwgpio(desc);
 
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
-		return;
+		return -ENODEV;
 
 	if (value) {
 		ret = guard.gc->direction_input(guard.gc, offset);
@@ -3425,6 +3425,8 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 		gpiod_err(desc,
 			  "%s: Error in set_value for open drain err %d\n",
 			  __func__, ret);
+
+	return ret;
 }
 
 /*
@@ -3432,13 +3434,13 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
  * @desc: gpio descriptor whose state need to be set.
  * @value: Non-zero for setting it HIGH otherwise it will set to LOW.
  */
-static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value)
+static int gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value)
 {
 	int ret = 0, offset = gpio_chip_hwgpio(desc);
 
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
-		return;
+		return -ENODEV;
 
 	if (value) {
 		ret = guard.gc->direction_output(guard.gc, offset, 1);
@@ -3452,16 +3454,20 @@ static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value
 		gpiod_err(desc,
 			  "%s: Error in set_value for open source err %d\n",
 			  __func__, ret);
+
+	return ret;
 }
 
-static void gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
+static int gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 {
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
-		return;
+		return -ENODEV;
 
 	trace_gpio_value(desc_to_gpio(desc), 0, value);
 	guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), value);
+
+	return 0;
 }
 
 /*
@@ -3619,12 +3625,12 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
  */
-void gpiod_set_raw_value(struct gpio_desc *desc, int value)
+int gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
-	VALIDATE_DESC_VOID(desc);
+	VALIDATE_DESC(desc);
 	/* Should be using gpiod_set_raw_value_cansleep() */
 	WARN_ON(desc->gdev->can_sleep);
-	gpiod_set_raw_value_commit(desc, value);
+	return gpiod_set_raw_value_commit(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
 
@@ -3637,16 +3643,17 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
  * different semantic quirks like active low and open drain/source
  * handling.
  */
-static void gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
+static int gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
 {
 	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 		value = !value;
+
 	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
-		gpio_set_open_drain_value_commit(desc, value);
+		return gpio_set_open_drain_value_commit(desc, value);
 	else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
-		gpio_set_open_source_value_commit(desc, value);
-	else
-		gpiod_set_raw_value_commit(desc, value);
+		return gpio_set_open_source_value_commit(desc, value);
+
+	return gpiod_set_raw_value_commit(desc, value);
 }
 
 /**
@@ -3660,12 +3667,12 @@ static void gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
  */
-void gpiod_set_value(struct gpio_desc *desc, int value)
+int gpiod_set_value(struct gpio_desc *desc, int value)
 {
-	VALIDATE_DESC_VOID(desc);
+	VALIDATE_DESC(desc);
 	/* Should be using gpiod_set_value_cansleep() */
 	WARN_ON(desc->gdev->can_sleep);
-	gpiod_set_value_nocheck(desc, value);
+	return gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value);
 
@@ -4084,11 +4091,11 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
  *
  * This function is to be called from contexts that can sleep.
  */
-void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value)
+int gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value)
 {
 	might_sleep();
-	VALIDATE_DESC_VOID(desc);
-	gpiod_set_raw_value_commit(desc, value);
+	VALIDATE_DESC(desc);
+	return gpiod_set_raw_value_commit(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_value_cansleep);
 
@@ -4102,11 +4109,11 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value_cansleep);
  *
  * This function is to be called from contexts that can sleep.
  */
-void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
+int gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 {
 	might_sleep();
-	VALIDATE_DESC_VOID(desc);
-	gpiod_set_value_nocheck(desc, value);
+	VALIDATE_DESC(desc);
+	return gpiod_set_value_nocheck(desc, value);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
 
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 6270150f4e29..c1ec62c11ed3 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -91,7 +91,7 @@ static inline int gpio_get_value_cansleep(unsigned gpio)
 }
 static inline void gpio_set_value_cansleep(unsigned gpio, int value)
 {
-	return gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
+	gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
 }
 
 static inline int gpio_get_value(unsigned gpio)
@@ -100,7 +100,7 @@ static inline int gpio_get_value(unsigned gpio)
 }
 static inline void gpio_set_value(unsigned gpio, int value)
 {
-	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
+	gpiod_set_raw_value(gpio_to_desc(gpio), value);
 }
 
 static inline int gpio_to_irq(unsigned gpio)
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0b2b56199c36..51ab6728a998 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -121,7 +121,7 @@ int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
 			  struct gpio_array *array_info,
 			  unsigned long *value_bitmap);
-void gpiod_set_value(struct gpio_desc *desc, int value);
+int gpiod_set_value(struct gpio_desc *desc, int value);
 int gpiod_set_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
 			  struct gpio_array *array_info,
@@ -131,7 +131,7 @@ int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
 			      struct gpio_array *array_info,
 			      unsigned long *value_bitmap);
-void gpiod_set_raw_value(struct gpio_desc *desc, int value);
+int gpiod_set_raw_value(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
 			      struct gpio_array *array_info,
@@ -143,7 +143,7 @@ int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap);
-void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
+int gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   struct gpio_array *array_info,
@@ -153,7 +153,7 @@ int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
 				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap);
-void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
+int gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
 				       struct gpio_array *array_info,
@@ -360,10 +360,11 @@ static inline int gpiod_get_array_value(unsigned int array_size,
 	WARN_ON(desc_array);
 	return 0;
 }
-static inline void gpiod_set_value(struct gpio_desc *desc, int value)
+static inline int gpiod_set_value(struct gpio_desc *desc, int value)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(desc);
+	return 0;
 }
 static inline int gpiod_set_array_value(unsigned int array_size,
 					struct gpio_desc **desc_array,
@@ -389,10 +390,11 @@ static inline int gpiod_get_raw_array_value(unsigned int array_size,
 	WARN_ON(desc_array);
 	return 0;
 }
-static inline void gpiod_set_raw_value(struct gpio_desc *desc, int value)
+static inline int gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(desc);
+	return 0;
 }
 static inline int gpiod_set_raw_array_value(unsigned int array_size,
 					    struct gpio_desc **desc_array,
@@ -419,10 +421,11 @@ static inline int gpiod_get_array_value_cansleep(unsigned int array_size,
 	WARN_ON(desc_array);
 	return 0;
 }
-static inline void gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
+static inline int gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(desc);
+	return 0;
 }
 static inline int gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
@@ -448,11 +451,12 @@ static inline int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 	WARN_ON(desc_array);
 	return 0;
 }
-static inline void gpiod_set_raw_value_cansleep(struct gpio_desc *desc,
-						int value)
+static inline int gpiod_set_raw_value_cansleep(struct gpio_desc *desc,
+					       int value)
 {
 	/* GPIO can never have been requested */
 	WARN_ON(desc);
+	return 0;
 }
 static inline int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 						struct gpio_desc **desc_array,

-- 
2.45.2


