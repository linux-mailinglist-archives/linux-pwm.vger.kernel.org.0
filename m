Return-Path: <linux-pwm+bounces-7065-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4713DB26F1D
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 20:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCE3562BB8
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D423AB88;
	Thu, 14 Aug 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn7Tk2VR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB92309B0;
	Thu, 14 Aug 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196883; cv=none; b=rAmQkyR2rReIcxucSBs1liJh0tq1O7gFTsW/EVq3jI704D9ucqWuIMQPUMa/yEOxGFgOk9LuDrwinEyVpwNTIpahOo1nGXo124LbqD0q9YSmPrgN1CF8Dem9ZbKUQ4+bu0GtNt7rx4KXLzJDopHClM+4wYHfsrt34lpIgy/ZgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196883; c=relaxed/simple;
	bh=6vn1+wZkNtbvDhSSPowJXWhlwH664kiOtVWN5S+M7ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzZtC5UYqyDgMwgxI7GoGhVRIyhgmvE2HHZO2wM8kXLoiKp66a1+V9XewuQ/0TxGoJLlNF2dsAsT6rkfGvbNmcjXvxfyrTtH7lxcztlyjIEgg1l5guZwz2/4yyOE62zmVApr/wKwscFjKBDIeeQ5di8nKgSug7u3VvRtMtHyc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn7Tk2VR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b004954so9120455e9.0;
        Thu, 14 Aug 2025 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196880; x=1755801680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8K/ROQh3Tjz4xO7596husJI9J7hKXNq0i/Y5M+mi7M=;
        b=Nn7Tk2VR1wcgYDJzsWzClLwDp3ww+iEOmR6CnqxCs1+3h1apZPveS/1KFYIJIQE+iy
         NnpPJCYh1Gr4kFE/Clx0WIqcaFx3HaNZx47ztAJCXDinC3bzfkNb/xF1jl8ZjPeR1djj
         2sErcvgJpJdO+A1CYI5Ene8LUCCJeQwnmlxPKtAAVMp/NIRYT+IxulAypZtuA8PIEpPX
         uYRfpQb1m7n9g4d/CRuzQQgLfzSMj4xVEXWrabwxKhB921hoVGBDMr3pqpXQRJdT2QAc
         L3ETPsN2/9chSQcgLEchgjGlj4w1sMS74PPSRMd+ldO43DqOwZX+JHmdFkjYMoiyLL+J
         NXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196880; x=1755801680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8K/ROQh3Tjz4xO7596husJI9J7hKXNq0i/Y5M+mi7M=;
        b=iBxgBSt28dMaDLx0IYgq6HLOnm1tf7y5vEAXAeU5l9NnBxjX6xj8FZ2A3jPQ2EorCY
         NhOt5P8GsJCGk5AgkCGp5KVytgRiTsC25y4GJW/PoOPnI/FM8PlB4SyvfHtnWtg/kAw0
         Wu4YMAsyEUMg2mUm2joA3wcXCwZOv09pnc58NkonZWMv8Thd/Z6tp4aE830sEcjOdHVs
         TD8GKaFJny4eDaZmj5W/CbsV0Twg8v99c2ZNoa05grkmHRG/y8Mr7b8Hl+sf6hYOFSuT
         nzzTlvtD1b3pJlAkJx+g4wpk8I+8S0M/PoVpQDeTXSC8BikX+Sne0V7xVdTOx7I+Mstk
         gnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzVNqHI73M/Pg9FmeOCXQYwgC1f2RbKOJWgla2/1hTgGSnusT9owSkQSW0IkdLQApXSlT6pb+u9MD2W8lNG5Y9tiw=@vger.kernel.org, AJvYcCX+zkgfKFrIWHCsSg/K3JMgkSad5nK5T1qZXgMxp9oe7rN/dGHQ0m089X8ijBKxk+KiZvCzRTarJawkZUU=@vger.kernel.org, AJvYcCXvZ3sAY3VNirn2aXF++P5cLT/cY3me3snJ93mzqVZ4qx1M5WRaJd/Z7OPIdwp/LY3vwKqoagEqDHYF@vger.kernel.org
X-Gm-Message-State: AOJu0YyL87+EeseIF7aTwJsXEFVvO9di0/2ougjMgSbaILDN73f8dTvI
	zGsgaKtxTowjqpDnll7GyjTTnbb0zt8sOtXUCmIIZ03pmfGMWggkMRGF
X-Gm-Gg: ASbGncvKdz0Px4SAme/OTf1TqZeaSDUNRZG/nzjJA8GYYHjMRkMf6RoyZ3tNngR9+FN
	9x76nTi0FJy/E/I/gVXKC+pIIAanolPYp/rgx7s/HJ9T2askbjsKRU7YtYX6uaOg/ahBhTHX1UG
	w0DDmmLPQyjWeW+5O5V1JgZgY0S3H1PbjT+5qmTfiPXZmX07YI4yFVCLRGRnlk9sEOjhPn1TQLs
	8rKZJw1+uUGL48nhfbbkALsILVbeXOJfQrKfX6fIVOUhIHMv/wZhlhx/XZaObFFdiznztZ+8+R8
	7ZyD1ekE7UlTelmWRNjlv1m2gZKQngyy75dkDb5bsYsxVPRPYIRNzaYuq/v0WriQTKsPbHEH6tb
	gN/2qvHbQzZM712zcmWCSUdHqW27FssaucAQ2l3IDPcSTdDh0JYgrnEkEBg6V1codHOE9RJXt7Q
	==
X-Google-Smtp-Source: AGHT+IEPfawES6cJJJ8hPfR5FmxhaqIqHtlkP7bieQqszjVQvQMxkK9wgHsu+0s939lZ3UNj4uEs8g==
X-Received: by 2002:a05:600c:470d:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45a1b61ea12mr35938585e9.9.1755196879590;
        Thu, 14 Aug 2025 11:41:19 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm53744383f8f.40.2025.08.14.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:41:19 -0700 (PDT)
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
Subject: [PATCH 3/7] pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info
Date: Thu, 14 Aug 2025 19:41:07 +0100
Message-ID: <20250814184115.192930-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
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

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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


