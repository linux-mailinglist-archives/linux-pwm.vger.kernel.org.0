Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028FE1F8434
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2020 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFMQER (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 13 Jun 2020 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFMQER (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 13 Jun 2020 12:04:17 -0400
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Jun 2020 09:04:16 PDT
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8464C03E96F
        for <linux-pwm@vger.kernel.org>; Sat, 13 Jun 2020 09:04:15 -0700 (PDT)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 0ADDF9AC32B; Sat, 13 Jun 2020 17:57:48 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: add a config symbol for legacy drivers
Date:   Sat, 13 Jun 2020 17:57:42 +0200
Message-Id: <20200613155742.31528-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This (slightly) simplifies the core, reduces the size of the pwm_ops
struct, and makes it more obvious for driver authors to not add new drivers
relying on the old set of callbacks.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 drivers/pwm/core.c  |  6 +++++-
 include/linux/pwm.h |  2 ++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cb8d739067d2..70f21b5d3fc7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -33,6 +33,12 @@ config PWM_SYSFS
 	bool
 	default y if SYSFS
 
+config PWM_LEGACY_DRIVERS
+	bool
+	help
+	  This enables the needed infrastructure to support legacy drivers that
+	  still implement .config(), .enable(), .disable() and .set_polarity().
+
 config PWM_DEBUG
 	bool "PWM lowlevel drivers additional checks and debug messages"
 	depends on DEBUG_KERNEL
@@ -45,6 +51,7 @@ config PWM_DEBUG
 config PWM_AB8500
 	tristate "AB8500 PWM support"
 	depends on AB8500_CORE && ARCH_U8500
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Analog Baseband AB8500.
 
@@ -76,6 +83,7 @@ config PWM_ATMEL_HLCDC_PWM
 config PWM_ATMEL_TCB
 	tristate "Atmel TC Block PWM support"
 	depends on ATMEL_TCLIB && OF
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Atmel Timer Counter Block.
 
@@ -101,6 +109,7 @@ config PWM_BCM_KONA
 	tristate "Kona PWM support"
 	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
 	depends on HAVE_CLK && HAS_IOMEM
+	select PWM_LEGACY_DRIVERS
 	default ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
 	help
 	  Generic PWM framework driver for Broadcom Kona PWM block.
@@ -111,6 +120,7 @@ config PWM_BCM_KONA
 config PWM_BCM2835
 	tristate "BCM2835 PWM support"
 	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  PWM framework driver for BCM2835 controller (Raspberry Pi)
 
@@ -120,6 +130,7 @@ config PWM_BCM2835
 config PWM_BERLIN
 	tristate "Marvell Berlin PWM support"
 	depends on ARCH_BERLIN || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  PWM framework driver for Marvell Berlin SoCs.
 
@@ -129,6 +140,7 @@ config PWM_BERLIN
 config PWM_BRCMSTB
 	tristate "Broadcom STB PWM support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for the Broadcom Set-top-Box
 	  SoCs (BCM7xxx).
@@ -140,6 +152,7 @@ config PWM_CLPS711X
 	tristate "CLPS711X PWM support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
 	depends on HAS_IOMEM
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Cirrus Logic CLPS711X.
 
@@ -149,6 +162,7 @@ config PWM_CLPS711X
 config PWM_CRC
 	bool "Intel Crystalcove (CRC) PWM support"
 	depends on X86 && INTEL_SOC_PMIC
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Crystalcove (CRC) PMIC based PWM
 	  control.
@@ -163,6 +177,7 @@ config PWM_CROS_EC
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Cirrus Logic EP93xx.
 
@@ -196,6 +211,7 @@ config PWM_IMG
 	depends on MFD_SYSCON
 	depends on COMMON_CLK
 	depends on MIPS || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Imagination Technologies
 	  PWM block which supports 4 channels.
@@ -206,6 +222,7 @@ config PWM_IMG
 config PWM_IMX1
 	tristate "i.MX1 PWM support"
 	depends on ARCH_MXC || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for i.MX1 and i.MX21
 
@@ -257,6 +274,7 @@ config PWM_JZ4740
 config PWM_LP3943
 	tristate "TI/National Semiconductor LP3943 PWM support"
 	depends on MFD_LP3943
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for LP3943 which supports two PWM
 	  channels.
@@ -267,6 +285,7 @@ config PWM_LP3943
 config PWM_LPC18XX_SCT
 	tristate "LPC18xx/43xx PWM/SCT support"
 	depends on ARCH_LPC18XX || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for NXP LPC18xx PWM/SCT which
 	  supports 16 channels.
@@ -279,6 +298,7 @@ config PWM_LPC18XX_SCT
 config PWM_LPC32XX
 	tristate "LPC32XX PWM support"
 	depends on ARCH_LPC32XX || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for LPC32XX. The LPC32XX SOC has two
 	  PWM controllers.
@@ -323,6 +343,7 @@ config PWM_MTK_DISP
 	tristate "MediaTek display PWM driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_IOMEM
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for MediaTek disp-pwm device.
 	  The PWM is used to control the backlight brightness for display.
@@ -333,6 +354,7 @@ config PWM_MTK_DISP
 config PWM_MEDIATEK
 	tristate "MediaTek PWM support"
 	depends on ARCH_MEDIATEK || RALINK || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Mediatek ARM SoC.
 
@@ -364,6 +386,7 @@ config PWM_PCA9685
 	tristate "NXP PCA9685 PWM driver"
 	depends on I2C
 	select REGMAP_I2C
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for NXP PCA9685 LED controller.
 
@@ -373,6 +396,7 @@ config PWM_PCA9685
 config PWM_PUV3
 	tristate "PKUnity NetBook-0916 PWM support"
 	depends on ARCH_PUV3
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for PKUnity NetBook-0916.
 
@@ -382,6 +406,7 @@ config PWM_PUV3
 config PWM_PXA
 	tristate "PXA PWM support"
 	depends on ARCH_PXA || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for PXA.
 
@@ -403,6 +428,7 @@ config PWM_RENESAS_TPU
 	tristate "Renesas TPU PWM support"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
+	select PWM_LEGACY_DRIVERS
 	help
 	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
 	  in Renesas chips through the PWM API.
@@ -420,6 +446,7 @@ config PWM_ROCKCHIP
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for Samsung.
 
@@ -441,6 +468,7 @@ config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for the PWM controller on ST
 	  SPEAr SoCs.
@@ -463,6 +491,7 @@ config PWM_STI
 	tristate "STiH4xx PWM support"
 	depends on ARCH_STI || COMPILE_TEST
 	depends on OF
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for STiH4xx SoCs.
 
@@ -491,6 +520,7 @@ config PWM_STM32_LP
 config PWM_STMPE
 	bool "STMPE expander PWM export"
 	depends on MFD_STMPE
+	select PWM_LEGACY_DRIVERS
 	help
 	  This enables support for the PWMs found in the STMPE I/O
 	  expanders.
@@ -508,6 +538,7 @@ config PWM_SUN4I
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for the PWFM controller found on NVIDIA
 	  Tegra SoCs.
@@ -518,6 +549,7 @@ config PWM_TEGRA
 config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  PWM driver support for the ECAP APWM controller found on TI SOCs
 
@@ -527,6 +559,7 @@ config PWM_TIECAP
 config PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3 || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  PWM driver support for the EHRPWM controller found on TI SOCs
 
@@ -536,6 +569,7 @@ config PWM_TIEHRPWM
 config PWM_TWL
 	tristate "TWL4030/6030 PWM support"
 	depends on TWL4030_CORE
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for TWL4030/6030.
 
@@ -545,6 +579,7 @@ config PWM_TWL
 config PWM_TWL_LED
 	tristate "TWL4030/6030 PWM support for LED drivers"
 	depends on TWL4030_CORE
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for TWL4030/6030 LED terminals.
 
@@ -554,6 +589,7 @@ config PWM_TWL_LED
 config PWM_VT8500
 	tristate "vt8500 PWM support"
 	depends on ARCH_VT8500 || COMPILE_TEST
+	select PWM_LEGACY_DRIVERS
 	help
 	  Generic PWM framework driver for vt8500.
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 004b2ea9b5fd..488f90484d00 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -240,6 +240,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 
 	const struct pwm_ops *ops = chip->ops;
 
+#ifdef CONFIG_PWM_LEGACY_DRIVERS
 	/* driver supports legacy, non-atomic operation */
 	if (ops->config && ops->enable && ops->disable) {
 		if (IS_ENABLED(CONFIG_PWM_DEBUG))
@@ -248,6 +249,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 
 		return true;
 	}
+#endif
 
 	if (!ops->apply)
 		return false;
@@ -587,7 +589,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	    state->enabled == pwm->state.enabled)
 		return 0;
 
-	if (chip->ops->apply) {
+	if (!IS_ENABLED(CONFIG_PWM_LEGACY_DRIVERS) || chip->ops->apply) {
 		err = chip->ops->apply(chip, pwm, state);
 		if (err)
 			return err;
@@ -601,6 +603,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		 * implementations of .get_state depend on this
 		 */
 		pwm_apply_state_debug(pwm, state);
+#ifdef CONFIG_PWM_LEGACY_DRIVERS
 	} else {
 		/*
 		 * FIXME: restore the initial state in case of error.
@@ -650,6 +653,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 			pwm->state.enabled = state->enabled;
 		}
+#endif
 	}
 
 	return 0;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2635b2a55090..f5970b0a1df9 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -266,6 +266,7 @@ struct pwm_ops {
 			  struct pwm_state *state);
 	struct module *owner;
 
+#ifdef CONFIG_PWM_LEGACY_DRIVERS
 	/* Only used by legacy drivers */
 	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
 		      int duty_ns, int period_ns);
@@ -273,6 +274,7 @@ struct pwm_ops {
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
+#endif
 };
 
 /**
-- 
2.27.0

