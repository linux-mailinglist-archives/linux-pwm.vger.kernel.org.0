Return-Path: <linux-pwm+bounces-2986-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50E94BE60
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2024 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF628D3EF
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2024 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B718DF94;
	Thu,  8 Aug 2024 13:16:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16118DF71;
	Thu,  8 Aug 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123010; cv=none; b=tBeWXLHZUaLuq9YIek4WxYSbu3ctZxHhAUyvmUKP6xvi4l3LzI2dmx5BWV4PgPrmbj3ZDK9qoGqT4sd24yvXiOiFtnM0A+2H2k2jypjTea4Pa4+HYtCfxx5EAHAiKDdDG57u1HiLeK3xUTFK7J6va1nPjCU/PTpPQ62VbgMhH+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123010; c=relaxed/simple;
	bh=oDGQ7ZC0lz1iojfA8GQTXBW47C7WXL7zk1MEAeLZric=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q03Mp6a0TvxPh8bFox45J+NEUgYvZZtmmdCCR/NRi9YXm4B25sZXpipjnCK3qTstfZ0HD8VoaulIQ0FOPemC/gx7zAD3S36oB422nRTDGTOf1a1gAVWvOZPZJ7rzcxRhc23Egaqsttm7RyDHobhYbNRdpOUHIoIgQQkh7VI/pkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.09,273,1716217200"; 
   d="scan'208";a="215122095"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 08 Aug 2024 22:16:47 +0900
Received: from localhost.localdomain (unknown [10.226.92.225])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A6588427A697;
	Thu,  8 Aug 2024 22:16:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v21 4/4] pwm: rzg2l-gpt: Add support for gpt linking with poeg
Date: Thu,  8 Aug 2024 14:16:20 +0100
Message-ID: <20240808131626.87748-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
References: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
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
v20->21:
 * Dropped local variable offs for calculating RZG2L_GTINTAD channel register
   and instead using the macro RZG2L_GTINTAD(ch).
v19->v20:
 * No change
v18->v19:
 * No change
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
 drivers/pwm/pwm-rzg2l-gpt.c | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index b4fc6a44d869..d0f6bb111d1d 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -38,6 +38,7 @@
 #define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTINTAD(ch)	(0x38 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (sub_ch))
@@ -54,11 +55,17 @@
 #define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
 
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
@@ -70,12 +77,17 @@
 	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
 	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
 
+#define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
+
 #define RZG2L_MAX_HW_CHANNELS	8
 #define RZG2L_CHANNELS_PER_IO	2
 #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
 #define RZG2L_MAX_SCALE_FACTOR	1024
 #define RZG2L_MAX_TICKS ((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
+#define RZG2L_MAX_POEG_GROUPS	4
+#define RZG2L_LAST_POEG_GROUP	3
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
@@ -84,6 +96,7 @@ struct rzg2l_gpt_chip {
 	u32 user_count[RZG2L_MAX_HW_CHANNELS];
 	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
 	bool bootloader_enabled_channels[RZG2L_MAX_PWM_CHANNELS];
+	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHANNELS);
 };
 
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
@@ -412,6 +425,72 @@ static void rzg2l_gpt_rpm_put(void *data)
 	}
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
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTINTAD(of_args.args[0]),
+					 RZG2L_GTINTAD_GRP_MASK,
+					 poeg_grp << 24);
+
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(of_args.args[0]),
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
@@ -507,6 +586,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 		}
 	}
 
+	rzg2l_gpt_poeg_init(pdev, rzg2l_gpt);
 	pm_runtime_put(dev);
 
 	mutex_init(&rzg2l_gpt->lock);
-- 
2.43.0


