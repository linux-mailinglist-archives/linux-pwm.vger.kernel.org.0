Return-Path: <linux-pwm+bounces-5316-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5192A778D2
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6159216A37E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7A1E0E0B;
	Tue,  1 Apr 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y8uISR1E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8D1F0E50
	for <linux-pwm@vger.kernel.org>; Tue,  1 Apr 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503369; cv=none; b=UFqTMsk/HRTO+AdSxSOVU3j6HnguXVV9mtBP6Q2u0Rs7fD7htvPP7lCiMteBsKapVGe1m7senDG4DVWyRL0Wrl6UzR1FuHrD9qiAONcTUeFFI6v+8nsD2KWgofmhKnEXKhW+2jHJOFMn4Z/jScN+9CnqfCagSpzf87HF1EE4Kao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503369; c=relaxed/simple;
	bh=raD5nCVvGk3g4nqb+utI3fnRuRhZ5Dr24B1s+P7zKqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvPBQMElijtiOj5vU1V4a6h7CzkBb8MasK+KPLjwuOs3PXQEoNWX70IvSsm12tJlwLYVL6diqV2IGhwAwq15JoiZD/tUz00Dmny4FH8sQk5QiMWVOxO0ZAAD+4K8lF3khmVxHqF4CAkRvFRseVXogDuz9aP5rjBM+fT8MUSymMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y8uISR1E; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1efc457bso824465f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 01 Apr 2025 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743503366; x=1744108166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx+t7dS458WglT02dhLawv3+vNQb4ORGCFYodRrEmuE=;
        b=y8uISR1E6OtZxBZ7IcVZKPyCztg9f1F3rgSV7R2/5sjgqxHIdoJ3LFVN+vOftYGDCZ
         TogmZ4vHJo5MdF6EV0JYx8J/ClHl7hp8lj7SZ7h64wUr+jnJmJuNzm5CPi1E/HDZ9ZZK
         lN/h1hY7fgJmWdp0ThZAcUIZfitYg/OMxXa5k5xtIj8tJvWnKxuBTHG47OJ3aqgzSKEu
         5BQM8CkoPdaQlXY0lD+3xk2jfGKzoryenmXu81SRZtluqejBn1IesuYXFbTtLaQmASI3
         G5RGmNM8VQyVdPr5AUMaqiBYmWEb905Vc1uPZykGjU6xKC1+yGb0bd45spQRlqvGQDzF
         OeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743503366; x=1744108166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nx+t7dS458WglT02dhLawv3+vNQb4ORGCFYodRrEmuE=;
        b=UV/KT253E+e9mgfZSKQ5cbPQXerVZG3cyZRiWM+PSgm0F1h7jF6zI9spvQmtH69o9l
         cXeGLI9LbbCzy29kplopZF13LyZpEr5wk5YE9c+ISvylwLO65eYCIVLIe01RTAanT303
         4rd541Kcdts36sChcjd99r3g7RYeSjFuO5FrRvpvEpcI8P3u92K/21dHMdmO7JFF8yMY
         bNvSrE/J7qccYMm9AIhhrClnb2Fstnxjhx+69APUAlbL1sbux+ADXpXwy256SUUkimyW
         WQBibJybXxGy5+V8nm7necaAod+pectl0s+NYKCZr0Z0xqgsCzaONNzkSa80u2D/DDBS
         kxfA==
X-Forwarded-Encrypted: i=1; AJvYcCW548tU+t4rCWpqn9TXD0P2pKssOK2b/ku01YeG6hQJywd7ACawKiD+hE8TrvaJPA6Jjek2UUiqdMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4ALNfjQ7Dvm8sQM0sDP/TFGB/u8NEZ1pwDSyds25XpeirTfJ
	9qAjnO6mIL4C4f03DdQVy3/GoSkamTcxiZ1a7vjxG8laMlR08NTZNUHZPHZLrjWdUU6f6od6rqe
	9
X-Gm-Gg: ASbGncuNrG9GTGs1DtKuacvoMYUYaycO53B6Eu4DAkqOJGA2zXPEe4GDt0QKNQfSXMQ
	tffzgVpz1yidPpJHiMVIv4TVfRfyZ8pkQv/D8S1H6X65JcYPX07iKA9cQPFnyeUi42g3Ve9OE/P
	NWXujy7IM6MIprpMoa/TpQgggqf3YhuMsKQVX9BR45cWhjbiJxM+OA5fb7BnwgLo8db2GE3iQFi
	H9ORsAxid7CUc+OeqBpS1G+IdcNfjwiMk5LkUgyFEW8i5aNuCJNLMa36L10dvwWl1vTKnWDE/M6
	XzvN5nrKCB1yJu9qeSi0ScEY6joWUMGj4I2KFEfcvISA0xV6s5rS0KDjB1VfPczTDIQBE3WGscy
	8FN+/n4MqlfCNcUggXzg8XA==
X-Google-Smtp-Source: AGHT+IHNCeNtYlrxCPJQq3pSlv5yBxYcqbKoetqHiGqtUs6dXEfQgEOWN5bAXvUXs6ny7ElY+yJ12w==
X-Received: by 2002:a05:6000:4387:b0:39c:2678:302b with SMTP id ffacd0b85a97d-39c26783030mr979117f8f.45.1743503365953;
        Tue, 01 Apr 2025 03:29:25 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b79e0a3sm13885606f8f.71.2025.04.01.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:29:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	linux-pwm@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 2/3] pwm: rcar: Improve register calculation
Date: Tue,  1 Apr 2025 12:29:00 +0200
Message-ID:  <ab3dac794b2216cc1cc56d65c93dd164f8bd461b.1743501688.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
References: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=raD5nCVvGk3g4nqb+utI3fnRuRhZ5Dr24B1s+P7zKqE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn67/wHcybj4ht5H0d2Iuh8RCKOyAe0U8DxfqVJ xrBlWN2b3qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ+u/8AAKCRCPgPtYfRL+ Th5+B/wMpeK1IolZk0dLkSvc7Jvy3qaIyGxiJzB7ygT5pwAaGrUh+XwWLbqf2cooOQq3bkZU9Th l8F3jZ35LIht6eMZnQOt3gQ0dQNiKF/vVO3rDcu4sH0hoBKPMqnq6gquWNwm9P7nJzdWVupemnE CB2dMddd6nwb0lDUlmE78B72m6Qrl7K3kZ4ToRkLG6IHj18z9s/A5AoHeq+wZkWbCuVkMJlZu3t VRznHa5n4aueMEFAiJHc0Zm3F8w9t5yTCzr2rI6QeSPHJS160jVQSceht1S9gC33ZWMUa5x7UzN P+wukKm+wTQXSkxnZQW6RC9NOOUvSwjD5alLht8o197fNxDJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There were several issues in the function rcar_pwm_set_counter():

 - The u64 values period_ns and duty_ns were cast to int on function
   call which might loose bits on 32 bit architectures.
   Fix: Make parameters to rcar_pwm_set_counter() u64
 - The algorithm divided by the result of a division which looses
   precision.
   Fix: Make use of mul_u64_u64_div_u64()
 - The calculated values were just masked to fit the respective register
   fields which again might loose bits.
   Fix: Explicitly check for overlow

Implement the respective fixes.

Fixes: ed6c1476bf7f ("pwm: Add support for R-Car PWM Timer")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-rcar.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 2261789cc27d..19e5d0b849a6 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -102,23 +102,24 @@ static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
 	rcar_pwm_write(rp, value, RCAR_PWMCR);
 }
 
-static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
-				int period_ns)
+static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
+				u64 period_ns)
 {
-	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
+	unsigned long long tmp;
 	unsigned long clk_rate = clk_get_rate(rp->clk);
 	u32 cyc, ph;
 
-	one_cycle = NSEC_PER_SEC * 100ULL << div;
-	do_div(one_cycle, clk_rate);
+	/* div <= 24 == RCAR_PWM_MAX_DIVISION, so the shift doesn't overflow. */
+	tmp = mul_u64_u64_div_u64(period_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_CYC0_MASK);
 
-	tmp = period_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	cyc = (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
+	cyc = FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, tmp);
 
-	tmp = duty_ns * 100ULL;
-	do_div(tmp, one_cycle);
-	ph = tmp & RCAR_PWMCNT_PH0_MASK;
+	tmp = mul_u64_u64_div_u64(duty_ns, clk_rate, (u64)NSEC_PER_SEC << div);
+	if (tmp > FIELD_MAX(RCAR_PWMCNT_PH0_MASK))
+		tmp = FIELD_MAX(RCAR_PWMCNT_PH0_MASK);
+	ph = FIELD_PREP(RCAR_PWMCNT_PH0_MASK, tmp);
 
 	/* Avoid prohibited setting */
 	if (cyc == 0 || ph == 0)
-- 
2.47.2


