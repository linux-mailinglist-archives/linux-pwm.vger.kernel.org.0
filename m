Return-Path: <linux-pwm+bounces-6172-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2846AC7695
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 05:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26C47B10E8
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 03:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519E19DFA2;
	Thu, 29 May 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KDBgeNcL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFC248895
	for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490198; cv=none; b=NUqrS/Zotnr3VVw9Ev+b8BRIo0X1H2PN0Autdoqik9iL7QA7kpm1MJctDa34Mksgn3WC3WR4bdktXYiOGN2pZSm3wqqUvZmhU4XzB5bFPx04dGFMJe53O1ZGr3oHUSOhc/Oqj92y2DxScZH1Uc4IC/2/T8tuPxLwDB7/vrnZuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490198; c=relaxed/simple;
	bh=AJvyJ7Wuh+ibUAhKc7RsaJs2i8dB6oF3sV+4cai2wgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VxUqu9FXF2YovVfjgHVwwf8lJFP6NuxGMB1Y0NTjM+qEavzWnLj4DmIC+++GdSs5liB99iDjVlfozZNLlW+gdrFyL7moDy6T2m89hSTbUvw0m0Vu40vi0J6ssmjOQ55U2Np++iOHL2d8tGvdPv9+nWypzyuhOpv94vDNnDp8GOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KDBgeNcL; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-234e48b736aso6003895ad.3
        for <linux-pwm@vger.kernel.org>; Wed, 28 May 2025 20:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1748490196; x=1749094996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=448SqyxCcqHdB1MtWjOy06y/TgkzBx1OXFYWd5DfdV8=;
        b=KDBgeNcL+wu7XYEa06JaJ0weR5YtkPbaCkRyaby0rVjgamJZloNmW7GgBTAHPdiqpE
         c9NKVT+dYjU514R50rs+uuAdUz+RLQXj9y0mJckDRs5SmIE1LHUVJHkvpwLPloowg0Iy
         o5aa5LVC23AVEh+d9XVQ3KD77yGIEBOh3cZcfxRqR0VoLqAi9rpp6ORVVGLwWD6oINnR
         Eag2Jra26AqEkd0FJNGFFx6TerRhPH+kgq2yGzlGSNVDUWLrOg1B834i4gMV1aX6Wyr9
         GRAZkFZZZBH/lsU9zkuvAWBLK2nbIiesyVJr8eLV025zut3l08+d6FKtNpSFPhD4xUBc
         Y8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490196; x=1749094996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=448SqyxCcqHdB1MtWjOy06y/TgkzBx1OXFYWd5DfdV8=;
        b=DBfY/CWRI42UpecTNiEtwpoAG0bL003YQJ4VdcxMnL63s0suutgyQs6R2RDMW8QisZ
         5JF2oX6dnmPRs7tish09EajUYpSlD8aaHj9FdCgf+uUXnXscDUTzS87g45avsRyGcvSe
         CNdy1JlWmdYSRLcRfh/rKvGEF9+Xb8mYDn4H69cgu6eExfFOjXiWFLKwWhKyitBU3lTq
         c10hFg//3jH8FbPxtkryuBxaQxs1DIcKrsQtd9IkUF78mPO0phMajme5onHN94EcrxA3
         tI3ROhW1of7wx/jVT6fc/ox5KDtm4Z9Qn2lRgJFaMwshgkVVLUazOUovHero1lwBORBm
         YDsg==
X-Forwarded-Encrypted: i=1; AJvYcCU6wb2i13JmqEdCCJ0Vhbtjmh3fFSSiX4dH436x/TdQ58Mb6rFGlR7Ql1N5043bFYJrwDHQKM8UJTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5j1kLr9QBab5uOA+KfDFW5zK08E8WUTSiEbQlblZm8UMYJyXe
	IQopk0hUYPxyj1LUOm1CLdK3oo3YOTpk21b4ZwN/Xuj0iw2RhcGbdIe1El/9Y+pv19I=
X-Gm-Gg: ASbGncs8amos4Dq6sl/g62HiFgXgGn/gQDBtGduHtm7S5lfcxst87HeZjzABDdlIxwr
	nQFc4MM5cKlIRJyYMGk2Fu1SirwB/cwF0obelDlkNr0j/jReq/Zv6n4Y5cZGRxWRAPwwA8qy1x6
	dBx80gLlAa3XUSpGIvZnSuW+suoSI2hwf0ebCxmAC+SnS3hdjY6vci6rBI/yjuhUzTkDkQ47ABr
	BRwvAg9OZ+W/JgaUj+1y41lIOGTbtAoJjglC5ZY1Gs805gh876Bz2jO5/U5q2ibgYnFtrzM1Kod
	w9tmkUJn0KeMWZy7qsTRcDMGmDlG7jRhdTuJ0IIsaMAUMi+4Fq/+vv0qhxQd3hzu+46VHy+piJ1
	VEah+XA+QMHcx
X-Google-Smtp-Source: AGHT+IE4rnvwnzbHP0ZnIPLYdwNfcM2rTJMSw/tDJE5alNjUy+010GmhlfhJSC2GtgmwndX31yKcqQ==
X-Received: by 2002:a17:902:e951:b0:22e:b215:1b6 with SMTP id d9443c01a7336-235080396abmr9037875ad.28.1748490195873;
        Wed, 28 May 2025 20:43:15 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd92c7sm3425905ad.62.2025.05.28.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 20:43:14 -0700 (PDT)
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
	Zong Li <zong.li@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v15 2/3] pwm: sifive: fix PWM algorithm and clarify inverted compare behavior
Date: Thu, 29 May 2025 11:53:40 +0800
Message-Id: <20250529035341.51736-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529035341.51736-1-nylon.chen@sifive.com>
References: <20250529035341.51736-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `frac` variable represents the pulse inactive time, and the result
of this algorithm is the pulse active time. Therefore, we must reverse
the result.

Although the SiFive Reference Manual states "pwms >= pwmcmpX -> HIGH",
the hardware behavior is inverted due to a fixed XNOR with 0. As a result,
the pwmcmp register actually defines the low (inactive) portion of the pulse.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index d5b647e6be78..f3694801d3ee 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -4,11 +4,28 @@
  * For SiFive's PWM IP block documentation please refer Chapter 14 of
  * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
  *
+ * PWM output inversion: According to the SiFive Reference manual
+ * the output of each comparator is high whenever the value of pwms is
+ * greater than or equal to the corresponding pwmcmpX[Reference Manual].
+ *
+ * Figure 29 in the same manual shows that the pwmcmpXcenter bit is
+ * hard-tied to 0 (XNOR), which effectively inverts the comparison so that
+ * the output goes HIGH when  `pwms < pwmcmpX`.
+ *
+ * In other words, each pwmcmp register actually defines the **inactive**
+ * (low) period of the pulse, not the active time exactly opposite to what
+ * the documentation text implies.
+ *
+ * To compensate, this driver always **inverts** the duty value when reading
+ * or writing pwmcmp registers , so that users interact with a conventional
+ * **active-high** PWM interface.
+ *
+ *
  * Limitations:
  * - When changing both duty cycle and period, we cannot prevent in
  *   software that the output might produce a period with mixed
  *   settings (new period length and old duty cycle).
- * - The hardware cannot generate a 100% duty cycle.
+ * - The hardware cannot generate a 0% duty cycle.
  * - The hardware generates only inverted output.
  */
 #include <linux/clk.h>
@@ -110,9 +127,14 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
-	u32 duty, val;
+	u32 duty, val, inactive;
 
-	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	inactive = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	/*
+	 * PWM hardware uses 'inactive' counts in pwmcmp, so invert to get actual duty.
+	 * Here, 'inactive' is the low time and we compute duty as max_count - inactive.
+	 */
+	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
 
 	state->enabled = duty > 0;
 
@@ -123,7 +145,7 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = ddata->real_period;
 	state->duty_cycle =
 		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
-	state->polarity = PWM_POLARITY_INVERSED;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
 }
@@ -137,9 +159,9 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long num;
 	bool enabled;
 	int ret = 0;
-	u32 frac;
+	u32 frac, inactive;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -157,8 +179,9 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
-	/* The hardware cannot generate a 100% duty cycle */
+	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
@@ -190,7 +213,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	writel(inactive, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
 	if (!state->enabled)
 		clk_disable(ddata->clk);
-- 
2.34.1


