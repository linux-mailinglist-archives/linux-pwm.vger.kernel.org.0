Return-Path: <linux-pwm+bounces-7718-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B9C90735
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2143ABBD1
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D424DCF9;
	Fri, 28 Nov 2025 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSaMDjtd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5FB217723
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290360; cv=none; b=g7nQv5YVFUPHPFkHuFbuFGTt7ujhRrRWDywpoIjdMOikyZIu91n7HXtoLVbgi4RWl4zebf+lXjRQi4zVO4C6wrUsLLM+BXjCYpFre7Bt3UxvUi2uRgi8gA0U2UtP4N9Z2/EbAxjJ1YR3KA9M7z/ij8VEHvvAVhhYotffpgDl6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290360; c=relaxed/simple;
	bh=a+ErtWdGgzML7jxeerkz3o5bNQ2OjAjVgWc3l2NvJsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwJv6qf2KLw48itdKIs6LHZvicY1Vq8XGbl0xL+8y+L2sVktWFFg11t0MRTol5Yrku3kVA9K7e/C8PngAHtXjMLxFxVMRD6p5v6Snd+VoGIzLgmE7kI7SxbKupbwoztSVS0FhB/EwMB+36nXGbbqL7QOimlAYw+NZtrqUkNkPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSaMDjtd; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso2864236eec.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290358; x=1764895158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJfQ8EGmp2loECfkqUR8E4KO61R5QbpXVzwiV7sg5RE=;
        b=HSaMDjtdgUyGHvHTtbqRZWbzKWU8m1M6dLln70/qooTRNAH/hulSFiqA8Ny8KoSqnk
         2v2igSs5SAa+al3keP1PBeXn8gDznfVrM6iSqu1j93xNQe84lN1O9BNbOedall5GvkCg
         uCjVwEZFsEJ2AQu/4G5PpFgx247YnDEsAtx+4RZfp//r1l2+9MnGVPxrahwyWWFwU1Fe
         lZ3LFpqoc5Yo2KzIfyf4pF+ArK1SXggDazqYOF5yf0xzPmx+8bPedQg5oF3tKQ1oAqJ/
         /BOYye9B32+wufMMU8qc+jGndFajejh8ef7fmVgtZCMEIpGfHx94jL13Ze0hYJy3AqIJ
         rFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290358; x=1764895158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YJfQ8EGmp2loECfkqUR8E4KO61R5QbpXVzwiV7sg5RE=;
        b=lTS1DFqSNyiaxfwO8aaVKbDV/xEnNsjw0/R/7Ba/2gjF5bdEsBAr3qXONZNxtGrR0p
         0LLxu16HWQwtVZ1+nSXxWQ83oD0gEuPi2rSZswDnrvxe+Jn0Mzx9TwjavhQZFJWDmd6a
         FHImnhxEDn000U8YfKmQYZ4l87YDUVHoP62N2hi8rFjnWhX3yFJ04lTyijLqGaaL73sT
         iww8qG2ul2URTsL4KgXFNzBDB1joh2YyyRo1FTkq8DQJXus4RsfAYpFiMeO4eQWNkH/v
         6AerlghZW2/X2eA1k9Y9CoI8oBD1IpoMIK8FAwtgFYQNg3ZMSKrLssvViIuwG5S7x58o
         qPnA==
X-Forwarded-Encrypted: i=1; AJvYcCXd13naYVWAiAP7buMsyi/nK/e7OKesLFpfe3juvANMQ29ctHTK+3YPlOze4BdS4ddW7LFjpebIxGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBErGJjqKc0Cti+wz2GGgn5TcDBMz6Qs3q00LR+jZceU+B+rjl
	P7ZNBJKQl/+EpKXyjsraRIy1x27RcoaVtgizg1JcWhqx46o5F6s18anz
X-Gm-Gg: ASbGncslyJY3ns0gJ/96/3E+5r5CjChpxK/F8gtwMf8grIEvgLXGNy+UzRuoUcb7WxB
	DVlZYaGx7Zg8dMWMcmgufH0o2q+K7n1rhZnlOAR0wnsH5VfkFXlVdqcum8Q9UB+WQ7RhfuQXgxP
	5OHlZdrlcJjOYvZ1/OWG8Iiky1eU6tGCkT6LlXBofTcxFwZ5sfJd2uPkRHdHMp54zkXeFTz/QK8
	OsgJgntrRPUCvCeKhzS5ErJqxa9W+083pWbCwC7KANBGel7MfpsLr6A64cIRwOgMEYPU+hkr34T
	fVBQOymTM7xeO9zCxHciDJeB7t+T/Y9vaDSQu/Z5OaX+ggMUwOoq4SO6/EiIxD2Q/K48lfNi6Un
	02dF8iKfgLxHFBRcwTyS6XS+/uqvXF+Zm9UL2WM2Dro+qjVFxVK8r45wfD+Tmw9LQMygykJQaYb
	uS4X6SkFZy2rm/YlxMxaNVNnE8okBZDSeOzvT2ip10l4E=
X-Google-Smtp-Source: AGHT+IGNUwo9ubyy8ujnAFo6D0PFW/JSPgvTWJlI5LVUgs3ky818XTmQwwQ/ozc/xy/VNMrZCtt28A==
X-Received: by 2002:a05:7301:4382:b0:2a4:5ff6:4438 with SMTP id 5a478bee46e88-2a6ff5307b5mr12830564eec.1.1764290357568;
        Thu, 27 Nov 2025 16:39:17 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:39:17 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 9/9] pwm: tiehrpwm: handle already-running channels at probe
Date: Thu, 27 Nov 2025 21:36:34 -0300
Message-ID: <20251128003634.247529-10-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems leave eHRPWM outputs running when Linux probes the driver,
for example when firmware or the bootloader configured and enabled a
channel before handing control to the kernel. So far, the driver always
assumed both channels were disabled at probe time and started with zero
tbclk and runtime PM references.

Teach ehrpwm_pwm_probe() to take a best-effort snapshot of AQCSFRC and
AQCTLA/B before touching clocks or runtime PM, and treat channels that
are configured and not software-forced in AQCSFRC as "pre-enabled". For
each such channel, take one tbclk enable and one pm_runtime_get_sync()
reference so that later per-channel enable/disable paths cannot underflow
the clock or runtime PM usage counts.

If the eHRPWM block is power-gated or its clock is disabled while we
probe, the AQ* registers are expected to read back as 0 and the driver
will simply treat the instance as fully disabled, preserving the
previous behaviour. Error paths unwind both tbclk and runtime PM
references per channel to keep the reference counts balanced.

This makes tiehrpwm robust when attaching to hardware that is already
driving PWM outputs at probe time.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 81 +++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index d472d717abca..b2503a675484 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -478,13 +478,20 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct ehrpwm_pwm_chip *pc;
 	struct pwm_chip *chip;
 	struct clk *clk;
-	int ret;
+	int ret, ch_idx, ch_disable;
+	u16 aqcsfrc_reg, aqctla_reg, aqctlb_reg;
+	bool enabled_ch[TIEHRPWM_NUM_PWM_CHANNEL] = { false, false };
 
 	chip = devm_pwmchip_alloc(&pdev->dev, TIEHRPWM_NUM_PWM_CHANNEL, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
+
 	pc = to_ehrpwm_pwm_chip(chip);
 
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->mmio_base))
+		return PTR_ERR(pc->mmio_base);
+
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
 		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
@@ -493,6 +500,22 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * Best-effort snapshot of AQCSFRC/AQCTLx before touching clocks or
+	 * runtime PM. If the eHRPWM block is power-gated or its clock is
+	 * disabled these registers are expected to read as 0, which we
+	 * interpret as "channel not configured / disabled".
+	 */
+	aqcsfrc_reg = ehrpwm_read(pc->mmio_base, TIEHRPWM_AQCSFRC);
+	aqctla_reg = ehrpwm_read(pc->mmio_base, TIEHRPWM_AQCTLA);
+	aqctlb_reg = ehrpwm_read(pc->mmio_base, TIEHRPWM_AQCTLB);
+
+	if (aqctla_reg != 0 && !FIELD_GET(TIEHRPWM_AQCSFRC_CSFA_MASK, aqcsfrc_reg))
+		enabled_ch[0] = true;
+
+	if (aqctlb_reg != 0 && !FIELD_GET(TIEHRPWM_AQCSFRC_CSFB_MASK, aqcsfrc_reg))
+		enabled_ch[1] = true;
+
 	if (IS_ERR(clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "Failed to get fck\n");
 
@@ -504,10 +527,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &ehrpwm_pwm_ops;
 
-	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pc->mmio_base))
-		return PTR_ERR(pc->mmio_base);
-
 	/* Acquire tbclk for Time Base EHRPWM submodule */
 	pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
 	if (IS_ERR(pc->tbclk))
@@ -519,17 +538,67 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * For channels that were already running when we probed, take one
+	 * tbclk enable per channel, so that later per-channel disable paths
+	 * cannot underflow the clock reference count.
+	 */
+	for (ch_idx = 0; ch_idx < TIEHRPWM_NUM_PWM_CHANNEL; ch_idx++) {
+		if (enabled_ch[ch_idx]) {
+			ret = clk_enable(pc->tbclk);
+			if (ret) {
+				dev_err_probe(&pdev->dev, ret,
+					      "clk_enable(tbclk) failed for ch %d\n",
+					      ch_idx);
+
+				for (ch_disable = 0; ch_disable < ch_idx; ch_disable++) {
+					if (enabled_ch[ch_disable])
+						clk_disable(pc->tbclk);
+				}
+
+				goto err_clk_unprepare;
+			}
+		}
+	}
+
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto err_clk_unprepare;
+		goto err_disable_tbclk;
 	}
 
 	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
+	/*
+	 * Treat channels that were configured and not software-forced at probe
+	 * time as "pre-enabled": take a runtime PM reference so the eHRPWM block
+	 * stays powered while such channels exist. Consumers still get/put PM
+	 * on top of this bias via pwm_enable()/pwm_disable().
+	 */
+	for (ch_idx = 0; ch_idx < TIEHRPWM_NUM_PWM_CHANNEL; ch_idx++) {
+		if (enabled_ch[ch_idx]) {
+			ret = pm_runtime_get_sync(&pdev->dev);
+			if (ret < 0) {
+				for (ch_disable = 0; ch_disable <= ch_idx; ch_disable++) {
+					if (enabled_ch[ch_disable])
+						pm_runtime_put_noidle(&pdev->dev);
+				}
+
+				pwmchip_remove(chip);
+				pm_runtime_disable(&pdev->dev);
+				goto err_disable_tbclk;
+			}
+		}
+	}
+
 	return 0;
 
+err_disable_tbclk:
+	for (ch_idx = 0; ch_idx < TIEHRPWM_NUM_PWM_CHANNEL; ch_idx++) {
+		if (enabled_ch[ch_idx])
+			clk_disable(pc->tbclk);
+	}
 err_clk_unprepare:
 	clk_unprepare(pc->tbclk);
 
-- 
2.43.0


