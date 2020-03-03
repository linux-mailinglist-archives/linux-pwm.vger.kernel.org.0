Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64201783ED
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Mar 2020 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgCCUY4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Mar 2020 15:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbgCCUY4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Mar 2020 15:24:56 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC54620848;
        Tue,  3 Mar 2020 20:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267095;
        bh=L0GueqxteLGlGoUJ9dBrzniaBgvcDGJ2vJhbzDbsAeM=;
        h=From:To:Cc:Subject:Date:From;
        b=DNy83wdchtQCXa+LIQRCsT/RaIKN1z6kglAxRpPscymNKzoYBTE8Mr9M30T1vDjVO
         gAj+cephD/ztb06fhxYTN2kUiNZs8ZqBZtzHKPG9BI/3edKB7RW8f3YzwPlDGgEV+Z
         V4nvEoo+drNZdoTkmYrV5ooMPKGU74fMfG+4i6Nw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] pwm: Enable compile testing for some of drivers
Date:   Tue,  3 Mar 2020 21:24:47 +0100
Message-Id: <20200303202447.4245-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Some of the PWM drivers can be compile tested to increase build
coverage.

The Meson PWM driver requires COMMON_CLK dependency.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Florian Fainelli <f.fainelli@gmail.com> # For Broadcoam
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # For Meson
Acked-by: Claudiu Beznea <claudiu.beznea@microchip.com> # For Atmel

---

Changes since v1:
1. Split "depends on OF" to separate entry in PWM_ATMEL and PWM_MXS.
---
 drivers/pwm/Kconfig | 47 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 30190beeb6e9..70153bf11201 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -44,7 +44,8 @@ config PWM_AB8500
 
 config PWM_ATMEL
 	tristate "Atmel PWM support"
-	depends on ARCH_AT91 && OF
+	depends on OF
+	depends on ARCH_AT91 || COMPILE_TEST
 	help
 	  Generic PWM framework driver for Atmel SoC.
 
@@ -100,7 +101,7 @@ config PWM_BCM_KONA
 
 config PWM_BCM2835
 	tristate "BCM2835 PWM support"
-	depends on ARCH_BCM2835 || ARCH_BRCMSTB
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
 	help
 	  PWM framework driver for BCM2835 controller (Raspberry Pi)
 
@@ -109,7 +110,7 @@ config PWM_BCM2835
 
 config PWM_BERLIN
 	tristate "Marvell Berlin PWM support"
-	depends on ARCH_BERLIN
+	depends on ARCH_BERLIN || COMPILE_TEST
 	help
 	  PWM framework driver for Marvell Berlin SoCs.
 
@@ -118,7 +119,7 @@ config PWM_BERLIN
 
 config PWM_BRCMSTB
 	tristate "Broadcom STB PWM support"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	help
 	  Generic PWM framework driver for the Broadcom Set-top-Box
 	  SoCs (BCM7xxx).
@@ -152,7 +153,7 @@ config PWM_CROS_EC
 
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
 	help
 	  Generic PWM framework driver for Cirrus Logic EP93xx.
 
@@ -195,7 +196,7 @@ config PWM_IMG
 
 config PWM_IMX1
 	tristate "i.MX1 PWM support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Generic PWM framework driver for i.MX1 and i.MX21
 
@@ -204,7 +205,7 @@ config PWM_IMX1
 
 config PWM_IMX27
 	tristate "i.MX27 PWM support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Generic PWM framework driver for i.MX27 and later i.MX SoCs.
 
@@ -244,7 +245,7 @@ config PWM_LP3943
 
 config PWM_LPC18XX_SCT
 	tristate "LPC18xx/43xx PWM/SCT support"
-	depends on ARCH_LPC18XX
+	depends on ARCH_LPC18XX || COMPILE_TEST
 	help
 	  Generic PWM framework driver for NXP LPC18xx PWM/SCT which
 	  supports 16 channels.
@@ -256,7 +257,7 @@ config PWM_LPC18XX_SCT
 
 config PWM_LPC32XX
 	tristate "LPC32XX PWM support"
-	depends on ARCH_LPC32XX
+	depends on ARCH_LPC32XX || COMPILE_TEST
 	help
 	  Generic PWM framework driver for LPC32XX. The LPC32XX SOC has two
 	  PWM controllers.
@@ -289,7 +290,8 @@ config PWM_LPSS_PLATFORM
 
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
-	depends on ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on COMMON_CLK
 	help
 	  The platform driver for Amlogic Meson PWM controller.
 
@@ -318,7 +320,8 @@ config PWM_MEDIATEK
 
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
-	depends on ARCH_MXS && OF
+	depends on OF
+	depends on ARCH_MXS || COMPILE_TEST
 	select STMP_DEVICE
 	help
 	  Generic PWM framework driver for Freescale MXS.
@@ -357,7 +360,7 @@ config PWM_PUV3
 
 config PWM_PXA
 	tristate "PXA PWM support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  Generic PWM framework driver for PXA.
 
@@ -388,14 +391,14 @@ config PWM_RENESAS_TPU
 
 config PWM_ROCKCHIP
 	tristate "Rockchip PWM support"
-	depends on ARCH_ROCKCHIP
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
-	depends on PLAT_SAMSUNG || ARCH_EXYNOS
+	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Generic PWM framework driver for Samsung.
 
@@ -415,7 +418,7 @@ config PWM_SIFIVE
 
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
-	depends on PLAT_SPEAR
+	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
 	help
 	  Generic PWM framework driver for the PWM controller on ST
@@ -437,7 +440,7 @@ config PWM_SPRD
 
 config PWM_STI
 	tristate "STiH4xx PWM support"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	depends on OF
 	help
 	  Generic PWM framework driver for STiH4xx SoCs.
@@ -447,7 +450,7 @@ config PWM_STI
 
 config PWM_STM32
 	tristate "STMicroelectronics STM32 PWM"
-	depends on MFD_STM32_TIMERS
+	depends on MFD_STM32_TIMERS || COMPILE_TEST
 	help
 	  Generic PWM framework driver for STM32 SoCs.
 
@@ -483,7 +486,7 @@ config PWM_SUN4I
 
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Generic PWM framework driver for the PWFM controller found on NVIDIA
 	  Tegra SoCs.
@@ -493,7 +496,7 @@ config PWM_TEGRA
 
 config PWM_TIECAP
 	tristate "ECAP PWM support"
-	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	help
 	  PWM driver support for the ECAP APWM controller found on TI SOCs
 
@@ -502,7 +505,7 @@ config PWM_TIECAP
 
 config PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
-	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3 || COMPILE_TEST
 	help
 	  PWM driver support for the EHRPWM controller found on TI SOCs
 
@@ -529,7 +532,7 @@ config PWM_TWL_LED
 
 config PWM_VT8500
 	tristate "vt8500 PWM support"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	help
 	  Generic PWM framework driver for vt8500.
 
@@ -538,7 +541,7 @@ config PWM_VT8500
 
 config PWM_ZX
 	tristate "ZTE ZX PWM support"
-	depends on ARCH_ZX
+	depends on ARCH_ZX || COMPILE_TEST
 	help
 	  Generic PWM framework driver for ZTE ZX family SoCs.
 
-- 
2.17.1

