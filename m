Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C972A7253
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbgKDXrR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733151AbgKDXpb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:31 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA64C0613CF;
        Wed,  4 Nov 2020 15:45:31 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id m16so307899ljo.6;
        Wed, 04 Nov 2020 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxZqGk/ZMf8l9UbMDIPd7jdOdhUcVHtE7WzA1PmtWDg=;
        b=qk3P32kBW1RxeA7PoyCNvBPLJCdtiKl4MWIBl6NSYhckS7zhpZjih/eIFQc9CfkrKR
         QBqI644fhQW4mLWSisC9qSW3LcACR2l1N6UxOKrY1FC0CYtGrkCoh6rru/gRIdf1Bqmy
         +03qrV+7THkErJ4pTIvE3jV9THFP/EmrJfyPdsFrkd/12GgeeLQCbifklpNte/IaU13V
         rsoPxtyGsxt9OpKcfHNiFJmzq0DgS38cEfG+8LLIq3o13wTdkHylfC2uVqVTqoG+ja9l
         1n3U8+1zo6+Yjbou+fTTmq99uCbXrnAunW8QTWLuZNXRCn3gzFzWb3GmjZxLoPV2LIcP
         IGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxZqGk/ZMf8l9UbMDIPd7jdOdhUcVHtE7WzA1PmtWDg=;
        b=hhvTezNespKAwjXQp3N2VuuAJVgyxCxOM9w9QWL1tKXPbSivdtDelkXoUoslEQR9hm
         Q3cR1OPCCRVSspLoqdMao75TNQjpIhUrkZUeJEPLWmnBGIYmER3lUuf4SqQTAYBhMprI
         EBX9bbfLsOm/uPUE5udx+LzCPNPRQz4W0cwz0hv/Ry1VahjHhAmn039zhfSMaK44xGV1
         ye9tj0zSc3HdelVSlV/mDAY42jsPZ2JMWl959s+b52BhxXGQs1eqFOmakWVR73DzEWa5
         PZWEb155DEMNJV3IG/0tXAOaF/ckYOUjFFuW55H6Q+4Kz0kGx4HIPWEb/rVoKEK3Tq3l
         mAzw==
X-Gm-Message-State: AOAM532sb2gzAsonm/nqpuqPpXzxhw4VSgj4Cu3NLm0EI4BIhngNwNdM
        xGQN3N/UqXSfOf0walaZDuE=
X-Google-Smtp-Source: ABdhPJymtrhEAbNncSymhtYyuCPxyJyXQvnjnRaM2aoZ0BBto/FDcYNrl5JrWRN0UUQPlX8BPKiCkg==
X-Received: by 2002:a2e:9098:: with SMTP id l24mr126250ljg.163.1604533529567;
        Wed, 04 Nov 2020 15:45:29 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:29 -0800 (PST)
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
Subject: [PATCH v1 24/30] ARM: tegra: Add OPP tables for Tegra20 peripheral devices
Date:   Thu,  5 Nov 2020 02:44:21 +0300
Message-Id: <20201104234427.26477-25-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add OPP tables for Tegra20 SoC devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi | 386 ++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                |  14 +
 2 files changed, 400 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
index 25b1ba73951e..792dc79d32c5 100644
--- a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
@@ -89,4 +89,390 @@ opp@760000000 {
 			opp-hz = /bits/ 64 <760000000>;
 		};
 	};
+
+	vde_dvfs_opp_table: vde-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@95000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <95000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@123500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <123500000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@123500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <123500000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@152000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <152000000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@152000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <152000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@171000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <171000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@209000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <209000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@209000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <209000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@218500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <218500000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@237500000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <237500000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@275500000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <275500000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@285000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <285000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@300000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@300000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0006>;
+		};
+
+		opp@300000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x0008>;
+		};
+	};
+
+	gr2d_dvfs_opp_table: gr2d-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@133000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <133000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@171000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <171000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@247000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@300000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+			opp-supported-hw = <0x000F>;
+		};
+	};
+
+	gr3d_dvfs_opp_table: gr3d-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@114000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <114000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@161500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <161500000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@161500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <161500000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@209000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <209000000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@218500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <218500000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@247000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@247000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <247000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@256500000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <256500000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@285000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <285000000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@285000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <285000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@304000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <304000000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@323000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <323000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@333500000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x0001>;
+		};
+
+		opp@333500000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <333500000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@351500000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <351500000>;
+			opp-supported-hw = <0x0008>;
+		};
+
+		opp@361000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <361000000>;
+			opp-supported-hw = <0x0002>;
+		};
+
+		opp@380000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <380000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@400000000,1275 {
+			opp-microvolt = <1275000 1275000 1300000>;
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x0004>;
+		};
+
+		opp@400000000,1200 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x0008>;
+		};
+	};
+
+	host1x_dvfs_opp_table: host1x-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@104500000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <104500000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@133000000,1000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <133000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@166000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <166000000>;
+			opp-supported-hw = <0x000F>;
+		};
+	};
+
+	usbd_dvfs_opp_table: usbd-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@480000000 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <480000000>;
+		};
+	};
+
+	usb2_dvfs_opp_table: usb2-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@480000000 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <480000000>;
+		};
+	};
+
+	usb3_dvfs_opp_table: usb3-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@480000000 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <480000000>;
+		};
+	};
+
+	sdmmc1_dvfs_opp_table: sdmmc1-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+		};
+
+		opp@52000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+		};
+	};
+
+	sdmmc2_dvfs_opp_table: sdmmc2-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+		};
+
+		opp@52000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+		};
+	};
+
+	sdmmc3_dvfs_opp_table: sdmmc3-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+		};
+
+		opp@52000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+		};
+	};
+
+	sdmmc4_dvfs_opp_table: sdmmc4-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@44000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <44000000>;
+		};
+
+		opp@52000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <52000000>;
+		};
+	};
+
+	hdmi_dvfs_opp_table: hdmi-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@148500000 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <148500000>;
+		};
+	};
+
+	dc0_dvfs_opp_table: dc0-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@158000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <158000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@190000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x000F>;
+		};
+	};
+
+	dc1_dvfs_opp_table: dc1-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@158000000,950 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <158000000>;
+			opp-supported-hw = <0x000F>;
+		};
+
+		opp@190000000,1100 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+			opp-supported-hw = <0x000F>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 6ce498178105..317bdf75ff6c 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -42,6 +42,7 @@ host1x@50000000 {
 		clock-names = "host1x";
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
+		operating-points-v2 = <&host1x_dvfs_opp_table>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -91,6 +92,7 @@ gr2d@54140000 {
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
+			operating-points-v2 = <&gr2d_dvfs_opp_table>;
 		};
 
 		gr3d@54180000 {
@@ -99,6 +101,7 @@ gr3d@54180000 {
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
+			operating-points-v2 = <&gr3d_dvfs_opp_table>;
 		};
 
 		dc@54200000 {
@@ -110,6 +113,7 @@ dc@54200000 {
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 27>;
 			reset-names = "dc";
+			operating-points-v2 = <&dc0_dvfs_opp_table>;
 
 			nvidia,head = <0>;
 
@@ -138,6 +142,7 @@ dc@54240000 {
 			clock-names = "dc", "parent";
 			resets = <&tegra_car 26>;
 			reset-names = "dc";
+			operating-points-v2 = <&dc1_dvfs_opp_table>;
 
 			nvidia,head = <1>;
 
@@ -167,6 +172,7 @@ hdmi@54280000 {
 			resets = <&tegra_car 51>;
 			reset-names = "hdmi";
 			status = "disabled";
+			operating-points-v2 = <&hdmi_dvfs_opp_table>;
 		};
 
 		tvo@542c0000 {
@@ -319,6 +325,7 @@ vde@6001a000 {
 		clocks = <&tegra_car TEGRA20_CLK_VDE>;
 		reset-names = "vde", "mc";
 		resets = <&tegra_car 61>, <&mc TEGRA20_MC_RESET_VDE>;
+		operating-points-v2 = <&vde_dvfs_opp_table>;
 	};
 
 	apbmisc@70000800 {
@@ -755,6 +762,7 @@ usb@c5000000 {
 		nvidia,needs-double-reset;
 		nvidia,phy = <&phy1>;
 		status = "disabled";
+		operating-points-v2 = <&usbd_dvfs_opp_table>;
 	};
 
 	phy1: usb-phy@c5000000 {
@@ -792,6 +800,7 @@ usb@c5004000 {
 		reset-names = "usb";
 		nvidia,phy = <&phy2>;
 		status = "disabled";
+		operating-points-v2 = <&usb2_dvfs_opp_table>;
 	};
 
 	phy2: usb-phy@c5004000 {
@@ -818,6 +827,7 @@ usb@c5008000 {
 		reset-names = "usb";
 		nvidia,phy = <&phy3>;
 		status = "disabled";
+		operating-points-v2 = <&usb3_dvfs_opp_table>;
 	};
 
 	phy3: usb-phy@c5008000 {
@@ -852,6 +862,7 @@ mmc@c8000000 {
 		resets = <&tegra_car 14>;
 		reset-names = "sdhci";
 		status = "disabled";
+		operating-points-v2 = <&sdmmc1_dvfs_opp_table>;
 	};
 
 	mmc@c8000200 {
@@ -863,6 +874,7 @@ mmc@c8000200 {
 		resets = <&tegra_car 9>;
 		reset-names = "sdhci";
 		status = "disabled";
+		operating-points-v2 = <&sdmmc2_dvfs_opp_table>;
 	};
 
 	mmc@c8000400 {
@@ -874,6 +886,7 @@ mmc@c8000400 {
 		resets = <&tegra_car 69>;
 		reset-names = "sdhci";
 		status = "disabled";
+		operating-points-v2 = <&sdmmc3_dvfs_opp_table>;
 	};
 
 	mmc@c8000600 {
@@ -885,6 +898,7 @@ mmc@c8000600 {
 		resets = <&tegra_car 15>;
 		reset-names = "sdhci";
 		status = "disabled";
+		operating-points-v2 = <&sdmmc4_dvfs_opp_table>;
 	};
 
 	cpus {
-- 
2.27.0

