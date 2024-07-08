Return-Path: <linux-pwm+bounces-2724-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E61F92A08D
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C9E282715
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C278C6B;
	Mon,  8 Jul 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R1Uc+3HV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FF17721
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435985; cv=none; b=lU01Fy315dKcSGfiK7r73uToCci9zx30hI7m5HTRScqtHnaTDFjtrst1kkvOQ9cUfp0OVmQ8VI6ruRKFozoYQUS5AohzeNmYobt7x1400Ubj0iMRqLTdcRnoydmn+D/jLuufmcO7lACbA/prIbyvHCmKDOfm6aQqagN6Q3w4xQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435985; c=relaxed/simple;
	bh=Z0Wou9UJ/BhBczHjo/WbUSvrV4JMkFQL3FRoqJbCglY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsHOTZgNG0BrZP757m/CIEGX2LlQenkc2VhPkQgDX3QnDjXGMXgrFNsiWbZ51+k4W1aNYEePUhgBvux3MGx6uUa3hXAWHj5exAw8DWunBli7dkqsWxm0tZeaDO9Z7LzosOaJhUL81v9MPSa7YVahg5/9nF4VYh8U5cvbCF2+WYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R1Uc+3HV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36798e62aeeso2519876f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720435982; x=1721040782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqW0uZCqH5HVLtMjGDVx2xadsk75pptCe8ArkLxW0BI=;
        b=R1Uc+3HV4wX8fwG+DaNXKDEF+3mI7XOUJmYIK83aDWKlCRViFLJrNLC0opRUAXkwQU
         9wSOs3eMV/Y0N3+V5DVsq2WiCP4ZZijY5ZrUi7avXSmpzRvmM6FQIrRRkngUq7xKBw1s
         RpgEaWHtO3qB5Y/J+ma1i8a/lbrq5Yf5Dt1C2grVsvSl/F81lSy/FHKhgVKBYPc+DL3x
         Wdkf6eVvaKv+ZmJpd2PubGmGPz1gnfcFE57wgqAXi+3tBLuf9nAUkeN/wBZ7KWLt1t1m
         iSlbwYuiZMcRhhW3+uoVAuKDQ8++cCQOsdDlhnJhUsUDBhTX1FFnG/VIR/F8ONmVC8Wp
         TjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435982; x=1721040782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqW0uZCqH5HVLtMjGDVx2xadsk75pptCe8ArkLxW0BI=;
        b=VxWiwOQSY8rJaxQVnX8ebSkHIgXqS3NyaTgcpW84rXcyqJ28FvfXOlgsKLpK7N4eIb
         /ka/U7eWXqokSab+rE94v0yHAdmavp+aPo+oiPYdVxgV85F8C4HoLBH5OS9bY6j9Gc7d
         NhEXY07nKS4MloBJEeoymzZSCd4wODK+IbtUDHxf71+Pd+0g3DlnI0T89IBxsCpNRyS7
         vONyn3hB1N/j0gVGa8sTn1KOfVAEayed77F2nPm8Y8KhKbGt3b3Jqij69VEIxU2om8oD
         tE4qr/KeIQuPNBHMsSz21fdl5Rc7Zr7Of0Gp6ppVLnEY3RgbVex1ebMtVOkfHhwvXJQB
         zcDQ==
X-Gm-Message-State: AOJu0Yx5iXAPaW9sIQYAtHYw/eZXeX6IaK8FYxBGLUZB8MchQpJwwOpP
	2ZIEgY5+LMV3xhCo06PAtCdULQ5PDMITv/iRm+LUjpAE4UMarg3YPeJvgbVvYRCeWAmOrczqfw0
	v
X-Google-Smtp-Source: AGHT+IHMxb8Pkz6tOMDQA4LhfpVe7ohHWfwfKVMKlry1DWQTxambt1D+1NABi6c8oKAreMF9U/B32A==
X-Received: by 2002:a05:6000:12d1:b0:35f:122e:bd8c with SMTP id ffacd0b85a97d-3679dd3cbd6mr7851916f8f.17.1720435982030;
        Mon, 08 Jul 2024 03:53:02 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367c4eec908sm1850913f8f.88.2024.07.08.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:53:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 5/6] pwm: axi-pwmgen: Implementation of the waveform callbacks
Date: Mon,  8 Jul 2024 12:52:31 +0200
Message-ID:  <2c54a25eecc6f4745861568c49b98ca5b34a2f73.1720435656.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6777; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Z0Wou9UJ/BhBczHjo/WbUSvrV4JMkFQL3FRoqJbCglY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmi8T30PbP/6I88a+orp0W6GRXs33Va+7ZkeSop DrEH7cH0mGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZovE9wAKCRCPgPtYfRL+ Tvf7B/0aIz+8dBfoduuVn8jKUxkoU6ZnLZfrcdaACHPVqkIqRF8Rj+8E9fGaMDdTXkHsLYQS5tB 5aV4tMx/wQM3/niFNOxV23tGcZZKu/eDvBDMumHKDa4s98ga9ybeTRRE+cOCSkbow8vuQK3X9It LusebiNkZngz9r/TEKuPjVplwG3s5jponoZFbtvxzzWG3cVzGvxy1fh14namn3TfLAOZV0SF9y1 XxjSNq2zdU8hI5xnoW72KaktYJqr6DPJRiV7fLrl1/Yeo4crH8l1PtJtV5WOZgYnt+aosvbZxKs QIXFywNggCS7v7uHx537DqahGjyVNc9lbbKcE4Mpm6I5pzF8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert the axi-pwmgen driver to use the new callbacks for hardware
programming.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 148 ++++++++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 46 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index aac4f395497b..757ae037d5d6 100644
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
@@ -53,81 +54,136 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.val_bits = 32,
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
+	if (wf->period_length == 0) {
+		*wfhw = (struct axi_pwmgen_waveform){
+			.period_cnt = 0,
+			.duty_cycle_cnt = 0,
+			.duty_offset_cnt = 0,
+		};
+	} else {
+		/* With ddata->clk_rate_hz < NSEC_PER_SEC this won't overflow. */
+		wfhw->period_cnt = min_t(u64, mul_u64_u32_div(wf->period_length, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
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
+			wfhw->duty_cycle_cnt = min_t(u64, mul_u64_u32_div(wf->duty_length, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
+			wfhw->duty_offset_cnt = min_t(u64, mul_u64_u32_div(wf->duty_offset, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
+		}
+	}
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> PERIOD: %08x, DUTY: %08x, OFFSET: %08x\n",
+		pwm->hwpwm, wf->duty_length, wf->period_length, wf->duty_offset,
+                ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
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
+	wf->period_length = DIV64_U64_ROUND_UP((u64)wfhw->period_cnt * NSEC_PER_SEC,
+					ddata->clk_rate_hz);
+
+	wf->duty_length = DIV64_U64_ROUND_UP((u64)wfhw->duty_cycle_cnt * NSEC_PER_SEC,
+					    ddata->clk_rate_hz);
+
+	wf->duty_offset = DIV64_U64_ROUND_UP((u64)wfhw->duty_offset_cnt * NSEC_PER_SEC,
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
2.43.0


