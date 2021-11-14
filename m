Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF64744FA66
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhKNTjk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhKNTjM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:12 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C09C061766;
        Sun, 14 Nov 2021 11:36:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m27so13151844lfj.12;
        Sun, 14 Nov 2021 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R96ZVkrOm8k9eme6iC5AQ0TJyD6674Gzc/J8B1BaX4Y=;
        b=pu/yGPsLEDe9IItqNvKzJsJFt2lff0MaRwJLSl41zMSMTg1VKgxgyq7njVJtGIq/zV
         Jh5A1EiZAPAzRcphr8k9JkTk/GdzvIDVHElPNy5aqIoi5jifzXZ6Zbyh99KqUV1SKI/+
         WwBp6wxfGwT8R57QNlOkQb5vrjU+EN0cANdM1iw9BuQhXMikOVOOB85f7mZvOygiAVDz
         MQS9GBnCp4OylwxvkmN0N89qkV1fpxkWMjD7l2RoUkpdjU9SJ9VPeAxgdui3GZAJMA6H
         s2cHlBeybXqVqp6TjxGlOp9+B3HpZ0KQfMMUEoT32sJ6GOszAWkELRNEvcasdz10lhPq
         dq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R96ZVkrOm8k9eme6iC5AQ0TJyD6674Gzc/J8B1BaX4Y=;
        b=1jJn35AL5KsWT3pYNjkdBkIqoejnpQy86H0biz4jaDNa2Gr1ZtWqFwi836j7kkesBa
         FiT47Y/s1ZyW+Z2HvNPkO2398a8OF4V/CijwwDQ6ebOXAMImwpQeGpW2qivs+hsgJ2sg
         E/SjDsA1cIz3+hc/HhQ1/dxamKYkoTmSTG7YjVgJlKJ6ocOlffCWvIV+/58GpMClD7HE
         9ods83WofMDryACajn+8zumtoenqoM+J5dXaATiajDCBeSe+iPL/w9f4O7nqTMjkJU5s
         nTKPpD2ko97lYSk2aHAjvs23OTH25ij0TtBahBDvikIRM8Ll9e47pHCeVDwwcG0iKrzO
         GGtw==
X-Gm-Message-State: AOAM530JxoNjvGwTXRkvLZ2faohC6/fOrrALThgPKgLLCg31oO7Xa9zX
        ei3OGiMX41Qn3ts6Doc94/A=
X-Google-Smtp-Source: ABdhPJzlwYC1hwYYztjf+6/SjjR7JY2xogYzsbi2Cl87vNS63Vq2h5JBnrFdgAskMZApl0sE7g1IBw==
X-Received: by 2002:a05:6512:3a5:: with SMTP id v5mr30215930lfp.250.1636918574815;
        Sun, 14 Nov 2021 11:36:14 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:14 -0800 (PST)
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
Subject: [PATCH v15 19/39] bus: tegra-gmi: Add runtime PM and OPP support
Date:   Sun, 14 Nov 2021 22:34:15 +0300
Message-Id: <20211114193435.7705-20-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The GMI bus on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now GMI must be resumed using
runtime PM API in order to initialize the GMI power state. Add runtime PM
and OPP support to the GMI driver.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/bus/tegra-gmi.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
index a6570789f7af..35b59f92fa66 100644
--- a/drivers/bus/tegra-gmi.c
+++ b/drivers/bus/tegra-gmi.c
@@ -13,8 +13,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #define TEGRA_GMI_CONFIG		0x00
 #define TEGRA_GMI_CONFIG_GO		BIT(31)
 #define TEGRA_GMI_BUS_WIDTH_32BIT	BIT(30)
@@ -54,9 +57,10 @@ static int tegra_gmi_enable(struct tegra_gmi *gmi)
 {
 	int err;
 
-	err = clk_prepare_enable(gmi->clk);
-	if (err < 0) {
-		dev_err(gmi->dev, "failed to enable clock: %d\n", err);
+	pm_runtime_enable(gmi->dev);
+	err = pm_runtime_resume_and_get(gmi->dev);
+	if (err) {
+		pm_runtime_disable(gmi->dev);
 		return err;
 	}
 
@@ -83,7 +87,9 @@ static void tegra_gmi_disable(struct tegra_gmi *gmi)
 	writel(config, gmi->base + TEGRA_GMI_CONFIG);
 
 	reset_control_assert(gmi->rst);
-	clk_disable_unprepare(gmi->clk);
+
+	pm_runtime_put_sync_suspend(gmi->dev);
+	pm_runtime_force_suspend(gmi->dev);
 }
 
 static int tegra_gmi_parse_dt(struct tegra_gmi *gmi)
@@ -213,6 +219,7 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 	if (!gmi)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, gmi);
 	gmi->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -232,6 +239,10 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 		return PTR_ERR(gmi->rst);
 	}
 
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		return err;
+
 	err = tegra_gmi_parse_dt(gmi);
 	if (err)
 		return err;
@@ -247,8 +258,6 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, gmi);
-
 	return 0;
 }
 
@@ -262,6 +271,34 @@ static int tegra_gmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused tegra_gmi_runtime_resume(struct device *dev)
+{
+	struct tegra_gmi *gmi = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(gmi->clk);
+	if (err < 0) {
+		dev_err(gmi->dev, "failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_gmi_runtime_suspend(struct device *dev)
+{
+	struct tegra_gmi *gmi = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(gmi->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_gmi_pm = {
+	SET_RUNTIME_PM_OPS(tegra_gmi_runtime_suspend, tegra_gmi_runtime_resume,
+			   NULL)
+};
+
 static const struct of_device_id tegra_gmi_id_table[] = {
 	{ .compatible = "nvidia,tegra20-gmi", },
 	{ .compatible = "nvidia,tegra30-gmi", },
@@ -275,6 +312,7 @@ static struct platform_driver tegra_gmi_driver = {
 	.driver = {
 		.name		= "tegra-gmi",
 		.of_match_table	= tegra_gmi_id_table,
+		.pm = &tegra_gmi_pm,
 	},
 };
 module_platform_driver(tegra_gmi_driver);
-- 
2.33.1

