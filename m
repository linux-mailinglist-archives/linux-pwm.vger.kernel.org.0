Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5228418C28
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhIZWpO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhIZWod (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E9C06176A;
        Sun, 26 Sep 2021 15:42:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u8so67671275lff.9;
        Sun, 26 Sep 2021 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YyNAYfueuD3YPYHh112r77cDQBrhaXO0aFwD2cEPa8o=;
        b=qF7H2h+r/JAxQ+lpunKLfBqLnviZIZZiRw4LHX46oTVFXU9fQZNbf7amyob5pgCeAq
         FMRYnjZ+gP3KhrFm51CnfMQFfotFc/CatiCOb3fZX68cjEnUngu7M5bGWJYyJr8aALOJ
         FH4O/tFMnSDoiNWzXJC88D0RU4Ga1Km/JpQ1mCEoXKlHCWRpLfPVNz0/rIWuMEwa82ic
         gqeE219l0yS5n/Ar97bfTYZXCh9pH3Wx1yPuX0SQO+14aRlJBF4c+ooyAMw2L2/8ExAz
         XGgN1GER806rnSsOki5gnj15r2wd26+wG40np+sI1a1JZW4UTepHz+QSwUPoakrV32XR
         OxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YyNAYfueuD3YPYHh112r77cDQBrhaXO0aFwD2cEPa8o=;
        b=J6s/erXRTSFaAuXLor4xG1UzuPuYazJAG6SAr9bxn4ISUZwbEv+OQhQ5iXCMboXg1W
         Wqaalky52DVYB7FFAJ+Y5/5Wawce5iwb11pNFAWqOodt7UtRdA+LaTb+pyo7+Rez/Uxo
         5cz0jBjmfIlhwtIkQu9BsLS7UmGG0eNMwzTEnBxLuKc81ijoSLVYd73TS4xZc6PnsifT
         EigFJiJrUYegnRVRUe6Teo7MFZyxkovRfosSavDFGnrTo4ks1cZgCUwnt/+ZMb2jZXLl
         b5kUCsbv6L09L8YKIMzO1lGyR6AL+Frgo0OyZAIFjPK78grm4jFnfd1AqecEJ07bf3s5
         CNKg==
X-Gm-Message-State: AOAM533moeO8tSDuZO9iV4d1znlBXDWliXu/Q1nNbC6xGlOVfR56skOi
        oGdR6kaUEbpEoPNNSBJCP8s=
X-Google-Smtp-Source: ABdhPJzalQDl1f1xr46iXc8yO5/SuvQnlZ8lpy6q5dfaUDj7uaw39uYuGiwcTmDiJvR8bCfXuRuLiQ==
X-Received: by 2002:ac2:4312:: with SMTP id l18mr21453301lfh.602.1632696174426;
        Sun, 26 Sep 2021 15:42:54 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:54 -0700 (PDT)
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
Subject: [PATCH v13 24/35] media: staging: tegra-vde: Support generic power domain
Date:   Mon, 27 Sep 2021 01:40:47 +0300
Message-Id: <20210926224058.1252-25-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Currently driver supports legacy power domain API, this patch adds generic
power domain support. This allows us to utilize a modern GENPD API for
newer device-trees.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/staging/media/tegra-vde/vde.c | 57 +++++++++++++++++++++------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/tegra-vde/vde.c b/drivers/staging/media/tegra-vde/vde.c
index ed4c1250b303..bb3079a2c0b5 100644
--- a/drivers/staging/media/tegra-vde/vde.c
+++ b/drivers/staging/media/tegra-vde/vde.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/pmc.h>
 
 #include "uapi.h"
@@ -920,13 +921,17 @@ static __maybe_unused int tegra_vde_runtime_suspend(struct device *dev)
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
@@ -936,14 +941,41 @@ static __maybe_unused int tegra_vde_runtime_resume(struct device *dev)
 	struct tegra_vde *vde = dev_get_drvdata(dev);
 	int err;
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_VDEC,
-						vde->clk, vde->rst);
+	err = reset_control_acquire(vde->rst_mc);
 	if (err) {
-		dev_err(dev, "Failed to power up HW : %d\n", err);
+		dev_err(dev, "Failed to acquire mc reset: %d\n", err);
 		return err;
 	}
 
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
@@ -1001,14 +1033,14 @@ static int tegra_vde_probe(struct platform_device *pdev)
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
@@ -1066,6 +1098,10 @@ static int tegra_vde_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 300);
 
+	err = devm_tegra_core_dev_init_opp_table_common(dev);
+	if (err)
+		goto err_pm_runtime;
+
 	/*
 	 * VDE partition may be left ON after bootloader, hence let's
 	 * power-cycle it in order to put hardware into a predictable lower
@@ -1133,8 +1169,7 @@ static void tegra_vde_shutdown(struct platform_device *pdev)
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

