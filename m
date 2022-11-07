Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2161E806
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 01:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiKGA4J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Nov 2022 19:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKGA4I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Nov 2022 19:56:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A394A1A7;
        Sun,  6 Nov 2022 16:56:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C3513D5;
        Sun,  6 Nov 2022 16:56:13 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B2A53F703;
        Sun,  6 Nov 2022 16:56:05 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: [PATCH v2 02/10] ARM: dts: suniv: f1c100s: add PWM node
Date:   Mon,  7 Nov 2022 00:54:25 +0000
Message-Id: <20221107005433.11079-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <20221107005433.11079-1-andre.przywara@arm.com>
References: <20221107005433.11079-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Allwinner F1C100s family of SoCs contain a PWM controller compatible
to the one used in the A20 chip.
Add the DT node so that any users can simply enable it in their board
DT.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index a01541ba42c5..81749d5da12f 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -218,6 +218,15 @@ wdt: watchdog@1c20ca0 {
 			clocks = <&osc32k>;
 		};
 
+		pwm: pwm@1c21000 {
+			compatible = "allwinner,suniv-f1c100s-pwm",
+				     "allwinner,sun7i-a20-pwm";
+			reg = <0x01c21000 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial@1c25000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c25000 0x400>;
-- 
2.35.5

