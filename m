Return-Path: <linux-pwm+bounces-3524-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6584993D3E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 05:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F271F2420F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 03:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA225779;
	Tue,  8 Oct 2024 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhL+Zehu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FB3A1B5;
	Tue,  8 Oct 2024 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356666; cv=none; b=pBe/L7OU5hy5jU60FUIrIL4F1sW2pZ+BZrhEAku6Fkur2Azx89O1ZXVzshJqFWqXsCDjyMk0uJT7/RDvxQgQHpmKH/4GWVlmHXRG5u/2tkMJCwxnO0VN8zEcAlNB4Diu5Dxxslp1fZAxYucCDP6HrwerjJAkPIu9tk0G0nd5gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356666; c=relaxed/simple;
	bh=oAzjdmauBfKU8BlumM8J3crYAKMe10uoGI7BavUCMhM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbUVMp+dUxWRBH2i+D2XKPD47CT2Ct5iTXfqc4c30oJTlBCIEYtOtCY8EfiTmeRFWMfKaGYvY5Q/k5x/G1YBFWh4jfQCeSfuCqc1W+NcMnq0JAcW/YIsebV3EL161sKYxxugtFnbbuURb5ECqrH3AZ9Ksm/X65bsXcqbptBAGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhL+Zehu; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710f388621fso3163146a34.1;
        Mon, 07 Oct 2024 20:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356663; x=1728961463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrwsSs/z/pCRHRshak8tpEDcJHcOvUffC1RAHP+5S5k=;
        b=jhL+ZehuD+OxiX6AdoM7N4dB4nYmKU/AhPPr4A1G71yDsca7BGwk1STJ//xhOXr/bA
         C5DGetk9/AQL2YV2hXn3E6DkwJlqtd8L1ZM86CUYajM5dmryN4msw7LeN7WnA2NZ6lTy
         c1d1sbVVIhW12e7LLRas48tM9W56mKRuwlCI3oSH336JAe8/bUrCQQT9juBz8zs2KvM6
         3CNkbj/RwTSmVnEzcM2MF89KRjFHCgLSKTlELcc14ZVZgmCXgUeQ4DaQR6ZUGn0mwWLL
         QjERUhFvhvcXsi/9a7zq2aVsvKhZxJbqnGhKSxxT43yq22iXljRgtRyTWPp8LINJYwG1
         viYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356663; x=1728961463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrwsSs/z/pCRHRshak8tpEDcJHcOvUffC1RAHP+5S5k=;
        b=xE5IwwqGHJJyF9dK4Pj3o1T5VQF1Yx9/HYKVVA2fxmf+HPQHFPGiiUo6imcDV8MZa/
         fQYScCF+f444npnF3zAFJYKEbYNGYtTwxq3mTyq8rqdqfmz1K512pSA1U0beBDRWM9Fm
         PC/nexPbxJvOfHL/wOZiH8D+t6+IY5e1ZVvb4UvJfd/qaaKgJvvnh16ZG+3cSsruCC57
         91Etjwm+5P5r7JJ4mwFSq91s1xpESuvLJxVVwyQOJdHs/YVfsCPYDPh0n6WBN4jmGmfQ
         0Gju6X2J4X0IgRTJ8MJYx52Qx96HPy+RydBmo7SrSBXKglwizioDjMDjOlEaOU3zJfv5
         uePA==
X-Forwarded-Encrypted: i=1; AJvYcCUAeIjl2xeZNfodXuacFkwl1sSt/VXwPsGbV4nCsIAvTap7jeDLVOXb64l5vKjgKUC5jbPVC6c8ELWe@vger.kernel.org, AJvYcCUIRRJXrn0Es+JuasQSuGF5P4wdS4Qua7ONa9DuiePBqPEgjirKSuGrfOVMFgyoYsif3eJ7+dQpKhlslYlu@vger.kernel.org, AJvYcCXdFLL/u8hTyKD+nu8Rg2d8A/noj+aagmfB2OEdbrQ3pdJGbSOmu3UYdJF5ST1SSowzGleaKuN0c1xB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqe4d3571HrtnqzVWxGx8LRFwbWBgvqs+FtVTs6/Byns+AcLCj
	gassVnT7uH8u6YW5epfSKUfw2LHWixMASqKHJwh8AulfkcK0N3Qi
X-Google-Smtp-Source: AGHT+IEb54nCKSmtX6R321kIvYFqIxBWK2RiPXmKmeYVbfI35Fr35utxmLX4AJ1AAe8oCgCz3NBYHw==
X-Received: by 2002:a05:6830:6481:b0:711:3ed:4226 with SMTP id 46e09a7af769-7154e807f0fmr10858455a34.7.1728356663389;
        Mon, 07 Oct 2024 20:04:23 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71556847306sm1763569a34.51.2024.10.07.20.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:04:22 -0700 (PDT)
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
Subject: [PATCH v3 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Date: Tue,  8 Oct 2024 11:04:14 +0800
Message-Id: <57cf7ac3b4c092df1a6962d310b6d2603ca26995.1728355974.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728355974.git.unicorn_wang@outlook.com>
References: <cover.1728355974.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add a PWM driver for PWM controller in Sophgo SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pwm/Kconfig             |  10 ++
 drivers/pwm/Makefile            |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c | 180 ++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
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
index 000000000000..198019b751ad
--- /dev/null
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -0,0 +1,180 @@
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
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#include <asm/div64.h>
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
+#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
+#define SG2042_PERIOD(chan) ((chan) * 8 + 4)
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
+static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32 period, u32 hlperiod)
+{
+	writel(period, base + SG2042_PERIOD(chan));
+	writel(hlperiod, base + SG2042_HLPERIOD(chan));
+}
+
+static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+	u32 hlperiod;
+	u32 period;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		pwm_sg2042_config(ddata->base, pwm->hwpwm, 0, 0);
+		return 0;
+	}
+
+	/*
+	 * Period of High level (duty_cycle) = HLPERIOD x Period_clk
+	 * Period of One Cycle (period) = PERIOD x Period_clk
+	 */
+	period = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
+	hlperiod = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
+
+	if (hlperiod > period) {
+		dev_err(pwmchip_parent(chip), "period < hlperiod, failed to apply current setting\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(pwmchip_parent(chip), "chan[%u]: period=%u, hlperiod=%u\n",
+		pwm->hwpwm, period, hlperiod);
+
+	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);
+
+	return 0;
+}
+
+static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+	unsigned int chan = pwm->hwpwm;
+	u32 hlperiod;
+	u32 period;
+
+	period = readl(ddata->base + SG2042_PERIOD(chan));
+	hlperiod = readl(ddata->base + SG2042_HLPERIOD(chan));
+
+	if (!period && !hlperiod)
+		state->enabled = false;
+	else
+		state->enabled = true;
+
+	state->period = DIV_ROUND_UP_ULL((u64)period * NSEC_PER_SEC, ddata->clk_rate_hz);
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)hlperiod * NSEC_PER_SEC, ddata->clk_rate_hz);
+
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
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get base clk\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
+
+	ddata->clk_rate_hz = clk_get_rate(clk);
+	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
+
+	chip->ops = &pwm_sg2042_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
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


