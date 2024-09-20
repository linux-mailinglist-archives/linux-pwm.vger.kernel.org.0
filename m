Return-Path: <linux-pwm+bounces-3303-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0297D337
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 11:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0767DB23057
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327613F431;
	Fri, 20 Sep 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="khdmY0S7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238913D8A0
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822727; cv=none; b=aD1htu8+De0OaTRVWIkB74raFWRrqnWOK4AbLni86ij6qhSk3YqPYeaKKsP+NR9d95s7Dm731wr4crcJsaUc7+fgiPoqCHi9SPJ9QcGRaWaVUZYDTA8r6HKwR8nvqrFhxfOq5OpCard2hs935sCroHK1p/Ki1LniWPJB+xf+PFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822727; c=relaxed/simple;
	bh=1/DA38z2zOtfDAFsLQX9oXa4qWfa5hvXANUBX3INnUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3D8ka7z9IbtSmfbD1o/ppEVmPmTnzjbwJkl1s2EP8TUTAoIGoobZvoIfTsBwpFIZKfx7nC9Ev2HRV1U9bbU5Zs4gbs6qvLGd02FzcMrBZoq4DaTuiMJI1uwynS5vyBte15AMOTq6Lia+tZ1UU50z/WS7U7uTG0Ebtw8ggWkzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=khdmY0S7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-378f90ad32dso1130164f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726822724; x=1727427524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjzpGJfeYP6/WICKAznlj6Ny1mBWP1SdGFczevOlxF0=;
        b=khdmY0S70Pk4vutIF9tBe5XbjPDTCLoGBrPEVEz9duWBoFCOoJvi2f7F78HAUoB+dA
         YA7+Zp6tHG2VyZKyXcs84T7726s7VXWZqPKoJ8C7sBaUD1EiHZxaDTiNNpN/W6D/DsRK
         TL3cJwQ/hTYKzWwUVgyaa9wtEosnY10vPWewz/qNYEaVYxcWs25Dh5EdE1xp5ZKV+Q9/
         iH2nJSypy20Eg6OTFaaOGD/Nv1tScrHmdYhpbt6YJq7QlUEk1+r23DgainrAqb/vJFdy
         pmpVr3fh01nF8RsgDb7m5vSCS5rG8SVF56K62BAFUXZY3AMgg0qSj3txhqyqd5rD94wv
         jvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822724; x=1727427524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjzpGJfeYP6/WICKAznlj6Ny1mBWP1SdGFczevOlxF0=;
        b=vbUm0ZssVLu/6mRt8IVoRG8LHkYWlexjsH37Awn1g/PjGORllcYgl2Q4n4E5OSAJWE
         CgVYjKttEwlqWSR/JEakSAh1UNhO2ken92vm5rd9+CbxznhGuw2r0cBFj81yg3ahBYsB
         EGxI28vDxrAZmpmF+4XEz1F9GAXTtLApsloL1It97oU3CDn1POunusi+qcB1LJ6qw2ri
         Qh8wG51w3AoBtMP3OZa2aClF8Ko8+0YnFhxKZ0nAUVVUaWPu/ltSdgMlAjtC+wg7g1UE
         i1Zmu8NonJF/tb66A9wrgOoJ1cBKFJxxrvVJcyKZjtjmZd92Vkry1yzD8Fu0DHQZDtVp
         GQsw==
X-Gm-Message-State: AOJu0YxHchhYwXmKfmEfDPKYZ6JRwewKlh3Gy5SZnCeoslb6GjRAGwOk
	qp3eJ0bcPMcXbijFjVKt46xSl2hrEFZ9AG/mnmjSfOcjg69VfIaqbJdzyOma3mtQEGqeYbhpkea
	2
X-Google-Smtp-Source: AGHT+IFphtrmciVhRNb2HJe43wocMk7jMecQsgVjHVneJfuTC7xcdHZlWnlga6rDnjSNt08qE5i3Gg==
X-Received: by 2002:a5d:4e09:0:b0:376:efb7:d19a with SMTP id ffacd0b85a97d-37a4319e028mr1024322f8f.44.1726822724371;
        Fri, 20 Sep 2024 01:58:44 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e837csm17194559f8f.27.2024.09.20.01.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v5 5/8] pwm: axi-pwmgen: Implementation of the waveform callbacks
Date: Fri, 20 Sep 2024 10:58:01 +0200
Message-ID:  <922277f07b1d1fb9c9cd915b1ec3fdeec888a916.1726819463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6869; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=1/DA38z2zOtfDAFsLQX9oXa4qWfa5hvXANUBX3INnUY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7TkiVec0k33lY1TMkBmgv5NG/IuD1NRad4r4/ Lh2Pr3h8jmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu05IgAKCRCPgPtYfRL+ TkmWB/9l5lU29co6EgsiJEKaM4xRCDsXuG7LJD4gQUhZ1AqCFDjhKdW3g3RQS2c/ctP0ERpqCTo ZZ8+pb+dN1fS1nel2oUFA18SuUM0eXxPTKVBA8QgmwfJI4Bkgt7eNnOOhIFy9ohUnXmiIIK5jyy LKhbWs7eNUw8s0GqaW0Abu8ShtNAz4SHPO62tabholOmTtHK+kP/2i3zNUhqwt9ozURcrd2Fh/I 1m4AXKy+vJtGsclpS+amIjT8xFWt1X9oJBwM2+Pgg87V7cQb1b05uAfRgNF5k1H52LieyALJFXu 7ADjnPV6SEKxtDZriiR64aji5X32nx7R0h2+c/g7Hm9jpXc+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert the axi-pwmgen driver to use the new callbacks for hardware
programming.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 154 ++++++++++++++++++++++++-----------
 1 file changed, 108 insertions(+), 46 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index b5477659ba18..39d184417c7c 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/io.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -53,81 +54,142 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.max_register = 0xFC,
 };
 
-static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
+/* This represents a hardware configuration for one channel */
+struct axi_pwmgen_waveform {
+	u32 period_cnt;
+	u32 duty_cycle_cnt;
+	u32 duty_offset_cnt;
+};
+
+static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
+					  struct pwm_device *pwm,
+					  const struct pwm_waveform *wf,
+					  void *_wfhw)
 {
+	struct axi_pwmgen_waveform *wfhw = _wfhw;
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	if (wf->period_length_ns == 0) {
+		*wfhw = (struct axi_pwmgen_waveform){
+			.period_cnt = 0,
+			.duty_cycle_cnt = 0,
+			.duty_offset_cnt = 0,
+		};
+	} else {
+		/* With ddata->clk_rate_hz < NSEC_PER_SEC this won't overflow. */
+		wfhw->period_cnt = min_t(u64,
+					 mul_u64_u32_div(wf->period_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+					 U32_MAX);
+
+		if (wfhw->period_cnt == 0) {
+			/*
+			 * The specified period is too short for the hardware.
+			 * Let's round .duty_cycle down to 0 to get a (somewhat)
+			 * valid result.
+			 */
+			wfhw->period_cnt = 1;
+			wfhw->duty_cycle_cnt = 0;
+			wfhw->duty_offset_cnt = 0;
+		} else {
+			wfhw->duty_cycle_cnt = min_t(u64,
+						     mul_u64_u32_div(wf->duty_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+						     U32_MAX);
+			wfhw->duty_offset_cnt = min_t(u64,
+						      mul_u64_u32_div(wf->duty_offset_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+						      U32_MAX);
+		}
+	}
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> PERIOD: %08x, DUTY: %08x, OFFSET: %08x\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+		ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
+
+	return 0;
+}
+
+static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					     const void *_wfhw, struct pwm_waveform *wf)
+{
+	const struct axi_pwmgen_waveform *wfhw = _wfhw;
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	wf->period_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->period_cnt * NSEC_PER_SEC,
+					ddata->clk_rate_hz);
+
+	wf->duty_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_cycle_cnt * NSEC_PER_SEC,
+					    ddata->clk_rate_hz);
+
+	wf->duty_offset_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_offset_cnt * NSEC_PER_SEC,
+					     ddata->clk_rate_hz);
+
+	return 0;
+}
+
+static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     const void *_wfhw)
+{
+	const struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
-	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
-	u64 period_cnt, duty_cnt;
+	unsigned int ch = pwm->hwpwm;
 	int ret;
 
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), wfhw->period_cnt);
+	if (ret)
+		return ret;
 
-	if (state->enabled) {
-		period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
-		if (period_cnt > UINT_MAX)
-			period_cnt = UINT_MAX;
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), wfhw->duty_cycle_cnt);
+	if (ret)
+		return ret;
 
-		if (period_cnt == 0)
-			return -EINVAL;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
-		if (ret)
-			return ret;
-
-		duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
-		if (duty_cnt > UINT_MAX)
-			duty_cnt = UINT_MAX;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
-		if (ret)
-			return ret;
-	} else {
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
-		if (ret)
-			return ret;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
-		if (ret)
-			return ret;
-	}
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(ch), wfhw->duty_offset_cnt);
+	if (ret)
+		return ret;
 
 	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
 }
 
-static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-				struct pwm_state *state)
+static int axi_pwmgen_read_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    void *_wfhw)
 {
+	struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
 	struct regmap *regmap = ddata->regmap;
 	unsigned int ch = pwm->hwpwm;
-	u32 cnt;
 	int ret;
 
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &wfhw->period_cnt);
 	if (ret)
 		return ret;
 
-	state->enabled = cnt != 0;
-
-	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
-
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &wfhw->duty_cycle_cnt);
 	if (ret)
 		return ret;
 
-	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_OFFSET(ch), &wfhw->duty_offset_cnt);
+	if (ret)
+		return ret;
 
-	state->polarity = PWM_POLARITY_NORMAL;
+	if (wfhw->duty_cycle_cnt > wfhw->period_cnt)
+		wfhw->duty_cycle_cnt = wfhw->period_cnt;
+
+	/* XXX: is this the actual behaviour of the hardware? */
+	if (wfhw->duty_offset_cnt >= wfhw->period_cnt) {
+		wfhw->duty_cycle_cnt = 0;
+		wfhw->duty_offset_cnt = 0;
+	}
 
 	return 0;
 }
 
 static const struct pwm_ops axi_pwmgen_pwm_ops = {
-	.apply = axi_pwmgen_apply,
-	.get_state = axi_pwmgen_get_state,
+	.sizeof_wfhw = sizeof(struct axi_pwmgen_waveform),
+	.round_waveform_tohw = axi_pwmgen_round_waveform_tohw,
+	.round_waveform_fromhw = axi_pwmgen_round_waveform_fromhw,
+	.read_waveform = axi_pwmgen_read_waveform,
+	.write_waveform = axi_pwmgen_write_waveform,
 };
 
 static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
-- 
2.45.2


