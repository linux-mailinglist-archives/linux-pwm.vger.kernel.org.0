Return-Path: <linux-pwm+bounces-7653-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40147C7AB88
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6023A1149
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765234C144;
	Fri, 21 Nov 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FznR1xtQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3042BEC44
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741331; cv=none; b=EaazLCSK9X1mOEDhVjOt+TZa2bR/YrcVfY1o0+WohtBjzL//a1zkfpudDaSQvaYYaikSwHQ1OPLRgVV6MBotgWjFUZOxt5BhjnufmkUa4UDerZens6GWGdskgZTXZL2C4gVGkAsSrvfFdUjJje2MlWmi7XyPjmgRyJTWlZYIa3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741331; c=relaxed/simple;
	bh=UceBvl9mvJOOEGtnw5s3Ldt6TQ9x8yChblPWkYoFcFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfi+vOr/oqJ7B8FSoY3ZPdGzLE3QFlTKV9QM2QDxwp8xon0SgKmnkRQMmGF5p8TjdmqTbPHoeRJL1/46hRicU0VnIwppK1gTxzNbDO16mh3s/tl76bL1jybzhdU92AlTThHdawE2K9h0hg706+XUAwfsU+9ej6hlnsb1M2jPMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FznR1xtQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso15867065e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741327; x=1764346127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ktRUdOyc1/Pkzhkit+EBK/qIa002X/NMnov9ZgFcQM=;
        b=FznR1xtQOUvl1M60JWZ0DINV/PituXEc0F5JzZ+Kmx0GOGNZsZyiq2yMMuAPFuoQjx
         ey3ZMIwBXtYroYHcpVKS43NLcLLy/ZoORMV8Im59X9x+RvlC5s1HP1QYxbHDlt8QfPrl
         HCkyxNvGeQPePcViLdXPrnIIX4zZulPnjbX3rHPwQREkSLVWPuNHp+OxS7q53HSzjifu
         eYPgbEwk8GRpWzV8C9J5+Lzieb56Q84wz88aa1VgTP5xSaBhLUj+SFVXrxm09ARCVAIR
         9/l9yQZGIIAG5G52gccvNPsqlUX+E86Was/onq8i9pNiquPVDOwkoxFRJ9e6XgBflpbF
         0D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741327; x=1764346127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ktRUdOyc1/Pkzhkit+EBK/qIa002X/NMnov9ZgFcQM=;
        b=wyNqBtY2Val3MNwudGfaD9jqrj4kVCJKmSDG/v80o7/OXJa0PnWodmOIg5nWj/J/db
         /3/Qu3/8BnI8E7ulyZsw4j+71fE4sjxie8rDMEtxLaD+/acHBnyHq9ib9cL3GH0b389k
         6iPiYx90DG/zR+MCh8SmpTaZ2NwWUGVN9iTK5yJswFn+fx9UR0UPTb7BeGlzlWNDK+yh
         PNuliZsAR0zbysqyrFLTpLyGUWVKI4c31RgW0XKSKDfjQ95hs4aVLPpNoCbfl9n9mb9W
         v6d242gzaZ8oz1NnxwQdZF25b5H2x03m9jgQg19KQwN9eH+Eyk69gUY0dTjGo2yf4ohE
         5ezQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDcMqLguewEjUoPbyqPSkkWAaNHteS3E/VK5u5SQJWX7V7Jp83pcD1rFXuD9Jae0gg4htWugL1zCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEf/20MWUSJSN/ewYsG4Jtzb8PWT8CzBveRCusqQzVOY4TQq/9
	avVgE8oL3SjbLmoD3vuvKompQg7g+NS7HONcQzV1Z5DvHVkUrnaWHD4z
X-Gm-Gg: ASbGncv3OzMP4vIVL1XxCq6vE5/q1/JBu87Kda2bMj8gbRRGdHJygg+GbXinopkHdZq
	1PCTTZ6/MDlj5ig1COIDODIAb+ZsGRrIII6A8OuZagkiOqTAZSe/uQMU2oGUFTTjUSNiDlgFZ89
	MuBgjeIyVbEImik6iD7M7U6SkN11CCdinnJxwByXutMvHA7+M2IsKNWq49cQzMvZ/UDnsmucn3y
	/UCYlMVgw8dTa7CXJHJW7TZnNhndkOTT2fXLj0A5wa+/AxrpjbruBG2POBB/gaZ9n2qqx9/dYFP
	X/otj3Z6k9xWiGQGpjwcUeJKGBWBQVJkKlVb4mpk6P3E4+x0U3UzF1UHZR18nHmGSRO/bPMNa+5
	+T1511F4XbMytVAos5IrNg8d2Ywy61z9c6uc7s4b5qjheO6DVDWAnQBrjlCMVBipkxCne57qQt4
	ZvwunFAIs2M17bxMreGkrLx40erW8GGRUVJHYxs3fqjpXRbIirAkfeaMCD6FfKL1xtGJ5MC0k=
X-Google-Smtp-Source: AGHT+IGeQLaJrOaryWX2zfybKGWRFkJj8o+7i+WWm75ml8zvuOq2KxA2FJ7ZumY7I2XL5wodC/woiA==
X-Received: by 2002:a05:600c:3553:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-477c0170782mr27021165e9.8.1763741326760;
        Fri, 21 Nov 2025 08:08:46 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:46 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v8 02/15] pwm: rzg2l-gpt: Add support for gpt linking with poeg
Date: Fri, 21 Nov 2025 16:08:09 +0000
Message-ID: <20251121160842.371922-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The General PWM Timer (GPT) is capable of detecting "dead time error
and short-circuits between output pins" and send Output disable
request to poeg(Port Output Enable for GPT).

Add support for linking poeg group with gpt, so that gpt can control
the output disable function.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
V24 from [1] -> v8:
 * Replaced return type of rzg2l_gpt_poeg_init() from void->int and
   probe() checks this return value.
 * Added more error checks in rzg2l_gpt_poeg_init() 

[1] https://lore.kernel.org/all/20250226144531.176819-1-biju.das.jz@bp.renesas.com/
---
 drivers/pwm/pwm-rzg2l-gpt.c | 95 +++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 38ad03ded9ce..aabd2d576231 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -39,6 +39,7 @@
 #define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTINTAD(ch)	(0x38 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
 #define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (sub_ch))
@@ -55,12 +56,21 @@
 #define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
 
 #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
+#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
 #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
+#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
+
 #define RZG2L_GTIOR_GTIOx(sub_ch)	((sub_ch) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIOA)
+
 #define RZG2L_GTIOR_OAE		BIT(8)
 #define RZG2L_GTIOR_OBE		BIT(24)
 #define RZG2L_GTIOR_OxE(sub_ch)		((sub_ch) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
 
+#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
+#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
+#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
+	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE | RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE)
+
 #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
 #define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
 	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
@@ -71,12 +81,17 @@
 	((sub_ch) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
 	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
 
+#define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
+
 #define RZG2L_MAX_HW_CHANNELS	8
 #define RZG2L_CHANNELS_PER_IO	2
 #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
 #define RZG2L_MAX_SCALE_FACTOR	1024
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
+#define RZG2L_MAX_POEG_GROUPS	4
+#define RZG2L_LAST_POEG_GROUP	3
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
@@ -84,6 +99,7 @@ struct rzg2l_gpt_chip {
 	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
+	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHANNELS);
 };
 
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
@@ -379,6 +395,81 @@ static const struct pwm_ops rzg2l_gpt_ops = {
 	.apply = rzg2l_gpt_apply,
 };
 
+/*
+ * This function links a poeg group{A,B,C,D} with a gpt channel{0..7} and
+ * configure the pin for output disable.
+ */
+static int rzg2l_gpt_poeg_init(struct platform_device *pdev,
+			       struct rzg2l_gpt_chip *rzg2l_gpt)
+{
+	const char *poeg_name = "renesas,poegs";
+	struct of_phandle_args of_args;
+	struct property *poegs;
+	unsigned int i;
+	u32 poeg_grp;
+	u32 bitpos;
+	int cells;
+	int ret;
+
+	poegs =  of_find_property(pdev->dev.of_node, poeg_name, NULL);
+	if (!poegs)
+		return 0;
+
+	cells = of_property_count_u32_elems(pdev->dev.of_node, poeg_name);
+	if (cells < 0)
+		return cells;
+
+	if (cells & 1)
+		return -EINVAL;
+
+	cells >>= 1;
+	for (i = 0; i < cells; i++) {
+		ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+						       poeg_name, 1, i,
+						       &of_args);
+		if (ret)
+			return ret;
+
+		if (of_args.args[0] >= RZG2L_MAX_HW_CHANNELS) {
+			dev_err(&pdev->dev, "Invalid channel %d >= %d\n",
+				of_args.args[0], RZG2L_MAX_HW_CHANNELS);
+			goto err_of_node;
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
+				goto err_of_node;
+			}
+
+			bitpos = of_args.args[0] + poeg_grp * RZG2L_MAX_HW_CHANNELS;
+			set_bit(bitpos, rzg2l_gpt->poeg_gpt_link);
+
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTINTAD(of_args.args[0]),
+					 RZG2L_GTINTAD_GRP_MASK, poeg_grp << 24);
+
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(of_args.args[0]),
+					 RZG2L_GTIOR_OBDF | RZG2L_GTIOR_OADF,
+					 RZG2L_GTIOR_PIN_DISABLE_SETTING);
+		}
+
+		of_node_put(of_args.np);
+	}
+
+	return 0;
+
+err_of_node:
+	of_node_put(of_args.np);
+	return -EINVAL;
+}
+
 static int rzg2l_gpt_probe(struct platform_device *pdev)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt;
@@ -430,6 +521,10 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (rzg2l_gpt->rate_khz * KILO != rate)
 		return dev_err_probe(dev, -EINVAL, "Rate is not multiple of 1000");
 
+	ret = rzg2l_gpt_poeg_init(pdev, rzg2l_gpt);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to link gpt with poeg\n");
+
 	mutex_init(&rzg2l_gpt->lock);
 
 	chip->ops = &rzg2l_gpt_ops;
-- 
2.43.0


