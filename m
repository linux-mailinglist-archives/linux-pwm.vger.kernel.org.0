Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706CF43A77A
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhJYWuC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbhJYWtG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:49:06 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A9C061230;
        Mon, 25 Oct 2021 15:46:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w23so11207063lje.7;
        Mon, 25 Oct 2021 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AS+FEJOF13mRDVVUovX1BVWIAoN0guTY9bNVQA1UUns=;
        b=AS72yGNoAJKUQ54PsPSKHZ8AXutDi7fGr0aq6o2TZIGnVLPYxmf7CwsSXsFLDdHYWV
         ZreR9PHErZqbuH9IJY9uoL0iqz7AJzK2NXRBXqdhHWbazQY7zw9s4Dd7uJTW6D0HMj6Q
         3KATd8RNkAhTGVLcOjIpHdzVa3gUpv1Gqnyd3V6zFI1ZDbciWXoFdbdM47OOq/qCXen+
         Cl38l1/4xjrcVzKFfpmJ9azFMrop+2qMJH0F+/FqKTLh+/kv/Vy1y2ztYBPxRGG/kLfR
         KtGoc7sr7oe1bWGKi0DxWKePN02jEic7cf4kucIC59FfL/eqDkTiPkLwJwHSkzhp3YL5
         Fvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AS+FEJOF13mRDVVUovX1BVWIAoN0guTY9bNVQA1UUns=;
        b=MQ6TW9AbWV6xLlaMSYIsM5rrJATU28tTVO8pkbZFmr8Rjt48IDcEPOVdbDMH8x8siq
         b+0a7QCzwQEo+WZyZGzxMRmnDGUXDM4lzsJbrZGtFmh/m5XOW3uuuETLXPF5lu3MBwWz
         /zEkTl6LcStCKpA4WWRFRPi0xlw6cLFqOqGBJbiyBsfJkSlLOp6knOvGuN92WefapwK4
         ZNYx8EvXiGdG6RF5Q1Qe8Mp77awfVKylMSzS6EeuYkvd+i5Cwk6LhT+rWsmOX+gLlheb
         XJo4X25Oi6E+RuZd3thimrqLhEPRPDfCSJgqGanxUqJ0dJxmFXxIq+wnIVILsiWtUkQk
         VSXA==
X-Gm-Message-State: AOAM533Ku9W6ZazhC6N3Ok6V+y2pwjzFZWVbxJYwZzegUhgndzlI9vqZ
        9ovISCXPp2CncC6xMW8SM10=
X-Google-Smtp-Source: ABdhPJzwEq+PfsFhNGXOL3myfiDIrFjeEeo149B3ohKMmISZgOmVVWewdZsEdLez5IAoTM3RFYwwGg==
X-Received: by 2002:a2e:8706:: with SMTP id m6mr22180496lji.502.1635201966432;
        Mon, 25 Oct 2021 15:46:06 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:06 -0700 (PDT)
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
Subject: [PATCH v14 22/39] mtd: rawnand: tegra: Add runtime PM and OPP support
Date:   Tue, 26 Oct 2021 01:40:15 +0300
Message-Id: <20211025224032.21012-23-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The NAND on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now NAND must be resumed using
runtime PM API in order to initialize the NAND power state. Add runtime PM
and OPP support to the NAND driver.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mtd/nand/raw/tegra_nand.c | 60 ++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 32431bbe69b8..0124aba0b4f0 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -17,8 +17,11 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #define COMMAND					0x00
 #define   COMMAND_GO				BIT(31)
 #define   COMMAND_CLE				BIT(30)
@@ -1151,6 +1154,7 @@ static int tegra_nand_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctrl->dev = &pdev->dev;
+	platform_set_drvdata(pdev, ctrl);
 	nand_controller_init(&ctrl->controller);
 	ctrl->controller.ops = &tegra_nand_controller_ops;
 
@@ -1166,14 +1170,26 @@ static int tegra_nand_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->clk))
 		return PTR_ERR(ctrl->clk);
 
-	err = clk_prepare_enable(ctrl->clk);
+	err = devm_pm_runtime_enable(&pdev->dev);
+	if (err)
+		return err;
+
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		return err;
+
+	/*
+	 * This driver doesn't support active power management yet,
+	 * so we will simply keep device resumed.
+	 */
+	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
 		return err;
 
 	err = reset_control_reset(rst);
 	if (err) {
 		dev_err(ctrl->dev, "Failed to reset HW: %d\n", err);
-		goto err_disable_clk;
+		goto err_put_pm;
 	}
 
 	writel_relaxed(HWSTATUS_CMD_DEFAULT, ctrl->regs + HWSTATUS_CMD);
@@ -1188,21 +1204,19 @@ static int tegra_nand_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), ctrl);
 	if (err) {
 		dev_err(ctrl->dev, "Failed to get IRQ: %d\n", err);
-		goto err_disable_clk;
+		goto err_put_pm;
 	}
 
 	writel_relaxed(DMA_MST_CTRL_IS_DONE, ctrl->regs + DMA_MST_CTRL);
 
 	err = tegra_nand_chips_init(ctrl->dev, ctrl);
 	if (err)
-		goto err_disable_clk;
-
-	platform_set_drvdata(pdev, ctrl);
+		goto err_put_pm;
 
 	return 0;
 
-err_disable_clk:
-	clk_disable_unprepare(ctrl->clk);
+err_put_pm:
+	pm_runtime_put_sync_suspend(ctrl->dev);
 	return err;
 }
 
@@ -1219,11 +1233,40 @@ static int tegra_nand_remove(struct platform_device *pdev)
 
 	nand_cleanup(chip);
 
+	pm_runtime_put_sync_suspend(ctrl->dev);
+	pm_runtime_force_suspend(ctrl->dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_nand_runtime_resume(struct device *dev)
+{
+	struct tegra_nand_controller *ctrl = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(ctrl->clk);
+	if (err) {
+		dev_err(dev, "Failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_nand_runtime_suspend(struct device *dev)
+{
+	struct tegra_nand_controller *ctrl = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(ctrl->clk);
 
 	return 0;
 }
 
+static const struct dev_pm_ops tegra_nand_pm = {
+	SET_RUNTIME_PM_OPS(tegra_nand_runtime_suspend, tegra_nand_runtime_resume,
+			   NULL)
+};
+
 static const struct of_device_id tegra_nand_of_match[] = {
 	{ .compatible = "nvidia,tegra20-nand" },
 	{ /* sentinel */ }
@@ -1234,6 +1277,7 @@ static struct platform_driver tegra_nand_driver = {
 	.driver = {
 		.name = "tegra-nand",
 		.of_match_table = tegra_nand_of_match,
+		.pm = &tegra_nand_pm,
 	},
 	.probe = tegra_nand_probe,
 	.remove = tegra_nand_remove,
-- 
2.33.1

