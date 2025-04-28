Return-Path: <linux-pwm+bounces-5733-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE11A9E5D1
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 03:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75531788CF
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 01:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1002155398;
	Mon, 28 Apr 2025 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHrwScZC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071516DC28;
	Mon, 28 Apr 2025 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804168; cv=none; b=aAXojMLZeLU9o4eusjjP0ZKGprA4lKHwWSH6a3oM+Qa+w0bDv6To0qt1kmdkm1IaaNfWvJWmp5lsrNeoGoEBCKmt2YAPozt+3qxIQEnjuKWv5/VmrnxL/bRyW30tpOUKFlQkb9Fj2pbUYfELOcdE9PLW/HWyQsrtUL1XReYHwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804168; c=relaxed/simple;
	bh=RAwT+b9QULu37wssvt5BOzimq4M/z0TasiXxablI9RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y++GeZKaCQeQFAt03OyLULZNWXAbIlz+P1rSeOUsrGxYWMYqoLzIAUymAQeGIaOKSQziddj839761QYcbDgtQaoNKuftaI7f/bTPG+KWJZ6FhkHiTK8J6ZFimsJV67x1vHsY6uDPixjpvyW9XZA8wtAfiCNdYE9BDV5wygVE9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHrwScZC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30549dacd53so3316781a91.1;
        Sun, 27 Apr 2025 18:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745804166; x=1746408966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1XOo3Vbbk6OtPs69iC9nG392lpAw1JpBjWZCyN3iG8=;
        b=dHrwScZCib+i4igc8u5SaNDSOFwviJtK8T7bfUEhBeEBlRD2ms1Yej+r9gbBNX0FKW
         EgDZc0nzF9bQGYMTx8sNkU266lR48P3HTvHxKsTSG6PKlZ49ZIpdqAZLR+4dOM0Yfec0
         z7FjPnXy4o3tXFE44GOuoDqW0Z0yAtxNt6TVuukjmCJtl1h5uzpqSW3pDlhJNpJ+acn8
         C6ALHggzRaQo429+BfzmWdrMlh9WYwBYyInb+T9TyYnufgrWmbtmXD76lEQe1CSL04l0
         UIvGW3a7jC3KG+PpuHjhwDZ3xbYDt0kf9hu/ykO1h6ibcDeepOaoni91rYoiHcwYmE84
         0MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745804166; x=1746408966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1XOo3Vbbk6OtPs69iC9nG392lpAw1JpBjWZCyN3iG8=;
        b=a0sB3F43fh1vs1QfjVSPhVSb/OxMPNIV5SQgGYvGGGyklIIMqVq7pgBLlu9jAFq80K
         62oxeoPlrKStCMpRxbtaxEsWpZPbyqtrP463GFLGR2StlBCl4Sp6Xf09UXkEPCGvNL+A
         PwDAfmSLyLMlTJfAPCgrwdIMne3nkOuY8RslrEBDx+7B4pMG0WHxdKpjqnKUkK3td86t
         kdbtf5vdwpx3Rn9DEanIuUHNG/voAclzVYTEGdi4qTP7Sr0GQ/sMzAhF/An6FqxP3IfZ
         u9MoGI24PEy7CU36FzHtRoX9dlYyr/AVC/PJIGJvu/ygfb2EsqDYpYD6A4ooNBcmaPDW
         cZpw==
X-Forwarded-Encrypted: i=1; AJvYcCUWTW8cffJ1sEoK9H+ukEMCbboETX627VBo0ARB4G9Tqfbyx5BGreJZGCbM8INbEFFHw93O4cJaeKcQ@vger.kernel.org, AJvYcCWHwRRaUic7wM7Z+ul7ryxmEqwBoL7pFZ3rB6EVL/HJgR+E4IGsVJEQL7oxoNGnLjG4HfPVoLZZPUBT@vger.kernel.org, AJvYcCXnO2pHSlz7u4ECbj+Nm21va/op1VeOmbFBw3eDuxluCZKD5y0GapsQu0t504t1zXleUXGEWBwsZxm8P+Ac@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFi1uclN9rPCbgsX/vCq0OPIaSKu1SJa3AFZbI9Jhh4ACFCo9
	6XkWQ3I8NgzREuWw2WFSBipUekCI2hd9oAsbukWc+FG2GqeUjfMh
X-Gm-Gg: ASbGncsxjyijZ21GXOZ1VJuXfP6K9qYLgfZ36sJxl02d+ZRMxaS77Oi/BEUvIhlnwJv
	AXchE63r1hYIjIRrWRwEs9fN4dBZ4pR9vYaOloFdBQOtCLf/p6NKyD0f4faYcBMO4a3E5PtDjdb
	iQP5/9k++GtCGntZbb94gAuQu8qz0cQoTVbsJhrzNCIuee+mTmUk9z64Csj4Pr9qTtiWEaIS75w
	psWEZX0VMhjU5TSmKREDaMNNeq3Ts48sPOCx6e1WKqmD7aBPMgRiFlM0n1kuIuPzsT1dDnvx3F1
	sHBDCOJ0q+rR
X-Google-Smtp-Source: AGHT+IHnQ1vU6MU1r9JMw0k7Ecc6KjPOryGisSgNWZ3r5gCwX8c7GY+Ct6trsj1ZnBJ9DZNBVx8LLQ==
X-Received: by 2002:a17:90b:268c:b0:309:f46e:a67c with SMTP id 98e67ed59e1d1-309f8a0769dmr14912717a91.11.1745804166022;
        Sun, 27 Apr 2025 18:36:06 -0700 (PDT)
Received: from cu.. ([2001:da8:7001:11::460])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb26sm8508671a91.6.2025.04.27.18.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 18:36:05 -0700 (PDT)
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
Subject: [PATCH v4 3/3] pwm: sophgo: add driver for SG2044
Date: Mon, 28 Apr 2025 09:34:50 +0800
Message-ID: <20250428013501.6354-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428013501.6354-1-looong.bin@gmail.com>
References: <20250428013501.6354-1-looong.bin@gmail.com>
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
---
 drivers/pwm/pwm-sophgo-sg2042.c | 89 ++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
index 23a83843ba53..5bb92c910540 100644
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

+#define SG2044_PWM_POLARITY		0x40
+#define SG2044_PWM_PWMSTART		0x44
+#define SG2044_PWM_OE			0xd0
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
+	pwm_value = readl(ddata->base + SG2044_PWM_PWMSTART);
+
+	if (enabled)
+		pwm_value |= BIT(pwm->hwpwm);
+	else
+		pwm_value &= ~BIT(pwm->hwpwm);
+
+	writel(pwm_value, ddata->base + SG2044_PWM_PWMSTART);
+}
+
+static void pwm_sg2044_set_outputdir(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				     bool enabled)
+{
+	u32 pwm_value;
+
+	pwm_value = readl(ddata->base + SG2044_PWM_OE);
+
+	if (enabled)
+		pwm_value |= BIT(pwm->hwpwm);
+	else
+		pwm_value &= ~BIT(pwm->hwpwm);
+
+	writel(pwm_value, ddata->base + SG2044_PWM_OE);
+}
+
+static void pwm_sg2044_set_polarity(struct sg2042_pwm_ddata *ddata, struct pwm_device *pwm,
+				    const struct pwm_state *state)
+{
+	u32 pwm_value;
+
+	pwm_value = readl(ddata->base + SG2044_PWM_POLARITY);
+
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		pwm_value &= ~BIT(pwm->hwpwm);
+	else
+		pwm_value |= BIT(pwm->hwpwm);
+
+	writel(pwm_value, ddata->base + SG2044_PWM_POLARITY);
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

