Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168902128A5
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jul 2020 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGBPwa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jul 2020 11:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgGBPw2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Jul 2020 11:52:28 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951392088E;
        Thu,  2 Jul 2020 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593705147;
        bh=I36yVrLD52E/RNQ64kKYCYzRpU8aZRVCVCHAH3Jt6To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdPw6mCwzH8sNJ1IKEERZj30LyaFqfuu1D/+fYhA841U3Rj9qCsBltZXGQVICjD9T
         m78dIvqGCPo+D6KsOoArSyU3JcLRGqnUaTzm9QmTqp1zrQRNuH4y9mLE9uE10zVX7g
         MNh5mpDTIEEUkYf1RhFeOUWNNy9cn/mZLMTeoMew=
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
Subject: [PATCH v2 8/8] ARM: dts: exynos: Define fixed regulators in root node for consistency in SMDK5420
Date:   Thu,  2 Jul 2020 17:51:49 +0200
Message-Id: <20200702155149.12854-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove the regulators node and define fixed regulators directly under
the root node.  This makes SMDK5420 board consistent with other Exynos
boards.

Name the fixed regulator nodes consistently.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts | 56 ++++++++++-------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index e3f2afe8359a..d703c603c45a 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -32,40 +32,34 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vdd: fixed-regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "vdd-supply";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
+	vdd: regulator-0 {
+		compatible = "regulator-fixed";
+		reg = <0>;
+		regulator-name = "vdd-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 
-		dbvdd: fixed-regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "dbvdd-supply";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	dbvdd: regulator-1 {
+		compatible = "regulator-fixed";
+		reg = <1>;
+		regulator-name = "dbvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		spkvdd: fixed-regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "spkvdd-supply";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	spkvdd: regulator-2 {
+		compatible = "regulator-fixed";
+		reg = <2>;
+		regulator-name = "spkvdd-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
-	usb300_vbus_reg: regulator-usb300 {
+	usb300_vbus_reg: regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VBUS0";
 		regulator-min-microvolt = <5000000>;
@@ -76,7 +70,7 @@
 		enable-active-high;
 	};
 
-	usb301_vbus_reg: regulator-usb301 {
+	usb301_vbus_reg: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "VBUS1";
 		regulator-min-microvolt = <5000000>;
-- 
2.17.1

