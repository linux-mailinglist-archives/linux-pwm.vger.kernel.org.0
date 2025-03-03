Return-Path: <linux-pwm+bounces-5091-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC71A4EBA9
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 19:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717347A3CE4
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B527CB25;
	Tue,  4 Mar 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KzxCpQol"
X-Original-To: linux-pwm@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939122512FB
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112423; cv=pass; b=fGog6ZZX6gZC8Z8CQqCVxzJfQQKh8oxTVEAWiVAwwNikUWhvbYO2Px+XMck7f+u8f3L7zdpd0NQLZ18Y/8/CC2IQ66QF8Woj5IJYzNhJIv4+5G2g7O1lsjqrBr+NAEBrlxD8/co16kZsaDjSojgmq4ajY8c7eGP/93vyBQy5cG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112423; c=relaxed/simple;
	bh=V7EBnTsQdSCBlLOBmNG2woZ3wkKd2doIiND3mGdJNIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utCPrOaySjpD/pGNaZyTgxgJn0msfuaLwl5r6NoToz3IANxJ2kB0MsCnCdxRatnnLoWm8Zown8Tvo2Zi1YCdbuz9lLbLRwoyYAtELJU7ICqtqJ/ys3Zo8YA5XLdEMf+f9XNutTo2gtjWFgkpKDuxYeOTFJphe0JW36CzJMoxKFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KzxCpQol; arc=none smtp.client-ip=209.85.221.50; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id B7A4A40D0C6B
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 21:20:19 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=KzxCpQol
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fhv0x9RzG0MN
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 18:28:31 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 806E842728; Tue,  4 Mar 2025 18:28:25 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KzxCpQol
X-Envelope-From: <linux-kernel+bounces-541787-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KzxCpQol
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 74B0241F4E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:21:11 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 0CB4E2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:21:10 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297A73A9A7F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D5F21480B;
	Mon,  3 Mar 2025 13:18:51 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231920D4E9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007925; cv=none; b=mMSxHmgiT8mutmBDR6Yo2bwIfuU9139WtWcoQ8hclwkk2Xne3G1Gc6ISjVVyO9PYb9WyXyiiIawVLxX1aefA/JBzj01T1tiRGLsKehVvZxwh2woQgtdeKIsgPx69D9bzNgtKyUvGzUGHBhhp+Kc0V2TBHDl/gpISRposIpmAIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007925; c=relaxed/simple;
	bh=V7EBnTsQdSCBlLOBmNG2woZ3wkKd2doIiND3mGdJNIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZpTt0tQodQ6wV4OsrTtQnUzMNOqCHHamCuHOW7j7/KH5KpoCs8J6F0YfEaBopxxwe10CQA+PlCj3Gf6dbBzaiUaL9miXdRuVkE6STYPxSLydP1GqAC/QtQL9VKS/iYCG1zg5cUl59fWSYAwSu4pijRKKovWwDUUTMsZosrybC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KzxCpQol; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4146001f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007922; x=1741612722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFP6OzlnsfQDERRUw+GGdLYipfzpI50/ga4CvHUlY5w=;
        b=KzxCpQolmbQHhiUOeSpBeMCqPy6JA4OuMdbhB74pXQW5SMzX1vJionOHMiEm/7/S2v
         NbRMaqGWhgq70+EOZ48z1ar2mOWgndUj+QPteHsI8IKv1e2mwYtnLTR+5P+4rKbhGkfA
         b1QfBAcdNQvDbtiFEx4DYUSPydP6sN40QqMHp3SmqODDmGAFr+ikD11VWkxmQKjfk0Oj
         6e+Z/6KiVvcmMWw64jotr3CIPjGgLcEXpIAR0XifaiAoF+gTLiIbc82LzH3biYBlo7DZ
         DWyTa21ShFI3gNppDHW2YHI++ospfR3lVpUWZ0SIxpIl54A1LJs93/GYfWjyVnGFNdg2
         VAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007922; x=1741612722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFP6OzlnsfQDERRUw+GGdLYipfzpI50/ga4CvHUlY5w=;
        b=S7WJ4txjcMfJTfRmrT9Kd4YFXdLJlL0nwaSkpiFxYiQHITU26E5oYL5pJtuJk4iXK3
         6IwFg9tE17GKZPvoaIXhlQJwM7ot/++ove6jqn1LdCBYN6KTisq8K/HkLJg+u0qGwPNr
         8ua+6v+7TYr5RorETuk9f1Fecq5bhVOJdlfl+seDJk/8yOLvMmUcSMP9Pn77ig00q6TG
         u6rNqUyDbDQ9t2mx1OSQmrNzCs+sG104cGA44Midf44sYiWR2x82Tc6XOP/NXztWCu28
         SxwODhtF/+XsPnt4r1F9mfbR8huFVatpCgpGkupivXFXoJT14kOfDeLLN8oizKm8/RWn
         YT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXIQ9ebefd/40z3Uitmx2TG+pL9oTjb/838M1iG7fNaUMbhqaaZOkPXeNbLYIwemszvG1iEGlX4j2pU8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKJz9aWoL/WPFAURTUBhOS5WvfuGIQXqEXy8JDUa7iVmeIJdz
	y1g3WdedHWVE8Z9AhZD5gSXC7BWB7hLyULXFF9Xh/HDRMZ4nFY0Ti+LfRPs3GGA=
X-Gm-Gg: ASbGncuGfQUBD3BiWykfwSY84zmLNxdDqNW88fprrtnFWV5fHEalI8m8wVB83wCIAvt
	e4VtBmWdWEdqLl5npxv3kzY763OC7aFXn7sNPgdtCdnYMbh0+B9vzko/AdcQGGviS3GoNhfA/j2
	YiYY6GEVfIr51QnSc4N2SLAzfQOAtsiBARBHooD0DoD+3WVCcPveneG7oEx/q5vEAXu5ps1xCeQ
	bhy7mcxHji6A4yCnh7+xjabr23sxB5lTvD7gFmS18k15nI5lYuFvn2GAfroqGo/5M+uvBEhSn9w
	AlMjth3jXNsVoI5cOeZdQEJ7wh9knY7DS5eB2Q==
X-Google-Smtp-Source: AGHT+IH4JWES9ARnc+bAEeGbW+TGmzRI13+v2x9lWq0KdFeC2YMdrtpeHPu9rNemD9SH+Vsoyms9pQ==
X-Received: by 2002:a5d:47ad:0:b0:38f:3791:c1df with SMTP id ffacd0b85a97d-390ec7cdcd9mr16010467f8f.15.1741007922072;
        Mon, 03 Mar 2025 05:18:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:29 +0100
Subject: [PATCH 04/15] gpio: adnp: use new line value setter callbacks
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-4-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=kaPruJN9Kqnj6pYgKtiRCJyUBIyZUBSHWZ9yCXz+XTc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawqMe3ivpxHTwxjmRFDD+r5+f7Fb5d0Noi1G
 O5lxfuzzSSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKgAKCRARpy6gFHHX
 cmp4D/9jaHcQF7O+UdJIKHTVsZUWHdT/ZGnlWy1V3W1/TlaMF97G5wDnkiNu8Abc/PxBzSIt7Vo
 KBMyBZrdnswEDYNm04jbPBI25aQfX6tWozJEZf9iYmpe9wFlcFTzksQzJpUFBtmKqd6vNbmfItm
 fCi1KIafodHkdb9RUDWAvSu2oq3iv97mq72cqDYzqnwYTFGE3sRihwrVxQf/zbQxdJ+Bgggp8Zh
 bqOoleGxS5pKG8fcqro2cd/HEf4VsjNbjq0tFes+XRILE7ef4PWHacVJFLwiHuR6mgfskXZgqGm
 o0O3Q5FWRrbNpDJhuPWkvn/dR7gqcipLj5GyQgSL4t00/D2oFvkYW5n9LVPpPADv1N/YKiWNr2j
 HInoAV+f0REw8KC8InxkPcpaErGNaaXwgnrAu5Y9HXWkhzcSjYZfS/1xCmXXQKXwZN+Ln+fX4G1
 YccNjDF7ZFOmxClF18WPVkMu9m5kvZjyIqtgnvo/H8X+kMCpX9DR4FsmqOa6rl0KO8IKcge+D7d
 WobcW2JM7A49kYe/ZlTxhEX1pTfXKAIUfUuy1/o3ocVUdiIZjPjBbkaHyimA74usFeUAxDL1+q8
 k3cJxwl8jpJDmJvWpGCh5g+HLssBC0WNpo/UvXCxt3vqB7Wnl7G6Fmsfv/4nQk5KRv4/pPF4sj9
 CHJZ/DGf3QGZI2Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fhv0x9RzG0MN
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717077.63133@7HL3gHTyPh2aQkKTI5ubFw
X-ITU-MailScanner-SpamCheck: not spam

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index d6ae9cf1eb54..b31ce0e337ae 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -80,7 +80,7 @@ static int adnp_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return (value & BIT(pos)) ? 1 : 0;
 }
 
-static void __adnp_gpio_set(struct adnp *adnp, unsigned offset, int value)
+static int __adnp_gpio_set(struct adnp *adnp, unsigned int offset, int value)
 {
 	unsigned int reg = offset >> adnp->reg_shift;
 	unsigned int pos = offset & 7;
@@ -89,23 +89,23 @@ static void __adnp_gpio_set(struct adnp *adnp, unsigned offset, int value)
 
 	err = adnp_read(adnp, GPIO_PLR(adnp) + reg, &val);
 	if (err < 0)
-		return;
+		return err;
 
 	if (value)
 		val |= BIT(pos);
 	else
 		val &= ~BIT(pos);
 
-	adnp_write(adnp, GPIO_PLR(adnp) + reg, val);
+	return adnp_write(adnp, GPIO_PLR(adnp) + reg, val);
 }
 
-static void adnp_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static int adnp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct adnp *adnp = gpiochip_get_data(chip);
 
 	guard(mutex)(&adnp->i2c_lock);
 
-	__adnp_gpio_set(adnp, offset, value);
+	return __adnp_gpio_set(adnp, offset, value);
 }
 
 static int adnp_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -430,7 +430,7 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
 	chip->direction_input = adnp_gpio_direction_input;
 	chip->direction_output = adnp_gpio_direction_output;
 	chip->get = adnp_gpio_get;
-	chip->set = adnp_gpio_set;
+	chip->set_rv = adnp_gpio_set;
 	chip->can_sleep = true;
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))

-- 
2.45.2



