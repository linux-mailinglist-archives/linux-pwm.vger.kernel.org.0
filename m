Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF81B51C
	for <lists+linux-pwm@lfdr.de>; Mon, 13 May 2019 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfEMLhF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 May 2019 07:37:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfEMLgz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 May 2019 07:36:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so6340997pls.12
        for <linux-pwm@vger.kernel.org>; Mon, 13 May 2019 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AaaDENnh8+JO2RPDpSn3qV7MLgW0nZnP7gISsk3svnE=;
        b=kjSuubivvnmBWuD7lJSN7JpYdB6wXOH8Wjxq4EIaRYYtppuWsAif4vQZA5+21wjPui
         Nib1JGryFRl/Lr2JqWV8nqVOrv12H+mbv0pdzgg70WRVNo2qP9FKDj+YEPtpDJAMffgM
         yFL0+8CeH7ondq3EmklsKvoIThOuuB2RoSTN6f5ToZ9TmmQ+U+dDacHhnYQSKT/OR/p2
         edSzAiC3qHRIKWIe6siMJUO9YmaO55UnvIiHATVotIOoNF4YlYrIkyL7dICcZ6q4OV18
         PkQm2XLsS7zy/0OUH1YG+Fko3DuzQ/8Jw+9o5ocLCvRgQF46jZ0z2LkSG4X9NihLBJyI
         Si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AaaDENnh8+JO2RPDpSn3qV7MLgW0nZnP7gISsk3svnE=;
        b=mNiDEJwLfT7TU2ia9s/WtxBdRPyAQdXIBtsGCU+2iQvNcYEzOZPqn5ySWzW97pqnJc
         DkbRUMwGnJf4bzfl8e2fuziHtPD7gmw7NMOkw3zcOsiSVyIj5kF+aDuqjpQ8l6+Zo58S
         7VTD4o3jZkn360S38GhmLA/c50k3j+Hr2/k+1R82AHcZ6Z3HRv/uK/a1buxY40/QtP3F
         xbCjWQF9wjFi/5UDBv/I54Y761/xaKVYhTchNmFoJ3aT6iGrkTymwEh8DlZzMyXFPy3E
         CaaO/madMMbqlfSF4iCYlpTmwU3cZ9fkVUbOdgX8y723CQJ3ccvxdH1ykWa7cG8adR3k
         lmZA==
X-Gm-Message-State: APjAAAUbp031sbtJ1yjrGyheCWk/RJnVvk03lpnCqoIPzUW5KeGA9B+J
        7WlvnPuasycxBWJKkM8yYOxyrJEeLNI=
X-Google-Smtp-Source: APXvYqxpO8/kCOGBde9z2kCMGeMeKgU+EnaxLdZR4pJjWTysVvwuaVA1SI8wfcJLqrcZ8zDORFLm6A==
X-Received: by 2002:a17:902:e30b:: with SMTP id cg11mr29341050plb.3.1557747413713;
        Mon, 13 May 2019 04:36:53 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id d15sm44657128pfm.186.2019.05.13.04.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 04:36:52 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        thierry.reding@gmail.com
Cc:     palmer@sifive.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        paul.walmsley@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v12 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date:   Mon, 13 May 2019 17:06:20 +0530
Message-Id: <1557747380-12257-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557747380-12257-1-git-send-email-yash.shah@sifive.com>
References: <1557747380-12257-1-git-send-email-yash.shah@sifive.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Various fixes and code cleanup]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sifive.c | 338 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)
 create mode 100644 drivers/pwm/pwm-sifive.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 54f8238..95c1181 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -389,6 +389,17 @@ config PWM_SAMSUNG
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-samsung.
 
+config PWM_SIFIVE
+	tristate "SiFive PWM support"
+	depends on OF
+	depends on COMMON_CLK
+	depends on RISCV || COMPILE_TEST
+	help
+	  Generic PWM framework driver for SiFive SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sifive.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 448825e..0da3e99 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
+obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
new file mode 100644
index 0000000..1921e6ea
--- /dev/null
+++ b/drivers/pwm/pwm-sifive.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2018 SiFive
+ * For SiFive's PWM IP block documentation please refer Chapter 14 of
+ * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we cannot prevent in
+ *   software that the output might produce a period with mixed
+ *   settings (new period length and old duty cycle).
+ * - The hardware cannot generate a 100% duty cycle.
+ * - The hardware generates only inverted output.
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/bitfield.h>
+
+/* Register offsets */
+#define PWM_SIFIVE_PWMCFG		0x0
+#define PWM_SIFIVE_PWMCOUNT		0x8
+#define PWM_SIFIVE_PWMS			0x10
+#define PWM_SIFIVE_PWMCMP0		0x20
+
+/* PWMCFG fields */
+#define PWM_SIFIVE_PWMCFG_SCALE		GENMASK(3, 0)
+#define PWM_SIFIVE_PWMCFG_STICKY	BIT(8)
+#define PWM_SIFIVE_PWMCFG_ZERO_CMP	BIT(9)
+#define PWM_SIFIVE_PWMCFG_DEGLITCH	BIT(10)
+#define PWM_SIFIVE_PWMCFG_EN_ALWAYS	BIT(12)
+#define PWM_SIFIVE_PWMCFG_EN_ONCE	BIT(13)
+#define PWM_SIFIVE_PWMCFG_CENTER	BIT(16)
+#define PWM_SIFIVE_PWMCFG_GANG		BIT(24)
+#define PWM_SIFIVE_PWMCFG_IP		BIT(28)
+
+/* PWM_SIFIVE_SIZE_PWMCMP is used to calculate offset for pwmcmpX registers */
+#define PWM_SIFIVE_SIZE_PWMCMP		4
+#define PWM_SIFIVE_CMPWIDTH		16
+#define PWM_SIFIVE_DEFAULT_PERIOD	10000000
+
+struct pwm_sifive_ddata {
+	struct pwm_chip	chip;
+	struct mutex lock; /* lock to protect user_count */
+	struct notifier_block notifier;
+	struct clk *clk;
+	void __iomem *regs;
+	unsigned int real_period;
+	unsigned int approx_period;
+	int user_count;
+};
+
+static inline
+struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *c)
+{
+	return container_of(c, struct pwm_sifive_ddata, chip);
+}
+
+static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
+
+	mutex_lock(&ddata->lock);
+	ddata->user_count++;
+	mutex_unlock(&ddata->lock);
+
+	return 0;
+}
+
+static void pwm_sifive_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
+
+	mutex_lock(&ddata->lock);
+	ddata->user_count--;
+	mutex_unlock(&ddata->lock);
+}
+
+static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
+				    unsigned long rate)
+{
+	unsigned long long num;
+	unsigned long scale_pow;
+	int scale;
+	u32 val;
+	/*
+	 * The PWM unit is used with pwmzerocmp=0, so the only way to modify the
+	 * period length is using pwmscale which provides the number of bits the
+	 * counter is shifted before being feed to the comparators. A period
+	 * lasts (1 << (PWM_SIFIVE_CMPWIDTH + pwmscale)) clock ticks.
+	 * (1 << (PWM_SIFIVE_CMPWIDTH + scale)) * 10^9/rate = period
+	 */
+	scale_pow = div64_ul(ddata->approx_period * (u64)rate, NSEC_PER_SEC);
+	scale = clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0xf);
+
+	val = PWM_SIFIVE_PWMCFG_EN_ALWAYS |
+	      FIELD_PREP(PWM_SIFIVE_PWMCFG_SCALE, scale);
+	writel(val, ddata->regs + PWM_SIFIVE_PWMCFG);
+
+	/* As scale <= 15 the shift operation cannot overflow. */
+	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
+	ddata->real_period = div64_ul(num, rate);
+	dev_dbg(ddata->chip.dev,
+		"New real_period = %u ns\n", ddata->real_period);
+}
+
+static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
+	u32 duty, val;
+
+	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP0 +
+		     pwm->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
+
+	state->enabled = duty > 0;
+
+	val = readl(ddata->regs + PWM_SIFIVE_PWMCFG);
+	if (!(val & PWM_SIFIVE_PWMCFG_EN_ALWAYS))
+		state->enabled = false;
+
+	state->period = ddata->real_period;
+	state->duty_cycle =
+		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
+	state->polarity = PWM_POLARITY_INVERSED;
+}
+
+static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
+{
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
+	int ret;
+
+	if (enable) {
+		ret = clk_enable(ddata->clk);
+		if (ret) {
+			dev_err(ddata->chip.dev, "Enable clk failed\n");
+			return ret;
+		}
+	}
+
+	if (!enable)
+		clk_disable(ddata->clk);
+
+	return 0;
+}
+
+static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
+{
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
+	struct pwm_state cur_state;
+	unsigned int duty_cycle;
+	unsigned long long num;
+	bool enabled;
+	int ret = 0;
+	u32 frac;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	ret = clk_enable(ddata->clk);
+	if (ret) {
+		dev_err(ddata->chip.dev, "Enable clk failed\n");
+		return ret;
+	}
+
+	mutex_lock(&ddata->lock);
+	cur_state = pwm->state;
+	enabled = cur_state.enabled;
+
+	duty_cycle = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycle = 0;
+
+	/*
+	 * The problem of output producing mixed setting as mentioned at top,
+	 * occurs here. To minimize the window for this problem, we are
+	 * calculating the register values first and then writing them
+	 * consecutively
+	 */
+	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
+	frac = DIV_ROUND_CLOSEST_ULL(num, state->period);
+	/* The hardware cannot generate a 100% duty cycle */
+	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+
+	if (state->period != ddata->approx_period) {
+		if (ddata->user_count != 1) {
+			ret = -EBUSY;
+			goto exit;
+		}
+		ddata->approx_period = state->period;
+		pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
+	}
+
+	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP0 +
+	       pwm->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
+
+	if (state->enabled != enabled)
+		pwm_sifive_enable(chip, state->enabled);
+
+exit:
+	clk_disable(ddata->clk);
+	mutex_unlock(&ddata->lock);
+	return ret;
+}
+
+static const struct pwm_ops pwm_sifive_ops = {
+	.request = pwm_sifive_request,
+	.free = pwm_sifive_free,
+	.get_state = pwm_sifive_get_state,
+	.apply = pwm_sifive_apply,
+	.owner = THIS_MODULE,
+};
+
+static int pwm_sifive_clock_notifier(struct notifier_block *nb,
+				     unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct pwm_sifive_ddata *ddata =
+		container_of(nb, struct pwm_sifive_ddata, notifier);
+
+	if (event == POST_RATE_CHANGE)
+		pwm_sifive_update_clock(ddata, ndata->new_rate);
+
+	return NOTIFY_OK;
+}
+
+static int pwm_sifive_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_sifive_ddata *ddata;
+	struct pwm_chip *chip;
+	struct resource *res;
+	int ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	mutex_init(&ddata->lock);
+	chip = &ddata->chip;
+	chip->dev = dev;
+	chip->ops = &pwm_sifive_ops;
+	chip->of_xlate = of_pwm_xlate_with_flags;
+	chip->of_pwm_n_cells = 3;
+	chip->base = -1;
+	chip->npwm = 4;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ddata->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ddata->regs)) {
+		dev_err(dev, "Unable to map IO resources\n");
+		return PTR_ERR(ddata->regs);
+	}
+
+	ddata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ddata->clk)) {
+		if (PTR_ERR(ddata->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Unable to find controller clock\n");
+		return PTR_ERR(ddata->clk);
+	}
+
+	ret = clk_prepare_enable(ddata->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock for pwm: %d\n", ret);
+		return ret;
+	}
+
+	/* Watch for changes to underlying clock frequency */
+	ddata->notifier.notifier_call = pwm_sifive_clock_notifier;
+	ret = clk_notifier_register(ddata->clk, &ddata->notifier);
+	if (ret) {
+		dev_err(dev, "failed to register clock notifier: %d\n", ret);
+		goto disable_clk;
+	}
+
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "cannot register PWM: %d\n", ret);
+		goto unregister_clk;
+	}
+
+	platform_set_drvdata(pdev, ddata);
+	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
+
+	return 0;
+
+unregister_clk:
+	clk_notifier_unregister(ddata->clk, &ddata->notifier);
+disable_clk:
+	clk_disable_unprepare(ddata->clk);
+
+	return ret;
+}
+
+static int pwm_sifive_remove(struct platform_device *dev)
+{
+	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
+	bool is_enabled = false;
+	struct pwm_device *pwm;
+	int ret, ch;
+
+	ret = pwmchip_remove(&ddata->chip);
+	clk_notifier_unregister(ddata->clk, &ddata->notifier);
+
+	for (ch = 0; ch < ddata->chip.npwm; ch++) {
+		pwm = &ddata->chip.pwms[ch];
+		if (pwm->state.enabled) {
+			is_enabled = true;
+			break;
+		}
+	}
+	if (is_enabled)
+		clk_disable(ddata->clk);
+	clk_disable_unprepare(ddata->clk);
+	return ret;
+}
+
+static const struct of_device_id pwm_sifive_of_match[] = {
+	{ .compatible = "sifive,pwm0" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
+
+static struct platform_driver pwm_sifive_driver = {
+	.probe = pwm_sifive_probe,
+	.remove = pwm_sifive_remove,
+	.driver = {
+		.name = "pwm-sifive",
+		.of_match_table = pwm_sifive_of_match,
+	},
+};
+module_platform_driver(pwm_sifive_driver);
+
+MODULE_DESCRIPTION("SiFive PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

