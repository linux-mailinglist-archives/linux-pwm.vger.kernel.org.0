Return-Path: <linux-pwm+bounces-5584-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B8A94558
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD94177BA5
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3691E2853;
	Sat, 19 Apr 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOKAAtqI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972A14AD2D;
	Sat, 19 Apr 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745092583; cv=none; b=Sxo15jcu/vjv13tq+zNr7MCk2IMmEtJSK1YGy25i6KJ49oZbe1sxX/EWEZ1RVgqxj67FXeusbLsieizazHo3TM9tHtjgy5oPwABoIX81MlK9KFI2fu9Q49nz7KQ2IjHKQsJ9lfzJ6JHX5voErmuwS+3Rkc5IY9i+IiZ2U2BkoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745092583; c=relaxed/simple;
	bh=kfta5NdNHvpIdljpRdiQyjKJ31+i4wb42+idAWlspI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLW6F4Kwq3kpgKl97ikLltUC9xgLwR5D2AZKeD+hY05C1YJxxWZ1koCTSax1cPWZiyw+eP03yfrF9SS4fdyAvDCwngO+C/CTyV4wrmD/7DJgk9EP+GVNTmEaP42f2dm/XZsei6y1tIzTJYJty8PxNjSLCdsiMeJPW1MXUDFLh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOKAAtqI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7394945d37eso2308904b3a.3;
        Sat, 19 Apr 2025 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745092581; x=1745697381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpp2hc2xxpyE2JKFWxWeIGAapuaD+HUpX/Ty/I3rv5s=;
        b=HOKAAtqIvrgh2OisCqolrExL6I1W+g1WOfe1K72oI66bJ+9HWpQxKF/TcRBaofXhIW
         5+NSHkNtCcnF69SBDH8K2Nm4T63SOWEmcYc4KqBcj/7Wt3NuxwmYQzx6snpg8s6z3Qo5
         9j8M8rG52G1mkYMZJtIqMEQSSl0uRsyfwyZtlUnr42ySQ32DGLhc5dC6GK3enl6xO+wR
         Cj+oK6FiP5VQVKPPuo2jggO+m5Q43TZ/OT8grRzCmB3idunURVRXuDYLUdWVk0wbZS++
         9OmpTMhFjm3xJ2MftTjUTp1XblzzQ0CfeQq/cBl4UTdxQwagqPswW+fUO9CmS5zjO6RG
         9A1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745092581; x=1745697381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpp2hc2xxpyE2JKFWxWeIGAapuaD+HUpX/Ty/I3rv5s=;
        b=uwNLOHiCTK8zI7zx5rzUwweilIPBexoFWTw/3AAbc5VYwO1V4aLBwiT7m+TkFGheNL
         hVStkF4apMnTbFW2HXXSLX3gFL52V3bIZeAnT9GBWAOu/K6xsh/4fq9jOwm1KtfkzWyU
         /YSUUwAK0D4zBxa+LgA0s+sO936u6cvveL9aIIP7tn3TVE7ke/GsmrVGK01S6AAF/nyL
         PWR3ECJyB71zv995u0WSeLdd9Z/zQ5q33YmYzwLVDDitl1MQlnv5E9OHqBAhYcgFR1mr
         imz83e63kyh73yNETTQtMC2CZN/2YEmoTWl09wGE46aCYpn9KXX6gdErrZSqJpujx2IQ
         EHdw==
X-Forwarded-Encrypted: i=1; AJvYcCXx8LqHDpPxqKmxN6Rz9M/XV2IkxDJos0seOvLGwizM5gIQUGBDu701Kk6tRUF7KgXKcWja6jsSzvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ejHXeAHpTVS757M7H6RXhEcxhgrT3+o8/vXV7XYmDD/sbj9y
	EjofJXDApRbCaRn6d98Tao/zacmCA4xdZy/fleb490jPijTOCBnrMAYKkHjvvVI=
X-Gm-Gg: ASbGnctU55nXkzByPJz4f6E3YSQBdMsa0Mcb9T5oeqLbrnKViglvV5RgEe5K6X9G8pP
	FrwtIhArxKfthZ23WK8iN46k7FkfIrmVh+fLmz9rIU1TpNXnHIEqbVfKSccgK/tw4RQ0sXMeFhg
	+5KQUNsfzRK2/ZHTzN3ILXItzNmBlIk/I02qM0zCFEN5UIxz5t4MXf1jFlcZaqBOXPqLz8uemYe
	MQBN7cHSE7Uof802EiBX/gTr2xar1LYMkf9EfT8LhohfsVapUY5H//u7vgffCAYlNbt59638FDR
	dq00x5qZDnchsSL+yJvjzORkSliPAUeANjZ/EFOaTjfGVgTjsXtzp0drnj7y
X-Google-Smtp-Source: AGHT+IH1sNpTR8jvEGELSby9unMMsvRIgdvPMIj05h2Aj6IqYk6CuZCN4ALeFd2oHz9clQln0WzLaA==
X-Received: by 2002:a05:6a00:4644:b0:736:57cb:f2b6 with SMTP id d2e1a72fcca58-73dc14c6df1mr8556991b3a.12.1745092580893;
        Sat, 19 Apr 2025 12:56:20 -0700 (PDT)
Received: from localhost.localdomain ([177.10.12.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaac865sm3777258b3a.147.2025.04.19.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 12:56:20 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v4 2/4] pwm: tiehrpwm: add get_state function to retrieve PWM channel state
Date: Sat, 19 Apr 2025 16:55:55 -0300
Message-Id: <20250419195555.78933-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250419194835.77860-1-rafael.v.volkmer@gmail.com>
References: <20250419194835.77860-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ehrpwm driver was missing a get_state function, which is required
to properly retrieve the current state of the PWM channel. Add the
ehrpwm_get_state() function, allowing users to query the enabled state,
period, duty cycle, and polarity of the PWM output.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 1ead1aa91a1a..cde331a73696 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -68,7 +68,9 @@
 #define AQCTL_ZRO_MASK	GENMASK(1, 0)
 #define AQCTL_PRD_MASK	GENMASK(3, 2)
 #define AQCTL_CAU_MASK	GENMASK(5, 4)
+#define AQCTL_CAD_MASK	GENMASK(7, 6)
 #define AQCTL_CBU_MASK	GENMASK(9, 8)
+#define AQCTL_CBD_MASK	GENMASK(11, 10)
 
 /* common action codes (2‑bit) */
 #define AQCTL_FRCLOW	1
@@ -470,9 +472,104 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	u16 aqcsfrc_reg, aqctl_reg, tbprd_reg, cmpa_reg;
+
+	/* Bits */
+	u8 csf_bits;
+
+	/* Values */
+	u64 period_cycles, duty_cycles;
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
+	if (csf_bits)
+		state->enabled = false;
+	else if (aqctl_reg)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	tbprd_reg = readw(pc->mmio_base + TBPRD);
+	period_cycles = (u64)tbprd_reg + 1u;
+
+	/*
+	 * period (in ns) = (period_cycles * 1e9) / clk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	state->period = DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, pc->clk_rate);
+
+	cmpa_reg = readw(pc->mmio_base + CMPA);
+	duty_cycles = cmpa_reg;
+
+	/*
+	 * duty_cycle (in ns) = (duty_cycles * 1e9) / clk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	state->duty_cycle = DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, pc->clk_rate);
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
2.25.1


