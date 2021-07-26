Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA13D560E
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 11:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhGZIXh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 04:23:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33068 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhGZIXg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Jul 2021 04:23:36 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m7wWl-0001LU-2a; Mon, 26 Jul 2021 11:03:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        cl@rock-chips.com, pgwipeout@gmail.com, xxm@rock-chips.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] arm64: dts: rockchip: add pwm nodes for rk3568
Date:   Mon, 26 Jul 2021 11:03:55 +0200
Message-Id: <20210726090355.1548483-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726090355.1548483-1-heiko@sntech.de>
References: <20210726090355.1548483-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Add the pwm controller nodes to the core rk3568 dtsi.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 176 +++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 322971318d5a..a424edc81a9e 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -251,6 +251,50 @@ uart0: serial@fdd50000 {
 		status = "disabled";
 	};
 
+	pwm0: pwm@fdd70000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70000 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm0m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm1: pwm@fdd70010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70010 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm1m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm2: pwm@fdd70020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70020 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm2m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm3: pwm@fdd70030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfdd70030 0x0 0x10>;
+		clocks = <&pmucru CLK_PWM0>, <&pmucru PCLK_PWM0>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm3_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	pmu: power-management@fdd90000 {
 		compatible = "rockchip,rk3568-pmu", "syscon", "simple-mfd";
 		reg = <0x0 0xfdd90000 0x0 0x1000>;
@@ -738,6 +782,138 @@ saradc: saradc@fe720000 {
 		status = "disabled";
 	};
 
+	pwm4: pwm@fe6e0000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0000 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm4_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm5: pwm@fe6e0010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0010 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm5_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm6: pwm@fe6e0020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0020 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm6_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm7: pwm@fe6e0030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6e0030 0x0 0x10>;
+		clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm7_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm8: pwm@fe6f0000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0000 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm8m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm9: pwm@fe6f0010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0010 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm9m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm10: pwm@fe6f0020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0020 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm10m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm11: pwm@fe6f0030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe6f0030 0x0 0x10>;
+		clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm11m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm12: pwm@fe700000 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700000 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm12m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm13: pwm@fe700010 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700010 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm13m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm14: pwm@fe700020 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700020 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm14m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
+	pwm15: pwm@fe700030 {
+		compatible = "rockchip,rk3568-pwm", "rockchip,rk3328-pwm";
+		reg = <0x0 0xfe700030 0x0 0x10>;
+		clocks = <&cru CLK_PWM3>, <&cru PCLK_PWM3>;
+		clock-names = "pwm", "pclk";
+		pinctrl-0 = <&pwm15m0_pins>;
+		pinctrl-names = "active";
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.29.2

