Return-Path: <linux-pwm+bounces-7066-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B383BB26F1A
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702E9AA62EA
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 18:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9923D7D5;
	Thu, 14 Aug 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5KgU8UU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A5235044;
	Thu, 14 Aug 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196883; cv=none; b=C4s9i4iWxd2/6QggnRg6RE0E7nGMYsxFIol6zGMznZRYauwfZruw23DpYN36YCXKv+IcAhqHrTlX53IR/np52NxgNiT2/ZTqcO6WYDlKokzYGeYbea1cVsRdbVn0MO+Xl8grGDKwlL5+63/2+9twyHFR7N+Zfv7JX7FNxQMNKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196883; c=relaxed/simple;
	bh=E9nZvthPsuzjFPVZQ88Fqaa12g0bZzRpT+AEg5fYq2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3Tpz0lvgX49LWrFHN9CB+dbqk9bDK2jkR3tNyN2F0iQhotaehJI3vLNAwYnHJpzgqm6AW1ku0xCno8uWJ4RHh1bxPD/yvDvdPlPjMoTLPGAmlPhE1EJsFYh9VhB2qmgcIrjusjBmcsAwdcUF3sbEyx9zlGh5irtEiTuJdjo3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5KgU8UU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so198125e9.3;
        Thu, 14 Aug 2025 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196880; x=1755801680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfDKLYTW6+lKsgYQaQXkVu1QFpYTDZJmYBFQGV4QYj4=;
        b=O5KgU8UUFb2HLLVOS/Ltza51itmo5SOP0GzPzjHJjo7A2oc/I4qEdHLT77pOrld0M5
         c+5m9uCsxxjp3gU5rc59MUohSzcJfEl5gXwLJGLbweKOP104RWznWrlSRUjR2eDZF/lL
         c2CVpXoeqWt0g1VpaSbXTsTgjdrVt7YBejY40zxG0q89u9nuQFL3AdqVvgvzxaEjWLF4
         NKDxLlif9x6Oiq3ML2Qci+mTLTAlhDPMvi2LOqZuGoaWTMKOhLkeEnT6HmLmFeSCHAc9
         pHFTq9zarhx32YyxKdlU6SiMEKyxID8ZwhXR3qr3t3toKRGsuCH1L6UT0zL+TSc5AYaq
         vAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196880; x=1755801680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfDKLYTW6+lKsgYQaQXkVu1QFpYTDZJmYBFQGV4QYj4=;
        b=mv7KVl3wOOKvAKcwTA90w+NiCAc30y7kQ2W4IXWogMWh1Cv9MYSB8UafsvFs8Qr+df
         5JtQxr7sWXKAq4IJsafKi//NSGQ3AOQ96OjynfS6rfx76Cz+FinPQ9p8cojEz3K3ESAo
         zWAD7RFLFAaiI4pxOS7ueAW5Wv4Fn+xFQkOw7m1AsqP6ylKrz5H2EgcIyAwXAVlXBZBX
         idXW+S+mTkuWhqL2okI5eB1gKo/Y/EfSj66cJ7qpG5NLuPxtW8hr/UevFbKM9LqBF//c
         MvUYUXOmDZeNXlzMMFchUUI9fVak2q5/97V/BVYsODsUEr0aLL1avJDwSKAmNgeuvTaY
         g1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVP0ymUPo0YqRlGPzvPZhSAzPnWhhLbXsHHH57yGlIHgrGHOY0kuHXRJAGeaWdXOwuKSmdT831Cquwpg70=@vger.kernel.org, AJvYcCWP31QpnJ01B/fvt6coTirtdCg6idhYVtJtoQpkZVJzMm3zv9/5ejVKxQ/FZZuRQZMrIJ3JvFKEY67Y@vger.kernel.org, AJvYcCWrhDnZEMl7kYW0Kgmr4w6GqNJ620PtPP2px7UQE148MCeFMlYCGbAWN70uOj2YO73lCA5f1QQirzxqp3sKHunxWTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtZIzM6GM2Zp7LPRDGwe/YWtqoiyPVZIBEoiYskoynI/ZSR0P
	Hz1ovtBwyngdPtBx/0J+56wXCKpy6OOf3nqzB5/VeEJwgv82RiGXe2Yl
X-Gm-Gg: ASbGncuaeV+EvhKtgCEeQ0hJtIQcP5/niW1olGm/jS8mZHZg6FsGYas/ERx6lOjoGtn
	KphQMngzLKQhQQfHCnZpq8AM3bCQmQIxL989XLFEN9Dcaz1ScYcs08gwC3KDj1TR6u5zIeNjdyw
	1oCoZbVE/kGWXzJdnpL42B169KwXPXf6G2bhHnz8pKrKWSH0RDrRkugUGOYssdoz3PP+xozCu3r
	5/b4MXsUGm1QaaXMkCRdK0tcwNXtOfFD+8OVYHByL1vIKivfDxc88C291Co6IfeFO5czUN6MqI4
	brTJdmro49XncFuGL3TmuvK6ICDb6nZQxYiGoJ0h/Qsz3E0WC6rBnn7A6rW533VaORyP6K2Y0Gw
	IrRT0i3sh5mFQDwfUJaoM2xOVRN7zO7VSNUkAd3WRua3mBrLnClbcrgwzGbAtH8MxnRjOEJcrqA
	==
X-Google-Smtp-Source: AGHT+IHEOdU1SpMaE+AkPTtXGPzX0lXlAnZHPzwGwuNi9fI26uGArsLeQ8j/KNt5TW0Jb29PJ6wB/A==
X-Received: by 2002:a05:600c:4447:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-45a20c20a87mr555305e9.28.1755196880078;
        Thu, 14 Aug 2025 11:41:20 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm53744383f8f.40.2025.08.14.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:41:19 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 4/7] pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
Date: Thu, 14 Aug 2025 19:41:08 +0100
Message-ID: <20250814184115.192930-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G2L GPT the prescale factors are continuous power of 4 whereas on RZ/G3E
it is power of 2 but discontinuous. Add calculate_prescale() callback to
struct rzg2l_gpt_info for handling this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rzg2l-gpt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 74bb0cca4ab4..b247a6c181d5 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -90,6 +90,7 @@
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
 struct rzg2l_gpt_info {
+	u8 (*calculate_prescale)(u64 period);
 	u32 gtcr_tpcs_mask;
 	u8 prescale_pow_of_two_mult_factor;
 };
@@ -138,8 +139,7 @@ static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
 			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
 }
 
-static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
-				       u64 period_ticks)
+static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 {
 	u32 prescaled_period_ticks;
 	u8 prescale;
@@ -292,7 +292,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 			period_ticks = rzg2l_gpt->period_ticks[ch];
 	}
 
-	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	wfhw->prescale = info->calculate_prescale(period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
@@ -482,6 +482,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_gpt_info rzg2l_data = {
+	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs_mask = GENMASK(26, 24),
 	.prescale_pow_of_two_mult_factor = 2,
 };
-- 
2.43.0


