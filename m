Return-Path: <linux-pwm+bounces-7169-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E549CB3597F
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C231899684
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E6322A03;
	Tue, 26 Aug 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="l3BnuU5f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0A31986F
	for <linux-pwm@vger.kernel.org>; Tue, 26 Aug 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202088; cv=none; b=mTLntu4q7jlo0LAeOIDLh8Wexs9NqzYsp3AX/duiqWqvo4duATPS49zbrQ+zCJ7b/67qgm8m7SqJXGkc0+fXsQfRIxlOrPSpbSbR+9IpASspmrJbR8ew3sYMfyeqPEVQVQ1LkN8UI1mHxJG7SCL4xMxpyS8dcXMMbcSc07tHZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202088; c=relaxed/simple;
	bh=RPdlxmA8pQzezikqTMuokP+plWsLo1uTn6qI2eFWVGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QY3xyD8YWINu5DYdovughUSoIvooOEMKBodC/8GUyZkyG9PMZmAQDKE7eDs4qxSlKbPtHM70zMwIzLnQqM5jCx30iSqPkqyc3bAQ+jZI0dCtFitQBoPO2vTKaFZUBisCmL1aYNtPX4RwMySvvt6+YsKppmzWDz37cwL7oAHN9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=l3BnuU5f; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so2676361f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 26 Aug 2025 02:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756202085; x=1756806885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpYS93HuS2Ws4ibadqFyYNPcNkc+D/2ZRLQIn3G55gg=;
        b=l3BnuU5frjykkkArGkg9JD+wva46fo7SZxUGXx/m6M6jIG1R9Rl8P+lUbFMIo8Jyhg
         mGzQEVM6D3HZbiE2sEkltW99P6o61cjon0gDdfQJ/xwTqIYPWi2H5HFq7tRViik33Cor
         hVaE9LHRB9ec9fWl4lz8qWd9xTqnzinUcrby5DTlMo6Gz/g+o6WO+rlCP+VYYMNxWkhc
         mH2dDDae2e8kX/Mv1tn97KmcX6MATOhESnHN/xWvXOzAbSiEFT8MlRBFvV2t/wBtQH3m
         IcphwMZLEkiYUYz9vSRtrkrDulKCJhQptoJzngYoyFMIOQWYaQNV1Fwd9LrkPN4dxvBO
         1S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756202085; x=1756806885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpYS93HuS2Ws4ibadqFyYNPcNkc+D/2ZRLQIn3G55gg=;
        b=LQ0YK/Fv3GwlT8plHoStQGfLOGyC3D14i6M24Dyj/U7KC8H6Lald3hOK/BlxdNlWKm
         6RY1BNSIyu06A0dlWt2ciHgKFyHi+/m4btjfXupI5oM0rmnszd8yyUgpejLq/dT4fjBK
         UKL7Zpjc5GBgaN8NllSMtz4KTSDANPXX0A1V+E4R5u7FCPtd9p5lLZXh1CNia9CCPkLP
         fY0uufYBJdSV+4xCEyuDhNvtSAcJvb4MniMLxAmhTQymTP54jCQg3+tvSqUh42/u08Hk
         HH8U8UzlA1rrRF1lhB/1s47tvXeawd2ZZyk1f1nDhZU5s5PePuggziDekY9oVAzC8oip
         pxcg==
X-Forwarded-Encrypted: i=1; AJvYcCXPAWklHx4LTyg3wGWKJyle5obSjb0cpraUJyjE7txobT74T70jebDkH7pGQAqXPRYgDXGz+1Hzk1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFz1W1jm2WK5l+OkuXjWHTo7nBfVTHAC2bYaV/c5KqhWYCSyt
	zBexWnwNMsls+vjME8a632N1F0KQsTifBQkoeNRbnJG7qQ+gwg95vvYTDCXiE4m9cu0=
X-Gm-Gg: ASbGncu/rBYoq/0517ZyT0yBAO5XtSBGM63iRUoUxQZtxhwaav7ORddTfZUidr9Mstb
	tofEbJoaB/RSBSz5Z0OZJ0vqorDc/Ov9ZPKykCu+nwsh4ZGJ4ehT0Gp+Tl8I+Dlr2eD/yXZ0MiZ
	8Sx97UiPfpBc7CABCF7MxWhM0UcPoVPGjkfJ66HdLvo9d/lIgSHv2pia2V+rQUVFIUOeaulNzyQ
	Hj1JqHePV/+ttVJqKUWRmCopVV79WLyjXUCAZzZuu4mim6njvuMNZ2IgUhgMphNbXHCmdt65TZw
	XktzdAFOwBFN0cX5f58ie1qiSFBsOJgB32g93GB3Ze74OwtUSee2SyJbny5xi/4m2XqCuQWdLyB
	HnkTgKrMB6EILLjUObBfppMxR2WGd
X-Google-Smtp-Source: AGHT+IH+zImocM00pe6xCRWyWfzSwlePAUzY6aZ/dvMer4YnerGXKYc/WZlxM7P5Y+5mqjP1ZLVAkA==
X-Received: by 2002:a05:6000:40d9:b0:3ca:5a3f:4182 with SMTP id ffacd0b85a97d-3ca5a3f47cbmr4448457f8f.63.1756202085222;
        Tue, 26 Aug 2025 02:54:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5977sm15708447f8f.51.2025.08.26.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:54:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Aug 2025 11:54:36 +0200
Subject: [PATCH 2/6] gpio: nomadik: don't print out global GPIO numbers in
 debugfs callbacks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-gpio-dbg-show-base-v1-2-7f27cd7f2256@linaro.org>
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
In-Reply-To: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4312;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=oBcKb5RM1YnckG7cnSsJVl/Lpv59j4+skQx80n0XNRw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorYRgtssbMNuvtdq9VaXj9texeQjs6T84FYRzh
 GIOLMeOaHOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaK2EYAAKCRARpy6gFHHX
 cqp1D/9DHh5rBMhO3+JDLKv38OKZVQIWchApIdXx916/Wf5pq10ueE3pLb5m4Vvikj3RHMIu+iy
 u+F2qBtWL9EmQqGOhRB9PF3Eg02DRPX/bg+4lUWsKZp+7wvOYpkcLeFAuh7QxiOU/QrIDBpqYP8
 DYikMquUwOx/GfXEFHSj4poi7RRQGmWXMwlppIcoyEB03q+mQ1cSNmaFUCEJLLJcNHq0N5Trf0A
 Xt8XmE/QBLi/OXEM0i+IKbaZbsyBlBjitj1gxGJE7QwyyCUbaD7KPYkIS7n0uBlocqCGcG6WzFc
 I1cGSIGXVmxEGbOyDn0CTIK4lFcT3lS1KHH/4FmNKYxwyIpuEyO8EUjvjz/tOjdnmWXtqGnCFF1
 DudpHu4USyrl59LUT98mAqDQAjAuFdXINsoBJ7ZJKUoXyrk3Oko+P87+tQe5lB2TW/72TQL+9wr
 F15l/ynM6W7UkXSgTllBhtbdawKwKlM/7ZRlkG7KV1KoVC36SPl4bBbu36JoB2k9R48IELQs3iJ
 o3N3fZ3GGG+NzjADIoJaDXKcpgJkIeCvwSSmJWOZE4ZGyCL6ugws4pkhiykdjA09jQTKUFTJf/X
 aBnefpuUk7NfMbDt+V2JwNcvjp4XUkQNGD0uL533DMg7drYCwBrKkmb4YqeamMzb7QMYllOGPQq
 eeDaj8vM/Qle7eA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to further limit the number of references to the GPIO base
number stored in struct gpio_chip, replace the global GPIO numbers in
the output of debugfs callbacks by hardware offsets.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-nomadik.c               | 25 ++++++++++++-------------
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  2 +-
 include/linux/gpio/gpio-nomadik.h         |  3 +--
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index bcf4b07dd4584f884992ae35caa8aa1aaacb619e..fde4b416faa81816ee554f85e5665f16d5defa06 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -20,6 +20,7 @@
  */
 #include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -396,10 +397,10 @@ static int nmk_gpio_get_mode(struct nmk_gpio_chip *nmk_chip, int offset)
 }
 
 void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
-			   struct gpio_chip *chip, unsigned int offset,
-			   unsigned int gpio)
+			   struct gpio_chip *chip, unsigned int offset)
 {
 	struct nmk_gpio_chip *nmk_chip = gpiochip_get_data(chip);
+	struct gpio_desc *desc;
 	int mode;
 	bool is_out;
 	bool data_out;
@@ -425,15 +426,15 @@ void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
 	data_out = !!(readl(nmk_chip->addr + NMK_GPIO_DAT) & BIT(offset));
 	mode = nmk_gpio_get_mode(nmk_chip, offset);
 #ifdef CONFIG_PINCTRL_NOMADIK
-	if (mode == NMK_GPIO_ALT_C && pctldev)
-		mode = nmk_prcm_gpiocr_get_mode(pctldev, gpio);
+	if (mode == NMK_GPIO_ALT_C && pctldev) {
+		desc = gpio_device_get_desc(chip->gpiodev, offset);
+		mode = nmk_prcm_gpiocr_get_mode(pctldev, desc_to_gpio(desc));
+	}
 #endif
 
 	if (is_out) {
 		seq_printf(s, " gpio-%-3d (%-20.20s) out %s           %s",
-			   gpio,
-			   label ?: "(none)",
-			   str_hi_lo(data_out),
+			   offset, label ?: "(none)", str_hi_lo(data_out),
 			   (mode < 0) ? "unknown" : modes[mode]);
 	} else {
 		int irq = chip->to_irq(chip, offset);
@@ -445,9 +446,7 @@ void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
 		};
 
 		seq_printf(s, " gpio-%-3d (%-20.20s) in  %s %s",
-			   gpio,
-			   label ?: "(none)",
-			   pulls[pullidx],
+			   offset, label ?: "(none)", pulls[pullidx],
 			   (mode < 0) ? "unknown" : modes[mode]);
 
 		val = nmk_gpio_get_input(chip, offset);
@@ -479,10 +478,10 @@ void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
 
 static void nmk_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
-	unsigned int i, gpio = chip->base;
+	unsigned int i;
 
-	for (i = 0; i < chip->ngpio; i++, gpio++) {
-		nmk_gpio_dbg_show_one(s, NULL, chip, i, gpio);
+	for (i = 0; i < chip->ngpio; i++) {
+		nmk_gpio_dbg_show_one(s, NULL, chip, i);
 		seq_puts(s, "\n");
 	}
 }
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 8940e04fcf4cc4898cda5a5734574bfed6a175c6..db0311b14132276b9020bf3331fd9bb7a4f73a59 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -584,7 +584,7 @@ static void nmk_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 		seq_printf(s, "invalid pin offset");
 		return;
 	}
-	nmk_gpio_dbg_show_one(s, pctldev, chip, offset - chip->base, offset);
+	nmk_gpio_dbg_show_one(s, pctldev, chip, offset - chip->base);
 }
 
 static int nmk_dt_add_map_mux(struct pinctrl_map **map, unsigned int *reserved_maps,
diff --git a/include/linux/gpio/gpio-nomadik.h b/include/linux/gpio/gpio-nomadik.h
index b5a84864650d0c228de6e7350a28449537a829d9..7ba53b499e164edf410475cf62d60f399aaaa0c7 100644
--- a/include/linux/gpio/gpio-nomadik.h
+++ b/include/linux/gpio/gpio-nomadik.h
@@ -261,8 +261,7 @@ struct platform_device;
  * true.
  */
 void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
-			   struct gpio_chip *chip, unsigned int offset,
-			   unsigned int gpio);
+			   struct gpio_chip *chip, unsigned int offset);
 
 #else
 

-- 
2.48.1


