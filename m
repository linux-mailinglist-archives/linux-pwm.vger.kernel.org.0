Return-Path: <linux-pwm+bounces-5681-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27974A99E22
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 03:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16FB1946BCD
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1A1C8606;
	Thu, 24 Apr 2025 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAKlY2wR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E491C4A0A;
	Thu, 24 Apr 2025 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457927; cv=none; b=u7FyzU+E25Wae+lvGAzX0d04QY7uXlVkmAv0Q6uLM6l+35HjFhJBfq514gK1Dnm05+wHEVvpsH+UxrHPB2ifmVcVaE/aWbgdOoKDcU+UqhwBagU4Tx3v7VxPnocS1d9tQ1NIrOeibhsMtIrhuRnRE30Hb+5B2FK8HySkSiUoeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457927; c=relaxed/simple;
	bh=RAwT+b9QULu37wssvt5BOzimq4M/z0TasiXxablI9RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9D789BDqhFkdiMEivs+P0B+VGxw42cWXQZ8MDapKFoxjnGk/zzxsKvD+dNq/zlkjQ9IwxARJlNjLgqopUNnk0ZVJS34nUUe1uFg7tAPQ4GRv82dt7vnugzhi027gZ3sToWSryFdkP/je1s9eJfOPM+X3w3O7HZK0/GJb9ZR3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAKlY2wR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376dd56eccso423118b3a.0;
        Wed, 23 Apr 2025 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745457925; x=1746062725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1XOo3Vbbk6OtPs69iC9nG392lpAw1JpBjWZCyN3iG8=;
        b=FAKlY2wRgmZq7eEj3rin1y3TRjP5noDs5XUypynzFpg5lFfHjKEBqje4qApvi9X/o6
         VIqx016fyss0oZHcP1sJdXeiwfb8Z6IS0kT3tP737eNc5cRzsJ1opodIIGd14JbuB8Rc
         0gWBRQko0RWOsOjCrUYD0ba/a0bhWlsM4QsIsvXIVcsenU/7gHxndfoe6bZuMmdeMHrB
         uAVjoFdWl1PHmhB7ltwMeYcnBIVJNZFxIULI/4CWpFavToJwnggO21SIId3lBJZbmNFJ
         QrVnK1WlTlIgbKBp2748Qsbu4adARP8iTAt3UNPIGwHT2GK/HiPmCixv65g6FYsten/Y
         oHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745457925; x=1746062725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1XOo3Vbbk6OtPs69iC9nG392lpAw1JpBjWZCyN3iG8=;
        b=gmGbm3g4i3uUsi+1UJtpspV6RGrRfoEiAvxaGMAPkYcnCnWF98wc77L01TnFeK3JcH
         AXN9dRmwTS1svvkgOfF64Ximfka5D1VRKPSZXh8Gp5UdQPRXdhIFBlIgKjTPuhIbYOo9
         oJ7mdrEurNLuYzFnLpoIoP8CFtA19wazw0sBnP5AFIZskoGriOiDR1d3Bx2gym33kDbl
         Iie/0cK1XoKAVoCKvKF8l133AixH2SAmlTKYDJKJdejg81P4y1cxkWR3p6kbgGEz6Ep9
         mb++j+OueQhXBP7uukOShbST3p5iuU3DZP8uIuZrOE27SzcKNtf51nPSQZUdHo6Go2Lm
         mA2A==
X-Forwarded-Encrypted: i=1; AJvYcCU6+6C+osZFAJsWWB9kpAaCe23EX3vIYOguSeg24Y3+aNQsMN7DG6gG69BT7BGT5Vq6+RWVV+OWPwsl@vger.kernel.org, AJvYcCUxhXuw6DwMxe6IcDdyuRZHxy/vhFDDZ6yPGJDmPqgOVtCB6AUATuZxApz4bJU83VECh1wAQ9B0W0Rh/Vxn@vger.kernel.org, AJvYcCWwfZHb2sDXOl8S5YJX+0dOKcYKH0miaPMdtgByRPcugxTC14iS3l1z9A7xbuzBdHu9DUazDPEXrfTm@vger.kernel.org
X-Gm-Message-State: AOJu0YyIh3z3DH+wgopyKU2XLqQcw7tbZAF/4EAYpA9oKsqRHs0lQejV
	ElaNUBCLuxokOi38g7tCj2dDMdrM480M6ReUIptdsEdx8G02vQwQ
X-Gm-Gg: ASbGncsELxQO0niMiArDf5Ww4zieqM3Y0tXKFwAd7FXjbDP/dkJbgnYKq+b1QjnXi0A
	Rst0sDwUsfYv3OG94ALtODUOeT+ETSZx67Jbk2pjBU3olR8tbBVkV50MwhVLdME0dvA3/wCtpZD
	Xn9NRVdDY6fCmxhHOdMo2dhMW+rdVoKqDOoNvECqidz7vvQyrjYJt9P844C4pe2frEzUGTOIw3j
	x4heWQmtgwB0Bjb0F8ox+xMoN1sqdcjAYkj/T/OYWUVngyap3IknQXhmeNlakRKjawSRqpRHADL
	zYXBEqr+N/Aqf8ETcA+tMMccTIA7i5o=
X-Google-Smtp-Source: AGHT+IHsd1sGOFTAYcstFEpnAM4EWVWCMOqSqGHKwR4owwH0B3jVebBIs4l+NCEj36pdStMWv9MXGg==
X-Received: by 2002:a05:6a00:801:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-73e24e05acbmr1151329b3a.20.1745457924958;
        Wed, 23 Apr 2025 18:25:24 -0700 (PDT)
Received: from cu.. ([111.34.70.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a8cdsm231049b3a.115.2025.04.23.18.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 18:25:24 -0700 (PDT)
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
Subject: [PATCH v3 3/3] pwm: sophgo: add driver for SG2044
Date: Thu, 24 Apr 2025 09:23:28 +0800
Message-ID: <20250424012335.6246-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424012335.6246-1-looong.bin@gmail.com>
References: <20250424012335.6246-1-looong.bin@gmail.com>
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

