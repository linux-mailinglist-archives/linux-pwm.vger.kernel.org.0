Return-Path: <linux-pwm+bounces-1608-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D755C85F298
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Feb 2024 09:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C15B283148
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Feb 2024 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442B01BC47;
	Thu, 22 Feb 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JOtT518B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D32230C
	for <linux-pwm@vger.kernel.org>; Thu, 22 Feb 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589602; cv=none; b=tWSqwkiu6JuY6o9eakUq6D4hx4fmtdT4KV3asItQdRfYYd6QrUzm/EcEJds+3qmaDSF96KF3FV088d6AvsdSyZsPsZj7QIlcCWEh8C4F1E5OCc/U8OODKA/1XB42yX2KVhSL3kotuQ0jpR0vECI1vGtxv75gJ0aKQsMBCQQCW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589602; c=relaxed/simple;
	bh=Z1dTn0Gkiacy9ygCtMQgZsRONznaH3pmxeR3C8lF2Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8uk+0OJIAqhOd31lVOG/DFV6OUDPEIW1MSwzMTPdq7d4LDHMBpL3DHnrQnwCNkHMHzQMF1H4DyKrauVCFptshUttwx9whFAg7qlTCvhOEefrQnsV5InTkrdE5XvSMmBFYcW/LDqPgf1G81ETXaWKx0EZAKhL6+pSqfAmrc9Tmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JOtT518B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8da50bffaso39321445ad.2
        for <linux-pwm@vger.kernel.org>; Thu, 22 Feb 2024 00:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708589570; x=1709194370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Thj6USXv+zFZqbn9GMP05XSRBqohJA11glRlwlO2t8E=;
        b=JOtT518Bilsath7/0BagXPuprmaG9kHXt/1L33oBtkRmq5zZyHjb8dsnzjC1iHV92U
         v+Z5yKj2F73lp/tpnJkoDI6boSbOSvsGgHqEAzysIbg4sK/dSzLxAzEg0W0z0zQ/kF17
         V9h9Hx57ZjAZF+D5RIwEpvUj5wRzGx2+VTOhggh6AWof3GC5VnppDyWMiRxpCLng0O3I
         Os2vyMSddVWPfYwb7wzelELhIFXz1KHPMXvmd8MREuImXIBAfJegm4qCo0IUT70Z/xvE
         3KNYS2+pDl9LrAwyAsRJGoELaIRUy78HEwXUq9i34ZRvPOa5kD+kyko/XOFoY1HNHGaR
         0GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589570; x=1709194370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Thj6USXv+zFZqbn9GMP05XSRBqohJA11glRlwlO2t8E=;
        b=hd9eSGjaz0mpgzk7Wa+C8y7fvwI+v8izgeoDHC3PNoNasLFTMl8/yWGj/pzaDWFqYt
         XfLIpe9m2gQRihKnOJ+8jLwzOmLC78trExvvaEVto+qitYEF97F5HzyVRCyQjnkNUXvN
         gsiD6B8OAwGg82K+c+1FbLr48uHK9nca0UkmbB29jD2i7ts+x3qblRTWOkkdUcc/S11Y
         MNwF4D0l21Biks997+WElx3VAzU0dO6Pe85FuX/ZW1+1FnoXktRinovRQpWdKw6Aepa6
         w7E82bVYcvnUkPuQRst37CFIlPqIKbkCkAtFWYEuL6Glfg2tbAQXtaQEI8j6QIBTlYf9
         Pgzg==
X-Forwarded-Encrypted: i=1; AJvYcCW2eo7c1gZ0BWr58Mz0uD1XFL7YwdCwA2W/nxyNqBDgP37iBu1AwlA3t1TgrQRKlh1e8ugTxoUBjvD48tWyn2rKNppiDbwuLp24
X-Gm-Message-State: AOJu0YwIDn+PO3knYO2dJ/eqHWY1SfJrBpiHgbc2WcB45LYAR0TOuTV9
	2MKVG5DcPAKeZ0QtZ6auAvdktuG9GHL6oehNGSsCGw/5uJYosO/nvJuZYuFfWKw=
X-Google-Smtp-Source: AGHT+IGQEH1Pckgyx97VaV3qo9MCG5UniieyW2RPfQREJEuRYUX82wG9nTv/Om2GeygIf4u8y9Tjhw==
X-Received: by 2002:a17:902:e751:b0:1dc:1e4f:9b3f with SMTP id p17-20020a170902e75100b001dc1e4f9b3fmr7654206plf.24.1708589570167;
        Thu, 22 Feb 2024 00:12:50 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170902fb4800b001db5ea825b2sm9412796plb.123.2024.02.22.00.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:12:49 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de
Cc: vincent.chen@sifive.com,
	zong.li@sifive.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v9 2/3] pwm: sifive: change the PWM algorithm
Date: Thu, 22 Feb 2024 16:12:30 +0800
Message-ID: <20240222081231.213406-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222081231.213406-1-nylon.chen@sifive.com>
References: <20240222081231.213406-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `frac` variable represents the pulse inactive time, and the result
of this algorithm is the pulse active time.
Therefore, we must reverse the result.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index eabddb7c7820..a586cfe4191b 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -110,9 +110,10 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
-	u32 duty, val;
+	u32 duty, val, inactive;
 
-	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	inactive = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
 
 	state->enabled = duty > 0;
 
@@ -123,7 +124,7 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = ddata->real_period;
 	state->duty_cycle =
 		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
-	state->polarity = PWM_POLARITY_INVERSED;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
 }
@@ -139,7 +140,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret = 0;
 	u32 frac;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -159,6 +160,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-- 
2.43.0


