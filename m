Return-Path: <linux-pwm+bounces-5037-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2538A4C1A3
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 14:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C147A855B
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5272135D8;
	Mon,  3 Mar 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0L5A1N6g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE221147A
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007926; cv=none; b=gw0keIw7UeSJmZYRt9GNnsMH1A+zEKF4BHlwO651no0LXTaSSzuWRmSepaVyuteITO2MPoAexkC7EYXnaM39/M2rHyEO17FpN7nCXD6D5gSuph5spBwjVv/x5B7Zb+iyoY4/1EaLxEMJdhDQWslFqy2pwReRtNgFmH6iCuK7M/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007926; c=relaxed/simple;
	bh=C2FD3r9G96fNyZ/7mG5NtCcGXXprvCDkvpsW+gGA0d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpXzcI0fKDZujuOShI5ZBo/jplU+goOefHpfKWTrYw2JbltWM0zM7s/nS+gDo9aH4NuUMMgSP2PIOU2eVSAKtoG3yh9EUvxqIPSc09WnNM2hMHqzliZveraZ9FfoE6CD2Lg1VQyeONjgAdIkszUCXqlGW28c+yeohmP90PdB0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0L5A1N6g; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43690d4605dso28098075e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007921; x=1741612721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8hAv7noimuIZZQmeIe3WLO3rZ6iIEPRpuvmg5XIUhY=;
        b=0L5A1N6g/4nIQQvv2TLNEKO9+X3Pm7PaMyhWiSIlWyUZ3nlZgwdpDILlZSALB2mxc5
         Qo96OnHtS5mK8a0YiNozilrvR1O7pMYSuqTg6m5a1hqgys7ButrWYsjJfgmle5KWfuNR
         YLdlzwsWyIl/HfcSb/YP9yhAF/Q1oh2VzZRNV3oootC+OzY6c/ObdpBV1GvPz95tnroK
         kJjbzRUUulzCwRBmmWTQe/WAFEeHkdvGI8XZhvcqiEQR3upVYdXndlhpMOcMybAgxkVG
         m8i7hvkuTmp6dlwRcWjpRFJZfw6W/4OCWy4sQse27ZctW0AmRwK9hACXc78AINdynSg6
         bL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007921; x=1741612721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8hAv7noimuIZZQmeIe3WLO3rZ6iIEPRpuvmg5XIUhY=;
        b=conZu6kbGfUpjZC4e0im1Fy0XrdH9wmSjg5OVPy0LVnyH7U40V5KckIGV8zm3A9QgC
         G2l9cGB064+M8+a+SaZpA4fQtd8P5iiN6+0eDYkmbNfTWEC/gYxKIZt1iZL9DagcXl7W
         Kl9zQ62EttzAZOLotyzX8Lr+SoBZ8xpm4sGLBcxuaYCNoo2MyFyT5clrnm6GXjeg1VT0
         NFlNOYdINd7YGMGOB2Igw77B8H3X2ZnJd3Pf3uD3pWR6VqBMzGB+74dXSJ5iPGm/xZjH
         PhTohi3xFNT8/tAIyPsTYXUV/Q38BQycgIm6lj8g815/iglKb8ORQosvCv4uPR8EeQoJ
         iAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmiaF50k/bv+JubNwXBo8ObwQJyJFEE65t+MVk8sJFLdPSGJNR553/gRTjSLd5EMjZv0TMRiXpYCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Foc+lJ69tI+d0KJX21Ql2zoXly2ioyPAigXq1IjZYMxfu0zd
	7XM/+n44lCnpgGBS4OBoHBNUMURPAJs7uKWnIu52c+7qxDPxUyy7FFaAfInvYy0=
X-Gm-Gg: ASbGncusuZazX09v0iGeRItvAi5B9U/KulQxoquojqNXXkB+DfShlhgNsXWqehH8LpJ
	gFwx2nmbgv43BGxQEQ5cysZ1L2xFjqOZEH+eelB3Nvc2AKKohwOk9uQlZuGBIwYDrZMPJIsbxdp
	Jpj+s7hPUKwkEGoJSnPM9nEsXEUegA+xN4cbXkKpbPIWp5q3Q3yRKSuH/AqlpbS5sJYS1rceunU
	xO+vZKNkKrx10VywtyLKIzwOWmXuI2YC3GTOkDAceLcHhbHFCcWmlWXGW9IlckZYtDgGB2em1Nw
	NGPt2GBDmuaWeRIscdvlQED5snqU4K3U/i+G+A==
X-Google-Smtp-Source: AGHT+IENjU5auSW6uBydmqpRlN4cRim5e7ftx75e07xHAIh+YvS9KyaVM39ESiF/66tXbphMfz7i4g==
X-Received: by 2002:a05:600c:3112:b0:439:99d1:d4a4 with SMTP id 5b1f17b1804b1-43ba670a870mr109103405e9.18.1741007921076;
        Mon, 03 Mar 2025 05:18:41 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:28 +0100
Subject: [PATCH 03/15] gpio: adnp: use devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-3-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=rVvnRkyDf21RjdggCKIxDxEyQFvc1fgcMj5lcOy+gbw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawp7Yvsyrv6sI169Lp9L4rRvfe6m5SnbOO8v
 UqoONS7cQOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKQAKCRARpy6gFHHX
 ctf9EACVXYJIoLFFThB1bopDzr4Y6565Nv71gHd7ciywfLXPYQ6yTBNpZh/2RSmBQB+e+ja86PH
 CUip+9SBF9kzpxZiGkp6FhfuDN54tAmirDRWrtRODLUV3iHyzK9uH0jo1tXljQOt1NYRquUBhgN
 bGB/C2ihy4oE6qHKnMakBSbtacDEQp6fbBYxfNGH84kysXmJQV43Mv1NUjNnf/aHFKvNkgWDtin
 vHcT2e6jtYK1G5qPaEchHbyTOloRaGL4KXF+r87jQrAvoJFh5Qt7IswZ/Fmv1p+Er+tsRg1Dn4Y
 yYvnyN2mVheduT8LzO4AzsbzrjhkjYvz+vNbkfnZ450m15iY9yEiaCFyFc9WzGuR4PWA4+Vqbtb
 79F2tyV/LUQcR35Okda9wZAqhOGnH1EsdPjzfoAjV9UaqS3Dl7KloSMDvc1a5nEL4sX4JzhZgHf
 9ZF2kvH0tk3HMIpOQQR/ZbQ1CTCAxX6av1Qdbniwf08+kv/DyzDulxnlVG/qXDQ5LhC5fF3iUpM
 hdZiVTFUbzMvEXFScb9AF/4l3uK9w2PgNEZjDZ7aIzESl4APeYcOLcMK+vKAIPJUlaOYbOwMBZo
 lfhFveb81B6cBFCYG0aoXsPcfnT2rUfb4+52AfSHbC6d5HEiyQpdiT+5q5UoentxBKekBIrFEPc
 Y0M8FNdhHVNmC2g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The mutex initialized in probe() is never cleaned up. Use
devm_mutex_init() to do it automatically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index dc87768276ec..d6ae9cf1eb54 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -482,7 +483,10 @@ static int adnp_i2c_probe(struct i2c_client *client)
 	if (!adnp)
 		return -ENOMEM;
 
-	mutex_init(&adnp->i2c_lock);
+	err = devm_mutex_init(&client->dev, &adnp->i2c_lock);
+	if (err)
+		return err;
+
 	adnp->client = client;
 
 	err = adnp_gpio_setup(adnp, num_gpios, device_property_read_bool(dev, "interrupt-controller"));

-- 
2.45.2


