Return-Path: <linux-pwm+bounces-7783-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0A9CAD931
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A14433060182
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958342F5A36;
	Mon,  8 Dec 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBadctRM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3C2DECBD
	for <linux-pwm@vger.kernel.org>; Mon,  8 Dec 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207305; cv=none; b=WbYqiYM7ezIeB+6hE7zwvWYccTTI6gkcQabWlALgAn2XGqcC+WaBG0KAbLIZWIXuLRMjKB5uQULAc1VjQysu7g4HyGFGEN74zc/jaay94E6CPaTW3Q12QBFkn++Evz1DZFtJXvs5Rk1E0ToxGaulYGjdSUHgygIVDreOeEQ/xpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207305; c=relaxed/simple;
	bh=yXm/4YmON4ItbMvKkw1/c75Q/GHmL5fbLtW/K6gDKN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JP07QPcJ+HMVNovpeT38/XPq1uozQHhsIZZM5nuActdgJSj4swtArvle/r+pPJducR0NaYOpdY6OpmiyRxwyB7dEQL/gU4C8S7/M2oEP2B5RHBP2Tr4m3tdtGd+ywoSX4+6EX60+Z3iePJfVagBXZFD0/eo4F7I1RYZcGtJMXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBadctRM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so6541137a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Dec 2025 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765207300; x=1765812100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUOaOBzmat1IrbxWeXGOKr8YdTjnocfw3KD45UqcxkA=;
        b=FBadctRM14nBQGcblkvIPtIWHpdGYXRmAR8WhHzRJP81Ev3CFcFfmBc37sQW4Zo+hr
         MrIGL3vdtiFX/6bPeW4LuZayerU36JuzAEh5sdcTX8hsm53wFUwLeREXTvo4bMaexKBc
         NGjoP2JJL0/0dL82k48DtUOYPZfi7abQOacMJO4qf/7YA8vg7yE7p7IaQ4kHZBaVDO8y
         0SOr8NXmU5Qjp6uG3QS6ZpXNS2HZ3zL/oEREDUhVrXIF9hNqps/t9OHMWJY/CAMmJkru
         6zpLvAXkrIQx6FWQ7M9DqJMkvEjHpclvq/L1iJjADmE+3KiqYRD1IFvAA1U0/zV7nWPT
         UwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207300; x=1765812100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUOaOBzmat1IrbxWeXGOKr8YdTjnocfw3KD45UqcxkA=;
        b=f9onQpW9t0/dF8ENKzPeIuwAgKOtf14a+Qj+NJn4AntSHRRnOB/+dq/WwyEtpNLo2R
         990h8ao8gn7EkT1TTy9WGJqjuP1VdSJkyePZFXY9UGa83vymAdKf6MK0uY08tQjIF1Pd
         M/vXemkcPrXkKquQtKJ4eC8y8l3Mvz4LLqBOkPBMOt8Od3SOkzKPtUaK1bTdrRGNWrJK
         tZE+uF5BB3fEfQgzNbZ6aOoOYJUAYibAdYfBVtKDyyRhQDd6hxUe3XgLogUURaCUd2FG
         jpkn2SxG+pOFY8GZOh5Ou5nVNqWvIDbsl9jxuFBMR5k97zB3j/6g8I1Xzh601fWiTQUx
         uu2A==
X-Forwarded-Encrypted: i=1; AJvYcCVrykZwLK61ZDd7YTLhCGZ21K0OzkJED+vYymvuLxowiMYgGW7Nq1cIOqYhvFXcCn8tmyn1Zsr0n3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3D3OuY6BE+/iabvu2O2vVwWHf/qyqAgN+xh93Ecb4DpAO7dW
	HIMkA/nBw6MK7hsKbgE96AGKjuZptqmBuIwKjO1Z6ZbW1Z2K9JlbtqPt
X-Gm-Gg: ASbGncsv+9TANgfy7UZ2C16TvQwKVLDF8KrEPlGOyGMV7M44MmJKTNTzr7+A59FBedD
	3U2v8770E83V+YdjZV4ErYDigphECNV1Fjmuzfw34joqdxJf/g30roV7aB1HYZNALMpbilS7LHz
	mH8eJZvWigmMstP+IdJ6dpps+6ub6IHwRoED2TvIKyWTcKEtdYmetj40dSTkztnYkNE0Y8s7Luw
	i+NYaVJgqM6BRn7wnt4x+cREobXX7nYhMRB9jur9zS9QTfWCMPZs78+a5fMFlmrOwaDQaafr26T
	EEEhRb07lhbXMdHfxlEYkM54SuMjmIKADILdu+8ZnRk6/HQTgOfyDpFUjp0N968SQ6O1KAOLJLb
	gBJvzfsWZlM1p9i/ElvDM4x3jaOZGPkuXxtRT65FtPgiL9CXOsz79mmEl6URpA+RJQX++OAQ8Jw
	2KPS8eDv/vmIcIeSLHxWF4AuIUb2nvXoK+kenidL3mPesRqDKuoxNJhZ/Jz8ST5it51QfPvs25m
	2Msm+tpKjYgwUXD
X-Google-Smtp-Source: AGHT+IHEk7KHXPUAwS4Qo1SgQkiwq/e6w1gAGwCl62JsI2TcE4euezbVC0dRrZ8dqKv0mZlj5bm1CQ==
X-Received: by 2002:a05:6402:2809:b0:641:1d64:8dce with SMTP id 4fb4d7f45d1cf-6491a43297dmr7011492a12.17.1765207300101;
        Mon, 08 Dec 2025 07:21:40 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412deddsm11547484a12.31.2025.12.08.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:21:39 -0800 (PST)
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
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v4 6/9] pwm: rzg2l-gpt: Add RZ/G3E support
Date: Mon,  8 Dec 2025 15:21:23 +0000
Message-ID: <20251208152133.269316-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
References: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Added RZG3E_GTCR_TPCS bit definition for RZ/G3E and added to
   rzg3e_data.
v2->v3:
 * No change.
v1->v2:
 * Added link to hardware manual
 * Updated limitation section
 * Collected tag 
---
 drivers/pwm/pwm-rzg2l-gpt.c | 47 +++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 791900f6de3d..79ee59271d24 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -6,15 +6,21 @@
  *
  * Hardware manual for this IP can be found here
  * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ * https://www.renesas.com/en/document/mah/rzg3e-group-users-manual-hardware
  *
  * Limitations:
  * - Counter must be stopped before modifying Mode and Prescaler.
  * - When PWM is disabled, the output is driven to inactive.
  * - While the hardware supports both polarities, the driver (for now)
  *   only handles normal polarity.
- * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
- *   each HW channel have 2 IOs.
+ * - For RZ/G2L, the General PWM Timer (GPT) has 8 HW channels for PWM
+     operations and each HW channel have 2 IOs (GTIOCn{A, B}).
  * - Each IO is modelled as an independent PWM channel.
+ * - For RZ/G3E, the General PWM Timer (GPT) has 16 HW channels for PWM
+     operations (GPT0: 8 channels, GPT1: 8 Channels) and each HW channel
+     have 4 IOs (GTIOCn{A,AN,B,BN}). The 2 extra IOs GTIOCnAN and GTIOCnBN
+     in RZ/G3E are anti-phase signals of GTIOCnA and GTIOCnB. The
+     anti-phase signals of RZ/G3E are not modelled as PWM channel.
  * - When both channels are used, disabling the channel on one stops the
  *   other.
  * - When both channels are used, the period of both IOs in the HW channel
@@ -47,6 +53,7 @@
 #define RZG2L_GTCR_CST		BIT(0)
 #define RZG2L_GTCR_MD		GENMASK(18, 16)
 #define RZG2L_GTCR_TPCS		GENMASK(26, 24)
+#define RZG3E_GTCR_TPCS		GENMASK(26, 23)
 
 #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
 
@@ -146,6 +153,27 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 	return prescale;
 }
 
+static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks >= 64 && prescaled_period_ticks < 256) {
+		prescale = 6;
+	} else if (prescaled_period_ticks >= 256 && prescaled_period_ticks < 1024) {
+		prescale = 8;
+	} else if (prescaled_period_ticks >= 1024) {
+		prescale = 10;
+	} else {
+		prescale = fls(prescaled_period_ticks);
+		if (prescale > 1)
+			prescale -= 1;
+	}
+
+	return prescale;
+}
+
 static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
@@ -455,6 +483,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
+
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
@@ -493,6 +529,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg3e_data = {
+	.calculate_prescale = rzg3e_gpt_calculate_prescale,
+	.gtcr_tpcs = RZG3E_GTCR_TPCS,
+	.prescale_mult = 1,
+};
+
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs = RZG2L_GTCR_TPCS,
@@ -500,6 +542,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
-- 
2.43.0


