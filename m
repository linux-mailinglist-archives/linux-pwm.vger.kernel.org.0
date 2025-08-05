Return-Path: <linux-pwm+bounces-6956-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B9B1AEB6
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 08:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69351883522
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A921CA08;
	Tue,  5 Aug 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMv6k4+R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881171C861A;
	Tue,  5 Aug 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376638; cv=none; b=frmeHPRdBNOzQsfExjv5pfpYdXXEbmU0NapIpTjeabLRFPrA0eaT2Qg2JQBII6lpnVOHCJvmlZPKhlRzbBmaIrnb0G+RJ0uciogDl4uSwf/WG83yZF10w0hu7mZJJHHdd0u+AJVZoH1ET7XseuFNtiB3SGtwiDgsSrmhCzH4i3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376638; c=relaxed/simple;
	bh=RZzlgIO+JE/YFit6aIGokGuiJRZOXnKLXopnjx3NpEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGslF66yxYyXAUjS+eO96c5RS0RHCcJ74+JwiXjLJwQtch2oFLPKK+NtxafyB1C5C+bzgUJIcNmretMrmbffqBavXAEg7bPubvOoJCMKXVhqcesDbTirpby7KynYSxnick0H8aGhe3GZLOtlxSvnufihWQyxm8tVvwt1FTsSGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMv6k4+R; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so2917181f8f.1;
        Mon, 04 Aug 2025 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754376635; x=1754981435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6ynWmoIA9ihbPYhi5mb1DyN9mzcjr5p37HseCckTHU=;
        b=WMv6k4+RbnqNNogL3//N0uXWAbUyFmxj7rhzMtBHTk+al2WzEmYNYQRV5UYeiI1Bds
         r+nB+w3itO00Z8jDlUSUAP1N5cub93vX0R2WeL5mQunm2ML1sHuUayxPWdStvq4n63WW
         r+ljFdFou8r1jTtelRE3ZjPx9wHsiLdq4crFAkfWzOvXGJYxaED2dqRPMZq4suctQFaq
         D1aXHvlArBR61DFP0LL3XMMiE6JG1E5p8SuiXV/5IFW3K+O2LBohFTeKLbN8DtAZdAqL
         9vEaQA1gUiNgVk4qtJg7JLTknlXLA9zAE70nk3NEqX7K2NwCgmx57SGmA1SPZMAjtkLK
         3fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754376635; x=1754981435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6ynWmoIA9ihbPYhi5mb1DyN9mzcjr5p37HseCckTHU=;
        b=TTrMk6sYC1lul9GSmxL0z87c4iWAm0yxiMygtngzmUSaRRBPg447BZipyNrnjCR/s8
         G+RWGyoxrQl90Mc34wG2o1R5FGdODLeIJTXSTuXlSqvZ11xoXVy94dGgJqXm1UZYaRpk
         Xe80p0C7eYBEYvuznEoD1j4khM1MSO2VITVHHGTkws6RRD41mIoB+YFfkxbmAUerSYfI
         y/7HLuGkVWMnv2YzSUu9W8drr6qyrxaAY/l2PAuAypzFOb8dXhfeZXUeD9MMliMLarFH
         mNwWMv1dhGGkRT87zHUbn8wYb8RgR3ODiO2e4XDWzLTgX68cePj/l2lyS4k3SaRd44G4
         Ql1w==
X-Forwarded-Encrypted: i=1; AJvYcCUwriWn2c+Vt/k6ArAv2P2//US9sAW8wuM6FYF3MRQ8gCk7h1uj6CYEJf1mKjxtbIhquYzuR5C4bsj6cNI=@vger.kernel.org, AJvYcCWIYjF3+ExYhL21lEfhM4LAP+t3mw+brshE45Wbax3zlQxNNpzo8ZaLPovHqvp5TSoFrcLg6348oyl+4jM0CveO95U=@vger.kernel.org, AJvYcCWQE9ne3MCWezWmoOOS0CBj9O8wOFe4cu5+OFEVKRcXoBn9rKVl7NGJPCldrLAT1iuMnGhjPI1J7Voa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9bS1TIsglVkKgFyVmCTDB/udM++4Q1FiUIGi0RY6CQDEht+1K
	f5WgmKB3o0t0sxQXL1qvV2U/xdxAqMascAtzNU1xzDWG8vkS8gExdQms
X-Gm-Gg: ASbGncvHa3eJbpQCw4kiZq8AwSnmvRgbtVDpSSZjjFvAtGDFAczChzAmPVn67eoK0L/
	qOd5B+JyYs3b9XOXJkcfwpcilJP6U0S6uKBagU9viwFne9I8cf4A+OCktQIHsgUGg4OoxmcplCm
	EN5kK2d9SG/A90ubcNDKkCfo2ok0HIr4EBIQ/l9kwN6pxmk4FrCgHHquaWJdiZE4Tyz+wevRVmK
	vPMCZGPl5vdsOguT1QUj70FRJV6UsCkPrYRh64dG1T3oKC5Rq4Qi+YqyJzWDjWfj9XUxZmoFVFL
	TrvfSSLP3NNeiYqg1zEDkQcs8fU+YsW0FUg77n/Qtq6Y+HifrX+tOwYL3VpyQLGQh9ZUihUc8Ud
	jyScwoOdi2fjI8FhCGnt8cDcCBnlwEcdmgbcnXtCTa36ZVeGezVUcH2hnf5bfOx6PC0JcU2zyUw
	==
X-Google-Smtp-Source: AGHT+IG53rfelXQMCgJOa+PFjMzcmfDjqOPDF6v9Nz1EsaQG+btuwM9TGcw+gfH2eNi0w2ygKzMZVA==
X-Received: by 2002:a5d:4110:0:b0:3b7:9b4d:710e with SMTP id ffacd0b85a97d-3b8d94aae54mr7701353f8f.38.1754376634518;
        Mon, 04 Aug 2025 23:50:34 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b9159e00sm120410945e9.9.2025.08.04.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:50:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] pwm: rzg2l-gpt: Implementation of the waveform callbacks
Date: Tue,  5 Aug 2025 07:50:23 +0100
Message-ID: <20250805065032.193766-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Convert the rzg2l-gpt driver to use the new callbacks for hardware
programming.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c | 174 +++++++++++++++++++++---------------
 1 file changed, 101 insertions(+), 73 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 360c8bf3b190..a34a541da8c3 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -86,6 +86,13 @@ struct rzg2l_gpt_chip {
 	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
 };
 
+/* This represents a hardware configuration for one channel */
+struct rzg2l_gpt_waveform {
+	u32 gtpr;
+	u32 gtccr;
+	u8 prescale;
+};
+
 static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
 {
 	return pwmchip_get_drvdata(chip);
@@ -190,8 +197,10 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 	/* Stop count, Output low on GTIOCx pin when counting stops */
 	rzg2l_gpt->channel_enable_count[ch]--;
 
-	if (!rzg2l_gpt->channel_enable_count[ch])
+	if (!rzg2l_gpt->channel_enable_count[ch]) {
 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+		rzg2l_gpt->period_ticks[ch] = 0;
+	}
 
 	/* Disable pin output */
 	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0);
@@ -215,54 +224,38 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
 }
 
-static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-			       struct pwm_state *state)
-{
-	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
-
-	state->enabled = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
-	if (state->enabled) {
-		u32 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
-		u32 ch = RZG2L_GET_CH(pwm->hwpwm);
-		u8 prescale;
-		u32 val;
-
-		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
-		prescale = FIELD_GET(RZG2L_GTCR_TPCS, val);
-
-		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
-		state->period = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val, prescale);
-
-		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
-		state->duty_cycle = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, val, prescale);
-		if (state->duty_cycle > state->period)
-			state->duty_cycle = state->period;
-	}
-
-	state->polarity = PWM_POLARITY_NORMAL;
-
-	return 0;
-}
-
 static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
 {
 	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * prescale)),
 		     U32_MAX);
 }
 
-/* Caller holds the lock while calling rzg2l_gpt_config() */
-static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
+static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_waveform *wf,
+					 void *_wfhw)
+
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
-	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
 	u64 period_ticks, duty_ticks;
 	unsigned long pv, dc;
-	u8 prescale;
+
+	guard(mutex)(&rzg2l_gpt->lock);
+	if (wf->period_length_ns == 0) {
+		*wfhw = (struct rzg2l_gpt_waveform){
+			.gtpr = 0,
+			.gtccr = 0,
+		};
+
+		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm))
+			rzg2l_gpt_disable(rzg2l_gpt, pwm);
+		return 0;
+	}
 
 	/* Limit period/duty cycle to max value supported by the HW */
-	period_ticks = mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz, USEC_PER_SEC);
+	period_ticks = mul_u64_u64_div_u64(wf->period_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
 	if (period_ticks > RZG2L_MAX_TICKS)
 		period_ticks = RZG2L_MAX_TICKS;
 	/*
@@ -277,13 +270,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			period_ticks = rzg2l_gpt->period_ticks[ch];
 	}
 
-	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
-	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
-
-	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, USEC_PER_SEC);
+	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	wfhw->gtpr = pv;
+	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
-	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
+	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
+	wfhw->gtccr = dc;
 
 	/*
 	 * GPT counter is shared by multiple channels, we cache the period ticks
@@ -292,6 +286,58 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	rzg2l_gpt->period_ticks[ch] = period_ticks;
 
+	return 0;
+}
+
+static int rzg2l_gpt_round_waveform_fromhw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw,
+					   struct pwm_waveform *wf)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_waveform *wfhw = _wfhw;
+
+	wf->period_length_ns = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, wfhw->gtpr,
+								  wfhw->prescale);
+	wf->duty_length_ns = rzg2l_gpt_calculate_period_or_duty(rzg2l_gpt, wfhw->gtccr,
+								wfhw->prescale);
+	wf->duty_offset_ns = 0;
+
+	return 0;
+}
+
+static int rzg2l_gpt_read_waveform(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   void *_wfhw)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	struct rzg2l_gpt_waveform *wfhw = _wfhw;
+	u32 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	u32 ch = RZG2L_GET_CH(pwm->hwpwm);
+	u32 gtcr;
+
+	if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm)) {
+		gtcr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
+		wfhw->prescale = FIELD_GET(RZG2L_GTCR_TPCS, gtcr);
+		wfhw->gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
+		wfhw->gtccr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
+		if (wfhw->gtccr > wfhw->gtpr)
+			wfhw->gtccr = wfhw->gtpr;
+	}
+
+	return 0;
+}
+
+static int rzg2l_gpt_write_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    const void *_wfhw)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_waveform *wfhw = _wfhw;
+	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
+
+	guard(mutex)(&rzg2l_gpt->lock);
 	/*
 	 * Counter must be stopped before modifying mode, prescaler, timer
 	 * counter and buffer enable registers. These registers are shared
@@ -310,14 +356,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		/* Select count clock */
 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
-				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
+				 FIELD_PREP(RZG2L_GTCR_TPCS, wfhw->prescale));
 
 		/* Set period */
-		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), wfhw->gtpr);
 	}
 
 	/* Set duty cycle */
-	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
+	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), wfhw->gtccr);
 
 	if (rzg2l_gpt->channel_enable_count[ch] <= 1) {
 		/* Set initial value for counter */
@@ -326,44 +372,26 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		/* Set no buffer operation */
 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
 
-		/* Restart the counter after updating the registers */
-		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
-				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
-	}
-
-	return 0;
-}
-
-static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   const struct pwm_state *state)
-{
-	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
-	bool enabled = pwm->state.enabled;
-	int ret;
-
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
-
-	guard(mutex)(&rzg2l_gpt->lock);
-	if (!state->enabled) {
-		if (enabled)
-			rzg2l_gpt_disable(rzg2l_gpt, pwm);
-
-		return 0;
+		if (wfhw->gtpr)
+			/* Restart the counter after updating the registers */
+			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
+					 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
 	}
 
-	ret = rzg2l_gpt_config(chip, pwm, state);
-	if (!ret && !enabled)
+	if (wfhw->gtpr && !rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm))
 		rzg2l_gpt_enable(rzg2l_gpt, pwm);
 
-	return ret;
+	return 0;
 }
 
 static const struct pwm_ops rzg2l_gpt_ops = {
 	.request = rzg2l_gpt_request,
 	.free = rzg2l_gpt_free,
-	.get_state = rzg2l_gpt_get_state,
-	.apply = rzg2l_gpt_apply,
+	.sizeof_wfhw = sizeof(struct rzg2l_gpt_waveform),
+	.round_waveform_tohw = rzg2l_gpt_round_waveform_tohw,
+	.round_waveform_fromhw = rzg2l_gpt_round_waveform_fromhw,
+	.read_waveform = rzg2l_gpt_read_waveform,
+	.write_waveform = rzg2l_gpt_write_waveform,
 };
 
 static int rzg2l_gpt_probe(struct platform_device *pdev)

base-commit: 4b53f8d76cbedfd7c2a2eccb5f1cd85ec6c5a8d3
-- 
2.43.0


