Return-Path: <linux-pwm+bounces-9251-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nBSoF+FPIWpaDAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9251-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:13:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E107963EE60
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:13:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cmnueLEj;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9251-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9251-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D750530C07E1
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F773FE645;
	Thu,  4 Jun 2026 09:57:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB283FE640
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:56:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567021; cv=none; b=Asq6LppVrJow/p50qCKqpN1jJKo3nhdXbsAD5cDx0Im3afP7Ry/d7KgT4WmZjYGzuK8K5VPjTA8ICtzkysbQFFKl/ibduegOPwJYwJuzIxkEWCVLmFwV2XizqVUSHVo1yJMdaXxk+PeeerOFD9XvgGGDjmgzwPAYaHW/A92h2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567021; c=relaxed/simple;
	bh=uEIhjPWjaq8rpVHKXdCy1CAe3eGcNxikkPVyLTDFfXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1TfRfepRZH5csrSdPTBwJxSOHUtO6nORoNxLAu18C+7MDTBNU917dVVjy2R2wxgKzmt6SrTv5poUWenhkwSmad34rBrZ/i545SbK3Wu7Lr4JipKbGGH/GrCzaBqkZjhf7CQF9K4W4XIbw2pL4wmg7/dLc1egGX75gtW5/HLpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmnueLEj; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490a765d410so5590455e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567018; x=1781171818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eeFO3Vk65Lc6zMxBzrYaIBsCoZCZ8S4g/NBNLR0pfQ=;
        b=cmnueLEj3QSK0Ka0ch/KgtaMcKA3aBaMGI1dz1YJs29ik2aRadf+fNMaQh//BFvSyU
         h7ruSorqZ8n+Nsphl6hsOEOKYrJ3HJO+UMEKRt9ytPSL3OevkannfFLAb99L5Jec1w4b
         SKobBwSfUj7ZN1Zx+ergJbxRSnhzm6dHWcHz0KZrkCexAEZ4eTgQ6RqfKVdl6PJJ1YcI
         qzsFydBAlPpkpT6+kPvozldWos8raxtKJnzybKQWV4/cLpKpW+eYV3LOZOmd/tFdw6nP
         s2RMPegRev55nuu5sl1wUabxR3A7K19a7aWWtF8jBfJIOwYWJju5RBytVYcAZgQhxViL
         3BSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567018; x=1781171818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eeFO3Vk65Lc6zMxBzrYaIBsCoZCZ8S4g/NBNLR0pfQ=;
        b=kmjAqNM+YnzIalljoyZ3fBdvvZDxaOsCpf71z5qTdw7aDFD9fRFmwHRlh9v9Guex7T
         CyXJR5IevHITB037elNr0FWSSVqaFrQD4Xs4LApdH9iJDJLXBMvcFRm3GfIPvDoWGpX2
         JASXorKw+S1KWWvwgSklj3wLxewfM3aSWsNKd33Mh1n8oe6MKUPgkw58Td2wOA363yD+
         H/EN/UExDh6+c9Go+45RyGv2jm3NOuLRKQuBL+6hUPu2dcd3vHD4wvrhZD3kEuR1INTt
         QO5jwR0uUiKuP8sTqAOg5difsu0LWm6sNLXfxBI6L0TiRIu5IXXXSp5DUK5L7L0VfTx1
         +vBA==
X-Forwarded-Encrypted: i=1; AFNElJ/cuFzw1ZsdpvKA6BFQhneSqcc2jpNT4m7FaCRy2pffTL/AFi+UeXcyyDpoKLyYBfVdPGk9uv+JAss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydWcEkL1xaVAjdUzrQTDS3XGtH3ZPm+eOh0oalDUjr3q3Yqzn
	cP0kKrdIPsawNz7Q/8KetV9SL2/dEZ1BaIWHCU5DsQduGfEWFCVmlkZy
X-Gm-Gg: Acq92OGoMakbX1aUf7uKHj6lV8zoLFMbMZhpXoaD0akQYc8gzfaeDMsG8n7vRhLWbRm
	UdLzAQaCMAh8z38tBwdtKuDBubKA9uYa+puBX3lPW124FvdzOHpxMHdQ7FAM/9EngfUaCyGYDqh
	vOeExlQkfdxEVoC98x9Q+tqGjrwT6fCvOOeua4qU0UKp+XrBxG91gKP1/eIlzPid/W9n355y1tx
	tT97GJwT0SOwIDTq0pi6/4QPbEIrezWToWauQpG7/bJ+W/RlI+hdV/63MARv5MB2zqrYQOx9nt3
	6/37pajV07XzgZ/AViQdj2FYHBjyZwmhEi30i47NpOTVydpabrzAPBcCkldseC7QDX+Ql6dYaEh
	xDXE8luhnkCfFPLnYz89ybzvcK2OHqYgDv/V3kyZtH2HKGNTZ5h3r8x1e5C1AWfnWGawlNK1dHT
	Pes6gGEchEe7t3MahdBMxdu1E4XeUg+03V7toQjLuFJvWNqjARCBJMpekLXb4=
X-Received: by 2002:a05:600c:1381:b0:490:a1be:6b01 with SMTP id 5b1f17b1804b1-490b5e64659mr120340375e9.4.1780567017574;
        Thu, 04 Jun 2026 02:56:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v6 08/11] pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
Date: Thu,  4 Jun 2026 10:56:38 +0100
Message-ID: <20260604095647.108654-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,glider.be,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9251-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:geert+renesas@glider.be,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:linux-renesas-soc@vger.kernel.org,m:tommaso.merciai.xr@bp.renesas.com,m:geert@glider.be,m:bijudasau@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E107963EE60

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4.
Add prescale_mult variable to struct rzg2l_gpt_info for handling this
difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * Dropped extra parameter rzg2l_gpt from rzg2l_gpt_calculate_prescale()
   in rzg2l_gpt_round_waveform_tohw().
 * Updated comment in rzg2l_gpt_calculate_period_or_duty().
v4->v5:
 * No change.
v3->v4:
 * Updated commit header and description
 * Renamed prescale_pow_of_two_mult_factor->prescale_mult
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 3ee5a70ca265..4f3b4dd959e6 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -92,6 +92,7 @@
 
 struct rzg2l_gpt_info {
 	u32 gtcr_tpcs;
+	u8 prescale_mult;
 };
 
 struct rzg2l_gpt_chip {
@@ -234,24 +235,29 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 					      u32 val, u8 prescale)
 {
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	u64 tmp;
 
 	/*
-	 * The calculation doesn't overflow an u64 because prescale ≤ 5 and so
-	 * tmp = val << (2 * prescale) * USEC_PER_SEC
+	 * The calculation doesn't overflow a u64 because,
+	 * prescale ≤ 5 for info->prescale_mult = 2 and so
+	 * tmp = val << (info->prescale_mult * prescale) * USEC_PER_SEC
 	 *     < 2^32 * 2^10 * 10^6
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
 
@@ -261,6 +267,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 					 void *_wfhw)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	bool is_small_second_period = false;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
@@ -299,7 +306,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	}
 
 	wfhw->prescale = rzg2l_gpt_calculate_prescale(period_ticks);
-	wfhw->gtpr = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	wfhw->gtpr = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtccr = 0;
 	if (is_small_second_period)
 		return 1;
@@ -307,7 +314,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
-	wfhw->gtccr = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
+	wfhw->gtccr = rzg2l_gpt_calculate_pv_or_dc(info, duty_ticks, wfhw->prescale);
 
 	return 0;
 }
@@ -353,9 +360,9 @@ static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
 	return 0;
 }
 
-static u64 rzg2l_gpt_calculate_cycles(u32 value, u8 prescale)
+static u64 rzg2l_gpt_calculate_cycles(u32 value, u8 mult, u8 prescale)
 {
-	return (u64)value << (2 * prescale);
+	return (u64)value << (mult * prescale);
 }
 
 static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
@@ -363,6 +370,7 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 				    const void *_wfhw)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	const struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
@@ -418,6 +426,7 @@ static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
 		 * value for both channels.
 		 */
 		rzg2l_gpt->period_ticks[ch] = rzg2l_gpt_calculate_cycles(wfhw->gtpr,
+									 info->prescale_mult,
 									 wfhw->prescale);
 	} else if (!wfhw->gtpr && rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm, NULL)) {
 		rzg2l_gpt_disable(rzg2l_gpt, pwm);
@@ -580,6 +589,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
+	.prescale_mult = 2,
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-- 
2.43.0


