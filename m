Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383DB412C91
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351874AbhIUCpo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbhIUCDF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:03:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A40C140920;
        Mon, 20 Sep 2021 11:12:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so71798632lfj.12;
        Mon, 20 Sep 2021 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sOB+CC4oKPUtnAgAVkVlulPbe4zQ1YRgefv90mYIpNk=;
        b=Dse2/kC0O6SyO9n1SmZUZQPVCwHdqTbHbwtXw8ToO9kVwErtXQf/OAaLmk+vzOMujR
         HJQVJsV7Lhm7WoODh4ei8Ef38eppEODj7lFHg4YCVQan3cKnCbmnMWtVU4NStc2WjUPj
         EuWkxnaM5BqCOwcRDV1SughiTgrt2BsILpc1TgFwi52DRmwrgHDzCQ6Pp8w+awic2vgr
         zpnA3gnOGuNe7tatsnv32DFaMEDLSVNFFaAvsa36OmVCjnHSvwi3dLEVf5TG+yBDUKF5
         SxIxo8R5DGWnCMRejrdP0t93LuQWtoEDCgoOy56nhERJgJLZhynMCO2h0SMS70PC5EVW
         4RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sOB+CC4oKPUtnAgAVkVlulPbe4zQ1YRgefv90mYIpNk=;
        b=5W/hO/tkmKdY4NZxSoiZtHtAV2BzwiljXeJ7R8+NJS3yaAy/b7WsSWIUj5J7Hg1CKu
         VBdx/p3UBjGqoyWlzOOBUW6HeGpGRzKF3RvMF8I2e7CbzpvU5HUr90vfrYoywcaFfhNv
         xAPKexM5PaoqUn3sH6mzmyQ2R8eIi1lmT2lFcXlGbu8aBQJs/p8MvWA3MKl4+rJsN590
         +T2oUGyXvLQyVA7nKpbDrfM5ObqnswzqfFfjxdlK8QNZmQe0Kpgh63st6evO1/GN0NRH
         GdJYjh6s4DTPI8bsXYnMrx1ZYaSd0XyMqMU3aWyiU70UfZyXLjnOomhNH6MxTfh/tGW4
         K2fg==
X-Gm-Message-State: AOAM531Ey914kOE7oUschAuMnn25Rwq2t/aFzBsP2goJdqrDqZvy+pY2
        l0O8xl7zkzWXOVLYy/BY6KU=
X-Google-Smtp-Source: ABdhPJyuDkKTe9zYhCrkwhRZlqKRRrsFkFOvF0/tfcqmP+YcJTHIeW0n+OrZdCF78qQ6A+L2Sm6I/A==
X-Received: by 2002:a05:6512:78e:: with SMTP id x14mr51060lfr.239.1632161544619;
        Mon, 20 Sep 2021 11:12:24 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 20/35] mtd: rawnand: tegra: Add runtime PM and OPP support
Date:   Mon, 20 Sep 2021 21:11:30 +0300
Message-Id: <20210920181145.19543-21-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
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
 drivers/mtd/nand/raw/tegra_nand.c | 55 ++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 32431bbe69b8..098fcc9cb9df 100644
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
 
@@ -1166,14 +1170,22 @@ static int tegra_nand_probe(struct platform_device *pdev)
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
@@ -1188,21 +1200,19 @@ static int tegra_nand_probe(struct platform_device *pdev)
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
+	pm_runtime_put(ctrl->dev);
 	return err;
 }
 
@@ -1219,11 +1229,39 @@ static int tegra_nand_remove(struct platform_device *pdev)
 
 	nand_cleanup(chip);
 
+	pm_runtime_put(ctrl->dev);
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
@@ -1234,6 +1272,7 @@ static struct platform_driver tegra_nand_driver = {
 	.driver = {
 		.name = "tegra-nand",
 		.of_match_table = tegra_nand_of_match,
+		.pm = &tegra_nand_pm,
 	},
 	.probe = tegra_nand_probe,
 	.remove = tegra_nand_remove,
-- 
2.32.0

