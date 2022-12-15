Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2763D64E2A9
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Dec 2022 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLOU7D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Dec 2022 15:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLOU7C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Dec 2022 15:59:02 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D313528AF;
        Thu, 15 Dec 2022 12:59:01 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; 
   d="scan'208";a="146335249"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2022 05:59:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.26])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3084C400F7B4;
        Fri, 16 Dec 2022 05:58:57 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 3/3] pwm: rzg2l-gpt: Add support for gpt linking with poeg
Date:   Thu, 15 Dec 2022 20:58:43 +0000
Message-Id: <20221215205843.4074504-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215205843.4074504-1-biju.das.jz@bp.renesas.com>
References: <20221215205843.4074504-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The General PWM Timer (GPT) is capable of detecting "dead time error
and short-circuits between output pins" and send Output disable
request to poeg(Port Output Enable for GPT).

This patch add support for linking poeg group with gpt, so that
gpt can control the output disable function.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Updated commit header and description
 * Added check for poeg group in rzg2l_gpt_parse_properties().
v1->v2:
 * Replaced id->poeg-id as per poeg bindings.
This patch depend upon [1]
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221214132232.2835828-3-biju.das.jz@bp.renesas.com/
---
 drivers/pwm/pwm-rzg2l-gpt.c | 76 +++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index fa916f020061..6bf407550326 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -31,6 +31,7 @@
 #define RZG2L_GTCR		0x2c
 #define RZG2L_GTUDDTYC		0x30
 #define RZG2L_GTIOR		0x34
+#define RZG2L_GTINTAD		0x38
 #define RZG2L_GTBER		0x40
 #define RZG2L_GTCNT		0x48
 #define RZG2L_GTCCRA		0x4c
@@ -48,9 +49,15 @@
 #define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
 
 #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
+#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
 #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
+#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
 #define RZG2L_GTIOR_OAE		BIT(8)
 #define RZG2L_GTIOR_OBE		BIT(24)
+#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
+#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
+#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
+	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE | RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE)
 
 #define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
 #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
@@ -64,12 +71,16 @@
 #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
 	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) | RZG2L_GTIOR_OBE)
 
+#define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
+
 #define RZG2L_GTCCR(i) (0x4c + 4 * (i))
 
 #define RZG2L_MAX_HW_CHANNELS	(8)
 #define RZG2L_CHANNELS_PER_IO	(2)
 #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
 
+#define RZG2L_MAX_POEG_GROUPS	(4)
+
 #define RZG2L_IS_IOB(a) ((a) & 0x1)
 #define RZG2L_GET_CH_INDEX(a) ((a) / 2)
 
@@ -91,6 +102,7 @@ struct rzg2l_gpt_chip {
 	 */
 	u8 prescale[RZG2L_MAX_HW_CHANNELS];
 	unsigned int duty_cycle[RZG2L_MAX_PWM_CHANNELS];
+	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHANNELS);
 };
 
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
@@ -470,6 +482,69 @@ static void rzg2l_gpt_reset_assert_pm_disable(void *data)
 	reset_control_assert(rzg2l_gpt->rstc);
 }
 
+static void rzg2l_gpt_parse_properties(struct platform_device *pdev,
+				       struct rzg2l_gpt_chip *rzg2l_gpt)
+{
+	struct of_phandle_args of_args;
+	unsigned int i;
+	u32 poeg_grp;
+	u32 bitpos;
+	int cells;
+	u32 offs;
+	int ret;
+
+	cells = of_property_count_u32_elems(pdev->dev.of_node, "renesas,poegs");
+	if (cells == -EINVAL)
+		return;
+
+	cells >>= 1;
+	for (i = 0; i < cells; i++) {
+		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+						       "renesas,poegs", 1, i,
+						       &of_args);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to parse 'renesas,poegs' property\n");
+			return;
+		}
+
+		if (of_args.args[0] >= RZG2L_MAX_HW_CHANNELS) {
+			dev_err(&pdev->dev,
+				"Invalid channel %d > 7\n", of_args.args[0]);
+			return;
+		}
+
+		bitpos = of_args.args[0];
+		if (!of_device_is_available(of_args.np)) {
+			/* It's fine to have a phandle to a non-enabled poeg. */
+			of_node_put(of_args.np);
+			continue;
+		}
+
+		if (!of_property_read_u32(of_args.np, "renesas,poeg-id", &poeg_grp)) {
+			offs = RZG2L_GET_CH_OFFS(of_args.args[0]);
+			if (poeg_grp > 3) {
+				dev_err(&pdev->dev,
+					"Invalid poeg group %d > 3\n", poeg_grp);
+				return;
+			}
+
+			bitpos += poeg_grp * RZG2L_MAX_HW_CHANNELS;
+			set_bit(bitpos, rzg2l_gpt->poeg_gpt_link);
+
+			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTINTAD,
+					 RZG2L_GTINTAD_GRP_MASK,
+					 poeg_grp << 24);
+
+			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
+					 RZG2L_GTIOR_OBDF | RZG2L_GTIOR_OADF,
+					 RZG2L_GTIOR_PIN_DISABLE_SETTING);
+		}
+
+		of_node_put(of_args.np);
+	}
+}
+
 static int rzg2l_gpt_probe(struct platform_device *pdev)
 {
 	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
@@ -512,6 +587,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto clk_disable;
 
+	rzg2l_gpt_parse_properties(pdev, rzg2l_gpt);
 	mutex_init(&rzg2l_gpt->lock);
 	platform_set_drvdata(pdev, rzg2l_gpt);
 	bitmap_zero(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
-- 
2.25.1

