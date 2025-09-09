Return-Path: <linux-pwm+bounces-7266-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52FB4A73A
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A534E7EFA
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 09:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67312853EA;
	Tue,  9 Sep 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOBz7EAv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D762836A0;
	Tue,  9 Sep 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409153; cv=none; b=MjPXTJ9trW+ZE+j16gqGgTy2I8swfSMR64motiNd53KvItIwnegTxjHUrPiI/OThRQbJjdz6fG2m48JcS/b3bJgO339GPA7AOANCbCBVttABuwhB2biUZmJNhpGzK3kpuWc46/ZOJaz2GDtQWi2hnUReJtRldrDAx2w8oLaDXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409153; c=relaxed/simple;
	bh=CD5TKTl60f59ui6oMqmOSPYLW3fVTGaIxChtgxNCvjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emrAxDcecb4/4mQ0D7pShCyqFVPSmlFIZ1jiTOl1Mv4SUfh2e05Pt1I6wyLPRgKxzh5USZTyDMd2JaFOQpRGgQKG9e+fzx1plP110Ns9XhCxJl+xmatsje5cPyXYQFKbmcQZyHwixmCPz92X1MjeHaNDS5B/MHb2aPljyfrjiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOBz7EAv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so32602875e9.0;
        Tue, 09 Sep 2025 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409150; x=1758013950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGJk7K1akBqE6qsrgLgR6jEWXdy2HPxkeMtdUCK0+9E=;
        b=iOBz7EAvfz3vtC+AiOPAmSb2IWn8xBvJ5U8sthajdF1+Genai+7w0ZAW3fKYJ1T9cM
         49+JgQmJZ121wMVpfGQsgsH6DgRrnOjM9zsHBZrQ51tX5oodR1AijnIyJbuIgY4C/mOB
         LaV81z/BDJ7KKO0S/18Frmbd83F2IKVhVHR+Y2YuHf8GJ1BytZD132LPNhEN9mPrheSC
         J/3qWh7cK9JIvExhSoE1YK3obOvCY7ftemwX9RQ/L9/HZNwudH4XTtYyPcgS7XJxKDt9
         wCCHG+vKN0QMwc7HFjzJzEbkwrB6cjDE52RnjfTX7lL1RZA/9lBgjE+sLjzlNML1M7LB
         /3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409150; x=1758013950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGJk7K1akBqE6qsrgLgR6jEWXdy2HPxkeMtdUCK0+9E=;
        b=tzosjvHwi7o9p8jADOVPi5C/YmWd2+avsB7IciUNXOKPDdyksetTrcdq5SVb5HU4HA
         Vc0sth5FrnifsEErIBBID7rHu0V/gHJOZCGf/erAS1qNSkVGE8czKZs7shUXHNaK2XKw
         xzYjeKPf/NUbGmPQMwRLqLfA4BpeADYgedeIi6cnN67/UjMloufNA43A46GN5RGVy/20
         /zMNsUvTg1PXBc8znVRrEdOSxZ8UjJadpKJCXmuyrNZ5XMtDozgT1fE9adgOWglivNk9
         Rt/gdBqNy9NbhCjF1fSGhkuztYgwfQNLya2+EZIKuIEb1N1SOjCHOg5SveCX7DnKDc/p
         IqfA==
X-Forwarded-Encrypted: i=1; AJvYcCUh4pTskBEMoL9cFn+4nRS5L1RAljVoA7wFmAygILLccPrylFhlN9PA0Oz4U2DkQ2dfS/SpB5oHgATF0nA=@vger.kernel.org, AJvYcCUh5FjQJOacQw4x6Pn+VaS0YpPIu6ULhg103emTN9a1R87k5ZtsPoII9f9zwfuOedZUEtiljkSlPeOE8Jqllarrkno=@vger.kernel.org, AJvYcCW9WGnbiw5svEkdFzRDIrciif2OVhcJGHg+pCpo6gmVS0ivDCI4R1oLu3Lx1JP9XLfEEl+onWPPJzsw@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeWsqUm/y/ftAOhTZKxdtDEOlkanYW1DVcr2DvEsVttCtSQCx
	NoT+J5+o/UG0M1w7Sb9SwnK76+ReVtJxr3V3hDa+sF4fR8ntE4jNoiGo5db9AyL1
X-Gm-Gg: ASbGncty6DJb2O90MzzhPNJhjIQBNuGD8EhRuQdD6pOgXIFLNWEM3L/w77qRYnisP0Q
	AQ0RhuzV8vxYfixJjKm4DlIeUnlPiyxBqlY9iTOYbfAWyi4DzXDMJVKkLDR5e7J70A8tEl+2HGA
	EDN1nKVtRoEGALnRMOVFy+YDk63rO7L9jk2yxVokeYtTUgAI3J0FRpMHBC1iAkuUdwHek4dHnqe
	CtZpZTdBhGuXWORTra+n4784pGFn3A9nEL+qWVdXwm2n6cwlc6K4pdqAX7rH54qJo/vX6ukPvhl
	NJHvgRQyPR1MLtX/T7xibD+1PHz+hu0LDDbAMx3F3fJToNf3/XWMHp+elkMllwghNFWyNDtcyx9
	H8MmnQCXHilFBb/eJ8RaseZNsvB+phYxihg8VLpwsJpiUoJ1z5ohId3HD32D3uneVGXlsccH0XN
	//bA==
X-Google-Smtp-Source: AGHT+IH/0xWQQRjCJvI9a5G4CElnBmMoFP90PM/UIwbkpIhgisj8FMt44fGk96r3wkUlq+x6v7YbtQ==
X-Received: by 2002:a05:600c:3512:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-45dddeb8e58mr92956095e9.12.1757409149426;
        Tue, 09 Sep 2025 02:12:29 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45deff68b43sm6975685e9.2.2025.09.09.02.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:12:29 -0700 (PDT)
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
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v2 3/8] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
Date: Tue,  9 Sep 2025 10:12:13 +0100
Message-ID: <20250909091225.128658-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091225.128658-1-biju.das.jz@bp.renesas.com>
References: <20250909091225.128658-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E GPT IP is similar to the one found on RZ/G2L GPT, but there are
some differences. The field width of prescalar on RZ/G3E is 4 whereas on
RZ/G2L it is 3. Add rzg2l_gpt_info variable to handle this differences.
The FIELD_PREP and FIELD_GET macro is giving compilation issue as the
parameters are not build time constants. So added Non-constant mask
variant of FIELD_GET() and FIELD_PREP().

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index f0a8531457ca..bf989defa527 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -33,6 +33,19 @@
 #include <linux/time.h>
 #include <linux/units.h>
 
+/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
+#define field_get(_mask, _reg)	\
+({\
+	typeof(_mask) (mask) = (_mask); \
+	(((_reg) & (mask)) >> (ffs(mask) - 1)); \
+})
+
+#define field_prep(_mask, _val)	\
+({\
+	typeof(_mask) (mask) = (_mask); \
+	(((_val) << (ffs(mask) - 1)) & (mask)); \
+})
+
 #define RZG2L_GET_CH(hwpwm)	((hwpwm) / 2)
 #define RZG2L_GET_CH_OFFS(ch)	(0x100 * (ch))
 
@@ -46,7 +59,6 @@
 
 #define RZG2L_GTCR_CST		BIT(0)
 #define RZG2L_GTCR_MD		GENMASK(18, 16)
-#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
 
 #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
 
@@ -77,9 +89,14 @@
 #define RZG2L_MAX_SCALE_FACTOR	1024
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
+struct rzg2l_gpt_info {
+	u32 gtcr_tpcs_mask;
+};
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
+	const struct rzg2l_gpt_info *info;
 	unsigned long rate_khz;
 	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
@@ -317,7 +334,7 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 
 	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm)) {
 		gtcr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
-		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->prescale = field_get(rzg2l_gpt->info->gtcr_tpcs_mask, gtcr);
 		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
 		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
 		if (wfhw->gtccr > wfhw->gtpr)
@@ -354,8 +371,8 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
 
 		/* Select count clock */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), rzg2l_gpt->info->gtcr_tpcs_mask,
+				 field_prep(rzg2l_gpt->info->gtcr_tpcs_mask, wfhw->prescale));
 
 		/* Set period */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
@@ -414,6 +431,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rzg2l_gpt->mmio))
 		return PTR_ERR(rzg2l_gpt->mmio);
 
+	rzg2l_gpt->info = of_device_get_match_data(dev);
+
 	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
@@ -456,8 +475,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg2l_data = {
+	.gtcr_tpcs_mask = GENMASK(26, 24),
+};
+
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-	{ .compatible = "renesas,rzg2l-gpt", },
+	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
-- 
2.43.0


