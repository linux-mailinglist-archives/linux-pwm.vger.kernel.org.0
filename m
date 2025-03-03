Return-Path: <linux-pwm+bounces-5074-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A6A4E5F4
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6FF1884532
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520626463F;
	Tue,  4 Mar 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0L5A1N6g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4017255252
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104124; cv=pass; b=ixrUCQNmjn4jRfbB1PLoGgwyOXpnzRdcnklThCrEe9c2rn8eS9RVkt40ljlheVhp8/Mk7FMIkfOIEQ46LIyplqQsEdgpBAJ912jLW7CtaYHiL5z3ls/jQpWJbQvsmewjIaljSwr4+hz00Oa8zse8JF1imbOnG5cjsYLH9jcX5ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104124; c=relaxed/simple;
	bh=C2FD3r9G96fNyZ/7mG5NtCcGXXprvCDkvpsW+gGA0d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbTOfJnu1qtXrDPQPOAq6qaFHMUAp44ORUr7vulgYctd751Ne0yrGP1qyOQez4QjSRiAtHVjapu78MxkU/+fl1j7eniws07juHp167F9Yo5X51SUA5XkYqepGC9BjpEjhS1alKHK0aueTP5ZGM3tlySn+BCztV3/wL0IQ2RuS40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0L5A1N6g; arc=none smtp.client-ip=209.85.128.43; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 797A440D9758
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 19:02:01 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0L5A1N6g
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gPC6BRdzG1tr
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 18:59:59 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 199F94273A; Tue,  4 Mar 2025 18:59:53 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0L5A1N6g
X-Envelope-From: <linux-kernel+bounces-541786-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0L5A1N6g
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id A7A2541DC1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:20:14 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 3C5583063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:20:14 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6073A95DF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75921420A;
	Mon,  3 Mar 2025 13:18:48 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860F21148C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007924; cv=none; b=Dur/6zmuPxpJTQJY7s5QZ8IQD4QhKV4hZrVjEs24Pl56zoW1CgWnGwZWP70vM1n1BH+CeJ6a79lKH/9TKastBqPHOy1D2zYsgwunJTDVj//rDxkS+2BXbgqI18EF4nCfPe6iS/MOsQBWDxMyin4moRtguIBOcyqg/yC+VNwOHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007924; c=relaxed/simple;
	bh=C2FD3r9G96fNyZ/7mG5NtCcGXXprvCDkvpsW+gGA0d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAbE92/r3Q9IwQtfQrPy9ZTmmU4Q7tnw0khDVTdsNiXFJbX8p7izknE0nl4Ei1AT4qUJu8Z6MWeF7KwInSGr7YHShU91QwTviE48Ek5sQpk8seuHTxbZEzat0H12npMuoTGYkwL18pn0Qa4+5/9DgoavPQy7NCdIGSG/o1JaD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0L5A1N6g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso5914765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:42 -0800 (PST)
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
        b=UYW1vtlOlddnApQbYbUVrCtZyk60cZtGowXPVTLV70GYonOuAruBgJq3xrBcMoEz6C
         UlK57D+Skih+RWE44rF6uYwDY3u9lLri4KB7KlexzyT9V0X3O+t8tigA1IAxvECSwMF+
         TWgDLhJjAxC0sAXbdfHzsds375nalqo/OM2YNhiwILLK/TVXRpmscOmHjRbzJwxWvipy
         HjvuzomymvjxqzztHI+znen9K6zwowMZovNa6prOVlejjN5DLRUxjFKcY8sS4KmH+Wn+
         aRT6FrCIVD0u4od4wvKwg48KAh2xRIIj+JtWmzxcgNpnhvMzu9SRs3F7j7BiOT5IlrkE
         F32Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMvACppqabLj0DQUJrDETQUWFnVaBkrdb4EqRJusNRBVp4adoBP7j4721F/Uv/5d1gyhLqh3Y6OPu1mho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtTkb1a61YfraulDYakvHYJIV5pD3rVE/IX23waadQfNq8PkK
	RLiGMUpk58rY9LhiOuvWzjq3Eeyw4fFlVtm3dR8pIYZlN9vri5LuA51H7u7+OoU=
X-Gm-Gg: ASbGncs6lNI7W9D/tOK8T9vZJ9zj3hf9xN3VEjzlyVEnyisxC9KfJD2KcXHX1L/9xVk
	9nBVVThf8DZadpJvZSni4MCht/euw7gb7aBLD/lbo6tZQ/XM7B/WxBiEIqa1i1WiV68OaLHwCb2
	Vo1Vq8X/Ug3aKU5TC30kFRdJvZ0yYImvPX5pdMlphcDowx/aultbZTSEqUUSEpH8YeFWP8FoHK9
	EOCzENp4lYPSHQoRGA6Szf0RNx0g/kUY0F+ay2o94Ed9ftH4VZPwEnEb2laCA52vocV+N3ZJwfS
	fSj6NcakxDDrTc9h8+9Mahhg15Y1jbdtPA5EcA==
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gPC6BRdzG1tr
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708820.98759@KdE7hEXjZIAWrYlkrXoRhA
X-ITU-MailScanner-SpamCheck: not spam

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



