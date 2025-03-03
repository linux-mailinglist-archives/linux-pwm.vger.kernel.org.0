Return-Path: <linux-pwm+bounces-5054-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946CA4C6DA
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 17:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C543AB76F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E922FE11;
	Mon,  3 Mar 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B68uI8ij"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1E22FDF3
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018492; cv=none; b=KBSMGvozO8H9PNqRFpXE8d/tahHw3g9ObkVBbsftfhwi/r55lI20uqWOVt162lhiPw3FsEBGrALqZY/+4p6D3eitp1xOifmlyhezAcRM7iYES8JF5DteyIMTRHtCRXi+gyT4xZeIs6ImcyvNF3+u3pqaByOLh8fc2VmzV1s0UZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018492; c=relaxed/simple;
	bh=SW851bh5XjUCfDzmObPjOBzVvFjoWLDdCSaH8tLiKzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o5Y87atdnyyJOABjTTY7e40u5STwAZz6otKm8EKicSTFXaONiKgEIc8CP1PrDtWly6KizdRleWwTRTi5tRPk5i5ZGGgUbdxSG7Ukln5+4ryUGml6w0QlRxYNAAafBwCmINYPh4pd924jEwPGM79ZHAoCIORa8fd6EurLLSPnA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B68uI8ij; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so6094438a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741018488; x=1741623288; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4EjMp3BG+6HPrPb4bltHW8Z8/x5Nsu7f8FnE3Hkd78M=;
        b=B68uI8ijz3hT6UjrkrDttzLkjHyjYW1OHyBrxZLnuecTYEMSnrImxJXRadeaC7NHwq
         t16BHqOJyNOy9KRAPmSwBGxnjnfX7dk4Ib4E3FGXGuHuA+qxbxA0+1JTbYNbQgfCKDM8
         1sulTnr3T8uHBA4iFdRgZfLeQIZaiIDoxlM+ZVu2U1MZY8r5txHdyVMmPSpbtmvKlwn2
         K38iO4ph3DUeq8KTyKTr3nRKBX6bIvwOEnOr/XIkCJ0qmXZjcFtg5rtWkH8GDRg07JSQ
         CCBXgMb1gJAiziA/FQgk5Pygp/A1GkoRv/oHulMfX9fYI7xDRRkHjvxwovNkdwaEvRln
         e5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018488; x=1741623288;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EjMp3BG+6HPrPb4bltHW8Z8/x5Nsu7f8FnE3Hkd78M=;
        b=Q+W+HVcBnAlGxcqj80ctxQa6YXLmLMbYNQF5M9nfSoO2AeqWzuh6IsN9D3+ue/qpU3
         pOoTL/ui0VCxSrudwmFLCDQ30GObv4GTJGUNr4tJfL9PFIZNIuGQLLBZ5zKDHCdC55MY
         lFt8I6FGdwYgZDzISV6AdCMGr80nHQA/+KDRH8JXAswCOyiNuTAd8qRK9Nf8/cqU/LXu
         XQElr61IjG/VrPiOXiY7MdGyBGRlqYMrbq74VpBW4mfzWfhMfI02JT2nCXnZKUw13F3m
         PBG+JAzyqbiyxnlkqYYo4suxrq5E2N3nnMXcFzXObTN0BSYmLPTdlBhCzekP3W02Lw0F
         ZcbA==
X-Forwarded-Encrypted: i=1; AJvYcCVs/u1K126I1+FyIFcELBSGl+cLqBYv3sGy/f+dzkqtWCEeifIBgbacy77Th5PeFC3sOY/FibbgwvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtUxyWK518kq1g5mgITZ157ru62zQm1R9S4QG/hfhGG/r+SBc
	F3seRfULQQTgolWRilcDFlRANg06MQ/lq1gezC5lldVmkOt8ld9mgHE799mJM0Q=
X-Gm-Gg: ASbGncunXI6CJ9FyX/qBh/EcIMIEaepjdTx72JejYZgatQYxIEPXPTKGS+nw2MTwSpq
	lUCv6asndUD9Ww4G/rlvpP3z1vbckaUQIO9ZN76UOzBJcTaeRIaJEsWHC6chupPJRA7YHERyj98
	XubH2ZkvUUAQ5Lgkjn0y0PvjTioHXF05GMPFxif+B9/mgV+B1pejs9HCU4VjWUdXxRjBeoGJr/8
	RXAYpH77jfQnB2uvGzYvrolk4z8JJ+Y7ZdC1ZG2UGRE2Pc89VtxNvLbx2o7mRfB1br4MRQ5/4kF
	szkhzJJmP1G5J4n96gmaUzcWAWdNKR5hHd7EgSI3nj4=
X-Google-Smtp-Source: AGHT+IELDSZLaGVUnWYgfmAu11bd705GWNzFB2vaWGLLDScnt9ixXKpiFk9Vfs/66mFlQOr1fmaO2Q==
X-Received: by 2002:a05:6402:27d4:b0:5e4:c522:51cd with SMTP id 4fb4d7f45d1cf-5e4d6b691cbmr14687640a12.20.1741018487804;
        Mon, 03 Mar 2025 08:14:47 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb7560sm7161971a12.41.2025.03.03.08.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:14:47 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 03 Mar 2025 18:14:36 +0200
Subject: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGvVxWcC/x2NwQoCIRBAf2WZcwOmLUXXoA/oGh1MJxtw1Zzcg
 mX/Pen0eJf3FhCqTALHYYFKMwvn1GW7GcA9bQqE7LuDVnpURhmM5AVfLk8YS8DO0t6E5TPhbGM
 jbMIpYOnV7FEdtHF03487baEnS6UHf/+7K1zOJ7it6w84+WIbgwAAAA==
X-Change-ID: 20250303-leds-qcom-lpg-compute-pwm-value-using-period-0823ceb7542a
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=SW851bh5XjUCfDzmObPjOBzVvFjoWLDdCSaH8tLiKzo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxdVyTyNKYJNvHbQzz3p4W82eyaA9JJO/Jv3KV
 xsi6cDFabOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8XVcgAKCRAbX0TJAJUV
 Vm0XD/9ieCUXuxrAtsGiQz9dCETGuzxsUW3/Lo2wSkvSX2x1oQxAI6BJFEtrQIbwZMEx4oUMwFF
 zyKwWWc4Vsr21BPzuKBjZnt0qM0RysrKcLPRYM+0gZJWhVLChEMrm1tgg7hHsIOFNkKUcSnsAH7
 W1K29AEs2CRYm488pnF/k/wbFeviaPZ6HX4L/qp8U/dDSCvIcEHZQAj8mvz5Ik2icugTtbdlykI
 1gQCij08r9CMOeEd8vBWZDkuTQF1KhaFnmpUNNdpU2I2vbqqQ7KbMJ9emDnixw+2388uWgZv95e
 Ga6Lfx/mADNjBE0Lex6gMoR5A7ENTsyVTHd2excKLWq3CAq6ENfM7v9AO0N3eOykKZVLBXbC5Wo
 WXRoyXClpidstj3uFf1FGZr4o/PjrsmrJCBl7N3dPUFoa578W4hFtHFIoo2k747bKv6M/CqF9zy
 UlTIS6i+qTRxR/rAuM2RdSB3Q1fqRb4S3b7EAIqINe5vkz0rkrv4XnxAU7ufbFh6ldlcxhvpe3W
 z7z3oCPbsDclyqR+EnpFij9xZDAkrgDNERNyLVAdreNUflevw2SX6Q03gopF6DSmTFgx4j9n/Ng
 TWKgqSis/gezuOGYuMXXPTmkKBsKGR5IdMraUR2bbPxtf8yRGzxGKkAa/BsBY7yQhuOZHmUvmgt
 7zhBY5f0D5ouXPQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Currently, the implementation computes the best matched period based
on the requested one, by looping through all possible register
configurations. The best matched period is below the requested period.
This means the PWM consumer could request duty cycle values between
the best matched period and the requested period, which with the current
implementation for computing the PWM value, it will result in values out
of range with respect to the selected resolution.

So change the way the PWM value is determined as a ratio between the
requested period and duty cycle, mapped on the resolution interval.
Do this in contrast to using the register configuration selected when
the best matching period was determined.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
This patch is based on the following patchset:
https://lore.kernel.org/all/20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org/
---
 drivers/leds/rgb/leds-qcom-lpg.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 4f2a178e3d265a2cc88e651d3e2ca6ae3dfac2e2..80130c205dce7c6ae1c356b7a7c5f6460a2b0bb0 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -523,8 +523,10 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	return 0;
 }
 
-static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
+static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty, uint64_t period)
 {
+	const unsigned int *pwm_resolution_arr;
+	unsigned int step;
 	unsigned int max;
 	unsigned int val;
 	unsigned int clk_rate;
@@ -532,13 +534,15 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
 		max = BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
 		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
+		pwm_resolution_arr = lpg_pwm_resolution_hi_res;
 	} else {
 		max = BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;
 		clk_rate = lpg_clk_rates[chan->clk_sel];
+		pwm_resolution_arr = lpg_pwm_resolution;
 	}
 
-	val = div64_u64(duty * clk_rate,
-			(u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div_sel] * (1 << chan->pre_div_exp));
+	step = div64_u64(period, max);
+	val = div64_u64(duty, step);
 
 	chan->pwm_value = min(val, max);
 }
@@ -829,7 +833,7 @@ static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
 			lpg_calc_freq(chan, NSEC_PER_MSEC);
 
 			duty = div_u64(brightness * chan->period, cdev->max_brightness);
-			lpg_calc_duty(chan, duty);
+			lpg_calc_duty(chan, duty, NSEC_PER_MSEC);
 			chan->enabled = true;
 			chan->ramp_enabled = false;
 
@@ -906,7 +910,7 @@ static int lpg_blink_set(struct lpg_led *led,
 		chan = led->channels[i];
 
 		lpg_calc_freq(chan, period);
-		lpg_calc_duty(chan, duty);
+		lpg_calc_duty(chan, duty, period);
 
 		chan->enabled = true;
 		chan->ramp_enabled = false;
@@ -1241,7 +1245,7 @@ static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret < 0)
 			goto out_unlock;
 
-		lpg_calc_duty(chan, state->duty_cycle);
+		lpg_calc_duty(chan, state->duty_cycle, state->period);
 	}
 	chan->enabled = state->enabled;
 

---
base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
change-id: 20250303-leds-qcom-lpg-compute-pwm-value-using-period-0823ceb7542a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


