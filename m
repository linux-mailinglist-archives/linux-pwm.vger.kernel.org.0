Return-Path: <linux-pwm+bounces-5068-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50698A4E0B4
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA92188E06F
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3AD204582;
	Tue,  4 Mar 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RWQwNS+s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21284205E07
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098020; cv=pass; b=gEcOM4xKxKKBOTJ1sJiw0Dpqc1TcB/hJ5QICof8tSWUxJkJ4UZfS6woz6YfsmZBPhCctto4mcoPAtrYcNXUv1d6PiBYLCxyciTiVRtUIdWWxmrd1Po5DbAzAkYjlgbKgGr3AV2WPg0wBVzeKPZfg171UFYRyAuDbtvCt68WJpjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098020; c=relaxed/simple;
	bh=aiHZJQb821lhfiQdy435wijwae4OL7CouAwmJZyOTG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hm/dUjeiURM64MGZQTDAnAPo/CB0DQO7frlRLCrI5w3+o9/Eu4yzqHrIQa41xXvWrajSY+tQK4M1tg9kxyiYTmIoFjz5aAV3VSglcqVsV/TRXxdRJdhStRIbFORc5xk46KzRVAu0dD5jDTiFSAvRgrxoN9uu6GnGmF/IpWzzi54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RWQwNS+s; arc=none smtp.client-ip=209.85.221.44; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 23AE240CF133
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 17:20:17 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=RWQwNS+s
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6d7G4Y2XzFwBm
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 17:17:46 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id CFC6742745; Tue,  4 Mar 2025 17:17:32 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RWQwNS+s
X-Envelope-From: <linux-kernel+bounces-541792-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RWQwNS+s
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 041FE41DFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:22:01 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id D0481305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:22:01 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2B31892842
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B749213E91;
	Mon,  3 Mar 2025 13:18:54 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B821421E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007930; cv=none; b=nLNr9QxYtcuDtT3sWv2hq9qyoa8R4+wiS1cWgAt+mwjY5xnZqD50c27+0wadBRQr2gSlCTCzYX/jD1BF+f9Avj3ogr6WA5YzaojdwyXWMG9qH9Ju4WBGpxPsWb3Qt40Al3AAt/TPCFjWSwFK8LqJQPoK5oQ6Y/L2kqYB3jcOM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007930; c=relaxed/simple;
	bh=aiHZJQb821lhfiQdy435wijwae4OL7CouAwmJZyOTG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbBU7WEQQ8ASWUBrpR1/dSTDC+5raTOqWBYvp3su/Cqh8g6ozij6k2PF5RKGZE6JJKwZKoOEcsPEA0g0MBL7DQLIpyCWFXSXDNK8ZUwdhPq2HYFDvjNhveonGxw7ZI924d6O2AtTvB3Ug4kCTCbgcBm/2avvbJ6/LpMYhbz9prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RWQwNS+s; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390edaee0cfso2171222f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007927; x=1741612727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Eanl17qUXG71sYy7CwEaQ1Eemxd4O2oMCTK+HJwW1c=;
        b=RWQwNS+sgkXas+mhfPJqzMLzvslK0qV7odkrnY1Smp1yQlZb0zuGdaVOQ+9R/fRF/N
         hAoAGpu0PTn8UCJAZO3bPiVVZDa9zVYbWm9rjPZ6SStfe/gIsop9y0qSEQRMcx3bDCRb
         43eWaD6ly/cpg7AcBBAKCwEEvItojQUPrWvl27BIUiAs+hl9PvSGhcRU1SREQmQcNg+j
         vzk7CTUpSxmmghz3dWl+0NhjsM7hghspHlXoJkIkegA6d9/XEY7tw3O3k7cni99sOhOf
         tKcIrrst65KOBVUz8+gkC6Pce9j9Y0zoZl9513VvVvy8wSLj3ULN950+p75+ml2/Ckmn
         B1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007927; x=1741612727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Eanl17qUXG71sYy7CwEaQ1Eemxd4O2oMCTK+HJwW1c=;
        b=n2aAZoPt18Tlxn9vmqfk4HSlcxZ4vebHZPIf8Dw5yXnYAGrzM3auVEO1eLSGOkQ7Ie
         yTWJeFjs6XsGVSFHXioCkpUQ3fs9t0Yw9BG4j013lUKypYHBKBNjdiLSTVC96DwS12Vv
         ChJ3C7pxkVcGzQ3LVrWZYfT9Bl+knkOfc1FAy75+JY8+kN9qKN/NpTXOTQFawbo1ti9f
         CmCV22xV/kFwKwXTifsqy4OsbmkeWjXMAiTad9bDEprITHsckDqOq84/4avaBHoUbc9P
         uB1ZgwnFtRGAB4ohyqpy1vq/5g+r5KAAdyxfNl9FASbbxwI6rWu0KCSjMp/EoD/tZNb2
         Io5g==
X-Forwarded-Encrypted: i=1; AJvYcCVPem4Wm0Ps4O4tu4uIjvCZ5ATLyP9NKJny/EUPQmQzjQIaBgvouWHB4ToO8ayMntbiSoppowxDJ8C1LnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmsTmprk4lauMcO9GQgnx/PkOZiy/+tWrOuua6TCMz15JMKYl
	RigYX8wgs0kVXgvIwb6R/+yr9//7T1LW8kkayVkDvNm+GsbGQjmdIbNn8rie3eI=
X-Gm-Gg: ASbGnculxLVHWrtIRvlZGTZ8QbBl8uJQYS5ZkslQFXFL4WZGD8CkfTlzAt2zrKbxRf/
	NafY3b+Lvjt1eVdEkPwUUjsmMzXTdw/GTGhaQsZPFL4f43QszB7sPfmwKniUtfu9YcteCyyFISP
	U/Gr7+8RbJBqm9D9SXtw+wsNi7/CL5Z0fRU7KZiQjKI7yoazmNOJdihVYY4C0F7HI5TH/RSgwNi
	I2SsWIufARFreTqM3Z+b8hw+1FZCmXCw78r/Yl/Y0Ux4fLjdb7VSxuRWWQUmMYUfl8gwua8JR/5
	uVtaAKD6diDAJHwTD8M8qK2/olFtS2N/tBj0ug==
X-Google-Smtp-Source: AGHT+IG8W48OymLU+IHB9XFSJz4Ws6HhZ4oe3cmcpMbwh3yAlmIGNVglM90Lo5CWs6gLp9klDtqeGg==
X-Received: by 2002:a05:6000:188c:b0:38d:e15e:17e1 with SMTP id ffacd0b85a97d-390ec7c6743mr10583036f8f.10.1741007927451;
        Mon, 03 Mar 2025 05:18:47 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:34 +0100
Subject: [PATCH 09/15] gpio: amd8111: use new line value setter callbacks
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-9-1d5cceeebf8b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=IGpiMZp6L9gGWujO4qnSAPvX9iEEZxJHKKOMOCB/YPk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawrsUI2RWcy6gYPrX/W+WpNP5fdKL0VhBngf
 HbvtbNwL0SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 cn7uD/9fLib1qmXJVVjOojHi15zCxHxK9YZHqSAzCp7rH94PpJrQVFK0/4M/9A5SA7n/43yhQJt
 q16nhbWNsd656/N/6DKOmlP3alKPdHDzsIIJLWSCtEG/DUuKltm5rByCe83Q5WN+j72Ppw2dcXM
 0QndwPOucqxkqiqLUXTCx9n6rgL9K4/A66JfBJ3k+fnOIKWlQYRad+5Ja54geRp5RofS1D/RWVr
 r0dy0roFTTJ9ZB4kRj0pkWd7EO3pEYWcI7kSIl0y2+RjrvhSrYLQftUvg/JPPXEXds/8aiJ1Ew3
 xURb2djMwd0qp9hk5BgCX8JH8I20ZfXCGI4qWK80k6cMIMu8O3qyTd4CapXeIhFIHj760lTqZLb
 98+Poi2DamuEmj56LQN6R0v4nx4PIQWNEWYclzSyIMD/ThQZwtG9+MThzU9Baz+XhENutJBT5CO
 YRWrfqqV+XAKVNMeeE9szHW2C1uPqGMrLIar0g97JpGjqpHv3qPaIaZHWlq6E9tntQctjiMJ4se
 XimBq7eoM6qsxJRvRSXx4GSUb0TkysTs4XTpOZJf0LeCfU1UTnlQrIAPP5scSCe57es8PqKeVM4
 NhHNMAzFCUJvtRyNFSbOtJziCjPmw/weTEqrkCmM3p9OIBCRqEtfHh8aCuFfn13QvOXKYFsU9fZ
 vV6G4nC/fyB2SOQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6d7G4Y2XzFwBm
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741702738.88072@q2xlKvxRTrTiDBM6XK9Oug
X-ITU-MailScanner-SpamCheck: not spam

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-amd8111.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
index 3377667a28de..425d8472f744 100644
--- a/drivers/gpio/gpio-amd8111.c
+++ b/drivers/gpio/gpio-amd8111.c
@@ -94,7 +94,7 @@ static void amd_gpio_free(struct gpio_chip *chip, unsigned offset)
 	iowrite8(agp->orig[offset], agp->pm + AMD_REG_GPIO(offset));
 }
 
-static void amd_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static int amd_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct amd_gpio *agp = gpiochip_get_data(chip);
 	u8 temp;
@@ -107,6 +107,8 @@ static void amd_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&agp->lock, flags);
 
 	dev_dbg(&agp->pdev->dev, "Setting gpio %d, value %d, reg=%02x\n", offset, !!value, temp);
+
+	return 0;
 }
 
 static int amd_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -163,7 +165,7 @@ static struct amd_gpio gp = {
 		.ngpio		= 32,
 		.request	= amd_gpio_request,
 		.free		= amd_gpio_free,
-		.set		= amd_gpio_set,
+		.set_rv		= amd_gpio_set,
 		.get		= amd_gpio_get,
 		.direction_output = amd_gpio_dirout,
 		.direction_input = amd_gpio_dirin,

-- 
2.45.2



