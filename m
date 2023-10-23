Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE47D39E1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 16:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJWOmv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjJWOmZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 10:42:25 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C11995
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 07:41:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-778a92c06d6so207932485a.2
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072082; x=1698676882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=595ulVabtRF3llgdI31WX9Gdt75QPCMf8//5psjHRtY=;
        b=E7WQftWV2HtplcHnThsPfiEbyT0xzaPnCtyYrd/crZIe0XSwyAYT2KReoZ5bH/CbF8
         RgCQiQNHGb7yf+33/OVVtFqE6izA3NVMrD8pAzWwW2EyWWhUNqvvQXj+jZZ/BgZqHdLo
         NJ1T56Bso06T3+4k5NlnA0GsOTMYMP50WgzP6IzcwevViXkdrtmcPfhDDb0xd/k9bFTg
         mBQJes+kSpHoNsav5OPHEfNMbIScZkCrWKA8Uhu1ZiLXyyRRmDxwO2RWFQRUlX6W5EIs
         s/u3tpltdWkHMZFnjesOYV5LuewrAZ5OGXvGhjrvdQ/UVzyumepVoCVeOL/BaLCen2MG
         YlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072082; x=1698676882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=595ulVabtRF3llgdI31WX9Gdt75QPCMf8//5psjHRtY=;
        b=hxQtu0iiPhq3Dw/lX2bTcA6UXI8aG841npXdXccKx/4RtSkNqMEsgz964GxYl3T4lw
         Bbixw7P1LgiA4CH1Euf+vKGT7ZrWeMkjBUp6gAWTTBnMvjC2kn9T8KY/9jygynH6Coi2
         HkfTr7RYSYVHy32p2k09W6zpPGqkti9rwogPhRyr5IkXqgtLzAWdphDGQhgj02x90Jgx
         4RPgQEJOk5E6u1FhNYQ+bq01PopBLwhrg4D2+NgEiX0rrrqmwXlngg0zI5foNMlheOO5
         o0Kj7tvdzQtFhrp8bnsr6HYbrNTSSGBh+WSCwCF1d4dMcl7ksVvRRq86qecDJ/ZxS5Hs
         jeRQ==
X-Gm-Message-State: AOJu0Yy5HldpQz05pQGGtMw2ALbz4pVpSS/x1O2YBMa8a00lYzV/xD81
        kiao/qoaO6RC4vQNJi7iR0l2Ig==
X-Google-Smtp-Source: AGHT+IEcl8tn7kc5yak43uDO4NKC4OFhGJ1HhbnGe+skc/PMjn6o3r+j8Un5vwm66cBdZQOBlHJ8Rw==
X-Received: by 2002:a05:620a:bc9:b0:76e:f62e:45cc with SMTP id s9-20020a05620a0bc900b0076ef62e45ccmr9656082qki.32.1698072081572;
        Mon, 23 Oct 2023 07:41:21 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:41:21 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:18 +0200
Subject: [PATCH 18/18] arm64: dts: mediatek: add display support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-18-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6023; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=pcJBtWjpwilqxNWOakxNZQwRB91WeJf0Sg90BfqV228=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPkea0Zqy/PQcdnRsfgCu3AEXfk7wmG8tbv9W6
 6/bMYLmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURSDAEA
 CQA7Cf4KSXMTBTFLJLDn3nVGt/R5YFfqc4INXDjm6cldZkidaTUTKIifrfDCxHp1r0Ja/JaBxMYzh0
 pHhJvAuYtIecogTkNQHbTaEPok1TVVQBfaC39ZpgywxOcQ5R4V5wmk3JZo7ZSibtsAgR+NsmIDQXD1
 gMcHUflijw+a1lUpZ3wIGoCtZbrP/M+Gas8r4P6vb7YOIEP4kFZinEF+hPfGadJ7SAzsKKeOS2Am2q
 tiiB2z92LubE4muqkhtO4YRYBrSLpNkF52xFJfMkp8uweHjtZr8PCrr8AsRMr3ktLamN03DP1LKDDj
 2FzODsOY5xZ9SxTdcO5ktlVOW9oyereFUcwssEjDOSm3KneJeNTPngCGOdk+cxVYvKD05XG7WmxJLx
 Uk6KmO2qNJkS3JSRK6PRltlbvAk3zvHerOVqe1ytnDco6jzVC8hdmhQkOKGLl9l7wUGt93yBAFYYBA
 3UUUwXMvgprT3kjgAmhG1P0utomkLEv00dx3r7MhZEFIkKAo++sOZspVHKQNkmAe6HtWJ7Qe24ZjPg
 lqqmS2yVrDfBExc1i7WvB4nAC0RpGxnkLTV4AjGMsXk0sTh76HJXEAGlACHyNPpd5V+zTZ6z6cXVdq
 MPQDooC/3O8BIsyi+aQiGQNxmm8cZQnAU/HDVEjWBR0A6OWhBeZxaSBmuYrQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

MIPI DSI:
- Add "vsys_lcm_reg" regulator support and setup the "mt6357_vsim1_reg",
to power the pannel plugged to the DSI connector.
- Setup the Display Parallel Interface.
  - Add the startek kd070fhfid015 pannel support.

HDMI:
- Add HDMI connector support.
- Add the "ite,it66121" HDMI bridge support, driven by I2C1.
- Setup the Display Parallel Interface.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 183 ++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 50cbaefa1a99..823d7623b8b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -26,6 +26,18 @@ chosen {
 		stdout-path = "serial0:921600n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "d";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
+
 	firmware {
 		optee {
 			compatible = "linaro,optee-tz";
@@ -86,6 +98,57 @@ optee_reserved: optee@43200000 {
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
 	};
+
+	vsys_lcm_reg: regulator-vsys-lcm {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&pio 129 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vsys_lcm";
+	};
+};
+
+&dpi0 {
+	pinctrl-0 = <&dpi_default_pins>;
+	pinctrl-1 = <&dpi_idle_pins>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
+};
+
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "startek,kd070fhfid015";
+		status = "okay";
+		reg = <0>;
+		enable-gpios = <&pio 67 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 20 GPIO_ACTIVE_HIGH>;
+		iovcc-supply = <&mt6357_vsim1_reg>;
+		power-supply = <&vsys_lcm_reg>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+
+	port {
+		dsi_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
 };
 
 &cpu0 {
@@ -138,6 +201,50 @@ &i2c0 {
 	status = "okay";
 };
 
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-div = <2>;
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	it66121hdmitx: it66121hdmitx@4c {
+		#sound-dai-cells = <0>;
+		compatible = "ite,it66121";
+		interrupt-parent = <&pio>;
+		interrupts = <68 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&ite_pins>;
+		pinctrl-names = "default";
+		reg = <0x4c>;
+		reset-gpios = <&pio 69 GPIO_ACTIVE_LOW>;
+		vcn18-supply = <&mt6357_vsim2_reg>;
+		vcn33-supply = <&mt6357_vibr_reg>;
+		vrf12-supply = <&mt6357_vrf12_reg>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				it66121_in: endpoint {
+					bus-width = <12>;
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				hdmi_connector_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
 &mmc0 {
 	assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL>;
 	assigned-clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>;
@@ -180,7 +287,55 @@ &mt6357_pmic {
 	#interrupt-cells = <2>;
 };
 
+&mt6357_vsim1_reg {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
 &pio {
+	dpi_default_pins: dpi-default-pins {
+		pins {
+			pinmux = <MT8365_PIN_0_GPIO0__FUNC_DPI_D0>,
+				 <MT8365_PIN_1_GPIO1__FUNC_DPI_D1>,
+				 <MT8365_PIN_2_GPIO2__FUNC_DPI_D2>,
+				 <MT8365_PIN_3_GPIO3__FUNC_DPI_D3>,
+				 <MT8365_PIN_4_GPIO4__FUNC_DPI_D4>,
+				 <MT8365_PIN_5_GPIO5__FUNC_DPI_D5>,
+				 <MT8365_PIN_6_GPIO6__FUNC_DPI_D6>,
+				 <MT8365_PIN_7_GPIO7__FUNC_DPI_D7>,
+				 <MT8365_PIN_8_GPIO8__FUNC_DPI_D8>,
+				 <MT8365_PIN_9_GPIO9__FUNC_DPI_D9>,
+				 <MT8365_PIN_10_GPIO10__FUNC_DPI_D10>,
+				 <MT8365_PIN_11_GPIO11__FUNC_DPI_D11>,
+				 <MT8365_PIN_12_GPIO12__FUNC_DPI_DE>,
+				 <MT8365_PIN_13_GPIO13__FUNC_DPI_VSYNC>,
+				 <MT8365_PIN_14_GPIO14__FUNC_DPI_CK>,
+				 <MT8365_PIN_15_GPIO15__FUNC_DPI_HSYNC>;
+			drive-strength = <MTK_DRIVE_4mA>;
+		};
+	};
+
+	dpi_idle_pins: dpi-idle-pins {
+		pins {
+			pinmux = <MT8365_PIN_0_GPIO0__FUNC_GPIO0>,
+				 <MT8365_PIN_1_GPIO1__FUNC_GPIO1>,
+				 <MT8365_PIN_2_GPIO2__FUNC_GPIO2>,
+				 <MT8365_PIN_3_GPIO3__FUNC_GPIO3>,
+				 <MT8365_PIN_4_GPIO4__FUNC_GPIO4>,
+				 <MT8365_PIN_5_GPIO5__FUNC_GPIO5>,
+				 <MT8365_PIN_6_GPIO6__FUNC_GPIO6>,
+				 <MT8365_PIN_7_GPIO7__FUNC_GPIO7>,
+				 <MT8365_PIN_8_GPIO8__FUNC_GPIO8>,
+				 <MT8365_PIN_9_GPIO9__FUNC_GPIO9>,
+				 <MT8365_PIN_10_GPIO10__FUNC_GPIO10>,
+				 <MT8365_PIN_11_GPIO11__FUNC_GPIO11>,
+				 <MT8365_PIN_12_GPIO12__FUNC_GPIO12>,
+				 <MT8365_PIN_13_GPIO13__FUNC_GPIO13>,
+				 <MT8365_PIN_14_GPIO14__FUNC_GPIO14>,
+				 <MT8365_PIN_15_GPIO15__FUNC_GPIO15>;
+		};
+	};
+
 	ethernet_pins: ethernet-pins {
 		phy_reset_pins {
 			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;
@@ -222,6 +377,34 @@ pins {
 		};
 	};
 
+	i2c1_pins: i2c1-pins {
+		pins {
+			pinmux = <MT8365_PIN_59_SDA1__FUNC_SDA1_0>,
+				 <MT8365_PIN_60_SCL1__FUNC_SCL1_0>;
+			bias-pull-up;
+		};
+	};
+
+	ite_pins: ite-pins {
+
+		irq_ite_pins {
+			pinmux = <MT8365_PIN_68_CMDAT0__FUNC_GPIO68>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pwr_pins {
+			pinmux = <MT8365_PIN_70_CMDAT2__FUNC_GPIO70>,
+				 <MT8365_PIN_71_CMDAT3__FUNC_GPIO71>;
+			output-high;
+		};
+
+		rst_ite_pins {
+			pinmux = <MT8365_PIN_69_CMDAT1__FUNC_GPIO69>;
+			output-high;
+		};
+	};
+
 	mmc0_default_pins: mmc0-default-pins {
 		clk-pins {
 			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;

-- 
2.25.1

