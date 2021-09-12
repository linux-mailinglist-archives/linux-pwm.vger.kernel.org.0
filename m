Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A873A408127
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhILUOd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbhILUMZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:12:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821EAC0617AD;
        Sun, 12 Sep 2021 13:10:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t8so6287393wrq.4;
        Sun, 12 Sep 2021 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ww/L4fjenebIn9zOWRmgVU7EP8twv8HHX18pgFT7aL8=;
        b=F9aT6kqD3//zRNApSu9q/bIQ9dDrXTb49ZIzVt4TnuTbVaNXFn6hYdXNT3Zl+r5AzV
         LvdT1ajpZwKJCxCQYoACwLuzh03ASixemc1T/UQH7PGLb/QCw06mrGBEs8SWNQH5eyZE
         RE3rtLINrrZzCtgbqEmBKGdptHQKUCSVpCwsQFXjuN9EIdyumP46uHX7i4Ae1/u479Gt
         Cniy9D6YyXybsyA+Y4NPHGR3Ey8p0tgPOmHtg8flbzZ91fBWcFn2svxGcaWxYt2/o7W+
         qIS4KVGuqHt5eFI7Fm/FeMNVkKQwN3jd+Ff68oLA8Bm+m6q0zGWHQ1Axbp0BeZqT88Ja
         2jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ww/L4fjenebIn9zOWRmgVU7EP8twv8HHX18pgFT7aL8=;
        b=WQ8NwOYkiafQl6gv7QCWJdbyfFQ14rEHo3zGtC4XE02RNJ3WVbxXTCkYNkKjbkwPnM
         kj+SqERXAgJ87GPLYfkRwRwckTXqKJlBNCrc7HXrgd/paEB8BsF1tW4kWM+e/t6xNXfW
         zZvY/1SBsHGytZieknErRWn5LSCttsDG33lZxkbNKnCtpi56jOfHv5/GlcsTgZ6JL8h7
         NBromlxahXCSUV4Ia18qKalZgRhGhC2P38mpf57JtHvBWPFMLCM8My7Qrz/ZXPDxgO9U
         GZ38c5Jn4iz0AZyumH5yE6kHWEpaeKbS8J3OuAAdDZiLn03H8evUa4eN0qpy/j8iO/Gt
         4h9A==
X-Gm-Message-State: AOAM532io76SBUmdALecDJpDcaBWOlMzi3ts8//JvfswvevkU+Ki929s
        9LtzlSGgOqZhLRw15WMfcAE=
X-Google-Smtp-Source: ABdhPJzAOewaOicL6BQHongI3PvmPCPNCTnY4M9a/1QGoTnhq6LpUAY3jtJ4DV5UsDNVYLq/6z8tVQ==
X-Received: by 2002:adf:902b:: with SMTP id h40mr8676512wrh.342.1631477432154;
        Sun, 12 Sep 2021 13:10:32 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:31 -0700 (PDT)
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
Subject: [PATCH v11 24/34] media: staging: tegra-vde: Support generic power domain
Date:   Sun, 12 Sep 2021 23:08:22 +0300
Message-Id: <20210912200832.12312-25-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
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

