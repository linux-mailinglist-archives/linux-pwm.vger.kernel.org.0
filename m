Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD5521E28
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbiEJP1R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbiEJP0I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 11:26:08 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4717D14B677;
        Tue, 10 May 2022 08:11:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,214,1647270000"; 
   d="scan'208";a="119261235"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 May 2022 00:11:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.112])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B65D400A0E7;
        Wed, 11 May 2022 00:11:38 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC 5/8] arm64: dts: renesas: r9a07g044: Add POEG nodes
Date:   Tue, 10 May 2022 16:11:09 +0100
Message-Id: <20220510151112.16249-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add POEGG{A,B,C,D} nodes to RZ/G2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 28284d537a70..58476519683e 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -360,6 +360,50 @@ gpt7: pwm@10048700 {
 			status = "disabled";
 		};
 
+		poegga: poeg@10048800 {
+			compatible = "renesas,r9a07g044-poeg",
+				     "renesas,rzg2l-poeg";
+			reg = <0 0x10048800 0 0x04>;
+			interrupts = <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_POEG_A_CLKP>;
+			power-domains = <&cpg>;
+			resets =  <&cpg R9A07G044_POEG_A_RST>;
+			status = "disabled";
+		};
+
+		poeggb: poeg@10048c00 {
+			compatible = "renesas,r9a07g044-poeg",
+				     "renesas,rzg2l-poeg";
+			reg = <0 0x10048c00 0 0x04>;
+			interrupts = <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_POEG_B_CLKP>;
+			power-domains = <&cpg>;
+			resets =  <&cpg R9A07G044_POEG_B_RST>;
+			status = "disabled";
+		};
+
+		poeggc: poeg@10049000 {
+			compatible = "renesas,r9a07g044-poeg",
+				     "renesas,rzg2l-poeg";
+			reg = <0 0x10049000 0 0x04>;
+			interrupts = <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_POEG_C_CLKP>;
+			power-domains = <&cpg>;
+			resets =  <&cpg R9A07G044_POEG_C_RST>;
+			status = "disabled";
+		};
+
+		poeggd: poeg@10049400 {
+			compatible = "renesas,r9a07g044-poeg",
+				     "renesas,rzg2l-poeg";
+			reg = <0 0x10049400 0 0x04>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_POEG_D_CLKP>;
+			power-domains = <&cpg>;
+			resets =  <&cpg R9A07G044_POEG_D_RST>;
+			status = "disabled";
+		};
+
 		ssi0: ssi@10049c00 {
 			compatible = "renesas,r9a07g044-ssi",
 				     "renesas,rz-ssi";
-- 
2.25.1

