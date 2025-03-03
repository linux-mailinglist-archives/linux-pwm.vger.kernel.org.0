Return-Path: <linux-pwm+bounces-5048-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED0A4C1C4
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 14:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E983A32A8
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4FB214A8E;
	Mon,  3 Mar 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LShH7kHX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10ED215781
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007939; cv=none; b=u0ySFu9Fpm/RNJQsWJRR2QPA0B7JvAYgZx/l6Z5UD9e2KV3FqVBprJR9xBDlcizFzssmzmEKW8klD1SRG+QqqJWhx39ddYD+yh/Fo+CWHNGFc1JKitcGbPC7FPJAAW+s3ps359FK2IN24JR7khBv5EdsWsdgHgaAFauPTv5f+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007939; c=relaxed/simple;
	bh=wmxkqe1vFjcLK2jMM+NTo3KMs+4giqwo4Tu94x6rZ5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnOCNhseO7zxO2WsE/0QsxmHUGcSw9tYCi43avgFX0w4kWpvfvOQ4fX8ItNb/sFUcXb7qD73ncBgZrl8PGfY+9vK4ill1mNnqUm75YfmRADrEAAyPN59WEgjX997TytjTBnLO7bp59JCG4Cpolu/viaeNXjiYOtYDKBnqALd+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LShH7kHX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-439946a49e1so28175735e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007936; x=1741612736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYy3OxmCTfeXmKWW1VbewLs6rP6H3oG1fco894i6r5M=;
        b=LShH7kHXmNlqf3fu8ym+f1rFLE08mRQ2xXbmsVZYGziaWTsfyeSYIWsA3cpZ1/PmuU
         jdexayHHhJcOa6t/4RZYk4f1A56R0BC1w8paigKzJXkWCmxTMzRU5X6xxOm79PfmhtX2
         OOOu96YJkMSOADEEdGN7XoKCYIWsL8dTFwOlAkcp+9XM8fJma7gkoWaUWKIUzR1nAPUs
         LqATWxDmmFjuUkKO0mezr5jdt59VEcxGVtMK1eb7KvmfaDmt9WcthKEQCdv5unD0OcUl
         8sz04IZZ1qsoq9O/bvs1VHCpCWWRZ5EFAura1CzU6WFU0fIvqUkdSwS5b66/Z++DfSB5
         vx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007936; x=1741612736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYy3OxmCTfeXmKWW1VbewLs6rP6H3oG1fco894i6r5M=;
        b=QTVHY5FGlG9S2at/1K2X6KQzHkpEs4IwTcQfBUv9i/GQHsuvEZRbE4OIruc7ez/O35
         RGpifFFkvPlchPDehwDeXRIsQ6g4r59Zwm8hSHb77GT/6G57XoJmogOX6EybxBVE6m/L
         F9f02or1z3O5j1dmFs3Lq/eoGN9Yp+Qklyp2qGXjpr3uNZOFdXI+lspopA5TgNNYhqG9
         qWL42ZwQON4m8uY4ieYJKYMi7vZdpIPtULk6RJ1w5gKfqYr3DIp1QgPz9yBTTF9O6b/t
         Zk0gOODnQvDPe3w+NzwbAmdBBysbodMxYSopCHlSXhOr9C1lew39ajWZDQcyUFcPwI8+
         LtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0aEaZ8yBBL8je2e+EUowoOO5RLkrYDlI6Zj9Y5TRZHMeOivFUO3BVeitof7nZqcjJNLJkgwo634c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlojyufmUuZRKa0dxXLjstS4W+zbaSr10PXtC1zDizBpwjI5bj
	CzK7zzrB+1IjuOcg/CtLTIM9m7vOqP6DyrIMp1aUasCvY3kQniTsDpqsGnlWdhM=
X-Gm-Gg: ASbGncvO1777w2iw0XAKJUxjY4u4555oi/k0GmN62934fCja96LPP1KttiFcdYP3W8c
	8+vib1T0MXb7zWeisg1QSponZI333dDTbaMJGVWm2qSMgSjnAgiTaHua8sP7v2j9dCQRcYiEZgz
	GpXWVqHz7JD60NKuFpNmbZwzoX6j+cbFB00bQ5OZosXmH2e2nCEpmFGO6r6b0aEW+5+syPEvbWn
	JYn7iCtwzNjqvpQDtVAaDEUboumGeZRySIRM0gBYChLwh9ejdFuA43GDQmkyEdT0zneaTlMqKRd
	Rm8poxOZ+buvWjDkCWJSrkNHsItARz5/FkkiHA==
X-Google-Smtp-Source: AGHT+IGrzVhEnfUuDCVxi9rV1+Y2pAX00HYe4ND5tnilxpFNSHjqZm+Q1tO//4HTCcPKf55lo23WTw==
X-Received: by 2002:a05:600c:4ed4:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43ba67475aamr98841885e9.19.1741007934650;
        Mon, 03 Mar 2025 05:18:54 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:40 +0100
Subject: [PATCH 15/15] gpio: aspeed-sgpio: use new line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-15-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mun Yew Tham <mun.yew.tham@intel.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=o1RQkjcxzC+TGloaGMTPuFJzidyh+RPMXxMLz3aV4DI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxaws57keqtznwsHgFtxTpm4rRaKKUe8Z3RX1S
 ld6SfCwJGCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsLAAKCRARpy6gFHHX
 ckXIEADQhVFh09Iq4tEU1jISNlnEkfP7k1ELSZ2IXMcW2dvNP7VqR81V0ZYPQcclqaZcCttaM/0
 1t5g/NVwoezK7o4qVsmqkqEYmN/nvkOX0UsVySyJw/0dXUPT/CQHlKIC/erIqkDom3R1svtUd31
 J8c4lXQO8LVXCkp4nJAkRYT4Pp8L7ABPoI8raUIP2VV8rjcwdbiVm9WCmlKM4tWAcJUCSL+WNdq
 P08bBozKKrLOq69Uc92O0nJlOwBqmO4bFPrWVqNuqZLcX4lyWblxe8aftcHYJPVLMNkJ/VGuhSd
 scoDcPInDpwb45deB+pQKPmVX+r5jj6vzMfSsD3gtmzzVSbaRkjTrA9B2rqjxRO5+w1AwLup7eD
 dcPbHDmqiZewAlMFEyYu18B6DBXl0+p/kcCHFQHuX+RX7QW5f0TyiwikwKokqYPCvwXVRCDPUUW
 8Ro4zYv2Q4eoLzFPK7GbnD8MQO83Fy90ZIxjT4Hsw21lBZiOmicK28b5uSHvoAziBQurQ/M9+r9
 tMPeMyCpRPfCCwKF4H7RofC7RJGan9UoZtnZ66gpzw7ne2jNJ0rx2YSXzVoxYEwFv+RX2NRP0UD
 SxJc01SMF9zx33J3w0C77IRMrapFhhJcw6Ls1/VbuDECgOkpKtB9qH0Cr/4U9XQuMfQ3uo+w/Gt
 pwY99gL8+uSpR2g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 5ce86de22563..00b31497ecff 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -209,13 +209,13 @@ static int sgpio_set_value(struct gpio_chip *gc, unsigned int offset, int val)
 	return 0;
 }
 
-static void aspeed_sgpio_set(struct gpio_chip *gc, unsigned int offset, int val)
+static int aspeed_sgpio_set(struct gpio_chip *gc, unsigned int offset, int val)
 {
 	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);
 
 	guard(raw_spinlock_irqsave)(&gpio->lock);
 
-	sgpio_set_value(gc, offset, val);
+	return sgpio_set_value(gc, offset, val);
 }
 
 static int aspeed_sgpio_dir_in(struct gpio_chip *gc, unsigned int offset)
@@ -596,7 +596,7 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 	gpio->chip.request = NULL;
 	gpio->chip.free = NULL;
 	gpio->chip.get = aspeed_sgpio_get;
-	gpio->chip.set = aspeed_sgpio_set;
+	gpio->chip.set_rv = aspeed_sgpio_set;
 	gpio->chip.set_config = aspeed_sgpio_set_config;
 	gpio->chip.label = dev_name(&pdev->dev);
 	gpio->chip.base = -1;

-- 
2.45.2


