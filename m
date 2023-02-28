Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5346A5B5D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Feb 2023 16:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjB1PI3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Feb 2023 10:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjB1PI2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Feb 2023 10:08:28 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73514A249;
        Tue, 28 Feb 2023 07:08:18 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,222,1673881200"; 
   d="scan'208";a="154369049"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Mar 2023 00:08:17 +0900
Received: from localhost.localdomain (unknown [10.226.93.131])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 65044400F2C8;
        Wed,  1 Mar 2023 00:08:15 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v14 4/4] pwm: rzg2l-gpt: Add support for gpt linking with poeg
Date:   Tue, 28 Feb 2023 15:07:56 +0000
Message-Id: <20230228150756.482432-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228150756.482432-1-biju.das.jz@bp.renesas.com>
References: <20230228150756.482432-1-biju.das.jz@bp.renesas.com>
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
v3->v14:
 * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
 * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it not only parse
   the properties but also implements the needed register writes.
 * Added acomment here about the purpose of the function rzg2l_gpt_poeg_init()
 * Removed magic numbers from rzg2l_gpt_poeg_init()
 * Fixed resource leak in rzg2l_gpt_poeg_init().
 * Moved the patch from series[1] to here
 [1] https://lore.kernel.org/linux-renesas-soc/20221215205843.4074504-1-biju.das.jz@bp.renesas.com/T/#t
v2->v3:
 * Updated commit header and description
 * Added check for poeg group in rzg2l_gpt_parse_properties().
v1->v2:
 * Replaced id->poeg-id as per poeg bindings.
This patch depend upon [1]
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221214132232.2835828-3-biju.das.jz@bp.renesas.com/
---
 drivers/pwm/pwm-rzg2l-gpt.c | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index f69c2507b4f6..9f3e2f7635a8 100644
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
@@ -64,12 +71,17 @@
 #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
 	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) | RZG2L_GTIOR_OBE)
 
+#define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
+
 #define RZG2L_GTCCR(i) (0x4c + 4 * (i))
 
 #define RZG2L_MAX_HW_CHANNELS	8
 #define RZG2L_CHANNELS_PER_IO	2
 #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
 
+#define RZG2L_MAX_POEG_GROUPS	4
+#define RZG2L_LAST_POEG_GROUP	3
+
 #define RZG2L_IS_IOB(a) ((a) & 0x1)
 #define RZG2L_GET_CH_INDEX(a) ((a) / 2)
 
@@ -89,6 +101,7 @@ struct rzg2l_gpt_chip {
 	 * the register only if there is mismatch with cached value.
 	 */
 	u8 prescale[RZG2L_MAX_HW_CHANNELS];
+	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHANNELS);
 };
 
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
@@ -442,6 +455,75 @@ static void rzg2l_gpt_reset_assert_pm_disable(void *data)
 	reset_control_assert(rzg2l_gpt->rstc);
 }
 
+/*
+ * This function links a poeg group{A,B,C,D} with a gpt channel{0..7} and
+ * configure the pin for output disable.
+ */
+static void rzg2l_gpt_poeg_init(struct platform_device *pdev,
+				struct rzg2l_gpt_chip *rzg2l_gpt)
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
+			dev_err(&pdev->dev, "Invalid channel %d >= %d\n",
+				of_args.args[0], RZG2L_MAX_HW_CHANNELS);
+			of_node_put(of_args.np);
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
+			if (poeg_grp > RZG2L_LAST_POEG_GROUP) {
+				dev_err(&pdev->dev, "Invalid poeg group %d > %d\n",
+					poeg_grp, RZG2L_LAST_POEG_GROUP);
+				of_node_put(of_args.np);
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
 	struct rzg2l_gpt_chip *rzg2l_gpt;
@@ -494,6 +576,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	rzg2l_gpt->chip.dev = &pdev->dev;
 
+	rzg2l_gpt_poeg_init(pdev, rzg2l_gpt);
+
 	/*
 	 *  We need to keep the clock on, in case the bootloader has enabled the
 	 *  PWM and is running during probe().
-- 
2.25.1

