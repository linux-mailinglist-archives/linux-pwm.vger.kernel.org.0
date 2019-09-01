Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99998A4C90
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 00:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfIAW6u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 1 Sep 2019 18:58:50 -0400
Received: from vern.gendns.com ([98.142.107.122]:37384 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfIAW6s (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 1 Sep 2019 18:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ALnzwdMmPbGeDs+owXoQW25HAwK1djSFtCEeC0SHA+c=; b=bhVj+EJrYaFKbbIiPeKce3ZOU
        BDbb3Q3lnFgXAqIlkv64aOs6LyRAd7yaB8Uj2Xb1nuVorJJtEdJe4OPyFqgBMHhZT3ZGWpyIynEd9
        93V/fT9jhFzFKBqNw1wVhhYXXf11evUAjZUtTMr4iwmkJM2+2uptgbowIJ6pr/f+4xThpXlEGI4Y5
        ptruwWHQpQrsl1h1ltEObjPMFnducFnwxc68lx/XKIK9pXP04YFgVRB83vbp0SrUsnXC/YOZEKdib
        ySt0oSiNp9sHZx7E0xwHydWo1TCrlg3yr8nSBdpgfB/DKywtKJ8+sCglrvABknVKeAO9z40rs7E+6
        J9V1e94Pw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58390 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1i4Yo0-000351-T9; Sun, 01 Sep 2019 18:58:45 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v3 1/6] bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
Date:   Sun,  1 Sep 2019 17:58:22 -0500
Message-Id: <20190901225827.12301-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
References: <20190901225827.12301-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The TI PWMSS driver is a simple bus driver for providing power
power management for the PWM peripherals on TI AM33xx SoCs, namely
eCAP, eHRPWM and eQEP. The eQEP is a counter rather than a PWM, so
it does not make sense to have the bus driver in the PWM subsystem
since the PWMSS is not exclusive to PWM devices.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:
- none
v2 changes:
- new patch

 drivers/bus/Kconfig                           | 9 +++++++++
 drivers/bus/Makefile                          | 1 +
 drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} | 0
 drivers/pwm/Kconfig                           | 9 ---------
 drivers/pwm/Makefile                          | 1 -
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..4eeb15839ce0 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -140,6 +140,15 @@ config TEGRA_GMI
 	  Driver for the Tegra Generic Memory Interface bus which can be used
 	  to attach devices such as NOR, UART, FPGA and more.
 
+config  TI_PWMSS
+	bool
+	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
+	help
+	  PWM Subsystem driver support for AM33xx SOC.
+
+	  PWM submodules require PWM config space access from submodule
+	  drivers and require common parent driver support.
+
 config TI_SYSC
 	bool "TI sysc interconnect target module driver"
 	depends on ARCH_OMAP2PLUS
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ca300b1914ce..a2d13cf4a877 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
 obj-$(CONFIG_TEGRA_GMI)		+= tegra-gmi.o
+obj-$(CONFIG_TI_PWMSS)		+= ti-pwmss.o
 obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
 obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
diff --git a/drivers/pwm/pwm-tipwmss.c b/drivers/bus/ti-pwmss.c
similarity index 100%
rename from drivers/pwm/pwm-tipwmss.c
rename to drivers/bus/ti-pwmss.c
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a7e57516959e..300396564769 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -497,15 +497,6 @@ config  PWM_TIEHRPWM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiehrpwm.
 
-config  PWM_TIPWMSS
-	bool
-	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
-	help
-	  PWM Subsystem driver support for AM33xx SOC.
-
-	  PWM submodules require PWM config space access from submodule
-	  drivers and require common parent driver support.
-
 config PWM_TWL
 	tristate "TWL4030/6030 PWM support"
 	depends on TWL4030_CORE
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 76b555b51887..f67eb6e9294d 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
-obj-$(CONFIG_PWM_TIPWMSS)	+= pwm-tipwmss.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
-- 
2.17.1

