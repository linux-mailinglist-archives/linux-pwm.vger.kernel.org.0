Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F644FB2A
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhKNToz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbhKNTjK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:10 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E2C061746;
        Sun, 14 Nov 2021 11:36:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t11so30718271ljh.6;
        Sun, 14 Nov 2021 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igwS03O+cCyV7lRXH4y+t79qa1UqfsZF14OJ7wQIlV8=;
        b=C5D6+9Oi4+zld99F7pD08yGwYAU/NhQ1zTxCubY9k9Q8ArIwQ69vlKmCRsKoXeRKIk
         OX2pzAIglw37ncb/6VdTw3vgOg4G9+o0uaEAQPXrY766n5lFtp70AahsXXiIztYsM6sN
         2AerMVbL+60qRu/h+pVmAsvJ04XOqbY4dhZQLrXfzlmQjNqxFJ2JPR8/iDtx4dLIygDb
         97YYYR77U5qidcfs3B/Y/hwnDOXLGmLw753xcgIxFyAYRwC+eBqQw8FJ9Y81sJJOxELY
         e3XRW0brm1XNu15emeSs1ko9BeBH3twg8EzMjoT2KLHgEOWgtUmdUs4AqLOJJPK9Bvgu
         xlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igwS03O+cCyV7lRXH4y+t79qa1UqfsZF14OJ7wQIlV8=;
        b=B4/nvDrJtiv/HmXOahwDAF8bSxuF+5J4QIRhTmPnRBqQloq5TDbZHtozVqTUmdGTyD
         SZ+UQHWpmBI5/cjQk3LLZp1ng08N8MVXDaI+0QMTNoDWyhBENNC3OlbnYOrZaOaNUQMS
         uS56IkzkTje2aI6xsoASb2qu3QPn7qqlUJn2tj5Vqr77pwIpRxEdou7TS9JVcjYdVSsp
         bTuPcvJNCNXlX4U0ZqrVG+m4ZFtcQ6AGt1Cw5ZrbBCdp16R3PLIWsogbvzCmxGWQvTQp
         x2IBfL7XFGkRs0Z/+MNQOxitCd40riNyt9qnsktQJfodRrxNUIDSmB+1r9983nnIVsJU
         BSTQ==
X-Gm-Message-State: AOAM530R/ZydZpw23vTjZeY4FZkik44d4mfe/XhzddK9WdqWNtjDDCpX
        Or7dy18RnImcMXTriXxDLgA=
X-Google-Smtp-Source: ABdhPJxzW6RpNn1G2z9kncHPO6MlT6lQe7RN8J0/juGjF+3+fRMv30TCmD0lR7cBVyAACR0eZglRJw==
X-Received: by 2002:a2e:9349:: with SMTP id m9mr34179775ljh.178.1636918573891;
        Sun, 14 Nov 2021 11:36:13 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:13 -0800 (PST)
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
Subject: [PATCH v15 18/39] usb: chipidea: tegra: Add runtime PM and OPP support
Date:   Sun, 14 Nov 2021 22:34:14 +0300
Message-Id: <20211114193435.7705-19-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Tegra USB controller belongs to the core power domain and we're going
to enable GENPD support for the core domain. Now USB controller must be
resumed using runtime PM API in order to initialize the USB power state.
We already support runtime PM for the CI device, but CI's PM is separated
from the RPM managed by tegra-usb driver. Add runtime PM and OPP support
to the driver.

Acked-by: Peter Chen <peter.chen@kernel.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 53 ++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 60361141ac04..a72a9474afea 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -7,6 +7,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <linux/usb.h>
@@ -15,6 +16,8 @@
 #include <linux/usb/of.h>
 #include <linux/usb/phy.h>
 
+#include <soc/tegra/common.h>
+
 #include "../host/ehci.h"
 
 #include "ci.h"
@@ -278,6 +281,8 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (!usb)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, usb);
+
 	soc = of_device_get_match_data(&pdev->dev);
 	if (!soc) {
 		dev_err(&pdev->dev, "failed to match OF data\n");
@@ -296,11 +301,14 @@ static int tegra_usb_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = clk_prepare_enable(usb->clk);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", err);
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		return err;
+
+	pm_runtime_enable(&pdev->dev);
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
 		return err;
-	}
 
 	if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
 		usb->needs_double_reset = true;
@@ -320,8 +328,6 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_power_off;
 
-	platform_set_drvdata(pdev, usb);
-
 	/* setup and register ChipIdea HDRC device */
 	usb->soc = soc;
 	usb->data.name = "tegra-usb";
@@ -350,7 +356,9 @@ static int tegra_usb_probe(struct platform_device *pdev)
 phy_shutdown:
 	usb_phy_shutdown(usb->phy);
 fail_power_off:
-	clk_disable_unprepare(usb->clk);
+	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
+
 	return err;
 }
 
@@ -360,15 +368,46 @@ static int tegra_usb_remove(struct platform_device *pdev)
 
 	ci_hdrc_remove_device(usb->dev);
 	usb_phy_shutdown(usb->phy);
+
+	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_usb_runtime_resume(struct device *dev)
+{
+	struct tegra_usb *usb = dev_get_drvdata(dev);
+	int err;
+
+	err = clk_prepare_enable(usb->clk);
+	if (err < 0) {
+		dev_err(dev, "failed to enable clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused tegra_usb_runtime_suspend(struct device *dev)
+{
+	struct tegra_usb *usb = dev_get_drvdata(dev);
+
 	clk_disable_unprepare(usb->clk);
 
 	return 0;
 }
 
+static const struct dev_pm_ops tegra_usb_pm = {
+	SET_RUNTIME_PM_OPS(tegra_usb_runtime_suspend, tegra_usb_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver tegra_usb_driver = {
 	.driver = {
 		.name = "tegra-usb",
 		.of_match_table = tegra_usb_of_match,
+		.pm = &tegra_usb_pm,
 	},
 	.probe = tegra_usb_probe,
 	.remove = tegra_usb_remove,
-- 
2.33.1

