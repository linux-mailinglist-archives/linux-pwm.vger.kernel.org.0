Return-Path: <linux-pwm+bounces-4154-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DA9DBEEC
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 04:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBA281FC7
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CF37160;
	Fri, 29 Nov 2024 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaykm36p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4FD33C5;
	Fri, 29 Nov 2024 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732851879; cv=none; b=LaS7Ux+4FiMxWjOTWS165lGYMON1EyyDLoVYxchX6CjjoF8BNGzB80Fa5A3AbuYrc1Nno0sEvA71Zu+P51LIJaPkaqgru2+S9YE6DU5sMk2CbTz01Q58CIueghb65IuXJnWcnm7K6DUkCD4Cii/uDhC1Q8Tkj08wC7fC1vI98eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732851879; c=relaxed/simple;
	bh=p/BtqpG+IVaKvX4ukjImzgdAynVxORij5dB89nsDRos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TH2iQiX2GcSCc58VbZL/EQDLgX+PyR5zANMiQTeo1hM5PNw+4l37WlJqH+YCKklDHk17xsr6rWYrxCWgC+2g40n46KzSogd3zF8C8m3sJQ7v3AuqBXHPnQbTneDYqHQJXsQ0vruIbELnrbIy3Lh0D/N4/7Xmka0gb1q15ghvfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaykm36p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso1141883b3a.3;
        Thu, 28 Nov 2024 19:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732851877; x=1733456677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw5HuiFeElq/E/1SFYYivWjOveoig4PxqHy3M5+9mTg=;
        b=aaykm36p/+dGzg/p7k4VwxzoWLJWvYYWVFG4LDVgNjWsb7COef60dMLzm8LuqA09OY
         B/fPlqG3JNSjHEG1wppzdmfbOyaPAFXfrXCuyxEdmgDHCwHssiZ/PnqHP2JLD768ICkm
         H5J0Z3p91R7CyQDCS5VWVMVmYmds1GA9yG8iFovbG+p5gxPhmCL7+L2eBufZX3PV6aQa
         SxXrmHCj+hTlmFuT+t1bod62Zt6JDyTfDQ5SuwIATZtq7lVRfkg3gMEWCn/i4AHPt44t
         xZrevPEuiz6pC/HOicaceS1ADRInp7BAmzaF3Gl9XkfLUWcm9xr19ErOgEC91/xO6AEo
         AFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732851877; x=1733456677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw5HuiFeElq/E/1SFYYivWjOveoig4PxqHy3M5+9mTg=;
        b=W9kptFjiA9ts6ROvpqg1em/3uccpk6FyeL6NYcyW+5OB27UlgvzlJgs/dYs3E5wtnG
         Nwn6kbMlZ9pM7WwIOuUml57kQGDH71N5ET8GN5N6dXSw4Oc0UW5PgR73Bq2fSVzp9Iyz
         icois2UipZrHVaRGRH6t7a7xmszgrp5LZTpAFeqyyJ6lyM5Go/bLgzEeMrj6w+qudZwS
         oQTffuEya32ZuM+EqPmKX/AEX7//emRwinnS6sGSXkARuOOjwoFFWyBal8hf5npluelR
         Ygq8sVQ2bj5wEXcvrdvOQWwh5mlC231sRc/YqefHm0+yIXJlYvP8hh8k0n4Yvh/Za+MH
         wU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl93OkX6UO3cWJOdo8fEi7KX4D45GSi1H5nTyV2Tnwtwb63ag8MiY+jwX5dIL7r6G2jezm5TvZ8sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FfeZ/9PS4B70BaSSzHsuG47D6RFiN/KPBYPtbe1c8qYrHga5
	ZxJf3l0H635BGH14Y3B2x64U/usqEV27HdcSdmy4sZeRIOYVgFse4fLl8HW+
X-Gm-Gg: ASbGncu8MK+khO7oI5saXfuIwyvmn3kc/HKM26tp+DdHX49rNDP+I21P4io8CvuJFvX
	uiAKmJD3bhEXdhghOVTDtAmLeo30ifTEu+7absQsnwKlnlfmbsPC2RmJ8+BtdlfXHO5/KB2g+rA
	1oQDW8PX0e7MtbXarut/Dm4IUUHhRux99rlybPLjTc5JbnkCtgrO0WaQ0isZiUGNJO1WXcH8a47
	pUzR5xxVxyi24QMs7c1Rz2FOkw7ZcYGGoB4KcJcfiXtiJes/8ke5Tve/7rl/emeKctV2/o=
X-Google-Smtp-Source: AGHT+IGnEF07GDYyxw1iLOHTvzjFzaEmKJ3HpP28dlaG6gu7KLJJWTPS0pjZgVX4+JqsJjvhNDnWjA==
X-Received: by 2002:a17:903:189:b0:212:618a:4637 with SMTP id d9443c01a7336-215010903cdmr118763515ad.14.1732851876773;
        Thu, 28 Nov 2024 19:44:36 -0800 (PST)
Received: from localhost.localdomain ([177.10.10.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521966d45sm20719555ad.125.2024.11.28.19.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 19:44:36 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH] pwm: tiehrpwm: ensures that state.enabled is synchronized during .probe()
Date: Fri, 29 Nov 2024 00:43:34 -0300
Message-Id: <20241129034334.27203-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <eobcrbxmtyxv4x5dkgxf2sssgjefqbhit3tsnzizdel2aqzynq@opsqlav5zh32>
References: <eobcrbxmtyxv4x5dkgxf2sssgjefqbhit3tsnzizdel2aqzynq@opsqlav5zh32>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes potential desynchronization of state.enabled in the .probe() method by
suggesting proper handling of hardware state initialization. Adds
considerations for implementing .get_hw_state() to check the current state
of the module by checking physical registers.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---

Hi, Uwe!

Thanks again for the feedback!

I have taken your findings into consideration again and am working on 
getting my application up and running. Regarding the points you mentioned 
earlier about the driver, I made this small patch, using some hardware 
validation functions I had in my possession, to check for occasionality.

Best regards,
Rafael V. Volkmer

 drivers/pwm/pwm-tiehrpwm.c | 162 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..693704406f25 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -91,6 +91,15 @@
 #define AQCSFRC_CSFA_FRCHIGH	BIT(1)
 #define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
 
+#define AQCTLA_CAU_MASK   (BIT(5) | BIT(4)) 
+#define AQCTLA_CAU_SHIFT  4U
+
+#define AQCTLA_CAD_MASK   (BIT(7) | BIT(6)) 
+#define AQCTLA_CAD_SHIFT  6U
+
+#define AQ_SET    0x1
+#define AQ_CLEAR  0x2
+
 #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
 struct ehrpwm_context {
@@ -400,6 +409,134 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	pc->period_cycles[pwm->hwpwm] = 0;
 }
 
+static bool ehrpwm_is_enabled(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	bool ret;
+
+	u16 aqcsfrc_reg;
+	u8 csfa_bits;
+
+	u16 aqctla_reg;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	aqcsfrc_reg = readw(pc->mmio_base + AQCSFRC);
+	csfa_bits = (u8)(aqcsfrc_reg & AQCSFRC_CSFA_MASK);
+	
+	aqctla_reg = readw(pc->mmio_base + AQCTLA);
+
+	ret = (csfa_bits != 0u)	 ? false :
+		  (aqctla_reg == 0u) ? false : true;
+
+	return ret;
+}
+
+static u64 ehrpwm_read_period(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	u64 ret;
+
+	unsigned long tbclk_rate;
+	
+	u16 tbprd_reg;
+	u64 period_cycles;
+	u64 period_ns;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	tbprd_reg = readw(pc->mmio_base + TBPRD);
+	tbclk_rate = clk_get_rate(pc->tbclk);
+
+	period_cycles = tbprd_reg + 1u;
+	
+	/* period_ns = (period_cycles * 1e9) / tblck_rate */
+	period_ns = DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, tbclk_rate);
+	
+	ret = period_ns;
+
+	return ret;
+}
+
+static u64 ehrpwm_read_duty_cycle(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	u64 ret;
+	
+	u16 cmpa_reg;
+	u64 duty_cycles;
+	u64 duty_ns;
+
+	unsigned long tbclk_rate;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	cmpa_reg = readw(pc->mmio_base + CMPA);
+
+	tbclk_rate = clk_get_rate(pc->tbclk);
+
+	duty_cycles = cmpa_reg;
+
+	/* duty_ns = (duty_cycles * 1e9) / tblck_rate */
+	duty_ns = DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, tbclk_rate);
+
+	ret = duty_ns;
+
+	return ret;
+}
+
+static enum pwm_polarity ehrpwm_read_polarity(struct pwm_chip *chip)
+{
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	enum pwm_polarity ret;
+
+	u16 aqctla_reg;
+	u8 cau_action;
+	u8 cad_action;
+
+	if(chip == NULL) {
+		return -EINVAL;
+	}
+
+	aqctla_reg	= readw(pc->mmio_base + AQCTLA);
+
+	cau_action = (aqctla_reg & AQCTLA_CAU_MASK) >> AQCTLA_CAU_SHIFT;
+	cad_action = (aqctla_reg & AQCTLA_CAD_MASK) >> AQCTLA_CAD_SHIFT;
+
+	ret = (cau_action == AQ_SET && cad_action == AQ_CLEAR) ? PWM_POLARITY_NORMAL :
+		  (cau_action == AQ_CLEAR && cad_action == AQ_SET) ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	return ret;
+}
+
+static int ehrpwm_get_hw_state(struct pwm_chip *chip, struct pwm_device *pwm, 
+								struct pwm_state *state)
+{
+	int ret;
+
+	if(chip == NULL || pwm == NULL || state == NULL){
+		return -EINVAL;
+	}
+
+	state->enabled = ehrpwm_is_enabled(chip);
+
+	state->period = ehrpwm_read_period(chip);
+    state->duty_cycle = ehrpwm_read_duty_cycle(chip);
+    state->polarity = ehrpwm_read_polarity(chip);
+
+	return ret;
+}
+
 static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -450,6 +587,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct ehrpwm_pwm_chip *pc;
 	struct pwm_chip *chip;
+	bool tbclk_enabled;
 	struct clk *clk;
 	int ret;
 
@@ -501,10 +639,32 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
+	ehrpwm_get_hw_state(&pc->chip, &pc->chip.pwms[0], &state);
+
+	if(state.enabled == true) {
+		ret = clk_prepare_enable(pc->tbclk);
+		if (ret) {	
+			dev_err(&pdev->dev, "clk_prepare_enable() failed: %d\n", ret);
+			goto err_pwmchip_remove;
+		}
+		
+		tbclk_enabled = true;
+
+		ret = pm_runtime_get_sync(&pdev->dev);
+		if(ret < 0) {
+			dev_err(&pdev->dev, "pm_runtime_get_sync() failed: %d\n", ret);
+			clk_disable_unprepare(pc->tbclk);
+			goto err_pwmchip_remove;
+		}
+	}
+
 	return 0;
 
+err_pwmchip_remove:
+	pwmchip_remove(&pc->chip);
 err_clk_unprepare:
-	clk_unprepare(pc->tbclk);
+	if(tbclk_enabled)
+		clk_unprepare(pc->tbclk);
 
 	return ret;
 }
-- 
2.25.1


