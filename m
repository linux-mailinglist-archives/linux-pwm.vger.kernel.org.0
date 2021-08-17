Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2F3EE26F
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhHQBbF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbhHQBaq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3773C0617AE;
        Mon, 16 Aug 2021 18:30:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g13so38106852lfj.12;
        Mon, 16 Aug 2021 18:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TXI1PsD2CP95PVSZQdBoUU6aVsve75rwezr3hbKqQc=;
        b=ctE/gnNctwQ78bIwB8gkQtQ4rMJljulmz2YnS7E3wGldETznUW6j3Ou4Z5KWvHfBMj
         q0RBAXpPH4bqaZI8wZlyaqho96SEjh7zD1Ofo1hNZE1rHPyelmg2wCLllSyJon15IVGV
         vWWfpZmUyMA/D/HgqWJHpk8hWFM5h6/DJUkAcvCjzYUCLr7pH++ps9GgE+5stqlL3iCn
         rUSkOxDP8oqLNMHsvwUQdkQ5F3DHIl893dm3oWgqUFIOe1a5fA2ZUOXJYUkS31JFywbU
         ZkzE2+subwHYO7oX3w+hl4aG+ebw2VNbA/Smii6cdUwy7w8zwaZ3hD2rT0IoRpnEASFC
         CcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TXI1PsD2CP95PVSZQdBoUU6aVsve75rwezr3hbKqQc=;
        b=HyWPpoA7Lwgg0Vxd0Mt6IgDPiSWKttxTu0Zq2blCtupFX/fsgGgHpqMhzA4GlDO9du
         EhV6I87keHrJchYylzk1IVGPmgCowKZIcK14YK1PfAYaKiYYXvZm/PHEDz7JZTO4IXrN
         6wOFfltQLDw3JM16yTqP+QAr75nSOPCTnr8CT4hsJ3vsPzkIgKLayoVLTpfh7BI9+zAG
         s8PcbCKMFrDHLqeGIxoFCSmCGe3Srykj2MM+QLRH3vx4e7iuh3XYujyTMTdc9vbCicge
         JkK5C4WNQtzTsnXgbTmJtupxfc1f957u0oYWg0XBl3JgCaMdrxXGyrhV8tRQIX4v83Do
         rIJw==
X-Gm-Message-State: AOAM531L8O2cVIuQ++zyZzTqqnmTGmRtCR3KDR2hTjoOY+BECfakvyAc
        PBtmMHWEL5y26k6DYv0DQH0=
X-Google-Smtp-Source: ABdhPJzuZ2KMRBi3eQc/FWRQo/+rgKKj4s5rWZFGxcvpLMIWcBLFu2OqgDwQXznaAWLcokuOhOhN+w==
X-Received: by 2002:a05:6512:2625:: with SMTP id bt37mr486235lfb.255.1629163811065;
        Mon, 16 Aug 2021 18:30:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v8 08/34] dt-bindings: host1x: Document OPP and power domain properties
Date:   Tue, 17 Aug 2021 04:27:28 +0300
Message-Id: <20210817012754.8710-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new DVFS OPP table and power domain properties of the Host1x bus
and devices sitting on the bus.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../display/tegra/nvidia,tegra20-host1x.txt   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 8a6d3e1ee306..62861a8fb5c6 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -20,6 +20,18 @@ Required properties:
 - reset-names: Must include the following entries:
   - host1x
 
+Optional properties:
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandle to HEG or core power domain.
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
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandle to MPE power domain.
 
 - vi: video input
 
@@ -128,6 +142,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandle to VENC power domain.
 
 - epp: encoder pre-processor
 
@@ -147,6 +163,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandle to HEG or core power domain.
 
 - isp: image signal processor
 
@@ -166,6 +184,7 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - power-domains: Phandle to VENC or core power domain.
 
 - gr2d: 2D graphics engine
 
@@ -185,6 +204,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandle to HEG or core power domain.
 
 - gr3d: 3D graphics engine
 
@@ -209,6 +230,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandles to 3D or core power domain.
 
 - dc: display controller
 
@@ -241,6 +264,8 @@ of the following host1x client modules:
   - interconnect-names: Must include name of the interconnect path for each
     interconnect entry. Consult TRM documentation for information about
     available memory clients, see MEMORY CONTROLLER section.
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandle to core power domain.
 
 - hdmi: High Definition Multimedia Interface
 
@@ -267,6 +292,7 @@ of the following host1x client modules:
   - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
   - nvidia,edid: supplies a binary EDID blob
   - nvidia,panel: phandle of a display panel
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
 
 - tvo: TV encoder output
 
@@ -277,6 +303,10 @@ of the following host1x client modules:
   - clocks: Must contain one entry, for the module clock.
     See ../clocks/clock-bindings.txt for details.
 
+  Optional properties:
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
+  - power-domains: Phandle to core power domain.
+
 - dsi: display serial interface
 
   Required properties:
@@ -305,6 +335,7 @@ of the following host1x client modules:
   - nvidia,panel: phandle of a display panel
   - nvidia,ganged-mode: contains a phandle to a second DSI controller to gang
     up with in order to support up to 8 data lanes
+  - operating-points-v2: See ../bindings/opp/opp.txt for details.
 
 - sor: serial output resource
 
@@ -408,6 +439,8 @@ Example:
 		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
+		operating-points-v2 = <&dvfs_opp_table>;
+		power-domains = <&domain>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -421,6 +454,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_MPE>;
 			resets = <&tegra_car 60>;
 			reset-names = "mpe";
+			operating-points-v2 = <&dvfs_opp_table>;
+			power-domains = <&domain>;
 		};
 
 		vi@54080000 {
@@ -429,6 +464,7 @@ Example:
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			assigned-clocks = <&tegra_car TEGRA210_CLK_VI>;
 			assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_C4_OUT0>;
+			operating-points-v2 = <&dvfs_opp_table>;
 
 			clocks = <&tegra_car TEGRA210_CLK_VI>;
 			power-domains = <&pd_venc>;
@@ -510,6 +546,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_EPP>;
 			resets = <&tegra_car 19>;
 			reset-names = "epp";
+			operating-points-v2 = <&dvfs_opp_table>;
+			power-domains = <&domain>;
 		};
 
 		isp {
@@ -528,6 +566,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
+			operating-points-v2 = <&dvfs_opp_table>;
+			power-domains = <&domain>;
 		};
 
 		gr3d {
@@ -536,6 +576,8 @@ Example:
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
+			operating-points-v2 = <&dvfs_opp_table>;
+			power-domains = <&domain>;
 		};
 
 		dc@54200000 {
@@ -547,6 +589,8 @@ Example:
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
+			operating-points-v2 = <&dvfs_opp_table>;
+			power-domains = <&domain>;
 
 			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
 					<&mc TEGRA20_MC_DISPLAY0B &emc>,
@@ -571,6 +615,8 @@ Example:
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
+			operating-points-v2 = <&dvfs_opp_table>;
+			power-domains = <&domain>;
 
 			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
 					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
@@ -596,6 +642,7 @@ Example:
 			resets = <&tegra_car 51>;
 			reset-names = "hdmi";
 			status = "disabled";
+			operating-points-v2 = <&dvfs_opp_table>;
 		};
 
 		tvo {
@@ -604,6 +651,7 @@ Example:
 			interrupts = <0 76 0x04>;
 			clocks = <&tegra_car TEGRA20_CLK_TVO>;
 			status = "disabled";
+			operating-points-v2 = <&dvfs_opp_table>;
 		};
 
 		dsi {
@@ -615,6 +663,7 @@ Example:
 			resets = <&tegra_car 48>;
 			reset-names = "dsi";
 			status = "disabled";
+			operating-points-v2 = <&dvfs_opp_table>;
 		};
 	};
 
-- 
2.32.0

