Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305FD2A7295
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgKDXsJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733121AbgKDXpU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:20 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12EC0613D2;
        Wed,  4 Nov 2020 15:45:19 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 74so174090lfo.5;
        Wed, 04 Nov 2020 15:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qlwfzgS9XHjSWBbs0HLllCSVTbcvFduzW2+0sVnum3s=;
        b=nVoWtTN3E27fw+e2vYrYyoK2YFjA4ez2wyReXTpMCOK05zlNCZYH9KU8VNTCldyh6L
         KogjTtU+Km/dOlpcLQn2ooEhWlItxvclTz3HXEsbh7EjdGrc5RhyR37hDLuFw1JSc7eO
         Gc9Or7OWnvqYLnm7WFCPqGQfanr0jdG2BVtlZFwMmXO6jmpVr4PrHyQblINNnM/kF/9n
         iJXxQ5iCJkFHRBwC70e9LmMyCg0QAvq7vlcIeqMZec23TAjDiY/YN/8hNhXMopCsDLmq
         tjpvSmY0HFn2Oiz+REgzPtZI/kle/4pnt7QEqGaWM6GRy0/oyF1peq7zQp8mGKIThoWY
         QV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlwfzgS9XHjSWBbs0HLllCSVTbcvFduzW2+0sVnum3s=;
        b=D/wfT5s62ftH1eJCZVwWF2VTifuEUh/J9ulCYaGuJ8fWNUjLzPs0OWsxzyM1Bf2CqI
         HTDGez2AzzAFtjoaVa3E0wx5wDiW2P/l9f4e/sgOIKmI4AXFPUGJMUMWPHqf3NNDyetr
         TNVEVoD3J5aNfmllFZD32lFRmtYxRFHsQRWgVvLm1b4hn61dke3Rz6p3V0l0sTHH5Pcw
         iziLllMa5WN64ltnDOCPI2xh3/0k0puHq9dCSaGqluVD26lbwQsZYH5XdZ0p/ROwNQ7U
         2ASNyuS+ctgnJh1s03a0TPU8CuFFa1+jTXBJ94vqtpo9tLF4/Zve2DW9WONwgbC0QIsu
         x58A==
X-Gm-Message-State: AOAM533uVtH45VEGMESm+ibHy+cRdUFKyGR+DMhtZEu9N+aGfOjIo6q8
        OT9sBD674MhVbjpX+VkWGVc=
X-Google-Smtp-Source: ABdhPJww/mH4JeZkOxyy6unI/bkZQkh23ChejAdpe/msVcgoHNZ7EjqsxaweoWsZLgt1vQhkJ6Bujw==
X-Received: by 2002:a05:6512:32a1:: with SMTP id q1mr42540lfe.561.1604533518413;
        Wed, 04 Nov 2020 15:45:18 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:17 -0800 (PST)
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
Subject: [PATCH v1 16/30] gpu: host1x: Support OPP and SoC core voltage scaling
Date:   Thu,  5 Nov 2020 02:44:13 +0300
Message-Id: <20201104234427.26477-17-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add initial OPP and SoC core voltage scaling support to the Host1x driver.
This is required for enabling system-wide DVFS on older Tegra SoCs.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/Kconfig |  1 +
 drivers/gpu/host1x/dev.c   | 87 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
index 6dab94adf25e..fba4207c35a4 100644
--- a/drivers/gpu/host1x/Kconfig
+++ b/drivers/gpu/host1x/Kconfig
@@ -3,6 +3,7 @@ config TEGRA_HOST1X
 	tristate "NVIDIA Tegra host1x driver"
 	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
 	select IOMMU_IOVA
+	select PM_OPP
 	help
 	  Driver for the NVIDIA Tegra host1x hardware.
 
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d0ebb70e2fdd..06e65dc1ab19 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -13,6 +13,9 @@
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/pm_opp.h>
+
+#include <soc/tegra/fuse.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/host1x.h>
@@ -341,6 +344,85 @@ static void host1x_iommu_exit(struct host1x *host)
 	}
 }
 
+static void host1x_deinit_opp_table(void *data)
+{
+	struct device *dev = data;
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_put_supported_hw(opp_table);
+	dev_pm_opp_put_regulators(opp_table);
+	dev_pm_opp_put_opp_table(opp_table);
+}
+
+static int devm_host1x_init_opp_table(struct host1x *host)
+{
+	struct opp_table *opp_table, *hw_opp_table;
+	const char *rname = "core";
+	u32 hw_version;
+	int err;
+
+	/* voltage scaling is optional */
+	if (device_property_present(host->dev, "core-supply"))
+		opp_table = dev_pm_opp_set_regulators(host->dev, &rname, 1);
+	else
+		opp_table = dev_pm_opp_get_opp_table(host->dev);
+
+	if (IS_ERR(opp_table))
+		return dev_err_probe(host->dev, PTR_ERR(opp_table),
+				     "failed to prepare OPP table\n");
+
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		hw_version = BIT(tegra_sku_info.soc_process_id);
+	else
+		hw_version = BIT(tegra_sku_info.soc_speedo_id);
+
+	hw_opp_table = dev_pm_opp_set_supported_hw(host->dev, &hw_version, 1);
+	err = PTR_ERR_OR_ZERO(hw_opp_table);
+	if (err) {
+		dev_err(host->dev, "failed to set supported HW: %d\n", err);
+		goto put_table;
+	}
+
+	/*
+	 * OPP table presence is optional and we want the set_rate() of OPP
+	 * API to work similarly to clk_set_rate() if table is missing in a
+	 * device-tree.  The add_table() errors out if OPP is missing in DT.
+	 */
+	if (device_property_present(host->dev, "operating-points-v2")) {
+		err = dev_pm_opp_of_add_table(host->dev);
+		if (err) {
+			dev_err(host->dev, "failed to add OPP table: %d\n", err);
+			goto put_hw;
+		}
+	}
+
+	/* first dummy rate-set initializes voltage vote */
+	err = dev_pm_opp_set_rate(host->dev, clk_get_rate(host->clk));
+	if (err) {
+		dev_err(host->dev, "failed to initialize OPP clock: %d\n", err);
+		goto remove_table;
+	}
+
+	err = devm_add_action(host->dev, host1x_deinit_opp_table, host->dev);
+	if (err)
+		goto remove_table;
+
+	dev_info(host->dev, "OPP HW ver. 0x%x\n", hw_version);
+
+	return 0;
+
+remove_table:
+	dev_pm_opp_of_remove_table(host->dev);
+put_hw:
+	dev_pm_opp_put_supported_hw(opp_table);
+put_table:
+	dev_pm_opp_put_regulators(opp_table);
+
+	return err;
+}
+
 static int host1x_probe(struct platform_device *pdev)
 {
 	struct host1x *host;
@@ -424,6 +506,11 @@ static int host1x_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = devm_host1x_init_opp_table(host);
+	if (err < 0)
+		return dev_err_probe(&pdev->dev, err,
+				     "failed to initialize OPP\n");
+
 	err = host1x_iommu_init(host);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to setup IOMMU: %d\n", err);
-- 
2.27.0

