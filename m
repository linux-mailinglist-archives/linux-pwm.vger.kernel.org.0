Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3819485D9D
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 11:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfHHJAD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Aug 2019 05:00:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46684 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbfHHJAC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 05:00:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so20594128pfa.13
        for <linux-pwm@vger.kernel.org>; Thu, 08 Aug 2019 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6dKhUXVTfnG7RXmOsA61bvBMaPJOZFEtKXDu0fw21FY=;
        b=tRe8RBUzPa6IhH0+hSbf+GiaQP8EWcA12uBnSdGylW0vp8+K+fS+rG9sagRWMxWLuQ
         du7tBQKujF7yQ6BYxx9HbxvRbbweqp2/mvVUQlolCPSVZxviTmyXbpi5FFaiu/U/nkyq
         15ncGQFdzBnExnnogh8f2nC0NhGN7sX4SJSQbqwYqc9R97J0K5LkINMXr9OFDbTETtv0
         r6zvuTQAasb+zyYcUf5SMTq3r7+6WiJAEla4RAgsVJC40ZHA7kUqjnmr6sd2/hUSwzbZ
         0yjWhthsYA0rlHtvSBwmemaiSGoEDyCSO9lZhkqpUHbBm0cSp6/M4NickXIElyNnSsHY
         kLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6dKhUXVTfnG7RXmOsA61bvBMaPJOZFEtKXDu0fw21FY=;
        b=a4MDfG9pZ0fvmsi3RalTHNLHZdmcvJDMwkeEujyU+XzA/Ij1wij3mFg1bPc207mmIL
         id4Rwk54+ytNTpk/Mh2kD6VnmdkkhoKLjYCq4xzq3pB/kawl/jp2eHpHGvrxjkuIUCZd
         4rKUM6NszK1fRLMbL3Wnf5fkJngW03QA2O9dqEJhYy/n6rlSKw2x8KFOelCH6XVYN+a5
         /F2uBpIjjJIPQRKIYG22uiEjYIHAM/3RuqslPxANVV0+KMN3ZkIFN0WVhMYsGHsFctng
         1UxYdHCuMN6ZiXdmp5qAAwqnTrE1QjzIae1+VNGY70Mt2kLozB1u2HYWOvCx4Y0RcmfV
         c+pw==
X-Gm-Message-State: APjAAAU5PbevhMWdtiQVYHiRe0FaOHBPOGVqsERumiu72rXVWQC8yzmB
        CHqui5JL8YANFrvvJRdO0K+BYw==
X-Google-Smtp-Source: APXvYqxOXUuSS0vu4mv/BCYVbC/szFA2sxTGC0MCJAGnxsus2pV+bp8RSk1psp6826oFAISYpub9eg==
X-Received: by 2002:aa7:8f24:: with SMTP id y4mr14159826pfr.36.1565254801990;
        Thu, 08 Aug 2019 02:00:01 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b24sm21716254pgw.66.2019.08.08.01.59.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 02:00:01 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     thierry.reding@gmail.com, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
Date:   Thu,  8 Aug 2019 16:59:39 +0800
Message-Id: <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
In-Reply-To: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Neo Hou <neo.hou@unisoc.com>

This patch adds the Spreadtrum PWM support, which provides maximum 4
channels.

Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Co-developed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/pwm/Kconfig    |   10 ++
 drivers/pwm/Makefile   |    1 +
 drivers/pwm/pwm-sprd.c |  311 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 drivers/pwm/pwm-sprd.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a7e5751..4963b4d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -423,6 +423,16 @@ config PWM_SPEAR
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-spear.
 
+config PWM_SPRD
+	tristate "Spreadtrum PWM support"
+	depends on ARCH_SPRD || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the PWM controller on
+	  Spreadtrum SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sprd.
+
 config PWM_STI
 	tristate "STiH4xx PWM support"
 	depends on ARCH_STI
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 76b555b..26326ad 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
+obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
new file mode 100644
index 0000000..f6fc793
--- /dev/null
+++ b/drivers/pwm/pwm-sprd.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Spreadtrum Communications Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define SPRD_PWM_PRESCALE	0x0
+#define SPRD_PWM_MOD		0x4
+#define SPRD_PWM_DUTY		0x8
+#define SPRD_PWM_DIV		0xc
+#define SPRD_PWM_PAT_LOW	0x10
+#define SPRD_PWM_PAT_HIGH	0x14
+#define SPRD_PWM_ENABLE		0x18
+
+#define SPRD_PWM_MOD_MAX	GENMASK(7, 0)
+#define SPRD_PWM_REG_MSK	GENMASK(15, 0)
+#define SPRD_PWM_ENABLE_BIT	BIT(0)
+
+#define SPRD_PWM_NUM		4
+#define SPRD_PWM_REGS_SHIFT	5
+#define SPRD_PWM_NUM_CLKS	2
+#define SPRD_PWM_DEFAULT_CLK	26000000UL
+
+struct sprd_pwm_chn {
+	struct clk_bulk_data clks[SPRD_PWM_NUM_CLKS];
+	unsigned long clk_rate;
+	bool clk_enabled;
+};
+
+struct sprd_pwm_chip {
+	void __iomem *base;
+	struct device *dev;
+	struct pwm_chip chip;
+	int num_pwms;
+	struct sprd_pwm_chn chn[SPRD_PWM_NUM];
+};
+
+/* list of clocks required by PWM channels */
+static const char * const sprd_pwm_clks[] = {
+	"enable0", "pwm0",
+	"enable1", "pwm1",
+	"enable2", "pwm2",
+	"enable3", "pwm3",
+};
+
+static u32 sprd_pwm_read(struct sprd_pwm_chip *chip, u32 num, u32 reg)
+{
+	u32 offset = reg + (num << SPRD_PWM_REGS_SHIFT);
+
+	return readl_relaxed(chip->base + offset);
+}
+
+static void sprd_pwm_write(struct sprd_pwm_chip *chip, u32 num,
+			   u32 reg, u32 val)
+{
+	u32 offset = reg + (num << SPRD_PWM_REGS_SHIFT);
+
+	writel_relaxed(val, chip->base + offset);
+}
+
+static int sprd_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			   int duty_ns, int period_ns)
+{
+	struct sprd_pwm_chip *spc =
+		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
+	u64 div, tmp;
+	u32 prescale, duty;
+	int ret;
+
+	/*
+	 * NOTE: the clocks to PWM channel has to be enabled first before
+	 * writing to the registers.
+	 */
+	if (!chn->clk_enabled) {
+		ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
+		if (ret) {
+			dev_err(spc->dev, "failed to enable pwm%u clock\n",
+				pwm->hwpwm);
+			return ret;
+		}
+
+		chn->clk_enabled = true;
+	}
+
+	duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
+
+	/*
+	 * According to the datasheet, the period_ns calculation formula
+	 * should be:
+	 * period_ns = 10^9 * (prescale + 1) * mod / clk_rate
+	 *
+	 * Then we can get the prescale formula:
+	 * prescale = (period_ns * clk_rate) / (10^9 * mod) -1
+	 */
+	tmp = chn->clk_rate * period_ns;
+	div = 1000000000ULL * SPRD_PWM_MOD_MAX;
+	prescale = div64_u64(tmp, div) - 1;
+
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_LOW, SPRD_PWM_REG_MSK);
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_HIGH, SPRD_PWM_REG_MSK);
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
+
+	return 0;
+}
+
+static int sprd_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sprd_pwm_chip *spc =
+		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
+	int ret;
+
+	if (!chn->clk_enabled) {
+		ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
+		if (ret) {
+			dev_err(spc->dev, "failed to enable pwm%u clocks\n",
+				pwm->hwpwm);
+			return ret;
+		}
+
+		chn->clk_enabled = true;
+	}
+
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
+
+	return 0;
+}
+
+static void sprd_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sprd_pwm_chip *spc =
+		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
+
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 0);
+
+	if (chn->clk_enabled) {
+		clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
+		chn->clk_enabled = false;
+	}
+}
+
+static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct sprd_pwm_chip *spc =
+		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
+	u32 enabled, duty, prescale;
+	u64 tmp;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
+	if (ret) {
+		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
+			pwm->hwpwm);
+		return;
+	}
+
+	chn->clk_enabled = true;
+
+	duty = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & SPRD_PWM_REG_MSK;
+	prescale = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE) & SPRD_PWM_REG_MSK;
+	enabled = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE) & SPRD_PWM_ENABLE_BIT;
+
+	/*
+	 * According to the datasheet, the period_ns and duty_ns calculation
+	 * formula should be:
+	 * period_ns = 10^9 * (prescale + 1) * mod / clk_rate
+	 * duty_ns = 10^9 * (prescale + 1) * duty / clk_rate
+	 */
+	tmp = (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX;
+	state->period = div64_u64(tmp, chn->clk_rate);
+
+	tmp = (prescale + 1) * 1000000000ULL * duty;
+	state->duty_cycle = div64_u64(tmp, chn->clk_rate);
+
+	state->enabled = !!enabled;
+
+	/* Disable PWM clocks if the PWM channel is not in enable state. */
+	if (!enabled) {
+		clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
+		chn->clk_enabled = false;
+	}
+}
+
+static const struct pwm_ops sprd_pwm_ops = {
+	.config = sprd_pwm_config,
+	.enable = sprd_pwm_enable,
+	.disable = sprd_pwm_disable,
+	.get_state = sprd_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
+{
+	struct clk *clk_parent, *clk_pwm;
+	int ret, i, clk_index = 0;
+
+	clk_parent = devm_clk_get(spc->dev, "source");
+	if (IS_ERR(clk_parent)) {
+		dev_err(spc->dev, "failed to get source clock\n");
+		return PTR_ERR(clk_parent);
+	}
+
+	for (i = 0; i < SPRD_PWM_NUM; i++) {
+		struct sprd_pwm_chn *chn = &spc->chn[i];
+		int j;
+
+		for (j = 0; j < SPRD_PWM_NUM_CLKS; ++j)
+			chn->clks[j].id = sprd_pwm_clks[clk_index++];
+
+		ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_NUM_CLKS, chn->clks);
+		if (ret) {
+			if (ret == -ENOENT)
+				break;
+
+			dev_err(spc->dev, "failed to get channel clocks\n");
+			return ret;
+		}
+
+		clk_pwm = chn->clks[1].clk;
+		if (!clk_set_parent(clk_pwm, clk_parent))
+			chn->clk_rate = clk_get_rate(clk_pwm);
+		else
+			chn->clk_rate = SPRD_PWM_DEFAULT_CLK;
+	}
+
+	if (!i) {
+		dev_err(spc->dev, "no availbale PWM channels\n");
+		return -EINVAL;
+	}
+
+	spc->num_pwms = i;
+
+	return 0;
+}
+
+static int sprd_pwm_probe(struct platform_device *pdev)
+{
+	struct sprd_pwm_chip *spc;
+	int ret;
+
+	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
+	if (!spc)
+		return -ENOMEM;
+
+	spc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(spc->base))
+		return PTR_ERR(spc->base);
+
+	spc->dev = &pdev->dev;
+	ret = sprd_pwm_clk_init(spc);
+	if (ret)
+		return ret;
+
+	spc->chip.dev = &pdev->dev;
+	spc->chip.ops = &sprd_pwm_ops;
+	spc->chip.base = -1;
+	spc->chip.npwm = spc->num_pwms;
+
+	ret = pwmchip_add(&spc->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add PWM chip\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, spc);
+	return 0;
+}
+
+static int sprd_pwm_remove(struct platform_device *pdev)
+{
+	struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < spc->num_pwms; i++)
+		pwm_disable(&spc->chip.pwms[i]);
+
+	return pwmchip_remove(&spc->chip);
+}
+
+static const struct of_device_id sprd_pwm_of_match[] = {
+	{ .compatible = "sprd,ums512-pwm", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sprd_pwm_of_match);
+
+static struct platform_driver sprd_pwm_driver = {
+	.driver = {
+		.name = "sprd-pwm",
+		.of_match_table = sprd_pwm_of_match,
+	},
+	.probe = sprd_pwm_probe,
+	.remove = sprd_pwm_remove,
+};
+
+module_platform_driver(sprd_pwm_driver);
+
+MODULE_DESCRIPTION("Spreadtrum PWM Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

