Return-Path: <linux-pwm+bounces-1863-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE1189929E
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 02:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E071C21708
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Apr 2024 00:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDBE79CD;
	Fri,  5 Apr 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fa2NAhNg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E40A2A
	for <linux-pwm@vger.kernel.org>; Fri,  5 Apr 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712277034; cv=none; b=a5hHK3i52uc97Axi/U3NlY56rXBuXNqAWHLiYiSMTfvftxnv13s5G6P3Z3rZq0Zwavn07ORTT/4u0EZJjJiirunriIc8G2sa4I3QbAbOZvf2VIntv8tc1Vd9B6ERK7ywXhYHNmskgTXT3BonLBjv/yQKv5oFDfM3hvmFzZrN27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712277034; c=relaxed/simple;
	bh=xo/5zy7BKD5MQNwqWrK5Y7aZc4xuWO41L1gezsqpgM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Axr3aKjy8KQi3wdBBKOkviqxSiE/f1JYA0yX6BCG5JkmrpohQvtp+/TSzGjtcaIR6Gvheqelh2RPvH5OE/6MdeYJtN7bc42NsXHz1tIf/saNne0Hn0L65WYu//aHKsQRxtcEbKhCCKyF74Xa2GY3Brn5KHJA5bx3yL4OX93jHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fa2NAhNg; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e89c87a72eso1148986a34.0
        for <linux-pwm@vger.kernel.org>; Thu, 04 Apr 2024 17:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712277030; x=1712881830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mflIGl0JabM93wYA4asHh3PZJ7LJW93To1t++JIDmfs=;
        b=Fa2NAhNg6kkwFytftj+oDsjgnaUUd4/KoFeFjaBOunkuROV4mwqUgrHD3XNk7cUAHd
         BZgbN8ii6I/k5M3YWqybW1oX77rErtpeW1VsbleWWN063hiNPrgpgfosDn6kGqDriIbP
         IODvwdG6GxsTZ5sL47UVuljKcaz2tzBip3ALnBq1u2NC4SqdxK6FgVgXWWIsg6n08c7X
         gMU9HWa5f41fBFcBs3OHjHb5ogCXnri1CONgSLzvxDyW0XJnmAOmycRjrjGewBk0qu73
         N5AtaU57m9freAkvmr7eOBKnacx+n3NAIxOdiO863GzzGIqwRc3ALPeEp29zvluiF/PG
         e1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712277030; x=1712881830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mflIGl0JabM93wYA4asHh3PZJ7LJW93To1t++JIDmfs=;
        b=LyAjwsofXccjtQmnyiE69qyN/NTp+WDWd6JkNoUMtbHK643wKGc/D9ReblvbP8pb5z
         gMc2/UoGQkD+nCRtiqEnt3rmfdtbDi4eoQxNyERfg6M4q0rnZZIeI14znBD3oNp/Qd4Y
         8C9OITWHxOj1RqfiSyD6e6kzmBsmurR4sBCEwc0zQkudqH1aaQJ8Jr22sGZmSiXCIQjl
         R0rNjKnOF3abkaEmd9E0I5YN5iQyzz4pozmH8IxpXY1/G/nAyaDyJn1evmDrERCfWSoS
         31TfXYlKsuIkphEoVN3EPtjN2W4fcTq77OMcfrlERb+ZAy0BFaERidqKXeb2Nco1oJSP
         KE6w==
X-Gm-Message-State: AOJu0YwGMMfdlV/4xSXJYgXnrSi1pIQsDPvcRSNPN0ekkyQ7DojnKZLw
	ocFq/8AcMhWRetjiZK5ML5nt87V5yF58NyWzn5sb7CvX8Q99v6ZgmLs9/E7D5TAgJv0ZNylZTnn
	OV44=
X-Google-Smtp-Source: AGHT+IGeFIba7Fjoy+Lh5imxQMFJ60kylklXD567TEN4HDRnVJ4VBUmRGP0suOKAmd/UdpjTU1+F8w==
X-Received: by 2002:a9d:7a57:0:b0:6e9:df99:77c6 with SMTP id z23-20020a9d7a57000000b006e9df9977c6mr29202otm.27.1712277030414;
        Thu, 04 Apr 2024 17:30:30 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id o4-20020ac86d04000000b00432feda5986sm232728qtt.35.2024.04.04.17.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:30:29 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [RFC PATCH 2/3] pwm: axi-pwmgen: add duty offset support
Date: Thu,  4 Apr 2024 20:30:24 -0400
Message-ID: <20240405003025.739603-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405003025.739603-1-tgamblin@baylibre.com>
References: <20240405003025.739603-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable duty_offset feature now that it is supported in the pwm
subsystem. Related macros and struct fields related to duty_offset are
renamed to be consistent.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 539625c404ac..84ecb12e1e21 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -6,9 +6,9 @@
  * Copyright 2024 Baylibre SAS
  *
  * Limitations:
- * - The writes to registers for period and duty are shadowed until
- *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the end of the
- *   current period.
+ * - The writes to registers for period, duty, and duty_offset are
+ *   shadowed until LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at
+ *   the end of the current period.
  * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
  *   enabled channels, which could cause glitching on other channels. It
  *   is therefore expected that channels are assigned harmonic periods
@@ -34,7 +34,7 @@
 #define AXI_PWMGEN_REG_NPWM		0x14
 #define AXI_PWMGEN_CHX_PERIOD(v, ch)	((v)->period_base + (v)->ch_step * (ch))
 #define AXI_PWMGEN_CHX_DUTY(v, ch)	((v)->duty_base + (v)->ch_step * (ch))
-#define AXI_PWMGEN_CHX_OFFSET(v, ch)	((v)->offset_base + (v)->ch_step * (ch))
+#define AXI_PWMGEN_CHX_DUTY_OFFSET(v, ch)	((v)->duty_offset_base + (v)->ch_step * (ch))
 #define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
 #define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
 #define AXI_PWMGEN_RESET		BIT(0)
@@ -42,7 +42,7 @@
 struct axi_pwm_variant {
 	u8 period_base;
 	u8 duty_base;
-	u8 offset_base;
+	u8 duty_offset_base;
 	u8 major_version;
 	u8 ch_step;
 };
@@ -62,7 +62,7 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 static const struct axi_pwm_variant pwmgen_1_00_variant = {
 	.period_base = 0x40,
 	.duty_base = 0x44,
-	.offset_base = 0x48,
+	.duty_offset_base = 0x48,
 	.major_version = 1,
 	.ch_step = 12,
 };
@@ -70,7 +70,7 @@ static const struct axi_pwm_variant pwmgen_1_00_variant = {
 static const struct axi_pwm_variant pwmgen_2_00_variant = {
 	.period_base = 0x40,
 	.duty_base = 0x80,
-	.offset_base = 0xC0,
+	.duty_offset_base = 0xC0,
 	.major_version = 2,
 	.ch_step = 4,
 };
@@ -83,7 +83,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
 	const struct axi_pwm_variant *variant = ddata->variant;
-	u64 period_cnt, duty_cnt;
+	u64 period_cnt, duty_cnt, duty_offset_cnt;
 	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -108,6 +108,14 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), duty_cnt);
 		if (ret)
 			return ret;
+
+		duty_offset_cnt = mul_u64_u64_div_u64(state->duty_offset, ddata->clk_rate_hz, NSEC_PER_SEC);
+		if (duty_offset_cnt > UINT_MAX)
+			duty_offset_cnt = UINT_MAX;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY_OFFSET(variant, ch), duty_offset_cnt);
+		if (ret)
+			return ret;
 	} else {
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(variant, ch), 0);
 		if (ret)
@@ -116,6 +124,10 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(variant, ch), 0);
 		if (ret)
 			return ret;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY_OFFSET(variant, ch), 0);
+		if (ret)
+			return ret;
 	}
 
 	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
@@ -145,6 +157,12 @@ static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
 
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY_OFFSET(variant, ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->duty_offset = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
@@ -254,6 +272,7 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
 
 	chip->ops = &axi_pwmgen_pwm_ops;
 	chip->atomic = true;
+	chip->supports_offset = true;
 
 	return devm_pwmchip_add(dev, chip);
 }
-- 
2.44.0


