Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C433EE32E
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhHQBcl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbhHQBa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8996C06129D;
        Mon, 16 Aug 2021 18:30:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g13so38107737lfj.12;
        Mon, 16 Aug 2021 18:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lkMe1kfjyl72aACDUoar04Z3kVJXU/K1V2K/vaWhQI=;
        b=TMnJpzJzzXGpq158U+0IfMSpvwwi/z4KC4LQ/QwbhAdPyykV5omzv0e3JvjHpMG+jm
         YjYKDXJVQ1JLw2rXknVxP1MQP0poHeFLpr7HGZsxsoU/CuhzelIEIup9ZTenjT1uM38I
         N/j10YqNOcgRvUbX/Lw6NTygd3q7ZV9vVf6q742bHPl7A8seSzy1RjCKe28HX2D5uLzW
         CdjwqAU6b8SdLcnpOKDx1hsKgeIrJl2K3HnIkNAldm0zdhar4OARY/MuRL/yT+3e1l4Q
         gJWVLVsKe3aU7cCfDIidNssk5wE2KSDQli8QJG+FBBckRAXgNsSkHvgXAkUUIHBGDhPW
         UyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lkMe1kfjyl72aACDUoar04Z3kVJXU/K1V2K/vaWhQI=;
        b=CVhnMNhbMSwjMXox4RbgPhcb2xh7KjnELI8XdwdwiJOz0CDagvuKgbh4pju8PpAwxE
         Zb+N7jQt2pvJf6QGPB2V362ygjwts+H2QYScEvw7yopkELB3eaM479xxmLxq6Ebn4fuT
         HUl2ebzx0uUEWVm8jY7cfsz32iT3bRn8RxvtP/ihPYXeBZBEk4NB3PQebFG2vq5IwW0g
         r0rlUL+Sw2KZGXK2LRyPVqRwyK7koleOINVo333vimOy5CM/6Bp4yK+ARB8hrJEoH+ah
         sGRL07rhc5GJ/P/0Yzqy5SivOpaw7m05vcmpVG8HxtuYgOg2ZbbndzSoVW8t7QxqO1sZ
         P4Qw==
X-Gm-Message-State: AOAM531KmmFOq9KWuVxeKKtezuv1vtV2C7DW6aXA8qlb6xBA+4TKVG5N
        S4xDQGtq/dP0ZwapSQaaSXU=
X-Google-Smtp-Source: ABdhPJyKm8MUjPwNU/XaPhkpCC07f4s3U0TJC71msPXy5iUJTdJeDCVsEUr34EX+MR86aW6pHwjnsw==
X-Received: by 2002:a05:6512:3a8b:: with SMTP id q11mr491818lfu.582.1629163824182;
        Mon, 16 Aug 2021 18:30:24 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v8 19/34] pwm: tegra: Add runtime PM and OPP support
Date:   Tue, 17 Aug 2021 04:27:39 +0300
Message-Id: <20210817012754.8710-20-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now PWM must be resumed using
runtime PM API in order to initialize the PWM power state. The PWM clock
rate must be changed using OPP API that will reconfigure the power domain
performance state in accordance to the rate. Add runtime PM and OPP
support to the PWM driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/pwm/pwm-tegra.c | 104 ++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 11a10b575ace..bb6d184946b9 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -42,12 +42,16 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pwm.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #define PWM_ENABLE	(1 << 31)
 #define PWM_DUTY_WIDTH	8
 #define PWM_DUTY_SHIFT	16
@@ -145,12 +149,25 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		required_clk_rate =
 			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
 
-		err = clk_set_rate(pc->clk, required_clk_rate);
-		if (err < 0)
+		/*
+		 * GENPD performance state should be changed only for
+		 * the resumed device because GENPD core tracks performance
+		 * state and drops/restores the state on RPM suspend/resume.
+		 */
+		err = pm_runtime_resume_and_get(pc->dev);
+		if (err)
+			return err;
+
+		err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
+		if (err < 0) {
+			pm_runtime_put(pc->dev);
 			return -EINVAL;
+		}
 
 		/* Store the new rate for further references */
 		pc->clk_rate = clk_get_rate(pc->clk);
+
+		pm_runtime_put(pc->dev);
 	}
 
 	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
@@ -181,8 +198,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * before writing the register. Otherwise, keep it enabled.
 	 */
 	if (!pwm_is_enabled(pwm)) {
-		err = clk_prepare_enable(pc->clk);
-		if (err < 0)
+		err = pm_runtime_resume_and_get(pc->dev);
+		if (err)
 			return err;
 	} else
 		val |= PWM_ENABLE;
@@ -193,7 +210,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * If the PWM is not enabled, turn the clock off again to save power.
 	 */
 	if (!pwm_is_enabled(pwm))
-		clk_disable_unprepare(pc->clk);
+		pm_runtime_put(pc->dev);
 
 	return 0;
 }
@@ -204,8 +221,8 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	int rc = 0;
 	u32 val;
 
-	rc = clk_prepare_enable(pc->clk);
-	if (rc < 0)
+	rc = pm_runtime_resume_and_get(pc->dev);
+	if (rc)
 		return rc;
 
 	val = pwm_readl(pc, pwm->hwpwm);
@@ -224,7 +241,7 @@ static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val &= ~PWM_ENABLE;
 	pwm_writel(pc, pwm->hwpwm, val);
 
-	clk_disable_unprepare(pc->clk);
+	pm_runtime_put_sync(pc->dev);
 }
 
 static const struct pwm_ops tegra_pwm_ops = {
@@ -256,11 +273,21 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	ret = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		goto disable_pm;
+
 	/* Set maximum frequency of the IP */
-	ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
+	ret = dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
-		return ret;
+		goto put_pm;
 	}
 
 	/*
@@ -278,7 +305,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->rst)) {
 		ret = PTR_ERR(pwm->rst);
 		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
-		return ret;
+		goto put_pm;
 	}
 
 	reset_control_deassert(pwm->rst);
@@ -291,34 +318,70 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		reset_control_assert(pwm->rst);
-		return ret;
+		goto put_pm;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	return 0;
+put_pm:
+	pm_runtime_put(&pdev->dev);
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int tegra_pwm_remove(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
+	int err;
 
 	pwmchip_remove(&pc->chip);
 
+	err = pm_runtime_resume_and_get(pc->dev);
+	if (err)
+		return err;
+
 	reset_control_assert(pc->rst);
+	pm_runtime_put(pc->dev);
+	pm_runtime_disable(pc->dev);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tegra_pwm_suspend(struct device *dev)
+static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
 {
-	return pinctrl_pm_select_sleep_state(dev);
+	struct tegra_pwm_chip *pc = dev_get_drvdata(dev);
+	int err;
+
+	clk_disable_unprepare(pc->clk);
+
+	err = pinctrl_pm_select_sleep_state(dev);
+	if (err) {
+		clk_prepare_enable(pc->clk);
+		return err;
+	}
+
+	return 0;
 }
 
-static int tegra_pwm_resume(struct device *dev)
+static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 {
-	return pinctrl_pm_select_default_state(dev);
+	struct tegra_pwm_chip *pc = dev_get_drvdata(dev);
+	int err;
+
+	err = pinctrl_pm_select_default_state(dev);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(pc->clk);
+	if (err) {
+		pinctrl_pm_select_sleep_state(dev);
+		return err;
+	}
+
+	return 0;
 }
-#endif
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
@@ -344,7 +407,10 @@ static const struct of_device_id tegra_pwm_of_match[] = {
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
 
 static const struct dev_pm_ops tegra_pwm_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_pwm_suspend, tegra_pwm_resume)
+	SET_RUNTIME_PM_OPS(tegra_pwm_runtime_suspend, tegra_pwm_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static struct platform_driver tegra_pwm_driver = {
-- 
2.32.0

