Return-Path: <linux-pwm+bounces-8640-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCoLOYoD5mmBqQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8640-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:44:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F6429759
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 12:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39445301A092
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7346139D6F3;
	Mon, 20 Apr 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrELNSXo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BD39C012
	for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681824; cv=none; b=kihdXyFDTkg45E/+B8H9o94j8kY54ZzHfqREt27B4I06JugrS85pcvCIvQOWbVNJvIjE37DyFlEeOGySRBjX5UKD7dFwvgkEgPogiKFIaFhnC2stVs3o425SSv6egmP7gZRTlneFWS7aIfb4m+yIPOY5MrzGAESGVGzD4gr33gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681824; c=relaxed/simple;
	bh=V6vPZIO14rznHl4RSRcL1gjxUChfhoafHLXw4fi8css=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVSl/Q4dRerW8MuEl2VNlw0wHljJ/tyXl+5Xi6QEY2P70eV7Up7AeJsaEpgMmmjwI+Qjrk2wZ/qJuWuNDKMCkrny8KIHq59RAyTKPvv7xgMf0EtzaOvN4ehWlEE3wLl6ecOrJdHV/G3ms4S9gSaLsmKUdduz6Pw2gWpWwA8fCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrELNSXo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891b0786beso8091125e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 20 Apr 2026 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681821; x=1777286621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdTM6lxXBPg35ylfZyqHqOCqKgb9cxeDIMetQfd6nAs=;
        b=qrELNSXogwaUF9nnsxcGOC8ZbOIwdjSg6KGzByj3eWxQOx5CxwaXBgiKRS4TpaeyOv
         DxUv7ECn10X5DvKQotVCGAabW0rtPUTP+eRVuCJ/yJGaaS7p/vVfLqsOf4GTchEdgINb
         DcynT8Y2Ghb/1L3DfgoIHYbNM+3Pxnm926XF1cLxbkfMd0YXF7u2xbxeuFS8VHH7bFAI
         I+Bqie6zUOFHM1KZpFn09ITEzPK87ebMz+AlURnzwahQuLw1bBX2xqlyaIBw6rwrA3o6
         jZGNJX0Fnf5XJwm7We2hGvcAJ4cMsmxERG6KRbRkkIa/Zz1y/YXlQOQgH+VVnaHZcXT2
         nBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681821; x=1777286621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdTM6lxXBPg35ylfZyqHqOCqKgb9cxeDIMetQfd6nAs=;
        b=VCUbxeewZvCQ8ScPK8vLdZXKbSJ6jJcjD1yDySu/Sq1HvC9XVxeIGbkrvRkucosuYd
         5snWbiMMcF+T2EIzr0U5r4QeVwRDoF/XT4uEsyDNfrWBu9NEVwNLYtImTyYRi7opjdBA
         JkM7KxBMLHoJpU0jAIQKXMENzVvlciTEfoja1Ye3p3S0BfQUIsNq//YU5gr4l4H22cXX
         2jBngcYgBaR5+QatOClySl1U5ZQJtT2CvuwhOnN3nl3ij9N21XmErZhV5bYoWTK19qC0
         NwaW7D545HYbRyqnXgCYktHOZHQ9kqJzdCC5D6J0InseOqWvWSeTf1/D/u23KbAuifNi
         XxYw==
X-Forwarded-Encrypted: i=1; AFNElJ829uQwkPhE1yptidE4HpRFvu3b4ZjFfGpFXLCY/59Uq3Slf3OTjAcrKhuCabZMl4FEW+PJ6gGsOWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKP8JAJYF+b3BhUpS+tJLUZzOnCPCuKYTJWd1d4idy6yWYD4yx
	kwYqIyEBK7fcKEzHw+N7z6ILG4f60MzrADpYcPMiBwArAE5zsgcy6+QC
X-Gm-Gg: AeBDieuxvnMHw9GHa1U2fe/f7SRXKkPi8hwJmHp4uZ45qlqOrOOFcaBT1zbWTdn9FQP
	28MXA7FzUzcri7iTWY6oETkGmlYmV2cgzRdqeX92EkHOrYnsq5op84dK3+yTm7hAxHcRwndJLrK
	bWHcO1KTEByvebDl5EYFYeLB0nLfhM3zNpvaWqe/4N25Bl6i72q8wNZxOgsGFbuENZH4WSoUZ1v
	AQ6QBsgA+GaVLqI7w1Rldn17o27quIn5AL0lTUnyDf3OnsWNsrNQcqJFxl8YIQ8UozXvuGrj3/T
	DUFxD9YZlE9EFzQ+oT8DpWXx4PSPEGaYmsyZT5GDKxuh9/G9upHuncbYjmLGfIbGQEv3YkN1Ffr
	5XG7VYTDA3gArLZPlY22lkp3dQoweYuuKcUUoX5g7biXFEBiC7LHYCgvwV9xnAR8iAJCFbcA0eN
	wmAkDKLtMcaDJ+Aa5RdCeT3YigfUFNMpmjoXU1oGLpngSRv47x+YPakv0JglmBVz4akzjD4g==
X-Received: by 2002:a05:6000:26cf:b0:43d:6787:992f with SMTP id ffacd0b85a97d-43fe3db2d27mr20233365f8f.10.1776681820855;
        Mon, 20 Apr 2026 03:43:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm28038301f8f.0.2026.04.20.03.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:43:40 -0700 (PDT)
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
Subject: [PATCH v5 6/9] pwm: rzg2l-gpt: Add prescale_mult variable to struct rzg2l_gpt_info
Date: Mon, 20 Apr 2026 11:43:23 +0100
Message-ID: <20260420104332.153640-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
References: <20260420104332.153640-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8640-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,glider.be,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA7F6429759
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4.
Add prescale_mult variable to struct rzg2l_gpt_info for handling this
difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
 drivers/pwm/pwm-rzg2l-gpt.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index af594c1ce536..4324ffc8629d 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -92,6 +92,7 @@
 
 struct rzg2l_gpt_info {
 	u32 gtcr_tpcs;
+	u8 prescale_mult;
 };
 
 struct rzg2l_gpt_chip {
@@ -234,6 +235,7 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 					      u32 val, u8 prescale)
 {
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	u64 tmp;
 
 	/*
@@ -243,15 +245,18 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
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
 
@@ -262,6 +267,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	bool is_small_second_period = false;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
@@ -299,8 +305,8 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 		}
 	}
 
-	wfhw->prescale = rzg2l_gpt_calculate_prescale(period_ticks);
-	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	wfhw->gtccr = 0;
 	if (is_small_second_period)
@@ -309,7 +315,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
 	if (duty_ticks > RZG2L_MAX_TICKS)
 		duty_ticks = RZG2L_MAX_TICKS;
-	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
+	dc = rzg2l_gpt_calculate_pv_or_dc(info, duty_ticks, wfhw->prescale);
 	wfhw->gtccr = dc;
 
 	/*
@@ -582,6 +588,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
+	.prescale_mult = 2,
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-- 
2.43.0


