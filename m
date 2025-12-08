Return-Path: <linux-pwm+bounces-7781-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33A3CAD91F
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5B7A304E38E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426162D97BF;
	Mon,  8 Dec 2025 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+ti9FUk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE227C162
	for <linux-pwm@vger.kernel.org>; Mon,  8 Dec 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207303; cv=none; b=DuPEpICOY6CVQnl1BKCwTo1Eg/anQsjdy8uskQlS8Jhs9aerrNrgumS1WwPCFQZMFseToHsc0fvRaf2inq2qCY4AxXocPuE1GIsQkiMEVfOtl2/anS1FKbnhpidNRGaEOteYrkuCKTl6DuChrH2TzGQ4IPSMS/d1Z7zFQpC5sD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207303; c=relaxed/simple;
	bh=ZySL4AaKcPct8+xQngHUl687RLkZDPY5G13LCNOJ9qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAMz3zdP9pXZJxOFX44us200GqNSzm/BKB6Hv56WsdMRwKId7GSkdp+XUvHwmlpgdjTN8UapsXL4xP7aZ1cPRbkJn7kRU/1Mxr/Ctf7XHNWe4k/cVYn8U5f5Knkd1X4KlmyrXwOXtEkmik0/SysIOT7s/kG/rYaXbdxIJAOIUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+ti9FUk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so5550560a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Dec 2025 07:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765207299; x=1765812099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC17qmBanT6eMZ4oYKmegq6u5Sp1tiXwqNyarpnc6Sc=;
        b=G+ti9FUkn6sGR+zQhWGCZd2GcnDXZ+BXdaTuYQ5WXnNsh9xmr19UEB81rOeE1DcdUT
         4JAMK+ltWYb1sH0kic4gdqAa/yC9UUT4qva+BE9+gn4MjMMtQWqQ6K70CVXsfpEGPCFJ
         PcYiqfZkNPEenxlqLqIVaz4yX0Dw44qMCzf8QyFDjtOR+PlVNu6iyQSxW0ee1GXYkam/
         3QhBSSEDZH5eLQu7cc1KZNbVMdly3v4MjQmU3OGsdOSJXJjK7j2Q6E+dow6sznQ6q8E+
         haZkk7hNo8kK/0ilfwyziMEB1gPUaeaIZ1P7wkBIfQ6/AtLgh1A6tFziEaBB3UyQEHqY
         q0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207299; x=1765812099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FC17qmBanT6eMZ4oYKmegq6u5Sp1tiXwqNyarpnc6Sc=;
        b=J/0wBIesFiOLnukhKSJEa84a7ygA9KibunnuHbJtF283/PXGu39n82+YCqdMhRnriI
         yJA8vuWQ5T6bL1/rqqgLXMfAIcYHdmDwVjnjiBopuaIF1dRP4X5tQWrft9T/zxQOEJva
         Lv7xoMsFRLISVlwmQQRthwRkXnoXGihuOba5BEqCnQ4UWvphYh+KgVkBIPFCAKLzBpVb
         ZX489HBEjRLXb4RA4ET36XSyqPdCzXU4Ox6t6FIuUAdcNJWTNEpiHiGMwXM/NR88znPh
         rTqMPFOfyKun3EFAimVv67hDyMC5mQIqBxRsz0v2EtPeAqPGCpduACp16uPFPctNipP4
         KZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVeIc0RtBxknArmK7NVsw6WgOPLNnvn6OXFAMG6J7uZLzumvcOLiU254DfWwe+PVY7JIkkGeoBp2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxLfhN3cPv2ibBtEC3LUxFncFfhxeuE21yKkRvgeh/BdoQ2X9f
	n4ISrKjYSUj/REn7OPLGRCCRoVgmb5ebg/Us9osYdYlxY8d490GUKDu7
X-Gm-Gg: ASbGnctlv2sbhoXXnVp1miFqPej/eFe6jT1g+G1msYTfeox3m17dJxgSzyc8q+6jgmw
	mD/FbKopOKgCHsAKOamCVVUrm1QsJNotmcqtOOo4FEWKSFpPhFDcpnNCLjncrr00c5Q3ZPzClqD
	xk5q5X5lJDrA/mAMzuwnxZkgE8ctgpzPY70z/+WdeATIpGAhfWpfSSC+mSoke/g/P+Bh+rnBl+E
	p+fjhd7Xt32158Koa1CYt5vNyzNulIPfwkaK1hh6BvmmjZjqs0s4dkIwnDlrCwFGCU8svtm8f6U
	9Eu6nfgb0H+ClwbGtNcYxt6Tfs+i7PornmuwtSkDW43ivHZsBJiMSqzylkqPRn3d+SkOKve1k51
	l+tEkocULjb4KhaVt9bQVYLv25M0P7jLbHwFuvTRusRgFZ+DnzW9LmcsX32b9hj4jH+HihjjmFp
	uKtta6U2/XMVHgF951aeJdb5E7Z5siLwPhbO0YsHM8mWtVUYjMj5wGDqSraTyONW0eyoa4C9DRW
	YDSmva9QRyjxoaZ
X-Google-Smtp-Source: AGHT+IEuVsAowzX2HEzzHJz1UT9rGTyNQECkkWfzii1fOwFC1ra9h58iVZ2xBp1lIlJPlUAaEDk5bg==
X-Received: by 2002:a05:6402:1941:b0:640:a356:e797 with SMTP id 4fb4d7f45d1cf-6491a3e85d2mr7239496a12.13.1765207298781;
        Mon, 08 Dec 2025 07:21:38 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412deddsm11547484a12.31.2025.12.08.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:21:38 -0800 (PST)
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
Subject: [PATCH v4 4/9] pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
Date: Mon,  8 Dec 2025 15:21:21 +0000
Message-ID: <20251208152133.269316-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
References: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4.
Add prescale_mult variable to struct rzg2l_gpt_info for handling this
difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Updated commit header and description
 * Renamed prescale_pow_of_two_mult_factor->prescale_mult
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 5a8e5a3eb1b1..47324c9fa6dd 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -79,6 +79,7 @@
 
 struct rzg2l_gpt_info {
 	u32 gtcr_tpcs;
+	u8 prescale_mult;
 };
 
 struct rzg2l_gpt_chip {
@@ -221,6 +222,7 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 					      u32 val, u8 prescale)
 {
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	u64 tmp;
 
 	/*
@@ -230,15 +232,18 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 	 *     < 2^32 * 2^10 * 2^20
 	 *     = 2^62
 	 */
-	tmp = (u64)val << (2 * prescale);
+	tmp = (u64)val << (info->prescale_mult * prescale);
 	tmp *= USEC_PER_SEC;
 
 	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
 }
 
-static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
+static u32 rzg2l_gpt_calculate_pv_or_dc(const struct rzg2l_gpt_info *info,
+					u64 period_or_duty_cycle, u8 prescale)
 {
-	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * prescale)),
+	return min_t(u64,
+		     DIV_ROUND_DOWN_ULL(period_or_duty_cycle,
+					1 << (info->prescale_mult * prescale)),
 		     U32_MAX);
 }
 
@@ -249,6 +254,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	bool is_small_second_period = false;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
@@ -287,7 +293,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	}
 
 	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
-	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	if (is_small_second_period)
 		return 1;
@@ -295,7 +301,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
-	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
+	dc = rzg2l_gpt_calculate_pv_or_dc(info, duty_ticks, wfhw->prescale);
 	wfhw->gtccr = dc;
 
 	/*
@@ -489,6 +495,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
+	.prescale_mult = 2,
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-- 
2.43.0


