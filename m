Return-Path: <linux-pwm+bounces-4489-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF49FBB21
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B381885A04
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4D1AF0A4;
	Tue, 24 Dec 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ITozso57"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA871A8F9A
	for <linux-pwm@vger.kernel.org>; Tue, 24 Dec 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032496; cv=none; b=f1DwXD6hRD5vL6ww/qTKJkIET5DU8d3ZqplJeO7eYFGH/avy8JoRIf+dSC+/Af6Cp17tEqp/MQMnThNh+Wnso45hU5nT8Gg/KLYlPWZUkOoBSxSea4CRo/QYppth5kBd9NZblAp4yxYpPGoln+IER31ZSapqOCP4lUIcUk21AxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032496; c=relaxed/simple;
	bh=2VZgQzqkmIHGbSxAN4ilTEh2INUhlZFHHp/XIMBstrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2uYAPLt4cUNkDFgWMMkaqoeH0695uAlQ2G3j3auR46jtme7lE5Ry3meXUOCuSJZF7kdPMt5XNFZg030ifeEYVVu8wNOeAhs23Nb9OxGITzsZsS5PxAqGPJ68cHAc8W2AFUxFeFBbqxCnRVDN3vSr3pdEEfZJHUhzZpiqowGgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ITozso57; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21680814d42so46167205ad.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Dec 2024 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1735032495; x=1735637295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foFQx7pLXh9yW9AzrGBy+50v7YD42XfIXa2v/75AelA=;
        b=ITozso57kC7w9M1kDFgVvwPhmvxAlcyFzTg9Zy5uRzjnUgGMpmQLVg4A1U9Zs3d5JU
         xLwlfr3+gDTx4W0OJnRTXsuKrxf/6BTONVDOE8un+x/82P60EQsgwl5Ikrj89b2IUK9y
         xPuFpy5lXWcbOZg88596TQ1AL9ENCIGlHCbi7X1CmNjkFfo/8hb9U6rt9DlJq5JEKg54
         DUfEqyY54qecAzfl+3439APv3kx5Y9lcW3kaZqM7ZD1htgGFkazPsxoS+i16fn+YE1Cn
         95C82Ujcr7ni+3rVgMjGtHeLIbw1uc50NabBU3r9stFvHFbPrz0RhmpksXmTq21yeesP
         V9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735032495; x=1735637295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foFQx7pLXh9yW9AzrGBy+50v7YD42XfIXa2v/75AelA=;
        b=Kc5hUOHWGDQZQ6JVj5T9mmQF+z9EeAUdOhHSFDYebfwZgqZi8Aols9s4CrzYvHPs01
         hE2r+I4r2HEA4yTPAQcC79uSDbX0SdsyH10e2rS1KfnJcfAQ1jPjDBsEm3LAEyUfS1mp
         oiibJvHVyQSWf3w0331YZz8zSOROJt8UJFzVoySMYIttzf1IUw7a8zs2OV7xLKe2FQTd
         U8/hkqNd6Chud9ox2s6efIo4ABqf46LqVzATWsia7grAqQINhPU3SXNk1QZrIq3Lknyj
         pKoW5Ke+VatPZnYhTii0YVQKnWAa9pyqfZO/lt6wQt4NtUD3ASrpyhLflsUS9eN2FFGS
         TLIw==
X-Forwarded-Encrypted: i=1; AJvYcCWqZm8bb4ijHcugWP+yPV6kmtgVaUd8fH+JmZet259S3aR0spnJQYoedRPnTjrzWAIUj7yMc8oitfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvF9jvo2FLHex7Kv3ZJ7V6CH1A0UQXOiJUwZm3dr+tqPCGj8X
	CzVlXnW4wC+RSk+FLBNZLAl6HDIR2aSA1+KbDM+4P0mfvn9W0ta04dzSPRzxLvQ=
X-Gm-Gg: ASbGncse40ewna9hVgplLlAQiNxB+ryTCLnZ3qQZ0c60Jwr8t9QCUf1vCLhtSKLD8lb
	IwQ/KCfN8XEeNbxkfcz4FoNauY7g4U+4xSRx4Aa+FfX0lg4aGYei8E+9J7hp0R/3zkHbxW77V7i
	zmUUnSFXG2ofQyEs7uszRiVh01P7eyfrWZxfWl+PxjhejVFGf2fv9t78wO/N65tLDI0MH5Ie23A
	vUonayvj08r3Q6D+vrgY8LPUWU5LhAmAHXYomDHOKcfUZkjirMFcN3EXZpdmAo6epbbOTtBMVfK
	RJvDtYYeB8RquT48vw==
X-Google-Smtp-Source: AGHT+IElaW7KRvjzzkaa9PnzdUfH1pw/EWBS66svqEXCyWXdLzH5EuyNp84u4FNtb41a24nBilQU3w==
X-Received: by 2002:a05:6a20:1588:b0:1e1:e2d9:307 with SMTP id adf61e73a8af0-1e5e0802532mr20282867637.33.1735032494734;
        Tue, 24 Dec 2024 01:28:14 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72af8dcff60sm516341b3a.152.2024.12.24.01.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:28:14 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 2/3] pwm: sifive: change the PWM algorithm
Date: Tue, 24 Dec 2024 17:39:00 +0800
Message-Id: <20241224093902.1632627-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224093902.1632627-1-nylon.chen@sifive.com>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
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
 drivers/pwm/pwm-sifive.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index d5b647e6be78..bb9146267bc5 100644
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
@@ -137,9 +138,9 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long num;
 	bool enabled;
 	int ret = 0;
-	u32 frac;
+	u32 frac, inactive;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -157,8 +158,9 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
-	/* The hardware cannot generate a 100% duty cycle */
+	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
@@ -190,7 +192,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	writel(inactive, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
 	if (!state->enabled)
 		clk_disable(ddata->clk);
-- 
2.34.1


