Return-Path: <linux-pwm+bounces-3407-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43706989F6F
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 12:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B932DB23C89
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E618CBFA;
	Mon, 30 Sep 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bbEc9eV/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F318C35C
	for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692330; cv=none; b=bmd1nOAZQY3hLYFfiKsr46lLFqTs/CsLHS22MFAh/mGz/KDkdvk1WX4cbHBSXZH0AdCQlPiwpvmfU9/+vff8HCd0s9ZhB6ROYWXfN/fd918Ij7CNVh0SWOcE4boImpy1uhXwEK/BXQL/zqkwpNNGZZ0iw8o5OpbWYnACGBODrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692330; c=relaxed/simple;
	bh=5E6KTTiaOKc/2wVB8+QH9mI5osox+uyEdBEePOu4R7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksBbaYdiFL2yIzaKrLME1DV3FYN8mA3xcI18NP9D5gkc9AUyM069dMdjY0iIPSs28dUzS718xC1JVO3apS5IC++mmBSDJABWXTJbb4SFOSwR3FILj+NXUdsyIkrX/mlxMC/h2wtUo8kHZrIQbA6lMcUH0Jf9RrKwaYvleM2UQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bbEc9eV/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so40434805e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727692328; x=1728297128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laT5Lrp2VC3fnoAmsJC3kBCiqkiMwP636Ixvur8jZe8=;
        b=bbEc9eV/7U1Px0+TV7uzYjRuxhjG61QeC2WCsHR2wKm9ZPrdWTxLC9w/j0qhBNv2c+
         OPqi+b0J2/oGUrFETtV/oKk+61E+kzIDKXhHn5CkNZh9ZGHZSTi0+7woxVw9wD3nLkeA
         obkpq8xQssQJeDuPbVsXVZSnkzTTA5+DPCIG624pw3UFxR6mylUJ3AQo7wkmv8lAF4Y7
         uHRIYf69FXGNsFjDSsqjWRylmK2wLVlMEAuAEbrQBypNqsDD6iSQnmlaMyM+C1mvCo57
         7Dezp4WgUWSwhbRVi1LGERjESXkGTbLm3oLP2Gh6HWXZCqr0aSK7kPUGVdRYpbrYKMMg
         gTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692328; x=1728297128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laT5Lrp2VC3fnoAmsJC3kBCiqkiMwP636Ixvur8jZe8=;
        b=bNmoZXx02I6X24D56kXA2rNxD998NTpe2dGxx3nRgLliL8hi+pPRiwswOmXiuvAeYZ
         iRsNBdzjVYtrfminSqm72L/i+gezjkD8nNGNv7vNjY8UqooX84Z9bCcd6XzpplmHo/vE
         Q7eiqQStmYGNXsPMeFm4kIG/gXt9cqYnOXM73zCwkoc6TbDyBjkFLNY+71+iQEWoV+Mu
         oiZUc29BySaJTtMS7CkDE8A53geJ8HFBirGwtasqUhLuVnXI0YI3Siq/gpZCaaDeAku8
         /pvs4N7oSz4HfOZIsTt52qiUHIBNYsy1Hz41+AQLCDICPpgM5skJ9GEnvOfJmjH21du3
         eSXA==
X-Forwarded-Encrypted: i=1; AJvYcCXcj6zkm4VhI+LVjfzCid+OqjHj/hoO41OsLCelYijcXs49cU5gWP03evEAnp5pdxbfVk3L4RPuLb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1z64KYk9LgfF3g+RODg6jTzsqPAJBwyKWbaDsm0QNQjhnWRi
	80vy/pnnwGFVgRBRL+tguD3JLfsSTLA1Mbmw3C8Duiex4uQ4yYsCJ4mmTfqqXO8=
X-Google-Smtp-Source: AGHT+IHXW8upZaxGdmS5j+5vFJ2MR5/aTCr9eVUSyE0063qQAsrBbXctV5+mv/YiqGlFZoN4sus5IQ==
X-Received: by 2002:a05:600c:3541:b0:42c:c080:7954 with SMTP id 5b1f17b1804b1-42f5849fb09mr88579745e9.30.1727692327877;
        Mon, 30 Sep 2024 03:32:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5745696sm8633491f8f.106.2024.09.30.03.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:32:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] gpio: syscon: drop dependency on CONFIG_OF
Date: Mon, 30 Sep 2024 12:31:57 +0200
Message-ID: <20240930103157.49259-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930103157.49259-1-brgl@bgdev.pl>
References: <20240930103157.49259-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

MFD_SYSCON does not depend on OF and we now removed OF symbols from
gpio-syscon. Drop the Kconfig dependency.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 98722e814e81..643747da4475 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -681,7 +681,7 @@ config GPIO_STP_XWAY
 
 config GPIO_SYSCON
 	tristate "GPIO based on SYSCON"
-	depends on MFD_SYSCON && OF
+	depends on MFD_SYSCON
 	help
 	  Say yes here to support GPIO functionality though SYSCON driver.
 
-- 
2.43.0


