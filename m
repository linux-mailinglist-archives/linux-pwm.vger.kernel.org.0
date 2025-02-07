Return-Path: <linux-pwm+bounces-4827-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF5A2CFBF
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 22:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2BB7A53C3
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 21:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312891C5F19;
	Fri,  7 Feb 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5vhQUKw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1C188CB1;
	Fri,  7 Feb 2025 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963991; cv=none; b=d9fD+MG4pbEzPbpQDlYtdAM97WNUq5pIG7KsS38xZHpF7CHYIRV6v44iMZPENHdkn4s4AHDbhIGoN5qgD4nuuD1AHTLkz6PMEOcsjZxe0ubdWkgagIhqvqL5GMivuyMmGX9sL0Dn0hF0bhV+Xtb5euLLOSda+lKti+1z92mOYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963991; c=relaxed/simple;
	bh=ND4gohn0BeJfrycarSWYVj0/KeAgqHA/l71R9DjQDx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDcBN8obGC/Kt+CTunS06y8g5ZoR+bGmnC9ydnnCOnK9wrRMANeWugMYBsi8b5nbHBEWBKNPXU8kXVvxkIewW4Y9jH8fQDc01LgY3U9Yl6Lg60mIBzjyFI2bkDiaDzB1EpG8ipi2CyCbJN6lEe8t1D0DmOr6w2FG8YSODA7EzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5vhQUKw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so2808539a91.3;
        Fri, 07 Feb 2025 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738963989; x=1739568789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ry9v1qNyrkiZWi5g4Y4EFTVbke1Qw5rssJvnWpacj0=;
        b=d5vhQUKwXLjS0cyT1J4hRUomK7DRno/SH90n9mCmqiPsxgpAm7/TrJi48PZfWbC6Pb
         Y8aq5LkuOky2yRpK8DdJ2irJd7Xj2mCmnHe5Iq/CQuoP6boyDRTJwMPwxIN243AZJrPs
         p6nTqvmJV1AdM4GcxaGnpLIdcNA4l3kdtO2Nojdlh4ZYuAN8+kyfk7yznHKgweB+GD3u
         yse9vtUzYP7KD/Z3Ziju1Nj//VFD+gNqAZ5vQRO6cbdnnSY11IUz//oUbMh+j+vCKeVa
         i5Dkk8O9ZERc2m9a1cB57xX9qIOkj3GwTf0WvStNSCxe7wSt/lZhlBYfbrxXQtTIvvfG
         UEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738963989; x=1739568789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ry9v1qNyrkiZWi5g4Y4EFTVbke1Qw5rssJvnWpacj0=;
        b=XB9DHnjf4ATGHR/jF8h5QXIw80RXK2LpSvKJK1gCVGP3R/0h20KFKmUIn+U8yz2bCR
         6iWctqniB0BShPh6SSb/LpkfYvdeoniM2RgW/GVkdQgSGml8k6zleN+OS6iWCzJ39RpT
         acWijnpcAHs+Ukp+2OdSd4rJ/pPZh0D1NaKxTnwuceUHDddnhwUciAtFNfnov6N4OG8t
         QecYzXpbI4vhjg+RB9MoLvDeUPn9fo6osxIDB2FKJ+xnONwQ1o8QbsiQsOPJWYEQlHGf
         SqFJZSF55hIscDkmbgdMRBJFBgi1zWo3J65FYGvPasD8VoEu4F/AbADTSTGcBxxljmDa
         OK4g==
X-Forwarded-Encrypted: i=1; AJvYcCV9VoMP+iMCJuI+UyasqjQwUX2GMlIEd34okBneQea9Z4ltbHmLzD9/2eAvHyKndgtp5Wly0ug/koE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SF0vN8K84AnCbYlGXa4By6tfnsjgU8bA2Dy6M9pTK6q5QrnF
	voL4mdWYwk7o567scssyfN4xgc5GFRayw7Ve7IUnkCHwi+cBITd1fG8gMcTv
X-Gm-Gg: ASbGncsD94zVaqyYIJu2QcfAcIGr1rWTQp3GyebTDtO14B2Bc7PkQHeoBDnM1TuuyAi
	hqBwqZ5uKakgAddHJjB1ClHfBwG0HIJpm0oxNOpmUpD5eKoChpoSlEadEi8SxRpP4dfP86J2MAI
	Wrjm33B2dT7x1anfmcPQpzMHXA6P/+1KwdCBwfgIPzlaiyBnf+7iw7VH8dCzxByNCnplLru8mpT
	JsgZ4u/fCOMUbOTUOi3yEqLhZxR2MBf5FR77lkva3df/pR0z1tn5TEDY6IaOyaE6SPCXzgCeavQ
	xxjxEu0swMWTKRskZuG9+Yhx/cuGrH40/Tcx
X-Google-Smtp-Source: AGHT+IGTNfzddwk/SjNvOXY3iufZsTFutjBvHM8bE9Mo7cAqnNvRQ8HkCkiz4+wsGEFihDzCriDYHA==
X-Received: by 2002:a17:90b:54cb:b0:2ee:b66d:6576 with SMTP id 98e67ed59e1d1-2fa2450d252mr6889572a91.30.1738963988582;
        Fri, 07 Feb 2025 13:33:08 -0800 (PST)
Received: from localhost.localdomain ([181.192.80.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a2743asm3906114a91.18.2025.02.07.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:33:08 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v3 2/3] pwm: ehrpwm: add get_state function to retrieve PWM channel state
Date: Fri,  7 Feb 2025 18:32:34 -0300
Message-Id: <20250207213234.1026-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207212954.934-1-rafael.v.volkmer@gmail.com>
References: <20250207212954.934-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ehrpwm driver was missing a get_state function, which is required
to properly retrieve the current state of the PWM channel. This commit
adds the ehrpwm_get_state() function, allowing users to query the
enabled state, period, duty cycle, and polarity of the PWM output.

The function reads the relevant registers (AQCSFRC, AQCTLx, TBPRD, CMPA)
to determine:
- Whether the PWM is enabled or disabled
- The configured period and duty cycle
- The polarity based on action-qualifier configurations

Additionally, this commit updates the pwm_ops structure to include
.get_state, ensuring proper integration with the PWM subsystem.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 122 +++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 50516f46ab04..52527136c507 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -81,7 +81,9 @@
 #define AQCTL_ZRO_MASK			GENMASK(1, 0)
 #define AQCTL_PRD_MASK			GENMASK(3, 2)
 #define AQCTL_CAU_MASK			GENMASK(5, 4)
+#define AQCTL_CAD_MASK			GENMASK(7, 6)
 #define AQCTL_CBU_MASK			GENMASK(9, 8)
+#define AQCTL_CBD_MASK			GENMASK(11, 10)
 
 /*
  * FORCE LOW	=> 0b01
@@ -495,9 +497,129 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return err;
 }
 
+/**
+ * ehrpwm_get_state - Retrieves the current state of the eHRPWM channel
+ * @chip:	pointer to the PWM chip structure
+ * @pwm:	pointer to the PWM device structure
+ * @state:	pointer to the pwm_state structure to be filled
+ *
+ * @return:	0 on success or a negative error code on failure
+ */
+static int ehrpwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+							struct pwm_state *state)
+{
+	int ret = 0u;
+
+	struct ehrpwm_pwm_chip *pc = NULL;
+
+	unsigned long long tbclk_rate = 0u;
+
+	/* Registers */
+	u16 aqcsfrc_reg = 0u;
+	u16 aqctl_reg = 0u;
+	u16 tbprd_reg = 0u;
+	u16 cmpa_reg = 0u;
+
+	/* Bits */
+	u8 csf_bits = 0u;
+
+	/* Values */
+	u64 period_cycles = 0u;
+	u64 duty_cycles = 0u;
+
+	/* Actions */
+	u8 up_action = 0u;
+	u8 down_action = 0u;
+
+	if (chip == NULL || pwm == NULL || state == NULL)
+		return -EINVAL;
+
+	pc = to_ehrpwm_pwm_chip(chip);
+	if (pc == NULL || pwm == NULL || state == NULL)
+		return -EINVAL;
+
+	tbclk_rate = clk_get_rate(pc->tbclk);
+	if (tbclk_rate <= 0)
+		return -EINVAL;
+
+	/*< Get if EHRPWM is enable by checking registers values >*/
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
+
+	else if (aqctl_reg)
+		state->enabled = true;
+
+	/*< Get EHRPWM Period by checking registers values >*/
+	tbprd_reg = readw(pc->mmio_base + TBPRD);
+	period_cycles = (u64)(tbprd_reg + 1u);
+
+	/*
+	 * period (in ns) = (period_cycles * 1e9) / tbclk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	state->period = DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, tbclk_rate);
+
+	/*< Get EHRPWM Duty Cycle by checking registers values >*/
+	cmpa_reg = readw(pc->mmio_base + CMPA);
+	duty_cycles = cmpa_reg;
+
+	/*
+	 * duty_cycle (in ns) = (duty_cycles * 1e9) / tbclk_rate
+	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
+	 */
+	state->duty_cycle  = DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, tbclk_rate);
+
+	/*< Get EHRPWM polarity by checking registers values >*/
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
+	if (up_action == AQCTL_FRCHIGH && down_action == AQCTL_FRCLOW)
+		state->polarity = PWM_POLARITY_NORMAL;
+
+	else if (up_action == AQCTL_FRCLOW && down_action == AQCTL_FRCHIGH)
+		state->polarity = PWM_POLARITY_INVERSED;
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


