Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA158D36B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfHNMql (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 08:46:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46862 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfHNMql (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 08:46:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so5229675pfc.13
        for <linux-pwm@vger.kernel.org>; Wed, 14 Aug 2019 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=re458ShbrwuSGSh01ZoEgx1slPI0WS8Ndw7LUdP3ms8=;
        b=cE8gIKKmea8mwqzdi0QNDdmRY+JF46d/Z1ayVZ2KkRX+fRU0BVjn0PXT1dFlRMnbYx
         3XObdwxIGhDZWsKgn1CAKex/3NPeZrlu36WYqoP98Lx9nctiCTlBdMN1ws9Njzw+TGZX
         JpSUdSk9eloeGB/dqKsez7kEyUjviE8Wa0MeM9jPswpkV58AY8p8ZV6OJWkRf/kGOIhg
         MJWPnEK08OVeRMu+CPU0/VoR7fBB6InzfS4H3Dls/+EWx9VjOaVswZFSAQpngZRqbXIU
         bYrCezeSj1G4E3vpUqPfpMh8CfJpG+GS1eW+UIwl2HA33MyJoIMUQ/7/wd5kJc4hgGgp
         iU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=re458ShbrwuSGSh01ZoEgx1slPI0WS8Ndw7LUdP3ms8=;
        b=Yam2UvtDMz+xLG2nPD+lzilQt0ut/fZ+aKBiscoTmcXQfyBlh9o4U7Kr8HfiZR5QLA
         M/IzkmnqU5sCyvy3BnlTw6y18uQ/5euL7bA2MEol6Wt2TXmEO22JBDR9ekOc8ZiPG0ED
         fOVZ3dlqrinFyxvf79SbCPqsaz+ktRa5QknKbOxOIUmN6bFa3QQxZ0MHcbEY1ETVnP4O
         aSthWBaZE9MO2zIu3t1NsZCla8sMNElgiHupFGfVWtYNEIrtu5m0V1HKsUggJshqy47F
         T3Pw3v1S58UuS5loeH7zWIZeX8aM794v94w/559OVvNJO10LpmLexuFEAMmYhh+tL+Ca
         s5gA==
X-Gm-Message-State: APjAAAWz6Azh+ewCRfY4Wd5gqaxzoCP+9/XxN0UCLj9sAxDICsgMHwvg
        ZVEqbGMV4vbTtNAFTFLq51T1nw==
X-Google-Smtp-Source: APXvYqx/bvNYtZ9uJq2lZcpbpk/5GvZWot3NVRXogjVbDXHxM1/hoKHHMSttpZPktAMPYWYyJYuBrw==
X-Received: by 2002:a62:cec4:: with SMTP id y187mr45957722pfg.84.1565786800131;
        Wed, 14 Aug 2019 05:46:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e5sm40753099pgt.91.2019.08.14.05.46.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 05:46:39 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     thierry.reding@gmail.com, robh+dt@kernel.org
Cc:     u.kleine-koenig@pengutronix.de, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
Date:   Wed, 14 Aug 2019 20:46:11 +0800
Message-Id: <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
In-Reply-To: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds the Spreadtrum PWM support, which provides maximum 4
channels.

Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v2:
 - Optimize some macors' name.
 - Improve some comments.
 - Optimize the calculation of prescale.
 - Do not print error log if error numeber is EPROBE_DEFER.
 - Return -ENODEV if no available PWM channels.
 - Simplify the logics in sprd_pwm_clk_init().
 - Remove disabling PWM clocks in sprd_pwm_remove().
 - Remove pwm_get_state().

Changes from v1:
 - Add depending on HAS_IOMEM.
 - Rename parameters' names.
 - Implement .apply() instead of .config(), .enable() and .disable().
 - Use NSEC_PER_SEC instead of 1000000000ULL.
 - Add some comments to make code more readable.
 - Remove some redundant operation.
 - Use standard clock properties to set clock parent.
 - Other coding style optimization.
---
 drivers/pwm/Kconfig    |   11 ++
 drivers/pwm/Makefile   |    1 +
 drivers/pwm/pwm-sprd.c |  309 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/pwm/pwm-sprd.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a7e5751..31dfc88 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -423,6 +423,17 @@ config PWM_SPEAR
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-spear.
 
+config PWM_SPRD
+	tristate "Spreadtrum PWM support"
+	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HAS_IOMEM
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
index 0000000..68c2d9f
--- /dev/null
+++ b/drivers/pwm/pwm-sprd.c
@@ -0,0 +1,309 @@
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
+#define SPRD_PWM_ENABLE		0x18
+
+#define SPRD_PWM_MOD_MAX	GENMASK(7, 0)
+#define SPRD_PWM_DUTY_MSK	GENMASK(15, 0)
+#define SPRD_PWM_PRESCALE_MSK	GENMASK(7, 0)
+#define SPRD_PWM_ENABLE_BIT	BIT(0)
+
+#define SPRD_PWM_CHN_NUM	4
+#define SPRD_PWM_REGS_SHIFT	5
+#define SPRD_PWM_CHN_CLKS_NUM	2
+#define SPRD_PWM_CHN_OUTPUT_CLK	1
+
+struct sprd_pwm_chn {
+	struct clk_bulk_data clks[SPRD_PWM_CHN_CLKS_NUM];
+	u32 clk_rate;
+};
+
+struct sprd_pwm_chip {
+	void __iomem *base;
+	struct device *dev;
+	struct pwm_chip chip;
+	int num_pwms;
+	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
+};
+
+/*
+ * The list of clocks required by PWM channels, and each channel has 2 clocks:
+ * enable clock and pwm clock.
+ */
+static const char * const sprd_pwm_clks[] = {
+	"enable0", "pwm0",
+	"enable1", "pwm1",
+	"enable2", "pwm2",
+	"enable3", "pwm3",
+};
+
+static u32 sprd_pwm_read(struct sprd_pwm_chip *spc, u32 hwid, u32 reg)
+{
+	u32 offset = reg + (hwid << SPRD_PWM_REGS_SHIFT);
+
+	return readl_relaxed(spc->base + offset);
+}
+
+static void sprd_pwm_write(struct sprd_pwm_chip *spc, u32 hwid,
+			   u32 reg, u32 val)
+{
+	u32 offset = reg + (hwid << SPRD_PWM_REGS_SHIFT);
+
+	writel_relaxed(val, spc->base + offset);
+}
+
+static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct sprd_pwm_chip *spc =
+		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
+	u32 val, duty, prescale;
+	u64 tmp;
+	int ret;
+
+	/*
+	 * The clocks to PWM channel has to be enabled first before
+	 * reading to the registers.
+	 */
+	ret = clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
+	if (ret) {
+		dev_err(spc->dev, "failed to enable pwm%u clocks\n",
+			pwm->hwpwm);
+		return;
+	}
+
+	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE);
+	if (val & SPRD_PWM_ENABLE_BIT)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	/*
+	 * The hardware provides a counter that is feed by the source clock.
+	 * The period length is (PRESCALE + 1) * MOD counter steps.
+	 * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
+	 * Thus the period_ns and duty_ns calculation formula should be:
+	 * period_ns = NSEC_PER_SEC * (prescale + 1) * mod / clk_rate
+	 * duty_ns = NSEC_PER_SEC * (prescale + 1) * duty / clk_rate
+	 */
+	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
+	prescale = val & SPRD_PWM_PRESCALE_MSK;
+	tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
+
+	val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
+	duty = val & SPRD_PWM_DUTY_MSK;
+	tmp = (prescale + 1) * NSEC_PER_SEC * duty;
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
+
+	/* Disable PWM clocks if the PWM channel is not in enable state. */
+	if (!state->enabled)
+		clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
+}
+
+static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
+			   int duty_ns, int period_ns)
+{
+	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
+	u32 prescale, duty;
+	u64 tmp;
+
+	/*
+	 * The hardware provides a counter that is feed by the source clock.
+	 * The period length is (PRESCALE + 1) * MOD counter steps.
+	 * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
+	 *
+	 * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.
+	 * The value for PRESCALE is selected such that the resulting period
+	 * gets the maximal length not bigger than the requested one with the
+	 * given settings (MOD = SPRD_PWM_MOD_MAX and input clock).
+	 */
+	duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
+
+	tmp = (u64)chn->clk_rate * period_ns;
+	do_div(tmp, NSEC_PER_SEC);
+	prescale = DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
+	if (prescale > SPRD_PWM_PRESCALE_MSK)
+		prescale = SPRD_PWM_PRESCALE_MSK;
+
+	/*
+	 * Note: Writing DUTY triggers the hardware to actually apply the
+	 * values written to MOD and DUTY to the output, so must keep writing
+	 * DUTY last.
+	 *
+	 * The hardware can ensures that current running period is completed
+	 * before changing a new configuration to avoid mixed settings.
+	 */
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
+	sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
+
+	return 0;
+}
+
+static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  struct pwm_state *state)
+{
+	struct sprd_pwm_chip *spc =
+		container_of(chip, struct sprd_pwm_chip, chip);
+	struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
+	struct pwm_state *cstate = &pwm->state;
+	int ret;
+
+	if (state->enabled) {
+		if (!cstate->enabled) {
+			/*
+			 * The clocks to PWM channel has to be enabled first
+			 * before writing to the registers.
+			 */
+			ret = clk_bulk_prepare_enable(SPRD_PWM_CHN_CLKS_NUM,
+						      chn->clks);
+			if (ret) {
+				dev_err(spc->dev,
+					"failed to enable pwm%u clocks\n",
+					pwm->hwpwm);
+				return ret;
+			}
+		}
+
+		if (state->period != cstate->period ||
+		    state->duty_cycle != cstate->duty_cycle) {
+			ret = sprd_pwm_config(spc, pwm, state->duty_cycle,
+					      state->period);
+			if (ret)
+				return ret;
+		}
+
+		sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
+	} else if (cstate->enabled) {
+		/*
+		 * Note: After setting SPRD_PWM_ENABLE to zero, the controller
+		 * will not wait for current period to be completed, instead it
+		 * will stop the PWM channel immediately.
+		 */
+		sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 0);
+
+		clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops sprd_pwm_ops = {
+	.apply = sprd_pwm_apply,
+	.get_state = sprd_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
+{
+	struct clk *clk_pwm;
+	int ret, i;
+
+	for (i = 0; i < SPRD_PWM_CHN_NUM; i++) {
+		struct sprd_pwm_chn *chn = &spc->chn[i];
+		int j;
+
+		for (j = 0; j < SPRD_PWM_CHN_CLKS_NUM; ++j)
+			chn->clks[j].id =
+				sprd_pwm_clks[i * SPRD_PWM_CHN_CLKS_NUM + j];
+
+		ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_CHN_CLKS_NUM,
+					chn->clks);
+		if (ret) {
+			if (ret == -ENOENT)
+				break;
+
+			if (ret != -EPROBE_DEFER)
+				dev_err(spc->dev,
+					"failed to get channel clocks\n");
+
+			return ret;
+		}
+
+		clk_pwm = chn->clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
+		chn->clk_rate = clk_get_rate(clk_pwm);
+	}
+
+	if (!i) {
+		dev_err(spc->dev, "no available PWM channels\n");
+		return -ENODEV;
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
+	platform_set_drvdata(pdev, spc);
+
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
+	if (ret)
+		dev_err(&pdev->dev, "failed to add PWM chip\n");
+
+	return ret;
+}
+
+static int sprd_pwm_remove(struct platform_device *pdev)
+{
+	struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
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

