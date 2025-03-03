Return-Path: <linux-pwm+bounces-5080-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEEA4E9AC
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 18:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D975A188E51D
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3D2BE7AE;
	Tue,  4 Mar 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UUb9VCzB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FD2BD5BC
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108538; cv=pass; b=sAqb8uuQuf2qGGIKWDHxOAirkZCKP7N7nfiICJ9oQA/+Nw7WMeIZHBnOEcI0zakwjOIxSNM2uE1Vz1VtX2qEHS1O8TezG6jSiWsbuInGU41NaTzBeojhO69nCi9N5QIdR+dtpe5UbfefWfnjLmue9ASkP+th8CQ7FlN7UHeqwys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108538; c=relaxed/simple;
	bh=J1ebPfDsymL89EYyjnHLGCQ5SmI12B8EdLVOUvf6DkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXyF6uH3U1UZ+KZ+jllnnxW6OdHHnkDod1MCnGY8N10tM/VsJmR3pLwRU5GaVaRuwIzuK/3YAx+zGvLsIrYaWXyZg0VLoT7kjA4QmtvP74llMFSBErqU8F1Sxu+nbINCjAUSh3/92ypqilL5suQYROH7drtuHvKJPbh6mRJWCjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UUb9VCzB; arc=none smtp.client-ip=209.85.128.50; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id C6C00408B643
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 20:15:35 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=UUb9VCzB
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dlQ4YqgzFxQf
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 17:45:38 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 32EDD41898; Tue,  4 Mar 2025 17:45:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UUb9VCzB
X-Envelope-From: <linux-kernel+bounces-541794-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UUb9VCzB
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 2FE8042269
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:22:37 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 050A52DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:22:36 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831771896DD0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102632153E4;
	Mon,  3 Mar 2025 13:18:57 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F72147F8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007933; cv=none; b=aqwA76TnZFHv++oQXdRDqB1O02C5AMMSdyYCQn84CXSzLP7Iys9BXXLny2EI4CiBV8/TxuaEWwsKvgzyJjUvKRQqCqxEwW77m9DKEcUZoZe3JyOzxb8fPWzXHCJ6sSuLKCU0PqBIder5FWUqvPP85pIoOI/dfyaEl0VkEzTvC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007933; c=relaxed/simple;
	bh=J1ebPfDsymL89EYyjnHLGCQ5SmI12B8EdLVOUvf6DkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fO4J6Bxzy83pkQv3wX8iFSR/RYiZ+XgdutkT0/mwow/4zVWN/1KWctfRuGo4EHp34rw6leEEliz1zCCWmIPo16ZW3qMPKjmFMLaySGrLR+vft+X3dMrGeFgD82+v7jX7+UJCDCvcwUtxZ/S3YFaJeogXBNZjEo+dq06CGQoAYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UUb9VCzB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso5916685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007930; x=1741612730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Axi8YRJzHoLHKP7VK2GqIyJfaSqTW3LqYKFDfDPjWc=;
        b=UUb9VCzBdF7zOpKTNlTvdgwcbmqhRb8jTB580yFqg1bxKW/QYBbAi9wZx+6rABxblu
         reV0UhNwEr6RiPSIXekxOhHfDgpKrArlNeGRLKznozpB9unylh0lohqzVj9qq6Z0Q6vT
         alG8pz6HQoWHi17FPYWvVtuQ0w6LIwSFhwIT0Oip8eYQrPzakzck9xyG1CMPboreI+J7
         0BFFHzcDeyWNURTrJePT3dms4cKMlwgahC7RoWt5fRhKmi5q/Pyiz9vLe6pByIU7FldQ
         MwinrfUuDa20XnkIPD7SMvzThmdlqEgVtLHQwqLkMItKRG0nQ+ialglVsWdK1Q73dCR4
         xXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007930; x=1741612730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Axi8YRJzHoLHKP7VK2GqIyJfaSqTW3LqYKFDfDPjWc=;
        b=ZmcsxML25Yu4Pl54vZarnHrFhdppAyRDl2VyzhqjAIRhnRSQUq88UHI3ySZcpaKFLf
         RODNjKEz/sqLv/b+oGXRlYd3uXq+3Icr2XZ4b+VgJLtwpALxMP+3Acy1y1zeBTrxhGK0
         WF9klBV6gvZpq6L8v0LbzySTUB9R4wpuDid1VW405Eat+6b6Q4bPTriF4SM2GKbajW9T
         CkZ7HWkQXNaa5Dhwr2Beife48Ye3kz9VbFC+etoqxeuxBowXtjqKoVhgCAG+bB16gibH
         3FC9Nosx6jRWemvc71P7WH729kGfYheWUrgN/IWNYidQ+vmNpojRMSLYeihXZu/s7EYb
         26IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiZaOdIj3Q0ilCUnArNmjxpCynpew77jP32M6oiMi5YG0JM/sHZdS4Yq3Fixjms3ugKbboxGHCFNxoLss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWw6o8+FGZOXOkfAQLREIou9esQ4dcQ2SuqHlj5odE2+ynUgD
	j7NGpbgQosJDMHHSSx3xogUAIivYf2NMKEcZHpPTi2eT3xAQuh+/Fvds+Oxj8rQ=
X-Gm-Gg: ASbGncsOuxkAogdmD3vB/bG8Iqai6gJGXiH0tx2jj4CokmkMZju+AcKZMBuPhVl4cV9
	rAJ3FT0nQdej3YywwJzzMq59QuYlhqxZp2FRC9ebPrt7s9cFPF/h2EGr6Q65j/rOKg63CRlGD9h
	SrooKHkuVtwEFH8/+tkZepuB4b3b9Bj3Gg3EftanbRxrbbG4F7/dE8/QMNP4GFC5komIDjfRlgd
	iPB32xhi4clsmZXcs5FX5m6RKeHkOsk6HZSLUdx03TIuvd55dH2/YChKyK5tAci7TjQLh95g32h
	/fEyqHeuidtbwhr+AUI1UjsyfHeSFxZao3wE3A==
X-Google-Smtp-Source: AGHT+IEYGtm956aiE024ARJ2YI+wm6oMviFmiaVF8KsdIN5Clg89Ip+CqvEtma0/pMlgb+be7pTlmA==
X-Received: by 2002:a05:600c:3ca8:b0:439:84d3:f7ee with SMTP id 5b1f17b1804b1-43ba675d56fmr88856985e9.24.1741007929922;
        Mon, 03 Mar 2025 05:18:49 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:36 +0100
Subject: [PATCH 11/15] gpio: arizona: use new line value setter callbacks
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-11-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/sU8cBlWkrzRnahs8pB2nRSYYvpui0zCRmMzsOLe/tU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawraFYt3OLPOcsUJTdWtbmDf7jf8fWbJTlqG
 F0x+3X77liJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 csaTD/9Lb0FTC8KUiNCwa8U+38+asQjGBBJIpJ4m2oHxZOZqIc4wVOq47KeugpmygKJZbDzH9nY
 VokyB5RQQdWl9/JvjKQkDl3oDwemi0Seq6VX97lRYJ+aTkwO7BQjHHEEVIP3muwuoNhsXDPa579
 7wAsmgYPxunC4nioaY9ezXw4eenqB88jwUU/o3+BqgopQAJ5e8X/2JoxQZSo/xAYurmoqiOY6wd
 p73NKeItCF2pHZyCLxxR6p82URyBidDFAHMLpCd3HfTvKxmRBNm6Ce4obmLcD3HyhPJSLtXiDhZ
 9TADKmuz64mhdRBi2DnAlxh2m0pxFAyAt495sG1RU+RFeiDmoqfTcLETX01ozNEpfQanlH2Hu2g
 srX9bkbJu9VNN5aVa26Uu4H2jn1vnWuc21drG00Uff6xB6M0MhwXu96GWPhbCkTxXPUz4CFlDN5
 rNpsy2TmVoIqAOdK/ikHR8/N+/XlOkpvUZzLEwREHABI/4GLxoLb0lACmmtAamOHcDr0JlPrbhL
 UyNV2+Lmcy1PkrODKfKTXG99i5mDcXnhnbMjTP8DVFB8gyg3nfYwrFUJ2OE98ffd+bZBl6q8Q9m
 C0z8DgLTTNUabyQIJqqEx6wQDenlo2nt/gKTANo0OX/oLyK0VWh4qHPLHtqQY1XJ9zgAioTCALv
 zkNFecD6T7gJS9g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dlQ4YqgzFxQf
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713247.63771@JuC4JDCoWeCr6mIvtlSsIw
X-ITU-MailScanner-SpamCheck: not spam

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-arizona.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index c15fda99120a..e530c94dcce8 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -121,7 +121,8 @@ static int arizona_gpio_direction_out(struct gpio_chip *chip,
 				  ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
 }
 
-static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static int arizona_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
 {
 	struct arizona_gpio *arizona_gpio = gpiochip_get_data(chip);
 	struct arizona *arizona = arizona_gpio->arizona;
@@ -129,8 +130,8 @@ static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	if (value)
 		value = ARIZONA_GPN_LVL;
 
-	regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
-			   ARIZONA_GPN_LVL, value);
+	return regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
+				  ARIZONA_GPN_LVL, value);
 }
 
 static const struct gpio_chip template_chip = {
@@ -139,7 +140,7 @@ static const struct gpio_chip template_chip = {
 	.direction_input	= arizona_gpio_direction_in,
 	.get			= arizona_gpio_get,
 	.direction_output	= arizona_gpio_direction_out,
-	.set			= arizona_gpio_set,
+	.set_rv			= arizona_gpio_set,
 	.can_sleep		= true,
 };
 

-- 
2.45.2



