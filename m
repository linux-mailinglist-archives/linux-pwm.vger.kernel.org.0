Return-Path: <linux-pwm+bounces-4843-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBFA30B33
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858347A173F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14F1FCCEB;
	Tue, 11 Feb 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cEfiGe2o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FA1FCF72
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275806; cv=none; b=eWUPaVBN9GgcMeLg2cxUfxfYSFLOYuJXwGiwSbgNBXsQjX6Tjrt47bx5JqAwkCHVAGd7HRqUbyHfUp0FMtl9BgWic9KKHCM3+gCEOGdFQ1EBekyV9NjQ+zYpELErGY+ebFed56LLFyfwZMDBjq4RRiniOx/SOSdGeqMHlLK70sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275806; c=relaxed/simple;
	bh=MMkb4dRX5zMhwJcQDReE7WPl/llXU9kqfg5byg6F6mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOYpm8fXA3G2Cup7xd35OU1gDxyQpEo8NFmb+bmHS1h4lum1k8vMRIhLZZGr1iGwqKtR2/ZZkYYTTrrQqOUFQmxLS92uMDQkMLKZ6U+lhs0oaLwUiyduPGbyw5lB5Gv3iHXqwibjUE5Bm5NVn/cR5J6DUxRGSEgE8OzdgCOt29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cEfiGe2o; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dc6d9b292so2298858f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275803; x=1739880603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEDRUvF1p1hAfOhpGhc4T564238TZHGEZmhtJoahJg0=;
        b=cEfiGe2ormQCqinwRfQmpo6Vpuli+KpXWhnIt7K8LZR2omtXWt99iCNDgNLDMLNNU9
         Vnizla0xFZ4bJk/7LvhJ1gEviO+blHCdTVKW8NcZEmMReR6hZI4LKl6c5+Tzhim/MZgu
         o3nEKJ1Q6/wWqksK5wShJmPlAqjvZwG7IPbBPIxRBpjJoDqtjl2Gi9kYq0n2glP1jeKx
         1DuKxw6KPyA8esW6cjI5XDKzv44xumJ1ZC0n65E2d+jmPbQQXlp7/bg5G6p/U1OaUVSX
         8Blcz4Ki8OVWaonKco7zYA5J5ckO/fAYmej7bDtSbPB1Xn+LJB2A9F7IGKqv/I0gwrBf
         1LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275803; x=1739880603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEDRUvF1p1hAfOhpGhc4T564238TZHGEZmhtJoahJg0=;
        b=WnHlUiUK3ufexip0ECE9ThmqEvJYZVHuPcyLAgOZ+EeoknuD/M9BU/WlBOVgtlCltT
         m/Kdc5x9vIMBwjIYzOuFl1nQ5bl/3kReZGUxVBnzGIKyjsrw76ijyRNTb2kEweVdB/vK
         yirJYEoSuL9Vj07Uug7ECRsIVP6LMA6F2bX+cMDdNAWRZrHO1yp/Z3hFZAg1hpztn6KM
         8WL1LasdQmIGL2w8NAt+mYiYJ/pnc41RAUseoE8cWa8XP6CAMgazZEgT+IQqXGEA/wop
         1ge6+Sq3HAzVLqR2bSbbe7D1MAsxOra/QtJjBFZz+2JZXk23TNVBV845jdjpZ8s8HyVT
         TXrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NOwxoIVp/Lz76ieCfsDOyczKhk+1p76iqfiwKmsUYXJRjKOJNfgYldF521SjXvDi7534MiJioE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhyUaUNtFwTs3/nkUOIz4hfcoAKrTzNHEDr6tcIpxDDzcDo6Va
	A2CAjAHq1eVR6f/jQ7lu5n/aYS1cjhRU+AZZk5B2orzAO0usMUHDpAZsd/pLp20=
X-Gm-Gg: ASbGncvknd3wmV0LTCMz5gU4wyp2a9VidCHYkYRo7mOp/hivDxMqKwBmhnR1rjnnkOT
	mGLw00gkCvO1E95/jDGFc1jXfZvXkE57L6GOebd6UPV4JnLpsIlcdMHqaQFPuwDTN9B7MJFWbKJ
	ylrlLQAnZEJlTF0uz94KnOgoj4GY0qPVdr4N/4duTqXPO/nabMLO3wMe2EVqJl96nrEiuGnYDW8
	MqVmPBOaVlkPv4wNtyxU9HOC4DoJUhFqxQGfBw8rVpjB+2bzRhxz7M8114GmaoYmDoL8tKqVUEp
	WKWPaXw=
X-Google-Smtp-Source: AGHT+IGbXPVGWi7Igz/keya3LWr0E2YRzBTraUZk7q4L4t7TU0QIroRHD06D1dZYCV3EZu+jd8mtYg==
X-Received: by 2002:a05:6000:2a6:b0:38d:badf:9dec with SMTP id ffacd0b85a97d-38de41be928mr3219861f8f.38.1739275802566;
        Tue, 11 Feb 2025 04:10:02 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:35 +0100
Subject: [PATCH 01/14] gpiolib: make value setters have return values
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-1-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11577;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=QVcgCfBIvLr0n9gb/kFfsTwOztz1FuXZwUfXaqOWYsY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4VW82RuRMVMesp/5yKWucPbtOOpyBV1YpnL
 Nkdr1ZmaCCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+FQAKCRARpy6gFHHX
 cuEsD/9fM2MIJuFPOrpuztTyDrN6tM+lV8fL+205K8GrWizVU0xenBmWDMULVLH/zH9tJXV4H97
 9P0FNayLCrkGyP/Z9N5QBPskF+FyiY9dJzs2L+92eeT1m0SZ8fJLNN08Y1A9dLui9wOuME4VHYa
 LutSNpMxDKfGE9RwUIkIFTwq/Hhb0Ia99ozZ7z4fT53VkzR2Z4amk7bzGv/DEeTg3o8d0ZCGx9z
 YAu7kUV6nZOyU/Omd9wKbjb+DuD/ewlA1bCWqCgkeszJScEjvyzltwkgiE0t7UvlmiyFm4CBWYi
 oN/1F3CgAtLBclcPdq59SC3PrRudMB2pvVMsN0g2VYf1QCWH1z9RLPy/6CT3Bq+I+WZ9GpITBAJ
 h9qgLGMQXJR7eBoc+zDzuEYoGwjrv1xxy6i4QwKgtpYuAgemw7iCaDc0i8sxFNwimCsod4FtlKQ
 pwWQYIENBKEr8Dmz4KSULSBBdHvJ/auWGmioysSHdXiPg9zHCL46JjFI5pWSnQGGTDvBaQPZJ1u
 PmMjeFVuL1flL5h/2D3rpEI8wVdso6mw9mcQ/nuMrAo1XceKex92JZmc0bbk9VmQHHo1KIo/Tb9
 mUi8B2E9PxjsFmQvNzf9TwAdzfwwlXBJ/mJrhIqstieY9ARZYdy1N2SKQMjajAlcdFo0Y3ZoihL
 OYsLf8lDXdd+ZzA==
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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c     |  2 +-
 drivers/gpio/gpiolib.c        | 53 ++++++++++++++++++++++++-------------------
 include/linux/gpio.h          |  4 ++--
 include/linux/gpio/consumer.h | 22 ++++++++++--------
 4 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index d7c3b20c8482..e935b3b34117 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -72,7 +72,7 @@ static int gpio_latch_get_direction(struct gpio_chip *gc, unsigned int offset)
 }
 
 static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
-				    void (*set)(struct gpio_desc *desc, int value),
+				    int (*set)(struct gpio_desc *desc, int value),
 				    unsigned int offset, bool val)
 {
 	int latch = offset / priv->n_latched_gpios;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index be3351583508..f31c1ed905c0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3383,13 +3383,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value);
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
@@ -3403,6 +3403,8 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
 		gpiod_err(desc,
 			  "%s: Error in set_value for open drain err %d\n",
 			  __func__, ret);
+
+	return ret;
 }
 
 /*
@@ -3410,13 +3412,13 @@ static void gpio_set_open_drain_value_commit(struct gpio_desc *desc, bool value)
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
@@ -3430,16 +3432,20 @@ static void gpio_set_open_source_value_commit(struct gpio_desc *desc, bool value
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
@@ -3589,12 +3595,12 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
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
 
@@ -3607,16 +3613,17 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
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
@@ -3630,12 +3637,12 @@ static void gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
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
 
@@ -4054,11 +4061,11 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
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
 
@@ -4072,11 +4079,11 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value_cansleep);
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
index db2dfbae8edb..4a87c24686e3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -119,7 +119,7 @@ int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
 			  struct gpio_array *array_info,
 			  unsigned long *value_bitmap);
-void gpiod_set_value(struct gpio_desc *desc, int value);
+int gpiod_set_value(struct gpio_desc *desc, int value);
 int gpiod_set_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
 			  struct gpio_array *array_info,
@@ -129,7 +129,7 @@ int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
 			      struct gpio_array *array_info,
 			      unsigned long *value_bitmap);
-void gpiod_set_raw_value(struct gpio_desc *desc, int value);
+int gpiod_set_raw_value(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
 			      struct gpio_array *array_info,
@@ -141,7 +141,7 @@ int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap);
-void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
+int gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
 				   struct gpio_array *array_info,
@@ -151,7 +151,7 @@ int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
 				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap);
-void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
+int gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
 				       struct gpio_array *array_info,
@@ -375,10 +375,11 @@ static inline int gpiod_get_array_value(unsigned int array_size,
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
@@ -404,10 +405,11 @@ static inline int gpiod_get_raw_array_value(unsigned int array_size,
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
@@ -434,10 +436,11 @@ static inline int gpiod_get_array_value_cansleep(unsigned int array_size,
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
@@ -463,11 +466,12 @@ static inline int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
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


