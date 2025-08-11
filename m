Return-Path: <linux-pwm+bounces-7004-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E61CB21867
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E11464E0E
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF42E336C;
	Mon, 11 Aug 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3x5+Mbx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1722425B
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951460; cv=none; b=U7xngwHdV81P0w4qy0JWh73n1XzxRdqQKVRj3DSEr3dxwAQFidrGM64Z106u53FnoAi3g64Ay9A/R5nwXLE9uCF/weGskfNexRaBAXb/BTa7gYwc/1RQF1mwvClFIWe2mEgsxWV7suIIwCN3SwyEFWOk6tPhpLemvXD0CaORmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951460; c=relaxed/simple;
	bh=QhsYH0yhdInsawGFOOU7wcTCxTp2DjRCkw5oJ+fqeTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4e+RUq+UGAzfMEG85fMUyYlwOlwQlxuzc0e9jE22BOGQSkQ7QUag81cbtBWV34rRzWzpphKykjdCxn74ZHF/ISB/wasg80NHxlNhegA/k7ZddbUIc22HsZa7D7uusXuw3JF+C+vm5lHnLrDO6YCI23MhdHkuoC/sntxq+QJlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M3x5+Mbx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455b00339c8so31022465e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754951457; x=1755556257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffT6YWZkdUEe6FghMWArz7x5VLbOw7EcrzjaESrmOVU=;
        b=M3x5+MbxIAZ1hYugfjac1JsqdVvTHxfYNIdfX0Gn023YlKzEMxAdRwyiMmnHYV3GlZ
         802X4DBCxRqBdL1+r0POGO8rPgF2tqc7qun2TCi34mmsAcwrI/n9uDWED3sK6+BzVUyX
         bcc8jQGUYOKXmECXE6K5BAbOx1BpmGDsyQGi2omJjNN81C6RUbsETVydEM1XKpRt43H+
         X5cqbTBsNAyrsGCVMi8449A4UkFE8S06O8f5FOET49LeRVWH0XsxUVZlazF1MT82YrVH
         Pg4eDeUURk3In4VyvLJnHS3BkhgOx0LYqO6eAfw21Y3z1qDBSgtMW6wV56b81il8TTWu
         W1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951457; x=1755556257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffT6YWZkdUEe6FghMWArz7x5VLbOw7EcrzjaESrmOVU=;
        b=LNzthBg43h5BAufbT7kj538vSYkLx0wU6PVQ1dQ2J6N+8w0PRaDPfXSIf51gRb/J6Z
         9/PKc22bcHXcLujUIUtIylKJ8WabUJg0BlQm/JM1sHz0+l2k8GOQG93n+Y61t/zuWoN5
         RsQgmU+LdgKUx1MzjcuP8acgJENW+8U9v7nO0EvFE8c91353yC1bznX2tL1l7uggMXoQ
         2DbQNm5pJT9UVhi5cQkR3V67pOuvqkcxZYPkz+RmFYR+hGC4bCmqtEY+eIitTQte2/vj
         o5FJJ8lI473lSWdAZummvX2kz1hsN5YCBO60aC16/xLumyQ6SP95V/j7B+SAmfAlwp8J
         Snog==
X-Gm-Message-State: AOJu0YwtYFqTi3uwZDmz+VEhomm/cV9uupqP/OoxbUP8t/Ui43sFisvc
	eL9H0TSVdvA1lA4mDnTJ/UILWEVpuo8AsWyEU6vCJOutuzKrWt5Z722DGGQPvB9aVe0=
X-Gm-Gg: ASbGncsgC12f4odM6j/mJF7ShbzlxboHU7AB+S9cDH2KJB9uYHT94tM6qhCP5A9hHTo
	+qBqXBhyzPBfzkB6Y/SIP+LaL+DZ9PFNoSGbGS/uhAZ4dxTNCX8dAhCPUM0zQoCWh7NP+h7wFhB
	9Tl9hVgXnQh/xv6Ikkpj66SYbI6QY1eVF4LCVH4GUHI9g1P90KWK2gP9+F79dyhStKqIO1Oidq2
	JFosE946Iu2yWy7jRAXLmpCf3cL3QzcU1HbaU4EoWlMK6MOevAdQktVINYwaO9X7EQhOzYV92yX
	1rA7rEzwgXEtuNp9vmgx67973mDniokhhsI0JogCKRmA9tdMRrXCBcEeLofZA8evIl6I2o3u8HZ
	TYoUT67+OTrS4FPvZn1HelDsjCZuFmmXabxfxA/Du/V3chxrfiOIeH/Sk/po=
X-Google-Smtp-Source: AGHT+IHVXO4RAN9/7Z9SLjJsYn02aSZQYS+lU4qmFjKvqvXByVPkXWX5bCNH7Uajhq9MOI+lo9gT7Q==
X-Received: by 2002:a05:6000:24c4:b0:3b7:940e:6529 with SMTP id ffacd0b85a97d-3b910fdb838mr872543f8f.10.1754951457121;
        Mon, 11 Aug 2025 15:30:57 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5853104sm271557715e9.8.2025.08.11.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:30:56 -0700 (PDT)
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
Subject: [PATCH v2 2/2] pwm: Add the S32G support in the Freescale FTM driver
Date: Tue, 12 Aug 2025 00:30:40 +0200
Message-ID: <20250811223044.3087090-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811223044.3087090-1-daniel.lezcano@linaro.org>
References: <20250811223044.3087090-1-daniel.lezcano@linaro.org>
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
suspend / resume. The fault register does not exist on the s32gx and
at resume time all the mapping is wrote back leading to a kernel
crash.

  /* restore all registers from cache */
  regcache_cache_only(fpc->regmap, false);
  regcache_sync(fpc->regmap);

The regmap callbacks 'writeable_reg()' and 'readable_reg()' will skip
the address corresponding to a register which is not present.

Tested on a s32g274-rdb2 J5 PWM pin output with signal visualization
on oscilloscope.

Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/pwm/pwm-fsl-ftm.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index c45a5fca4cbb..e0069dbdb02d 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -3,6 +3,7 @@
  *  Freescale FlexTimer Module (FTM) PWM Driver
  *
  *  Copyright 2012-2013 Freescale Semiconductor, Inc.
+ *  Copyright 2020-2025 NXP
  */
 
 #include <linux/clk.h>
@@ -31,6 +32,8 @@ enum fsl_pwm_clk {
 
 struct fsl_ftm_soc {
 	bool has_enable_bits;
+	bool has_flt_reg;
+	unsigned int npwm;
 };
 
 struct fsl_pwm_periodcfg {
@@ -386,6 +389,20 @@ static bool fsl_pwm_volatile_reg(struct device *dev, unsigned int reg)
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
+	if ((reg == FTM_FLTCTRL || reg == FTM_FLTPOL) && !fpc->soc->has_flt_reg)
+		return false;
+
+	return true;
+}
+
 static const struct regmap_config fsl_pwm_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -394,23 +411,26 @@ static const struct regmap_config fsl_pwm_regmap_config = {
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
@@ -526,15 +546,26 @@ static const struct dev_pm_ops fsl_pwm_pm_ops = {
 
 static const struct fsl_ftm_soc vf610_ftm_pwm = {
 	.has_enable_bits = false,
+	.has_flt_reg = true,
+	.npwm = 8,
 };
 
 static const struct fsl_ftm_soc imx8qm_ftm_pwm = {
 	.has_enable_bits = true,
+	.has_flt_reg = true,
+	.npwm = 8,
+};
+
+static const struct fsl_ftm_soc s32g2_ftm_pwm = {
+	.has_enable_bits = true,
+	.has_flt_reg = false,
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


