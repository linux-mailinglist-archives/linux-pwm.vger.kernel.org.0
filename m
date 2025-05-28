Return-Path: <linux-pwm+bounces-6163-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5DAC66CF
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0AB1BC6C27
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7627A46F;
	Wed, 28 May 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB0Yhs9+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33C27991C;
	Wed, 28 May 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427145; cv=none; b=Zuc1RFtHNKlzhKpoyziwvYN9l+kh2ar/EyB43CWtUcp3IfYBtwsaQrE1lR6TSwDwoQAS76cezFmh2T6ae0wlnlFqGk0Ffui/vrIrHIT4cXIc1nVdEwW4APHEEbRAPOKNQabVVvn7+O0/sN+YlzSHkgHViIJz7wXjujbKaqUELwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427145; c=relaxed/simple;
	bh=xr9G46dj58Ks9R2hFHMEyGZQjQDhmexVHbnzDbFEwVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si+iRYvZh3LcDLzem/zkSZXIduyStW9ZfmqQkVrbfnpbIzf9N9UftoyX4ZbMGBNThx035ahMrAjEe7Kt8XknRPpAExjcX+O3759y4EryEZKtNEeK4Mpede8W4AwOrMly8k+Q78mtXle3oK1XFIVWddqPdzd2KoS4pPYvi7x/bc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB0Yhs9+; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3fa6c54cc1aso2523582b6e.1;
        Wed, 28 May 2025 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748427143; x=1749031943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9UzaJZDvKRNmn4BJ2b4hvJbdoSm7qg3xJXdaBQvCs4=;
        b=eB0Yhs9+42K8/KhZI0GQuQ6GGIPkDAwu47Us7KskuAqyijbrQF/VBdZsDI9SMC3hA1
         ruipRu+qHVQ7gwEuxywCbHaLtZxaPA7eJb1uLNL5u9Otr2GMjmH8Z4U8Apj20iKt0jmw
         1HLeN/BlIzqqgST/mtna+nU4hHEAzLlWorvhH4iM+oAMB9n1e0IUUwqPhAT15KM9IGz3
         8NnP528ZCmBrj0vCo9TC+FFs/8zs42PghD6lpS3SZssyy0vCZPK9eDl7InTSxZLKy8OZ
         FJo24RVncIf6FyQCEH1QvDshy9GiLwBu64GAsQQdGkZ9hwPqkCxdfSY09pjaQK3Bv1GW
         fCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748427143; x=1749031943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9UzaJZDvKRNmn4BJ2b4hvJbdoSm7qg3xJXdaBQvCs4=;
        b=fws0ndU5p0lRsQCQFOb169xw0j2hhrFJxOt+LqTLVR2a8j9mAsLd0QkmmfDPhmv9VI
         7Xf69vO5QMsBLXrIf1fcbgWqQoizNX4N8L3iyPv3nS82ycmDNQVc4lQoTiVmKikWED1i
         SETQTfK/MI9oHbXGuRHrjWHhfRFSJA19YrLmtOloKOc8RALunwig/wmJw2BBrNA3ESY4
         1YOBc59eC/qdRb5Pwb0/klqK86mhBfw+qPaIg2BqggW4Sx/TDMNk23ZuD8f6EZ91Ns2H
         vWyn4mf9aqJ2yJVbWeeCeQbg1AKAPr0yscFxfZKPtyTVg8lI5DwI4WWnCbXYvqgfwmXb
         AArA==
X-Forwarded-Encrypted: i=1; AJvYcCUyyjoyya485HzwONcK0JWV89VEsDjCK05Qp9UkZAG7vRBkt34KRO/Ztq5qN+7QnCQ8eo9Tnsoe5kTg+C+l@vger.kernel.org, AJvYcCVTmZsIMwYM9ATa40hVMxRZ1KvfQ1PnmHFCRi0MSjQtVuYf5ryc7o7zBUhRG6hIjOJP0nEJNLIl20ks@vger.kernel.org
X-Gm-Message-State: AOJu0YzcnRo1GoyFiKfCHvtGDBB0/EB7S9aY6zsUmf+MtIfvsKEZ5w6+
	KWiKNmEeHViZ/PrK5fkh2YhlS9ufgA4SZEruFly53nJcPbcMkYYNxpnkfb9SnA==
X-Gm-Gg: ASbGncvysRn5jTx3rNR1I7G9/1BBm4vqrMFcU54owRWT3PkhUns2kTB94+mJWyTYhl6
	eqBhpRJ6yGv3rxTFgG/BmSGjF5TzvX1Bre0l8PwPIt6dnEVR5ZwPpPIRq3An8zqCt7bquXkzqcm
	KMtH0DBjntAa/hOCaZk24xeeSiUdVPZ0ChfrRY/HUbhXYwOsw6z0JqhTKoOWCZpRJeJ+erkgxSA
	S6r02v2w/NTwRbAvbj5r8ptEyFWwDVWT6POv1L54UrvVBIqeKR5LlorTm6g7CZwHglz0eJ9eQ29
	/jI+xJCINL5MMWQ7VgIKdj3GYYemA3qN4oX+v2UQ7N3+VQ==
X-Google-Smtp-Source: AGHT+IEjHqDXErb8LHY+YXueka86+j+atlpa5otAATrNzDLyo6C+uNeLDmOMpvofRqGSXrlPBv+XBQ==
X-Received: by 2002:a17:902:f544:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23414feac2bmr246739315ad.32.1748427132449;
        Wed, 28 May 2025 03:12:12 -0700 (PDT)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d358f118sm8453595ad.138.2025.05.28.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:12:12 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/3] pwm: sophgo: add driver for SG2044
Date: Wed, 28 May 2025 18:11:38 +0800
Message-ID: <20250528101139.28702-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528101139.28702-1-looong.bin@gmail.com>
References: <20250528101139.28702-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PWM controller for SG2044 on base of SG2042.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pwm/pwm-sophgo-sg2042.c | 89 ++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
index da1c75b9c8f5..d71d2a66b722 100644
--- a/drivers/pwm/pwm-sophgo-sg2042.c
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -13,6 +13,7 @@
  *   the running period.
  * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
  *   be stopped and the output is pulled to high.
+ * - SG2044 supports both polarities, SG2042 only normal polarity.
  * See the datasheet [1] for more details.
  * [1]:https://github.com/sophgo/sophgo-doc/tree/main/SG2042/TRM
  */
@@ -41,6 +42,10 @@
 #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
 #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)

+#define SG2044_PWM_POLARITY		0x40
+#define SG2044_PWM_PWMSTART		0x44
+#define SG2044_PWM_OE			0xd0
+
 #define SG2042_PWM_CHANNELNUM	4

 /**
@@ -84,8 +89,8 @@ static void pwm_sg2042_set_dutycycle(struct pwm_chip *chip, struct pwm_device *p
 	period_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
 	hlperiod_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);

-	dev_dbg(pwmchip_parent(chip), "chan[%u]: PERIOD=%u, HLPERIOD=%u\n",
-		pwm->hwpwm, period_ticks, hlperiod_ticks);
+	dev_dbg(pwmchip_parent(chip), "chan[%u]: ENABLE=%u, PERIOD=%u, HLPERIOD=%u, POLARITY=%u\n",
+		pwm->hwpwm, state->enabled, period_ticks, hlperiod_ticks, state->polarity);

 	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
 }
@@ -135,6 +140,74 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }

+static void pwm_sg2044_set_outputen(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				    bool enabled)
+{
+	u32 pwmstart;
+
+	pwmstart = readl(ddata->base + SG2044_PWM_PWMSTART);
+
+	if (enabled)
+		pwmstart |= BIT(pwm->hwpwm);
+	else
+		pwmstart &= ~BIT(pwm->hwpwm);
+
+	writel(pwmstart, ddata->base + SG2044_PWM_PWMSTART);
+}
+
+static void pwm_sg2044_set_outputdir(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				     bool enabled)
+{
+	u32 pwm_oe;
+
+	pwm_oe = readl(ddata->base + SG2044_PWM_OE);
+
+	if (enabled)
+		pwm_oe |= BIT(pwm->hwpwm);
+	else
+		pwm_oe &= ~BIT(pwm->hwpwm);
+
+	writel(pwm_oe, ddata->base + SG2044_PWM_OE);
+}
+
+static void pwm_sg2044_set_polarity(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				    const struct pwm_state *state)
+{
+	u32 pwm_polarity;
+
+	pwm_polarity = readl(ddata->base + SG2044_PWM_POLARITY);
+
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		pwm_polarity &= ~BIT(pwm->hwpwm);
+	else
+		pwm_polarity |= BIT(pwm->hwpwm);
+
+	writel(pwm_polarity, ddata->base + SG2044_PWM_POLARITY);
+}
+
+static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	pwm_sg2044_set_polarity(ddata, pwm, state);
+
+	pwm_sg2042_set_dutycycle(chip, pwm, state);
+
+	/*
+	 * re-enable PWMSTART to refresh the register period
+	 */
+	 pwm_sg2044_set_outputen(ddata, pwm, false);
+
+	if (!state->enabled)
+		return 0;
+
+	pwm_sg2044_set_outputdir(ddata, pwm, true);
+	pwm_sg2044_set_outputen(ddata, pwm, true);
+
+	return 0;
+}
+
 static const struct sg2042_chip_data sg2042_chip_data = {
 	.ops = {
 		.apply = pwm_sg2042_apply,
@@ -142,11 +215,22 @@ static const struct sg2042_chip_data sg2042_chip_data = {
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
 	{
 		.compatible = "sophgo,sg2042-pwm",
 		.data = &sg2042_chip_data
 	},
+	{
+		.compatible = "sophgo,sg2044-pwm",
+		.data = &sg2044_chip_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
@@ -212,5 +296,6 @@ static struct platform_driver pwm_sg2042_driver = {
 module_platform_driver(pwm_sg2042_driver);

 MODULE_AUTHOR("Chen Wang");
+MODULE_AUTHOR("Longbin Li <looong.bin@gmail.com>");
 MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
 MODULE_LICENSE("GPL");
--
2.49.0

