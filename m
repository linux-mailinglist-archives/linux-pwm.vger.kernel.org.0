Return-Path: <linux-pwm+bounces-3154-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A800C970FE5
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615162813D7
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214E1B0108;
	Mon,  9 Sep 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f35d3/xG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95621AF4EF
	for <linux-pwm@vger.kernel.org>; Mon,  9 Sep 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867098; cv=none; b=dnDk02raUlTQClhzOLMVlEddWF/xrxjF7W1dhhebolr51TjqFVOSKSTVjJGYanh4ylgI7VNLG4UkFO7FfR7joiGLM0sa9yxMSGVLapyBmoLaPLeIYAo6iDKwrMwmfepkefGG6CGzoIxGoQ8zxE4yVxsZlmbLIqWmmgHTX6McLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867098; c=relaxed/simple;
	bh=gQiHO3f1Zn1rXB9zUJbXdejwW615HN9Fc/TavEGaxCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RsqDGSRCIfVF3BfUgjrjRbvjU9sri/faP2lcxIf6Tv1TansOesI/L4z1BhumCy4JKUoonZEvfmGfOZZyNuPxgWeY4HifmJk39bzkmIHvqFZOAZj7RW/41ah6n+fXsmGd+4Pcbaz4V8lkwYIHW9yaNvfI7OV8bcoAKwQtsTOB/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f35d3/xG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c6187b6eso2405255f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 09 Sep 2024 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725867093; x=1726471893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=algUI0QLeOROhTSxgwM/XgwQRVsCRfSMXvqmelJBycM=;
        b=f35d3/xGzyJqmAOYurO3cN1+fvAz282fHnhoK1Tl25uSaeil+q3OW1QwlQlZfmfr6Q
         6xUQycKFetHC8CX6jcEIj8V5Yk0nB8/Srl3oSqd7G7Ua/blOdtCyJbJvm54YwFUi7Uby
         OlxlCOHwkVkpGTGFpfjP54qRWkBmlSVYKXajLX70WeEpElV+7HMkf4FPgkPbJuQY5bnt
         VWFW+I5z+mfNZbwWMGCkoa3iKyx33LZ1WCXguyZK7TXwyqw8olp8ufYGb8lSSK8M09oS
         mYm627PN6Yl9E1YQji9jjnWLvhoFidIGQE+WfIe0FJx94S9XwxnY8JESDIcYb5E51GAH
         hTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725867093; x=1726471893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=algUI0QLeOROhTSxgwM/XgwQRVsCRfSMXvqmelJBycM=;
        b=jepzwyzz7W3X+PDw3kY98KRQbihWloIgkMkQiM+CLJuLZdRqUapTRaDeD2GycQm0M+
         O9WzETS4HIKU7iqEpCK9t8bXiQp49xGw7hS8h0KIKY7hHutgME+rL0HxWdbX7VeZhr9b
         qCXttVEDEPUI+Tqxv37rMycHZd3Sb8EVPCJ0OINRBAP9gDAKcNW7lG0IkCn6lCueJjHO
         r0QV/zWdEE4prlIuz6mhKRZZ+WlgCsGLbXsYAAv8/PNF0QU9wUi/0NEvJKQLiz4Z8wrY
         RU3kLTGbi4GNHzbnEkd67uJmpvAe+piQQx4QLQQDwjyryAfqaDObqN9w3jKSornrNuow
         QzvA==
X-Gm-Message-State: AOJu0YysrcR/ptLZrJ9gV/zessHjgzwgVgWLwRW/jZWLDON+g1Cy33Fv
	SRwqJR0v2URr8sG3L0/FCF8H8o3iD2qx1x6/es7EJmfIK9DfF+alndD1ivUvVjt4KVchtwr6Xaj
	U
X-Google-Smtp-Source: AGHT+IHgaZuUQkXgiW70YsGx6pFN2Q8UnleEfPWXf2SEjd85hOos1vXa+FbgCunpBcCwXced94bUxg==
X-Received: by 2002:adf:eb92:0:b0:374:c42f:bac1 with SMTP id ffacd0b85a97d-378895c28camr5533266f8f.8.1725867092934;
        Mon, 09 Sep 2024 00:31:32 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895649728sm5246202f8f.16.2024.09.09.00.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:31:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: [PATCH] pwm: Switch back to struct platform_driver::remove()
Date: Mon,  9 Sep 2024 09:31:24 +0200
Message-ID: <20240909073125.382040-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7495; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=gQiHO3f1Zn1rXB9zUJbXdejwW615HN9Fc/TavEGaxCk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm3qRNwHXKVLHdqMWmR3m01/w7KD4IOtJZ2S4S3 hYoZ/t4eHWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZt6kTQAKCRCPgPtYfRL+ TgX3B/94GOc20Ud5SybmEO6X7+ZHeMi2EdjC6V3OaNIZmgYLs5uv92kOlCXXcC9uGt1NMRRw4da V6Es5MQoRRjOhngbOvUMFVEPqQUOPvSvvIcyEqHrdSgNR+kLuwABJwItWQUubgbHEmwrxcsApJL d8lyKl1Uii2vUiElWUwSMzuClaIrfebDrtVoTcsoh5czARG2CZvwwU/6AEELqeVd+7lJ4b/8VpJ HG2TIghljnNvmGk3VBo8ozMkuo65Cn4hujYa2+da01e+XHptnq9s6b12VhJpTX0vOKllydeD9ai cr1LrA1aDC32bvCovGyljSCuwyBq6EVpkStdVsvemLEZPQyX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all pwm drivers to use .remove(), with the eventual goal to drop
struct platform_driver::remove_new(). As .remove() and .remove_new() have
the same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c  | 2 +-
 drivers/pwm/pwm-atmel-tcb.c    | 2 +-
 drivers/pwm/pwm-clk.c          | 2 +-
 drivers/pwm/pwm-hibvt.c        | 2 +-
 drivers/pwm/pwm-img.c          | 2 +-
 drivers/pwm/pwm-lpc18xx-sct.c  | 2 +-
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 drivers/pwm/pwm-rcar.c         | 2 +-
 drivers/pwm/pwm-rockchip.c     | 2 +-
 drivers/pwm/pwm-sifive.c       | 2 +-
 drivers/pwm/pwm-sun4i.c        | 2 +-
 drivers/pwm/pwm-tegra.c        | 2 +-
 drivers/pwm/pwm-tiecap.c       | 2 +-
 drivers/pwm/pwm-tiehrpwm.c     | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index eb39955a6d77..387a0d1fa4f2 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -299,7 +299,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
 		.pm = pm_ptr(&atmel_hlcdc_pwm_pm_ops),
 	},
 	.probe = atmel_hlcdc_pwm_probe,
-	.remove_new = atmel_hlcdc_pwm_remove,
+	.remove = atmel_hlcdc_pwm_remove,
 };
 module_platform_driver(atmel_hlcdc_pwm_driver);
 
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index f9a9c12cbcdd..5ee4254d1e48 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -527,7 +527,7 @@ static struct platform_driver atmel_tcb_pwm_driver = {
 		.pm = pm_ptr(&atmel_tcb_pwm_pm_ops),
 	},
 	.probe = atmel_tcb_pwm_probe,
-	.remove_new = atmel_tcb_pwm_remove,
+	.remove = atmel_tcb_pwm_remove,
 };
 module_platform_driver(atmel_tcb_pwm_driver);
 
diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index c19a482d7e28..f8f5af57acba 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -130,7 +130,7 @@ static struct platform_driver pwm_clk_driver = {
 		.of_match_table = pwm_clk_dt_ids,
 	},
 	.probe = pwm_clk_probe,
-	.remove_new = pwm_clk_remove,
+	.remove = pwm_clk_remove,
 };
 module_platform_driver(pwm_clk_driver);
 
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 2eb0b13d4e10..e02ee6383dbc 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -276,7 +276,7 @@ static struct platform_driver hibvt_pwm_driver = {
 		.of_match_table = hibvt_pwm_of_match,
 	},
 	.probe = hibvt_pwm_probe,
-	.remove_new = hibvt_pwm_remove,
+	.remove = hibvt_pwm_remove,
 };
 module_platform_driver(hibvt_pwm_driver);
 
diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index d6596583ed4e..71542956feca 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -416,7 +416,7 @@ static struct platform_driver img_pwm_driver = {
 		.of_match_table = img_pwm_of_match,
 	},
 	.probe = img_pwm_probe,
-	.remove_new = img_pwm_remove,
+	.remove = img_pwm_remove,
 };
 module_platform_driver(img_pwm_driver);
 
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 04b76d257fd8..f351baa63453 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -446,7 +446,7 @@ static struct platform_driver lpc18xx_pwm_driver = {
 		.of_match_table = lpc18xx_pwm_of_match,
 	},
 	.probe = lpc18xx_pwm_probe,
-	.remove_new = lpc18xx_pwm_remove,
+	.remove = lpc18xx_pwm_remove,
 };
 module_platform_driver(lpc18xx_pwm_driver);
 
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index e514f3614c43..1858a77401f8 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -455,7 +455,7 @@ static struct platform_driver pwm_omap_dmtimer_driver = {
 		.of_match_table = pwm_omap_dmtimer_of_match,
 	},
 	.probe = pwm_omap_dmtimer_probe,
-	.remove_new = pwm_omap_dmtimer_remove,
+	.remove = pwm_omap_dmtimer_remove,
 };
 module_platform_driver(pwm_omap_dmtimer_driver);
 
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 4cfecd88ede0..2261789cc27d 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -253,7 +253,7 @@ MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 
 static struct platform_driver rcar_pwm_driver = {
 	.probe = rcar_pwm_probe,
-	.remove_new = rcar_pwm_remove,
+	.remove = rcar_pwm_remove,
 	.driver = {
 		.name = "pwm-rcar",
 		.of_match_table = rcar_pwm_of_table,
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 0fa7575dbb54..c5f50e5eaf41 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -386,7 +386,7 @@ static struct platform_driver rockchip_pwm_driver = {
 		.of_match_table = rockchip_pwm_dt_ids,
 	},
 	.probe = rockchip_pwm_probe,
-	.remove_new = rockchip_pwm_remove,
+	.remove = rockchip_pwm_remove,
 };
 module_platform_driver(rockchip_pwm_driver);
 
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index ed7957cc51fd..d5b647e6be78 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -336,7 +336,7 @@ MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
 
 static struct platform_driver pwm_sifive_driver = {
 	.probe = pwm_sifive_probe,
-	.remove_new = pwm_sifive_remove,
+	.remove = pwm_sifive_remove,
 	.driver = {
 		.name = "pwm-sifive",
 		.of_match_table = pwm_sifive_of_match,
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5c29590d1821..e60dc7d6b591 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -493,7 +493,7 @@ static struct platform_driver sun4i_pwm_driver = {
 		.of_match_table = sun4i_pwm_dt_ids,
 	},
 	.probe = sun4i_pwm_probe,
-	.remove_new = sun4i_pwm_remove,
+	.remove = sun4i_pwm_remove,
 };
 module_platform_driver(sun4i_pwm_driver);
 
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index a3d69976148f..172063b51d44 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -432,7 +432,7 @@ static struct platform_driver tegra_pwm_driver = {
 		.pm = &tegra_pwm_pm_ops,
 	},
 	.probe = tegra_pwm_probe,
-	.remove_new = tegra_pwm_remove,
+	.remove = tegra_pwm_remove,
 };
 
 module_platform_driver(tegra_pwm_driver);
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index d6c2b1b1387e..d91b2bdc88fc 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -324,7 +324,7 @@ static struct platform_driver ecap_pwm_driver = {
 		.pm = pm_ptr(&ecap_pwm_pm_ops),
 	},
 	.probe = ecap_pwm_probe,
-	.remove_new = ecap_pwm_remove,
+	.remove = ecap_pwm_remove,
 };
 module_platform_driver(ecap_pwm_driver);
 
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index e5104725d9b7..0125e73b98df 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -603,7 +603,7 @@ static struct platform_driver ehrpwm_pwm_driver = {
 		.pm = pm_ptr(&ehrpwm_pwm_pm_ops),
 	},
 	.probe = ehrpwm_pwm_probe,
-	.remove_new = ehrpwm_pwm_remove,
+	.remove = ehrpwm_pwm_remove,
 };
 module_platform_driver(ehrpwm_pwm_driver);
 

base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.45.2


