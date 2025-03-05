Return-Path: <linux-pwm+bounces-5105-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D519AA5001F
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 14:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB8172597
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D324EF86;
	Wed,  5 Mar 2025 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6qelFjx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D724EF6A
	for <linux-pwm@vger.kernel.org>; Wed,  5 Mar 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180171; cv=none; b=nmlPrhk1LVTUESjXVswZsTY9zCBnWF3ybXFMpNeiL9E2kaIPDztvX/nKL4LWI44RJnHoXWZgRdI5HxNMwAV/5hbCzA893I79KVa5iAMt99zTUzacSkqEU0nezjrWVBQ9g9hiOnI0NNjCPnfthk5lJg5+inswUnwB3qzMzG+27qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180171; c=relaxed/simple;
	bh=1lfv18zXpdxY8kZVpZlVeAwNtS8AmywOofVeGqzeOEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiMwUebUO5HpmbfK6meJAAMYw1oQ+gDRP3OhrOOZ4zMsm9a8XCegFy/bL0CA4B7+YZovMz7WnTskBnu3y/WRz87cY6mP4KGDPzBLhWyffFOlmnw0xu9UfbjLB6U+FQ1PoIsfEcB019SolQeXs5dfpOhWCqwCaKVGkU81ZvbVWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J6qelFjx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1818761a12.0
        for <linux-pwm@vger.kernel.org>; Wed, 05 Mar 2025 05:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180167; x=1741784967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcO45S/il2qWOt5c4ZNer6B5gyqfJVMeCB4pzlqBXPc=;
        b=J6qelFjx1/6gyYUNzM75bbEBjUA/ag0WrIF01NMXVXQ4nhz0PDh2Ezb4IVbjRSg3je
         GqSwJV8Jblym9JAE2YQn/zI+ROWpB7chOQOTKBcBHZOp0xOUOaDDz2amxVREPTy48o1m
         FcEKyWVd/O7bO/9pudoJXL9eUV6DzE0zy+c46vWR3t37+m4/EEe3RncNsjrZvA6ksOtQ
         ohXKNSWj+uyaJYZhZ3iwG3GIeU5tjo2jcMup/CqyJu/jLOzEtf2W1vEwUWkO5Pq6h23o
         eYvkne6wwZ2nLEOaix27w+9amghpJQ+opm8+Y/wJJmDe1mRkTp5H3yiEwZx2Tv2vvFdO
         t67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180167; x=1741784967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcO45S/il2qWOt5c4ZNer6B5gyqfJVMeCB4pzlqBXPc=;
        b=w/wk2YyO9ZtqzxjwuT9w47Nnm4K6lldLNOp19njAHPezEe/kFd1nWsCOArJE5BWjg/
         I7RGqFHuyJqpWMN1bZgqMDidXWOtshso38ctsiL7e06YkFmb0Hk7E8P7g914s9XHy1Km
         kYRhCZ7yKu+t8kOUHSlZFk7f3A4JA/l/v+YSU2VgrEU3v2ucFNEmTH/4SauJnzhdmc4E
         zVOz3v2zk0MKW6RxI0rGgzLe3zTJ9y/NedgYuQAd/DSvkbEuFz9uWBMrz80EY+fJi9Ea
         m0jaUifi7Ka7EBT6iJOQkYNhgX0xEs+CR7h+ziwXk1vXD2rL0zC/360+9pZimJzyh720
         uB0w==
X-Forwarded-Encrypted: i=1; AJvYcCUQf2w06vGezcvBIu+3IJORQE668+uO6ilALkSBS3ezzbKvxzdCae5LUqhugHBBKKMq2RPzICzieuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHb3COtnlpXWf7ZQ/ntZ78ElaGA1fFqktbRzD8xGMCu/ibLVhA
	+c6mPzULFZLdgfWFL/0vA9Sjhk5ZEUrUj7OZSS/6uUle7tyGoHpXjxdJkCaRrBA=
X-Gm-Gg: ASbGnctci2sIOKbMD0skYvsEQQzakmeEz0bqosQZhHJCC+nCPezcBmcUgTMr5tbGUMD
	VEwwjdatMjCDujh84/9Ahrlk1lzfXl28EhS6llE4Naa2A3MuI9k1jctZSI7TgIo1d3n4842mTVC
	n6bntrHMJJkRz8tuyjJt6QJSopp1mf9ImUaRAr3oyBKtuekGUu1McrqqMClokHM7j8DwHLMi4RP
	SvbY8OyV03HmcXZ90DzQPPr0BFmY4MLjC7isuIOzziCiI+hRkGguq+X20hZu8N7njEn9xW7y1G6
	snL9B0IEfxL/RjUKAxnvFbzj8/Fjhtm+kazz7LmriWc=
X-Google-Smtp-Source: AGHT+IEhPlA8syse6BxS6MwO/8ykIl7YX3VsOgc47tKf3pBFQkbkyjyaD9GvZYQWYZb90PvcAHhpFA==
X-Received: by 2002:a05:6402:1cc1:b0:5e4:95fc:d748 with SMTP id 4fb4d7f45d1cf-5e584e2916bmr6857202a12.5.1741180166877;
        Wed, 05 Mar 2025 05:09:26 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa5dsm9627341a12.14.2025.03.05.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:09:26 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 05 Mar 2025 15:09:06 +0200
Subject: [PATCH v4 3/3] leds: rgb: leds-qcom-lpg: Fix calculation of best
 period Hi-Res PWMs
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-3-bfe124a53a9f@linaro.org>
References: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
In-Reply-To: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
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
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1lfv18zXpdxY8kZVpZlVeAwNtS8AmywOofVeGqzeOEg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnyEz9GvsrtuEyjaHc+0jk69pgJbYcU3phTRWaq
 N4oAF9qzWaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8hM/QAKCRAbX0TJAJUV
 VjNUEACcTE751zA3mWoqblM1OJYA48Kzok/TAGKeHouxbv4Rf/LdSP6eB3zkjNKKYLEgpRVsAUy
 LTIjXRTmTe3u/TPrdbuzR/8ZuSNoXW7GaPx18Hrgh5cfEhNZQY+FFVscVY7ie6xW9hXZeHGqGpl
 Aw7ZXNAvfnTdpwsxFn5ZaWQI2kgUal+z/exISqrPcbOhSYMzogouj1/nt4ZBYlPPfj49kxUYHVZ
 Z8PPvFXEAp7aWEXSAlffvZecuxHzJtc3IYlb1mNIR9xby3aRYi7b+Xb+GzA3dzcNfA9+h0Jcdfl
 KKQozdo11qANexEqJWTptXvTDyrjEg9IOHYXF5L8D/9iG7VNEC/Vt2iN2eks+Uwqn8PGWvSqNhQ
 DyemuYEMKCFdvQp77Fe0rNXttGzmZwqnMlJFizok/LrZFsS7eg9TTEYtgNBLTA/BM5mj1JEWWYr
 UFMUiOaBY0V1MfYkxs4Ay1ijK6+pRhtfVQk5XyrE1sy/FaRffUBxXvE7dM0nLBkyEg89a0ofk+t
 DB93pHIlBa4epkOPSKHFK4HGJOcyqvLEQQcTiLnPDy5d4xgtZKy33gSZHuKta77Wkj/4cMprSOJ
 +LCAPcWFOn6BHP/+1DPV+az+Uh5Fpyc6xaTIR7pfT0LQU1JtjjaZ8xUateBxVCRZ9PULctU/s8h
 xuX/yP4eD8HoatQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

When determining the actual best period by looping through all
possible PWM configs, the resolution currently used is based on
bit shift value which is off-by-one above the possible maximum
PWM value allowed.

So subtract one from the resolution before determining the best
period so that the maximum duty cycle requested by the PWM user
won't result in a value above the maximum allowed by the selected
resolution.

Cc: stable@vger.kernel.org    # 6.4
Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 0b6310184988c299d82ee7181982c03d306407a4..4f2a178e3d265a2cc88e651d3e2ca6ae3dfac2e2 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -462,7 +462,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 		max_res = LPG_RESOLUTION_9BIT;
 	}
 
-	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
+	min_period = div64_u64((u64)NSEC_PER_SEC * ((1 << pwm_resolution_arr[0]) - 1),
 			       clk_rate_arr[clk_len - 1]);
 	if (period <= min_period)
 		return -EINVAL;
@@ -483,7 +483,7 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	 */
 
 	for (i = 0; i < pwm_resolution_count; i++) {
-		resolution = 1 << pwm_resolution_arr[i];
+		resolution = (1 << pwm_resolution_arr[i]) - 1;
 		for (clk_sel = 1; clk_sel < clk_len; clk_sel++) {
 			u64 numerator = period * clk_rate_arr[clk_sel];
 
@@ -1292,7 +1292,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (1 << resolution) *
+		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * ((1 << resolution) - 1) *
 						 pre_div * (1 << m), refclk);
 		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
 	} else {

-- 
2.34.1


