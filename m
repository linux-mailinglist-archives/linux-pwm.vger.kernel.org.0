Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDE63EE34A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbhHQBci (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhHQBa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F315C0612E7;
        Mon, 16 Aug 2021 18:30:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p38so38352633lfa.0;
        Mon, 16 Aug 2021 18:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVewrQPLqMIzX/eUr1ccRXf6dVPwW04CHGi9g8P6H2I=;
        b=Ngw0q21CDl+yxQ7xI6sFiWFDLy1/jXJWCzDmmHgTyR7UHFdWvRHsZx+fwwbTxV2Cyv
         gN6KKIyDdmn9trt+zxJhnrKxJcVQ+dnkic/3q9GtmrOvXqnunqZ+3rLOZ5UuPH5SKRXQ
         wHnnssBODCzWhAf3IXJsR51tcgLbdYamJQnd58q7DpKGQ4YxYliB2agkeVrrv0VQH3WD
         yX57PPPDbCytK20teu7FFGxH65vic3f2b3gEAv0Mzw0Wl85PutrUYT2zIxxGhQmXSuej
         il2Sc7DptAVhnwSP4QkipTWxTtJR6TstiShQkQRUQrPcr1noWm9NKLF1HbC63QkYiuH+
         PRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVewrQPLqMIzX/eUr1ccRXf6dVPwW04CHGi9g8P6H2I=;
        b=QCYs9zEBwtBKJNaYtyIPQH9Y7mDZi/ulwUbbFrDgZUiP4wBiFDtkD7pfhlahWmkVRC
         fDE0MrLxnEY0xSJdo3Pl8s4eeSoqkw/42SpC5YXwwCb6rS7paQxS1mLzcFuhcuohXCOK
         lchPPcHBWykzpnKKRtAHWSH0B1jczJja26gYZ6hraK7y5os7VfqKEiSakCkAMIP65hN6
         8VnK9GlNoTVbX/GKpfvqyPOnj8CJHOwPCs4u8KcFKRzXRh8fVHtonIMXFcLCXUT5nTsN
         vWbqOFJLRAoj3sle7pzNrgcpCVPWKau1yAslOpOKm5j5cTWggJvOopjSrDR3kvNJ+h3Y
         nLfQ==
X-Gm-Message-State: AOAM531o5J8njOSh+Y+sDUHpecN5sKNYsVl77ThltznDkkcwKZb7mGrw
        sw4D/VQv01pIjqF5hhXFuqI=
X-Google-Smtp-Source: ABdhPJwQhGPy+Iac60Z/w+/X1SqDXqcJNZewEFmLnX1JN/Qye3BOu6cFpYRzvaojzNHG7UQlI4Pj5A==
X-Received: by 2002:a05:6512:304a:: with SMTP id b10mr522160lfb.442.1629163823026;
        Mon, 16 Aug 2021 18:30:23 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:22 -0700 (PDT)
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
Subject: [PATCH v8 18/34] bus: tegra-gmi: Add runtime PM and OPP support
Date:   Tue, 17 Aug 2021 04:27:38 +0300
Message-Id: <20210817012754.8710-19-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The GMI bus on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now GMI must be resumed using
runtime PM API in order to initialize the GMI power state. Add runtime PM
and OPP support to the GMI driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/bus/tegra-gmi.c | 92 ++++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
index a6570789f7af..51cac6822f20 100644
--- a/drivers/bus/tegra-gmi.c
+++ b/drivers/bus/tegra-gmi.c
@@ -13,8 +13,12 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #define TEGRA_GMI_CONFIG		0x00
 #define TEGRA_GMI_CONFIG_GO		BIT(31)
 #define TEGRA_GMI_BUS_WIDTH_32BIT	BIT(30)
@@ -54,36 +58,20 @@ static int tegra_gmi_enable(struct tegra_gmi *gmi)
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
 
-	reset_control_assert(gmi->rst);
-	usleep_range(2000, 4000);
-	reset_control_deassert(gmi->rst);
-
-	writel(gmi->snor_timing0, gmi->base + TEGRA_GMI_TIMING0);
-	writel(gmi->snor_timing1, gmi->base + TEGRA_GMI_TIMING1);
-
-	gmi->snor_config |= TEGRA_GMI_CONFIG_GO;
-	writel(gmi->snor_config, gmi->base + TEGRA_GMI_CONFIG);
-
 	return 0;
 }
 
 static void tegra_gmi_disable(struct tegra_gmi *gmi)
 {
-	u32 config;
-
-	/* stop GMI operation */
-	config = readl(gmi->base + TEGRA_GMI_CONFIG);
-	config &= ~TEGRA_GMI_CONFIG_GO;
-	writel(config, gmi->base + TEGRA_GMI_CONFIG);
-
-	reset_control_assert(gmi->rst);
-	clk_disable_unprepare(gmi->clk);
+	pm_runtime_put(gmi->dev);
+	pm_runtime_disable(gmi->dev);
 }
 
 static int tegra_gmi_parse_dt(struct tegra_gmi *gmi)
@@ -213,6 +201,7 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 	if (!gmi)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, gmi);
 	gmi->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -232,6 +221,10 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 		return PTR_ERR(gmi->rst);
 	}
 
+	err = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (err)
+		return err;
+
 	err = tegra_gmi_parse_dt(gmi);
 	if (err)
 		return err;
@@ -247,8 +240,6 @@ static int tegra_gmi_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, gmi);
-
 	return 0;
 }
 
@@ -262,6 +253,58 @@ static int tegra_gmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused tegra_gmi_runtime_resume(struct device *dev)
+{
+	struct tegra_gmi *gmi = dev_get_drvdata(dev);
+	int err;
+
+	err = dev_pm_opp_sync(gmi->dev);
+	if (err) {
+		dev_err(gmi->dev, "failed to sync OPP: %d\n", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(gmi->clk);
+	if (err < 0) {
+		dev_err(gmi->dev, "failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	reset_control_assert(gmi->rst);
+	usleep_range(2000, 4000);
+	reset_control_deassert(gmi->rst);
+
+	writel(gmi->snor_timing0, gmi->base + TEGRA_GMI_TIMING0);
+	writel(gmi->snor_timing1, gmi->base + TEGRA_GMI_TIMING1);
+
+	gmi->snor_config |= TEGRA_GMI_CONFIG_GO;
+	writel(gmi->snor_config, gmi->base + TEGRA_GMI_CONFIG);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_gmi_runtime_suspend(struct device *dev)
+{
+	struct tegra_gmi *gmi = dev_get_drvdata(dev);
+	u32 config;
+
+	/* stop GMI operation */
+	config = readl(gmi->base + TEGRA_GMI_CONFIG);
+	config &= ~TEGRA_GMI_CONFIG_GO;
+	writel(config, gmi->base + TEGRA_GMI_CONFIG);
+
+	reset_control_assert(gmi->rst);
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
@@ -275,6 +318,7 @@ static struct platform_driver tegra_gmi_driver = {
 	.driver = {
 		.name		= "tegra-gmi",
 		.of_match_table	= tegra_gmi_id_table,
+		.pm = &tegra_gmi_pm,
 	},
 };
 module_platform_driver(tegra_gmi_driver);
-- 
2.32.0

