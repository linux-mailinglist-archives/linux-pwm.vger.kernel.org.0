Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906C9464296
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Dec 2021 00:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhK3X15 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Nov 2021 18:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbhK3X1i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 18:27:38 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E03C061746;
        Tue, 30 Nov 2021 15:24:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id j18so31072961ljc.12;
        Tue, 30 Nov 2021 15:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ih+LeOQIGJjC7liZ7ONCl8Okef0duyrFbhQsj2+Cwt8=;
        b=qCSauoq31kscOuMPCRMFCs5L7NG1tntq8qEKMGqz6ZrjjUJx4kyhz4NY2iyG53pJWP
         Vp7Q75F/WAHXogRorKQXvZUASafzJ/GgnrzXnkIIX94uADc+2uIci0EbSg57CuU9BE0n
         Ji0StgwUvj0SqczlfWJadWsBKN4fvu8fm0olHjsOed0cymPymTyK4eJnN/nDAq+226lk
         AsiUMryWQ79GebqTGwjxOyrUJTlKGj0Lt1lgn2c96zFQu5LxI017r3U0iooktaRBwWL9
         Jv3QpqZFinhodRKRNH7VLA5eXaFgfHNpv86iEqM0j3jQFrlS7rAgLD0G9jXgpOJMwGXY
         i4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ih+LeOQIGJjC7liZ7ONCl8Okef0duyrFbhQsj2+Cwt8=;
        b=c/DXpbfo00Ln9gtJjjDFbf9yfzjgAeCQLb8lA71HAxphi7sxojTy6q2Wq/ni9yqlN/
         Gf9yazZa7rjJl5q9XAdKOBst8QNp0dW+ewLqyWOeZN5dn4yl86JH5TNSuooVEA05DQ4A
         mrpXElxtV+WKg1B/MYdKHY2+KJqN8rKa+zCJkzCOgPEFBxnmy3ERELQy/Rc2Y8Ke79jk
         /a3BLurRr8DMX7hCp8OvwwuX3tlWjnMUg62CzFpHS81rjtjdIDFak4RVMe2O0aQZ2pPa
         SaqL3hA9e64Lw0HDyV2catgUg59Nx5w9UQdKloZzoqv2CNYGmy2nWakT1rzBZcXt8/dw
         bqsQ==
X-Gm-Message-State: AOAM533yhQlRfTl6vYoLzxi6TN8hkWAppsbuLGoLYTg60npy9MPOt98u
        TeI0t0UW4kb0Zf48RO7a+y4=
X-Google-Smtp-Source: ABdhPJz/8LJst8O0RraYkhZbT8hkpy3lQ5P+qdEMqe7swhm2LT9fmOPH661TjgbBYt7ORWzxnKmVfg==
X-Received: by 2002:a05:651c:b23:: with SMTP id b35mr2044243ljr.286.1638314656463;
        Tue, 30 Nov 2021 15:24:16 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 22/40] mmc: sdhci-tegra: Add runtime PM and OPP support
Date:   Wed,  1 Dec 2021 02:23:29 +0300
Message-Id: <20211130232347.950-23-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The SDHCI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now SDHCI must be resumed using
runtime PM API in order to initialize the SDHCI power state. The SDHCI
clock rate must be changed using OPP API that will reconfigure the power
domain performance state in accordance to the rate. Add runtime PM and OPP
support to the SDHCI driver.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 81 +++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a5001875876b..6435a75142a6 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -15,6 +15,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/mmc/card.h>
@@ -24,6 +26,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ktime.h>
 
+#include <soc/tegra/common.h>
+
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
 
@@ -760,7 +764,9 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	unsigned long host_clk;
+	int err;
 
 	if (!clock)
 		return sdhci_set_clock(host, clock);
@@ -778,7 +784,12 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	 * from clk_get_rate() is used.
 	 */
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
-	clk_set_rate(pltfm_host->clk, host_clk);
+
+	err = dev_pm_opp_set_rate(dev, host_clk);
+	if (err)
+		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
+			host_clk, err);
+
 	tegra_host->curr_clk_rate = host_clk;
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
@@ -1705,7 +1716,6 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 				   "failed to get clock\n");
 		goto err_clk_get;
 	}
-	clk_prepare_enable(clk);
 	pltfm_host->clk = clk;
 
 	tegra_host->rst = devm_reset_control_get_exclusive(&pdev->dev,
@@ -1716,15 +1726,24 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		goto err_rst_get;
 	}
 
-	rc = reset_control_assert(tegra_host->rst);
+	rc = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (rc)
 		goto err_rst_get;
 
+	pm_runtime_enable(&pdev->dev);
+	rc = pm_runtime_resume_and_get(&pdev->dev);
+	if (rc)
+		goto err_pm_get;
+
+	rc = reset_control_assert(tegra_host->rst);
+	if (rc)
+		goto err_rst_assert;
+
 	usleep_range(2000, 4000);
 
 	rc = reset_control_deassert(tegra_host->rst);
 	if (rc)
-		goto err_rst_get;
+		goto err_rst_assert;
 
 	usleep_range(2000, 4000);
 
@@ -1736,8 +1755,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 err_add_host:
 	reset_control_assert(tegra_host->rst);
+err_rst_assert:
+	pm_runtime_put_sync_suspend(&pdev->dev);
+err_pm_get:
+	pm_runtime_disable(&pdev->dev);
 err_rst_get:
-	clk_disable_unprepare(pltfm_host->clk);
 err_clk_get:
 	clk_disable_unprepare(tegra_host->tmclk);
 err_power_req:
@@ -1756,19 +1778,38 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 
 	reset_control_assert(tegra_host->rst);
 	usleep_range(2000, 4000);
-	clk_disable_unprepare(pltfm_host->clk);
-	clk_disable_unprepare(tegra_host->tmclk);
 
+	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
+
+	clk_disable_unprepare(tegra_host->tmclk);
 	sdhci_pltfm_free(pdev);
 
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
+static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	clk_disable_unprepare(pltfm_host->clk);
+
+	return 0;
+}
+
+static int __maybe_unused sdhci_tegra_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_prepare_enable(pltfm_host->clk);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_tegra_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
 	int ret;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
@@ -1783,17 +1824,22 @@ static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
 		return ret;
 	}
 
-	clk_disable_unprepare(pltfm_host->clk);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		sdhci_resume_host(host);
+		cqhci_resume(host->mmc);
+		return ret;
+	}
+
 	return 0;
 }
 
-static int __maybe_unused sdhci_tegra_resume(struct device *dev)
+static int sdhci_tegra_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	int ret;
 
-	ret = clk_prepare_enable(pltfm_host->clk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
@@ -1812,13 +1858,16 @@ static int __maybe_unused sdhci_tegra_resume(struct device *dev)
 suspend_host:
 	sdhci_suspend_host(host);
 disable_clk:
-	clk_disable_unprepare(pltfm_host->clk);
+	pm_runtime_force_suspend(dev);
 	return ret;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(sdhci_tegra_dev_pm_ops, sdhci_tegra_suspend,
-			 sdhci_tegra_resume);
+static const struct dev_pm_ops sdhci_tegra_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(sdhci_tegra_runtime_suspend, sdhci_tegra_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_tegra_suspend, sdhci_tegra_resume)
+};
 
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
-- 
2.33.1

