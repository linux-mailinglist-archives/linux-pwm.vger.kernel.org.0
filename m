Return-Path: <linux-pwm+bounces-3243-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D29783D4
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C062281C10
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703613342F;
	Fri, 13 Sep 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkEen/ds"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59312D758;
	Fri, 13 Sep 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240121; cv=none; b=ZT2panYD6nS/PC3UTeFRdJ4x69tjCZAuPh5vyeuHOEXGsmUPS9CilulscJo/QorFoiuR0NixmTMBFEOQ00XFMCQwrQn1Rxo/Juj0Elh2kI4emOJK/O+F+OZnniGOLILvAlgiXMNUPSBrd9Mj6KXFOoJIsgRtfqo+On9JyoxbfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240121; c=relaxed/simple;
	bh=JLT3fRS+yl6/Mb+tf79ZnYVcgNkISumMGZ+lQQFDBZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDuWwi7OGpSokKRnKatuf8pR/s22QYGR52rR4PppBsa6EXGqZtA6hVQ9vOE15FRdlibWWHN2x1MhfytDK1+LXpafvAmIPjrGboLMQllcTJWJbfPwdu0rnbZVVG+PmlPxU5y1Bh+Jn8IncIT/YwO29z56dQGMYyXS/b3pvhvXA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkEen/ds; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so2923898a12.2;
        Fri, 13 Sep 2024 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240118; x=1726844918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGV3WmFsQ+1pAhEILcS0ZUWipFofO4AxkBOKtNoxFJE=;
        b=hkEen/dsdSlXIUSEW9aK49FNJA9he8X1jKv41PJ2s/KKftianzh6/IZS8X1GgneILN
         51ArwE8gBIGASN1rL3CV8XG8s4zIrh99h+8c/7UbsSQRyz6hlOI6dIYUoK2MZLZ204LC
         6KP42zUIa/ctBLLj38mEqKhFfaQOs/xHNmc9aDSEWjvlKhf6RKRPN5csobHGwoJmfC78
         KEaXdA9DVkyFmi4OmUfks1j3c01sICHgjBPC1kxfQtdCn5zuYCqW1ARe8Q0n0PpR+K+C
         hdmx85gIk2qkWsXMk0oXFnTtksfw33RosFuTORdJEhiVxxBcZ+27gS3q7w++NDinKL/g
         w/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240118; x=1726844918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGV3WmFsQ+1pAhEILcS0ZUWipFofO4AxkBOKtNoxFJE=;
        b=vqK9TmOZybCJ9nQftx1FagdYwwQp2cU5T/70AnczGo4n/J+p1oyjox0WSRkfPNnSuX
         +pMjC2U3eoZHAkB/Ex5XLmtlOjmGKtOXqOiRGtOC01N/vyhXCUTSdabY8maOz9YZlhtt
         TjpWGXczWhIGDX/HCqInyRkrGKvR1j1l0SAofPQkClyGKLx/Vj8ah8GNxRuRZo6GJ+ID
         FGYaSX3gzNBChgOa+rJn40tS4K98sUnDXW7jA9jjIkfzUWHvMfmf/eVdrvtpuU5Lv0/n
         i0VDjvYD3od5NqViTHaZCCVelRXSCzIGO3V8PffzinojGrKOHhlm9JP85ZjwiizrWbOn
         6nDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3sDCXySc36MAdGG7bHQkrY8nWnkvqyol55xuHlsTLob8U3seddpBzMfu7rvtd+aLL6GTfh+ChcmLl/FevdcQyEmQ=@vger.kernel.org, AJvYcCUTiVZSyIJEbOXCRhhtksHwvblHGVLoicVkBJEv5SAPWfvDVdsLykE/8dy3sHXuaeaDp2ZjY+00glmQYw==@vger.kernel.org, AJvYcCVBXsHWm6ITvTlXbStlQ4x9YPyvoNfQVS/8i7rbEWHM+x+ZvYdmLh1ZxxfOYhCjHQlSVFOVnjYx8n/Pesz2@vger.kernel.org, AJvYcCW/EcLo72eiWGT54K7ro9jaSxDsp0G+884dBNaCUPNDYkoWdAuo79qYqLRlebIy53kuSfyuHBZbo1Xme4g=@vger.kernel.org, AJvYcCWNXwgGRw2Utktud9Cz72bIqX0Xpeuhq2YLrd2lhWQbUi7mBBHXdkJM/+9/i1O8BfBJxOSgxQHwR5IPvpqZMQ==@vger.kernel.org, AJvYcCWXV5QvBbkblLC/o5d2xovSYvkoOlRXcSnTD2gQNzahgzoW1/dgWDq9idxnqApR7AFQcngl7Viza9Gq@vger.kernel.org, AJvYcCWZl62T+FRUTk7vYJPmAqoGp49axgt50e4sY++DTz9m1VhJo1pgY+ZmstM+q+cvP3I5my0lq/8DIr30@vger.kernel.org, AJvYcCXrd3F2O/oUNulJpla51pdilMX/OWjoiT9v3j8DtL6BMZaN/3QYcgDsBeVhGjFuhXTdKVR8tqTBr3RV@vger.kernel.org
X-Gm-Message-State: AOJu0YycGEcjvNW51PTD3R2cFkfd893/Qhs4/kZAq7kgzbS2PHKlOlVf
	JjwKTxlncVVbVEhbgUhsNW/Gsyyjlh43SeAMsGpdDYZxsVoTQDuujNRxMA==
X-Google-Smtp-Source: AGHT+IHmet3oVeZAIyzfyGhQipzCR5J7qgVMqR0U3qlYsOGLKQIFYN4djfEUjPbQ4Oc1wrwDnPBcKg==
X-Received: by 2002:a50:cc07:0:b0:5bf:2577:32b8 with SMTP id 4fb4d7f45d1cf-5c413e10d16mr4591778a12.9.1726240118059;
        Fri, 13 Sep 2024 08:08:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:36 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:53 +0300
Subject: [PATCH v4 10/27] input: max77693: add max77705 haptic support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-10-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=4227;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=JLT3fRS+yl6/Mb+tf79ZnYVcgNkISumMGZ+lQQFDBZo=;
 b=QWXeiajPIVlTrdpZ46bVxljmi2LWiwS0GqKpCG23HcYVw+Bp9aq3S2iNDvOVLBwdKDhO61jha
 OvHVW13g2C0BqFw1fsSf6jd+d1jSYQFH6MfjPlYVXo0cT3tjjJXeRfN
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add support for haptic controller on MAX77705 Multifunction
device.

This driver supports external pwm and LRA (Linear Resonant Actuator) motor.
User can control the haptic device via force feedback framework.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v4:
- add max77705 haptic support to max77693 driver
- delete max77705-haptic
---
 drivers/input/misc/Kconfig           |  4 ++--
 drivers/input/misc/Makefile          |  1 +
 drivers/input/misc/max77693-haptic.c | 15 ++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6a852c76331b..b4515c4e5cf6 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -241,11 +241,11 @@ config INPUT_MAX77650_ONKEY
 
 config INPUT_MAX77693_HAPTIC
 	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
-	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
+	depends on (MFD_MAX77693 || MFD_MAX77705 || MFD_MAX77843) && PWM
 	select INPUT_FF_MEMLESS
 	help
 	  This option enables support for the haptic controller on
-	  MAXIM MAX77693 and MAX77843 chips.
+	  MAXIM MAX77693, MAX77705 and MAX77843 chips.
 
 	  To compile this driver as module, choose M here: the
 	  module will be called max77693-haptic.
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 4f7f736831ba..3e3532b27990 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
 obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
 obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
 obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
+obj-$(CONFIG_INPUT_MAX77705_HAPTIC)	+= max77705-haptic.o
 obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
 obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
 obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+= mc13783-pwrbutton.o
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 0e646f1b257b..c3b9d33608d7 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -23,6 +23,7 @@
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/mfd/max77705-private.h>
 #include <linux/mfd/max77843-private.h>
 
 #define MAX_MAGNITUDE_SHIFT	16
@@ -115,6 +116,13 @@ static int max77693_haptic_configure(struct max77693_haptic *haptic,
 			MAX77693_HAPTIC_PWM_DIVISOR_128);
 		config_reg = MAX77693_HAPTIC_REG_CONFIG2;
 		break;
+	case TYPE_MAX77705:
+		value = ((haptic->type << MAX77693_CONFIG2_MODE) |
+			(enable << MAX77693_CONFIG2_MEN) |
+			(haptic->mode << MAX77693_CONFIG2_HTYP) |
+			MAX77693_HAPTIC_PWM_DIVISOR_128);
+		config_reg = MAX77705_PMIC_REG_MCONFIG;
+		break;
 	case TYPE_MAX77843:
 		value = (haptic->type << MCONFIG_MODE_SHIFT) |
 			(enable << MCONFIG_MEN_SHIFT) |
@@ -312,6 +320,9 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 	case TYPE_MAX77693:
 		haptic->regmap_haptic = max77693->regmap_haptic;
 		break;
+	case TYPE_MAX77705:
+		haptic->regmap_haptic = max77693->regmap;
+		break;
 	case TYPE_MAX77843:
 		haptic->regmap_haptic = max77693->regmap;
 		break;
@@ -407,6 +418,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
 
 static const struct platform_device_id max77693_haptic_id[] = {
 	{ "max77693-haptic", },
+	{ "max77705-haptic", },
 	{ "max77843-haptic", },
 	{},
 };
@@ -414,6 +426,7 @@ MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
 
 static const struct of_device_id of_max77693_haptic_dt_match[] = {
 	{ .compatible = "maxim,max77693-haptic", },
+	{ .compatible = "maxim,max77705-haptic", },
 	{ .compatible = "maxim,max77843-haptic", },
 	{ /* sentinel */ },
 };
@@ -432,5 +445,5 @@ module_platform_driver(max77693_haptic_driver);
 
 MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
 MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
-MODULE_DESCRIPTION("MAXIM 77693/77843 Haptic driver");
+MODULE_DESCRIPTION("MAXIM 77693/77705/77843 Haptic driver");
 MODULE_LICENSE("GPL");

-- 
2.39.2


