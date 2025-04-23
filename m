Return-Path: <linux-pwm+bounces-5667-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03AA9844C
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C633BAC13
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552F223DCB;
	Wed, 23 Apr 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l/BFXzFY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3F21FF4F
	for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398416; cv=none; b=ZUBojXKTAVrRX7mVEE7AeeFuFdu31DSlBKPTcsQSWic6d6XfG1fLIOB7F6mDoN7p1bWDNvsL2Byg5lEjqVJFnXSR6ZTl8PbFkanHVmMQOisc2RbbfefG00yRItV/DG9OXYyzaI6VusJoZroLwJ6yTRmNg6/GLnv6/T7Eumj5WSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398416; c=relaxed/simple;
	bh=3r/5Z/FYNGrd9yVol3oPvJOMUrAGXQMWCQuwPGjhyIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufjH0vfDvRrYFXLLUWsK9/lT/nWVzg77+PZzCJQUwm0KKkq8tnX/TrF/jSH5N3UNZ57gv0XcsKZJ9BkmhdLxlFzlpD4/cgW6W5JOfgkrPOUFpgQbSlOKwHvuUN9IL7TwILRladHo6Jfy1DceOB+apmJde4asAG0CNELAFZH3yZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=l/BFXzFY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301c4850194so4633520a91.2
        for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745398413; x=1746003213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ySeC6yawUczfsda0tPZSNQIrOLUHwdCmyF43sMLfrQ=;
        b=l/BFXzFYywi7/G3t8cBtRni0/CZA3hGD2bySF7QiOGUGb8+zYoKc8/stk3r9riNFnw
         /LNkxvkRxvALiGOkjeBJouN8eKjJaa3XXhgBLNaKENBZbwKMaLvfj46B8WiPJdDCNpsz
         gzgccTtbDOEluw5csuUwAy1CZWdwinYbcX+u4fvOB3vstMYyHKuUMwUvFk+Ph9qg03W8
         mhsPHSpA1Rwb5biWDsz0dbBSr/ITkkzI8yTlb2l8Gb17m+tHEu/5IEPc1mdS4+yIlemU
         CvV7qEUV9kD3CXBBNMNSEsZrJ6alWM+vdTlb8LVgQReLU0E7etLhgSypQNXkVQg3NPix
         wg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745398413; x=1746003213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ySeC6yawUczfsda0tPZSNQIrOLUHwdCmyF43sMLfrQ=;
        b=b/twWGsrKOaZLFQuPLDQDuH2GyPRn5/1wzfgg2kRn4jYURZxAcoeRgH0+3sO9zKk1P
         BtfojPsdjiz97FoKWUwgIFEH1p6s1K9TeAITr34BOkV3rSXiN+M5b9mLPw2tmEFBJ33k
         uXdH9xvZL/Y5qCm7xmHkwkC5aOxTVVkc5j18iF/oQ6Gc456QGX/3Oz4JfK3wY+2HUSBC
         hvKc1jUVb36+OZXEjVY8zhvYaUBPDCOqRsI1huxG9kNdfcenyLiXUaOLE/oOZeVTgn+y
         H33Pc1le2QK1zfcZuyoaij52xgrFoRzBVgBE3eYhyQawtkstNkJlfuTyn70NEP/LLLnB
         QsJw==
X-Forwarded-Encrypted: i=1; AJvYcCUMRBCsKzHDWhbD2lMCxAqCxCJHlbMqeJtbGx+KBYIrjpYaV7l0MzUeoCys6nOxj6DPpVSUKv9YW5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NnX/LjkDF/Wd5SK6AcgT7V7qFuOyB/0lt6iKGPPr+BPoS69I
	zKwwQ7cP+kie0KCboMOIAUqWyN5z01D/uU4vjEZtE2Y8LerTuw9DNUPu3jgSy08=
X-Gm-Gg: ASbGncsCtyxoCOjFFQv1cKEQHYMRlQI9rsjDoZMi3qQAMi22yB67PhE5F/yVfOxRbMe
	zsD6/UUP6LoStcY8Y9l6Ahb9jtKymJ6L0/+GOi2i1uVve6OgtZ8I5cXmZiOcxQxZm+Ps4fQTtgv
	eDtMg+Aw7vwI4czLiaFOSI45CrkJXAZYh+E9qZNHZwBQHRcV+NOsQYFXxLWuZJ29X0xEnFsahbX
	EqMczzijGkBksovYOPGpRxQCjXe0at2wUeFFZBElFMbso0JBpfVuahMMdEq2Do21Xaf9tylvQmd
	El6LepWYz6x2doJwOKs0sHM2/NNWIKVkmelrL8eglnciEvoEoQ+wvOy5UPwzCun0HV6FZyJeieH
	STA==
X-Google-Smtp-Source: AGHT+IGCdyRrXA3gFk3nBMhtBGH9c8nvuEZ3lZ6EALzxbQyXUOgptExJPWtu72AQ/7Ux8Uo93heJog==
X-Received: by 2002:a17:90b:380b:b0:2f6:d266:f45e with SMTP id 98e67ed59e1d1-3087bb3e794mr27325433a91.2.1745398412701;
        Wed, 23 Apr 2025 01:53:32 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309dfa5f880sm1047611a91.38.2025.04.23.01.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:53:32 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v13 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
Date: Wed, 23 Apr 2025 17:04:45 +0800
Message-Id: <20250423090446.294846-5-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423090446.294846-1-nylon.chen@sifive.com>
References: <20250423090446.294846-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix PWM apply and get_state rounding to ensure consistency between
setting and reading values

This fixes the reported errors:
pwm-sifive 10021000.pwm: .apply is supposed to round down
duty_cycle (requested: 360/504000, applied: 361/504124)
pwm-sifive 10021000.pwm: .apply is supposed to round down
period (requested: 504000, applied: 504124)

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 6259f8500f71..4cf3e715fd84 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -122,8 +122,8 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 
 	state->period = ddata->real_period;
-	state->duty_cycle =
-		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty * ddata->real_period,
+					     (1U << PWM_SIFIVE_CMPWIDTH));
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
@@ -157,7 +157,8 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * consecutively
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
-	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
+	frac = num;
+	do_div(frac, state->period);
 	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
-- 
2.34.1


