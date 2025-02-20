Return-Path: <linux-pwm+bounces-4949-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DEA3D597
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1380189D5E8
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665801F1524;
	Thu, 20 Feb 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eJEaxOwZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9331F0E39
	for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045444; cv=none; b=KUFYDHFwX2wqRVSnCImeOEkAJQrPMfDZSyYTLKrpHYSH5Kt6L3pF7fhUen4U39IvDVWSEEnfd1w+QtBT3Rx4uJN/s/6M2TvTHQIeqkKT2w5gLxm1jcr/JuTFohigYpbMgopWYXM5+FJ/ZTfw8qGr3DBGtIJopLJXdXVxNBCY08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045444; c=relaxed/simple;
	bh=Hx8x42h3TmyvG19Hvhj3xP7pPFU/ZDoyjClGhadyhMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uh80LNkqOzieEZV1VjTyU19PAV5DS//T/5fTPWBoux+EvoClQDGn5tmhS82yjVswqrU8SapWTbzB3W+FqU0Xq7qHcKyCIQ+vrrasCpaEXb6/61YMXXSAsNammSwzXLFlryMjRmKOek47OQQt+YqAVpBLpasMEpIXHJCRdfI+q+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eJEaxOwZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso4404715e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Feb 2025 01:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045440; x=1740650240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CW1BtDxAa/GSG19LzM6FVm6kpOL/sCLazVCSkC2HISg=;
        b=eJEaxOwZ49GirZ7WB7oRfLIYRLO+MydNW8gTlGzR5Q46+ZiD+7VaTXJ8A/boLs42Ji
         otgBkXwuE3bO71peK5w18tUYB3AZAlKfgH7/LyQzFAeWwKL/94f2hEUB+LoAItH1vZ8r
         vqu+RVTp23S6xtZfpYxGQpIYD/b8ZFdqXsbpHCtibSpAE+hbYf30wvGAWHj7A9Kwx5IO
         ERdXVKsU1xUGguAbQagf7VqmmAtsJkBPxj/wP41n4Vt6psmtg8peahcMCgEYGPLMMMcu
         2Q9UW6gRT+9jYX28vp/kLbS+5Qji/671ecpyUGwe+/Sl4yZBK4EqhsMTTZfkopMadx9u
         qrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045440; x=1740650240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW1BtDxAa/GSG19LzM6FVm6kpOL/sCLazVCSkC2HISg=;
        b=aIhF6/B2KeTcSCWmgcaXaHSIS+qpDtOzUfVDTIZTQHnoiSzXn/ZL+gUd41iael2X5R
         e3+PAuy6wnDRisqpYFiRcy93KE6Vpsta8mMcSvjaL5xGQnFBlCMPwDr9AIlC5gLL5piT
         ZF16kuppdW1SaIx7yVsCAMGu1LXXcSQ9uu7LmEukM7pZ4SnlnMYSJrUw5WAcbMO5EjGa
         5liNO/iIeXqsU/bsplnjHHu2DGPwu2UQ5fNoj/CjWktqEbSuNoz7lNvc2INU3B8nSJgz
         IfPDP8SXhJsPDTkOa+zRagjFqW0EDTxVMmstcP+5UorGITHug05f4PPmI4qkOYBa9PyY
         eu+w==
X-Forwarded-Encrypted: i=1; AJvYcCVxh7FRvBijuNM7Wc8Kk9oI+MwAkLkRJjPuHyVJkzEHnmF9QmVSl+bVUgAxwJwekt6nLGoBh9Mjor0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvI96qGZDvktvavpa2Mthsh55RfqfO46ShGTRtm3YEdb4kTea
	bW6NK7iuvdYqGeeu02Y4/wOrd0u2wRxLysTmm+ysXrVJO062Tq9RN5me8Yt7BYU=
X-Gm-Gg: ASbGnct7JVsKQk5/9UW3vgcAW83jqehbRoAS/lcTviubS3dhOLXelyoumc9AmvoAaN5
	7HZy93RyiHePJ0Da21iyNtIfqCxcRetJQWAZqlC2XXQtWBkMPukKymprMTDFEo7vEpShsaM5cLg
	VdWUMBmcGmJ+3sqR7D/IBSrH6gd8wQUDt7nrPGbXi/zDP7fCsxVSHZcdcauwy5hqqPNjJGBaQAj
	reJpDEzW7mL5+Zbb4Um4a8Vr8H72HaeGbtQwcsOPaQtwEai3G3b3Vg8yqLV9oWZwqb7vlP0rNO7
	aOMAHnk=
X-Google-Smtp-Source: AGHT+IEzfYTeDdg/DrUePFOBkrqsf083bzzXDfXkF2qzL45+2j4Kd/nMhGJG7tMvJ7+QZy9eEcP3Tg==
X-Received: by 2002:a05:600c:1516:b0:439:5d00:e78f with SMTP id 5b1f17b1804b1-439a30d4c32mr21123675e9.11.1740045440011;
        Thu, 20 Feb 2025 01:57:20 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:19 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:02 +0100
Subject: [PATCH v2 05/15] gpiolib: introduce gpio_chip setters that return
 values
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-5-bc4cfd38dae3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3620;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=A1iH2N7/CXnZXWebW/r7AKV8RFBFJ+TvTYVcN6Ufjwk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx340P6bz8HBHSRoz1htB8NvNzkOI84ft9b7
 Or6HUMWz9GJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8dwAKCRARpy6gFHHX
 crNxD/49lgMRbbBvfftYNyPR3zsQIi3k6BMOdyIhLPRspZIILH/urHQIKCOotMqhAU/Ab2cKPiY
 jxjvOxmTQN7MUBTRQ6df1NEDwthBY4RKKf+JURBJn3bQ9SwPaLzI1EVx8zRrcqFqiAxxpGfmTP2
 OUU1tpThztixzKi6Knf6+0loNH8aWYXd9bxs6+mjQVOisQqe6RGu2JEsC4v6jvC/FwdLseCaaSf
 x8Kqw8o6wtQixtEHVtV0jl8eKahilwSH+I7v7qzIiCay0ctDkpxNKIRIV/GTb+FudqWxjh6nuZq
 FXQG3PDWhT+2+CAaPGsX7AiLsoJChWoVVLgVp/SdcVmgq4yv2ye09RNxgkvc6YmuizOU1rJiFg7
 Tae4zQ0KEKHfXuHCTi9z8IAxCUtF+vm3jkkX6f19O3jnMyfiP7OUj+7Gmu8goagEc3zn5nPPTf5
 +xEl+ig3mNs3B48/wdRAXAdUVP5oS7PhTqOEHA+GxR6nB+K8K/c3bldMADga6CXx9RHNetTWTLl
 KVh+ZCs1b0t5eTOyMFY+fmjVCyD+iwnTs35enqg2kDRve/6XJe+9fqvMYsVJDlZvUFgc075w1mw
 r8wwTdvLHKWpfiyXVNx7VTsNqqunZZ5khVevjPD209bcw/26iq13yhhQ49twYY+dtNTeAMu5tzD
 7c/rAcxajd8AdVw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add new variants of the set() and set_multiple() callbacks that have
integer return values allowing to indicate failures to users of the GPIO
consumer API. Until we convert all GPIO providers treewide to using
them, they will live in parallel to the existing ones.

Make sure that providers cannot define both. Prefer the new ones and
only use the old ones as fallback.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 27 +++++++++++++++++++++++++--
 include/linux/gpio/driver.h | 10 ++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b1e7d368bc7d..19f78ffcc3c1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -926,6 +926,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = 0;
 	int ret = 0;
 
+	/* Only allow one set() and one set_multiple(). */
+	if ((gc->set && gc->set_rv) ||
+	    (gc->set_multiple && gc->set_multiple_rv))
+		return -EINVAL;
+
 	/*
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
@@ -2757,11 +2762,21 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 
 static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
 {
+	int ret;
+
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
-	if (WARN_ON(unlikely(!gc->set)))
+	if (WARN_ON(unlikely(!gc->set && !gc->set_rv)))
 		return -EOPNOTSUPP;
 
+	if (gc->set_rv) {
+		ret = gc->set_rv(gc, offset, value);
+		if (ret > 0)
+			ret = -EBADE;
+
+		return ret;
+	}
+
 	gc->set(gc, offset, value);
 	return 0;
 }
@@ -3501,9 +3516,17 @@ static int gpiochip_set_multiple(struct gpio_chip *gc,
 
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
-	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set)))
+	if (WARN_ON(unlikely(!gc->set_multiple && !gc->set_multiple_rv)))
 		return -EOPNOTSUPP;
 
+	if (gc->set_multiple_rv) {
+		ret = gc->set_multiple_rv(gc, mask, bits);
+		if (ret > 0)
+			ret = -EBADE;
+
+		return ret;
+	}
+
 	if (gc->set_multiple) {
 		gc->set_multiple(gc, mask, bits);
 		return 0;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 10544f4a03e5..b2627c8ed513 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -347,6 +347,10 @@ struct gpio_irq_chip {
  *	stores them in "bits", returns 0 on success or negative error
  * @set: assigns output value for signal "offset"
  * @set_multiple: assigns output values for multiple signals defined by "mask"
+ * @set_rv: assigns output value for signal "offset", returns 0 on success or
+ *          negative error value
+ * @set_multiple_rv: assigns output values for multiple signals defined by
+ *                   "mask", returns 0 on success or negative error value
  * @set_config: optional hook for all kinds of settings. Uses the same
  *	packed config format as generic pinconf.
  * @to_irq: optional hook supporting non-static gpiod_to_irq() mappings;
@@ -442,6 +446,12 @@ struct gpio_chip {
 	void			(*set_multiple)(struct gpio_chip *gc,
 						unsigned long *mask,
 						unsigned long *bits);
+	int			(*set_rv)(struct gpio_chip *gc,
+					  unsigned int offset,
+					  int value);
+	int			(*set_multiple_rv)(struct gpio_chip *gc,
+						   unsigned long *mask,
+						   unsigned long *bits);
 	int			(*set_config)(struct gpio_chip *gc,
 					      unsigned int offset,
 					      unsigned long config);

-- 
2.45.2


