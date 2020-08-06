Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6223E115
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 20:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgHFSkX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 14:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgHFSkW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 Aug 2020 14:40:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4C522D70;
        Thu,  6 Aug 2020 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738173;
        bh=e1oSXjKRZ1/t6yaGmxeMpFJIIqxQuITtDtfD3fTgYtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnJk8Nw20oovJGOtix16awmixT2stIdDZnn5cCpdsfoPL1ZDrAouFmfTXazZkBryt
         U6+/C4sQrMYB7/RhwqVpMgQSY+Lnf776wVev3iQBKSSjccZfpKA0QCfvg58nAuJV/9
         XLhS2JgfS/EMeK/1j1FFEu/fmUc6n1ay5mUcjoIg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 18/41] ARM: s5pv210: don't imply CONFIG_PLAT_SAMSUNG
Date:   Thu,  6 Aug 2020 20:20:35 +0200
Message-Id: <20200806182059.2431-18-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The plat-samsung directory and mach-s5pv210 can be build
completely independently, so split the two Kconfig symbols
CONFIG_PLAT_SAMSUNG and CONFIG_ARCH_S5PV210.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/Kconfig.debug        | 6 +++---
 arch/arm/Makefile             | 1 -
 arch/arm/plat-samsung/Kconfig | 2 +-
 drivers/mmc/host/Kconfig      | 2 +-
 drivers/pwm/Kconfig           | 2 +-
 drivers/spi/Kconfig           | 2 +-
 drivers/tty/serial/Kconfig    | 2 +-
 sound/soc/samsung/Kconfig     | 2 +-
 8 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 153a9a35dd20..b4b41f9d246b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1005,7 +1005,7 @@ choice
 		  via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
 
 	config DEBUG_S3C_UART0
-		depends on PLAT_SAMSUNG || ARCH_EXYNOS
+		depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1017,7 +1017,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART1
-		depends on PLAT_SAMSUNG || ARCH_EXYNOS
+		depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1029,7 +1029,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART2
-		depends on PLAT_SAMSUNG || ARCH_EXYNOS
+		depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 826613a20b7d..3997cec8848e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -234,7 +234,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 # by CONFIG_* macro name.
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
-plat-$(CONFIG_ARCH_S5PV210)	+= samsung
 plat-$(CONFIG_PLAT_ORION)	+= orion
 plat-$(CONFIG_PLAT_PXA)		+= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	+= samsung
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index a7cb0db1d5cc..13b39684b582 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -4,7 +4,7 @@
 
 config PLAT_SAMSUNG
 	bool
-	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
+	depends on PLAT_S3C24XX || ARCH_S3C64XX
 	default y
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index ddce8e62280c..9f387daa764a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -289,7 +289,7 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_EXYNOS)
+	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS)
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d33..9448e4ca8c73 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -410,7 +410,7 @@ config PWM_ROCKCHIP
 
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
-	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Generic PWM framework driver for Samsung.
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c3008e423f59..85619ab64156 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -680,7 +680,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST)
+	depends on (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST)
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8a0352eb337c..10de494e808a 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -235,7 +235,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 1431be4ed054..a2221ebb1b6a 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
-- 
2.17.1

