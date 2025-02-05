Return-Path: <linux-pwm+bounces-4768-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE1A284C9
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 08:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69253A6C7A
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC8218580;
	Wed,  5 Feb 2025 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkEvmT/Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEC227BA5;
	Wed,  5 Feb 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738887; cv=none; b=o9w43qu135f5IO6Xev4vUg36NUa7Sj7YrdJiWH3/CAoT5cSolEaeW69DbZkxC3YQ1/NGu1ZkNp1ZslhOdmPBFfOMUXlNXfnwlC1XatfZXY+jWAjNiqGQSUrEq2MGXHRsTlwhVYWd3LlfQaUwuZyCJZkhJVcAUA7BUIbzD2MX2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738887; c=relaxed/simple;
	bh=GGqBP1IfPzVWXKWgqaKxM1VSdxfOao9IJ4hydXG6cKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPNo8GeUR48lAlU+278UVDNt7wyRpGpxY/M/Rjsda025Zsv0fZs20bVJcWTpzdmpu+xiIcp2SvmChIi3wX0YSeMptfnXWf1jbfGOc/S5xzX9N/IRg1LwcXVQHHKJF12j7H4a0amhnPFdHnXSnMj7lmKEBHt2TlF2dB1gwL86Pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkEvmT/Y; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb98b3b63dso1694868b6e.1;
        Tue, 04 Feb 2025 23:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738738884; x=1739343684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwBabY2Dif2qU+HHNZ8N8GiCs/b5gFtvrv0DgcVk+kU=;
        b=UkEvmT/Y+CPT7BGATUkUFNUjGBp/xi22s1hhrx4fJK3wgpItu6CZlpUQ52hrUQnOBG
         NfPnqg4nIdpdis8d2N5wtGSBkEvRb4XrBsU6sHzVWid85woWMYfOHsNv/GUOabFi7gpl
         oCFxfLnW6jAtuVFHdr6b0OutTdHG2sjrnx6o968AaywOkv1wWPTj7uPOL4t7lJxIzA9n
         Rn0Bw4aVtVaBobcZCicFz1VtLlM6f9aEQ2KN//AZ9pkbfvDPHVT6iVcg7V2kA7ougMWN
         TallryA/xOWZF/NdRrwYV0cOnsA9nDr8QL5uJPze5Pkv640qz73LO5xmZa0YB4qemFKt
         CHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738738884; x=1739343684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwBabY2Dif2qU+HHNZ8N8GiCs/b5gFtvrv0DgcVk+kU=;
        b=uDyJuxqxCqPZAfLSHTGC542eUzrFUWlLPdCR3+r0w4S7cGp1t1Gl/qIdMOkYawgjzb
         STb13Yrqpwol8mB9eIopRJiQwOGvBNbLXLfx/gvu/byXZSzuhPUpKKZ9gp2cjK381SWn
         8jYmU0F1K3rqeHZjCXzXbQ5g4C0No55NRCBDu1Nc8AqHIDwY2qq0H1HNVXTYir9yQ1DE
         iPkg8fRGkfb2KwbxP5bh0cX3wYLTZIVllu2Rori2YArlcuL0SrSehwK036gaUKt9kws9
         7H80P7m2OmtGiCazKQJyAY6oqp/5FPwir3G/rkY4iEL3lmIlmGau2sYiSj3ZcmwK3Hii
         a6mA==
X-Forwarded-Encrypted: i=1; AJvYcCVt11k1EmeWnMu5rwbHrYAjWcVVL5XrWIaWEAvyvEl/H2kFFuHPq1Zq8Vc9Qwr4tQEFq6vSAOObhWJ4jQl1@vger.kernel.org, AJvYcCX//SxXF2Nlq393Esa0fYkDbzCPD3vB6h4O9+gZKRLWNvokSvUrhgNGXbihGzmA78dungHtBI9ZYwYA@vger.kernel.org, AJvYcCXnyukYCIg4+/oGAU+ys4bh2c0eVrSALHeqtYDjrVrPlWKnASENZlCg6V7yz97WH/k7kSbi1N+TEB07@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uy22fCi7HEtHgl0PmRKmvh7TpKtW2ySrYdVx5o9mfVefmgX9
	aZ87cp/ud8OkWveDpC7KNJV4Bxgcq6gcIx2LIg9c/WZ620sbChWR
X-Gm-Gg: ASbGncu37fvRJ8OfVrZfYaRVMQE2Im0MUZhuP6F5iUV8KT1aftGird/Ilh1DCgG9P9G
	9zhk53X2luW97qBGserPvgWAZHMfDkWQZhUfcG4K/RFMfe6rZUV9p7/ZssSayfFFuq9PT0VPeJC
	09jd5ltemUpCCvzD5tA2V10V8kA9OjNt/NrJxyn4HvXhjYTtE5dH28bQIBQahrLseqSEFNyJFSh
	wsr0Dc/6lES3vrovwj75DbimfBoh3Z8cI9iLciuV/lhv2euuCiR24z/vuVWIoWEdjaIaQfFtPVH
	dYIMb7i3lJNS1WdXtxH9Cy2QfQ==
X-Google-Smtp-Source: AGHT+IFOKv7NvEPObj+ABlljhF58GKcG3uAwtk/8J4W/YhXzERpVBCwZPgxh2nYVVtiLK17dNr+teQ==
X-Received: by 2002:a05:6808:3204:b0:3e6:5761:af3 with SMTP id 5614622812f47-3f37c10d334mr1158689b6e.9.1738738882752;
        Tue, 04 Feb 2025 23:01:22 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33367f6c6sm3441203b6e.42.2025.02.04.23.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 23:01:21 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Cc: Sean Young <sean@mess.org>
Subject: [PATCH v7 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Date: Wed,  5 Feb 2025 15:01:13 +0800
Message-Id: <ae8ea1bf0bb0a09336cd8b7f627a994630524bba.1738737617.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738737617.git.unicorn_wang@outlook.com>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add a PWM driver for PWM controller in Sophgo SG2042 SoC.

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pwm/Kconfig             |  10 ++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c | 196 ++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..ec85f3895936 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -584,6 +584,16 @@ config PWM_SL28CPLD
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sl28cpld.
 
+config PWM_SOPHGO_SG2042
+	tristate "Sophgo SG2042 PWM support"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  PWM driver for the PWM controller on Sophgo SG2042 SoC. The PWM
+	  controller supports outputing 4 channels of PWM waveforms.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm_sophgo_sg2042.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e0..539e0def3f82 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
+obj-$(CONFIG_PWM_SOPHGO_SG2042)	+= pwm-sophgo-sg2042.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
new file mode 100644
index 000000000000..ce8cf8af3402
--- /dev/null
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sophgo SG2042 PWM Controller Driver
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
+ *
+ * Limitations:
+ * - After reset, the output of the PWM channel is always high.
+ *   The value of HLPERIOD/PERIOD is 0.
+ * - When HLPERIOD or PERIOD is reconfigured, PWM will start to
+ *   output waveforms with the new configuration after completing
+ *   the running period.
+ * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
+ *   be stopped and the output is pulled to high.
+ * See the datasheet [1] for more details.
+ * [1]:https://github.com/sophgo/sophgo-doc/tree/main/SG2042/TRM
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+/*
+ * Offset RegisterName
+ * 0x0000 HLPERIOD0
+ * 0x0004 PERIOD0
+ * 0x0008 HLPERIOD1
+ * 0x000C PERIOD1
+ * 0x0010 HLPERIOD2
+ * 0x0014 PERIOD2
+ * 0x0018 HLPERIOD3
+ * 0x001C PERIOD3
+ * Four groups and every group is composed of HLPERIOD & PERIOD
+ */
+#define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
+#define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
+
+#define SG2042_PWM_CHANNELNUM	4
+
+/**
+ * struct sg2042_pwm_ddata - private driver data
+ * @base:		base address of mapped PWM registers
+ * @clk_rate_hz:	rate of base clock in HZ
+ */
+struct sg2042_pwm_ddata {
+	void __iomem *base;
+	unsigned long clk_rate_hz;
+};
+
+/*
+ * period_ticks: PERIOD
+ * hlperiod_ticks: HLPERIOD
+ */
+static void pwm_sg2042_config(struct sg2042_pwm_ddata *ddata, unsigned int chan,
+			      u32 period_ticks, u32 hlperiod_ticks)
+{
+	void __iomem *base = ddata->base;
+
+	writel(period_ticks, base + SG2042_PWM_PERIOD(chan));
+	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
+}
+
+static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+	u32 hlperiod_ticks;
+	u32 period_ticks;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		pwm_sg2042_config(ddata, pwm->hwpwm, 0, 0);
+		return 0;
+	}
+
+	/*
+	 * Duration of High level (duty_cycle) = HLPERIOD x Period_of_input_clk
+	 * Duration of One Cycle (period) = PERIOD x Period_of_input_clk
+	 */
+	period_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
+	hlperiod_ticks = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
+
+	dev_dbg(pwmchip_parent(chip), "chan[%u]: PERIOD=%u, HLPERIOD=%u\n",
+		pwm->hwpwm, period_ticks, hlperiod_ticks);
+
+	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
+
+	return 0;
+}
+
+static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+	unsigned int chan = pwm->hwpwm;
+	u32 hlperiod_ticks;
+	u32 period_ticks;
+
+	period_ticks = readl(ddata->base + SG2042_PWM_PERIOD(chan));
+	hlperiod_ticks = readl(ddata->base + SG2042_PWM_HLPERIOD(chan));
+
+	if (!period_ticks) {
+		state->enabled = false;
+		return 0;
+	}
+
+	if (hlperiod_ticks > period_ticks)
+		hlperiod_ticks = period_ticks;
+
+	state->enabled = true;
+	state->period = DIV_ROUND_UP_ULL((u64)period_ticks * NSEC_PER_SEC, ddata->clk_rate_hz);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)hlperiod_ticks * NSEC_PER_SEC, ddata->clk_rate_hz);
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_sg2042_ops = {
+	.apply = pwm_sg2042_apply,
+	.get_state = pwm_sg2042_get_state,
+};
+
+static const struct of_device_id sg2042_pwm_ids[] = {
+	{ .compatible = "sophgo,sg2042-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
+
+static int pwm_sg2042_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sg2042_pwm_ddata *ddata;
+	struct reset_control *rst;
+	struct pwm_chip *chip;
+	struct clk *clk;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ddata = pwmchip_get_drvdata(chip);
+
+	ddata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->base))
+		return PTR_ERR(ddata->base);
+
+	clk = devm_clk_get_enabled(dev, "apb");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get base clk\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get exclusive rate\n");
+
+	ddata->clk_rate_hz = clk_get_rate(clk);
+	/* period = PERIOD * NSEC_PER_SEC / clk_rate_hz */
+	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
+
+	rst = devm_reset_control_get_optional_shared_deasserted(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
+
+	chip->ops = &pwm_sg2042_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0) {
+		reset_control_assert(rst);
+		return dev_err_probe(dev, ret, "Failed to register PWM chip\n");
+	}
+
+	return 0;
+}
+
+static struct platform_driver pwm_sg2042_driver = {
+	.driver	= {
+		.name = "sg2042-pwm",
+		.of_match_table = sg2042_pwm_ids,
+	},
+	.probe = pwm_sg2042_probe,
+};
+module_platform_driver(pwm_sg2042_driver);
+
+MODULE_AUTHOR("Chen Wang");
+MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


