Return-Path: <linux-pwm+bounces-3406-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180F989F6B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 12:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6FB1F23512
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2B17D358;
	Mon, 30 Sep 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CYljyKVL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56F18A95A
	for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692328; cv=none; b=uYm+fTqvI7Vj0PZ9sHPiBnguGnFNMZxzObkbNkLFDBclI7g+79kFZ1yfRhI1Biovjr57F1d3FSty+2lxdZ2ci3ASx8DO1HYRAUD1kMG9BmnGrat2OxrA4W6N8ZxZ80uXnL6/51OY4ON3luNQ5wchNLtzc1gLYNIoiE7q+P/RBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692328; c=relaxed/simple;
	bh=aIZPTXuyA3IdOp3E5tKoSd7rL9GYMk8CHYQ3RC0Ak2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEap5M8nX1ZoCfxShnteG162HqNLUH+QuLTf7vXKuPpXwliouC3HFiJNyUJwDCb3SnYh22aEW9Yzbbj1FfHZ6UrJuuYBWZwTEXM2+l23lScidAtg7tChveFqci5T1digLQeV00EJTNaYWxPvCSZJO3gZzC/HsZDTOhDJURiPJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CYljyKVL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso1156355f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 30 Sep 2024 03:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727692325; x=1728297125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbIeQCIQG29ruA9aOyFEUr782VHdH/golS3SG+SvRT0=;
        b=CYljyKVL3PYnfLVmqxlJ1vth92v2HvW9PNaTpG2rzKlWdCv1b2PbVf+LogXhv5cy5j
         4V7O+SItBkk3iIwZ3Amr9W99PTBrb7bYMwO6tgitxyND2voHYaXghascZvRuxDuxe4v+
         9+viCFeyfKUxDva8ZyngwLRcGcoYhllbCqiq9v6LLs4HdtNRjQZoy4GrCHseMWTuylSf
         GtD+C0hiwgou8O/1vkrGyBU9MYpJyiuvcSMcBUC/GFySLTsm9b99hNSXcg2DXTY1lIea
         mBV1iFERJwgGz5jadSjlx1/V6MpARWU0ZUAM78bRN87HjDU7wCUFOAxeIk27ystzjZ9n
         +vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692325; x=1728297125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbIeQCIQG29ruA9aOyFEUr782VHdH/golS3SG+SvRT0=;
        b=Oqj+ZoK+eLwnoOFG7Ho+1SnDiKXOSZ3fQVdCIY1JRGwPMnmeKY8kPZGdSQMU96cQDp
         tys/Qc8qb3CtklKTEzKTRgz+pxGVZMwbSkRh5yX682jqj1g6QkirDkjnwAPQuTjAbJm0
         /nPO0AnBZJezRO7H75NMTx4JvmImNPT71UQQcrmWyVfCIXe1nN4JC/Emt8n/OY/0kQBd
         D/Hw9dwelm1kdl+5XPXg+1SnSdAvqnqkdGy/Chi9coSYqwYQyPF18Kgm/SZWTeFBTN7J
         b/ysG2tLwV9K//XNrhyOA4XN1+yQa7YEykX7AC+Et9iy8iVtwE89O8/3+B8X9tiOM0wv
         Gaug==
X-Forwarded-Encrypted: i=1; AJvYcCWDuNHnH8R3zVzNB5dlBChqwq/URhEMbgAsq8iHWAfUY3qVcO6U7XJJbgiWghrvd65ZnCkrfzdHV8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrq2ghACn9Xrt2cJRgyp8b7ovn6afhfoJloBXX73PzXxh10Ek
	jmU3M0O+eP850qyISq8T47uxwWealYlEPM00CggEj9ykROXyi8DPV6nLThnLioo=
X-Google-Smtp-Source: AGHT+IH5plmZC25ms6hNKllqBa1tbp+dUWi0ti5d9oJ+0pVrJAYkka/MkWfWzSt5AttzcdV9kme8/w==
X-Received: by 2002:a5d:5273:0:b0:37c:d027:d92f with SMTP id ffacd0b85a97d-37cd5a80dd7mr6986395f8f.15.1727692324965;
        Mon, 30 Sep 2024 03:32:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5745696sm8633491f8f.106.2024.09.30.03.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:32:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] gpio: syscon: use generic device properties
Date: Mon, 30 Sep 2024 12:31:56 +0200
Message-ID: <20240930103157.49259-2-brgl@bgdev.pl>
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

OF-specific routines should not be used unless necessary. Generic device
properties are preferred so switch to using them in the driver code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-syscon.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 638095d5f459..06c07085feb8 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -9,7 +9,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -208,12 +207,13 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	int ret;
 	bool use_parent_regmap = false;
+	unsigned int props[] = { 0, 0 };
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->data = of_device_get_match_data(dev);
+	priv->data = device_get_match_data(dev);
 
 	priv->syscon = syscon_regmap_lookup_by_phandle(np, "gpio,syscon-dev");
 	if (IS_ERR(priv->syscon) && np->parent) {
@@ -224,19 +224,15 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->syscon);
 
 	if (!use_parent_regmap) {
-		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1,
-						 &priv->dreg_offset);
-		if (ret)
+		ret = device_property_read_u32_array(dev, "gpio,syscon-dev",
+						     props, 2);
+		if (ret < 0)
 			dev_err(dev, "can't read the data register offset!\n");
-
-		priv->dreg_offset <<= 3;
-
-		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 2,
-						 &priv->dir_reg_offset);
-		if (ret)
+		if (ret != 2)
 			dev_dbg(dev, "can't read the dir register offset!\n");
 
-		priv->dir_reg_offset <<= 3;
+		priv->dreg_offset = props[0] << 3;
+		priv->dir_reg_offset = props[1] << 3;
 	}
 
 	priv->chip.parent = dev;
-- 
2.43.0


