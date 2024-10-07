Return-Path: <linux-pwm+bounces-3512-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F8992929
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD9AB22E6E
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Oct 2024 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36621B85E7;
	Mon,  7 Oct 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wYDUdQlO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B71BB686
	for <linux-pwm@vger.kernel.org>; Mon,  7 Oct 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296756; cv=none; b=H0ayj9BJwkdywRizEcRSvpCxVPL5lUYXoWc3rd05KEIJ2C5W6wbqALenFkWttXYsjrTH4pG8ZFAkoHE5l7WYToJJRUtcAgtRf6rVz3kxPl9t33wdCDDhBewKZMh75aiPYsEeGlXlXzKF/X6k+LQKH+Y2ZIA1RCTlgXuiLq4GMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296756; c=relaxed/simple;
	bh=AZ4aYTqXTb9q4p3DEsDM0IbTpvbwQAKE5iXBImqWgpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjEM/ZBBvH3BOJfVLei32jQrb3B96AFQUBGfULea6wtszA9x/acOIVhV22CGu7S82NSjvJtwkFPNc2PIXJDW+FeLDrl4Ktbap38M1OP0FmvhaEcqquXVQA1YrWxU7GL4ruoFv5FWL7dI55b3AbTJqc6s2FlG3nxYQSofzLVP59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wYDUdQlO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cc810ce73so2224539f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 07 Oct 2024 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728296753; x=1728901553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8uYf00EYYgczHi2fziShElLaaQfAMmUckBMhY+cS7o=;
        b=wYDUdQlOzBf+oyWGS9ksJRL+DcRhz8M4uG8QWQpBwJsx8PDzEWiY/3BF+voeFmOCod
         xw3UxMPM5Jr8JW4J9GiNE0N8VYdRYivmKK+OYV+iNz1Tjed27TMNBjYsP/Z9Grk4PVJZ
         aWAueuuZD/pMVvedUboBOg2+63s7w24YbowcrcWK6UO0zX77pg+0Z+S+vidjw824Xndv
         E27+Af0DX6J0pNqOv3759NZEHjLOsCtPrdXrQ1HTItMqUzfG4/N1cBrhQ2wOZVuo/jX5
         qndn432/oDnJO6BgKK5ShwHFFqQ/QNGYGM38EYzJ4AAOlpU2ZRbfttoMykircc/aaHSu
         ubEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296753; x=1728901553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8uYf00EYYgczHi2fziShElLaaQfAMmUckBMhY+cS7o=;
        b=ZRE+NZ2r2iKIdlVj6BKxgVtWXgRc9DsocwSh6htLIi0EUFcJ4LT8zY5mWpwO3VhK5T
         P4b7G3l0nkywhACttmzkiS4bmuPuU+uYnP5csuiNt+kXko6VRpmLeVawaUXPxqqZG2os
         Q7lzmWGSLKriXsE9MNDsv52g7y8suW3GUbg2Cxr38OJolyfv9hjzK5hcgEmNOHZ4eqvs
         brzLUnSezwhDzkT32RPTOrj/DPJfQwbVmT5hSU5RsXvxivU1m4PVeeaqDx92sWq7sDLS
         PFQGzmI5+CpZXlIjNcGB15uR2p6ekg4DgdVA4qj1Lb6FK2Aw53d2bJYETvL9UcZbh38h
         LBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXntCPRAxiiSPOAz0nGM0Pd+4AAEWd0wTmzLnA6ORvUNLGhARbmKn/tgf+y8OzoVbc7FU7m2sU2Txs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kDntDTQ4PLhykvpG0kwVRoRGPgQNzSkiUKAngyuaYsbcEWTR
	4D5YJAZHjFR+pxVUuMpEodIXN9IZtplowPp+X7tf74gBnQVWF4XXaw5tUypG1O8=
X-Google-Smtp-Source: AGHT+IGoWnkzT8525AyTFXUAMe09p4H7f1gY6gqLj2BHWQIwWIeqaenHWlKIXmGcXpVtGMX/wdXI9Q==
X-Received: by 2002:a05:6000:1816:b0:37c:cd7e:6642 with SMTP id ffacd0b85a97d-37d0e736e43mr5873702f8f.13.1728296752831;
        Mon, 07 Oct 2024 03:25:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a495sm5386900f8f.26.2024.10.07.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:25:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: vf610: use generic device_get_match_data()
Date: Mon,  7 Oct 2024 12:25:49 +0200
Message-ID: <20241007102549.34926-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no need to use the OF-specific variant to get the match data.
Switch to using device_get_match_data() and with that remove the of.h
include. Also remove of_irq.h as none of its interfaces is used here and
order the includes in alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-vf610.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 27eff741fe9a..c4f34a347cb6 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -15,10 +15,9 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define VF610_GPIO_PER_PORT		32
 
@@ -297,7 +296,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	port->sdata = of_device_get_match_data(dev);
+	port->sdata = device_get_match_data(dev);
 
 	dual_base = port->sdata->have_dual_base;
 
-- 
2.43.0


