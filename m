Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443662A728B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgKDXsH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733132AbgKDXpW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:22 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13EC0613CF;
        Wed,  4 Nov 2020 15:45:21 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so148807lfd.9;
        Wed, 04 Nov 2020 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiMZXJPavVdA5iWrAG5s24KuYQ60OjfNxHzqyJK5EsM=;
        b=ZQMFC548Tvz/UdDyQFnHjksr0tRAmfVl4BN+QGzygwbC/1g6BcNRHq0ChVxHTmLlgv
         Q4KgPHWyW5yaNpRiGInuz8rjGVTjJiwlSvi68RHD2JbxD4VrbNRG0nirUu18yFlB64pN
         1sGGT+hX9uNOODPR6RnmEnppSaTqmaN38nhkk+wFXiwJkR7mLQID+noXFH8tY0zh5cl+
         0DX5nMxLE7U7YMFAb5ekFv3Ak0zp9ddUNQTmvp6SOf47XUuWn12lpZg8Z/JjHtL8tBgM
         BhsDuC+VyY/4LOSfFmlVb7tBQ3AxqeOID9lSb5GqzCoUvn+/jMniiRoPjIsIRfEcN7cz
         2qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiMZXJPavVdA5iWrAG5s24KuYQ60OjfNxHzqyJK5EsM=;
        b=lQDPDIp5MHRtaI/Q+zliGUKDNQKNbMFN/jlTCwQqCauaYX70tQ6g/Zbz6kKoOUMIla
         +Bv8Ft1Jeha6FkwHe41FhesK9nla3CvNSaUUDJ16N7mxk90WuM0d7d4M7whl6yAiJq1d
         t7nQiVpy+aroM9rbaE8lFb+2iYX6bsOSJDEH8iS/4MKDdBZEDMoj2OQPBSCG9FJFYJ4L
         z9cwxdVUHe9qzKRUrbAorY230MjPd5CZvtOJGAcmt2FowKJgJrRE3wmZCI8aBJ/5YnHp
         9imcJtFUuBfFTulHe+aBG3sMgYmtifoxkGdEyJ7X5mYtv63yfBRFuTg1TgOsrOHEv7qz
         8R2w==
X-Gm-Message-State: AOAM531vA8DWinI4fvGbO9CTki7VWDadUXDVAMfAFUpDoSr6ROS+vSp3
        rf5gP0UoIxLe40uJCNhl70g=
X-Google-Smtp-Source: ABdhPJx8frc7rILYDyrQ7e/HdSjfS3VFNHPxEyzIQyqGuaOcFU1S/XE+OGCZV1OwLzUUJngXh+x4OQ==
X-Received: by 2002:a19:5206:: with SMTP id m6mr38911lfb.367.1604533519754;
        Wed, 04 Nov 2020 15:45:19 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:19 -0800 (PST)
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
Subject: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage scaling
Date:   Thu,  5 Nov 2020 02:44:14 +0300
Message-Id: <20201104234427.26477-18-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add OPP and SoC core voltage scaling support to the Tegra SDHCI driver.
This is required for enabling system-wide DVFS on older Tegra SoCs.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci-tegra.c | 70 ++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 310e546e5898..7d719c81b917 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -293,6 +293,7 @@ config MMC_SDHCI_TEGRA
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
+	select PM_OPP
 	help
 	  This selects the Tegra SD/MMC controller. If you have a Tegra
 	  platform with SD or MMC devices, say Y or M here.
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ed12aacb1c73..964709a3ccd6 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -754,10 +755,15 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	unsigned long host_clk;
 
-	if (!clock)
-		return sdhci_set_clock(host, clock);
+	/* disable clock and then remove OPP performance/voltage vote */
+	if (!clock) {
+		sdhci_set_clock(host, clock);
+		dev_pm_opp_set_rate(dev, clock);
+		return;
+	}
 
 	/*
 	 * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI
@@ -772,7 +778,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	 * from clk_get_rate() is used.
 	 */
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
-	clk_set_rate(pltfm_host->clk, host_clk);
+	dev_pm_opp_set_rate(dev, host_clk);
 	tegra_host->curr_clk_rate = host_clk;
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
@@ -1558,6 +1564,60 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 	return ret;
 }
 
+static void sdhci_tegra_deinit_opp_table(void *data)
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
+static int devm_sdhci_tegra_init_opp_table(struct device *dev)
+{
+	struct opp_table *opp_table;
+	const char *rname = "core";
+	int err;
+
+	/* voltage scaling is optional */
+	if (device_property_present(dev, "core-supply"))
+		opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
+	else
+		opp_table = dev_pm_opp_get_opp_table(dev);
+
+	if (IS_ERR(opp_table))
+		return dev_err_probe(dev, PTR_ERR(opp_table),
+				    "failed to prepare OPP table\n");
+
+	/*
+	 * OPP table presence is optional and we want the set_rate() of OPP
+	 * API to work similarly to clk_set_rate() if table is missing in a
+	 * device-tree.  The add_table() errors out if OPP is missing in DT.
+	 */
+	if (device_property_present(dev, "operating-points-v2")) {
+		err = dev_pm_opp_of_add_table(dev);
+		if (err) {
+			dev_err(dev, "failed to add OPP table: %d\n", err);
+			goto put_table;
+		}
+	}
+
+	err = devm_add_action(dev, sdhci_tegra_deinit_opp_table, dev);
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
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1621,6 +1681,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		goto err_power_req;
 	}
 
+	rc = devm_sdhci_tegra_init_opp_table(&pdev->dev);
+	if (rc)
+		goto err_parse_dt;
+
 	/*
 	 * Tegra210 has a separate SDMMC_LEGACY_TM clock used for host
 	 * timeout clock and SW can choose TMCLK or SDCLK for hardware
-- 
2.27.0

