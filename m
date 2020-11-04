Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E42A7241
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbgKDXqa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733169AbgKDXpi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:38 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D3FC0613CF;
        Wed,  4 Nov 2020 15:45:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id i6so197314lfd.1;
        Wed, 04 Nov 2020 15:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gi4Ws1VebKSodZ1aFskWWEY2ENCBRhjpkPkVyE+JZ/s=;
        b=ZVGF415ceJ5cr2f9Gly+jv4fzQXLlFJzBRcuR2zD4WvgH5zsluXpWCU+Qj1Ax6ZhVf
         1u0lOZIC13jnHSZyF8YgC9LapKlkjSE2olp5X0VAkAmOHo47oGiOd5KA51jau/9+1r5Q
         ZeTQKEqrAXOCG4BSyhIC6+s49wRDSmdZMvycdRKpjqSje66qxlJOfAn1erQ73TtXXuaZ
         iSCWRvM8IOOU+neCqee3lOhq+/lqVKY3CF0lloOJSA1gj7ifC6+jn0RNW/R6aoa+9wD+
         dgu4HpFxYtEPUrSRWIfoyjVSloujlYPyvV4oLCDPZxUQsNdkHeXL2lcu1JDT6N4vPELD
         54yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gi4Ws1VebKSodZ1aFskWWEY2ENCBRhjpkPkVyE+JZ/s=;
        b=T1W/5H5Whi67trlRA1SViwE9vJeh2sQU+OcIzjhcHqwtcRafuqROA5xIi9T2r7QjiT
         qBO0QuIdT9DY36ztv3W6ObvuPYMm+vDLORMJPRXCXDJ1UGCvvL2CaI6GWTYhU0JE7yUb
         gZZnm8StrE/jx3QKMx6rX6u1kqKJC8BEpEJXq5RZNwyg6zT6VKsSkOP7idUMmwr4WX3w
         jihpXOcGZ4isixkqnjOrfX+8lVx3zdSpptzBC2KgAbonSf2bsRjzD2LM/nkrbBbCZfz/
         6B//Q5BXcyziEDGkJstGT4wMOmzbdNysm4nR5wC9+tn/TjsTZPmi/8m3x8FFnjWLVvxZ
         RRcw==
X-Gm-Message-State: AOAM532sD7lWL7tMwOy6KXt7jmsCKicooBKMN6My4iSEj/tuf6p1Lasc
        Yz9DWq0E7+oyKGPKnxIUwNw=
X-Google-Smtp-Source: ABdhPJxSINEdNTI8WAS9/8DNtowjH/ui3U9cyprfFygiShmm4vwewOoOOmbkqukzpRnxz4FsJYlb2g==
X-Received: by 2002:ac2:5498:: with SMTP id t24mr69465lfk.12.1604533535051;
        Wed, 04 Nov 2020 15:45:35 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:34 -0800 (PST)
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
Subject: [PATCH v1 28/30] ARM: tegra: acer-a500: Add voltage supplies to DVFS-capable devices
Date:   Thu,  5 Nov 2020 02:44:25 +0300
Message-Id: <20201104234427.26477-29-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add voltage supplies to DVFS-capable devices in order to enable
system-wide voltage scaling and allow CORE/RTC regulators to go lower.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index b4ed88802387..5ab6872cd84c 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -60,7 +60,19 @@ linux,cma@30000000 {
 	};
 
 	host1x@50000000 {
+		core-supply = <&vdd_core>;
+
+		gr2d@54140000 {
+			core-supply = <&vdd_core>;
+		};
+
+		gr3d@54180000 {
+			core-supply = <&vdd_core>;
+		};
+
 		dc@54200000 {
+			core-supply = <&vdd_core>;
+
 			rgb {
 				status = "okay";
 
@@ -73,12 +85,17 @@ lcd_output: endpoint {
 			};
 		};
 
+		dc@54240000 {
+			core-supply = <&vdd_core>;
+		};
+
 		hdmi@54280000 {
 			status = "okay";
 
 			vdd-supply = <&hdmi_vdd_reg>;
 			pll-supply = <&hdmi_pll_reg>;
 			hdmi-supply = <&vdd_5v0_sys>;
+			core-supply = <&vdd_core>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
@@ -86,6 +103,10 @@ hdmi@54280000 {
 		};
 	};
 
+	vde@6001a000 {
+		core-supply = <&vdd_core>;
+	};
+
 	pinmux@70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
@@ -565,7 +586,7 @@ sys_reg: sys {
 
 				vdd_core: sm0 {
 					regulator-name = "vdd_sm0,vdd_core";
-					regulator-min-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
 					regulator-max-microvolt = <1300000>;
 					regulator-coupled-with = <&rtc_vdd &vdd_cpu>;
 					regulator-coupled-max-spread = <170000 550000>;
@@ -606,7 +627,7 @@ ldo1 {
 
 				rtc_vdd: ldo2 {
 					regulator-name = "vdd_ldo2,vdd_rtc";
-					regulator-min-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
 					regulator-max-microvolt = <1300000>;
 					regulator-coupled-with = <&vdd_core &vdd_cpu>;
 					regulator-coupled-max-spread = <170000 550000>;
@@ -696,6 +717,7 @@ usb@c5000000 {
 		compatible = "nvidia,tegra20-udc";
 		status = "okay";
 		dr_mode = "peripheral";
+		core-supply = <&vdd_core>;
 	};
 
 	usb-phy@c5000000 {
@@ -709,6 +731,7 @@ usb-phy@c5000000 {
 
 	usb@c5008000 {
 		status = "okay";
+		core-supply = <&vdd_core>;
 	};
 
 	usb-phy@c5008000 {
@@ -746,6 +769,7 @@ sdmmc1: mmc@c8000000 {
 		non-removable;
 
 		mmc-pwrseq = <&brcm_wifi_pwrseq>;
+		core-supply = <&vdd_core>;
 		vmmc-supply = <&vdd_3v3_sys>;
 		vqmmc-supply = <&vdd_3v3_sys>;
 
@@ -764,6 +788,7 @@ sdmmc3: mmc@c8000400 {
 		bus-width = <4>;
 		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
+		core-supply = <&vdd_core>;
 		vmmc-supply = <&vdd_3v3_sys>;
 		vqmmc-supply = <&vdd_3v3_sys>;
 	};
@@ -771,6 +796,7 @@ sdmmc3: mmc@c8000400 {
 	sdmmc4: mmc@c8000600 {
 		status = "okay";
 		bus-width = <8>;
+		core-supply = <&vdd_core>;
 		vmmc-supply = <&vcore_emmc>;
 		vqmmc-supply = <&vdd_3v3_sys>;
 		non-removable;
-- 
2.27.0

