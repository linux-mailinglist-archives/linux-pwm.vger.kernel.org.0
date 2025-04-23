Return-Path: <linux-pwm+bounces-5671-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B697A9869B
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CC53A65D3
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2324262FDD;
	Wed, 23 Apr 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yHlV9IL2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FED2566DF
	for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402253; cv=none; b=A+UhJUFihYuMu0tKO6tDCiEY6w98ASGcGVPmrsH5skBStIjTd79V78osTd2fVpo51R3+Pmkyl4MU+hwzUntg1vFNuWMawIIv7duU/BXfdgJdIbxkCi0CazYUtLRyliERPMc6NbT9FOEJXzV/hm76ruEi6R5l49jkjONjkOUMfX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402253; c=relaxed/simple;
	bh=j2S7xRaQQfqbGm0kr4hX1E29Z42C6Rw3SuNUIoaXM0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MBpERJugQOQnxq3NFnnvsBsyrdk0qjTAZGELgdscOb8lYMZ/kcCy9BUgh1wnCZYV7+c/dduSLjky+vfjhr+Er6igGhd9S/z58hnwJ0HEy6jEtq6hbBC1aeABGCtDhqJSNpRjSb/9zFwfizcCnxhf0z3nav1fUJTn/uUSDc31Fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yHlV9IL2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-440685d6afcso58219445e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745402248; x=1746007048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=woknpawhCAZyHc/43vVqnD05PnKsWPtCNhXJhFtXyyM=;
        b=yHlV9IL2Yuk+5UezBZPV8S81pGD1CM/wEv3mjtC2cR/TBuQzr0ZZdTw9WHLA9Hyfoa
         7XJsol9ORIbO79rkcnKH4J1big9CqUEMdHNsdxTyP7xITs0HfUJYLFaAqkB5atg2HCsj
         gakfh/s0o9CBAYqWs55IxlmEEppXOu1fEaGskgQRwEH30SdHGy2+7cVXlkHRjEZ/Gtzw
         6uF5usGkr3L0nIr5duyvYzFZDIZFysAxeekdusa4RIBeTXnx8NjAR1ExwouaRLzsd01G
         da79NjwwGhldTVATwfLSY2f9yh9HhiuJb61C3h9LoSEm/rfpSUjWaVjbVaua88Bn45IA
         QnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402248; x=1746007048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woknpawhCAZyHc/43vVqnD05PnKsWPtCNhXJhFtXyyM=;
        b=bj9qa2itgH227sEEwUYcVqrquYKZef6qSj9FWqpmX7RQE75+zbNpMujO3ZR6L5Yftc
         q9YQDz3dHjwfH/yBAPamvyWqutREN09DFx2f31fYS6X18vIsuoNv7XO/iUDEkAj5046t
         jk3Cy6fOQly5zUVfF70Mcmre0YY9F4EzH3AvDV8YdiOc0LPC3CcYe+eFErptP6XMcB4z
         Zc4ICJ+LsuejsyuV5DnoNYz+sC+rP5t3p5zMb2BKg63jzJp07xmt8dm97xtT6RP318m6
         Lr5D/Dv2cDrBO8lnLvmyV26sp8uxc4KLreJXoXAnJ57Rg4Y5PxtlwZgiD3HcFSJuxjd2
         5AlA==
X-Gm-Message-State: AOJu0Yw0hq2UlgRSsTxZjZj1Qgfr2rlCAu1v6NXAVfp7kVbKi5kaigFv
	RcmkpoI/K7jU1PddDYl4zcrckjiA9l4moGEZKhLNsm92iaZIeKusA1PtsglPZV8F4wgJdHWOhbm
	J
X-Gm-Gg: ASbGnctCcJQSIIYmX8JYxhMqnemif01FQbtJzGlVrxxI/1PESnyOPpFmQVT8ywLLa1d
	D1VaKwiRZpiimNUubhvW6dQs/c84FEOrk4YM+eqWFPJlkZYZqRU3wubgXs+Qz2a5cQBiuwgFY/o
	1/14PZMn4SppI+GRkoR2dQCTFQp7M8x+e3XYdYnHO5WnLymGeVy/kUghxDnf0Muy+uFv7arpOlt
	xs87CLuU015h57aXgdRX2HmYWARH3MLwil6JpRRvyuEuoGh5BRmihCcXDU+GLewhoIN+E0GrMsB
	y/ZvpyYgORnJvSwo7Dfc5XjV+pbRleTmAM7AOVzSPhM7m1I9D71uU0AMcMLvr77Sz8X18SnOkCu
	BATgYx4w+UXUf5t2mKg==
X-Google-Smtp-Source: AGHT+IGRTkOwrU+/GBj3ML2vX06Y5dx2d/Jir/sGDPjHmCY047L6Ala8lkdxT1EGZ/88QkUqvz0VRA==
X-Received: by 2002:a05:600c:4f12:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-4406ab964dfmr155221645e9.9.1745402248492;
        Wed, 23 Apr 2025 02:57:28 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44092d4158esm19605315e9.38.2025.04.23.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 02:57:28 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: rzg2l-gpt: Accept requests for too high period length
Date: Wed, 23 Apr 2025 11:57:15 +0200
Message-ID: <20250423095715.2952692-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=j2S7xRaQQfqbGm0kr4hX1E29Z42C6Rw3SuNUIoaXM0s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoCLl8jgIflO3Mv96dTS1oBd5gSXUuBrBH6Z+eZ WdW09K1zeiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaAi5fAAKCRCPgPtYfRL+ TpeKB/0RNgvl4/RY8wCYiolJdyTuZrVwfE0/UzGU0lbS4Dnp3FtSQxUrKhMs2m5OIgov0lcU2rp DNuLTSFs7MjD92kLOm8DMEAq5Xf1hUIOdeeRtAeuUlJCkyuraA1X8/EqO6Eu8JhTA5/Zg8iEFFY 1U2ZImtZamypo7xXqaXu8B2HSe3/dLH8gU/MFHuZAXEHFAZPeOx+TLTnM2jg0EMj6RrGcJ1ymXv 9zVvoH2yPG4/BnnsFz47XbFfqskYENnIzX3VTk0PcDLRDOc/l3gEf2gB0aaTdvGzjFCAWA0q/Nc 6p1WLoWTIDmHXmMWMtpA3VL8Zaf9/x24LpIocX4UIY6hx6WH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The period setting is shared for each pair of PWM channels. So if the
twin channel is in use, the period must not be changed. According to the
usual practise to pick the next smaller possible period, accept a
request for a period that is bigger than the unchangable value.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello Biju,

here comes the patch that I promised when I applied your driver patch.

This aligns the period setting to the usual procedure. Obviously only
compile tested.

Best regards
Uwe

 drivers/pwm/pwm-rzg2l-gpt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 2ddbb13f50aa..360c8bf3b190 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -270,15 +270,19 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * prescale and period can NOT be modified when there are multiple IOs
 	 * in use with different settings.
 	 */
-	if (rzg2l_gpt->channel_request_count[ch] > 1 && period_ticks != rzg2l_gpt->period_ticks[ch])
-		return -EBUSY;
+	if (rzg2l_gpt->channel_request_count[ch] > 1) {
+		if (period_ticks < rzg2l_gpt->period_ticks[ch])
+			return -EBUSY;
+		else
+			period_ticks = rzg2l_gpt->period_ticks[ch];
+	}
 
 	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
 
 	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, USEC_PER_SEC);
-	if (duty_ticks > RZG2L_MAX_TICKS)
-		duty_ticks = RZG2L_MAX_TICKS;
+	if (duty_ticks > period_ticks)
+		duty_ticks = period_ticks;
 	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
 
 	/*

base-commit: 6d54ef7161f815beded94837b40a522df7fd7177
-- 
2.47.2


