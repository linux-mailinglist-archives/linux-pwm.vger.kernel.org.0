Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534A63EE2B0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhHQBb2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbhHQBbF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:31:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8FEC0613CF;
        Mon, 16 Aug 2021 18:30:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t9so38200448lfc.6;
        Mon, 16 Aug 2021 18:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFAqaH94y5dODw6bxUJyzcf4ykAG32TzvIL6HQjvI4o=;
        b=TOSPckvcKxaz8x4YZmCZ0DSatUga5azJjxEAWG2dD391oqsaF+CbiZiVAkzwluviXN
         i74KxE0D6tlq7a0vVADBfmWiluCgjyDF3N9YlGeBDAbRQrV/51sL4V3dKMgYITDxPopl
         O1KTXO+fpQ7NQZgIgm3lz3ppA2MexSw7vxNbzRluXdC6hWniNB23aLETH8FZ03nf2pVp
         ijicJHlUcovAndBkG7Cp510kqyIeulwDX7Ng90xzDP22Ji/mR1pu3sSVo3MbrHlTh2Gp
         f3brQfprquAO+aixVhD065gj1DfukxgmNs8kHoK0SlXfurKhWyxIElPa+Z84dZkahUAA
         VcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFAqaH94y5dODw6bxUJyzcf4ykAG32TzvIL6HQjvI4o=;
        b=a/ncine40vuISrvsEQK8YMTYYjJ9WdwvLYWpuEWaezADSEwDg5SydrlrVRDlYkxTD8
         4RcTCem1SbkCA+0Z/6foS2RR7VpCao714/DEZm+nVOdp4N9ts6f7suBMVbqsV2TANTwh
         p+koaM++vObfiKZoYsciYCz2grwR2jdmvAsH+xIGdu55tSurxJgRAqqeAsJhFE4WvbkW
         gxNXSa9m07ygxd02reu+Nb+Psr/nFewp+T33xrTZXR06Hoy7NSaLqfm7lwMVOm51T38L
         k/LtbXt9E6H+bkrM+Q257nmXrM2DEY0oK2UDuvQzg1pyyEddfMi0JPJh/EanVQ21obVP
         SoDA==
X-Gm-Message-State: AOAM531t2siiXP5t/n3sMg1ITyxuD+P2pcIuOFh3Irh2BHj9wIPKWs7J
        91ocb9fBMAEGD+leIFslBHA=
X-Google-Smtp-Source: ABdhPJzDfhGZOTtGotoFXUcS8muVuZ5oQKe5OJmXVsMZ9TFuuD4YSntIkTKjSY9ZSxKC1uuHJPNZNg==
X-Received: by 2002:a19:ac4c:: with SMTP id r12mr473734lfc.217.1629163831275;
        Mon, 16 Aug 2021 18:30:31 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:31 -0700 (PDT)
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
Subject: [PATCH v8 25/34] media: staging: tegra-vde: Support generic power domain and OPP
Date:   Tue, 17 Aug 2021 04:27:45 +0300
Message-Id: <20210817012754.8710-26-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Currently driver supports legacy power domain API, this patch adds generic
power domain and OPP support. This allows us to utilize a modern GENPD API
for newer device-trees and support DVFS of the video decoder hardware.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/vde.c | 65 ++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index ed4c1250b303..9a3eee8e71e2 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -15,11 +15,14 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/pmc.h>
 
 #include "uapi.h"
@@ -920,13 +923,17 @@ static __maybe_unused int tegra_vde_runtime_suspend(struct device *dev)
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
 
-	err = tegra_powergate_power_off(TEGRA_POWERGATE_VDEC);
-	if (err) {
-		dev_err(dev, "Failed to power down HW: %d\n", err);
-		return err;
+	if (!dev->pm_domain) {
+		err = tegra_powergate_power_off(TEGRA_POWERGATE_VDEC);
+		if (err) {
+			dev_err(dev, "Failed to power down HW: %d\n", err);
+			return err;
+		}
 	}
 
 	clk_disable_unprepare(vde->clk);
+	reset_control_release(vde->rst);
+	reset_control_release(vde->rst_mc);
 
 	return 0;
 }
@@ -936,14 +943,47 @@ static __maybe_unused int tegra_vde_runtime_resume(struct device *dev)
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VDEC,
-						vde->clk, vde->rst);
+	err = reset_control_acquire(vde->rst_mc);
+	if (err) {
+		dev_err(dev, "Failed to acquire mc reset: %d\n", err);
+		return err;
+	}
+
+	err = reset_control_acquire(vde->rst);
+	if (err) {
+		dev_err(dev, "Failed to acquire reset: %d\n", err);
+		goto release_mc_reset;
+	}
+
+	if (!dev->pm_domain) {
+		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VDEC,
+							vde->clk, vde->rst);
+		if (err) {
+			dev_err(dev, "Failed to power up HW : %d\n", err);
+			goto release_reset;
+		}
+	}
+
+	err = dev_pm_opp_sync(dev);
 	if (err) {
-		dev_err(dev, "Failed to power up HW : %d\n", err);
+		dev_err(dev, "failed to sync OPP: %d\n", err);
 		return err;
 	}
 
+	err = clk_prepare_enable(vde->clk);
+	if (err) {
+		dev_err(dev, "Failed to enable clock: %d\n", err);
+		goto release_reset;
+	}
+
 	return 0;
+
+release_reset:
+	reset_control_release(vde->rst);
+release_mc_reset:
+	reset_control_release(vde->rst_mc);
+
+	return err;
 }
 
 static int tegra_vde_probe(struct platform_device *pdev)
@@ -1001,14 +1041,14 @@ static int tegra_vde_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	vde->rst = devm_reset_control_get(dev, NULL);
+	vde->rst = devm_reset_control_get_exclusive_released(dev, NULL);
 	if (IS_ERR(vde->rst)) {
 		err = PTR_ERR(vde->rst);
 		dev_err(dev, "Could not get VDE reset %d\n", err);
 		return err;
 	}
 
-	vde->rst_mc = devm_reset_control_get_optional(dev, "mc");
+	vde->rst_mc = devm_reset_control_get_optional_exclusive_released(dev, "mc");
 	if (IS_ERR(vde->rst_mc)) {
 		err = PTR_ERR(vde->rst_mc);
 		dev_err(dev, "Could not get MC reset %d\n", err);
@@ -1026,6 +1066,10 @@ static int tegra_vde_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_tegra_core_dev_init_opp_table_simple(dev);
+	if (err)
+		return err;
+
 	vde->iram_pool = of_gen_pool_get(dev->of_node, "iram", 0);
 	if (!vde->iram_pool) {
 		dev_err(dev, "Could not get IRAM pool\n");
@@ -1133,8 +1177,7 @@ static void tegra_vde_shutdown(struct platform_device *pdev)
 	 * On some devices bootloader isn't ready to a power-gated VDE on
 	 * a warm-reboot, machine will hang in that case.
 	 */
-	if (pm_runtime_status_suspended(&pdev->dev))
-		tegra_vde_runtime_resume(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 }
 
 static __maybe_unused int tegra_vde_pm_suspend(struct device *dev)
-- 
2.32.0

