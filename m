Return-Path: <linux-pwm+bounces-5566-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353BBA93000
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 04:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327A446819D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 02:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95756267B9B;
	Fri, 18 Apr 2025 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTwNAO7N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC54268686;
	Fri, 18 Apr 2025 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943441; cv=none; b=GzhBYGXfiIQ0Xg6hjhD35kxaCaoMjZ4qz7cccKcTj96aSajNeWFLyIH+VHSgxUyKedt5YmCMtNLdHUk6P7bYexhjVP86D0oNROSX0L4I4av1Fra449Qufem4vzhIs58OUCgHMlGc2p/gKIsjgmY8tbuE+938NV9cJ/78tms5atg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943441; c=relaxed/simple;
	bh=F5wTWiuzfh8Tt2PQ9yfbi0SFEuZODRRM9Iglxqr2MVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrtG6yJYUcwUuhTRUZ8MFhb4cQoF+4cj3D3krMzNRQc9g/NQUqXLchcvL8ZQW3GCzmVLFtL3EIJCBzNGG7ESV70GWBvHOmP0tvkAsp+uG8ZqbVizc5WO/INdQ1TFwLE/7HhrHk87RQPJBtrZyyqovMpK2pljBsXgLxU3mg98JFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTwNAO7N; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22c33e5013aso18502815ad.0;
        Thu, 17 Apr 2025 19:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744943438; x=1745548238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhyHi9uQpRULTwQZULLja3qU3XsixSmtudhV3coPhWg=;
        b=HTwNAO7NaTjT9Do17YoR4JmtGIHtX0pPMtq9kLQMjkxOuWcuMfE/2uEQztHOhrF2nz
         +hifLZnwLWO0atnTdxFSGBZCTTWA06wTCMVxr9gWCIj0DV1DXlDzkkoL0G2yvub2JeNL
         ExcUiVWUr0rQTDeHU+Py/rIEyb43u5fQ+Qc8zCnwaY61BOTVZwHibug4HX089Dhku5nR
         hW7TlKDnr4x5a6cB/22OGTozQUjTA9E5T2jrrK9ChD8G3dFGevCFtF2KNv1TmRWQlufH
         15aoqRuBKj3/254twwk5bOEQMnbAv05a/FuuxLuX+W6NYUA5L0TekizCAf/qh//q8I3y
         Zn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943438; x=1745548238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhyHi9uQpRULTwQZULLja3qU3XsixSmtudhV3coPhWg=;
        b=p2P7U/Imy9XV7y1ngHfBLqmS9CaQ6OwtHzVA7HVRkD6LiROs9AmIIMgEmsHv4T4+Q8
         aDlGTg1zLDmnjQv2KSU8cFH6bAdILn/R+AlcQrG3tfB7hjsVRvtMFOjhD6GlqQ90vQeo
         njcm91dUCJQBWfglEltfcc7v1x7Jj+W6yfx5MglffV9tc+/KZQsKHRkoI24mia1El7nd
         FKQjbndIKwUErw+vwQVD41SlqR8TfyDpgTcPFIc3TUUj/cHrDehJkP1wUsdDFrJlkwfr
         s3vzvnmMXdaIXTDpLH9LkazioLazE6flDryBX4ifrnNviplI23vuR9ZPiqRIG0yqMyx4
         2rjw==
X-Forwarded-Encrypted: i=1; AJvYcCUhBYh++Ha4tWi5cBT/QBJSnuWy49GU0bx0FwAyN0/ihvrZg1J3H8vFPYhTPeLeDYWJUHWDWZfzP/hC@vger.kernel.org, AJvYcCVi3ZrA3v3X4cbCLN/Bc7/t1osNIWWILIcHg0UQ6T65NynN+frXKCjNfUdYys8pf1n5VWi2r1e3BCet@vger.kernel.org, AJvYcCXAaToS86btlKTDYuin7r+trZGOROdUuBwEEUTGsIqLdjDq2JrrhBiXc+pF7ockSee6iNvM80sCtFdOIBeT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqm2tq9cDlSjlbhmq7Fx0ZqmpgZrd8LCbYzfkzufXPNbaDYCu+
	BIQQKyN9jNjoeX2HBlAyYeNfHhF/mlxIgAg+GEijTYyZaaplOH33
X-Gm-Gg: ASbGnctxN7KeY7tEx3AQPPZpAfL83/k8PcLQr/QuPLazXnwaARizAAtMCjLHH2Slnqe
	3uddyAcp/nylMYlI2mYERa/FXer1A0cdAPsauFBxkwSeMsdjVwqpIhmR1WTu0XKI4t+U4kHa12a
	UMTI+oPN0ClnH9ohXKE7M9sYKAIbUks3EriptXJLakBXWgV0qVF5Zifk2SazsFVEsWVG8hsF9XQ
	Z3E7159s35HiGGZopR647lN2Dalci9Qsi6BMrynEu4BNY/cri0SQA1bu2Af8qIzK9XUIipcUNaK
	+vTWYzYGlpX2spDfbhnK5GfgcVQXvL7S2fY=
X-Google-Smtp-Source: AGHT+IHo/o4KQhGB66PuErDoqro0sabaeHOL40TB7KoY2oAF3V05eK3U8JRd5gLiVCzL4LU7JUlRpw==
X-Received: by 2002:a17:903:41c7:b0:215:b1a3:4701 with SMTP id d9443c01a7336-22c5359b5damr16046695ad.13.1744943438447;
        Thu, 17 Apr 2025 19:30:38 -0700 (PDT)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0c14esm182185a91.19.2025.04.17.19.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:30:37 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] pwm: sophgo: add driver for SG2044
Date: Fri, 18 Apr 2025 10:29:46 +0800
Message-ID: <20250418022948.22853-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418022948.22853-1-looong.bin@gmail.com>
References: <20250418022948.22853-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PWM controller for SG2044 on base of SG2042.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 drivers/pwm/pwm-sophgo-sg2042.c | 89 ++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
index 23a83843ba53..26147ec596c9 100644
--- a/drivers/pwm/pwm-sophgo-sg2042.c
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -13,6 +13,9 @@
  *   the running period.
  * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
  *   be stopped and the output is pulled to high.
+ * - SG2044 support polarity while SG2042 does not. When PWMSTART is
+ *   false, POLARITY being NORMAL will make output being low,
+ *   POLARITY being INVERSED will make output being high.
  * See the datasheet [1] for more details.
  * [1]:https://github.com/sophgo/sophgo-doc/tree/main/SG2042/TRM
  */
@@ -26,6 +29,10 @@
 #include <linux/pwm.h>
 #include <linux/reset.h>

+#define SG2044_REG_POLARITY		0x40
+#define SG2044_REG_PWMSTART		0x44
+#define SG2044_REG_PWM_OE		0xD0
+
 #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
 #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)

@@ -72,8 +79,8 @@ static void pwm_set_dutycycle(struct pwm_chip *chip, struct pwm_device *pwm,
 	period_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
 	hlperiod_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);

-	dev_dbg(pwmchip_parent(chip), "chan[%u]: PERIOD=%u, HLPERIOD=%u\n",
-		pwm->hwpwm, period_ticks, hlperiod_ticks);
+	dev_dbg(pwmchip_parent(chip), "chan[%u]: ENABLE=%u, PERIOD=%u, HLPERIOD=%u, POLARITY=%u\n",
+		pwm->hwpwm, state->enabled, period_ticks, hlperiod_ticks, state->polarity);

 	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
 }
@@ -123,6 +130,74 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }

+static void pwm_sg2044_set_start(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				 bool enabled)
+{
+	u32 pwm_value;
+
+	pwm_value = readl(ddata->base + SG2044_REG_PWMSTART);
+
+	if (enabled)
+		pwm_value |= BIT(pwm->hwpwm);
+	else
+		pwm_value &= ~BIT(pwm->hwpwm);
+
+	writel(pwm_value, ddata->base + SG2044_REG_PWMSTART);
+}
+
+static void pwm_sg2044_set_outputdir(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				     bool enabled)
+{
+	u32 pwm_value;
+
+	pwm_value = readl(ddata->base + SG2044_REG_PWM_OE);
+
+	if (enabled)
+		pwm_value |= BIT(pwm->hwpwm);
+	else
+		pwm_value &= ~BIT(pwm->hwpwm);
+
+	writel(pwm_value, ddata->base + SG2044_REG_PWM_OE);
+}
+
+static void pwm_sg2044_set_polarity(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				    const struct pwm_state *state)
+{
+	u32 pwm_value;
+
+	pwm_value = readl(ddata->base + SG2044_REG_POLARITY);
+
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		pwm_value &= ~BIT(pwm->hwpwm);
+	else
+		pwm_value |= BIT(pwm->hwpwm);
+
+	writel(pwm_value, ddata->base + SG2044_REG_POLARITY);
+}
+
+static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	pwm_sg2044_set_polarity(ddata, pwm, state);
+
+	pwm_set_dutycycle(chip, pwm, state);
+
+	/*
+	 * re-enable PWMSTART to refresh the register period
+	 */
+	pwm_sg2044_set_start(ddata, pwm, false);
+
+	if (!state->enabled)
+		return 0;
+
+	pwm_sg2044_set_outputdir(ddata, pwm, true);
+	pwm_sg2044_set_start(ddata, pwm, true);
+
+	return 0;
+}
+
 static const struct sg2042_chip_data sg2042_chip_data = {
 	.ops = {
 		.apply = pwm_sg2042_apply,
@@ -130,9 +205,18 @@ static const struct sg2042_chip_data sg2042_chip_data = {
 	}
 };

+static const struct sg2042_chip_data sg2044_chip_data = {
+	.ops = {
+		.apply = pwm_sg2044_apply,
+		.get_state = pwm_sg2042_get_state,
+	}
+};
+
 static const struct of_device_id sg2042_pwm_ids[] = {
 	{ .compatible = "sophgo,sg2042-pwm",
 	  .data = &sg2042_chip_data },
+	{ .compatible = "sophgo,sg2044-pwm",
+	  .data = &sg2044_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
@@ -198,5 +282,6 @@ static struct platform_driver pwm_sg2042_driver = {
 module_platform_driver(pwm_sg2042_driver);

 MODULE_AUTHOR("Chen Wang");
+MODULE_AUTHOR("Longbin Li <looong.bin@gmail.com>");
 MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
 MODULE_LICENSE("GPL");
--
2.49.0

