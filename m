Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418AC2B7A8F
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 10:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgKRJpW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 04:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKRJpW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:45:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B68C0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 01:45:22 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK1f-0002SO-0T; Wed, 18 Nov 2020 10:45:19 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK1b-0007rC-UG; Wed, 18 Nov 2020 10:45:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] pwm: fix dependencies on HAS_IOMEM
Date:   Wed, 18 Nov 2020 10:45:08 +0100
Message-Id: <20201118094509.365684-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Drivers making use of IO remapping must depend on HAS_IOMEM.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63be5362fd3a..852aa128c30c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -53,8 +53,8 @@ config PWM_AB8500
 
 config PWM_ATMEL
 	tristate "Atmel PWM support"
-	depends on OF
 	depends on ARCH_AT91 || COMPILE_TEST
+	depends on HAS_IOMEM && OF
 	help
 	  Generic PWM framework driver for Atmel SoC.
 
@@ -88,7 +88,7 @@ config PWM_ATMEL_TCB
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
-	depends on COMMON_CLK
+	depends on COMMON_CLK && HAS_IOMEM
 	default ARCH_BCM_IPROC
 	help
 	  Generic PWM framework driver for Broadcom iProc PWM block. This
@@ -111,6 +111,7 @@ config PWM_BCM_KONA
 config PWM_BCM2835
 	tristate "BCM2835 PWM support"
 	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM framework driver for BCM2835 controller (Raspberry Pi)
 
@@ -120,6 +121,7 @@ config PWM_BCM2835
 config PWM_BERLIN
 	tristate "Marvell Berlin PWM support"
 	depends on ARCH_BERLIN || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM framework driver for Marvell Berlin SoCs.
 
@@ -129,6 +131,7 @@ config PWM_BERLIN
 config PWM_BRCMSTB
 	tristate "Broadcom STB PWM support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for the Broadcom Set-top-Box
 	  SoCs (BCM7xxx).
@@ -163,6 +166,7 @@ config PWM_CROS_EC
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for Cirrus Logic EP93xx.
 
@@ -184,6 +188,7 @@ config PWM_FSL_FTM
 config PWM_HIBVT
 	tristate "HiSilicon BVT PWM support"
 	depends on ARCH_HISI || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for HiSilicon BVT SoCs.
 
@@ -206,6 +211,7 @@ config PWM_IMG
 config PWM_IMX1
 	tristate "i.MX1 PWM support"
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for i.MX1 and i.MX21
 
@@ -215,6 +221,7 @@ config PWM_IMX1
 config PWM_IMX27
 	tristate "i.MX27 PWM support"
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for i.MX27 and later i.MX SoCs.
 
@@ -267,6 +274,7 @@ config PWM_LP3943
 config PWM_LPC18XX_SCT
 	tristate "LPC18xx/43xx PWM/SCT support"
 	depends on ARCH_LPC18XX || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for NXP LPC18xx PWM/SCT which
 	  supports 16 channels.
@@ -279,6 +287,7 @@ config PWM_LPC18XX_SCT
 config PWM_LPC32XX
 	tristate "LPC32XX PWM support"
 	depends on ARCH_LPC32XX || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for LPC32XX. The LPC32XX SOC has two
 	  PWM controllers.
@@ -287,11 +296,13 @@ config PWM_LPC32XX
 	  will be called pwm-lpc32xx.
 
 config PWM_LPSS
+	depends on HAS_IOMEM
 	tristate
 
 config PWM_LPSS_PCI
 	tristate "Intel LPSS PWM PCI driver"
 	depends on X86 && PCI
+	depends on HAS_IOMEM
 	select PWM_LPSS
 	help
 	  The PCI driver for Intel Low Power Subsystem PWM controller.
@@ -302,6 +313,7 @@ config PWM_LPSS_PCI
 config PWM_LPSS_PLATFORM
 	tristate "Intel LPSS PWM platform driver"
 	depends on X86 && ACPI
+	depends on HAS_IOMEM
 	select PWM_LPSS
 	help
 	  The platform driver for Intel Low Power Subsystem PWM controller.
@@ -312,7 +324,7 @@ config PWM_LPSS_PLATFORM
 config PWM_MESON
 	tristate "Amlogic Meson PWM driver"
 	depends on ARCH_MESON || COMPILE_TEST
-	depends on COMMON_CLK
+	depends on COMMON_CLK && HAS_IOMEM
 	help
 	  The platform driver for Amlogic Meson PWM controller.
 
@@ -333,6 +345,7 @@ config PWM_MTK_DISP
 config PWM_MEDIATEK
 	tristate "MediaTek PWM support"
 	depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for Mediatek ARM SoC.
 
@@ -341,8 +354,8 @@ config PWM_MEDIATEK
 
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
-	depends on OF
 	depends on ARCH_MXS || COMPILE_TEST
+	depends on HAS_IOMEM && OF
 	select STMP_DEVICE
 	help
 	  Generic PWM framework driver for Freescale MXS.
@@ -373,6 +386,7 @@ config PWM_PCA9685
 config PWM_PXA
 	tristate "PXA PWM support"
 	depends on ARCH_PXA || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for PXA.
 
@@ -404,6 +418,7 @@ config PWM_RENESAS_TPU
 config PWM_ROCKCHIP
 	tristate "Rockchip PWM support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
@@ -411,6 +426,7 @@ config PWM_ROCKCHIP
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for Samsung.
 
@@ -420,7 +436,7 @@ config PWM_SAMSUNG
 config PWM_SIFIVE
 	tristate "SiFive PWM support"
 	depends on OF
-	depends on COMMON_CLK
+	depends on COMMON_CLK && HAS_IOMEM
 	depends on RISCV || COMPILE_TEST
 	help
 	  Generic PWM framework driver for SiFive SoCs.
@@ -441,7 +457,7 @@ config PWM_SL28CPLD
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR || COMPILE_TEST
-	depends on OF
+	depends on HAS_IOMEM && OF
 	help
 	  Generic PWM framework driver for the PWM controller on ST
 	  SPEAr SoCs.
@@ -463,7 +479,7 @@ config PWM_SPRD
 config PWM_STI
 	tristate "STiH4xx PWM support"
 	depends on ARCH_STI || COMPILE_TEST
-	depends on OF
+	depends on HAS_IOMEM && OF
 	help
 	  Generic PWM framework driver for STiH4xx SoCs.
 
@@ -509,6 +525,7 @@ config PWM_SUN4I
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for the PWFM controller found on NVIDIA
 	  Tegra SoCs.
@@ -519,6 +536,7 @@ config PWM_TEGRA
 config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM driver support for the ECAP APWM controller found on TI SOCs
 
@@ -528,6 +546,7 @@ config PWM_TIECAP
 config PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM driver support for the EHRPWM controller found on TI SOCs
 
@@ -555,6 +574,7 @@ config PWM_TWL_LED
 config PWM_VT8500
 	tristate "vt8500 PWM support"
 	depends on ARCH_VT8500 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for vt8500.
 
@@ -564,6 +584,7 @@ config PWM_VT8500
 config PWM_ZX
 	tristate "ZTE ZX PWM support"
 	depends on ARCH_ZX || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for ZTE ZX family SoCs.
 

base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.28.0

