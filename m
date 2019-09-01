Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4BA4C88
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 00:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfIAW6w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 1 Sep 2019 18:58:52 -0400
Received: from vern.gendns.com ([98.142.107.122]:37446 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfIAW6w (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 1 Sep 2019 18:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UWqdC7qainDYiI83hlQ8fsjYCgOyB5DxNVt66ZZMzls=; b=ylitdJlj49OjGR89tj65PvTZ5
        mtjniIleBJvINx6qFjoIrM5Ges/AFdY2u++OdzX2n5GJdrc81o6tBrNgcAPxThoSL/E9IFM+SBt85
        l+iird9IcCpCLoV3fOufqspRqTKEdWfWXA5EdBLBBrf2uFoZ1F6ehP5dlobEW7Q9HUX+oqt2nfDa/
        3pn9nIaE8URhiBCpxwmZHypnf/JbkJE85sk6pYFu4L79w5856BN2Vi3GMHHAYT7oEE+yHEK13Dki0
        zpQbwclV9vzG2D4gbzzR50wIdE5odvfJA6I7VmdJclNHb0Y2jfdeHbH8iU7qg46UMy/dSRfhqofOc
        G3BXMVmnw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58390 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1i4Yo5-000351-7e; Sun, 01 Sep 2019 18:58:49 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v3 5/6] ARM: dts: am335x-boneblue: Enable eQEP
Date:   Sun,  1 Sep 2019 17:58:26 -0500
Message-Id: <20190901225827.12301-6-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
References: <20190901225827.12301-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This enables the Enhanced Quadrature Encoder Pulse (eQEP) module for
connectors E1, E2 and E3 on BeagleBone Blue.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:
- none
v2 changes:
- none

 arch/arm/boot/dts/am335x-boneblue.dts | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 0257576d5d16..df3978ce061c 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -258,6 +258,30 @@
 			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_OUTPUT, MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
 		>;
 	};
+
+	/* E1 */
+	eqep0_pins: pinmux_eqep0_pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT, MUX_MODE1)		/* (B12) mcasp0_aclkr.eQEP0A_in */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSR, PIN_INPUT, MUX_MODE1)		/* (C13) mcasp0_fsr.eQEP0B_in */
+		>;
+	};
+
+	/* E2 */
+	eqep1_pins: pinmux_eqep1_pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT, MUX_MODE2)		/* (V2) lcd_data12.eQEP1A_in */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_INPUT, MUX_MODE2)		/* (V3) lcd_data13.eQEP1B_in */
+		>;
+	};
+
+	/* E3 */
+	eqep2_pins: pinmux_eqep2_pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT, MUX_MODE4)		/* (T12) gpmc_ad12.eQEP2A_in */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT, MUX_MODE4)		/* (R12) gpmc_ad13.eQEP2B_in */
+		>;
+	};
 };
 
 &uart0 {
@@ -530,3 +554,33 @@
 		line-name = "LS_BUF_EN";
 	};
 };
+
+&epwmss0 {
+	status = "okay";
+};
+
+&eqep0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqep0_pins>;
+};
+
+&epwmss1 {
+	status = "okay";
+};
+
+&eqep1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqep1_pins>;
+};
+
+&epwmss2 {
+	status = "okay";
+};
+
+&eqep2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqep2_pins>;
+};
-- 
2.17.1

