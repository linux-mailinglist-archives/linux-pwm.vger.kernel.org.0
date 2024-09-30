Return-Path: <linux-pwm+bounces-3403-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51295989DAC
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3E01C203A8
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BDA185B48;
	Mon, 30 Sep 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kh9BH74L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238615F3F9
	for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687480; cv=none; b=oqG1+Yn8O6NIw/GCrbJPD06mTRFDC+nuxxspVQiZtyrGyCmp0EP1DqdF+h9OMex39cRrT52lCamjLdQRBcXuyxmD9gT5iUIsg1Jj2UvFZxpJG4IuYXf4FC91m6CDD0xIvjkJaF8nlVNhLZ5Kcih7O67vmNwS3GEtD8mjRfKqNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687480; c=relaxed/simple;
	bh=qDdYD6XtEzoE+bIvCc85PjknxnyK0Eqt2/xjj90H5dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vy843s/wdGUJ9w81y/hZqcBvvuxoWWc6pq15uLlb4vMx1q61JMnKYTHgOM5EKQve8OYSrlNEonjzj1STyBpbU7K88vHnBnRNr9gKMN1AgOyHH8txlDeXxfVT+bXe47VbyTDRNY+HjH7oV9LRgEL5ARnCC9M+JAlw6maQ6oEtiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kh9BH74L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so51085145e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727687477; x=1728292277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+AJ60vTnn4OfaHASmdMRI84bP+OXJuds8ClPyVwo7o=;
        b=kh9BH74LmMvj1ggri8qbrpl9WP6wsGmgDs01dFbaGQbC8avDQkOSmXOX6f5oOIq1PU
         mQWmbqeI+pfGuFl00iwh/NpdmVXy2Ek0tBaoxSOplR2BaSUxrHFZfi/0hmqwpOE0sQCF
         KN2giS4MdUVO/93HLG9tiImo5dsy0v8gx5sqNI4BK7IKwtyHGwQR5frcdscSJZGuApqA
         GywMcEhOlj4MW13fz1w0QXxhz1rnfCDG1KkzzGbQo9yhV0Czgc94pzLjWMGXtJ2xg/Qh
         ZHbCDTruU4VPN13XYvkSIOb0th2PreisZMaC+IcgqsgwGY2PS0qenhRFIbhW03jb1JIO
         +zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687477; x=1728292277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+AJ60vTnn4OfaHASmdMRI84bP+OXJuds8ClPyVwo7o=;
        b=tIYn24isG4fypUK3MUZOk1/TT/CWMtgrDgdqTdXH+Ci04HYqle521synVZvc2J66AO
         v0jlfQpH1ysS7VHL5Nr9GJNPE15cIAW9sdR28UASrTa8J1u5SyXY0wbeXuRpdxL0c94F
         k+DEyrUtpKygWIna4kqUR6E5Alsxl8M8hFVXQiz9uUr7M7D2Q163KRMPPFlEM2/0E3UJ
         5m1LyPzrfvsveplE5yF9NTZrvtAzo2ZThSW/lvzknG9kbjQ87S0K+YGEm/gFC0noNGBi
         lD/MVcXMwSlX1XdtPQbRTeaEGVmxAd2m8BRQSYlmmV+JGIpG+b6Zc8T8ZB8p/gvqEE7P
         g6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAXWeymYXO/G/Dvf1RQ7t5AI3iMUYehf5NkRXViv6R7reCQFqb8SsrfDEMgf+w0gO9jQ2Uveou1KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxitgc7vNOSZO8XqMM1Xf2flMtQmXo61KNiqICMMsfosmeYLGRi
	GvYsHwIctp06Ijn9wVWuayhqAGEhNRXvaXbr+6zyrjaj4m9kgTbwbMdfg0eqavQ3d+3Fu3ZAqA1
	L
X-Google-Smtp-Source: AGHT+IEakmid4weMzgcB5hvS4fmSB9tjRPWOIxYXsK8WdO+Z/xh1QbooPSntbIPib3f58YLkywXBIA==
X-Received: by 2002:a05:600c:198c:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-42f584a1d36mr104426815e9.35.1727687477578;
        Mon, 30 Sep 2024 02:11:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec169sm97231595e9.21.2024.09.30.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:11:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: mvebu: allow building the module with COMPILE_TEST=y
Date: Mon, 30 Sep 2024 11:11:10 +0200
Message-ID: <20240930091111.32010-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make it possible to build the module when COMPILE_TEST is enabled for
better build coverage.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d93cd4f722b4..98722e814e81 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -487,7 +487,7 @@ config GPIO_MT7621
 
 config GPIO_MVEBU
 	def_bool y
-	depends on PLAT_ORION || ARCH_MVEBU
+	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
 	depends on OF_GPIO
 	select GENERIC_IRQ_CHIP
 	select REGMAP_MMIO
-- 
2.43.0


