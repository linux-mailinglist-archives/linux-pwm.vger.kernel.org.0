Return-Path: <linux-pwm+bounces-2635-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9706891BCB2
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 12:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914CFB21143
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B21103;
	Fri, 28 Jun 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z5DATHLj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DE153810
	for <linux-pwm@vger.kernel.org>; Fri, 28 Jun 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570935; cv=none; b=E+ox8HUJvROysDjynEuCBWkk8CBfYR9xGylg6Z4jrTaSiyzKlRRFvTMDlT07rGp6R8Te+x0mxicdaTbFYebBVy1SNwL/THEGmZll1mTAEWiaqxgtn4WbEbsaVeGlwXWa/ybBc3ePHr5kNdL0+XwIpf9Zx7koavv4V/XT7HK8PwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570935; c=relaxed/simple;
	bh=2Sj7jzGDU7aqKwSdO8t3SW2PIQOZMjbWxuYjw+cjoTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtPfY2uWxkr/q+1B/v2h9ic0w4MJ08QomH8HNagHH/2pXe671mgQKX+adBhNnAzZDo2wwM6SbbhuB3QOPXnrOBa5xbaQ0n3Zn21XY1tE7ByeZO9m89JMm3sUXeS87IHxrxbFV87cWZMNsOmxokRsGa1HVJvI1n/UEXJif05xqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z5DATHLj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec1620a956so4182271fa.1
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jun 2024 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719570930; x=1720175730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNcvmC8uVk01l6jcQf4AR/Rcl20splLYVhNbYcguVtQ=;
        b=z5DATHLjNx1pPplPSR12GPT/hOGSYGpA/b9l2cFgummN9q987hCwYqOedeoed1/kDH
         x41GOF3Oi8pk73DyjyxPvKKYkmKqy0B1KXCeMSivVoHZBDJ3Pp/b73Gas5EZwi2T2ndk
         4sDjvG0BqYGfIUbsjUPZUq3/A75C7h/Dj/tQyrQODAbfB9ddblO+bel+//NIqDSuupnY
         viW92oJ2unJZLLq05tHqX/wcrunEqcOU79nJp0onfLAlwGkQUYrWR7rsiBz4mtbFybU0
         r2Vrj9kWw4l0a04YM03WHIUpNE+wDCknzExIMW/jn6eAHg/lxVPr9vOrY6ueW9tq3YuT
         +7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719570930; x=1720175730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNcvmC8uVk01l6jcQf4AR/Rcl20splLYVhNbYcguVtQ=;
        b=S7RTJ3XuB5/sAIHk95CHeFTZVuanKKEecAEzT2fN+tucg+zj476W8HjKX8MHW/SCfv
         w+WNGNVbYL6noC8SC9AyeUxjqqdPDH6WCtn8Wq1TNF2k1FxyUDxvN0gMMZoDop/lGQQe
         CIjK0WNF0eQ2MFsSKmSn2Hogxj2kLIcQUbaC5qydetafj9K0tOfIeH7bpRcllhyXiB0b
         m1/nQ5xSrApe1nFxoKv3p5Y6IpPjlFy0vUtARJVCUNrkwbvRpoFjRJx6ror/BIIRyerc
         gs9Y5j6gP7h6HoSKM1iLi+k91qOlOdny/mun1T4O7Yaz/fy7EgBt9nmxg1Hu6XF7Kkpg
         88JQ==
X-Gm-Message-State: AOJu0YxZ4GQ+y2H1riJPI+dNNM0JiBBp3uDOpPIZGvNhiX+wZ2oi3wQs
	3mg8koL6N5HP6cYq6DRpLN0BKcogztk2oFq4uWZV5I/GkrM+dIRVoxbhE2ZJTLwwHJ3RIYPkAx6
	R
X-Google-Smtp-Source: AGHT+IGsWhVglXI8EbOdlisAi9IlU6LFlOzlNvr90EHLGi/tp2YQ2sr+dd10HXOx/0SfjAgRzzdgLA==
X-Received: by 2002:a2e:2d12:0:b0:2ec:3180:d4f7 with SMTP id 38308e7fff4ca-2ec5b3460f7mr88510011fa.26.1719570930317;
        Fri, 28 Jun 2024 03:35:30 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324dfaasm865799a12.32.2024.06.28.03.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:35:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Thorsten Scherer <t.scherer@eckelmann.de>
Subject: [PATCH] pwm: Allow pwm state transitions from an invalid state
Date: Fri, 28 Jun 2024 12:35:19 +0200
Message-ID: <20240628103519.105020-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=2Sj7jzGDU7aqKwSdO8t3SW2PIQOZMjbWxuYjw+cjoTs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmfpHnJktfd6oHRDXP08VKLdWarWSK2iSB7/FDK nf5jnMItyGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZn6R5wAKCRCPgPtYfRL+ TpAFCACpuz3BGFIfhQ4hw6nMm6J2W9RkN7CTR6T5qApi9smgmR3w5bO2LyYc0Xa7J9qoBCXuP6A nOeTsUw+13f2dvlmAmmAAAMiBUaI+V5AZoLX1L14ho1wZrz//0G3Ur39gZZItIoTE8IK002V/lR gDS9OkCyh+vvs+wMQdJ3GGexv/vRVtE1lXDZXSkAUbVOQu6k61Ai5TLXRBKy+R9W7yxEuu1onoL Hlt928J7bxYerOhipj/JK/1VcqpwbPGmI4gHPzgZlSXUjZRBAotyr260B93QuChYSHuoNni7+4F RgtmRBZity4e1DeSkYUGEfsJYE2a2yeD7zlX3WrN71V8RZNb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While driving a PWM via the sysfs API it's hard to determine the right
order of writes to the pseudo files "period" and "duty_cycle":

If you want to go from duty_cycle/period = 50/100 to 150/300 you have to
write period first (because 150/100 is invalid). If however you start at
400/500 the duty_cycle must be configured first. The rule that works is:
If you increase period write period first, otherwise write duty_cycle
first. A complication however is that it's usually sensible to configure
the polarity before both period and duty_cycle. This can only be done if
the current state's duty_cycle and period configuration isn't bogus
though. It is still worse (but I think only theoretic) if you have a PWM
that only supports inverted polarity and you start with period = 0 and
polarity = normal. Then you can change neither period (because polarity
= normal is refused) nor polarity (because there is still period = 0).

To simplify the corner cases for userspace, let invalid target states
pass if the current state is invalid already.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5c1d20985148..be5054146a49 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -137,6 +137,25 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	}
 }
 
+static bool pwm_state_valid(const struct pwm_state *state)
+{
+	/*
+	 * For a disabled state all other state description is irrelevant and
+	 * and supposed to be ignored. So also ignore any strange values and
+	 * consider the state ok.
+	 */
+	if (state->enabled)
+		return true;
+
+	if (!state->period)
+		return false;
+
+	if (state->duty_cycle > state->period)
+		return false;
+
+	return true;
+}
+
 /**
  * __pwm_apply() - atomically apply a new state to a PWM device
  * @pwm: PWM device
@@ -147,10 +166,26 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	struct pwm_chip *chip;
 	int err;
 
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	if (!pwm || !state)
 		return -EINVAL;
 
+	if (!pwm_state_valid(state)) {
+		/*
+		 * Allow to transition from one invalid state to another.
+		 * This ensures that you can e.g. change the polarity while
+		 * the period is zero. (This happens on stm32 when the hardware
+		 * is in its poweron default state.) This greatly simplifies
+		 * working with the sysfs API where you can only change one
+		 * parameter at a time.
+		 */
+		if (!pwm_state_valid(&pwm->state)) {
+			pwm->state = *state;
+			return 0;
+		}
+
+		return -EINVAL;
+	}
+
 	chip = pwm->chip;
 
 	if (state->period == pwm->state.period &&

base-commit: 642a16ca7994a50d7de85715996a8ce171a5bdfb
-- 
2.43.0


