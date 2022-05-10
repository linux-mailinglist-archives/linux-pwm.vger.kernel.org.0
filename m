Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC60521E27
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345534AbiEJP1S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345842AbiEJP0K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 11:26:10 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB52615A77D;
        Tue, 10 May 2022 08:11:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,214,1647270000"; 
   d="scan'208";a="119261240"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 May 2022 00:11:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.112])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A24DE400A0E7;
        Wed, 11 May 2022 00:11:47 +0900 (JST)
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
Subject: [RFC 7/8] arm64: dts: renesas: rzg2l-smarc: Enable POEGG{A,B,C,D} on carrier board
Date:   Tue, 10 May 2022 16:11:11 +0100
Message-Id: <20220510151112.16249-8-biju.das.jz@bp.renesas.com>
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

Enable POEGG{A,B,C,D} on RZ/{G2,V2}L SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 8fb68e95f1d7..f1fb9cecc49b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -42,6 +42,22 @@ wm8978: codec@1a {
 	};
 };
 
+&poegga {
+	status = "okay";
+};
+
+&poeggb {
+	status = "okay";
+};
+
+&poeggc {
+	status = "okay";
+};
+
+&poeggd {
+	status = "okay";
+};
+
 /*
  * To enable SCIF2 (SER0) on PMOD1 (CN7)
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.25.1

