Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF52128A4
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jul 2020 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGBPwU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jul 2020 11:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgGBPwS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Jul 2020 11:52:18 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532C620771;
        Thu,  2 Jul 2020 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593705137;
        bh=sSdReNCbQ95iX95NO7DctNPjLRYAsM3DUM6aFTxJSlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MclqMFkIoXnNvdMftEaiTPRw5qmQBKoezvwiDzyRLIIY7eKmor7Bc3wtlQI8euehr
         S2RxV3ec5AIv+kbSqLg40JpsUgr73N8gkIPQ+sKj4bVKe/SVc8zITyb1nkI57TmVqE
         +D1Tt0wBkDSfNqUEd7x+qmrjc0BL5Kl+zVX27uy8=
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
Subject: [PATCH v2 6/8] ARM: dts: exynos: Define fixed regulators in root node for consistency in Origen
Date:   Thu,  2 Jul 2020 17:51:47 +0200
Message-Id: <20200702155149.12854-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove the regulators node and define fixed regulators directly under
the root node.  This makes Exynos4412 Origen board consistent with other
Exynos boards.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos4412-origen.dts | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index dc865be40751..74f7cef8acc5 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -33,20 +33,14 @@
 		reg = <0x0203F000 0x1000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		mmc_reg: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "VMEM_VDD_2.8V";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	mmc_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		reg = <0>;
+		regulator-name = "VMEM_VDD_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	display-timings {
-- 
2.17.1

