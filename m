Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1383EE327
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbhHQBcj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbhHQBa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70981C0613A3;
        Mon, 16 Aug 2021 18:30:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r9so28747283lfn.3;
        Mon, 16 Aug 2021 18:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyUAbE2QFBPkAmLeYWIUbN1190eoatB//1STMKYD8E8=;
        b=FHHkdVALDIC8dyirLf0Z63rRk2CutfNmZs9OsR4qhsaRwNMT/JUhplqAuSsrFSjuJt
         7zSJwbx7dRC2Y9TwD2ZgLA5WNk42Z5kK0YZGsGNs3gwML8PTM0G7q3O9wFbjuiSMyB0k
         KGqYd6awr7eVl6/cGTwCB183jYlUcnE+k7hkycg/xusGFpw8VM2zyG04lr4PyeyWYT2s
         5azXGdQxYI0PqjxHmfPrlOWLRcxdK/wmwF/vC6iJgIsJkfElj58/Nx7y+ML/ZOXDk4uG
         X7bjcWfPs3d71DI5ydF/R/VhKo+ZQTQ07nPlS36IPVJW1y82YTEYBSTdFfCOPQdw86Td
         ypTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyUAbE2QFBPkAmLeYWIUbN1190eoatB//1STMKYD8E8=;
        b=sYtr9ml4cF6YMacoScA68QfTOEHbWcos5VNNOKMwOXTRJhGc+RMtmRQxTVbKpLlXXr
         pHKuIdGN7lc59XaM4G/0AgSCMgNMh0F5/uVHomsAsOykQ2Shurhxq+kzjGJhZAEGIYrZ
         ppj069HmEiq1ain6GAscN2PrshB5jYCSHWxC7bg66PvjN5Z5zhW+mboLaAe6uCSMMFKb
         PQY+ZdpA20eTtdIE6cG/LBHUU3I4OK3T8fcF/n1RKuJ4YmH9mNP/rMiFdyi9kNIkNZfQ
         xNBLnzJDVgiWsFvBwlQpdIx16sauljx2LIE7qmvZy63lvPB4kcK4fCxKsy+prrEVYpDb
         pYAw==
X-Gm-Message-State: AOAM533/4fkC8FUzKUTYu33vJNilDSvegIkQ7sd4BXFnboyfY2Fh/6ei
        jgIvrbaZi5LVZ9wcfvAvn+w=
X-Google-Smtp-Source: ABdhPJyRsAKpO2RcAL+dS1g6qGdkcebzosRG7tO7qBO0N4O3xLiuYgInL89eIUxXQ6XIMR0zalmnVA==
X-Received: by 2002:a19:6b02:: with SMTP id d2mr510341lfa.522.1629163821862;
        Mon, 16 Aug 2021 18:30:21 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:21 -0700 (PDT)
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
Subject: [PATCH v8 17/34] usb: chipidea: tegra: Add runtime PM and OPP support
Date:   Tue, 17 Aug 2021 04:27:37 +0300
Message-Id: <20210817012754.8710-18-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
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
to tegra-usb driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 61 ++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 60361141ac04..09a5e5fc251f 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -7,6 +7,8 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <linux/usb.h>
@@ -15,6 +17,8 @@
 #include <linux/usb/of.h>
 #include <linux/usb/phy.h>
 
+#include <soc/tegra/common.h>
+
 #include "../host/ehci.h"
 
 #include "ci.h"
@@ -278,6 +282,8 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (!usb)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, usb);
+
 	soc = of_device_get_match_data(&pdev->dev);
 	if (!soc) {
 		dev_err(&pdev->dev, "failed to match OF data\n");
@@ -296,11 +302,14 @@ static int tegra_usb_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = clk_prepare_enable(usb->clk);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", err);
+	err = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (err)
 		return err;
-	}
+
+	pm_runtime_enable(&pdev->dev);
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
+		goto disable_pm;
 
 	if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
 		usb->needs_double_reset = true;
@@ -320,8 +329,6 @@ static int tegra_usb_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_power_off;
 
-	platform_set_drvdata(pdev, usb);
-
 	/* setup and register ChipIdea HDRC device */
 	usb->soc = soc;
 	usb->data.name = "tegra-usb";
@@ -350,7 +357,10 @@ static int tegra_usb_probe(struct platform_device *pdev)
 phy_shutdown:
 	usb_phy_shutdown(usb->phy);
 fail_power_off:
-	clk_disable_unprepare(usb->clk);
+	pm_runtime_put(&pdev->dev);
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
+
 	return err;
 }
 
@@ -360,15 +370,52 @@ static int tegra_usb_remove(struct platform_device *pdev)
 
 	ci_hdrc_remove_device(usb->dev);
 	usb_phy_shutdown(usb->phy);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused tegra_usb_runtime_resume(struct device *dev)
+{
+	struct tegra_usb *usb = dev_get_drvdata(dev);
+	int err;
+
+	err = dev_pm_opp_sync(dev);
+	if (err) {
+		dev_err(dev, "failed to sync OPP: %d\n", err);
+		return err;
+	}
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
2.32.0

