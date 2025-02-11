Return-Path: <linux-pwm+bounces-4854-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D1A30B56
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 13:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DE71682A3
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488D24FC16;
	Tue, 11 Feb 2025 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HkuweSds"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1F1FE45A
	for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275819; cv=none; b=EzVguJtKdOQDRJ4cKZefYqVBPw9u7x5nkr9YKzvmwu2bVBptLqOihAkgtr4iuZeNOGZVvF1WaIEmEiwsBLArPZ5NadQODoKcgBLvvJUTEPudAeCDA4gvGB+ojMe8bLsmL+0viRb7eZIKvKUYtAEgWT90ZawhJ67GlvfJcaVQqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275819; c=relaxed/simple;
	bh=bHBkkQ3gwrzmNpAMzNtD02RKPcIOd8kTW4JbUoyfFV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSM8rSTeKviOQsNeqXtryb4VcMrzy/C9mj0WQya61kRMB3ktSzddiD6bs7TCrxx5Glk+HwRG/l5wRM2qXf9KsJwpALgbvrWa+l7jsda1zuGmFKpgif+S9vQEfe1Vv5XQkgWTttZ91qWYgM/8toYBtEoG2QR6DotSoicxa3uBahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HkuweSds; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43955067383so3475025e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Feb 2025 04:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739275814; x=1739880614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWAYSRpQyGW1MmOUzWp6CZEaNkYKfy89Gcg/wUWpW38=;
        b=HkuweSds/bfFj2FDg3cU3m1gb8cFRnaraTsQOD5hIO/eHrgvTQr+gY0ngKYT+F4pbd
         9YzSl4fkpW15VVoGFmUcoWTSh5EmRC1CsP46JNph+r//SEE/8dAqxTLX/qzUZFzj4MA4
         0PXZ/R3YtrnVnpHBXlkHyf/CR4NNtEMMBVuu7XLNqnZ0rd1ShrC6JR2eY7wBMpY6dwEl
         qzeV3wdvZb7+Cdf6OWCB0SVHy475bM0vMykcdWinXxCjl/5Q25Yaweq1zDy/PEW3morn
         8gcDHebakzyEuYjAfSmH8NHrbczuNhX1tF6Uw1VZgUDX82jiHS8ip2/ht1bv4Zc3kZT4
         HEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275814; x=1739880614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWAYSRpQyGW1MmOUzWp6CZEaNkYKfy89Gcg/wUWpW38=;
        b=SeILPCcGefJVdfdSKfGiKGRSrD9tQyrzibnwH9KhLFrfPIGhNSwQmAnOAgjbYFBAjO
         YhirY9MXiy4ftl/4AuPWXWxiUtmVQ38/kP+lmMTpT6Z2wC+gM1ho8mCANH6APpJgwkiB
         KuXW11ArdSbwbR0+C635FG9Xw/AJjJMY6VevXI2H/jxDUbD2XYZLfDHpcZCezkokbgWT
         F5f0D/oDf4LUxGA0Qmeh+obR0KiZ4Enqfa+bKGIAXonPOdPzn939I09fSWCLxUAsLxb7
         Co9NhvOF49xykK8tF7TLsM8rK7fMhliYvEZoJNOU87Q3MPNHiQUR7xIMWtlpL+oEgFhL
         8LMw==
X-Forwarded-Encrypted: i=1; AJvYcCW7GkGDGWVi6nf2M9kz6fNsd+dXmLl/wFG6oMbJkCMjqteJ0uga4OKqozbiTsiWIK4g76HuBwgN0M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHW5V9+lVVKQ8afIny9GTmgkh05JCg4WI/J4ZtzDJi4MxBfok
	goTLdGs10M71l5XKEpvWwkGL31lnoA3ilxbo2ujIb6iX9iHLVKGP214LnqjCRgU=
X-Gm-Gg: ASbGncsKlatFmiTtcz2XhZ9QPX63il/UzQReQrBmudLTZ3fA9oB8Nap7N9VzRPm1V5V
	pK236aQwrnRqHqejZf8zuLNw8oaPDo+QNxoTlLKkIfuUqBww0oYdHwJZ/hEr5sbj6O0JpliR+td
	9INTcg1FuOhalR78S+w8eaTUub50xBDwqtMnKdsbdwTreyrHKm6J+faNeIFjrws/K1OXStSZAGD
	0YMrFJh6rqfFd5Pb9cPzMBLqBugnlj+6jB1YHOu+xY1vN6TTuUoHM9bLHYiQnYs/P+Sb/rFTi7s
	s1xbJdg=
X-Google-Smtp-Source: AGHT+IHYgYYOaXEpCdGY3z7Bd2VkYJBXiycDpU53N+TlhIMT/SWdj99wXGUXUo6mOipeYCRicV9nKg==
X-Received: by 2002:a05:600c:1ca8:b0:439:3d5c:a028 with SMTP id 5b1f17b1804b1-4394c81a33amr38392455e9.12.1739275814586;
        Tue, 11 Feb 2025 04:10:14 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd4342502sm9152327f8f.26.2025.02.11.04.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:10:14 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 13:09:47 +0100
Subject: [PATCH 13/14] gpio: davinci: use value returning setters
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-gpio-set-retval-v1-13-52d3d613d7d3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=yf93BY6UtZ3z9CvJxszbP+L4YyMx5+aznul9fLO8j0Q=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnqz4YjmuswHK/ySgxs6vkxh9UOnLtF49m+HYhw
 kEk7Bki8iKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ6s+GAAKCRARpy6gFHHX
 chwlD/9zW+lnpiPgLXbElhrE9+pbLjQ2E4wbziINynawEf9Y1rEgv29XTE28fO9Om5SdY6yvMzi
 bQbAf9MA0YtwVvH2NhyDNMIicUx/lECPglW0WtDX806YERgydsNPcowpxzwpV86Rq4kDdJy6X5/
 AyYtg8ucPcQBP7AXgKsI6YLfqImcjahAc+c7FkN7RJvTMNQtQqMvX7dk0Q+iYIYhY4z2QQZUH0C
 bQFfqBme6mvn3FDLOSALr//ITeFg8zX98CRPFaN+Jkjtz+QEshMe6t0N/5gCZQRFF19O0SGaWWT
 7yYmtdo+01jdh7eOtUFsFLTORsIa11wtKiBbmoZb6xjPc0n0cnWsDm2iogGJ4WnIXPbN0RZxqJZ
 aNE2fywbdg6PSUgreOKplFn77Sn+uMletLUpQbJMXaeVM0liZ/3hixVLdc9cXgYbdQG2LPREQYN
 EhMy713GOGXoWh66FCQH4CdKtvkc/KwRo9SHj9kwDY77vn25G77vplG9BAlU0+HJ9ldg6d1jjLp
 8CTlUEBle6etiWuPIh/vJEab9TgwvrTW04j1UrkE47R2f/q6kd2g260X9hs/W25H4wGWiXTVVgn
 hhwM87DBACNCKWp8MuZo077opF/SlR/MkrKLdI+FSOTmbXwYF8Ov1RUgsvk09W9Gp4EDAzjWznq
 zUMwfdpHgDO41/g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has additional variants of the set(_multiple)
driver callbacks that return an integer to indicate success or failure.
Convert the driver to using them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-davinci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 8c033e8cf3c9..63fc7888c1d4 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -139,7 +139,7 @@ static int davinci_gpio_get(struct gpio_chip *chip, unsigned offset)
 /*
  * Assuming the pin is muxed as a gpio output, set its output value.
  */
-static void
+static int
 davinci_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct davinci_gpio_controller *d = gpiochip_get_data(chip);
@@ -150,6 +150,8 @@ davinci_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	writel_relaxed(__gpio_mask(offset),
 		       value ? &g->set_data : &g->clr_data);
+
+	return 0;
 }
 
 static int davinci_gpio_probe(struct platform_device *pdev)
@@ -209,7 +211,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	chips->chip.direction_input = davinci_direction_in;
 	chips->chip.get = davinci_gpio_get;
 	chips->chip.direction_output = davinci_direction_out;
-	chips->chip.set = davinci_gpio_set;
+	chips->chip.set_rv = davinci_gpio_set;
 
 	chips->chip.ngpio = ngpio;
 	chips->chip.base = -1;

-- 
2.45.2


