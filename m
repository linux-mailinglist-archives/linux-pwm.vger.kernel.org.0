Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0F21289B
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jul 2020 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGBPwP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jul 2020 11:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgGBPwN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Jul 2020 11:52:13 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 292AB2088E;
        Thu,  2 Jul 2020 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593705132;
        bh=XxcW+NWiv7SU31fHemT75WK2/DVTRFtSDqu+NpOM4Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIiks6/Np10095Ewg0GOa4Q8d8nU3iuoEqGwNHi2hehZbXPYpvMGXae7rc6i2BohP
         TTz7w6fPY0tb/JMbjKkiUoPH3vtnOzWukbG3tBNo+PiFQVZ/2KDliMZygwuR7XeFtb
         Jkjvq9xiRGvFUALDwlz+BRoacSwA/Ddqc7XdK1DE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 5/8] ARM: dts: exynos: Remove DMA controller bus node name to fix dtschema warnings
Date:   Thu,  2 Jul 2020 17:51:46 +0200
Message-Id: <20200702155149.12854-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There is no need to keep DMA controller nodes under AMBA bus node.
Remove the "amba" node to fix dtschema warnings like:

    amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove the bus, as suggested by Marek
---
 arch/arm/boot/dts/exynos3250.dtsi             |  47 +++----
 arch/arm/boot/dts/exynos4.dtsi                |  70 +++++-----
 .../boot/dts/exynos4210-universal_c210.dts    |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi             |  92 ++++++-------
 arch/arm/boot/dts/exynos5410.dtsi             |  46 +++----
 arch/arm/boot/dts/exynos5420.dtsi             | 130 ++++++++----------
 6 files changed, 174 insertions(+), 213 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 044e5da64a76..d3fb45a56527 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -418,33 +418,26 @@
 			status = "disabled";
 		};
 
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pdma0: pdma@12680000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12680000 0x1000>;
-				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@12690000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12690000 0x1000>;
-				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@12680000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12680000 0x1000>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@12690000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12690000 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		adc: adc@126c0000 {
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index d2779a790ce3..a1e54449f33f 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -669,45 +669,37 @@
 			status = "disabled";
 		};
 
-		amba: amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			pdma0: pdma@12680000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12680000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@12690000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12690000 0x1000>;
-				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			mdma1: mdma@12850000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x12850000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
+		pdma0: pdma@12680000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12680000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@12690000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12690000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		mdma1: mdma@12850000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12850000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
 		};
 
 		fimd: fimd@11c00000 {
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 02fde1a75ebd..e07aa3aa93bd 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -181,7 +181,7 @@
 	};
 };
 
-&amba {
+&soc {
 	mdma0: mdma@12840000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x12840000 0x1000>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b6135af7ef39..e3dbe4166836 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -679,56 +679,48 @@
 			samsung,pmureg-phandle = <&pmu_system_controller>;
 		};
 
-		amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			pdma0: pdma@121a0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121A0000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@121b0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121B0000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			mdma0: mdma@10800000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10800000 0x1000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
-
-			mdma1: mdma@11c10000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x11C10000 0x1000>;
-				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
+		pdma0: pdma@121a0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121A0000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@121b0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121B0000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		mdma0: mdma@10800000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10800000 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
+		};
+
+		mdma1: mdma@11c10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x11C10000 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
 		};
 
 		gsc_0:  gsc@13e00000 {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 2eab80bf5f3a..abe75b9e39f5 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -189,34 +189,26 @@
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			pdma0: pdma@121a0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121a0000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@121a0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121a0000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
 
-			pdma1: pdma@121b0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121b0000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma1: pdma@121b0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121b0000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		audi2s0: i2s@3830000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b672080e7469..c76460b70532 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -433,76 +433,68 @@
 			power-domains = <&mau_pd>;
 		};
 
-		amba {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			interrupt-parent = <&gic>;
-			ranges;
-
-			adma: adma@3880000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x03880000 0x1000>;
-				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock_audss EXYNOS_ADMA>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <6>;
-				#dma-requests = <16>;
-				power-domains = <&mau_pd>;
-			};
-
-			pdma0: pdma@121a0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121A0000 0x1000>;
-				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@121b0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x121B0000 0x1000>;
-				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			mdma0: mdma@10800000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10800000 0x1000>;
-				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-			};
+		adma: adma@3880000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x03880000 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_audss EXYNOS_ADMA>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <6>;
+			#dma-requests = <16>;
+			power-domains = <&mau_pd>;
+		};
 
-			mdma1: mdma@11c10000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x11C10000 0x1000>;
-				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock CLK_MDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <1>;
-				/*
-				 * MDMA1 can support both secure and non-secure
-				 * AXI transactions. When this is enabled in
-				 * the kernel for boards that run in secure
-				 * mode, we are getting imprecise external
-				 * aborts causing the kernel to oops.
-				 */
-				status = "disabled";
-			};
+		pdma0: pdma@121a0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121A0000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@121b0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x121B0000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		mdma0: mdma@10800000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10800000 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
+		};
+
+		mdma1: mdma@11c10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x11C10000 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock CLK_MDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <1>;
+			/*
+			 * MDMA1 can support both secure and non-secure
+			 * AXI transactions. When this is enabled in
+			 * the kernel for boards that run in secure
+			 * mode, we are getting imprecise external
+			 * aborts causing the kernel to oops.
+			 */
+			status = "disabled";
 		};
 
 		i2s0: i2s@3830000 {
-- 
2.17.1

