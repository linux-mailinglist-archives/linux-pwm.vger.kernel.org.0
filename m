Return-Path: <linux-pwm+bounces-5848-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B0AAF559
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 10:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834C41BA2B92
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53319226D12;
	Thu,  8 May 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qEAwg5pZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1A2248A6
	for <linux-pwm@vger.kernel.org>; Thu,  8 May 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692242; cv=none; b=ascibhfuyJ8NEz8QhACiSFyACRnhFS7UFvZLKvcM5+5FhxCaXhO+ijS/haJWaz8bxpt1wlxNTNIBGgPJnK1qC/DZpqLyZU6kA/aKojtIHRk5/uasJS2ri+donNJZgdiQ0whNX8y4r5NmUBOHcPMjBs8FlN7nfzOHMOIwV3xZIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692242; c=relaxed/simple;
	bh=KAWEODHpTCGvnTXz0C/w1WYdVoFkyZuCAlWfpLoOjVU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2QZy0cUQC/c/ufPwkz/5p6fwFt7OTSEpJ/0fcazAoMsAMNSKZsI0YzJMWlZFpXrLdIO36RObf/E7ZtGllnScfxN+jzcIbGbNm2aJlOl2j5667Pef+Zvx6ryT12ZaheHMdqHDtQ2MHWl15S/3YcisC8vrPBPUOjf3pKfM9g+4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qEAwg5pZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2c663a3daso134804666b.2
        for <linux-pwm@vger.kernel.org>; Thu, 08 May 2025 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746692236; x=1747297036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9ZYSEMrdChhXbBExAwLopdPwiSOtp6k4lPhXpahPhw=;
        b=qEAwg5pZalAscxR51ty1btKMlbLSaEd14kfUESOsv7PahCY/GIYWk1X065U+FW6Rt7
         21bPpA71hwFiY9cL7BUQQlZtk2m3BJ42xeBbNTAut6EbkERxM0ihTBGL8deOPF/jrGUc
         0gxe2F+5vXtCE7lkGP7cE1nQykVLmqElS2V2KsxOGLPmpG0kS2qV1oqMXM0t5XSi/nHE
         Mu0YrMPJcl6t5T8/SoxbcZPW45vaXJoCodbSKgPa6Nmb6z2VQ665D4fiaR8zihicDyrF
         vJTV19EAJpvXqg6SRc9JtCd96paw1Dy0yCkRWu45LPZf+/ojuKBvJCEwyichJUnO3PVH
         aCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692236; x=1747297036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9ZYSEMrdChhXbBExAwLopdPwiSOtp6k4lPhXpahPhw=;
        b=SRaac3GGD11xI2ZkeS8f0bwyK34FdvmSrYywIcZK+k5g5rRmmCypaOFcwSXq8HhXIB
         0v6R6KhPloBLEujtfePaNFSUBMVQYMotXLUNokEmeEDOvEBAjlZi+xGCiS0FERu/9rfg
         6Rp+ydqD0BOL2CHTrrljcMQfm/q5w+AA1KQETZYvub7AJJCWMUT8fkfe/zL8U2aJq5Fz
         Q8qDNEimFfFpwC0atYbOJAUoe1fNvC5ov9BS1f5g7jQH9K1aWV68tiCyXFsaEOgzvxLi
         1tXHU0yTZKj86IuGi0raiTf4cK4xYOmVKHnvRze+YVTnNg7hJmb/9tluOVlWjJAVps6/
         bRMg==
X-Gm-Message-State: AOJu0Yzv+WiPRcbv1jLppKaM3OrunP/ukBlw4CYlXZsMRAo2GoIr6dcA
	ggq4RnIP0fvMRd/ZwNq6i92L/7GeKlz/4uS7AHogleXK5hERS0ioBttrAhLBo6OgFDMfZfU5zNa
	3
X-Gm-Gg: ASbGnctpJr0JRbwg3UXmkuQC5DL06ASEWsHGepj+zCO6TGKMTu7IQeCxJazgvcmo1NH
	gIl2fBqOHkZQCgnlw/BfgRE/yymx3fxWrZJEuICymZNbrYP+i4GLSFAgm6O+lhq6IM/O3etuvjB
	gqo8HVq2JD+BLCbdO9/Ro0Px2KwShEkipdYyb4dYDG3ggaeP4DBzgkeyeAGgmV/X/vXi6fXboF4
	C0Qo7ITcVWOSrU4Nk6Cneav6AZAWld8R/T5SAqUGiQD6ohs5iEs3VfxaoAr/1XL1aFQBK7rzZcQ
	plLPQK2zVRzzGYOMnrP/zMCwejswNRCvKuhVqVxXdh/2HCy8hCnYj6ckD7wmkjgphtR2sA1fsAs
	A942JQBc=
X-Google-Smtp-Source: AGHT+IEbFHxIUTCunp3J28ttymdjnfS+pk25WoraQdhlFDiCCSOwCcbQMf3hd1+e4N05aHbAQn6LvA==
X-Received: by 2002:a17:906:6a1a:b0:ace:d7af:15e1 with SMTP id a640c23a62f3a-ad1e8bf11d7mr606918966b.28.1746692236302;
        Thu, 08 May 2025 01:17:16 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad1895094basm1048749966b.145.2025.05.08.01.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:17:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Restore alphabetic ordering in Kconfig and Makefile
Date: Thu,  8 May 2025 10:17:06 +0200
Message-ID: <20250508081706.751209-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5215; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=KAWEODHpTCGvnTXz0C/w1WYdVoFkyZuCAlWfpLoOjVU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoHGiDEEGFy7feg6zRD/lCgPM0Ji0RjWU8Bd4i6 KGd4r2RmIKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBxogwAKCRCPgPtYfRL+ TnGYB/9RKeU9LLrgoBIDpNfMRSgeLGiLzRlgmgflRO1TyKaA8r/Xl0yM7cY4WvplUgQtAPBAVr1 bAcQDKv6yHTwnnNhq/5ZzA+H6Be0DhkgO2aRFfXIR15yP7SfazOwjcwxIGFfAoD3SjqRNFkR745 9L6Ep5E2+USir2eILTZawurZVmWoB+DiotNvk9ST11KgNgNdc4olnrwjsPxdpItewbnCZlYyWfm 4ySzLHifIzvoSo+IEZNFpmQS7taWLX6NXkgVOskueuJoC4FBEo0uy8K4X3LniNRzB7mBfqv8yT3 gqjHAzvtynfvlmTA0N4pnC8uzWMnkhbP6bSk0fscjZNVyZyJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The drivers are nearly ordered alphabetically by the symbol name. Fix the
few outliers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

triggered by
https://lore.kernel.org/linux-pwm/874ixv3nqz.wl-kuninori.morimoto.gx@renesas.com/
I found a few symbols that are not in their proper order. Fixed here.

In the expectation that there are no relevant concerns and to simplify
the followup for the above patch, I'll apply this patch immediately to
my for-next branch.

Best regards
Uwe

 drivers/pwm/Kconfig  | 60 ++++++++++++++++++++++----------------------
 drivers/pwm/Makefile |  4 +--
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6faa8b2ec0a4..c866ed388da9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -114,6 +114,16 @@ config PWM_AXI_PWMGEN
 	  To compile this driver as a module, choose M here: the module will be
 	  called pwm-axi-pwmgen.
 
+config PWM_BCM2835
+	tristate "BCM2835 PWM support"
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  PWM framework driver for BCM2835 controller (Raspberry Pi)
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-bcm2835.
+
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
@@ -137,16 +147,6 @@ config PWM_BCM_KONA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-bcm-kona.
 
-config PWM_BCM2835
-	tristate "BCM2835 PWM support"
-	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  PWM framework driver for BCM2835 controller (Raspberry Pi)
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-bcm2835.
-
 config PWM_BERLIN
 	tristate "Marvell Berlin PWM support"
 	depends on ARCH_BERLIN || COMPILE_TEST
@@ -435,6 +435,16 @@ config PWM_MC33XS2410
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mc33xs2410.
 
+config PWM_MEDIATEK
+	tristate "MediaTek PWM support"
+	depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Generic PWM framework driver for Mediatek ARM SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-mediatek.
+
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
 	depends on ARCH_MESON || COMPILE_TEST
@@ -445,6 +455,16 @@ config PWM_MESON
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-meson.
 
+config PWM_MICROCHIP_CORE
+	tristate "Microchip corePWM PWM support"
+	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	help
+	  PWM driver for Microchip FPGA soft IP core.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-microchip-core.
+
 config PWM_MTK_DISP
 	tristate "MediaTek display PWM driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
@@ -456,26 +476,6 @@ config PWM_MTK_DISP
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mtk-disp.
 
-config PWM_MEDIATEK
-	tristate "MediaTek PWM support"
-	depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Generic PWM framework driver for Mediatek ARM SoC.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-mediatek.
-
-config PWM_MICROCHIP_CORE
-	tristate "Microchip corePWM PWM support"
-	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
-	depends on HAS_IOMEM && OF
-	help
-	  PWM driver for Microchip FPGA soft IP core.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-microchip-core.
-
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9742fc196f07..5c782af8f49b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -7,9 +7,9 @@ obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
 obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
+obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
-obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
 obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
 obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
@@ -38,8 +38,8 @@ obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
-obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
+obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o

base-commit: d041b76ac9fb9e60e7cdb0265ed9d8b6058a88bf
-- 
2.47.2


