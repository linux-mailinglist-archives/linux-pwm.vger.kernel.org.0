Return-Path: <linux-pwm+bounces-1577-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFB85C512
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 20:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C86B24FC4
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C26F14A0B6;
	Tue, 20 Feb 2024 19:43:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D46A8D5;
	Tue, 20 Feb 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458227; cv=none; b=Dva4PhgQR4VHkiamWPQGlB5x19+U6jag24Mu0cLN01+RT6761gtVBl33LoR2cJVv183jTITK5VOcAfQxoVoSlHPy1N7o/Q9Fc1yxO7A16kBFzXDODp4LLr1XRpwJ+W5joMWpDamW7CSJZp9w3MRSHQhs0/fZQHVPufz0RmgdNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458227; c=relaxed/simple;
	bh=v6TM7e/E9AXwqW8WFLxVsXU9NvoMm4n/Q6ipHdxV9t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQkQv66JrzBgPrbzx4l+OK8Kn4qBawfeHGoMogoF0hvEbauXEXbnhzP8t00TV6vpwzJsmJP8XjeNtkCY5M4ZbGr2hQ0CyJkV1OonF/tk6jJLGnnLMEXFC7vZZ47A9M+RJuAfmv+xJoXFfAXHUMyq7kR9HjMqDlVIZ4UjX+9jRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,174,1705330800"; 
   d="scan'208";a="198557854"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2024 04:43:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E724D40031D1;
	Wed, 21 Feb 2024 04:43:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v18 4/4] pwm: rzg2l-gpt: Add support for gpt linking with poeg
Date: Tue, 20 Feb 2024 19:43:18 +0000
Message-Id: <20240220194318.672443-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
References: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The General PWM Timer (GPT) is capable of detecting "dead time error
and short-circuits between output pins" and send Output disable
request to poeg(Port Output Enable for GPT).

Add support for linking poeg group with gpt, so that
gpt can control the output disable function.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v17->v18:
 * Moved bitpos near to the user.
v16->v17:
 * No change
v15->v16:
 * No change.
v14->v15:
 * Updated commit description by replacing "This patch add"-> "Add".
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
 drivers/pwm/pwm-rzg2l-gpt.c | 82 +++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 0dc8163ee92b..de2926395a5a 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -32,6 +32,7 @@
 #define RZG2L_GTCR		0x2c
 #define RZG2L_GTUDDTYC		0x30
 #define RZG2L_GTIOR		0x34
+#define RZG2L_GTINTAD		0x38
 #define RZG2L_GTBER		0x40
 #define RZG2L_GTCNT		0x48
 #define RZG2L_GTCCR(i)		(0x4c + 4 * (i))
@@ -48,11 +49,17 @@
 #define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
 
 #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
+#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
 #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
 #define RZG2L_GTIOR_GTIOx(a)	((a) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIOA)
+#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
 #define RZG2L_GTIOR_OAE		BIT(8)
 #define RZG2L_GTIOR_OBE		BIT(24)
 #define RZG2L_GTIOR_OxE(a)	((a) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
+#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
+#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
+#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
+	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE | RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE)
 
 #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
 #define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
@@ -64,6 +71,8 @@
 	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
 	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
 
+#define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
+
 #define RZG2L_MAX_HW_CHANNELS	8
 #define RZG2L_CHANNELS_PER_IO	2
 #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
@@ -73,6 +82,9 @@
 
 #define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
 
+#define RZG2L_MAX_POEG_GROUPS	4
+#define RZG2L_LAST_POEG_GROUP	3
+
 struct rzg2l_gpt_chip {
 	struct pwm_chip chip;
 	void __iomem *mmio;
@@ -85,6 +97,7 @@ struct rzg2l_gpt_chip {
 	u32 user_count[RZG2L_MAX_HW_CHANNELS];
 	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
 	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
+	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHANNELS);
 };
 
 static inline unsigned int rzg2l_gpt_subchannel(unsigned int hwpwm)
@@ -444,6 +457,74 @@ static void rzg2l_gpt_reset_assert_pm_disable(void *data)
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
+			bitpos = of_args.args[0] + poeg_grp * RZG2L_MAX_HW_CHANNELS;
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
@@ -511,6 +592,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 		}
 	}
 
+	rzg2l_gpt_poeg_init(pdev, rzg2l_gpt);
 	pm_runtime_put(&pdev->dev);
 
 	mutex_init(&rzg2l_gpt->lock);
-- 
2.25.1


