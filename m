Return-Path: <linux-pwm+bounces-6980-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E077EB1FBC9
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F083B7E43
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB196201017;
	Sun, 10 Aug 2025 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffavlSyv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD381F4E57
	for <linux-pwm@vger.kernel.org>; Sun, 10 Aug 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851975; cv=none; b=nNsvRQM663XxrlxAuCzTgc3OF65MyhdQIEfzBwh3alcG/hPbO/u/DahVCRQa8mw3sm8rzSauxKvyM9zVlrE8M0Iy5oIj3j3nE0WZC1PFgLf1onAK216yHhBgwNNcEUjodWMxQc1DCsTq+iWTfT2wEZwfF/3/8E8/Zio/w9XTSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851975; c=relaxed/simple;
	bh=P2Fu72CQaNHCt9JS3YRrF2AbMeOcEEBOTRXmAyjvBGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+V8HpmNtjDku4xkkaxeM+f9hQ2hImE9QtAkcWyhhmKcbadr97x5+yJgPmL/dQcoEz5Bd84xU8rLLgrTBcnLKHRe7dFR18TuSsDpzHFHKpJLTH+aUHFgTyupG0VcXalE/nTCzRNDoeNmBGEGnf9rz9j39TSVgOcMez1p4qhUklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffavlSyv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so23164205e9.1
        for <linux-pwm@vger.kernel.org>; Sun, 10 Aug 2025 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754851972; x=1755456772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFEz1nclHsvZ5p/yQBGHENq//Wd3Y52xpznrZUoy7hY=;
        b=ffavlSyvULV9XGBkHd5bq5yfTJVVKkK24pnXF6JGTHRtpZg4Bp6bNojz88qDEJsZoR
         50v+iBD8AtPvDervR2icKjk6bh1WiJI1c+31oSEUwEsTQc+F5jRKuae1rHVxIMwuHcPv
         N+ysgTPS7OZUwjZH6f9ON5lg2mVK0TuzCCI1wrGOyQQxZ8yCdZ1uj9F8Rk002xr7ieqD
         zb/3a3lJDN0cPU4jc/YWT9fKgm0Scern/rzDDgV97cHYXI5A2+7I0Htk/dDkCug3gUpG
         cO55uMTewqnaJpnXtunX7jdp5URyDgeiiR/FpsL4p59+24Y789TVzlnqaxWxLYlGZj8g
         laMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754851972; x=1755456772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFEz1nclHsvZ5p/yQBGHENq//Wd3Y52xpznrZUoy7hY=;
        b=uP9EjHttbtnD8z5SoLfH0YfSaxBTd5NO5ctJWEQEO0/BrQ+w6fJhLqNI40n849Xx0x
         21oFni4QFCMen57U6tNfuw5p5ncv5R+MrImNDCon2HVjhTlHRb4iBx8pcyqBrKJDisox
         9IpponCt6pVGLeXu7smoZFwY+rnW7uZ4dodIzJHcSdPfmGxkPeL/QOnbsFATc1zDuN/P
         5+fy4usgHy+GuBj4itMONCRzRuDGB3qNQhxpAZEHXQ6LYsrSRInQj8IdAruxq+WAJxPU
         8RVv4veC2udGBTisv0IRtTl1ilKSpUl2MvdCwY23ReUxgGjVXpG3sJGMbWG8IHRcdTZK
         sy8w==
X-Gm-Message-State: AOJu0Yx1lTPKp66ejg1M4Btr4Ys2YDDbU/bJsu074/xYq+ZNnQ6K4VEb
	dqrXu1czmuoNdmShctpQAjVAO2K6y2YfH6BjrOCFj1XGHzWJlhu9pppcFWKHyn5eors=
X-Gm-Gg: ASbGncshlXYVvr6KrGO1MRrYJy/qfj9VwT0tY6UbvGWjBqUjLDtARe5rZhDe14vfYow
	/CjtM4ujkX7Rb3dnmv2RnqxxaA3YQbVAT7S884fejB8DpsHkLeCgjMyqxz54hFP2BaRIVQfLdP5
	DSKE9uLEwdtCr31ioP6NxJYwZeVkLM6YW1PeVNSRqciUV2aDA/3HM+f26r+jK5c59CKyR1uSaAz
	qB/XxvfCLIRwjMlVzPCHoqHhbCFAkN+kxNmg0zqe60maBWdZdduZTujdkPc2lh5rJTzddcjthDF
	1ZPmqBydQqkMcJxTpobcQ0TPj/clSGrV8/KU/gydKZyxVv2I+sppDCUQ5Uy31HebcYqdgcOx7At
	V5C1my4VZ69hbvuycTU+6qJ/+GyVA841RK8n4tlvjSQJmoQmU
X-Google-Smtp-Source: AGHT+IHWEczYoBoBFfJKfiPTtisF+slaMpEsHwic/e3e52JoQy92AoB9CQoFKFa36R/flhTCcQ+URA==
X-Received: by 2002:a05:600c:1c98:b0:458:bfb1:1fc7 with SMTP id 5b1f17b1804b1-459f4f2e2f9mr83878475e9.6.1754851972158;
        Sun, 10 Aug 2025 11:52:52 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm319461145e9.22.2025.08.10.11.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 11:52:51 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v1 2/2] pwm: Add the S32G support in the Freescale FTM driver
Date: Sun, 10 Aug 2025 20:52:18 +0200
Message-ID: <20250810185221.2767567-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
References: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>

The Automotive S32G2 and S32G3 platforms include two FTM timers for
pwm. Each FTM has 6 PWM channels.

The current Freescale FTM driver supports the iMX8 and the Vybrid
Family FTM IP. The FTM IP found on the S32G platforms is almost
identical except for the number of channels and the register mapping.

These changes allow to deal with different number of channels and
support the holes found in the register memory mapping for s32gx for
suspend / resume.

Tested on a s32g274-rdb2 J5 PWM pin output with signal visualization
on oscilloscope.

Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/pwm/pwm-fsl-ftm.c | 42 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index c45a5fca4cbb..cdf2e3572c90 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -3,6 +3,7 @@
  *  Freescale FlexTimer Module (FTM) PWM Driver
  *
  *  Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *  Copyright 2020-2025 NXP
  */
 
 #include <linux/clk.h>
@@ -31,6 +32,9 @@ enum fsl_pwm_clk {
 
 struct fsl_ftm_soc {
 	bool has_enable_bits;
+	bool has_fltctrl;
+	bool has_fltpol;
+	unsigned int npwm;
 };
 
 struct fsl_pwm_periodcfg {
@@ -386,6 +390,23 @@ static bool fsl_pwm_volatile_reg(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool fsl_pwm_is_reg(struct device *dev, unsigned int reg)
+{
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
+
+	if (reg >= FTM_CSC(fpc->soc->npwm) && reg < FTM_CNTIN)
+		return false;
+
+	if (reg == FTM_FLTCTRL && !fpc->soc->has_fltctrl)
+		return false;
+
+	if (reg == FTM_FLTPOL && !fpc->soc->has_fltpol)
+		return false;
+
+	return true;
+}
+
 static const struct regmap_config fsl_pwm_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -394,23 +415,26 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 	.max_register = FTM_PWMLOAD,
 	.volatile_reg = fsl_pwm_volatile_reg,
 	.cache_type = REGCACHE_FLAT,
+	.writeable_reg = fsl_pwm_is_reg,
+	.readable_reg = fsl_pwm_is_reg,
 };
 
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
+	const struct fsl_ftm_soc *soc = of_device_get_match_data(&pdev->dev);
 	struct pwm_chip *chip;
 	struct fsl_pwm_chip *fpc;
 	void __iomem *base;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*fpc));
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->npwm, sizeof(*fpc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	fpc = to_fsl_chip(chip);
 
 	mutex_init(&fpc->lock);
 
-	fpc->soc = of_device_get_match_data(&pdev->dev);
+	fpc->soc = soc;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -526,15 +550,29 @@ static const struct dev_pm_ops fsl_pwm_pm_ops = {
 
 static const struct fsl_ftm_soc vf610_ftm_pwm = {
 	.has_enable_bits = false,
+	.has_fltctrl = true,
+	.has_fltpol = true,
+	.npwm = 8,
 };
 
 static const struct fsl_ftm_soc imx8qm_ftm_pwm = {
 	.has_enable_bits = true,
+	.has_fltctrl = true,
+	.has_fltpol = true,
+	.npwm = 8,
+};
+
+static const struct fsl_ftm_soc s32g2_ftm_pwm = {
+	.has_enable_bits = true,
+	.has_fltctrl = false,
+	.has_fltpol = false,
+	.npwm = 6,
 };
 
 static const struct of_device_id fsl_pwm_dt_ids[] = {
 	{ .compatible = "fsl,vf610-ftm-pwm", .data = &vf610_ftm_pwm },
 	{ .compatible = "fsl,imx8qm-ftm-pwm", .data = &imx8qm_ftm_pwm },
+	{ .compatible = "nxp,s32g2-ftm-pwm", .data = &s32g2_ftm_pwm },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
-- 
2.43.0


