Return-Path: <linux-pwm+bounces-7138-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC0B30DAE
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1097C1CC79BC
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02DF2566E2;
	Fri, 22 Aug 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmK+a0dW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48284322A;
	Fri, 22 Aug 2025 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838137; cv=none; b=o62Oeo88LnnyVrLtRYBG1xfNcuwbm885n3wQKcGwSY3+m+4AuLFx+80jLE/pFb1XFr6ZtyvaU23hs1JWB2qtRkOy3Ic1pSNFsTpkaVJjgg63OCSnDmxZCijxMfLxudZxhbNLSbPaP+0ascR9ddf1mlCdh1W9s9s33xwMwnUwE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838137; c=relaxed/simple;
	bh=3xSnzVR9ye7nvzGlEH6U7XGu6tORQwGuV7EfKcVnbpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY5efffh7AzsU5FhBHtvBosMnm1JYeAMXfStbKEpCNLhsWTEl2R2Vooe9LK/plNt8O2p+G23PnOpNA2iN5c3zMepScKDUT9/e97IKtF9PHCoKGpypsBIswYSa9p2X/Z3l8wz3HE3632K6xcgRsszV8FwgwFe2GH8+6bTZpNM9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmK+a0dW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso996129a12.2;
        Thu, 21 Aug 2025 21:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755838135; x=1756442935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKlE+Ww5Y80VoOt4lttVv8oB7FM3MLtESOSrWfKC/2M=;
        b=NmK+a0dW6fAI4crIoiHfab3mvUIoZ9v4fRmEu5mouoQ4MXUkIowAUAz1uG7W0s8r7r
         a5X84PWcu5zzA7widzdDG20h1h3PXmjbkMetsch/pq0TU7YYkKPlTIrKkc803xlCtUCt
         sCZeRbNvoSQPS00ug5HvNhKlIB5OQBq3O6ugnGaFLdU5sCFCGtpVFtPjM1yBysQvq8Sf
         wexFY1fXEpWX2A5Mqx6TgjfbNwMj1XicLWsLXbaAxO9PtKjN3k/kL+5e55wCW6Tbkcq2
         z8uTrhi3RcFZSjcjJ4sYVNLu/jma+A90h5y77f4rbZ7cFtSZtcEH9dvXf66vnNpNSiNq
         PARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755838135; x=1756442935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKlE+Ww5Y80VoOt4lttVv8oB7FM3MLtESOSrWfKC/2M=;
        b=i8WAcQsEvt5LCW3gcSLBIixPrciYpR0l10MPth1aIQiTIsOX4ehLWN2Mnag3fBHz0n
         cBoTJv37Dhmb3/X2bIquj6TrMQ3xLktl82q2h5YBdBu4hEjtglnylVnaiX5gUA0ya+Jy
         yBOU2mqf6vbKK/k5od2H4g7N4LIXE2s6juFRsFYauyTFCOAz/yyX84UR4makE3dDOQUR
         cZcmo+4KyqyzOQvhZ19YEae4Em+PlvzKzk93uytDs7HhDGMLC1tKlDukM6Y9Wt6Y1+ep
         uk7h2eFiPb3Zb94mso2I0+TlzXJ7vVqu5oCJTMjQngDC05zPLAul7a1xJ7IM5S4MEqmc
         9Cxg==
X-Forwarded-Encrypted: i=1; AJvYcCVVDtuk5x/mQgfOC6jRB1OZ0VCuG5BquK8cAK6xWhNhYtgnQoNHpFrTrhrk+TIAvYn4wi+wMeuET3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YztR3gl1LVq4vKRFHugXz8J5oP7W9P3PRDO1PW03Yh6abiQRm03
	1jat02iFM7GvwDvPfSwHzYm7CZADTePoN26JWjRRQL06iPHuwRQ6Y+Q3
X-Gm-Gg: ASbGncu4+Gysx9HUwJdRskiDNydd0YsO+mHFHdbvq0P7syuSiVgNGQKYwINXFUiB265
	C3YiqORcTrwpfMQj/OmOrzVpsyWn3xwKd7moyOEDX9XZD7gB8tm4grH6KOyUxn7sC4B0+Jo4RZY
	ypp9qD+b/OPhacL3wwBCuOpaLM9FvFFrMQIgLLjnGBUGgeOHrwYLHO4Y/iK0XlUnLSCzzHK3lEI
	WnLwBC4i4GdxC/ghRSmQJTw3TBXuup7m9XudRQN0lo/Ip/XVdBGLSpl81UBhQM8DtYPUybbwcTQ
	cfrajswfZnqwxnb47zqeeD6jFVbzRbL01i+HO5iG3GDC435JIf/eiWsfvTPgsRdHdjT0aLp7evO
	JH8mExQ3QOc0oS/ESDUiiEIIhMFSdWdc5gSjHa34wt6owpOTNYteyDMKk7w==
X-Google-Smtp-Source: AGHT+IEEZhC4QdMCMK498g/wBcJCUWrWdRaXv1ijZ/cmiZT5LYe3jZ3y1FvLcu/GT401zJUiGzH7LQ==
X-Received: by 2002:a17:903:2105:b0:240:8fa2:15d2 with SMTP id d9443c01a7336-2462ef440eemr15305685ad.33.1755838135525;
        Thu, 21 Aug 2025 21:48:55 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f0d86c05sm64305745ad.93.2025.08.21.21.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:48:55 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v5 4/6] pwm: tiehrpwm: implement .get_state
Date: Fri, 22 Aug 2025 01:48:06 -0300
Message-ID: <20250822044806.4103-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822044545.4080-1-rafael.v.volkmer@gmail.com>
References: <20250822044545.4080-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ehrpwm_get_state() to report enable, period, duty cycle and
polarity. Read AQCSFRC and AQCTL(A/B) to determine whether a channel is
software-forced (treated as disabled) and expose current timing and
polarity through the pwm_state.

This lets consumers query the current hardware state reliably.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 103 +++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index b2a55e59b..1dae3b8b5 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -461,9 +461,112 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	if (pwm->hwpwm == 0) {
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
+	if (pwm->hwpwm == 0)
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
+	if (pwm->hwpwm == 0) {
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
+	 *  - If an up-count event sets the output (AQCTL_FRCHIGH) and a down-count
+	 *    event clears it (AQ_CLEAR), then polarity is NORMAL.
+	 *  - If an up-count event clears the output (AQ_CLEAR) and a down-count
+	 *    event sets it (AQCTL_FRCLOW), then polarity is INVERSED.
+	 */
+	if (up_action == AQCTL_FRCHIGH && down_action == AQCTL_FRCLOW) {
+		state->polarity = PWM_POLARITY_NORMAL;
+	} else if (up_action == AQCTL_FRCLOW && down_action == AQCTL_FRCHIGH) {
+		state->polarity = PWM_POLARITY_INVERSED;
+	} else {
+		state->polarity = PWM_POLARITY_NORMAL;
+		dev_dbg(&chip->dev, "ehrpwm: unknown polarity bits (0x%x/0x%x), defaulting to NORMAL\n",
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


