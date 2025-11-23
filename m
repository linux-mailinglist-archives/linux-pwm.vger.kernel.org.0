Return-Path: <linux-pwm+bounces-7682-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D25C7E9AF
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 00:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B6844E0448
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 23:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48022A1CF;
	Sun, 23 Nov 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMtvQ0QK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6B36D4F4
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940719; cv=none; b=nmOiV9dlC+wOAB0d7uXIij/S9qrNmTTnyMfBH9HxABii2p9FoVjmx7pXlETFZ07goAompTzw3TMErHfVy4YkRrsyyo+hX0qPlQZ62RbSVHpuv0IsHnGA9GGE57lqTDyAWaQ9nkmxPLQcTaUu/x39jIZftm8jzc+atOPTo2otoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940719; c=relaxed/simple;
	bh=MsGC0rVImn4yoVuI3PikUf+62aeQRPT1ZxaetcjJlmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esxHNUkqRgXz8kVUOQQF07JR1wW7P+4d1EVt0/ef0tyCqRKXP4ky7m3jWFJi2RrJhqMqCjf4H1Bm9n4bMfkRSYh5wznY1bgjQbVq2uf/R0ORHvPGyyk4H8/W7iQez8mhH+pouCWLP/bQe49unTb4v5qeRA/CtMuqHxN88HKAhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMtvQ0QK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298039e00c2so51586525ad.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940717; x=1764545517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNVGtxxCdtKTz9MbEED20di05LbkTLbFYH9Jhd0dyMQ=;
        b=kMtvQ0QKTG1d6U06smRGjf0WX7LLMspwzZJs2M0PB6fxkES39GVUTL7b1iwgnvTpAS
         BD3q1J2UBd33+kRHTvEWoOjQ7KJ1GAi7aFUO9o0DnV12tjrezUaR5fvkY4enKPaoFr5D
         OTCHaaxTDD/KhpIu/yF27vMmSxG2yJh2Kp/C/1kdEGJhJ9OvkSBwVlMAHeSyH/zE9N7f
         ub+m+snDWfnP+HjO1sRT1Q279I99EMx654jOJKjdR9VXLRmmaW1+XPToSNf+Y5M/eGKz
         afl4UoLYLe1TPnxv3K/8peNikrGavtTt9yFVQPsC9Liirq9nEqTxrM/54DXlLpnw26ga
         uTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940717; x=1764545517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNVGtxxCdtKTz9MbEED20di05LbkTLbFYH9Jhd0dyMQ=;
        b=ahVfsz/dn9xkJc6xfV2xYS8wVoUnaNvT5P9i9XWah+HQ3rO6jgUIYvtmWmfuK5nacd
         S/VGTvSCZ7vPkasroArT8BB2zbUDwBSKJ7L2+di9POMY7sVKiLrdOCeZXuvPtld/66si
         jVRTTo/xbILcJvuHxTaEWR2CXteHo+lzaz6hWo7y0zubLH24IeKBXzjeuqkbZwjnB9IL
         8j3ffNzEelbl6oAdxpgVdfoPEPWLQ9rXX5IE3HuUL0pFV4TSAzszGVE8S5VTLO4fwJwo
         vEEjxv/qDMomKfe7RvaM1YckTincDY1+v48xrObvyIDmpMNYxT3E0RZykfEOGIQASwMf
         rBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwwll0ICLCfxKy2CeNUsbfQSbir3cJCc8sNVR64NrBaDq2xto+MkZy7dePj8XVo4ldlUuoZdXg+z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhmpDZYuUdm+u3CNLspZQuGRWf7S2y48eDhwszBfy8dknLtoi
	zDH0k9fgXtUB9kiQe3WLFxshmJ/oWQzo1r3fql7ks2DzQC9tRq8sZQA4F6V3/Q==
X-Gm-Gg: ASbGnctxyplnLQdFQo8lBv7HOimh77c3UG/WxkGLSLnyzs6cTq5aM9J+CsrwKL24iEx
	DXYTRuV40TJUwraCUk29JgrZBNdtOCH+tgC2jjd9XS9HfRAtFiqffQS6hpUQa/pVeYI8r0QCE4K
	MbTmcRjfB/5uvHmOGmiyM0w5CBeijUv19x3nhfQlAmLLfNeZ+eEbbpT5bPSdM+jWXVetC6zyb0A
	XmLIrqr4bb397nD/DzsJE/zBF5+RhG1Fy8xBS7AezwpT1BsbDrJkMmxhj+drC/c56xUfiInWcNQ
	JVX9OxejOitWmPk0l2TmW1X2QrN8AJjR2ekhqbMplczC1TLcA7wrhUPi8BOmSUpwdonXobhHF0i
	f+ZXEnm6JB1I/Ka8ejIDzdl+7zM9pRyjdJaPjHfrdR+kbVw3Rv9rWV9a3DSwzETz5CPXOy2UTB8
	lFNCJBo6twmBDwNeL7YVa/yjQpvxTutCPYdCqY0WJzRJM=
X-Google-Smtp-Source: AGHT+IGnHZ4GxX1f8fU5VzPAvYtVO8m0P2vlT/Jgji/t4FJEHRKUDxosOSuAc+y34TnsIf7UJhqDIw==
X-Received: by 2002:a05:701b:2719:b0:11b:b2f5:a1f4 with SMTP id a92af1059eb24-11c9d863125mr5679738c88.39.1763940717223;
        Sun, 23 Nov 2025 15:31:57 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm65793593c88.7.2025.11.23.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:31:56 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
Date: Sun, 23 Nov 2025 20:31:51 -0300
Message-ID: <20251123233151.2103-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251123232947.2085-1-rafael.v.volkmer@gmail.com>
References: <20251123232947.2085-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ehrpwm_get_state() so that consumers can query the current
hardware configuration via pwm_get_state().

The callback reconstructs period and duty_cycle in nanoseconds from
TBPRD, CMPA/B and the TBCTL prescaler fields. It also inspects AQCSFRC
to treat software-forced outputs as disabled, and decodes the CAx/CDx
action-qualifier bits in AQCTL(A/B) to report the current polarity.

To make polarity decoding reliable, the configuration path now programs
both up- and down-count compare actions (CAx/CDx) consistently for each
polarity.

This lets consumers query the effective hardware state instead of just
the last requested settings.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 132 +++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 9f1be35912d3..cc525626b2f9 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -114,6 +114,9 @@
 
 #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
+#define PWM_CHA			0
+#define PWM_CHB			1
+
 struct ehrpwm_context {
 	u16 tbctl;
 	u16 tbprd;
@@ -267,37 +270,37 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRESCALE_MASK, tb_divval);
 
-	if (pwm->hwpwm == 1) {
+	if (pwm->hwpwm == PWM_CHB) {
 		/* Channel 1 configured with compare B register */
 		cmp_reg = CMPB;
 
 		aqctl_reg = AQCTLB;
-		aqctl_mask = AQCTL_CBU_MASK;
+		aqctl_mask = AQCTL_CBU_MASK | AQCTL_CBD_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHB_UP_POLINVERSE;
+			aqctl_val = AQCTL_CHB_UP_POLINVERSE | AQCTL_CHB_DN_POLINVERSE;
 		else
-			aqctl_val = AQCTL_CHB_UP_POLNORMAL;
+			aqctl_val = AQCTL_CHB_UP_POLNORMAL | AQCTL_CHB_DN_POLNORMAL;
 
-		/* if duty_cycle is big, don't toggle on CBU */
+		/* if duty_cycle is big, don't toggle on compare events */
 		if (duty_cycles > period_cycles)
-			aqctl_val &= ~AQCTL_CBU_MASK;
+			aqctl_val &= ~(AQCTL_CBU_MASK | AQCTL_CBD_MASK);
 
 	} else {
 		/* Channel 0 configured with compare A register */
 		cmp_reg = CMPA;
 
 		aqctl_reg = AQCTLA;
-		aqctl_mask = AQCTL_CAU_MASK;
+		aqctl_mask = AQCTL_CAU_MASK | AQCTL_CAD_MASK;
 
 		if (polarity == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHA_UP_POLINVERSE;
+			aqctl_val = AQCTL_CHA_UP_POLINVERSE | AQCTL_CHA_DN_POLINVERSE;
 		else
-			aqctl_val = AQCTL_CHA_UP_POLNORMAL;
+			aqctl_val = AQCTL_CHA_UP_POLNORMAL | AQCTL_CHA_DN_POLNORMAL;
 
-		/* if duty_cycle is big, don't toggle on CAU */
+		/* if duty_cycle is big, don't toggle on compare events */
 		if (duty_cycles > period_cycles)
-			aqctl_val &= ~AQCTL_CAU_MASK;
+			aqctl_val &= ~(AQCTL_CAU_MASK | AQCTL_CAD_MASK);
 	}
 
 	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
@@ -426,9 +429,116 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return err;
 }
 
+static int ehrpwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
+{
+	int ret = 0;
+
+	struct ehrpwm_pwm_chip *pc = NULL;
+
+	/* Registers */
+	u16 aqcsfrc_reg, aqctl_reg, tbprd_reg, tbctl_reg;
+
+	/* Bits */
+	u8 csf_bits, clkdiv_bits, hspclkdiv_bits;
+
+	/* Values */
+	u64 period_ticks, duty_ticks, ps_div;
+
+	/* Actions */
+	u8 up_action, down_action;
+
+	pc = to_ehrpwm_pwm_chip(chip);
+
+	/*
+	 * The 'hwpwm' field identifies which hardware output channel (e.g.,
+	 * 0 for channel A and 1 for channel B) of the eHRPWM module is in use.
+	 */
+	if (pwm->hwpwm == PWM_CHA) {
+		aqcsfrc_reg = readw(pc->mmio_base + AQCSFRC);
+		csf_bits = FIELD_GET(AQCSFRC_CSFA_MASK, aqcsfrc_reg);
+		aqctl_reg = readw(pc->mmio_base + AQCTLA);
+	} else {
+		aqcsfrc_reg = readw(pc->mmio_base + AQCSFRC);
+		csf_bits = FIELD_GET(AQCSFRC_CSFB_MASK, aqcsfrc_reg);
+		aqctl_reg = readw(pc->mmio_base + AQCTLB);
+	}
+
+	if (csf_bits || !aqctl_reg) {
+		state->enabled = false;
+		return 0;
+	}
+
+	state->enabled = true;
+
+	tbprd_reg = readw(pc->mmio_base + TBPRD);
+	period_ticks = (u64)tbprd_reg + 1u;
+
+	tbctl_reg = readw(pc->mmio_base + TBCTL);
+	hspclkdiv_bits = FIELD_GET(TBCTL_HSPCLKDIV_MASK, tbctl_reg);
+	clkdiv_bits = FIELD_GET(TBCTL_CLKDIV_MASK, tbctl_reg);
+
+	ps_div = (1 << clkdiv_bits) * (hspclkdiv_bits ? (hspclkdiv_bits * 2) : 1);
+
+	/*
+	 * period (in ns) = (period_ticks * preescaler * 1e9) / clk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	state->period = DIV_ROUND_UP_ULL(period_ticks * ps_div * NSEC_PER_SEC, pc->clk_rate);
+
+	if (pwm->hwpwm == PWM_CHA)
+		duty_ticks = readw(pc->mmio_base + CMPA);
+	else
+		duty_ticks = readw(pc->mmio_base + CMPB);
+
+	/*
+	 * duty_cycle (in ns) = (duty_ticks * preescaler * 1e9) / clk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	state->duty_cycle = DIV_ROUND_UP_ULL(duty_ticks * ps_div * NSEC_PER_SEC, pc->clk_rate);
+
+	/*
+	 * The 'hwpwm' field identifies which hardware output channel (e.g.,
+	 * 0 for channel A and 1 for channel B) of the eHRPWM module is in use.
+	 */
+	if (pwm->hwpwm == PWM_CHA) {
+		aqctl_reg = readw(pc->mmio_base + AQCTLA);
+		up_action = FIELD_GET(AQCTL_CAU_MASK, aqctl_reg);
+		down_action = FIELD_GET(AQCTL_CAD_MASK, aqctl_reg);
+	} else {
+		aqctl_reg = readw(pc->mmio_base + AQCTLB);
+		up_action = FIELD_GET(AQCTL_CBU_MASK, aqctl_reg);
+		down_action = FIELD_GET(AQCTL_CBD_MASK, aqctl_reg);
+	}
+
+	/*
+	 * Evaluate the actions to determine the PWM polarity:
+	 *  - In this driver, NORMAL polarity is programmed as:
+	 *      ZRO = FRCHIGH and CAx/CDx = FRCLOW.
+	 *  - INVERSED polarity is programmed as:
+	 *      ZRO = FRCLOW and CAx/CDx = FRCHIGH.
+	 *
+	 * So if both up/down compare actions are FRCLOW we treat it as
+	 * NORMAL, and if both are FRCHIGH we treat it as INVERSED.
+	 */
+	if (up_action == AQCTL_FRCLOW && down_action == AQCTL_FRCLOW) {
+		state->polarity = PWM_POLARITY_NORMAL;
+	} else if (up_action == AQCTL_FRCHIGH && down_action == AQCTL_FRCHIGH) {
+		state->polarity = PWM_POLARITY_INVERSED;
+	} else {
+		state->polarity = PWM_POLARITY_NORMAL;
+		dev_dbg(pwmchip_parent(chip),
+			"ehrpwm: unknown polarity bits (0x%x/0x%x), defaulting to NORMAL\n",
+			up_action, down_action);
+	}
+
+	return ret;
+}
+
 static const struct pwm_ops ehrpwm_pwm_ops = {
 	.free = ehrpwm_pwm_free,
 	.apply = ehrpwm_pwm_apply,
+	.get_state = ehrpwm_get_state,
 };
 
 static const struct of_device_id ehrpwm_of_match[] = {
-- 
2.43.0


