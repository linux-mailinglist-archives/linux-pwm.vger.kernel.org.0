Return-Path: <linux-pwm+bounces-5610-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DCAA94EE5
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542A71892C31
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5E259CB3;
	Mon, 21 Apr 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YGA4WY6K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536B25A2C1
	for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228646; cv=none; b=XqIPP9CKt6qTOO0OwY5UZ48TWBGRVb0aMaN+ul1yuaCvxfkypZJoIH8cbzRFzFnubEz6b7odrlsuiw+o2koo2L1WHvHXLbK8k3WVSsREF9GLGXPkUHh++xeeyqRtCFozeMvKvbiYOITdIAKvGXL9p5M3t9sdYqYDAnnIxmPZgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228646; c=relaxed/simple;
	bh=AhRbnxt00FmE/WhEN1u8zVz8q5gXEKLj1JYmMYck0AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAmQvY8PyPP0VCyeRJQ6TJZLKopppoGNlb/sfAXwNJ/WSees8TLW/334ug7FBfWQDMyDfyupBCb92iikN2d6caKW2UeVoabcRW13+9fg3tsPAdKGdqMz+OPbWLb7r8K+OL2K4g90BK3N0REMHi0SRQLrOG2AB1zAuA2qsVb5ZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YGA4WY6K; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2295d78b45cso61229645ad.0
        for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745228644; x=1745833444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTYlTOXj1U7VnsAmcUnx1eYdk5rL5ZGZ7LNT8Q6B11E=;
        b=YGA4WY6KQSctBDXQ42DOC/hbszCtaDYiSjYik0hKWJoyHP/aLVQxyrG+eHxsvTq6tm
         /3fU76TKg+R6WR5i8PVo0Tx+nxx+MCQwEdEESqzDo472JqyVkhdhp5fjFajZuGtG5XRo
         rsVABhKZpUSCRgOxHy/Fb6AHG99AOw2yyh1YAu42Xn5HgB+0/YndFty4EVvEoIC+JHcF
         0N3uWT/RkhS4IGGCbrswvpcF0dSPzzzHa69o3VnXahBDroOoDL2Li25LxveAJpUsQ3iO
         0oojZJfzeolI0k16DITY5pRcQ1PvPFlMTx4XtU0AD/sonxAlDv6V7wPPs2/UdP7D2DXV
         w6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745228644; x=1745833444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTYlTOXj1U7VnsAmcUnx1eYdk5rL5ZGZ7LNT8Q6B11E=;
        b=mLxIFfmQUhy0kVE0kee0C8xmYVze30z3PljkUWbd03ChxnuWXrippwvrWsVdQ5BPDX
         TmWQR2xBqrI07/bp41GcccM9VtHwX/XM71ljdrGp+u4tWeHfqoKssES5TUHG0lRDxvmu
         eUl9LawdhCGMCu9PNQsNbXoVyWKt57j69x4kNoiTtsFbWaGztyeQ6sT2qGLECtYJxkfx
         NTKq2awxiGqZ/uDthpEfgJuUxGIeoD7/2mie+56wRY8xnPF00Zv9JhpAmHV0sQUhk7Bc
         vkATeG+ns8CN5bcECyjUACwzxd078KxSvX0gIIxDrAmqc98B05+H/GpzPkg0l/QH/Gaz
         0Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCXOzbgEMxv5upCgVsSlGHG4O5tQ4TXuo+7sz6SrKYMPc1gSSREXVsBRA9KqrjhpuVfBVzdVGEoxq1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulmY2UlTgIFi7iekDxglRO0VJlTPwHI/0Imx5Az5uKuH4xj+M
	y18SIv/bhLB0zJrXro0Ce/94uoJwmd2EM05sv7HVf/0Oy/JQC6rCTGzf/6wgF7I=
X-Gm-Gg: ASbGnctBIufTRZDMRKCQOgavguaPUZIpZszrEEXv5I0GK4MSt5kkM3QgJZrUypf3abW
	ajivuLV1OSXZP+11nrFWKpz44qp5MNBtViX0AOGnLNlo0Ss3F2ubSC7GfcoQS+HwIOVzm/bnPVo
	mAs7MxTqZd4mmD3HHHextlPsTpM9tKr7+nVLObTcX2iQ8FoO6AKr7GwNy1Lts37ZVy/2d5w82Ve
	3+mms0M5B/U3KqWGJD7O12m4orbMPRW3OvH0Asftu+t0m7WPlK2vHpttv/lcIvu/s+du7nZBoOe
	jJ6sEhI7MilukN25D/z8SH+rNwsFYP0w47jCKFwND9oY+afQPLnTH6DDkMaRoG4kf6PDKRsHBoN
	nIw==
X-Google-Smtp-Source: AGHT+IHEYpGr2ZvIBvvKW7ZFaNUJwrpR7XQJq5VPcYBgX/Wl0N6AKjMZmEmIW83x6cviTTPcE+wOYA==
X-Received: by 2002:a17:902:f541:b0:21f:c67:a68a with SMTP id d9443c01a7336-22c535acbeemr153720645ad.31.1745228644193;
        Mon, 21 Apr 2025 02:44:04 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf32sm6371965b3a.142.2025.04.21.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 02:44:03 -0700 (PDT)
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
Subject: [PATCH v11 2/5] pwm: sifive: change the PWM algorithm
Date: Mon, 21 Apr 2025 17:55:18 +0800
Message-Id: <20250421095521.1500427-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250421095521.1500427-1-nylon.chen@sifive.com>
References: <20250421095521.1500427-1-nylon.chen@sifive.com>
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


