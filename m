Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CEE2A7319
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbgKDXuo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732671AbgKDXpA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:00 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64CCC0613CF;
        Wed,  4 Nov 2020 15:44:58 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so310919lji.5;
        Wed, 04 Nov 2020 15:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YM5IiBSxM0x10e+Au9qpNGPC4fBnjpf0BFdkUuSd19o=;
        b=lVcUqzf4bACnjosNBHshwKvloxF1mXmh47Jx+tv5SOw3pbcF5MewYXF2PB/avaGI70
         vQJq32tRmP2XPmPN+x69w89RTcvLM305K0t5/8gnq90BjT7LO494irREBwHTquD1oSOp
         MR5CN4fovrz4pzkyzp0PaspM5y8oMZxNFeB8gslG+P+IZgNjFaL4yf1zeIhqoK+5owom
         LKXVk/rIA3l92z9ZoOn/8SQ+nc3Up9VpkX9oU+cQ2Ho8ccmdajqKcqIPL9LaPxQguChN
         UxuOOhhmNyTW8RnPu0w3dFY1qJ71LnPOFHgjMdZmODW6bZUq1ow8R47S8wm2f/wv7rkQ
         4nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YM5IiBSxM0x10e+Au9qpNGPC4fBnjpf0BFdkUuSd19o=;
        b=d9G7uCb1QAShnsO0T+9wTGvMMRgv+VAgVh7bL8lz2WQ5nvxGJkoTTwMs+mnjVbj6P6
         cW2zyvLJ0d+oixksh+nNh/06AwVPKI1BkthZRmIF79pSO2ITPKzNzcW/liTDAN7o/KRe
         i/29MVFR8ZEpa+h5GbV75lUSUH35dSIMN0EV/inCI6sWmP/8ifM2KXP43k2KgJZsv17Y
         FMSHPEEfR59ckD68op/7sBD8Iyjn5QDHovRv01kdWAgzT6xz8DZe5u079/QeoubjEKWN
         FT8O+Ya7qy2lcQh3mdaqQ4Un5j8ULBHKHdNaY14bDAaH9m6nEoZ3mMAumduGmZKO5ZOQ
         SbXw==
X-Gm-Message-State: AOAM531ddC49S8SYFTdhv656Z7XmFsH0TPpdaU9icUyncjl7gUlqzyGO
        Tdj1ffxEUu6jA9N/Hs8D0a8=
X-Google-Smtp-Source: ABdhPJwmfo2F3w3VqauMbdw79G3wwAW+IEPO2zeUaLvIq9m5Iy9Czxc99+HDdNQyXZjk5AradNM/vg==
X-Received: by 2002:a2e:9a98:: with SMTP id p24mr132196lji.418.1604533497375;
        Wed, 04 Nov 2020 15:44:57 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:44:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 01/30] dt-bindings: host1x: Document OPP and voltage regulator properties
Date:   Thu,  5 Nov 2020 02:43:58 +0300
Message-Id: <20201104234427.26477-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new DVFS OPP table and voltage regulator properties of the
Host1x bus and devices sitting on the bus.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../display/tegra/nvidia,tegra20-host1x.txt   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 34d993338453..0593c8df70bb 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -20,6 +20,18 @@ Required properties:
 - reset-names: Must include the following entries:
   - host1x
 
+Optional properties:
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- core-supply: Phandle of voltage regulator of the SoC "core" power domain.
+
+For each opp entry in 'operating-points-v2' table of host1x and its modules:
+- opp-supported-hw: One bitfield indicating:
+	On Tegra20: SoC process ID mask
+	On Tegra30+: SoC speedo ID mask
+
+	A bitwise AND is performed against the value and if any bit
+	matches, the OPP gets enabled.
+
 Each host1x client module having to perform DMA through the Memory Controller
 should have the interconnect endpoints set to the Memory Client and External
 Memory respectively.
@@ -45,6 +57,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
 
 - vi: video input
 
@@ -128,6 +142,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - epp: encoder pre-processor
 
@@ -147,6 +163,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - isp: image signal processor
 
@@ -166,6 +184,7 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - gr2d: 2D graphics engine
 
@@ -185,6 +204,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - gr3d: 3D graphics engine
 
@@ -209,6 +230,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - dc: display controller
 
@@ -241,6 +264,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - hdmi: High Definition Multimedia Interface
 
@@ -267,6 +292,8 @@ of the following host1x client modules:
   - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - tvo: TV encoder output
 
@@ -277,6 +304,10 @@ of the following host1x client modules:
   - clocks: Must contain one entry, for the module clock.
     See ../clocks/clock-bindings.txt for details.
 
+  Optional properties:
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
+
 - dsi: display serial interface
 
   Required properties:
@@ -305,6 +336,8 @@ of the following host1x client modules:
   - nvidia,panel: phandle of a display panel
   - nvidia,ganged-mode: contains a phandle to a second DSI controller to gang
     up with in order to support up to 8 data lanes
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 - sor: serial output resource
 
@@ -394,6 +427,7 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
 
 Example:
 
@@ -408,6 +442,8 @@ Example:
 		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
+		operating-points-v2 = <&dvfs_opp_table>;
+		core-supply = <&vdd_core>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -421,6 +457,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_MPE>;
 			resets = <&tegra_car 60>;
 			reset-names = "mpe";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 		};
 
 		vi@54080000 {
@@ -429,6 +467,8 @@ Example:
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			assigned-clocks = <&tegra_car TEGRA210_CLK_VI>;
 			assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 
 			clocks = <&tegra_car TEGRA210_CLK_VI>;
 			power-domains = <&pd_venc>;
@@ -510,6 +550,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_EPP>;
 			resets = <&tegra_car 19>;
 			reset-names = "epp";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 		};
 
 		isp {
@@ -528,6 +570,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 		};
 
 		gr3d {
@@ -536,6 +580,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 		};
 
 		dc@54200000 {
@@ -547,6 +593,8 @@ Example:
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 
 			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
 					<&mc TEGRA20_MC_DISPLAY0B &emc>,
@@ -571,6 +619,8 @@ Example:
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 
 			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
 					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
@@ -596,6 +646,8 @@ Example:
 			resets = <&tegra_car 51>;
 			reset-names = "hdmi";
 			status = "disabled";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 		};
 
 		tvo {
@@ -604,6 +656,8 @@ Example:
 			interrupts = <0 76 0x04>;
 			clocks = <&tegra_car TEGRA20_CLK_TVO>;
 			status = "disabled";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 		};
 
 		dsi {
@@ -615,6 +669,8 @@ Example:
 			resets = <&tegra_car 48>;
 			reset-names = "dsi";
 			status = "disabled";
+			operating-points-v2 = <&dvfs_opp_table>;
+			core-supply = <&vdd_core>;
 		};
 	};
 
-- 
2.27.0

