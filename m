Return-Path: <linux-pwm+bounces-5647-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF84A9630A
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B46C1797ED
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363025B698;
	Tue, 22 Apr 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZEdL+XXW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E225D52B
	for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311343; cv=none; b=FdgMdp/sZpbCMD21ACQJnlVtQ20I9MrYssUHHgH/hmzMdQ/0MGKVzDQ1iN8l42uf3JwK+1sVtobDgCQrIVRy/5JpkhobZQfEtX1RqXW+HnwSZA6pCI54t7rY4A65BoOfYIm4t9mrciV0oHLJoVZTQ4b179702nXaOHmHyqvDSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311343; c=relaxed/simple;
	bh=EzCnckv9uZo2HPeOYfcjt07O4220J44jVkWlG4oW530=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFoMAyk4cWQ8/Xjqj72T0aqpsQQGoJf136n3qjTF+jgoLcqIvak8BUPrKc2BEc/oCJ79swIytcPizR3LnCleOhR8Y189xOXR8Uk8EMNzA86qGsUoxFdtx50GpB0i+jhEJTsMClwYMh2sZRlDKcADN0vlwMua+3BA0bOpBoLWnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZEdL+XXW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4094717b3a.3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745311341; x=1745916141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kd2q5FNIM78jM5HghPwsl1jyBcissy+tuMihRdmdhE=;
        b=ZEdL+XXWc38j0cl9qTgvCLaSKSqUXODHil5RYbnuk9uvEwoUrsCxQRWKk+Mz68x2xA
         Pljt/qutYYTRFWepTlcNhfc5DVDYa2qnNkeWGxiKcUS5hNzLGLfGgNId4JrrKKbxytJ8
         bnZlgaDFlaW/Um/alnFdGBORJgeBrPs+B8hy+Jhf1e5pt8Nn10uqd1jo6LBlaik5gke1
         ddjF3ELqVGnQnsK40aV5Z4qJY3UP7DGKbZTTcsfZGh02LvIvjNfu/nJh3IZ9l1ocGimI
         f/ubtfKYOEzZme1QGi5dxYyRLZco4ULfPsj158Nn0glAEzgFIHH7Gb1pSQmg3Wa2cWwV
         eOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311341; x=1745916141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kd2q5FNIM78jM5HghPwsl1jyBcissy+tuMihRdmdhE=;
        b=feUBhHfC3Zj2eZdJXJsaLhLCwdSoHZYpPhJUW8ho+4cOTc6VZMCuNZa9pxz/6Q/nqj
         KqI81jriVET6qAyvuD/pkaVs5Mvi2GiArBBu5tFGloGGhgWetFk3+U63nXJSrW9hsTDF
         QBJhNJUQ3M69mMCVwyJOgnS773uAWJXKcuRuswdYkYxJR+QDH66m8J5BfT9vSiAMtebD
         yNF/zz23eFFB8napLm3Vxc2zPJWsOFuasYuFtqC9IiFP1oHhl27I6U8ZHnSzMKWCbUMR
         +VmGerqtaW3X33tdyGTkzoshGDsBDU4Nee2RfkQf7yeVPmSOeiTgcaiGXOpmdbqsks0C
         kD3g==
X-Forwarded-Encrypted: i=1; AJvYcCXZtPuhhfT6oN8ZV2MUxJCjQjfFyRUhPXBI3/6cU6rSz3JQvtRs0vgjknXSc/N+vAANMYM8WBLXlYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmLcCoJpcHiDKDSsleUvP+I8hdQQOnGANeTcsxNzBDRIwPP5d
	yA63XMH0S5EEvV06jCasXy444aFz7n3mk/kswbKmtzzvRiO9/YrZo0gQAMLYt7E=
X-Gm-Gg: ASbGncuuqoCB/dlpd6axgymSYZ8tyhDkfWVk9HUGTCqoUAorv5xXXDh+9dK+WCHiE3F
	D+Ie/d1cDJV6p1SABG6EVPzeVbXYzuCGN+4bC5xjzqwgx4BwM9QwACeaLHGa9fVceT1fUbohNwl
	fprJQ1iPY9KrN1FVAl+5xdYuzbnKdEHrhnE78u/BRxSECItuBNP4j/q8BUX9huPdn6c0I6fEoK+
	y4PFTw7L7zcNM7UJ+SuIGeU97Dxn3/3GFZcoic1uc++anBdCRVlLj1NE1GzjnGgUMtNULjqVXGW
	A2InI+N3g5FpG28wFB/7aIg3iqlxKDFHq8FOKYzgP6MWa33gE/kDUg1k37O4yUpffwc4Xpb9/3Q
	IHg==
X-Google-Smtp-Source: AGHT+IFXZZ39jj72YYhr/K/5oJ3Ngnd4eF5Q61F34OsaTVnM0ysvTXVv8micdw2peLTPVFWC++GWNQ==
X-Received: by 2002:a05:6a20:9f07:b0:1ee:e96a:d9ed with SMTP id adf61e73a8af0-203cbc251cbmr24313065637.7.1745311341488;
        Tue, 22 Apr 2025 01:42:21 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d7f7sm8038343b3a.82.2025.04.22.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:42:21 -0700 (PDT)
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
Subject: [PATCH v12 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
Date: Tue, 22 Apr 2025 16:53:11 +0800
Message-Id: <20250422085312.812877-5-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422085312.812877-1-nylon.chen@sifive.com>
References: <20250422085312.812877-1-nylon.chen@sifive.com>
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
index 6259f8500f71..065d6d2b84bc 100644
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
+	do_div(frac, state->period;
 	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
-- 
2.34.1


