Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B40521E24
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245137AbiEJP1Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345791AbiEJP0E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 11:26:04 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9841B13CA28;
        Tue, 10 May 2022 08:11:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,214,1647270000"; 
   d="scan'208";a="120533861"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 May 2022 00:11:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.112])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8CF00400A11D;
        Wed, 11 May 2022 00:11:34 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [RFC 4/8] pwm: rzg2l-gpt: Add support for linking with POEG
Date:   Tue, 10 May 2022 16:11:08 +0100
Message-Id: <20220510151112.16249-5-biju.das.jz@bp.renesas.com>
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

This patch add support for linking POEG group with pwm, so that
POEG can control the output disable function.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index d5d22b1ff792..8eaf96b2052d 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -21,6 +21,7 @@
 #define GTCR		0x2c
 #define GTUDDTYC	0x30
 #define GTIOR		0x34
+#define GTINTAD		0x38
 #define GTBER		0x40
 #define GTCNT		0x48
 #define GTCCRA		0x4c
@@ -37,9 +38,14 @@
 #define UP_COUNTING	(GTUDDTYC_UP | GTUDDTYC_UDF)
 
 #define GTIOR_GTIOA_MASK			GENMASK(4, 0)
+#define GTIOR_OADF_MASK				GENMASK(10, 9)
 #define GTIOR_GTIOB_MASK			GENMASK(20, 16)
+#define GTIOR_OBDF_MASK				GENMASK(26, 25)
+
 #define GTIOR_OAE				BIT(8)
 #define GTIOR_OBE				BIT(24)
+#define GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	(1 << 9)
+#define GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	(1 << 25)
 
 #define INIT_OUT_LO_OUT_LO_END_TOGGLE		(0x07)
 #define INIT_OUT_HI_OUT_HI_END_TOGGLE		(0x1B)
@@ -48,6 +54,13 @@
 #define GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH	((INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | GTIOR_OBE)
 #define GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH	((INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | GTIOR_OBE)
 
+#define GTINTAD_GRP_MASK	GENMASK(25, 24)
+#define GRP_INVALID		(0xFF)
+#define POEG_GRP_A_ADDR		(0x10048800)
+#define POEG_GRP_B_ADDR		(0x10048c00)
+#define POEG_GRP_C_ADDR		(0x10049000)
+#define POEG_GRP_D_ADDR		(0x10049400)
+
 struct phase {
 	u32 value;
 	u32 mask;
@@ -85,6 +98,7 @@ struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct reset_control *rstc;
 	struct clk *clk;
+	u8 poeg_grp;
 };
 
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
@@ -220,6 +234,17 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 	/* Set period */
 	rzg2l_gpt_write(pc, GTPR, pv);
 
+	if (pc->poeg_grp != GRP_INVALID) {
+		rzg2l_gpt_modify(pc, GTINTAD, GTINTAD_GRP_MASK, pc->poeg_grp << 24);
+
+		if (pwm->channel)
+			rzg2l_gpt_modify(pc, GTIOR, GTIOR_OBDF_MASK,
+					 GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE);
+		else
+			rzg2l_gpt_modify(pc, GTIOR, GTIOR_OADF_MASK,
+					 GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE);
+	}
+
 	/* Enable pin output */
 	rzg2l_gpt_modify(pc, GTIOR, pwm->ph->mask, pwm->ph->value);
 
@@ -266,6 +291,36 @@ static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
+static int rzg2l_gpt_parse_properties(struct platform_device *pdev,
+				      struct rzg2l_gpt_chip *pc)
+{
+	static const u64 poeg_grp_addr[] = {
+		POEG_GRP_A_ADDR, POEG_GRP_B_ADDR, POEG_GRP_C_ADDR, POEG_GRP_D_ADDR
+	};
+	struct device_node *np;
+	unsigned int i;
+	u64 addr;
+
+	pc->poeg_grp = GRP_INVALID;
+	np = of_parse_phandle(pdev->dev.of_node, "renesas,poeg-group", 0);
+	if (!np)
+		return 0;
+
+	if (!of_property_read_u64(np, "reg", &addr)) {
+		for (i = 0; i < ARRAY_SIZE(poeg_grp_addr); i++) {
+			if (addr == poeg_grp_addr[i]) {
+				pc->poeg_grp = i;
+				break;
+			}
+		}
+	}
+
+	if (np)
+		of_node_put(np);
+
+	return 0;
+}
+
 static const struct pwm_ops rzg2l_gpt_ops = {
 	.request = rzg2l_gpt_request,
 	.free = rzg2l_gpt_free,
@@ -288,6 +343,10 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (!rzg2l_gpt)
 		return -ENOMEM;
 
+	ret = rzg2l_gpt_parse_properties(pdev, rzg2l_gpt);
+	if (ret)
+		return ret;
+
 	rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
-- 
2.25.1

