Return-Path: <linux-pwm+bounces-5645-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB97A96307
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDFF17D197
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD102594B7;
	Tue, 22 Apr 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I+r9HcGV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BE25C705
	for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311321; cv=none; b=GlXcxQguJg3dcS/xid9bdi3acY4bydMmPTS0mjXeYFxhvLgfDxQOxgiZjAX/wiD7hOwK5GKjl8N3fG6jkVROqBZQfq5tUNaz9Xkbj2GjoZVJ6+jUGCepwYrWhaXZSmVjDk95YoiZe5C5KS2UJmi41i09d1TQERxS1MvargLCmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311321; c=relaxed/simple;
	bh=AhRbnxt00FmE/WhEN1u8zVz8q5gXEKLj1JYmMYck0AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WyEdXeRl/HkqrxxbF8y0ssinn9BQe/L/tjrZMKH14eQC6bvvV+7Kq5d17eiL18uTmTA89t9bkjdfxH8uj+01i76pm/iQ9x6iami3N6azp7CTJd27MVly+B8S66C2bywfEY1ZoO/l5RZyOYKjeuB7g1U405OsE4fkdJnT8pBe95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=I+r9HcGV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376dd56f60so3445344b3a.3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745311318; x=1745916118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTYlTOXj1U7VnsAmcUnx1eYdk5rL5ZGZ7LNT8Q6B11E=;
        b=I+r9HcGV+iABKy4DaG0c045CG0YwQTWTa4bafq3dWTL3lYxp5PX6MkerrHE2icSFme
         rcWWJLIhCk6qOz4yCqOF39nN/tcGIIRMP87r+mFEw9oVuT8VG5RPEMydKlsVcNgam7yK
         baMQUSf2Bh6ZtrSToSuuRD/J4WSIywx+6jBwbw1wLYZNSR99A98rKDj0SBo07dkeASc2
         9P9FWqg9TGKQ0hWkt6DRuH4EbynnoMGbR99FC0Pjxm0MWaozMEmsM9Hr5sprfSp1HHqC
         BmaLSpl8nRv1LMqvPzqwVnF8FID813TxbMWeirNjX/Gp1eAM25iKVp1i84Kgi0S+ccV6
         hrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311318; x=1745916118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTYlTOXj1U7VnsAmcUnx1eYdk5rL5ZGZ7LNT8Q6B11E=;
        b=bzxr7LmXz8/3CcftBxqrIM39XNL47oMkOXYBtyCHJLMO57XUsajRUfoJ19VZtdxG5O
         ty2rl09OzXSznE2A61cJoC+qfbZAZjncp46WtgkljT5BUQWxJJsVguNaojnu3YjN4wrj
         ciirVb9TJN+qaCtaN3UtlRCrvCV1U5LOUDkdKSObUgDrCNbXKyKqAQgdN6VxLmKVn0Rx
         eUmTipNsK6fIqzBnQC94awn1bmnxngck6I8UB1JGiz/fXIdW8TBzr6dweci4bfln+Dbe
         fknVo7Y54/LJQMIq0d0jqALAFmx5fu8JMnnxPQXR9z+ETXcBQxAIVO0FGlibT3A7170I
         KchA==
X-Forwarded-Encrypted: i=1; AJvYcCUYlrpD5dbS2Kj0K/pricNtNxrai9CETfC88DnrUJHxwlVslbY3CXYJ1TmL1miasgKW3GjzfozGyAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8KZnHcpqnK90PnqCn5YyThHVcsrMRXNKIwUuQOHxExigUbDJO
	6BPpVky2a7LaIhvbuxNl8Am1/6P5WbyUzFCtjfly9GgYpCx4M1eCJKEHvKez9aE=
X-Gm-Gg: ASbGncsuA73XyMYzxcpL0B/m64vz25RMPAKP1BFKAP9YvbIOiW7fIljfpEEPit45oJ0
	AFLIu4J1oVMS0blPFmmx3LnLL9z10KQWTH1NOhpfb12ihajRf1WTsCPftwbz+WIbR1KJho4WBX7
	U3K20XieWw3+FUDMVIuiepjF6AmVMPZF0tlZN7R6xQzi8Pif5OartT1Thw0z8LrGiqbju2rQI9L
	Whs1dBuzCuAiWoiJCG6FD2pDOzHZvCo2Q4g79JJNemwLhbe/MYasraMmQWdJWe0YYxPbqjB+wSb
	LdTCfU/29qUK8AxJD5CfdBFM1TceIQRjWxD/9FAl3zKGNIWBuM9/C3byJ8XSH0NZ3yeZuFk3h9S
	UWA==
X-Google-Smtp-Source: AGHT+IGfbihuBEBc/pdNIJMJF4VwDXG6UwENQDwhbQ6dawvH9aE1MJPeh2yhFP9zSoJtskbZsJMTIQ==
X-Received: by 2002:a05:6a00:21c5:b0:736:2a73:675b with SMTP id d2e1a72fcca58-73dc1568a74mr20805479b3a.19.1745311318480;
        Tue, 22 Apr 2025 01:41:58 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d7f7sm8038343b3a.82.2025.04.22.01.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:41:58 -0700 (PDT)
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
Subject: [PATCH v12 2/5] pwm: sifive: change the PWM algorithm
Date: Tue, 22 Apr 2025 16:53:09 +0800
Message-Id: <20250422085312.812877-3-nylon.chen@sifive.com>
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

The `frac` variable represents the pulse inactive time, and the result
of this algorithm is the pulse active time. Therefore, we must reverse the result.

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


