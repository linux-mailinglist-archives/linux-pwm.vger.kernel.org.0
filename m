Return-Path: <linux-pwm+bounces-3405-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB561989F69
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 12:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EC8285199
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8918A92C;
	Mon, 30 Sep 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sJ/9H8JP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82F5336E
	for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692325; cv=none; b=cxwn0EGGcnsIZGD7RqIcqqEaei57q0fzWEskHaF6fJiUXvrWdhOGr0Jd7ET/oZCnTDm644DUrWp0LVl8ptnWAjSGHifLiQ21JPI2pnBYUG75SDxAvyRyeSF/A5bHwlcPhoW2BtrKmOoRDyccXq/R1Xwbl78RDKINjsiDGewQgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692325; c=relaxed/simple;
	bh=CQBiquwPJYNslu/+jeo9tvNeIusUOgAyH92OuMpD8uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nY2lP+Uybpe+38w+yq8CLDwj3QA7EjKSrlPp9glljTxR2pGEiR+6EQhh18nLrB/g/k3zotVvHlUTEswHHK6aD7fX9VZ2rLWeZ5XrQJpvzAoLku3dHNm++6pzl3Wsz7L12T1WqLulIwW7VUK/dzMJi5KEGAwquiXOTND47FfnNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sJ/9H8JP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ce9644daaso648126f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727692322; x=1728297122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3A1gwsFCiikEDi0rY6BdG2On460nhwk+2mLer0OuSQ=;
        b=sJ/9H8JP9EuKrJ44ioHa2iOxE6DjwvXonV6pNBU1pG7mYzI69I5K82QHtClUhM1KIo
         VQT+hgz1m2eBqU31dGTRe8cVx+VMmBhweKFjrBwxPEf+8YmzDQtqv3dY//eMaVjjpB68
         qqBsLEgOskuPcfmBCiwg/a2cdX7cwe/n7w+1cIQu8KNvYOZLCyDI+fdqJCx+lOP7r3fk
         HkglLVbsAYhSJk3UDxlCSWtKzCBfeRHKHja5l4MpE6T2Kr6Ko3Gmg6N6X7mffHMku4uF
         VwuIomjHn4SdiLG17YCRrYEWL4+APlzDDnRRiXQzBfbdrPsLANCf0tv4Zwk/qe5ei/7i
         aqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692322; x=1728297122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3A1gwsFCiikEDi0rY6BdG2On460nhwk+2mLer0OuSQ=;
        b=mbhd8dXISHdsEfAru5YpzjLHKXO3i0T5WyrsjzEF5JTPD8KaVUy7aacWs7hD1sQHu6
         O5avRJpAJ1clSLXggctEIgf+RsZGD5fxKB928Gp69MMu/AysSVUJOj8fEZThW3OiuNuO
         xJsXOdA+OdNzAzkGm4dzrsfqU8G01PwnY3HKgHsPG0GvqFsOEWCyvlARMmV8U7ogGT3P
         hiLtC4TrnWb/0p4OHZ8hAhU8bQsO6RxYvGyBH/bYMBgaLJF85G7pNWu20OFKI9JV7vT8
         j+ZuKSo0n/TiWFLgpUyxCOy4WAjcP/ixEePO9wwszwzqmowfaSqeIQk0MAyyCDU6YJ+v
         qC0A==
X-Forwarded-Encrypted: i=1; AJvYcCXF0UJMzv+N8CdAKbEDzYMD8sVasOlFrCyAs2WlBB73EC8fr+1hAztSxNUr+vqIn9u2g30rl/LvfzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvcOu6T2/UB+ytWpupd5ovSNTMI7IsQqVhdRdAh+Okkp7RCnaj
	gcud8mLReUmCoOhUhTweQYiwSjYQrOaBR9fqdSrSFZyTTwSnaGdVpDhIP2TWeck=
X-Google-Smtp-Source: AGHT+IFZbYwugRIqIG5RKdS3sy4SuxyJuRmJH18Mpd9Sbm2l5OpKu+eySXRb2iMevWzzBBW1WU2MsQ==
X-Received: by 2002:adf:f4c8:0:b0:37c:cf0b:e9e6 with SMTP id ffacd0b85a97d-37cd5ad142emr6600408f8f.42.1727692321979;
        Mon, 30 Sep 2024 03:32:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5745696sm8633491f8f.106.2024.09.30.03.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:32:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] gpio: syscon: order includes alphabetically
Date: Mon, 30 Sep 2024 12:31:55 +0200
Message-ID: <20240930103157.49259-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Put includes in alphabetical order in gpio-syscon.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 5ab394ec81e6..638095d5f459 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -7,11 +7,11 @@
 
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
 
 #define GPIO_SYSCON_FEAT_IN	BIT(0)
 #define GPIO_SYSCON_FEAT_OUT	BIT(1)
-- 
2.43.0


