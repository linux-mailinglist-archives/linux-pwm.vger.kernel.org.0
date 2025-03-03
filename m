Return-Path: <linux-pwm+bounces-5041-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5FA4C1AC
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 14:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A1F16FB40
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A52144B1;
	Mon,  3 Mar 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uyMXxpVX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA0213E8B
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007930; cv=none; b=uni3VdAkyL3mqzFZnUZHSww9nJ0D+6jyx73IvR3Ud8+owm8llRA8RKBSL8UdY7QA4IIEvZEhoS3nBDhRzrmqSSLcfiIDY0CRSOLVKTKkgdthRq0YVaHqQJhz9WQEeU+PR2qOn3y5iIWCufEasKudHXjMRY4xC52bW9PQkFBksqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007930; c=relaxed/simple;
	bh=pNFZLswBAGvHZgnszFpzGA3Zwifb9QpDP0WoiQWGE14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqzVApJTXYMxnQ3WRNf6/52kwB9tklV5TOn5HDy1citLLgPfSDlAc2CaDQumXuNylgBL5s6JaMnML5dFqAk+m65nXFvVyfpd8ek1mGkuMtxcgNdr/ql3f/dY/1/BWB2qISKktsRq30yvwb3t0Gir1kP4Xmm6fVQSBebJp8kIndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uyMXxpVX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439950a45daso27921625e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007926; x=1741612726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/r0MuZTH6RnCwiU0BqdZFY1e9Cm3LvOPjQ1muaLpSVA=;
        b=uyMXxpVXvID0PXrjwZjYyxx2FfGD+4e/p68FyjiCRpx7Nl5X5YTO/EuMYUEdHNiIdL
         mZb198mI5SsJfSF8NvLq1eg5XMRDBv24y+Mrf3BpIGiPr6jG6WhduXqVMei0wKbBOlKB
         7MRcMJd5dJSbUg8sZdo0qNgHIg+e3c8Uq88raTYa+6uKvUMXVGnz9o+BW2PMZffXCn86
         5/ODKa/9qW9sj4IAOv4DelvX0WZ224Q6wcs7orc8y/2zGsq/0GhbKfpYuX+f5ihkxW1Y
         9TRqm/7S54qi1aCTmOhJxojkln0VpheuTRxL/XWcTvDK9eCUxUnFrO3rZSk1mWQYKxvi
         LSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007926; x=1741612726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/r0MuZTH6RnCwiU0BqdZFY1e9Cm3LvOPjQ1muaLpSVA=;
        b=Rmh3D4CXa5Mrn+DPVitRp5Afwt29SGU7pIGn33pm4BecBOmmWJUF2I1zQ0xjSSeWi4
         FgwscFejj1eIreFIDWqXsBXIp7Lq0sjwn/u4W0Ury/PuC8byJwOHbKyJxOXhojIHzyjc
         2YTfPmH2uwhS7i/sgABW8jlxb8q077rdMuDuiqrXaslocLBkRhO2xelKj0jWCjCfRsJY
         6uF3Hn1wuRo/FMwvfftYejYf2Ai7wOFxfWEsQU9S00k8rd7rNZ2gVfZweG4XJToI1aIQ
         CNaT+/J/nNQbOrxJNS8pRwoMvW1QcCZG01h34hlbTsU6r70XkVq7NxpUQ7J1IOzw4Dwc
         bF6w==
X-Forwarded-Encrypted: i=1; AJvYcCXKccJbZ41CBp398voBgSP/B5/l8kYkvZGr2u9R0aurbtjJrju7zzib3brN6PqTpfbThEt//ACMfug=@vger.kernel.org
X-Gm-Message-State: AOJu0YznC+V20x6ZZpdaiIImx4ARSTrvv7p7u4qFqgfwYTTG+B707qvG
	gjFbljpyL9SxeWBgz0y2MK2ahPhxWp374MfGgumiruMxg1xC/IXHmMQCtZBL8+0=
X-Gm-Gg: ASbGncsf+5FRa9+N0eWs3O5kmikLH0UXElVMzIG4PkMH31r/zrFgn0lghjwu8jCAeuh
	6foZutd5m0lz11+zx9wWHK+fIBsLGexfaXaRJWyPGArvcqQ343KPYKTZjrcl+cgQ0Z35VNMPmNw
	IIbjBKyxF1/WxMUrylON7z0oPpSEUCPd2g9TTWx4Y35mu9lLAcc8ko2Fv++G8AsV7iPwNSyE7tW
	ECGip7BU9755Qvjh3lVTVfUtSvYHefzmdAiB62+B6IuG613nsgrF71LElxutVRJc7FOVLhr5hnP
	IGKer5NVU+JnATf3x3AwB645+eCrjgKiEvwIyg==
X-Google-Smtp-Source: AGHT+IHm6EaYBn70SJkUBa0sIwAoFeDNkswqub4neNrYccFomXUwUOGpuKJlkXEU0LDo4dNArOpzqQ==
X-Received: by 2002:a05:600c:3ba9:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ba66e0a61mr112280175e9.7.1741007926409;
        Mon, 03 Mar 2025 05:18:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:33 +0100
Subject: [PATCH 08/15] gpio: altera: use new line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-8-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=SMOq2xgstETx1JyBNH5vYamCTElxv0DKa/FsWx+nPds=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawrqlWF7E8xNzhaiQDDre2OcEVZwl9/RTexY
 M26Lfz22DaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 cmqwD/4phcgUzCpl6mKnD/IdnZIH9RNk3LmcqASY0VFf4EbXRAfUJVTaMQeDgSgk24dtEjEosuC
 bpBw1QzXfAFamKZKIQDyNKjXPzE/Hoe1EDCF34rZuNHNHPI0UBjmxJ1HQiXsaiOvcp6YuN90LqU
 IruTx8dSh8NomvJYZNovzKeon6/LRWzKlWb+uZYczW7uUFTXZL+T5oLS7DO99kqZsTCTfVU6Ul0
 3OFRD6NQ0Ihy9l2k1V7lqCDuH+qJyDeuUNq2LtUBuuX+2I8AY3ESBJp2i+MBGELCLWfwR6b1xxT
 LeM5r6nSFUOHN/2f46OZqPlXo+/06oFEI5JqVGow8tZdNrM6mq6cPa5erpnMrWDBhkLZOUeMhCt
 DWHujIwH4kTX+GRjsbuNjNbgHqGEDhX4l7xuIqaQFgkjS5/dRaSQ62lfMxG5PRYtYAOb417XaMv
 6t9tvs9wnV8Sijw4pvvP23BSDop9+n7LfOH20zHB8z38ZXbJcRKZJoWG+Brj5qdvrQmskwcQC0u
 MK94saNiUr6TGH1b7JaI0RM1SXCnT+wdiP5hdJBrPc9ZvTC7wVF5ruvBjzyMXjf9DAdh/hou8W1
 S4LR1Rq4rbXXTZk3VddxFwUqAmWQKWmlpqvYKvAjKmoq6Au2FAByQj/JHUPyd3iJAIjpfvDLzrN
 e1HgWPF2h6MAoxw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-altera.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index 17ab039c7413..1b28525726d7 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -113,7 +113,7 @@ static int altera_gpio_get(struct gpio_chip *gc, unsigned offset)
 	return !!(readl(altera_gc->regs + ALTERA_GPIO_DATA) & BIT(offset));
 }
 
-static void altera_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
+static int altera_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
 	struct altera_gpio_chip *altera_gc = gpiochip_get_data(gc);
 	unsigned long flags;
@@ -127,6 +127,8 @@ static void altera_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 		data_reg &= ~BIT(offset);
 	writel(data_reg, altera_gc->regs + ALTERA_GPIO_DATA);
 	raw_spin_unlock_irqrestore(&altera_gc->gpio_lock, flags);
+
+	return 0;
 }
 
 static int altera_gpio_direction_input(struct gpio_chip *gc, unsigned offset)
@@ -257,7 +259,7 @@ static int altera_gpio_probe(struct platform_device *pdev)
 	altera_gc->gc.direction_input	= altera_gpio_direction_input;
 	altera_gc->gc.direction_output	= altera_gpio_direction_output;
 	altera_gc->gc.get		= altera_gpio_get;
-	altera_gc->gc.set		= altera_gpio_set;
+	altera_gc->gc.set_rv		= altera_gpio_set;
 	altera_gc->gc.owner		= THIS_MODULE;
 	altera_gc->gc.parent		= &pdev->dev;
 	altera_gc->gc.base		= -1;

-- 
2.45.2


