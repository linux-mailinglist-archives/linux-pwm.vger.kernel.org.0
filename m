Return-Path: <linux-pwm+bounces-5036-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB502A4C19E
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 14:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9E3A916E
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74692135A3;
	Mon,  3 Mar 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KzxCpQol"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E1212D68
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007925; cv=none; b=ZO0WHo5AkEc6RVR/Ph1LgnqA1aqcSBOSXsvU/3KGreUKJHRoL2+hVY+U8TI/SgNABsfwl1u7BXDLDFCdI3zBG3JfZiF6VngNMOyoTUV1I4vitESNCRowR7WH/V0PIa1I62Ve40TfGL5CVN5YalPYZ9xvhRpl4F4rIs/LNzIuCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007925; c=relaxed/simple;
	bh=V7EBnTsQdSCBlLOBmNG2woZ3wkKd2doIiND3mGdJNIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZpTt0tQodQ6wV4OsrTtQnUzMNOqCHHamCuHOW7j7/KH5KpoCs8J6F0YfEaBopxxwe10CQA+PlCj3Gf6dbBzaiUaL9miXdRuVkE6STYPxSLydP1GqAC/QtQL9VKS/iYCG1zg5cUl59fWSYAwSu4pijRKKovWwDUUTMsZosrybC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KzxCpQol; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390fdaf2897so1645796f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 05:18:43 -0800 (PST)
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
        b=IRTMD3A6txTlrpMFcfb7P3Ewu+us750zjqFnhBdFGuNIv1xC8qktAFd4IaEECo65iE
         H5A0sFyjDNfNPYEnzMcsENJvzJTDdhFjMQZ+rInHaL7Il0+N/0IyChD8R8Q3nemLesj+
         yIXEEE4YDTna+OMzUTr2vhNI6XwAf8ZikLPyCPB8LEYjxsaCwxqffxWaxB77Rz8QAYeR
         My4Rx6kEj827LgXFdzlS/qdHs0L0PXYqIH1LzfcqCNLJHomI/ceS219wifIsr0602PMc
         /fmql/KV89uwCcgBXNfDIxZModMpM/UJ9q5sXEu7dh2/fFfct4chRVrv57c6mfPwvPhz
         DbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbPX18Og7aknns8HMS3GNlK0cJrHt92/mfDaxIv9PxhYf/HR+ug6/Cz3HvkBzhNgStfymcMq/c8JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTDxSKRz8zFHFAgurn0f+hScJdY5/Im0Pl8tmSh23XQYY9cW0
	h/zqcuXbnqrNgoRQsh6pc927lPUOfZGX/W0cs1EUHx9V6Uk05DkBGDZZJYDG5ps=
X-Gm-Gg: ASbGnct9WrqedJMuMC/CPDlWJn/CTV6XtivW5nrnkMqsw0xEFKQmsU0lNuleNE/P7ut
	vAnrrFKBrbvntSpbfXbrxfkK0gdm4Fhugttfu56svVOONxdrSDoAqSdHUzNUiCJC39jdkjNno50
	t2O8LNBkJyEOzI2BNCs4QmyN9EjNCCUh8mHIMEcXBJvL98TwMudRbIm9FTlxVYCsD5JgjZodxhC
	x1SkJefuXvemdof6fJXZeDnVu8QU6p7bgGuGSTYohsWrIqK6uOjjoJ92iYhiMLe1hoZ8ejU4x9e
	DbpZtEcapf2xtFZcjn+S7Hb6RCuLNYfMfIe5Zw==
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


