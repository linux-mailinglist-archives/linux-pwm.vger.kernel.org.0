Return-Path: <linux-pwm+bounces-7269-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4F8B4A710
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7F94E608B
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCE3287507;
	Tue,  9 Sep 2025 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khzi6jBD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10135284B3B;
	Tue,  9 Sep 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409156; cv=none; b=FZx1DliUrlYg59mNLVACYYiQAeNEybI9/DZBlycYmAyTe2XCLjk42hAPlUvEiL57Mudt103czp9oGqRgM9Sk/wT8/I18WWBApOc3kz85OMrRFe/qUB9p28FlvPDNqvz9V3t0EgmsLzZFmxsyhPqfQSPtzByDWuujCt0tAVt85Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409156; c=relaxed/simple;
	bh=iaVrUZVAGtIDDo7CrJ99ZmVFWRx5LBGc89EHHd9+jTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlmAAJ3xysA2owtuHkcZE+c3DVFOi5M2x43ckxqGGMUWSUKi0N/omOc2ctSWxdDhIjAdbobx4tP6pI9shghdqZtEshV7MSaT0vm95EEsdbLsZ/9FBIZVdMk9B1T5KR/yPhXWzJKzryksKpwf71HjGfNbHtH0t+dlNWt/uh7Ms9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khzi6jBD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso3263029f8f.0;
        Tue, 09 Sep 2025 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409150; x=1758013950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmrSlLjkNOQrq8mOEczlTxlQvJ7lcou1Etlwq2uNfJY=;
        b=khzi6jBDU4/bDCsTBfHFpN6bIEm/NjC4PbnYGt61HlqpB98qWPESRqqq0/A611JDph
         936kWw6GyLKjao2RNU1m4qkfpLCLZbloJJvW7UcrJx4mNtxbQ/Jl2kdssgZ+4X1Ni0Y4
         FYRUN8aeEFmwi+PQIUNcLON7sUiFlX1W/ehWT3k1NtKnbWRJalXqtumV7scJ0KWfMXs2
         qELH1isC5XMDjUaaeLsjxqlmfkMPUJV8nGMzxjOQ7iuLfTgNcGB/SUHhgF+61PSrX/iS
         6e60FttYED2I02/+80s5ntoNHY6Y4b3iQ7t9M+t2RvuBdlAlu55yvWQEH818EI9/8ZDe
         PwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409150; x=1758013950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmrSlLjkNOQrq8mOEczlTxlQvJ7lcou1Etlwq2uNfJY=;
        b=Ja5qTPMnCJn3Qr3ANHUFACVFxybweXX59/Se6g8xE70B0uGowsj8vEhmigJwp2ikBB
         wmaHYUryuXkq6WhxYhhp0BSjW5NWOGI4JGdDB1YkVI/AMUiFLgEUS6uw4nlYVETEPjQX
         wTkw964skQOPHKufrbe4KsXAlnQkJEH53vdXquFx5vMQcBT3UzbEjoxR8Xd63dg4dY8D
         KOvkQ1rgkid1qoIJT+spc+aIKLC0x7q0Y8Wb2N13+HwZflYJA/LWrmEGwMpbeI4HKkFb
         xU60FH93WOI/gdTZPDSize6HhVZ85Yqw/MrqPHlucNflTB9N8iV3ivmgvQrHrhpN4vie
         sfjw==
X-Forwarded-Encrypted: i=1; AJvYcCUG0bUckNWON15RReFVd2R7c3ihfS5Uz6qmzNFnfPvVBEr58G/hFdyOIdaDrnXYrxKDeZE1j+/zpejVRHwvUFHQeQs=@vger.kernel.org, AJvYcCUYN4pFJtJhn67P7IQG73oda+My5qUv2LqWqkD3pjsZkFE23ZuKgUSW4dN6PeS08V2M7+XGzNfsI14F7A4=@vger.kernel.org, AJvYcCWcc9N0sxdqZHTv7SIPPBllqye0MYN7gjOuT2OBYGauMKlqhrz3EItVA4KVH9uZpwQS6iLLcUfw/gBx@vger.kernel.org
X-Gm-Message-State: AOJu0YxypgiaMKxeUS5QnCFI543kxzRvGEHvxa4uvRZlBre2i1GThpmK
	ousL7fvlOBOi7jjWrQEJa7toDCoUF2QB5yPxd2JLjdx8hmhjDC/Vfqfe
X-Gm-Gg: ASbGnctN8W369vMgVS/4OmO2w9bqdO0EwtksBNmGxalgeydgP692zO4VcMepwwD5qjJ
	HrLN8LjrVG9JLw5qn4/wRmGuX1S3zRiAeeX6P2RZ2Z/SIJe5XS4r8Pe3sRIxe/YPWjnEMeiuwEf
	hgHRSgCYdz9rZ1SyBKeG5BQ4fH6ikpUJwgBe5RH7FvvuZQma/qTMG4NHI4clysL27piRWZ3YDN5
	mTDzpsHP7OroDoumvBun/uCXKvKuemrnafdn4L8ptACfkA95aC7w385C4HSKe87kxzE3ZvmKJLM
	HLZHOgtK0bWsSI/H9WSnfQH8RauV+xI6bknjJy9GsAFw5At7ze7B09S/dZESDMwCPI8vwk1z01E
	V2jXhNJI1eWC+XPUiWl7KleegIQgz4jGsJxLYaSnKg1xjbzN2X9j5pZLdm8fRpJgPMsN+4l2Hea
	g9Gk/pi2J0NbmC
X-Google-Smtp-Source: AGHT+IFDsZqw02vEByOKMEv/UGLYz2ZEcUyPHaw7tQpEgp6x8v/e6K+eJZCANhOlh1VtOzj3T0wc1g==
X-Received: by 2002:a05:6000:178b:b0:3d1:721:31de with SMTP id ffacd0b85a97d-3e636d8fb10mr8931403f8f.7.1757409149986;
        Tue, 09 Sep 2025 02:12:29 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45deff68b43sm6975685e9.2.2025.09.09.02.12.29
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
Subject: [PATCH v2 4/8] pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info
Date: Tue,  9 Sep 2025 10:12:14 +0100
Message-ID: <20250909091225.128658-5-biju.das.jz@bp.renesas.com>
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

RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4.
Add prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info for
handling this difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index bf989defa527..74bb0cca4ab4 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -91,6 +91,7 @@
 
 struct rzg2l_gpt_info {
 	u32 gtcr_tpcs_mask;
+	u8 prescale_pow_of_two_mult_factor;
 };
 
 struct rzg2l_gpt_chip {
@@ -226,6 +227,7 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 					      u32 val, u8 prescale)
 {
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	u64 tmp;
 
 	/*
@@ -235,15 +237,18 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 	 *     < 2^32 * 2^10 * 2^20
 	 *     = 2^62
 	 */
-	tmp = (u64)val << (2 * prescale);
+	tmp = (u64)val << (info->prescale_pow_of_two_mult_factor * prescale);
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
+					1 << (info->prescale_pow_of_two_mult_factor * prescale)),
 		     U32_MAX);
 }
 
@@ -254,6 +259,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
 	u64 period_ticks, duty_ticks;
@@ -287,12 +293,12 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	}
 
 	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
-	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
-	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
+	dc = rzg2l_gpt_calculate_pv_or_dc(info, duty_ticks, wfhw->prescale);
 	wfhw->gtccr = dc;
 
 	/*
@@ -477,6 +483,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.gtcr_tpcs_mask = GENMASK(26, 24),
+	.prescale_pow_of_two_mult_factor = 2,
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-- 
2.43.0


