Return-Path: <linux-pwm+bounces-5868-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02190AB0F5C
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995949C239E
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5964028CF76;
	Fri,  9 May 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gnk6RZ/K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64728CF73
	for <linux-pwm@vger.kernel.org>; Fri,  9 May 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783703; cv=none; b=c3Lz0/K+SUiGAE3jJwIfgK+ljvJ4JYQm1g+gzWA19M2WAksQBzl4bW3gtwoiUZiLEJdBwObe1tsGelGseo3KAU2Qwbxzy4AjMHnJBTVnxLqisplfQG/ukKvJC/lRkz1ouvDcrOh/Ynl/+m1+wcCkwspnLJMBSbbSx1xORcTOny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783703; c=relaxed/simple;
	bh=AhRbnxt00FmE/WhEN1u8zVz8q5gXEKLj1JYmMYck0AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCH9CDY54LY3M6G8YJ+U8JiFNCl2ZHLgJ9GNvOHUEmCBP+JYbGGGC+KMNbHJOK2gZEnNze20ItiEypuoZrB27b4O0fHg9IK3Qg7LPFHGyxpDqiJfsSmXXCWHM1ZevAOMnjo0NJv2XOkFuvClP1B5bvGfyDSkHCXO2iNhqekh8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gnk6RZ/K; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b061a06f127so1237757a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 09 May 2025 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746783701; x=1747388501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTYlTOXj1U7VnsAmcUnx1eYdk5rL5ZGZ7LNT8Q6B11E=;
        b=gnk6RZ/KgoV7HPxvwotAKtrfohVED2CYX0BLPhyouCfXpb8ssaUAlQDC+EBsk1tMx9
         lpC1PLO9KsV3ivvqwjECKDhEeX4b3O9eSzpQCc/9gVwaWHzsaFZjBNWA+bKXPGzOhSnP
         2W5A1MJHmb5FfY0isBTbwsyljaZXyC0Rrq1E+P9PmvpZBgr4VCzicsD96EY6w6aiTcxt
         1Izos8yH5u5ubAdLtskPdkfuVduY88PTVihQc8XtRJlFLAyKDcus65p2JR3qVizNH+fH
         eAfUgY7ysmu6xuNNwqlLdJAYiYNhxeA1rl1q7pKydqwdTU9HYtdHBs7xh2CRSbTZDi2Z
         uflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783701; x=1747388501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTYlTOXj1U7VnsAmcUnx1eYdk5rL5ZGZ7LNT8Q6B11E=;
        b=UqfXvU1z+kSYrPOD0w0wKJTNIPJMdxiriyrnEoeHKuRaV0whyO6+0ueohZVMLiRkeX
         czSzahP5tE1+aOxZaSOE1j2DdjJrHxymvipMLCK2DUmyjRWmI52CfTYE8kyfWMYN5nY1
         GDWq1a/kaEBQkJi2hIDt22uDC/TL06HoF1TtW/7GdT3MDsTjxbq4pvw0xg+h2XYdQx3T
         WAAB2/RXJNiOedu8SDWPFZpebHjfLIXIM08BMMGdfZfVj+NdTqxeEXaEiZrQT59h37DM
         19WlbSVJOFzKAJbpuHeCA4N5bArH6jMMTV+Nnns+eIxjuRoyuODW7MFVJTnsgIhKrq3s
         Zo4w==
X-Forwarded-Encrypted: i=1; AJvYcCWk23whWRWhZX2USmSJnjkWI4KIyLiZH5x7h1BmWPFGdR0UTUl9/EgwvCQTV0eA1UDWYeuuQr0vJBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JNb0RqO80oG54VBg7KvtaWJwkp/w3cj16N+jB6ttMg4S6NdA
	rHDz5JiLkGDdid5C1DHV6HLlFoewZKAZ4eUnaqjdkZeJ9N9nX3Nr6Cu/Z3nOgaKXdrwOJpZrkxu
	hBQYMlA==
X-Gm-Gg: ASbGncsqWVVY4dQBYGk30umFRt340HDQQYi/Ew26QX/gM5c+2ZXsTV6qTTayZe7DFks
	4o/iqnzDK/ECKlflp8uP9Rw28jG6z6zC+Z787+LUI0u1J0ovts6O1wN7wbAjxohuf4H9XZnWEG6
	A5UKs6dpZoHsfJtL1XjKyvdZojT7dDyh0hKRleJTdsT/uCUFHw2mJyYgOxSB79sJ74GlbWtVVFt
	9Xx44rfHnrf0lIudSJM0xjXPKtkSGbFwtvAcOe7wMSdVGSlZTFGAgcKvH4w37QRLsJswaO1TwwN
	/v6NyjhG8E7wXTIAnrL33lrdIqiQHnTggBrxMgvqXTKKbm+4y0NfNaNOpL20ghTa1KwJUQZ7Jko
	uew==
X-Google-Smtp-Source: AGHT+IH6CJp7geNRf/gfDN17FTLMQyKVaZTxIXnNcwyUwIxRi1b6xhJMl5CuSsuy0q5Q7sBCMcAAog==
X-Received: by 2002:a17:902:f644:b0:224:a74:28d2 with SMTP id d9443c01a7336-22fc8b76ab5mr41666335ad.26.1746783701043;
        Fri, 09 May 2025 02:41:41 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c38sm13271035ad.119.2025.05.09.02.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:41:40 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v14 2/5] pwm: sifive: change the PWM algorithm
Date: Fri,  9 May 2025 17:52:31 +0800
Message-Id: <20250509095234.643890-3-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509095234.643890-1-nylon.chen@sifive.com>
References: <20250509095234.643890-1-nylon.chen@sifive.com>
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


