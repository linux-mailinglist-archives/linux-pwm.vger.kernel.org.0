Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950E82A7261
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgKDXrU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733143AbgKDXpZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:25 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85234C0613CF;
        Wed,  4 Nov 2020 15:45:25 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 74so174428lfo.5;
        Wed, 04 Nov 2020 15:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bYI1lTU0u9qugSWMqSGv5A3HDa8DCxBYBbaISJenZIs=;
        b=lIEXO/La7Zc0VwM0c4dDJ9vgZF6JXEGcQnUDRRMwyyD10nK8kcgrNp9DgX3Du75IIT
         OzpoO+2Bl7PIc8Pyh1aBFhzzFuhxYw/EGzxr89Ll+MHvnacmt4aq+occ46DdFWbChWkL
         izUIyLqX6Bqr0wRpJMiCGaqg2/bML9hVkLcegcNewXvrIjcjdirU/fjw5hxKasYetBF0
         ag405LakLuvWIXmezrX37MwwgCR2hLz4ZwMbHvpDRnPUc1zYptM9IAdfmP4GvSqjJHt3
         DpNnOKNZjLv+kBhz26qVrZFveREsWzpQVEUcELKxB05MXwMJE6kz+wM2C0LgbHfqMsKs
         A2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYI1lTU0u9qugSWMqSGv5A3HDa8DCxBYBbaISJenZIs=;
        b=VD23WUI/Iw9+s38Vg7zoOyUSj77CJTkl4oqVOeQuEVNk41Cr4W+AxINkEnY1yuBbK/
         hMipYrDvC8bu1GWehfik3MJ7B2y5lCsu10ccyDIqJ5sONdz3WdF8RmWXGRFLFaR700mJ
         426bTVx0DwyjSP9RLp9ZNgyKugM6L6YAwiOxkHfPcMuyiPnKcFD/yjT5tml4u9NAeyYL
         EGA/dXqDnnD0gLZBcq74udmM+X23BQkmnSdmKZLFcNfGN9u1P5GW9270gs8qs2ejJa/9
         LGCKqrvkKTqAHXGjg6jKZDRR83oXyNBlLC5pcbfM9nFOx0owMPnk/Fl4QvxuGeE6C2I9
         P1xw==
X-Gm-Message-State: AOAM532/a1dHDvUt+Fs3ZJ3azm+6o9KuzK28puFwj+akkEAj2pRJxnM4
        VpzEfNqsZnKmwP/R6397MI0=
X-Google-Smtp-Source: ABdhPJzQf9TUjFglxLujGELvxqeC4uglPytS2wsivLSpqjwqfzVF8NSmMtie4mgdOemR7ln3Z7XqDQ==
X-Received: by 2002:a19:7409:: with SMTP id v9mr59130lfe.402.1604533524002;
        Wed, 04 Nov 2020 15:45:24 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:23 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 20/30] usb: chipidea: tegra: Support OPP and SoC core voltage scaling
Date:   Thu,  5 Nov 2020 02:44:17 +0300
Message-Id: <20201104234427.26477-21-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add initial OPP and SoC CORE voltage scaling support to the Tegra UDC
driver. This is required for enabling system-wide DVFS on older Tegra
SoCs.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/chipidea/Kconfig         |  1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c | 79 ++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 8bafcfc6080d..6a5bc08711d6 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -56,6 +56,7 @@ config USB_CHIPIDEA_TEGRA
 	tristate "Enable Tegra UDC glue driver" if EMBEDDED
 	depends on OF
 	depends on USB_CHIPIDEA_UDC
+	select PM_OPP
 	default USB_CHIPIDEA
 
 endif
diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 7455df0ede49..7f0403e810fe 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/reset.h>
 
 #include <linux/usb/chipidea.h>
@@ -47,6 +48,79 @@ static const struct of_device_id tegra_udc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_udc_of_match);
 
+static void tegra_udc_deinit_opp_table(void *data)
+{
+	struct device *dev = data;
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_put_regulators(opp_table);
+	dev_pm_opp_put_opp_table(opp_table);
+}
+
+static int devm_tegra_udc_init_opp_table(struct device *dev)
+{
+	unsigned long rate = ULONG_MAX;
+	struct opp_table *opp_table;
+	const char *rname = "core";
+	struct dev_pm_opp *opp;
+	int err;
+
+	/* legacy device-trees don't have OPP table */
+	if (!device_property_present(dev, "operating-points-v2"))
+		return 0;
+
+	/* voltage scaling is optional */
+	if (device_property_present(dev, "core-supply"))
+		opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
+	else
+		opp_table = dev_pm_opp_get_opp_table(dev);
+
+	if (IS_ERR(opp_table))
+		return dev_err_probe(dev, PTR_ERR(opp_table),
+				     "failed to prepare OPP table\n");
+
+	err = dev_pm_opp_of_add_table(dev);
+	if (err) {
+		dev_err(dev, "failed to add OPP table: %d\n", err);
+		goto put_table;
+	}
+
+	/* find suitable OPP for the maximum clock rate */
+	opp = dev_pm_opp_find_freq_floor(dev, &rate);
+	err = PTR_ERR_OR_ZERO(opp);
+	if (err) {
+		dev_err(dev, "failed to get OPP: %d\n", err);
+		goto remove_table;
+	}
+
+	dev_pm_opp_put(opp);
+
+	/*
+	 * First dummy rate-set initializes voltage vote by setting voltage
+	 * in accordance to the clock rate.
+	 */
+	err = dev_pm_opp_set_rate(dev, rate);
+	if (err) {
+		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
+		goto remove_table;
+	}
+
+	err = devm_add_action(dev, tegra_udc_deinit_opp_table, dev);
+	if (err)
+		goto remove_table;
+
+	return 0;
+
+remove_table:
+	dev_pm_opp_of_remove_table(dev);
+put_table:
+	dev_pm_opp_put_regulators(opp_table);
+
+	return err;
+}
+
 static int tegra_udc_probe(struct platform_device *pdev)
 {
 	const struct tegra_udc_soc_info *soc;
@@ -77,6 +151,11 @@ static int tegra_udc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_tegra_udc_init_opp_table(&pdev->dev);
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "failed to initialize OPP\n");
+
 	err = clk_prepare_enable(udc->clk);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to enable clock: %d\n", err);
-- 
2.27.0

