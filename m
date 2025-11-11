Return-Path: <linux-pwm+bounces-7617-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF43C4C074
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 08:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C66F4FA883
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Nov 2025 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D558C35470B;
	Tue, 11 Nov 2025 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GlqWiNON"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804034DCC4;
	Tue, 11 Nov 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844568; cv=none; b=B48WDPp2XyMAm+K7VcmiYXgrhos6N8gRla8+NPMdfm3eUoWbApNNzC3UUOth7uW3pkbhH5fxzAhMSC85JdkAz9rPYp5/5Uj+L5Xod78otbJv8GRJ36+hCkPyweFHbq0OhTbgpdZqCX56oNeZmYtangcMpASNzGRVvA9lvs0J1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844568; c=relaxed/simple;
	bh=J9FKhBLaNbK/i1odT+EeOFJ6//0+5rw8T2CsQ2ShXrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIW0Xu3h7P0D27H1pnZ25Sx32elxcD40n4ypSLIvu0s0KsbPIlXhvJYhgm7hc8Yn8TaoUsAmUpoEICbzsKL42lxyvhLXEKjq5yTWXS8oOTpN/O8lO4/PFw7kwAnqU2Trmf1xZBCi+wt2BvjXDMwtVYVbZ30zMaYoXYrgIp83joQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GlqWiNON; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 65db96c8becc11f0b33aeb1e7f16c2b6-20251111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=E7dtEFG0pJFMZIY/kAZ+SdJrPIS7jP27OpbBZKEIMLg=;
	b=GlqWiNONITrRWoYqKliNyxGaRuew/8XXgYIRTbf0EJDAQ2/DWa0723XBbjVgcyTpqrpZRhzRYkHR6rEtyzWxyKtpyhOsowd2i3Lo56lzFpjIiG8vu+ufuYYocVQNKbUHsLhWRx8v328kApKni0t1XmsHDQwggG/ylFuhfElwRgE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bd249eeb-bb20-42e4-8553-d8ead47cdaa8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4896aaba-0c02-41a0-92a3-94dc7dc7eeca,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:1,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 65db96c8becc11f0b33aeb1e7f16c2b6-20251111
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jh.hsu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 107993576; Tue, 11 Nov 2025 15:02:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 11 Nov 2025 15:02:31 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 11 Nov 2025 15:02:31 +0800
From: Jack Hsu <jh.hsu@mediatek.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <srini@kernel.org>,
	<ukleinek@kernel.org>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<chunfeng.yun@mediatek.com>, <wim@linux-watchdog.org>, <linux@roeck-us.net>,
	<sean.wang@mediatek.com>, <zhiyong.tao@mediatek.com>,
	<andrew-ct.chen@mediatek.com>, <lala.lin@mediatek.com>,
	<jitao.shi@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jack Hsu
	<jh.hsu@mediatek.com>
Subject: [PATCH v7 9/9] arm64: dts: mediatek: Add mt8189 evaluation board dts
Date: Tue, 11 Nov 2025 14:59:23 +0800
Message-ID: <20251111070031.305281-10-jh.hsu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251111070031.305281-1-jh.hsu@mediatek.com>
References: <20251111070031.305281-1-jh.hsu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add MediaTek mt8189 evaluation board dts, dtsi, Mafefile.

Signed-off-by: Jack Hsu <jh.hsu@mediatek.com>

---
Changs in v7:
   - update mt8189 clk node
     (refer to: https://lore.kernel.org/linux-mediatek/20251106124330.1145600-1-irving-ch.lin@mediatek.com/)
   - xhci node drop "reset-names" property
   - update mt8189 thermal node
     (refer to: https://lore.kernel.org/linux-mediatek/20251110094113.3965182-1-hanchien.lin@mediatek.com/)

 - Link to v6: https://lore.kernel.org/linux-mediatek/20251030134541.784011-1-jh.hsu@mediatek.com/

---
 arch/arm64/boot/dts/mediatek/Makefile       |    1 +
 arch/arm64/boot/dts/mediatek/mt8189-evb.dts | 1082 ++++++
 arch/arm64/boot/dts/mediatek/mt8189.dtsi    | 3310 +++++++++++++++++++
 3 files changed, 4393 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c5fd6191a925..188e479a6916 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -94,6 +94,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8189-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8189-evb.dts b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
new file mode 100644
index 000000000000..2ed404829730
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
@@ -0,0 +1,1082 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sirius Wang <sirius.wang@mediatek.com>
+ */
+/dts-v1/;
+#include "mt8189.dtsi"
+#include "mt8189-pinfunc.h"
+#include "mt6319.dtsi"
+#include "mt6359.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "MediaTek MT8189 evaluation board";
+	compatible = "mediatek,mt8189-evb", "mediatek,mt8189";
+
+	chosen: chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	usb_p0_vbus: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "p0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 82 0>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "p1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 84 0>;
+		enable-active-high;
+	};
+
+	usb_p2_vbus: regulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "p2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 85 0>;
+		enable-active-high;
+	};
+
+	usb_p3_vbus: regulator@3 {
+		compatible = "regulator-fixed";
+		regulator-name = "p3_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 86 0>;
+		enable-active-high;
+	};
+
+	usb_p4_vbus: regulator@4 {
+		compatible = "regulator-fixed";
+		regulator-name = "p4_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 87 0>;
+		enable-active-high;
+	};
+};
+
+&afe{
+	pinctrl-names = "aud-gpio-i2sin0-off",
+		"aud-gpio-i2sin0-on",
+		"aud-gpio-i2sout0-off",
+		"aud-gpio-i2sout0-on",
+		"aud-gpio-i2sin1-off",
+		"aud-gpio-i2sin1-on",
+		"aud-gpio-i2sout1-off",
+		"aud-gpio-i2sout1-on",
+		/*dmic*/
+		"aud-gpio-ap-dmic-off",
+		"aud-gpio-ap-dmic-on",
+		"aud-gpio-ap-dmic1-off",
+		"aud-gpio-ap-dmic1-on",
+		/*pcm*/
+		"aud-gpio-pcm-off",
+		"aud-gpio-pcm-on";
+
+	/* i2s */
+	pinctrl-0 = <&aud_gpio_i2sin0_off>;
+	pinctrl-1 = <&aud_gpio_i2sin0_on>;
+	pinctrl-2 = <&aud_gpio_i2sout0_off>;
+	pinctrl-3 = <&aud_gpio_i2sout0_on>;
+	pinctrl-4 = <&aud_gpio_i2sin1_off>;
+	pinctrl-5 = <&aud_gpio_i2sin1_on>;
+	pinctrl-6 = <&aud_gpio_i2sout1_off>;
+	pinctrl-7 = <&aud_gpio_i2sout1_on>;
+	/* dmic */
+	pinctrl-8 = <&aud_gpio_ap_dmic_off>;
+	pinctrl-9 = <&aud_gpio_ap_dmic_on>;
+	pinctrl-10 = <&aud_gpio_ap_dmic1_off>;
+	pinctrl-11 = <&aud_gpio_ap_dmic1_on>;
+	/* pcm */
+	pinctrl-12 = <&aud_gpio_pcm_off>;
+	pinctrl-13 = <&aud_gpio_pcm_on>;
+
+	status = "okay";
+};
+
+&auxadc {
+	status = "okay";
+};
+
+&cpuhvfs {
+	proc1-supply = <&mt6359_vmodem_buck_reg>; //L
+	proc2-supply = <&mt6319_7_vbuck1>; //B
+	proc3-supply = <&mt6359_vmodem_buck_reg>; //DSU
+};
+
+&disp_dvo0 {
+	status = "okay";
+
+	ports {
+		port {
+			disp_dvo0_out: endpoint {
+				remote-endpoint = <&edptx_in>;
+			};
+		};
+	};
+};
+
+&disp_dvo1 {
+	status = "okay";
+
+	port {
+		disp1_dp_intf0_out: endpoint {
+			remote-endpoint = <&dptx_in0>;
+		};
+	};
+};
+
+&dp_tx {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&dptx_pin>;
+
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dptx_in0: endpoint {
+				remote-endpoint = <&disp1_dp_intf0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dptx_out: endpoint {
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel1@0 {
+		compatible = "boe,tv101wum-nl6";
+		reg = <0>;
+		reset-gpios = <&pio 25 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pio 14 GPIO_ACTIVE_HIGH>;
+		gate-ic = <4831>;
+		pinctrl-names = "default";
+		status = "okay";
+
+		port {
+			panel_in1: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+
+	port {
+		dsi_out: endpoint {
+			remote-endpoint = <&panel_in1>;
+		};
+	};
+};
+
+&edp_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&edp_tx_hpd_pins>;
+	max-lane-count = <4>;
+	max-linkrate-mhz = <5400>;
+	use-aux-bus;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			edptx_in: endpoint {
+				remote-endpoint = <&disp_dvo0_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			edp_out: endpoint {
+				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&edp_panel_in>;
+			};
+		};
+	};
+
+	aux-bus {
+		panel: panel {
+			compatible = "edp-panel";
+			pinctrl-names = "default";
+			pinctrl-0 = <&panel_fixed_pins>;
+
+			status = "okay";
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&edp_out>;
+				};
+			};
+		};
+	};
+};
+
+&gpu {
+	supply-names = "mali";
+	mali-supply = <&mt6359_vproc1_buck_reg>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "disabled";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "disabled";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "disabled";
+
+	nau8825: audio-codec@1a {
+		compatible = "nuvoton,nau8825";
+		reg = <0x1a>;
+		interrupts-extended = <&pio 4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_codec_pins>;
+		#sound-dai-cells = <0>;
+
+		nuvoton,jkdet-enable;
+		nuvoton,jkdet-polarity = <1>;
+		nuvoton,vref-impedance = <2>;
+		nuvoton,micbias-voltage = <6>;
+		nuvoton,sar-threshold-num = <4>;
+		nuvoton,sar-threshold = <0xc 0x1e 0x38 0x60>;
+		nuvoton,sar-hysteresis = <1>;
+		nuvoton,sar-voltage = <0>;
+		nuvoton,sar-compare-time = <0>;
+		nuvoton,sar-sampling-time = <0>;
+		nuvoton,short-key-debounce = <2>;
+		nuvoton,jack-insert-debounce = <7>;
+		nuvoton,jack-eject-debounce = <7>;
+		nuvoton,adc-delay-ms = <300>;
+		status = "disabled";
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "disabled";
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	status = "disabled";
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	status = "disabled";
+};
+
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	status = "disabled";
+};
+
+&i2c7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_pins>;
+	status = "disabled";
+};
+
+&i2c8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c8_pins>;
+	status = "disabled";
+};
+
+&mipi_tx_config0 {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	supports-cqe;
+	cap-mmc-hw-reset;
+	no-sdio;
+	no-sd;
+	non-removable;
+	hs400-ds-delay = <0x1481b>;
+	mediatek,hs400-ds-dly3 = <0x14>;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	no-mmc;
+	no-sdio;
+	cd-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&mt6359_vpa_buck_reg>;
+	vqmmc-supply = <&mt6359_vsim1_ldo_reg>;
+};
+
+/delete-node/ &mt6319_7_vbuck2;
+/delete-node/ &mt6319_8_vbuck2;
+/delete-node/ &mt6319_8_vbuck4;
+
+&mt6359_vpa_buck_reg {
+	regulator-max-microvolt = <3000000>;
+};
+
+&mt6359_vmodem_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_proc2_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_md_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg{
+	regulator-always-on;
+};
+
+&mt6359_vproc2_buck_reg{
+	regulator-always-on;
+};
+
+&mt6359_vaux18_ldo_reg{
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg{
+	regulator-always-on;
+};
+
+&mt6359_va09_ldo_reg{
+	regulator-always-on;
+};
+
+&mt6359_vrfck_ldo_reg{
+	regulator-always-on;
+};
+
+&mt6359_vbbck_ldo_reg{
+	regulator-always-on;
+};
+
+&mt6359_vsram_proc1_ldo_reg{
+	 /delete-property/ regulator-always-on;
+};
+
+
+&mt6359_vproc1_buck_reg {
+	regulator-name = "buck_vgpu";
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <900000>;
+	regulator-coupled-with = <&mt6359_vsram_proc1_ldo_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
+&mt6359_vsram_proc1_ldo_reg {
+	regulator-name = "ldo_sram_gpu";
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <900000>;
+	regulator-coupled-with = <&mt6359_vproc1_buck_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
+&mt6359rtc {
+	status = "okay";
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins>;
+
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins_default>;
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
+
+&pio {
+	edp_tx_hpd_pins: edp-tx-hpd-pins{
+		pins-hpd {
+			pinmux = <PINMUX_GPIO28__FUNC_EDP_TX_HPD>;
+			bias-pull-up;
+		};
+	};
+
+	panel_fixed_pins: panel-fixed-pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO29__FUNC_GPIO29>,
+				 <PINMUX_GPIO108__FUNC_GPIO108>,
+				 <PINMUX_GPIO109__FUNC_GPIO109>,
+				 <PINMUX_GPIO110__FUNC_GPIO110>;
+			bias-pull-up;
+		};
+	};
+
+	i2c0_pins: i2c0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO52__FUNC_SDA0>,
+				 <PINMUX_GPIO51__FUNC_SCL0>;
+			bias-disable;
+		};
+	};
+
+	i2c1_pins: i2c1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO54__FUNC_SDA1>,
+				 <PINMUX_GPIO53__FUNC_SCL1>;
+			bias-disable;
+		};
+	};
+
+	i2c2_pins: i2c2-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO56__FUNC_SDA2>,
+				 <PINMUX_GPIO55__FUNC_SCL2>;
+			bias-disable;
+		};
+	};
+
+	i2c3_pins: i2c3-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO58__FUNC_SDA3>,
+				 <PINMUX_GPIO57__FUNC_SCL3>;
+			bias-disable;
+		};
+	};
+
+	i2c4_pins: i2c4-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO60__FUNC_SDA4>,
+				 <PINMUX_GPIO59__FUNC_SCL4>;
+			bias-disable;
+		};
+	};
+	i2c5_pins: i2c5-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO62__FUNC_SDA5>,
+				 <PINMUX_GPIO61__FUNC_SCL5>;
+			bias-disable;
+		};
+	};
+
+	i2c6_pins: i2c6-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO64__FUNC_SDA6>,
+				 <PINMUX_GPIO63__FUNC_SCL6>;
+			bias-disable;
+		};
+	};
+
+	i2c7_pins: i2c7-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO66__FUNC_SDA7>,
+				 <PINMUX_GPIO65__FUNC_SCL7>;
+			bias-disable;
+		};
+	};
+
+	i2c8_pins: i2c8-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO68__FUNC_SDA8>,
+				 <PINMUX_GPIO67__FUNC_SCL8>;
+			bias-disable;
+		};
+	};
+
+	spi0_pins: spi0-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO69__FUNC_SPIM0_CSB>,
+				 <PINMUX_GPIO70__FUNC_SPIM0_CLK>,
+				 <PINMUX_GPIO71__FUNC_SPIM0_MO>,
+				 <PINMUX_GPIO72__FUNC_SPIM0_MI>;
+		};
+	};
+
+	spi1_pins: spi1-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO73__FUNC_SPIM1_CSB>,
+				 <PINMUX_GPIO74__FUNC_SPIM1_CLK>,
+				 <PINMUX_GPIO75__FUNC_SPIM1_MO>,
+				 <PINMUX_GPIO76__FUNC_SPIM1_MI>;
+		};
+	};
+
+	spi2_pins: spi2-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO77__FUNC_SPIM2_CSB>,
+				 <PINMUX_GPIO78__FUNC_SPIM2_CLK>,
+				 <PINMUX_GPIO79__FUNC_SPIM2_MO>,
+				 <PINMUX_GPIO80__FUNC_SPIM2_MI>;
+		};
+	};
+
+	spi3_pins: spi3-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO0__FUNC_SPIM3_A_CSB>,
+				 <PINMUX_GPIO1__FUNC_SPIM3_A_CLK>,
+				 <PINMUX_GPIO2__FUNC_SPIM3_A_MO>,
+				 <PINMUX_GPIO3__FUNC_SPIM3_A_MI>;
+		};
+	};
+
+	spi4_pins: spi4-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO4__FUNC_SPIM4_A_CSB>,
+				 <PINMUX_GPIO5__FUNC_SPIM4_A_CLK>,
+				 <PINMUX_GPIO6__FUNC_SPIM4_A_MO>,
+				 <PINMUX_GPIO7__FUNC_SPIM4_A_MI>;
+		};
+	};
+
+	spi5_pins: spi5-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO8__FUNC_SPIM5_A_CSB>,
+				 <PINMUX_GPIO9__FUNC_SPIM5_A_CLK>,
+				 <PINMUX_GPIO10__FUNC_SPIM5_A_MO>,
+				 <PINMUX_GPIO11__FUNC_SPIM5_A_MI>;
+		};
+	};
+
+	pcie_pins_default: pcie-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO48__FUNC_WAKEN>,
+				 <PINMUX_GPIO49__FUNC_PERSTN>,
+				 <PINMUX_GPIO50__FUNC_CLKREQN>;
+		};
+	};
+
+	nor_pins: nor-pins {
+		pins-ck-io {
+			pinmux = <PINMUX_GPIO150__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO152__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO153__FUNC_SPINOR_IO1>;
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO151__FUNC_SPINOR_CS>;
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+	};
+
+	dptx_pin: dptx-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO27__FUNC_DP_TX_HPD>;
+		};
+	};
+
+	/* AUDIO GPIO standardization start */
+	audio_spk_en_pins: audio-spk-en-pins {
+		pins-spk-en {
+			pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
+			output-low;
+		};
+	};
+
+	audio_codec_pins: audio-codec-pins {
+		pins-hp-int-odl {
+			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
+			input-enable;
+			bias-disable;
+		};
+	};
+
+	aud_gpio_i2sin0_off: aud-gpio-i2sin0-off-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_gpio_i2sin0_on: aud-gpio-i2sin0-on-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO106__FUNC_I2SIN0_DI>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+
+	aud_gpio_i2sout0_off: aud-gpio-i2sout0-off-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO107__FUNC_GPIO107>;
+			input-enable;
+			bias-pull-down;
+		};
+
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO108__FUNC_GPIO108>;
+			input-enable;
+			bias-pull-down;
+		};
+
+		pins-cmd3-dat {
+			pinmux = <PINMUX_GPIO109__FUNC_GPIO109>;
+			input-enable;
+			bias-pull-down;
+		};
+
+		pins-cmd4-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_GPIO110>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_gpio_i2sout0_on: aud-gpio-i2sout0-on-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO107__FUNC_I2SOUT0_MCK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO108__FUNC_I2SOUT0_BCK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+
+		pins-cmd3-dat {
+			pinmux = <PINMUX_GPIO109__FUNC_I2SOUT0_LRCK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+
+		pins-cmd4-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_I2SOUT0_DO>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+
+	aud_gpio_i2sin1_off: aud-gpio-i2sin1-off-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO130__FUNC_GPIO130>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_gpio_i2sin1_on: aud-gpio-i2sin1-on-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO130__FUNC_I2SIN1_DI>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+
+	aud_gpio_i2sout1_off: aud-gpio-i2sout1-off-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO111__FUNC_GPIO111>;
+			input-enable;
+			bias-pull-down;
+		};
+
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO112__FUNC_GPIO112>;
+			input-enable;
+			bias-pull-down;
+		};
+
+		pins-cmd3-dat {
+			pinmux = <PINMUX_GPIO113__FUNC_GPIO113>;
+			input-enable;
+			bias-pull-down;
+		};
+
+		pins-cmd4-dat {
+			pinmux = <PINMUX_GPIO114__FUNC_GPIO114>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_gpio_i2sout1_on: aud-gpio-i2sout1-on-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO111__FUNC_I2SOUT1_MCK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO112__FUNC_I2SOUT1_BCK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+
+		pins-cmd3-dat {
+			pinmux = <PINMUX_GPIO113__FUNC_I2SOUT1_LRCK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+
+		pins-cmd4-dat {
+			pinmux = <PINMUX_GPIO114__FUNC_I2SOUT1_DO>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+
+	aud_gpio_ap_dmic_off: aud-gpio-ap-dmic-off-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
+			input-enable;
+			bias-pull-down;
+		};
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+	aud_gpio_ap_dmic_on: aud-gpio-ap-dmic-on-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO119__FUNC_DMIC0_CLK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO120__FUNC_DMIC0_DAT0>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+	aud_gpio_ap_dmic1_off: aud-gpio-ap-dmic1-off-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO122__FUNC_GPIO122>;
+			input-enable;
+			bias-pull-down;
+		};
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO123__FUNC_GPIO123>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+	aud_gpio_ap_dmic1_on: aud-gpio-ap-dmic1-on-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO122__FUNC_DMIC1_CLK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO123__FUNC_DMIC1_DAT0>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+
+	aud_gpio_pcm_off: aud-gpio-pcm-off-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO115__FUNC_GPIO115>;
+			input-enable;
+			bias-pull-down;
+		};
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO116__FUNC_GPIO116>;
+			input-enable;
+			bias-pull-down;
+		};
+		pins-cmd3-dat {
+			pinmux = <PINMUX_GPIO118__FUNC_GPIO118>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	aud_gpio_pcm_on: aud-gpio-pcm-on-pins {
+		pins-cmd1-dat {
+			pinmux = <PINMUX_GPIO115__FUNC_PCM0_CLK>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+		pins-cmd2-dat {
+			pinmux = <PINMUX_GPIO116__FUNC_PCM0_SYNC>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+		pins-cmd3-dat {
+			pinmux = <PINMUX_GPIO118__FUNC_PCM0_DO>;
+			input-schmitt-enable;
+			bias-disable;
+		};
+	};
+	/* AUDIO GPIO standardization end */
+
+	mmc0_pins_default: mmc0-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO166__FUNC_MSDC0_DAT0>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO166__FUNC_MSDC0_DAT0>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins-ds {
+			pinmux = <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO168__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO168__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
+};
+
+&pmic {
+	interrupts-extended = <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sound {
+	compatible = "mediatek,mt8189-nau8825";
+	model = "mt8189_rt9123_8825";
+	status = "okay";
+
+	dai-link-0 {
+		link-name = "I2SOUT0_BE";
+		mediatek,clk-provider = "cpu";
+
+		codec {
+			sound-dai = <&nau8825>;
+		};
+	};
+
+	dai-link-1 {
+		link-name = "I2SIN0_BE";
+		mediatek,clk-provider = "cpu";
+
+		codec {
+			sound-dai = <&nau8825>;
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "disabled";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	status = "disabled";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins>;
+	status = "disabled";
+};
+
+&spi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi3_pins>;
+	status = "disabled";
+};
+
+&spi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi4_pins>;
+	status = "disabled";
+};
+
+&spi5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi5_pins>;
+	status = "disabled";
+};
+
+&mfg0 {
+	domain-supply = <&mt6359_vproc1_buck_reg>;
+};
+
+&mfg1 {
+	domain-supply = <&mt6359_vsram_proc1_ldo_reg>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&ufshci {
+	vcc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vccq-supply = <&mt6359_vio18_ldo_reg>;
+	vccq2-supply = <&mt6359_vufs_ldo_reg>;
+};
+
+&xhci0{
+	vbus-supply = <&usb_p0_vbus>;
+	status = "okay";
+};
+
+&xhci1{
+	vbus-supply = <&usb_p1_vbus>;
+	status = "okay";
+};
+
+&xhci2{
+	vbus-supply = <&usb_p2_vbus>;
+	status = "okay";
+};
+
+&xhci3{
+	vbus-supply = <&usb_p3_vbus>;
+	status = "okay";
+};
+
+&xhci4{
+	vbus-supply = <&usb_p4_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
new file mode 100644
index 000000000000..2f2648f43f34
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
@@ -0,0 +1,3310 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mediatek,mt8189-memory-port.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/mediatek,mt8189-power.h>
+#include <dt-bindings/reset/ti-syscon.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
+#include <dt-bindings/thermal/thermal.h>
+#include "mt8189-gce.h"
+
+/ {
+	compatible = "mediatek,mt8189";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		dvo0 = &disp_dvo0;
+		dvo1 = &disp_dvo1;
+		dsc0 = &disp_dsc_wrap0;
+		gce0 = &gce;
+		gce1 = &gce_m;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mutex0 = &disp_mutex0;
+		ovl0 = &disp_ovl0_4l;
+		ovl1 = &disp_ovl1_4l;
+		rdma0 = &disp_rdma0;
+		rdma1 = &disp_rdma1;
+		serial0 = &uart0;
+	};
+
+	clk32k: oscillator-clk32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "clk32k";
+	};
+
+	clk13m: oscillator-clk13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-mult = <1>;
+		clock-div = <2>;
+		clock-output-names = "clk13m";
+	};
+
+	clk26m: oscillator-clk26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	clk104m: oscillator-clk104m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-mult = <4>;
+		clock-div = <1>;
+		clock-output-names = "clk104m";
+	};
+
+	ulposc: oscillator-ulposc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <520000000>;
+		clock-output-names = "ulposc";
+	};
+
+	ulposc3: oscillator-ulposc3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "ulposc3";
+	};
+
+	vowpll: oscillator-vowpll {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "vowpll";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x000>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <358>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <358>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <358>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <358>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <358>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <358>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x600>;
+			enable-method = "psci";
+			clock-frequency = <3000000000>;
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b>, <&cpu_s2idle>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x700>;
+			enable-method = "psci";
+			clock-frequency = <3000000000>;
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b>, <&cpu_s2idle>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+				core4 {
+					cpu = <&cpu4>;
+				};
+				core5 {
+					cpu = <&cpu5>;
+				};
+				core6 {
+					cpu = <&cpu6>;
+				};
+				core7 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_off_l: cpu-off-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <25>;
+				exit-latency-us = <57>;
+				min-residency-us = <5700>;
+			};
+
+			cpu_off_b: cpu-off-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <35>;
+				exit-latency-us = <82>;
+				min-residency-us = <1890>;
+			};
+
+			cpu_s2idle: cpu-s2idle {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x020180ff>;
+				local-timer-stop;
+				entry-latency-us = <10000>;
+				exit-latency-us = <10000>;
+				min-residency-us = <4294967295>;
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <262144>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-unified;
+		};
+	};
+
+	firmware: firmware {
+		scmi: scmi {
+			compatible = "arm,scmi";
+			mboxes = <&tinysys_mbox 0>, <&tinysys_mbox 1>;
+			shmem = <&scmi_tx_shmem>, <&scmi_rx_shmem>;
+			mbox-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_tinysys: protocol@80 {
+				reg = <0x80>;
+				mediatek,scmi-mminfra = <5>;
+			};
+		};
+	};
+
+	memory: memory@40000000 {
+		device_type = "memory";
+		/* This memory size is filled in by the bootloader */
+		reg = <0 0x40000000 0 0>;
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
+	};
+
+	pmu-a78 {
+		compatible = "arm,cortex-a78-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		/*TODO: add reserved memory node here*/
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		afe_dma_mem_reserved: snd-dma-mem-region@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0x300000>;
+			no-map;
+		};
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+	};
+
+	wl_info: wl-info@c2bf090 {
+		compatible = "mediatek,wl-info";
+		wl-support = <0>;
+		reg = <0 0x0c2bf090 0 0x10>, /*tcm sram base*/
+			<0 0x0c2c2f10 0 0x1520>; /*tcm wl-base sram*/
+		reg-names = "wl_sram_base", "wl_tbl_base";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		cpuhvfs: cpuhvfs@100a00 {
+			compatible = "mediatek,cpufreq-hybrid";
+			reg = <0 0x00100a00 0 0xc00>,
+			      <0 0x00108d68 0 0x1400>,
+			      <0 0x0010a168 0 0x1800>,
+			      <0 0x00103640 0 0xc0>;
+			reg-names = "USRAM", "CSRAM", "ESRAM", "FREQ_HW_STATE";
+
+			/* pll mcucfg */
+			mcucfg-ver = <0>;
+		};
+
+		performance: performance-controller@108d68 {
+			compatible = "mediatek,cpufreq-hw";
+			reg = <0 0x00108d78 0 0x120>,
+			      <0 0x00108e98 0 0x120>;
+			reg-names = "performance-domain0",
+				    "performance-domain1";
+			#performance-domain-cells = <1>;
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0xc000000 0 0x40000>, /* distributor */
+			      <0 0xc040000 0 0x200000>; /* redistributor */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu6 &cpu7>;
+				};
+			};
+		};
+
+		dbgao_clk: syscon@d01a000 {
+			compatible = "mediatek,mt8189-dbg-ao", "syscon";
+			reg = <0 0xd01a000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		soc_dbg_error_flag: soc-dbg-error-flag@d01a000 {
+			compatible = "mediatek, soc-dbg-error-flag";
+			reg = <0 0x0d01a000 0 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "dbg-error-flag";
+			/* error flag mask description */
+			mcu2sub-emi-m1-parity-mask = <0x1>;
+			mcu2sub-emi-m0-parity-mask = <0x2>;
+			mcu2emi-m1-parity-mask = <0x4>;
+			mcu2emi-m0-parity-mask = <0x8>;
+			mcu2infra-reg-parity-mask = <0x10>;
+			infra-l3-cache2mcu-parity-mask = <0x20>;
+			emi-parity-cen-mask = <0x40>;
+			emi-parity-sub-cen-mask = <0x80>;
+			emi-parity-chan1-mask = <0x100>;
+			emi-parity-chan2-mask = <0x200>;
+			emi-parity-chan3-mask = <0x400>;
+			emi-parity-chan4-mask = <0x800>;
+			dramc-error-flag-ch-a-mask = <0x1000>;
+			dramc-error-flag-ch-b-mask = <0x2000>;
+			dramc-error-flag-ch-c-mask = <0x4000>;
+			dramc-error-flag-ch-d-mask = <0x8000>;
+			ap-tracker-timeout-mask = <0x10000>;
+			infra-tracker-timeout-mask = <0x20000>;
+			infra-lastbus-timeout-mask = <0x1000000>;
+			peri-lastbus-timeout-mask = <0x2000000>;
+			dram-md32-wdt-event-ch-a-mask = <0x8000000>;
+			dram-md32-wdt-event-ch-b-mask = <0x10000000>;
+			dram-md32-wdt-event-ch-c-mask = <0x20000000>;
+		};
+
+		dem_clk: syscon@d0a0000 {
+			compatible = "mediatek,mt8189-dem", "syscon";
+			reg = <0 0xd0a0000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		topckgen_clk: syscon@10000000 {
+			compatible = "mediatek,mt8189-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infracfg_ao_clk: syscon@10001000 {
+			compatible = "mediatek,mt8189-infra-ao", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt8189-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11b50000 0 0x1000>,
+			      <0 0x11c50000 0 0x1000>,
+			      <0 0x11c60000 0 0x1000>,
+			      <0 0x11d20000 0 0x1000>,
+			      <0 0x11d30000 0 0x1000>,
+			      <0 0x11d40000 0 0x1000>,
+			      <0 0x11e20000 0 0x1000>,
+			      <0 0x11e30000 0 0x1000>,
+			      <0 0x11f20000 0 0x1000>,
+			      <0 0x11ce0000 0 0x1000>,
+			      <0 0x11de0000 0 0x1000>,
+			      <0 0x11e60000 0 0x1000>,
+			      <0 0x1c01e000 0 0x1000>,
+			      <0 0x11f00000 0 0x1000>;
+			reg-names = "base",
+				    "lm",
+				    "rb0",
+				    "rb1",
+				    "bm0",
+				    "bm1",
+				    "bm2",
+				    "lt0",
+				    "lt1",
+				    "rt",
+				    "eint0",
+				    "eint1",
+				    "eint2",
+				    "eint3",
+				    "eint4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 182>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
+			#interrupt-cells = <2>;
+		};
+
+		apmixedsys_clk: syscon@1000c000 {
+			compatible = "mediatek,mt8189-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		devapc_infra: devapc@10207000 {
+			compatible = "mediatek,mt8189-devapc";
+			reg = <0 0x10207000 0 0x1000>,
+			      <0 0x10030000 0 0x1000>; /* infra ao/pd */
+			vio-idx-num = <105>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;/* infra irq */
+		};
+
+		emicen: emicen@10219000 {
+			compatible = "mediatek,mt8189-emicen";
+			reg = <0 0x10219000 0 0x1000>;
+			mediatek,emi-reg = <&emichn>;
+		};
+
+		emichn: emichn@10235000 {
+			compatible = "mediatek,common-emichn";
+			reg = <0 0x10235000 0 0x1000>,
+				<0 0x10245000 0 0x1000>;
+		};
+
+		emicfg_ao_mem_clk: syscon@10270000 {
+			compatible = "mediatek,mt8189-emicfg-ao-mem", "syscon";
+			reg = <0 0x10270000 0 0x1000>;
+		};
+
+		devapc_infra1: devapc@10274000 {
+			compatible = "mediatek,mt8189-devapc";
+			reg = <0 0x10274000 0 0x1000>,
+			      <0 0x10034000 0 0x1000>; /* infra1 ao/pd */
+			vio-idx-num = <132>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;/* infra irq */
+		};
+
+		lvts_ap: lvts@10315000 {
+			compatible = "mediatek,mt8189-lvts-ap";
+			reg = <0 0x10315000 0 0x1000>;
+			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH 0>;
+			#thermal-sensor-cells = <1>;
+			nvmem-cells = <&lvts_e_data1>, <&lvts_e_data2>;
+			nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+		};
+
+		lvts_mcu: lvts@10316000 {
+			compatible = "mediatek,mt8189-lvts-mcu";
+			reg = <0 0x10316000 0 0x1000>;
+			interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH 0>;
+			#thermal-sensor-cells = <1>;
+			nvmem-cells = <&lvts_e_data1>, <&lvts_e_data2>;
+			nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+		};
+
+		infra_iommu_m4: iommu@10330000 {
+			compatible = "mediatek,mt8189-iommu-infra";
+			reg = <0 0x10330000 0 0x1000>;
+			interrupts = <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH 0>;
+			#iommu-cells = <1>;
+		};
+
+		infra_iommu_m7: iommu@1033a000 {
+			compatible = "mediatek,mt8189-iommu-infra";
+			reg = <0 0x1033a000 0 0x1000>;
+			interrupts = <GIC_SPI 543 IRQ_TYPE_LEVEL_HIGH 0>;
+			#iommu-cells = <1>;
+		};
+
+		uart0: serial@11001000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001000 0 0x1000>;
+			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&pericfg_ao_clk CLK_PERAO_UART0>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		afe: mt8189-afe-pcm@11050000 {
+			compatible = "mediatek,mt8189-afe-pcm";
+			reg = <0 0x11050000 0 0x10000>;
+			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_AUDIO>;
+			memory-region = <&afe_dma_mem_reserved>;
+			clocks = <&topckgen_clk CLK_TOP_AUD_INTBUS_SEL>,
+				 <&topckgen_clk CLK_TOP_AUD_ENGEN1_SEL>,
+				 <&topckgen_clk CLK_TOP_AUD_ENGEN2_SEL>,
+				 <&topckgen_clk CLK_TOP_AUDIO_H_SEL>,
+				 <&apmixedsys_clk CLK_APMIXED_APLL1>,
+				 <&apmixedsys_clk CLK_APMIXED_APLL2>,
+				 <&topckgen_clk CLK_TOP_APLL1_D4>,
+				 <&topckgen_clk CLK_TOP_APLL2_D4>,
+				 <&topckgen_clk CLK_TOP_APLL12_CK_DIV_I2SIN0>,
+				 <&topckgen_clk CLK_TOP_APLL12_CK_DIV_I2SIN1>,
+				 <&topckgen_clk CLK_TOP_APLL12_CK_DIV_I2SOUT0>,
+				 <&topckgen_clk CLK_TOP_APLL12_CK_DIV_I2SOUT1>,
+				 <&topckgen_clk CLK_TOP_APLL12_CK_DIV_FMI2S>,
+				 <&topckgen_clk CLK_TOP_APLL12_CK_DIV_TDMOUT_M>,
+				 <&topckgen_clk CLK_TOP_APLL12_CK_DIV_TDMOUT_B>,
+				 <&topckgen_clk CLK_TOP_AUD_1_SEL>,
+				 <&topckgen_clk CLK_TOP_AUD_2_SEL>,
+				 <&topckgen_clk CLK_TOP_APLL_I2SIN0_MCK_SEL>,
+				 <&topckgen_clk CLK_TOP_APLL_I2SIN1_MCK_SEL>,
+				 <&topckgen_clk CLK_TOP_APLL_I2SOUT0_MCK_SEL>,
+				 <&topckgen_clk CLK_TOP_APLL_I2SOUT1_MCK_SEL>,
+				 <&topckgen_clk CLK_TOP_APLL_FMI2S_MCK_SEL>,
+				 <&topckgen_clk CLK_TOP_APLL_TDMOUT_MCK_SEL>,
+				 <&clk26m>,
+				 <&pericfg_ao_clk CLK_PERAO_AUDIO0>,
+				 <&pericfg_ao_clk CLK_PERAO_AUDIO1>,
+				 <&pericfg_ao_clk CLK_PERAO_AUDIO2>;
+			clock-names = "top_aud_intbus",
+				      "top_aud_eng1",
+				      "top_aud_eng2",
+				      "top_aud_h",
+				      "apll1",
+				      "apll2",
+				      "apll1_d4",
+				      "apll2_d4",
+				      "apll12_div_i2sin0",
+				      "apll12_div_i2sin1",
+				      "apll12_div_i2sout0",
+				      "apll12_div_i2sout1",
+				      "apll12_div_fmi2s",
+				      "apll12_div_tdmout_m",
+				      "apll12_div_tdmout_b",
+				      "top_apll1",
+				      "top_apll2",
+				      "top_i2sin0",
+				      "top_i2sin1",
+				      "top_i2sout0",
+				      "top_i2sout1",
+				      "top_fmi2s",
+				      "top_dptx",
+				      "clk26m",
+				      "aud_slv_ck_peri",
+				      "aud_mst_ck_peri",
+				      "aud_intbus_ck_peri";
+			mediatek,apmixedsys = <&apmixedsys_clk>;
+			status = "disabled";
+		};
+
+		sound: sound {
+			mediatek,platform = <&afe>;
+			status = "disabled";
+		};
+
+		disp_pwm0: pwm@1100e000 {
+			compatible = "mediatek,mt8189-disp-pwm", "mediatek,mt8183-disp-pwm";
+			reg = <0 0x1100e000 0 0x1000>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_DISP_PWM0>,
+				 <&topckgen_clk CLK_TOP_DISP_PWM_SEL>,
+				 <&topckgen_clk CLK_TOP_OSC_D4>;
+			clock-names = "main", "mm", "pwm_src";
+			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH 0>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		spi0: spi@11010800 {
+			compatible = "mediatek,mt8189-spi";
+			reg = <0 0x11010800 0 0x100>;
+			interrupts = <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen_clk CLK_TOP_SPI0_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI0_B>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI0_H>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,pad-select = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi@11011800 {
+			compatible = "mediatek,mt8189-spi";
+			reg = <0 0x11011800 0 0x100>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen_clk CLK_TOP_SPI1_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI1_B>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI1_H>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,pad-select = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi@11012800 {
+			compatible = "mediatek,mt8189-spi";
+			reg = <0 0x11012800 0 0x100>;
+			interrupts = <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen_clk CLK_TOP_SPI2_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI2_B>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI2_H>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,pad-select = <0>;
+			status = "disabled";
+		};
+
+		spi3: spi@11013800 {
+			compatible = "mediatek,mt8189-spi";
+			reg = <0 0x11013800 0 0x100>;
+			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen_clk CLK_TOP_SPI3_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI3_B>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI3_H>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,pad-select = <0>;
+			status = "disabled";
+		};
+
+		spi4: spi@11014800 {
+			compatible = "mediatek,mt8189-spi";
+			reg = <0 0x11014800 0 0x100>;
+			interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen_clk CLK_TOP_SPI4_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI4_B>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI4_H>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,pad-select = <0>;
+			status = "disabled";
+		};
+
+		spi5: spi@11015800 {
+			compatible = "mediatek,mt8189-spi";
+			reg = <0 0x11015800 0 0x100>;
+			interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D2>,
+				 <&topckgen_clk CLK_TOP_SPI5_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI5_B>,
+				 <&pericfg_ao_clk CLK_PERAO_SPI5_H>;
+			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mediatek,pad-select = <0>;
+			status = "disabled";
+		};
+
+		nor_flash: spi@11018000 {
+			compatible = "mediatek,mt8189-nor","mediatek,mt8186-nor";
+			reg = <0 0x11018000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SFLASH_P>;
+			clock-names = "spi", "sf", "axi_f", "axi_h", "axi_p";
+			assigned-clocks = <&topckgen_clk CLK_TOP_SFLASH_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D6_D8>;
+			interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		auxadc: adc@11019000 {
+			compatible = "mediatek,mt8189-auxadc", "mediatek,mt8173-auxadc";
+			reg = <0 0x11019000 0 0x1000>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_AUXADC_26M>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		devapc_peri: devapc@11020000 {
+			compatible = "mediatek,mt8189-devapc";
+			reg = <0 0x11020000 0 0x1000>,
+			      <0 0x1103c000 0 0x1000>; /* peri ao/pd */
+			vio-idx-num = <62>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING 0>; /* peri irq */
+		};
+
+		pericfg_ao_clk: syscon@11036000 {
+			compatible = "mediatek,mt8189-peri-ao", "syscon", "simple-mfd";
+			reg = <0 0x11036000 0 0x1000>;
+			#clock-cells = <1>;
+			usb_rst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+				reset-duration-us = <100>;
+				ti,reset-bits = <
+					/* xhci mac reset */
+					/* 22: xhci */
+					0x0  22 0x0  22 0 0
+					(ASSERT_SET|ASSERT_CLEAR|STATUS_NONE)
+				>;
+			};
+		};
+
+		afe_clk: syscon@11050000 {
+			compatible = "mediatek,mt8189-audiosys", "syscon";
+			reg = <0 0x11050000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		xhci0: usb@11200000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11200000 0 0x1000>,
+			      <0 0x11203e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 207 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port0 PHY_TYPE_USB2>,
+			       <&u3port0 PHY_TYPE_USB3>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB0_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB0_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&usb_rst 0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x214 110>;
+			status = "disabled";
+		};
+
+		xhci1: usb@11210000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11210000 0 0x1000>,
+			      <0 0x11213e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 203 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port1 PHY_TYPE_USB2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB1_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB1_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck","mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			power-domains = <&spm MT8189_POWER_DOMAIN_SSUSB>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x21c 110>;
+			status = "disabled";
+		};
+
+		xhci2: usb@11220000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11220000 0 0x1000>,
+			      <0 0x11223e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 193 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port2 PHY_TYPE_USB2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB2_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB2_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck","mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			power-domains = <&spm MT8189_POWER_DOMAIN_SSUSB>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x27c 110>;
+			status = "disabled";
+		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11230000 0 0x10000>,
+			      <0 0x11e70000 0 0x1000>;
+			interrupts = <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC50_0_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0>,
+				 <&topckgen_clk CLK_TOP_MSDC50_0_HCLK_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0_SLV_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0_MST_F>,
+				 <&topckgen_clk CLK_TOP_MSDC50_0_SEL>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk",
+				      "pclk_cg", "axi_cg", "crypto";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11240000 0 0x1000>,
+			      <0 0x11d80000 0 0x1000>;
+			interrupts = <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC30_1_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1>,
+				 <&topckgen_clk CLK_TOP_MSDC30_1_HCLK_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1_SLV_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1_MST_F>;
+			clock-names = "source", "hclk", "source_cg", "bus_clk",
+				      "pclk_cg", "axi_cg";
+			status = "disabled";
+		};
+
+		xhci3: usb@11260000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11260000 0 0x2e00>,
+			      <0 0x11263e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 188 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port3 PHY_TYPE_USB2>,
+			       <&u3port3 PHY_TYPE_USB3>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB3_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB3_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			power-domains = <&spm MT8189_POWER_DOMAIN_SSUSB>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x284 110>;
+			status = "disabled";
+		};
+
+		xhci4: usb@11270000 {
+			compatible = "mediatek,mt8189-xhci", "mediatek,mtk-xhci";
+			reg = <0 0x11270000 0 0x1000>,
+			      <0 0x11273e00 0 0x0100>;
+			reg-names = "mac", "ippc";
+			interrupts-extended = <&gic GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH 0>,
+					      <&pio 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host","wakeup";
+			phys = <&u2port4 PHY_TYPE_USB2>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_SSUSB4_SYS>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_REF>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_H>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_F>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_XHCI>,
+				 <&pericfg_ao_clk CLK_PERAO_SSUSB4_FRMCNT>;
+			clock-names = "sys_ck", "ref_ck", "mcu_ck",
+				      "dma_ck", "xhci_ck", "frmcnt_ck";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			wakeup-source;
+			mediatek,syscon-wakeup = <&pericfg_ao_clk 0x28c 110>;
+			status = "disabled";
+		};
+
+		ufshci: ufshci@112b0000 {
+			compatible = "mediatek,mt8183-ufshci";
+			reg = <0 0x112b0000 0 0x2300>;
+			interrupts = <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&topckgen_clk CLK_TOP_U_SEL>,
+				 <&clk26m>,
+				 <&topckgen_clk CLK_TOP_MSDCPLL_D2>,
+				 <&topckgen_clk CLK_TOP_AES_UFSFDE_SEL>,
+				 <&topckgen_clk CLK_TOP_U_MBIST_SEL>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_UNIPRO_SYS>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_U_SAP_CFG>,
+				 <&ufscfg_ao_reg_clk CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_UFS>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_AES>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_U_AHB>,
+				 <&ufscfg_pdn_reg_clk CLK_UFSCFG_REG_UFSHCI_U_AXI>;
+
+			clock-names = "ufs_sel",
+				      "ufs_sel_min_src",
+				      "ufs_sel_max_src",
+				      "ufs_fde",
+				      "ufs_mbist",
+				      "unipro_tx_sym",
+				      "unipro_rx_sym0",
+				      "unipro_rx_sym1",
+				      "unipro_sys",
+				      "unipro_phy_sap",
+				      "phy_top_ahb_s_bus",
+				      "ufshci_ufs",
+				      "ufshci_aes",
+				      "ufshci_ufs_ahb",
+				      "ufshci_aes_axi";
+
+			freq-table-hz = <26000000 208000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<0 0>;
+
+			vcc-supply = <&mt6359_vemc_1_ldo_reg>;
+			vccq-supply = <&mt6359_vio18_ldo_reg>;
+			vccq2-supply = <&mt6359_vufs_ldo_reg>;
+
+			resets = <&ufscfgpdn_rst 0>,
+				 <&ufscfgpdn_rst 1>,
+				 <&ufscfgpdn_rst 2>;
+
+			reset-names = "unipro_rst",
+				      "crypto_rst",
+				      "hci_rst";
+
+			mediatek,ufs-disable-mcq;
+			mediatek,ufs-rtff-mtcmos;
+			mediatek,ufs-broken-vcc;
+
+			status = "disabled";
+		};
+
+		ufscfg_ao_reg_clk: syscon@112b8000 {
+			compatible = "mediatek,mt8189-ufscfg-ao", "syscon", "simple-mfd";
+			reg = <0 0x112b8000 0 0x1000>;
+			#clock-cells = <1>;
+
+			ufscfgao_rst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					/* ufs mphy reset */
+					/* 8: mphy */
+					0x48  8 0x4c  8 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+				>;
+			};
+		};
+
+		ufscfg_pdn_reg_clk: syscon@112bb000 {
+			compatible = "mediatek,mt8189-ufscfg-pdn", "syscon", "simple-mfd";
+			reg = <0 0x112bb000 0 0x1000>;
+			#clock-cells = <1>;
+
+			ufscfgpdn_rst: reset-controller {
+				compatible = "ti,syscon-reset";
+				#reset-cells = <1>;
+
+				ti,reset-bits = <
+					/* ufs ufschi/crypto/unipro reset */
+					/* 0: unipro */
+					0x48  0 0x4c  0 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+					/* 1: ufs-crypto */
+					0x48  1 0x4c  1 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+					/* 2: ufshci */
+					0x48  2 0x4c  2 0 0
+					(ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+				>;
+			};
+		};
+
+		pcie: pcie@112f0000 {
+			compatible = "mediatek,mt8189-pcie",
+				     "mediatek,mt8192-pcie";
+			reg = <0 0x112f0000 0 0x4000>;
+			device_type = "pci";
+			reg-names = "pcie-mac";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH 0>;
+			bus-range = <0x00 0xff>;
+			ranges = <0x82000000 0 0x30000000
+				  0x0 0x30000000 0 0x04000000>;
+
+			clocks = <&pericfg_ao_clk CLK_PERAO_AXI>,
+				 <&pericfg_ao_clk CLK_PERAO_AHB_APB>,
+				 <&pericfg_ao_clk CLK_PERAO_TL>,
+				 <&pericfg_ao_clk CLK_PERAO_REF>,
+				 <&topckgen_clk CLK_TOP_F26M_CK_EN>;
+
+			phys = <&pcieport PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&spm MT8189_POWER_DOMAIN_PCIE>;
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+
+			status = "disabled";
+
+			pcie_intc: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		u3phy3: t-phy@11b00000 {
+			compatible = "mediatek,mt8189-tphy",
+				     "mediatek,generic-tphy-v2";
+			reg = <0 0x11b00000 0 0x700>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port3: usb-phy@11b00000 {
+				reg = <0 0x11b00000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P3_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			u3port3: usb-phy@11b00700 {
+				reg = <0 0x11b00700 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P3_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u2phy4: xs-phy@11b10000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port4: usb-phy@11b10000 {
+				reg = <0 0x11b10000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P4_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		i2c2: i2c@11b20000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11b20000 0 0x1000>,
+			      <0 0x11300400 0 0x80>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_ws_clk CLK_IMPWS_I2C2>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		imp_iic_wrap_ws_clk: syscon@11b21e00 {
+			compatible = "mediatek,mt8189-iic-wrap-ws", "syscon";
+			reg = <0 0x11b21e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		mipi_tx_config0: mipi-tx-config@11b40000 {
+			compatible = "mediatek,mt8189-mipi-tx";
+			reg = <0 0x11b40000 0 0x1000>;
+			clocks = <&clk26m>;
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			clock-output-names = "mipi_tx0_pll";
+			dispsys-sel-offset = <0x170 0x174>;
+			status = "disabled";
+		};
+
+		dp_tx: dp-tx@11b60000  {
+			compatible = "mediatek,mt8189-dp-tx";
+			reg = <0 0x11b60000 0 0x5000>,
+			      <0 0x11c10000 0 0x1500>,
+			      <0 0x10011018 0 0x4>,
+			      <0 0x1c001e80 0 0x4>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DP_TX>,
+					<&spm MT8189_POWER_DOMAIN_SSUSB>;
+			power-domain-names = "pd_dp_tx", "pd_dp_phy";
+			interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH 0>;
+			#phy-cells = <0>;
+			clocks = <&topckgen_clk CLK_TOP_DP_SEL>,
+				 <&clk26m>;
+			clock-names = "mux_dp", "ck_26m";
+		};
+
+		edp_tx: edp-tx@11b70000 {
+			compatible = "mediatek,mt8189-edp-tx";
+			reg = <0 0x11b70000 0 0x14000>,
+			      <0 0x11e10000 0 0x1500>;
+			interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_EDP_TX_DORMANT>;
+			clocks = <&topckgen_clk CLK_TOP_EDP_SEL>;
+			clock-names = "power";
+		};
+
+		i2c0: i2c@11c20000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11c20000 0 0x1000>,
+			      <0 0x11300200 0 0x80>;
+			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_e_clk CLK_IMPE_I2C0>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@11c21000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11c21000 0 0x1000>,
+			      <0 0x11300300 0 0x80>;
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_e_clk CLK_IMPE_I2C1>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		imp_iic_wrap_e_clk: syscon@11c22e00 {
+			compatible = "mediatek,mt8189-iic-wrap-e", "syscon";
+			reg = <0 0x11c22e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		i2c3: i2c@11d70000 {
+			compatible = "mediatek,mt8188-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11d70000 0 0x1000>,
+			      <0 0x11300500 0 0x80>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s_clk CLK_IMPS_I2C3>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@11d71000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11d71000 0 0x1000>,
+			      <0 0x11300600 0 0x80>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s_clk CLK_IMPS_I2C4>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@11d72000 {
+			compatible = "mediatek,mt8188-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11d72000 0 0x1000>,
+			      <0 0x11300700 0 0x80>;
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s_clk CLK_IMPS_I2C5>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@11d73000 {
+			compatible = "mediatek,mt8188-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x11d73000 0 0x1000>,
+			      <0 0x11300800 0 0x80>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_s_clk CLK_IMPS_I2C6>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			status = "disabled";
+		};
+
+		imp_iic_wrap_s_clk: syscon@11d74e00 {
+			compatible = "mediatek,mt8189-iic-wrap-s", "syscon";
+			reg = <0 0x11d74e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		pciephy: t-phy@11e50700 {
+			compatible = "mediatek,mt8189-tphy",
+				     "mediatek,generic-tphy-v2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x11e50700 0x700>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_PCIE_PHY>;
+			status = "disabled";
+
+			pcieport: pcie-phy@0 {
+				reg = <0 0x700>;
+				#phy-cells = <1>;
+			};
+		};
+
+		u3phy0: xs-phy@11e80000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			reg = <0 0x11e83000 0 0x200>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port0: usb-phy@11e80000 {
+				reg = <0 0x11e80000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+
+			u3port0: usb-phy@11e83000 {
+				reg = <0 0x11e83400 0 0x500>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P0_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u2phy1: xs-phy@11e90000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port1: usb-phy@11e90000 {
+				reg = <0 0x11e90000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P1_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		u2phy2: xs-phy@11ef0000 {
+			compatible = "mediatek,mt8189-xsphy", "mediatek,xsphy";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			u2port2: usb-phy@11ef0000 {
+				reg = <0 0x11ef0000 0 0x700>;
+				clocks = <&topckgen_clk CLK_TOP_USB2_PHY_RF_P2_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
+		};
+
+		efuse: efuse@11f10000 {
+			compatible = "mediatek,mt8189-efuse", "mediatek,efuse";
+			reg = <0 0x11f10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			lvts_e_data1: data1@1a4 {
+				reg = <0x1a4 0x54>;
+			};
+
+			lvts_e_data2: data2@1f8 {
+				reg = <0x1f8 0x8>;
+			};
+
+			gpu_avs0: gpu-avs0@308 {
+				reg = <0x308 0x4>;
+			};
+
+			gpu_avs1: gpu-avs1@30c {
+				reg = <0x30c 0x4>;
+			};
+
+			gpu_avs2: gpu-avs2@310 {
+				reg = <0x310 0x4>;
+			};
+
+			socinfo-data1@7a0 {
+				reg = <0x7a0 0x4>;
+			};
+
+			socinfo-data2@7e0 {
+				reg = <0x7e0 0x4>;
+			};
+		};
+
+		i2c7: i2c@11f30000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11f30000 0 0x1000>,
+			      <0 0x11300900 0 0x80>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_en_clk CLK_IMPEN_I2C7>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@11f31000 {
+			compatible = "mediatek,mt8188-i2c";
+			reg = <0 0x11f31000 0 0x1000>,
+			      <0 0x11300a00 0 0x80>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&imp_iic_wrap_en_clk CLK_IMPEN_I2C8>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			clock-div = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		imp_iic_wrap_en_clk: syscon@11f32e00 {
+			compatible = "mediatek,mt8189-iic-wrap-en", "syscon";
+			reg = <0 0x11f32e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		gpu: gpu@13000000 {
+			compatible = "mediatek,mt8189-mali",
+				     "arm,mali-valhall-jm";
+			reg = <0 0x13000000 0 0x4000>;
+
+			nvmem-cells = <&gpu_avs0>, <&gpu_avs1>, <&gpu_avs2>;
+			nvmem-cell-names = "avs-bin-0", "avs-bin-1", "avs-bin-2";
+
+			interrupts = <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "job", "mmu", "gpu";
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			clocks = <&mfg_clk CLK_MFG_BG3D>;
+
+			power-domains = <&spm MT8189_POWER_DOMAIN_MFG2>,
+					<&spm MT8189_POWER_DOMAIN_MFG3>;
+			power-domain-names = "core0", "core1";
+
+			#cooling-cells = <2>;
+			dynamic-power-coefficient = <1427>;
+
+			power-model@0 {
+				compatible = "arm,mali-simple-power-model";
+				dynamic-coefficient = <1427>;
+				static-coefficient = <118279>;
+				thermal-zone = "gpu1-thermal";
+				ts = <6 (-238) 20283 32499>;
+			};
+			power-model@1 {
+				compatible = "arm,mali-tnax-power-model";
+				scale = <5>;
+			};
+		};
+
+		gpu_opp_table: opp-table-gpu {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-390000000 {
+				opp-hz = /bits/ 64 <390000000>;
+				opp-microvolt = <675000>;
+			};
+
+			opp-424000000 {
+				opp-hz = /bits/ 64 <424000000>;
+				opp-microvolt = <681250>;
+			};
+
+			opp-458000000 {
+				opp-hz = /bits/ 64 <458000000>;
+				opp-microvolt = <681250>;
+			};
+
+			opp-492000000 {
+				opp-hz = /bits/ 64 <492000000>;
+				opp-microvolt = <687500>;
+			};
+
+			opp-526000000 {
+				opp-hz = /bits/ 64 <526000000>;
+				opp-microvolt = <687500>;
+			};
+
+			opp-560000000 {
+				opp-hz = /bits/ 64 <560000000>;
+				opp-microvolt = <693750>;
+			};
+
+			opp-595000000 {
+				opp-hz = /bits/ 64 <595000000>;
+				opp-microvolt = <693750>;
+			};
+
+			opp-630000000 {
+				opp-hz = /bits/ 64 <630000000>;
+				opp-microvolt = <700000>;
+			};
+
+			opp-665000000 {
+				opp-hz = /bits/ 64 <665000000>;
+				opp-microvolt = <700000>;
+			};
+
+			opp-700000000 {
+				opp-hz = /bits/ 64 <700000000>;
+				opp-microvolt = <700000>;
+			};
+
+			opp-736000000 {
+				opp-hz = /bits/ 64 <736000000>;
+				opp-microvolt = <718750>;
+			};
+
+			opp-772000000 {
+				opp-hz = /bits/ 64 <772000000>;
+				opp-microvolt = <737500>;
+			};
+
+			opp-808000000 {
+				opp-hz = /bits/ 64 <808000000>;
+				opp-microvolt = <756250>;
+			};
+
+			opp-844000000 {
+				opp-hz = /bits/ 64 <844000000>;
+				opp-microvolt = <775000>;
+			};
+
+			opp-880000000 {
+				opp-hz = /bits/ 64 <880000000>;
+				opp-microvolt = <793750>;
+			};
+
+			opp-935000000 {
+				opp-hz = /bits/ 64 <935000000>;
+				opp-microvolt = <818750>;
+			};
+
+			opp-990000000 {
+				opp-hz = /bits/ 64 <990000000>;
+				opp-microvolt = <850000>;
+			};
+
+			opp-1045000000 {
+				opp-hz = /bits/ 64 <1045000000>;
+				opp-microvolt = <875000>;
+			};
+
+			opp-1100000000 {
+				opp-hz = /bits/ 64 <1100000000>;
+				opp-microvolt = <900000>;
+			};
+		};
+
+		mfg_clk: syscon@13fbf000 {
+			compatible = "mediatek,mt8189-mfgcfg", "syscon";
+			reg = <0 0x13fbf000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		dispsys_config: syscon@14000000 {
+			compatible = "mediatek,mt8189-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#clock-cells = <1>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_MUTEX0>,
+				 <&dispsys_config_clk CLK_MM_DIPSYS_CONFIG>;
+			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
+				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
+		};
+
+		dispsys_config_clk: syscon@14000100 {
+			compatible = "mediatek,mt8189-dispsys", "syscon";
+			reg = <0 0x14000100 0 0x20>;
+			#clock-cells = <1>;
+		};
+
+		disp_mutex0: mutex@14001000 {
+			compatible = "mediatek,mt8189-disp-mutex";
+			reg = <0 0x14001000 0 0x1000>;
+			interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_MUTEX0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
+			mediatek,gce-events = <CMDQ_EVENT_DISPSYS_DISP_MUTEX0_ENG_EVENT_0>,
+					      <CMDQ_EVENT_DISPSYS_DISP_MUTEX0_ENG_EVENT_1>;
+		};
+
+		disp_ovl0_4l: ovl@14002000 {
+			compatible = "mediatek,mt8189-disp-ovl";
+			reg = <0 0x14002000 0 0x1000>;
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&mm_iommu M4U_L0_P1_DISP_OVL0_4L_RDMA0>,
+				 <&mm_iommu M4U_L1_P2_DISP_OVL0_4L_RDMA1>,
+				 <&mm_iommu M4U_L0_P3_DISP_OVL0_4L_RDMA2>,
+				 <&mm_iommu M4U_L1_P4_DISP_OVL0_4L_RDMA3>,
+				 <&mm_iommu M4U_L0_P0_DISP_OVL0_4L_HDR>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_OVL0_4L>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x2000 0x1000>;
+		};
+
+		disp_ovl1_4l: ovl@14003000 {
+			compatible = "mediatek,mt8189-disp-ovl";
+			reg = <0 0x14003000 0 0x1000>;
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&mm_iommu M4U_L1_P1_DISP_OVL1_4L_RDMA0>,
+				 <&mm_iommu M4U_L0_P2_DISP_OVL1_4L_RDMA1>,
+				 <&mm_iommu M4U_L1_P3_DISP_OVL1_4L_RDMA2>,
+				 <&mm_iommu M4U_L0_P4_DISP_OVL1_4L_RDMA3>,
+				 <&mm_iommu M4U_L1_P0_DISP_OVL1_4L_HDR>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_OVL1_4L>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
+		};
+
+		disp_rdma0: rdma@14006000 {
+			compatible = "mediatek,mt8189-disp-rdma";
+			reg = <0 0x14006000 0 0x1000>;
+			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_RDMA0>;
+			iommus = <&mm_iommu M4U_L0_P5_DISP_RDMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
+		};
+
+		disp_rdma1: rdma@14007000 {
+			compatible = "mediatek,mt8189-disp-rdma";
+			reg = <0 0x14007000 0 0x1000>;
+			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_RDMA1>;
+			iommus = <&mm_iommu M4U_L1_P5_DISP_RDMA1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
+		};
+
+		disp_color0: color@14008000 {
+			compatible = "mediatek,mt8189-disp-color";
+			reg = <0 0x14008000 0 0x1000>;
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_COLOR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x8000 0x1000>;
+		};
+
+		disp_color1: color@14009000 {
+			compatible = "mediatek,mt8189-disp-color";
+			reg = <0 0x14009000 0 0x1000>;
+			interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_COLOR1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
+		};
+
+		disp_ccorr0: ccorr@1400a000 {
+			compatible = "mediatek,mt8189-disp-ccorr";
+			reg = <0 0x1400a000 0 0x1000>;
+			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_CCORR0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
+		};
+
+		disp_ccorr1: ccorr@1400b000 {
+			compatible = "mediatek,mt8189-disp-ccorr";
+			reg = <0 0x1400b000  0 0x1000>;
+			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_CCORR1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
+		};
+
+		disp_ccorr2: ccorr@1400c000 {
+			compatible = "mediatek,mt8189-disp-ccorr";
+			reg = <0 0x1400c000 0 0x1000>;
+			interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_CCORR2>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
+		};
+
+		disp_ccorr3: ccorr@1400d000 {
+			compatible = "mediatek,mt8189-disp-ccorr";
+			reg = <0 0x1400d000 0 0x1000>;
+			interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_CCORR3>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
+		};
+
+		disp_aal0: aal@1400e000 {
+			compatible = "mediatek,mt8189-disp-aal";
+			reg = <0 0x1400e000 0 0x1000>;
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_AAL0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
+		};
+
+		disp_aal1: aal@1400f000 {
+			compatible = "mediatek,mt8189-disp-aal";
+			reg = <0 0x1400f000 0 0x1000>;
+			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_AAL1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
+		};
+
+		disp_gamma0: gamma@14010000 {
+			compatible = "mediatek,mt8189-disp-gamma";
+			reg = <0 0x14010000 0 0x1000>;
+			interrupts = <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_GAMMA0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
+		};
+
+		disp_gamma1: gamma@14011000 {
+			compatible = "mediatek,mt8189-disp-gamma";
+			reg = <0 0x14011000 0 0x1000>;
+			interrupts = <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_GAMMA1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
+		};
+
+		disp_dither0: dither@14012000 {
+			compatible = "mediatek,mt8189-disp-dither";
+			reg = <0 0x14012000 0 0x1000>;
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_DITHER0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
+		};
+
+		disp_dither1: dither@14013000 {
+			compatible = "mediatek,mt8189-disp-dither";
+			reg = <0 0x14013000 0 0x1000>;
+			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_DITHER1>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x3000 0x1000>;
+		};
+
+		disp_dsc_wrap0: dsc@14014000 {
+			compatible = "mediatek,mt8189-disp-dsc";
+			reg = <0 0x14014000 0 0x1000>;
+			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DISP_DSC_WRAP0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
+		};
+
+		disp_merge0: merge@14015000 {
+			compatible = "mediatek,mt8189-disp-merge";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_VPP_MERGE0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
+		};
+
+		dsi0: dsi@14016000 {
+			compatible = "mediatek,mt8189-dsi";
+			reg = <0 0x14016000 0 0x1000>;
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH 0>;
+			phys = <&mipi_tx_config0>;
+			phy-names = "dphy";
+			clocks = <&dispsys_config_clk CLK_MMSYS_0_DISP_DSI0>,
+				 <&dispsys_config_clk CLK_MMSYS_1_DISP_DSI0>,
+				 <&mipi_tx_config0>;
+			clock-names = "engine", "digital", "hs";
+			status = "disabled";
+
+			port {
+				dsi_out: endpoint { };
+			};
+		};
+
+		disp_dvo0: dvo@14017000 {
+			compatible = "mediatek,mt8189-edp-dvo";
+			reg = <0 0x14017000 0 0x1000>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MMSYS_1_DISP_DVO>,
+				 <&topckgen_clk CLK_TOP_EDP_SEL>,
+				 <&apmixedsys_clk CLK_APMIXED_TVDPLL2>,
+				 <&clk26m>,
+				 <&dispsys_config_clk CLK_MMSYS_0_DISP_DVO>;
+			clock-names = "engine",
+				      "pixel",
+				      "pll",
+				      "dvo_clk",
+				      "hf_fdvo_clk";
+			status = "disabled";
+		};
+
+		disp_dvo1: dvo@14018000 {
+			compatible = "mediatek,mt8189-dp-dvo";
+			reg = <0 0x14018000 0 0x1000>;
+			interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&dispsys_config_clk CLK_MM_DP_INTF>,
+				 <&topckgen_clk CLK_TOP_DP_SEL>,
+				 <&apmixedsys_clk CLK_APMIXED_TVDPLL1>,
+				 <&clk26m>,
+				 <&dispsys_config_clk CLK_MM_DP_INTF0>;
+			clock-names = "engine",
+				      "pixel",
+				      "pll",
+				      "dvo_clk",
+				      "hf_fdvo_clk";
+			phys = <&dp_tx>;
+			phy-names = "dp_tx";
+		};
+
+		smi_larb0: larb@1401c000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1401c000 0 0x1000>;
+			clocks = <&dispsys_config_clk CLK_MM_SMI_LARB>,
+				 <&dispsys_config_clk CLK_MM_SMI_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			mediatek,larb-id = <SMI_L0_ID>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		smi_larb1: larb@1401d000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1401d000 0 0x1000>;
+			clocks = <&dispsys_config_clk CLK_MM_SMI_LARB>,
+				 <&dispsys_config_clk CLK_MM_SMI_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_DISP>;
+			mediatek,larb-id = <SMI_L1_ID>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		imgsys1_clk: syscon@15020000 {
+			compatible = "mediatek,mt8189-imgsys1", "syscon";
+			reg = <0 0x15020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		smi_larb9: larb@1502e000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1502e000 0 0x1000>;
+			clocks = <&imgsys1_clk CLK_IMGSYS1_LARB9>,
+				 <&imgsys1_clk CLK_IMGSYS1_LARB9>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_ISP_IMG1>;
+			mediatek,larb-id = <SMI_L9_ID>;
+			mediatek,smi = <&smi_img_2x1_sub_comm>;
+		};
+
+		smi_img_2x1_sub_comm: smi@1502f000 {
+			compatible = "mediatek,mt8189-smi-sub-common";
+			reg = <0 0x1502f000 0 0x1000>;
+			clocks = <&imgsys1_clk CLK_IMGSYS1_LARB9>,
+				 <&imgsys1_clk CLK_IMGSYS1_LARB11>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_ISP_IMG1>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		imgsys2_clk: syscon@15820000 {
+			compatible = "mediatek,mt8189-imgsys2", "syscon";
+			reg = <0 0x15820000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		smi_larb11: larb@1582e000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1582e000 0 0x1000>;
+			/* larb11 uses larb9's clk */
+			clocks = <&imgsys2_clk CLK_IMGSYS2_LARB9>,
+				 <&imgsys2_clk CLK_IMGSYS2_LARB9>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_ISP_IMG2>;
+			mediatek,larb-id = <SMI_L11_ID>;
+			mediatek,smi = <&smi_img_2x1_sub_comm>;
+		};
+
+		vdec: video-codec@16000000 {
+			compatible = "mediatek,mt8189-vcodec-dec";
+			reg = <0 0x16000000 0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0 0 0 0x16000000 0 0x26000>;
+			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+			iommus = <&mm_iommu M4U_L4_P0_HW_VDEC_MC_EXT>;
+			mediatek,scp = <&scp>;
+
+			vcodec_core: video-codec@16025000 {
+				compatible = "mediatek,mtk-vcodec-core";
+				reg = <0 0x25000 0 0x1000>;
+				iommus = <&mm_iommu M4U_L4_P0_HW_VDEC_MC_EXT>,
+					 <&mm_iommu M4U_L4_P1_HW_VDEC_UFO_EXT>,
+					 <&mm_iommu M4U_L4_P2_HW_VDEC_PP_EXT>,
+					 <&mm_iommu M4U_L4_P3_HW_VDEC_PRED_RD_EXT>,
+					 <&mm_iommu M4U_L4_P4_HW_VDEC_PRED_WR_EXT>,
+					 <&mm_iommu M4U_L4_P5_HW_VDEC_PPWRAP_EXT>,
+					 <&mm_iommu M4U_L4_P6_HW_VDEC_TILE_EXT>,
+					 <&mm_iommu M4U_L4_P7_HW_VDEC_VLD_EXT>,
+					 <&mm_iommu M4U_L4_P8_HW_VDEC_VLD2_EXT>,
+					 <&mm_iommu M4U_L4_P9_HW_VDEC_AVC_MV_EXT>,
+					 <&mm_iommu M4U_L4_P10_HW_VDEC_RG_CTRL_DMA_EXT>,
+					 <&mm_iommu M4U_L4_P11_HW_VDEC_UFO_ENC_EXT>;
+				interrupts = <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&vdec_core_clk CLK_VDEC_CORE_VDEC_CKEN>,
+					 <&vdec_core_clk CLK_VDEC_CORE_LARB_CKEN>;
+				clock-names = "soc-vdec", "vdec";
+				assigned-clocks = <&topckgen_clk CLK_TOP_VDEC_SEL>;
+				assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D4>;
+				power-domains = <&spm MT8189_POWER_DOMAIN_VDE0>;
+			};
+		};
+
+		smi_larb4: larb@1602e000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1602e000 0 0x1000>;
+			clocks = <&vdec_core_clk CLK_VDEC_CORE_LARB_CKEN>,
+				 <&vdec_core_clk CLK_VDEC_CORE_LARB_CKEN>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_VDE0>;
+			mediatek,larb-id = <SMI_L4_ID>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		vdec_core_clk: syscon@1602f000 {
+			compatible = "mediatek,mt8189-vdec-core", "syscon";
+			reg = <0 0x1602f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		venc_gcon_clk: syscon@17000000 {
+			compatible = "mediatek,mt8189-venc", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		smi_larb7: larb@17010000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			clocks = <&venc_gcon_clk CLK_VEN1_CKE0_LARB>,
+				 <&venc_gcon_clk CLK_VEN1_CKE0_LARB>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_VEN0>;
+			mediatek,larb-id = <SMI_L7_ID>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		venc: video-codec@17020000 {
+			compatible = "mediatek,mt8189-vcodec-enc";
+			reg = <0 0x17020000 0 0x6000>;
+			interrupts = <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&mm_iommu M4U_L7_P0_VENC_RCPU>,
+				 <&mm_iommu M4U_L7_P1_VENC_REC>,
+				 <&mm_iommu M4U_L7_P2_VENC_BSDMA>,
+				 <&mm_iommu M4U_L7_P3_VENC_SV_COMV>,
+				 <&mm_iommu M4U_L7_P4_VENC_RD_COMV>,
+				 <&mm_iommu M4U_L7_P8_VENC_SUB_W_LUMA>,
+				 <&mm_iommu M4U_L7_P10_VENC_CUR_LUMA>,
+				 <&mm_iommu M4U_L7_P11_VENC_CUR_CHROMA>,
+				 <&mm_iommu M4U_L7_P12_VENC_REF_LUMA>,
+				 <&mm_iommu M4U_L7_P13_VENC_REF_CHROMA>,
+				 <&mm_iommu M4U_L7_P14_VENC_SUB_R_LUMA>;
+			clocks = <&venc_gcon_clk CLK_VEN1_CKE1_VENC>;
+			clock-names = "venc_sel";
+			assigned-clocks = <&topckgen_clk CLK_TOP_VENC_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_UNIVPLL_D4>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_VEN0>;
+			mediatek,scp = <&scp>;
+		};
+
+		jpeg_encoder: jpeg-encoder@17030000 {
+			compatible = "mediatek,mt8189-jpgenc", "mediatek,mtk-jpgenc";
+			reg = <0 0x17030000 0 0x10000>;
+			interrupts = <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&venc_gcon_clk CLK_VEN1_CKE2_JPGENC>;
+			clock-names = "jpgenc";
+			power-domains = <&spm MT8189_POWER_DOMAIN_VEN0>;
+			mediatek,larb = <&smi_larb7>;
+			iommus = <&mm_iommu M4U_L7_P5_JPGENC_Y_RDMA>,
+				 <&mm_iommu M4U_L7_P6_JPGENC_C_RDMA>,
+				 <&mm_iommu M4U_L7_P7_JPGENC_Q_RDMA>,
+				 <&mm_iommu M4U_L7_P9_JPGENC_BSDMA>;
+		};
+
+		jpeg_decoder: jpeg-decoder@17040000 {
+			compatible = "mediatek,mt8189-jpgdec", "mediatek,mt2701-jpgdec";
+			reg = <0 0x17040000 0 0x10000>;
+			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&venc_gcon_clk CLK_VEN1_CKE3_JPGDEC>;
+			clock-names = "jpgdec";
+			power-domains = <&spm MT8189_POWER_DOMAIN_VEN0>;
+			mediatek,larb = <&smi_larb7>;
+			iommus = <&mm_iommu M4U_L7_P15_JPGDEC_WDMA>,
+				 <&mm_iommu M4U_L7_P16_JPGDEC_BSDMA>,
+				 <&mm_iommu M4U_L7_P17_JPGDEC_HUFF_OFFSET>;
+		};
+
+		apu_iommu: iommu@19010000 {
+			compatible = "mediatek,mt8189-iommu-apu";
+			reg = <0 0x19010000 0 0x1000>;
+			interrupts = <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+		};
+
+		camsys_main_clk: syscon@1a000000 {
+			compatible = "mediatek,mt8189-camsys-main", "syscon";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		smi_larb13: larb@1a001000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1a001000 0 0x1000>;
+			clocks = <&camsys_main_clk CLK_CAM_M_LARB13>,
+				 <&camsys_main_clk CLK_CAM_M_LARB13>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_CAM_MAIN>;
+			mediatek,larb-id = <SMI_L13_ID>;
+			mediatek,smi = <&smi_cam_4x1_sub_comm>;
+		};
+
+		smi_larb14: larb@1a002000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1a002000 0 0x1000>;
+			clocks = <&camsys_main_clk CLK_CAM_M_LARB14>,
+				 <&camsys_main_clk CLK_CAM_M_LARB14>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_CAM_MAIN>;
+			mediatek,larb-id = <SMI_L14_ID>;
+			mediatek,smi = <&smi_cam_3x1_sub_comm>;
+		};
+
+		smi_cam_3x1_sub_comm: smi@1a00c000 {
+			compatible = "mediatek,mt8189-smi-sub-common";
+			reg = <0 0x1a00c000 0 0x1000>;
+			clocks = <&camsys_main_clk CLK_CAM_M_CAM2MM_GALS>,
+				 <&camsys_main_clk CLK_CAM_M_CAM2MM_GALS>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_CAM_MAIN>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		smi_cam_4x1_sub_comm: smi@1a00d000 {
+			compatible = "mediatek,mt8189-smi-sub-common";
+			reg = <0 0x1a00d000 0 0x1000>;
+			clocks = <&camsys_main_clk CLK_CAM_M_CAM2MM_GALS>,
+				 <&camsys_main_clk CLK_CAM_M_CAM2MM_GALS>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_CAM_MAIN>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		smi_larb16: larb@1a00f000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1a00f000 0 0x1000>;
+			clocks = <&camsys_rawa_clk CLK_CAM_RA_CAMSYS_RAWA_LARBX>,
+				 <&camsys_rawa_clk CLK_CAM_RA_CAMSYS_RAWA_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_CAM_SUBA>;
+			mediatek,larb-id = <SMI_L16_ID>;
+			mediatek,smi = <&smi_cam_3x1_sub_comm>;
+		};
+
+		smi_larb17: larb@1a010000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1a010000 0 0x1000>;
+			clocks = <&camsys_rawb_clk CLK_CAM_RB_CAMSYS_RAWB_LARBX>,
+				 <&camsys_rawb_clk CLK_CAM_RB_CAMSYS_RAWB_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_CAM_SUBB>;
+			mediatek,larb-id = <SMI_L17_ID>;
+			mediatek,smi = <&smi_cam_4x1_sub_comm>;
+		};
+
+		camsys_rawa_clk: syscon@1a04f000 {
+			compatible = "mediatek,mt8189-camsys-rawa", "syscon";
+			reg = <0 0x1a04f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys_rawb_clk: syscon@1a06f000 {
+			compatible = "mediatek,mt8189-camsys-rawb", "syscon";
+			reg = <0 0x1a06f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		ipesys_clk: syscon@1b000000 {
+			compatible = "mediatek,mt8189-ipesys", "syscon";
+			reg = <0 0x1b000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		smi_ipe_2x1_sub_comm: smi@1b00e000 {
+			compatible = "mediatek,mt8189-smi-sub-common";
+			reg = <0 0x1b00e000 0 0x1000>;
+			clocks = <&ipesys_clk CLK_IPE_SMI_SUBCOM>,
+				 <&ipesys_clk CLK_IPESYS_GALS>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_ISP_IPE>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		smi_larb19: larb@1b10f000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1b10f000 0 0x1000>;
+			clocks = <&ipesys_clk CLK_IPE_LARB19>,
+				 <&ipesys_clk CLK_IPE_LARB19>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_ISP_IPE>;
+			mediatek,larb-id = <SMI_L19_ID>;
+			mediatek,smi = <&smi_ipe_2x1_sub_comm>;
+		};
+
+		smi_larb20: larb@1b00f000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1b00f000 0 0x1000>;
+			clocks = <&ipesys_clk CLK_IPE_LARB20>,
+				 <&ipesys_clk CLK_IPE_LARB20>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_ISP_IPE>;
+			mediatek,larb-id = <SMI_L20_ID>;
+			mediatek,smi = <&smi_ipe_2x1_sub_comm>;
+		};
+
+		vlpcfg_ao_reg_clk: syscon@1c000800 {
+			compatible = "mediatek,mt8189-vlp-ao", "syscon";
+			reg = <0 0x1c000800 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		scpsys: syscon@1c001000 {
+			compatible = "mediatek,mt8189-scpsys", "syscon", "simple-mfd";
+			reg = <0 0x1c001000 0 0x1000>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8189-power-controller";
+				mfg0-supply = <&mt6359_vproc1_buck_reg>;
+				mfg1-supply = <&mt6359_vsram_proc1_ldo_reg>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				power-domain@MT8189_POWER_DOMAIN_CONN {
+					reg = <MT8189_POWER_DOMAIN_CONN>;
+					mediatek,infracfg = <&infracfg_ao_clk>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_AUDIO {
+					reg = <MT8189_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen_clk CLK_TOP_AUD_INTBUS_SEL>;
+					clock-names = "audio";
+					mediatek,infracfg = <&infracfg_ao_clk>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_ADSP_AO {
+					reg = <MT8189_POWER_DOMAIN_ADSP_AO>;
+					clocks = <&vlp_cksys_clk CLK_VLP_CK_VADSP_SEL>;
+					clock-names = "vadsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8189_POWER_DOMAIN_ADSP_INFRA {
+						reg = <MT8189_POWER_DOMAIN_ADSP_INFRA>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT {
+							reg = <MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_MM_INFRA {
+					reg = <MT8189_POWER_DOMAIN_MM_INFRA>;
+					clocks = <&topckgen_clk CLK_TOP_MMINFRA_SEL>,
+						 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+					clock-names = "mminfra", "ss-mminfra";
+					mediatek,infracfg = <&infracfg_ao_clk>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8189_POWER_DOMAIN_ISP_IMG1 {
+						reg = <MT8189_POWER_DOMAIN_ISP_IMG1>;
+						clocks = <&topckgen_clk CLK_TOP_IMG1_SEL>,
+							 <&imgsys1_clk CLK_IMGSYS1_LARB9>,
+							 <&imgsys1_clk CLK_IMGSYS1_LARB11>,
+							 <&imgsys1_clk CLK_IMGSYS1_GALS>;
+						clock-names = "img1", "ss-img1-0", "ss-img1-1", "ss-img1-2";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8189_POWER_DOMAIN_ISP_IMG2 {
+							reg = <MT8189_POWER_DOMAIN_ISP_IMG2>;
+							clocks = <&imgsys2_clk CLK_IMGSYS2_LARB9>,
+								 <&imgsys2_clk CLK_IMGSYS2_LARB11>,
+								 <&imgsys2_clk CLK_IMGSYS2_GALS>;
+							clock-names = "ss-img2-0", "ss-img2-1", "ss-img2-2";
+							#power-domain-cells = <0>;
+						};
+					};
+
+					power-domain@MT8189_POWER_DOMAIN_ISP_IPE {
+						reg = <MT8189_POWER_DOMAIN_ISP_IPE>;
+						clocks = <&topckgen_clk CLK_TOP_IPE_SEL>,
+							 <&ipesys_clk CLK_IPE_LARB19>,
+							 <&ipesys_clk CLK_IPE_LARB20>,
+							 <&ipesys_clk CLK_IPE_SMI_SUBCOM>,
+							 <&ipesys_clk CLK_IPESYS_GALS>;
+						clock-names = "ipe", "ss-ipe0", "ss-ipe1", "ss-ipe2", "ss-ipe3";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8189_POWER_DOMAIN_VDE0 {
+						reg = <MT8189_POWER_DOMAIN_VDE0>;
+						clocks = <&topckgen_clk CLK_TOP_VDEC_SEL>,
+							 <&vdec_core_clk CLK_VDEC_CORE_LARB_CKEN>;
+						clock-names = "vdec", "ss-vdec";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8189_POWER_DOMAIN_VEN0 {
+						reg = <MT8189_POWER_DOMAIN_VEN0>;
+						clocks = <&topckgen_clk CLK_TOP_VENC_SEL>,
+							 <&venc_gcon_clk CLK_VEN1_CKE0_LARB>;
+						clock-names = "venc", "ss-venc";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8189_POWER_DOMAIN_CAM_MAIN {
+						reg = <MT8189_POWER_DOMAIN_CAM_MAIN>;
+						clocks = <&topckgen_clk CLK_TOP_CAM_SEL>,
+							 <&camsys_main_clk CLK_CAM_M_LARB13>,
+							 <&camsys_main_clk CLK_CAM_M_LARB14>,
+							 <&camsys_main_clk CLK_CAM_M_CAM2MM_GALS>;
+						clock-names = "cam", "ss-cam0", "ss-cam1", "ss-cam2";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8189_POWER_DOMAIN_CAM_SUBA {
+							reg = <MT8189_POWER_DOMAIN_CAM_SUBA>;
+							clocks = <&camsys_rawa_clk CLK_CAM_RA_CAMSYS_RAWA_LARBX>;
+							clock-names = "ss-cam-suba";
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8189_POWER_DOMAIN_CAM_SUBB {
+							reg = <MT8189_POWER_DOMAIN_CAM_SUBB>;
+							clocks = <&camsys_rawb_clk CLK_CAM_RB_CAMSYS_RAWB_LARBX>;
+							clock-names = "ss-cam-subb";
+							#power-domain-cells = <0>;
+						};
+					};
+
+					power-domain@MT8189_POWER_DOMAIN_MDP0 {
+						reg = <MT8189_POWER_DOMAIN_MDP0>;
+						clocks = <&topckgen_clk CLK_TOP_MDP0_SEL>,
+							 <&mdpsys_config_clk CLK_MDP_SMI0>;
+						clock-names = "mdp", "ss-mdp";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8189_POWER_DOMAIN_DISP {
+						reg = <MT8189_POWER_DOMAIN_DISP>;
+						clocks = <&topckgen_clk CLK_TOP_DISP0_SEL>,
+							 <&dispsys_config_clk CLK_MM_SMI_LARB>;
+						clock-names = "disp", "ss-disp";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8189_POWER_DOMAIN_DP_TX {
+							reg = <MT8189_POWER_DOMAIN_DP_TX>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8189_POWER_DOMAIN_EDP_TX_DORMANT {
+								reg = <MT8189_POWER_DOMAIN_EDP_TX_DORMANT>;
+								#power-domain-cells = <0>;
+							};
+						};
+					};
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_CSI_RX {
+					reg = <MT8189_POWER_DOMAIN_CSI_RX>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_SSUSB {
+					reg = <MT8189_POWER_DOMAIN_SSUSB>;
+					mediatek,infracfg = <&infracfg_ao_clk>;
+					#power-domain-cells = <0>;
+				};
+
+				mfg0: power-domain@MT8189_POWER_DOMAIN_MFG0 {
+					reg = <MT8189_POWER_DOMAIN_MFG0>;
+					clocks = <&apmixedsys_clk CLK_APMIXED_MFGPLL>;
+					clock-names = "mfg_top";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					mfg1: power-domain@MT8189_POWER_DOMAIN_MFG1 {
+						reg = <MT8189_POWER_DOMAIN_MFG1>;
+						clocks = <&topckgen_clk CLK_TOP_MFG_REF_SEL>;
+						clock-names = "mfg";
+						mediatek,infracfg = <&infracfg_ao_clk>;
+						mediatek,smi = <&emicfg_ao_mem_clk>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8189_POWER_DOMAIN_MFG2 {
+							reg = <MT8189_POWER_DOMAIN_MFG2>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8189_POWER_DOMAIN_MFG3 {
+							reg = <MT8189_POWER_DOMAIN_MFG3>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_PCIE {
+					reg = <MT8189_POWER_DOMAIN_PCIE>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8189_POWER_DOMAIN_PCIE_PHY {
+						reg = <MT8189_POWER_DOMAIN_PCIE_PHY>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+
+		watchdog: watchdog@1c00a000 {
+			compatible = "mediatek,mt8188-wdt", "mediatek,mt6589-wdt";
+			reg = <0 0x1c00a000 0 0x1000>;
+			#reset-cells = <1>;
+		};
+
+		vlpcfg_reg_bus_clk: syscon@1c00c000 {
+			compatible = "mediatek,mt8189-vlpcfg-ao", "syscon";
+			reg = <0 0x1c00c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		dvfsrc_top_clk: syscon@1c00f000 {
+			compatible = "mediatek,mt8189-dvfsrc-top", "syscon";
+			reg = <0 0x1c00f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vlp_cksys_clk: syscon@1c012000 {
+			compatible = "mediatek,mt8189-vlpckgen", "syscon";
+			reg = <0 0x1c012000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		devapc_vlp: devapc@1c01c000 {
+			compatible = "mediatek,mt8189-devapc";
+			reg = <0 0x1c01c000 0 0x1000>,
+			      <0 0x1c018000 0 0x1000>; /* vlp ao/pd */
+			vio-idx-num = <62>;
+			interrupts = <GIC_SPI 542 IRQ_TYPE_LEVEL_HIGH 0>; /* vlp irq */
+		};
+
+		sram@1c350000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x1c350000 0x0 0x80>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x1c350000 0x80>;
+
+			scmi_tx_shmem: mailbox-sram@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x80>;
+			};
+		};
+
+		tinysys_mbox: mailbox@1c351000 {
+			compatible = "mediatek,tinysys_mbox";
+			reg = <0 0x1c351000 0 0x1000>,
+			      <0 0x1c361000 0 0x1000>;
+			/* for profiling */
+			shmem = <&scmi_tx_shmem>, <&scmi_rx_shmem>;
+			interrupts = <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 510 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+			/* notify spm clr */
+			secure-sspm-md2spm-clr = <1>;
+		};
+
+		sram@1c360000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x1c360000 0x0 0x80>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x1c360000 0x80>;
+
+			scmi_rx_shmem: mailbox-sram@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x80>;
+			};
+		};
+
+		scp: scp@1c400000 {
+			compatible = "mediatek,mt8189-scp";
+			reg = <0 0x1c400000 0 0x60000>,
+			      <0 0x1cb20000 0 0xe0000>;
+			reg-names = "sram", "cfg";
+			interrupts = <GIC_SPI 516 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&vlp_cksys_clk CLK_VLP_CK_SCP_SEL>;
+			clock-names = "scp_sel";
+			status = "disabled";
+		};
+
+		scp_iic_clk: syscon@1c80ae10 {
+			compatible = "mediatek,mt8189-scp-i2c-clk", "syscon";
+			reg = <0 0x1c80ae10 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		scp_clk: syscon@1cb21150 {
+			compatible = "mediatek,mt8189-scp-clk", "syscon";
+			reg = <0 0x1cb21150 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		pwrap: pwrap@1cc04000 {
+			compatible = "mediatek,mt8189-pwrap", "mediatek,mt8195-pwrap", "syscon";
+			reg = <0 0x1cc04000 0 0x1000>;
+			reg-names = "pwrap";
+			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks =  <&vlpcfg_reg_bus_clk CLK_VLPCFG_REG_PMIF_SPMI_M_SYS>,
+				  <&vlpcfg_reg_bus_clk CLK_VLPCFG_REG_PMIF_SPMI_M_TMR>;
+			clock-names = "spi", "wrap";
+			assigned-clocks = <&vlp_cksys_clk CLK_VLP_CK_PWRAP_ULPOSC_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_OSC_D10>;
+		};
+
+		spmi: spmi@1cc06000 {
+			compatible = "mediatek,mt8189-spmi", "mediatek,mt8195-spmi";
+			reg = <0 0x1cc06000 0 0x0008ff>,
+			      <0 0x1cc00000 0 0x000100>;
+			reg-names = "pmif", "spmimst";
+			clocks = <&vlpcfg_reg_bus_clk CLK_VLPCFG_REG_PMIF_SPMI_P_SYS>,
+				 <&vlpcfg_reg_bus_clk CLK_VLPCFG_REG_PMIF_SPMI_P_TMR>,
+				 <&vlp_cksys_clk CLK_VLP_CK_SPMI_P_MST_SEL>;
+			clock-names = "pmif_sys_ck", "pmif_tmr_ck", "spmimst_clk_mux";
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		systimer: timer@1cc10000 {
+			compatible = "mediatek,mt8189-timer","mediatek,mt6765-timer";
+			reg = <0 0x1cc10000 0 0x1000>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk13m>;
+		};
+
+		vadsys_clk: syscon@1e010000 {
+			compatible = "mediatek,mt8189-vadsys", "syscon";
+			reg = <0 0x1e010000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		devapc_adsp: devapc@1e019000 {
+			compatible = "mediatek,mt8189-devapc";
+			reg = <0 0x1e019000 0 0x1000>,
+			      <0 0x1e340000 0 0x1000>; /* adsp ao/pd */
+			vio-idx-num = <44>;
+			interrupts = <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>; /* adsp irq */
+			status = "disabled";
+		};
+
+		mminfra {
+			compatible = "mediatek,mt8189-mminfra";
+			clocks = <&mminfra_config_clk CLK_MMINFRA_GCE_D>,
+				 <&mminfra_config_clk CLK_MMINFRA_GCE_M>,
+				 <&mminfra_config_clk CLK_MMINFRA_GCE_26M>;
+			clock-names = "gce_d", "gce_m", "gce_26m";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+			mediatek,mminfra = <&mminfra_config_clk>;
+		};
+
+		mminfra_config_clk: syscon@1e800000 {
+			compatible = "mediatek,mt8189-mm-infra", "syscon";
+			reg = <0 0x1e800000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		smi_disp_common: smi@1e801000 {
+			compatible = "mediatek,mt8189-smi-common";
+			reg = <0 0x1e801000 0 0x1000>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>,
+				 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+		};
+
+		mm_iommu: iommu@1e802000 {
+			compatible = "mediatek,mt8189-iommu-mm";
+			reg = <0 0x1e802000 0 0x5000>;
+			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "bclk";
+			#iommu-cells = <1>;
+			mediatek,larbs = <&smi_larb0 &smi_larb1 &smi_larb2 &smi_larb4 &smi_larb7
+					  &smi_larb9 &smi_larb11 &smi_larb13 &smi_larb14
+					  &smi_larb16 &smi_larb17 &smi_larb19 &smi_larb20>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+		};
+
+		disp_ssc0_smi_2x1_sub_comm: smi@1e807000 {
+			compatible = "mediatek,mt8189-smi-common";
+			reg = <0 0x1e807000 0 0x1000>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>,
+				 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+		};
+
+		disp_ssc1_smi_2x1_sub_comm: smi@1e808000 {
+			compatible = "mediatek,mt8189-smi-common";
+			reg = <0 0x1e808000 0 0x1000>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>,
+				 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+		};
+
+		mminfra_smi_3x1_sub_comm: smi@1e809000 {
+			compatible = "mediatek,mt8189-smi-sub-common";
+			reg = <0 0x1e809000 0 0x1000>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>,
+				 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		mminfra_smi_2x1_sub_comm: smi@1e80a000 {
+			compatible = "mediatek,mt8189-smi-sub-common";
+			reg = <0 0x1e80a000 0 0x1000>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_SMI>,
+				 <&mminfra_config_clk CLK_MMINFRA_SMI>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		devapc_mminfra: devapc@1e826000 {
+			compatible = "mediatek,mt8189-devapc";
+			reg = <0 0x1e826000 0 0x1000>,
+			      <0 0x1e820000 0 0x1000>; /* mminfra ao/pd */
+			vio-idx-num = <304>;
+			interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH 0>; /* mminfra irq */
+		};
+
+		gce: gce@1e980000 {
+			compatible = "mediatek,mt8189-gce";
+			reg = <0 0x1e980000 0 0x4000>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_GCE_D>,
+				 <&mminfra_config_clk CLK_MMINFRA_GCE_26M>;
+			clock-names = "gce0", "gce-timer";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+		};
+
+		gce_d_clk: syscon@1e9800f0 {
+			compatible = "mediatek,mt8189-gce-d", "syscon";
+			reg = <0 0x1e9800f0 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		gce_m: gce@1e990000 {
+			compatible = "mediatek,mt8189-gce";
+			reg = <0 0x1e990000 0 0x4000>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+			clocks = <&mminfra_config_clk CLK_MMINFRA_GCE_M>,
+				 <&mminfra_config_clk CLK_MMINFRA_GCE_26M>;
+			clock-names = "gce1", "gce-timer";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MM_INFRA>;
+		};
+
+		gce_m_clk: syscon@1e9900f0 {
+			compatible = "mediatek,mt8189-gce-m", "syscon";
+			reg = <0 0x1e9900f0 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		mdpsys_config_clk: syscon@1f000100 {
+			compatible = "mediatek,mt8189-mdpsys", "syscon";
+			reg = <0 0x1f000100 0 0x20>;
+			#clock-cells = <1>;
+		};
+
+		smi_larb2: larb@1f002000 {
+			compatible = "mediatek,mt8189-smi-larb";
+			reg = <0 0x1f002000 0 0x1000>;
+			clocks = <&mdpsys_config_clk CLK_MDP_SMI0>,
+				 <&mdpsys_config_clk CLK_MDP_SMI0>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8189_POWER_DOMAIN_MDP0>;
+			mediatek,larb-id = <SMI_L2_ID>;
+			mediatek,smi = <&smi_disp_common>;
+		};
+
+		thermal_zones: thermal-zones {
+
+			cpu0-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_BIG_CPU1>;
+				sustainable-power = <1200>;
+				trips {
+					cpu0_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu0_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu0_crit: trip-crit {
+						temperature = <115000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu0_alert>;
+						cooling-device =
+							<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <1024>;
+					};
+
+				};
+			};
+
+			cpu1-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_BIG_CPU2>;
+				sustainable-power = <1200>;
+				trips {
+					cpu1_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu1_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu1_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu1_alert>;
+						cooling-device =
+							<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <1024>;
+					};
+				};
+			};
+
+			cpu2-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_BIG_CPU3>;
+				sustainable-power = <1200>;
+				trips {
+					cpu2_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu2_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu2_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu2_alert>;
+						cooling-device =
+							<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <1024>;
+					};
+				};
+			};
+
+			cpu3-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_BIG_CPU4>;
+				sustainable-power = <1200>;
+				trips {
+					cpu3_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu3_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu3_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu3_alert>;
+						cooling-device =
+							<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <1024>;
+					};
+				};
+			};
+
+			cpu4-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU1>;
+				sustainable-power = <1200>;
+				trips {
+					cpu4_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu4_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu4_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu4_alert>;
+						cooling-device =
+							<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <1024>;
+					};
+				};
+			};
+
+			cpu5-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU2>;
+				sustainable-power = <1200>;
+				trips {
+					cpu5_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu5_alert: target@1 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu5_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu5_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <2345>;
+					};
+				};
+			};
+
+			cpu6-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU3>;
+				sustainable-power = <1200>;
+				trips {
+					cpu6_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu6_alert: target@1 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu6_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu6_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <2345>;
+					};
+				};
+			};
+
+			cpu7-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU4>;
+				sustainable-power = <1200>;
+				trips {
+					cpu7_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu7_alert: target@1 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu7_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&cpu7_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <2345>;
+					};
+				};
+			};
+
+			cpu8-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU5>;
+				sustainable-power = <1200>;
+				trips {
+					cpu8_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu8_alert: target@1 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu8_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&cpu8_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <2345>;
+					};
+				};
+			};
+
+			cpu9-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU6>;
+				sustainable-power = <1200>;
+				trips {
+					cpu_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu9_alert: target@1 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu9_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&cpu9_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <2345>;
+					};
+				};
+			};
+
+			cpu10-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU7>;
+				sustainable-power = <1200>;
+				trips {
+					cpu10_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu10_alert: target@1 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu10_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&cpu10_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <2345>;
+					};
+				};
+			};
+
+			cpu11-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_mcu MT8189_MCU_LITTLE_CPU8>;
+				sustainable-power = <1200>;
+				trips {
+					cpu11_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu11_alert: target@1 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					cpu11_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map0 {
+						trip = <&cpu11_alert>;
+						cooling-device =
+							<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <2345>;
+					};
+				};
+			};
+
+			soc1-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_ap MT8189_AP_SOC1>;
+				sustainable-power = <1200>;
+				trips {
+					soc1_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					soc1_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					soc1_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+			};
+
+			soc2-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_ap MT8189_AP_SOC2>;
+				sustainable-power = <1200>;
+				trips {
+					soc2_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					soc2_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					soc2_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+			};
+
+			soc3-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_ap MT8189_AP_SOC3>;
+				sustainable-power = <1200>;
+				trips {
+					soc3_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					soc3_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					soc3_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+			};
+
+			apu-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_ap MT8189_AP_APU>;
+				sustainable-power = <1200>;
+				trips {
+					apu_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					apu_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					apu_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+			};
+
+			gpu1-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_ap MT8189_AP_GPU1>;
+				sustainable-power = <1200>;
+				trips {
+					gpu1_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					gpu1_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					gpu1_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&gpu1_alert>;
+						cooling-device =
+							<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <1134>;
+					};
+				};
+			};
+
+			gpu2-thermal {
+				polling-delay = <200>; /* milliseconds */
+				polling-delay-passive = <100>; /* milliseconds */
+				thermal-sensors = <&lvts_ap MT8189_AP_GPU2>;
+				sustainable-power = <1200>;
+				trips {
+					gpu2_threshold: trip-point@0 {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					gpu2_alert: target@1 {
+						temperature = <85000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
+					gpu2_crit: trip-crit {
+						temperature = <119000>;
+						hysteresis = <2000>;
+						type = "critical";
+					};
+				};
+				cooling-maps {
+					map0 {
+						trip = <&gpu2_alert>;
+						cooling-device =
+							<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						contribution = <1134>;
+					};
+				};
+			};
+		};
+
+		emiisu {
+			compatible = "mediatek,common-emiisu";
+			ctrl-intf = <1>;
+		};
+	};
+};
-- 
2.45.2


