Return-Path: <linux-pwm+bounces-4956-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707BA3D5C7
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 11:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0537AAEC9
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C61F540C;
	Thu, 20 Feb 2025 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HMbU8BGC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8951F4614
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045451; cv=none; b=CmtfGDeCDHj5mqdozPu9e42Fhglxr29YDFOqAXO3v3lrB/bm8yrd5fpzRUqoRr7DpioLZ1Qz8gfsqYQE3RYAlYmSAhMyqTPWfYWtADaJHDsYGqLZkcdKbncD9PoH37R9dIYjBuQiF8OMCeRDQNCTBfGexKL6FKPc54eD9yFpCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045451; c=relaxed/simple;
	bh=oNMBdRZqUQCqeYdhk0xPtgNTqSfkbaSpML+Q07cXQ+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVHyrCJcD9Xn8D96xEesQEezPtpdb+EjWqDyqrvdGn43HodwKkfVHSY9x2rwgpsyFD4O15ggGgK+a1NBpS/bbJBwTRMB9PxExDIUiuy8svw3JadDMysaC9IJsFd7IfeDqucZuV4ZWXNLLi13UH3XIixSbBWsFCNpHXntDXnKN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HMbU8BGC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so348547f8f.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045447; x=1740650247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfqQhzIbPAlLlEplcRJK9DNV0YYD2STndi/P+xKMNHo=;
        b=HMbU8BGChMxsHNWcb6TRKA9VYOrIbgG8+3iOQ2mIL0UXswWshpJMpyNPbykVDQubEJ
         /sZkIUV41pd5vsC6WTkBViYc9ozXm6mT+RJMFSIgK39XMc2asyA0Uk2XZsWt1dDHEQdE
         EvRmk/x/jtaFGSH1NFQoiK/ZHezwVhIwWAFYPokKqLpIjw5CqPXUxQlXmNpmq1XmxtEI
         v9S2DKINCSwVKr0vcqKWvSlPnUY/hiKyU8PDp5K2HICiUes+KLOLYHIXjIMgrtQZLnY2
         cD4IsKiyt+cVTI5Z0a5VQlNyp2LY/443zcGZqgF6LDt7i1ZgTcBcIM3R25R6dJL1G+EM
         fkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045447; x=1740650247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfqQhzIbPAlLlEplcRJK9DNV0YYD2STndi/P+xKMNHo=;
        b=ZtGZp3i1KU1+e6sEilexIhFbNn0R3ynvxV434gqKn5QOdoSfDdcWuCS5CrqiXQsilF
         YI1n9HGAQ+1SlFi1bilLLU8bSgfKsqALynDsNUcv2LMKUMEGRHuQcSe9gcDlOVGzRSAG
         yOANL9XPBu1bnbVvUwsyCVPRa4EMUP/FOhKwpDg8bi97WbeAe8jifhF6mW18H162EhIK
         JETaT6ih0Mr6MFYrBpKKdxEgYhfx3vWb8+WxAs/yPmbgKSMrXl0QPLtUDeYnJ+PeNHx6
         r50Tmqef89nxFjb1ycWDrpqlyfDB3c75tJy2IKSis6HwF5D4Sz0sb42A0WeoO6QwV6wM
         dj3A==
X-Forwarded-Encrypted: i=1; AJvYcCUmFKtROT4oHZFeNKoxlKrbVwBJ2tI+bvWrUGxiengsTZTjdOqHeHfTlgGuvleZTbUaJCfiTRX3Dd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykN4gA8edOJeh/RLX6zeCVzqIhSC3IbWB/84B6HzcLbWC6zQnl
	Zaxvra09sCej2wz8D41SgDg12q/JILgxyzWnZ6iF/K3BNPFFunVzYB899xE7fbA=
X-Gm-Gg: ASbGncvTj77N1NtojVN/k79fiJhXKxQkYkLZDy2xstUlznN1QhfYru7kyvTNVpN3/N9
	O/hTKvTdpqFSGnBZGHfaPl0T2HS+wSMMQ2bbHSdqiI9k4fywUUQ62X2LBpuoF1CHyM7uaEX8XtD
	hyHqs9K/PuwNOZoxuEOT2mNT3mUwXumAUiKYFhe2Fww4TGsbUzRAPwiv/xO3NHx26y2/AmSXaLV
	DYUjkoTwfPXN98432Rq98h8RzMGzpFi11QSOxsKHBjSwZBqkMAwJYe0afA51j3tKBdZcQyU7mCq
	6hQNR4Q=
X-Google-Smtp-Source: AGHT+IEesjZmZYobgjhT/KsvHGhJ4/uJ96MmYOnkUp8TEDV29vEvKyBue0fV4qqalBxAWQRNOOTd1Q==
X-Received: by 2002:a05:6000:1cf:b0:38d:e6f4:5a88 with SMTP id ffacd0b85a97d-38f33f1b5bemr12896873f8f.12.1740045447286;
        Thu, 20 Feb 2025 01:57:27 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:09 +0100
Subject: [PATCH v2 12/15] gpio: latch: use lock guards
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-12-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GmNqVVnBfzS1ierDztOpK5GOdKITHuunFEXdWyqcpSA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx4XkZq/c6JUz5aMuMrXDx9YfeWhQw7bw089
 7pXZO8o7LKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8eAAKCRARpy6gFHHX
 cuYnD/kBzNfzsHamKa/Gd1E9IV807ikL7snAjFvcGlR5Fpu6zV4Z/tVOtkCEkLy9BQGuLOKfr45
 r8GzkZxvFSKPn47eDyxDaO6lVGhKsfeD+O+wTpnaevueqRyPcFlkp2mDoTjKfpq5bFc7W0lxhr3
 Fzp6dr9ktW2FtwTwfwE9A/DyrDQT7Wiw75gapDVOiGlFad7x8pohK07RCsjWtPbqAsfMC2K4m7W
 Hl26bwR/JQkixA14VLJzr1l2udnwmRiILOn1K6CNRntIx3nO95r1hR5sygIt+c2/Z7PYlL5zTZ2
 /sT6bVf11YoyJ9S7dx+bXeZPNUys37FoEq8YvQ7ytv5K/EzDSCcUxSPqFEDMKucsUL/Weq7Zgxv
 BJVCJDJTNlTPgymJNlh+wUDe6r4RA3h0lDANZEAt9Y2rUbR/rk0V7+2wdhMxP09TeeW3zhsDswd
 851NTRV/XUSf8O6TaOlQXzLpm6/OqPLs3+k103mBZUrwj6yjmUSiVbOCLZJsu3dXrVzFc0qi++n
 EzkyVwBTMyPO/5f9hxkimzhZXKLGvctXrnhDpjH5Hp7EYOUN9i0gOtUGA5cqOf14kVjTTkIMpoF
 Oq2Ywv21u8ELAXkkyMYLAZ/d0/TPEwNFwnMBEUPIK4OQzrKQ25QU89ub6S1Ok8JN0mBuVCHJgYh
 O+Z8hE7aBdYSXEg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use lock guards from linux/cleanup.h. This will make the subsequent
commit that switches to using value returning GPIO line setters much
simpler as we'll be able to return values without caring about releasing
the locks.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-latch.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-latch.c b/drivers/gpio/gpio-latch.c
index 64174ea7d008..f227966c50d5 100644
--- a/drivers/gpio/gpio-latch.c
+++ b/drivers/gpio/gpio-latch.c
@@ -38,6 +38,7 @@
  * in the corresponding device tree properties.
  */
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
@@ -94,24 +95,19 @@ static void gpio_latch_set_unlocked(struct gpio_latch_priv *priv,
 static void gpio_latch_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
-	unsigned long flags;
 
-	spin_lock_irqsave(&priv->spinlock, flags);
+	guard(spinlock_irqsave)(&priv->spinlock);
 
 	gpio_latch_set_unlocked(priv, gpiod_set_value, offset, val);
-
-	spin_unlock_irqrestore(&priv->spinlock, flags);
 }
 
 static void gpio_latch_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct gpio_latch_priv *priv = gpiochip_get_data(gc);
 
-	mutex_lock(&priv->mutex);
+	guard(mutex)(&priv->mutex);
 
 	gpio_latch_set_unlocked(priv, gpiod_set_value_cansleep, offset, val);
-
-	mutex_unlock(&priv->mutex);
 }
 
 static bool gpio_latch_can_sleep(struct gpio_latch_priv *priv, unsigned int n_latches)

-- 
2.45.2


