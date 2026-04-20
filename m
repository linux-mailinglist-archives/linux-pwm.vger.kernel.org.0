Return-Path: <linux-pwm+bounces-8636-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEYZFXYD5mmBqQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8636-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:44:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD442972E
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90FC030148AA
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0DF376BE4;
	Mon, 20 Apr 2026 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUADfpue"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FAF39B494
	for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681820; cv=none; b=UCI3BEeGZyS4+AOvvYpQP1SQTT7iyQVLL16HlhhE/3BvJiL4NfumAsCIL1pbFxkpUlMrRoqyK/t8d4wVfQgP7fE5ocKQb0h/hD7baSTqNx4rtwiu9e/4ACkxr/Uff9qHakmK8Tig8xTYcjeNPKuhOCh9OTTJPofEAusyJBN5CWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681820; c=relaxed/simple;
	bh=nrDwUsLA26hzIjayJTgFjPGid/cYtDJ5PDB04XhXoKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOhteoIP3dqzhGGD1PTcEUFQv7LZx/nMbw2Kruaic303loC0nTjZLlzabs0HP0HtgbfVJsr1rd+GkJHctJl2JCsmky2LuOAtZiUlH+F2HDuRPjJ51d2ay3akD3z2AOVmTWoKxAnBrLDNE7P9HV5aRkxIccv8NpQcesWxt98i6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUADfpue; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe608cb92so1879095f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681817; x=1777286617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/Csqb4UQrcrof3DTRO1RvzP+CgGq/GLAveFMe3H3iI=;
        b=VUADfpueIZofBYjacztlf7D+NKSH6JXq72sUEpINI4IZ063QYfDAx5dUkwXFnrRX9s
         e5iAp1mUqdhlln22ZwPjRDjryX7YnnJJ/XCmei1xWrYoW77z9GbvmapbEX5cXgOnSEoM
         pEZe4E3nC7QlYfzOO+87tgcpVIdlh+nUDboC4tIHWK8ZJq/nyLiSp+ng5jeuPIGf+d8a
         WGa3s/eCtzpxEjwINZE0AHQP4R9opj7JB64qUdeATmEnt6ZLCb4QuVP+XaYKZGXPevUx
         R8qsxwILOwMQkM41a7Pu0YM7XcflnYE3CQGEsJMvlEHJ1XzeoUpWK2+GIRKwFauBsURi
         o4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681817; x=1777286617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/Csqb4UQrcrof3DTRO1RvzP+CgGq/GLAveFMe3H3iI=;
        b=FAoVhO5vt3ONSDxxj4B303eSMzzkmI4GqznswnvadepBXVOtUmq0mmlg6jLynKFD8x
         d7AcdpdM7RK87rI6wKKIKytyToJ9W6n19wQjusaggD2HssbGpwhKmcKFdoNOJca2ewNH
         X5350aQY8UBwO2ctngr7huNvscyNaThu5mti3I2SAP44rTCPPMduiGW6R1lOJXE62jk2
         euEotdhmi5xTnkkKVQPDgBH1fxcLug4Dt1b2hM/gghiBT+ndY96hPAlgzvBr2NvjH4Jy
         /4ecwh5DiGEbs2kb6z4EWR+qecMRiObXFo1lkp5ozz930ZA6V0IhBGLCNg5PC11wvI4a
         cdvA==
X-Forwarded-Encrypted: i=1; AFNElJ/mBj48z5EOOxO75fXuhmZm3HRXaWkJqQFPYSh4WMANPmoT1aRi0t0y0uD7ZR7HHk39yPbwAVTjzVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbpW2ak+lcXoqsi9WwYNyEvOBTxZoJhEQyO2DL7QVmBg1hHwK
	JduaxlXTW/ZUGt8idyMNqYXBvevk+xaMn/Q9tYPmgLEPMNc7JtbcVt6v
X-Gm-Gg: AeBDietYi41ad+WPa/Snsd6xBnNJn9xQTMg1kdE2U/OEY2NzmY8PNOnCDXGs+KjHSsa
	gitCDDzICDFSooGfH896Z76OmJhXcP4Z0QWlhiacfeULdK/Q49A/NU6nOcpbpDfBJEOWvTJKp/f
	h+3rZXpLJNs7Ann4oGRVCRamLgx7a+trMXLmW9wd6XMCCUY6oB62S3/uftzDVE3TJTVr8HpsPNG
	4jxL/bXOBfJvv5SU3EEMsSx0YphPi9MSGk0m2x+maNN+18630Nfup0DtHA80FTF3f/I0RbsuXUX
	XAjNlFglWdR6BwexUbHyw6MDPgiLl40jY/YnTC+wHCvzmKSEK/tq95ipCj18TpmbALxqNuAeWlL
	HSkBm+VM3AKYp1BMaIK2TLJjan5pHkOiVeBuZUIGm8YcV6JqcXUGRULfxeCBKPRgqaOT6iFRhZc
	UiVF7punoJtTC9GR7wb9QnX949jcHhOUH2mGYoyid2gnMMwt3WGeINrBluDDM=
X-Received: by 2002:a05:6000:144d:b0:43c:fe0e:5bbc with SMTP id ffacd0b85a97d-43fe3dc59a6mr18783496f8f.19.1776681817237;
        Mon, 20 Apr 2026 03:43:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm28038301f8f.0.2026.04.20.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:43:36 -0700 (PDT)
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
Subject: [PATCH v5 2/9] pwm: rzg2l-gpt: Add support for gpt linking with poeg
Date: Mon, 20 Apr 2026 11:43:19 +0100
Message-ID: <20260420104332.153640-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
References: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8636-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 64DD442972E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

The General PWM Timer (GPT) is capable of detecting "dead time error
and short-circuits between output pins" and send Output disable
request to poeg(Port Output Enable for GPT).

Add support for linking poeg group with gpt, so that gpt can control
the output disable function by adding rzg2l_gpt_poeg_init() to parse
the renesas,poegs device tree property and establish links between POEG
groups (A–D) and GPT hardware channels (0–7). For each valid, enabled
POEG phandle entry, the driver:
 - Reads the renesas,poeg-id from the POEG node and validates it against
   the supported range
 - Records the GPT–POEG association in a per-chip bitmap (poeg_gpt_link)
 - Configures GTINTAD to route the output disable request to the correct
   POEG group
 - Configures GTIOR (OADF/OBDF fields) to set both output pins to
   high-impedance on an output disable event

Non-enabled POEG nodes are silently skipped.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5:
 * Updated commit description.
 * Replaced return type of rzg2l_gpt_poeg_init() from void->int and
   probe() checks this return value.
 * Added more error checks in rzg2l_gpt_poeg_init() 
V24 from [1]:
[1] https://lore.kernel.org/all/20250226144531.176819-1-biju.das.jz@bp.renesas.com/
---
 drivers/pwm/pwm-rzg2l-gpt.c | 93 +++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 4856af080e8e..71ae2f891fd2 100644
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
@@ -55,12 +56,19 @@
 #define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
 
 #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
+#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
 #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
+#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
 #define RZG2L_GTIOR_GTIOx(sub_ch)	((sub_ch) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIOA)
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
@@ -71,12 +79,17 @@
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
@@ -84,6 +97,7 @@ struct rzg2l_gpt_chip {
 	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
+	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHANNELS);
 };
 
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
@@ -375,6 +389,81 @@ static const struct pwm_ops rzg2l_gpt_ops = {
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
@@ -426,6 +515,10 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
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


