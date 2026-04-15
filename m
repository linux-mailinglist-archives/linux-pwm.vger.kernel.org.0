Return-Path: <linux-pwm+bounces-8590-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJKnLjym32miXAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8590-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:52:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40740589B
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B7173004D39
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE5F175A6D;
	Wed, 15 Apr 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GxxFKP00"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E8344DAC
	for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264634; cv=none; b=a3tytfEMj8NUPmZR2uQmXq0SQQ0oow2UYi7O3ra2Q+5A3u1/QIQWAdWxRL+whixVaQOvibNWBHAU53GmdmkoPLat3yNejAaL2MVWqdu+oS/0mrt7kb4QZPtWZhpsGz3YXSOyJoMcnbsEgA8tRikWjU+URqs4R95jrl8sve8O+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264634; c=relaxed/simple;
	bh=ajSHpn1BNzonBrH5M8RMYAzp3h9B89S9cIWnNvrv9aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDhssLJUhMNxp02UmZfpkRgYKpKtGtxEuBPJmZvMLwDookI4OQxIL+X8IfRPLH7v/jrNkqggrP2RbXjcF8uubEluX12flWURUXmB88nlIhDeeupRUg1jSKFK0wOGqGbZXPqGZsHALi6xYz9UomPe8wCmSwnrJ8gM/7DTKHHtmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GxxFKP00; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso70744145e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776264631; x=1776869431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jExw1zXy4YyTl+OWBiTmhuXsc+HcqG56ZjMjUPEOfbw=;
        b=GxxFKP00ftaHiuuPWc2g/d65OjriVzs6jx18QoGAxHVDPn3KcWnYRqlu9UXxGzdm9H
         tp5UaOw6naKQ+CQcPwLHJWMs23edA8rmhDH2DkVOBZPWryVSR9lLxPGO+vsoXr8ER8et
         Rc7fBe+ln50pfNxWxv/a6OH03qROysMBSPUSm5y/DuEW9rAwnrg1yLvhtiBe5YkvoSbg
         vOVZxlCZ066CUlVp4AbUEAEpV6ze8v1mllCpadFBO+TtrUlSu5GNnck9MJu3FEdKUjQg
         O+qXeY/+z2WzDwImvk4MhQpbLas3rEWMNJEgQEA8EDDvQ4dRu2Y2c/r/pmKL4nAakzEt
         ySkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264631; x=1776869431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jExw1zXy4YyTl+OWBiTmhuXsc+HcqG56ZjMjUPEOfbw=;
        b=ofAK2jl+2/UmHacC9kOCYh0aZhuH5P0SXB344U4I1bBot6WLsWzQjg7Hmb6PJgWK2U
         BlHhIL3hRsSai9l+JE/iewyrocIedwl+6NPLD7spu1Sk4f6iKtXkJ7rHYdONXupZUbRG
         y1uSq4YGbLBV5vHbS77ajD/D7yYwqVSHy3sPaZxI8qibIvUU0q68qequMegdITe7GI7j
         nskFOpnKX14EiGsEHaYvQw59kyIqgmZOB/sJDHjPpe00mPVzFGXXTjVyleMVwO5bDUeE
         Fl7QyPH4krgTvH2je96/pjur0a8qjuW+dmibcvjmrMae+nYuihGtxKKjC63YzqVhu0uM
         dDSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W4k5FbXtqNZwzgCfTsLEMFfWwWAHXfA6/MPxj1ce/wG0LA3in9e2cn0cGjej9HmNyqq1xo+IeM+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkt6l8U6jfFEmz8526TAZb8kX+fHl1nnbKaMOpr3cKv+jeh6e9
	CUzVpc4JqhN1SnHTIK3aXcCXhRR18BPHxUmY4FhvfUIkiFc/xq5RMjul/P1JmmD1MS4=
X-Gm-Gg: AeBDiet+cc4gBfcv/y9mveWJdEtbR3846V/3WjLIitfOWInfzz0siQRRxvTcXS35qPL
	bNCzQ2C92kNHPFISlOQ1PqC8o2IqxH0+7DiZ8ExvKBwgFD5xeZNqBWQpecMsLzU0PN0wJXczoT+
	VOh1BcgRgdwSmjBV7w/BGPzKu+KWQq0MiGUFLSvzpai90ynptg0zmLCECcVam2JYiAamMhLlrFA
	kCouvNLwTWNOVG6dFmv0rRibySAvhAOc11AWJT10WbH+P/etfdo2EaTmB+g+IALArrlSAvWzQki
	A/lVn2o8g2Yq43ZTUdgO6sv4+PBoERM+fPdSYvj1H1eBLbhC8L1oiw7YJuMbsXwQracEFdizuzS
	su27jTDTpL+bi6+F1jToS/mhWkU9FmmvG2IyBYyp1ReljGU/hiey5MdCBVZz+meGhzjHQ+9G1vl
	uHPRQ+kHZ1t983/cfctXlyy25hVG5BLAWb8PVmgAFMDNee8pVCPZ1olvjTI05Ihh4dK1Cr1dezu
	Lghf2ub4sF+wY4=
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488d67f0bb7mr285886345e9.10.1776264631425;
        Wed, 15 Apr 2026 07:50:31 -0700 (PDT)
Received: from localhost (p200300f65f20eb084c777289617ec110.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:4c77:7289:617e:c110])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488f08b960esm37537185e9.0.2026.04.15.07.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:50:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 1/2] pwm: stm32: Fix rounding issue for requests with inverted polarity
Date: Wed, 15 Apr 2026 16:50:12 +0200
Message-ID:  <c5e7767cee821b5f6e00f95bd14a5e13015646fb.1776264104.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776264104.git.u.kleine-koenig@baylibre.com>
References: <cover.1776264104.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3091; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ajSHpn1BNzonBrH5M8RMYAzp3h9B89S9cIWnNvrv9aY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp36Wn3t8V0cwMk6wJp4ND3V1gfyMohb6DSJJWf 9cMInW5qk+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCad+lpwAKCRCPgPtYfRL+ TnNvB/9+W/2Jab6L+30hO6T7u6hyyxLqJfIMDaAjeCbtPY+hhJtBlwYwdwTN0y48ovKKOB6MOpO O5U0WpFLZgrfzUQSxFT0Qzabf2FhdR1jacnbk8+dq2kQau/7hplscF/Uzw18UVDVfOXrUEgAkW2 hax6KpmE81l0DGtEue+aODWW7iyUixYNQJMikXfZvc8tJ+XPotiIuPYqs5nR6+mRq5lbqZBNuPb t2SfQNVVfJ0DysXaNEjCOqyWzkHWboL/gJlRnCpiVJOHG0VuCFdLOAjSVSKJi6SS/LRncLflxVP nq+Whuh9IrMXT/HlXuDLLjB7as8f+w3U0wuqbHkiTaDI+ymi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foss.st.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8590-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: AD40740589B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The calculation of the number of pwm clk ticks from a time length in
nanoseconds involves a division and thus some rounding. That might
result in

	duty_ticks + offset_ticks < period_ticks

despite

	duty_length_ns + duty_offset_ns >= period_length_ns

. The stm32 PWM cannot configure offset_ticks freely, it can only select
0 or period_length_ns - duty_length_ns---that is the classic normal and
inverted polarity. The decision to select the hardware polarity must be
done using the ticks values and not the nanoseconds times to adhere to
the rounding rules by the pwm core.

With the pwm clk running at 208900 kHz on my test machine
(stm32mp135f-dk), a test case that was handled wrong is:

	# pwmround -P 9999962 -O 24970 -D 9974992
	period_length = 9999962
	duty_length = 9974840
	duty_offset = 25123

With this change applied the rounding is done correctly:

	# pwmround -P 9999962 -O 24970 -D 9974992
	period_length = 9999962
	duty_length = 9974840
	duty_offset = 0

Fixes: deaba9cff809 ("pwm: stm32: Implementation of the waveform callbacks")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 2594fb771b04..935257a890b0 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -68,7 +68,7 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned int ch = pwm->hwpwm;
 	unsigned long rate;
-	u64 ccr, duty;
+	u64 duty_ticks, offset_ticks;
 	int ret;
 
 	if (wf->period_length_ns == 0) {
@@ -164,23 +164,25 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 		wfhw->arr = min_t(u64, arr, priv->max_arr) - 1;
 	}
 
-	duty = mul_u64_u64_div_u64(wf->duty_length_ns, rate,
-				   (u64)NSEC_PER_SEC * (wfhw->psc + 1));
-	duty = min_t(u64, duty, wfhw->arr + 1);
+	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rate,
+					 (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+	duty_ticks = min_t(u64, duty_ticks, wfhw->arr + 1);
 
-	if (wf->duty_length_ns && wf->duty_offset_ns &&
-	    wf->duty_length_ns + wf->duty_offset_ns >= wf->period_length_ns) {
+	offset_ticks = mul_u64_u64_div_u64(wf->duty_offset_ns, rate,
+					   (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+	offset_ticks = min_t(u64, offset_ticks, wfhw->arr + 1);
+
+	if (duty_ticks && offset_ticks &&
+	    duty_ticks + offset_ticks >= wfhw->arr + 1) {
 		wfhw->ccer |= TIM_CCER_CCxP(ch + 1);
 		if (priv->have_complementary_output)
 			wfhw->ccer |= TIM_CCER_CCxNP(ch + 1);
 
-		ccr = wfhw->arr + 1 - duty;
+		wfhw->ccr = wfhw->arr + 1 - duty_ticks;
 	} else {
-		ccr = duty;
+		wfhw->ccr = duty_ticks;
 	}
 
-	wfhw->ccr = min_t(u64, ccr, wfhw->arr + 1);
-
 out:
 	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x\n",
 		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
-- 
2.47.3


