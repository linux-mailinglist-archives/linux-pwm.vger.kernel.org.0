Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B688E44FAE6
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhKNTjS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhKNTjF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4002C061767;
        Sun, 14 Nov 2021 11:36:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l22so37516809lfg.7;
        Sun, 14 Nov 2021 11:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICJnk3FwYhvBb3ZzWnvNkPNXyskDbLEUXbJt1XZit8o=;
        b=S4oLx04AP93AYYEL7HHTX9339pGpdSKlb5MohXSXktgKPHIiLO5N1opBcNfKHslbuk
         jvjwOphexKzwNDmsus1DxGbwC+y3XNBjMXi2dX94usrwB3IvAMiw3YldaWvNt7HcgpXu
         tvbXUMX2iY3hn3BhhP97pHBdHueCCG9v3gx1yyu4O+THob7aKZt75pV/RrJhdVQ8IyfI
         JJb45vbASgR4zM/vpTVFfhLnQJbm3GjSOsinLOQjbTIqsTlPZ1lUG4t8Wo1vGyI2SMzR
         O4/XHPO3E0zCGdcwA/0Un6qk6XbI+8195kTu6K1UbSkwrFKtG4+rilBlKmtQEzb/Ijlh
         rF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICJnk3FwYhvBb3ZzWnvNkPNXyskDbLEUXbJt1XZit8o=;
        b=FtVnt21Giscz4I7Ho6w+UGRvnheCYnXixYefw9c0DHDER1RThz8XMAQ240yZPbNVMv
         wKw9X85aDUHxknl185CrhXk0DvCdHwU7k4lS25+jDLi1ygGARoWhiaR/S563FZokHQNU
         Fb+E7O4zT/jIm0He7X8tuYhGzf0hTHWa4ee/SOzH7/W7Zlh5HUGO+rWTQndniTC4bKhF
         9q7BfIlN7d3UFC3+bYYFtvlnhoAaZRuTrBhuPTUaICt0/mnII+oCMVtm50PQjKqTZAdB
         TLjTM8jTYCThNfBNcFkF4i3jC07vi7KIoOzDPyA5KmFkt3yCgMDmwtKAECBhh9CsSYsJ
         7dOA==
X-Gm-Message-State: AOAM531wOuzru9OiMfzBmhmbtUS4qrkprJyaXjsDWNHru+a/Cnte+FrJ
        rtmFpM+RslIt/94IY9B46Lw=
X-Google-Smtp-Source: ABdhPJxqJ1+1JaK/Su+w5wPLlnsULsFDAzLK94gNw/dvS7MkqXVVUom5uCRAC33Rf7uOZZqkD9iWww==
X-Received: by 2002:a19:5212:: with SMTP id m18mr30782580lfb.267.1636918566343;
        Sun, 14 Nov 2021 11:36:06 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:06 -0800 (PST)
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
Subject: [PATCH v15 10/39] drm/tegra: dc: Support OPP and SoC core voltage scaling
Date:   Sun, 14 Nov 2021 22:34:06 +0300
Message-Id: <20211114193435.7705-11-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add OPP and SoC core voltage scaling support to the display controller
driver. This is required for enabling system-wide DVFS on pre-Tegra186
SoCs.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 79 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h |  2 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index a457ee954a49..eb70eee8992a 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -11,9 +11,12 @@
 #include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/pmc.h>
 
 #include <drm/drm_atomic.h>
@@ -1834,6 +1837,52 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 	return 0;
 }
 
+static void tegra_dc_update_voltage_state(struct tegra_dc *dc,
+					  struct tegra_dc_state *state)
+{
+	unsigned long rate, pstate;
+	struct dev_pm_opp *opp;
+	int err;
+
+	if (!dc->has_opp_table)
+		return;
+
+	/* calculate actual pixel clock rate which depends on internal divider */
+	rate = DIV_ROUND_UP(clk_get_rate(dc->clk) * 2, state->div + 2);
+
+	/* find suitable OPP for the rate */
+	opp = dev_pm_opp_find_freq_ceil(dc->dev, &rate);
+
+	/*
+	 * Very high resolution modes may results in a clock rate that is
+	 * above the characterized maximum. In this case it's okay to fall
+	 * back to the characterized maximum.
+	 */
+	if (opp == ERR_PTR(-ERANGE))
+		opp = dev_pm_opp_find_freq_floor(dc->dev, &rate);
+
+	if (IS_ERR(opp)) {
+		dev_err(dc->dev, "failed to find OPP for %luHz: %pe\n",
+			rate, opp);
+		return;
+	}
+
+	pstate = dev_pm_opp_get_required_pstate(opp, 0);
+	dev_pm_opp_put(opp);
+
+	/*
+	 * The minimum core voltage depends on the pixel clock rate (which
+	 * depends on internal clock divider of the CRTC) and not on the
+	 * rate of the display controller clock. This is why we're not using
+	 * dev_pm_opp_set_rate() API and instead controlling the power domain
+	 * directly.
+	 */
+	err = dev_pm_genpd_set_performance_state(dc->dev, pstate);
+	if (err)
+		dev_err(dc->dev, "failed to set power domain state to %lu: %d\n",
+			pstate, err);
+}
+
 static void tegra_dc_set_clock_rate(struct tegra_dc *dc,
 				    struct tegra_dc_state *state)
 {
@@ -1867,6 +1916,8 @@ static void tegra_dc_set_clock_rate(struct tegra_dc *dc,
 	DRM_DEBUG_KMS("rate: %lu, div: %u\n", clk_get_rate(dc->clk),
 		      state->div);
 	DRM_DEBUG_KMS("pclk: %lu\n", state->pclk);
+
+	tegra_dc_update_voltage_state(dc, state);
 }
 
 static void tegra_dc_stop(struct tegra_dc *dc)
@@ -2057,6 +2108,13 @@ static void tegra_crtc_atomic_disable(struct drm_crtc *crtc,
 	err = host1x_client_suspend(&dc->client);
 	if (err < 0)
 		dev_err(dc->dev, "failed to suspend: %d\n", err);
+
+	if (dc->has_opp_table) {
+		err = dev_pm_genpd_set_performance_state(dc->dev, 0);
+		if (err)
+			dev_err(dc->dev,
+				"failed to clear power domain state: %d\n", err);
+	}
 }
 
 static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -3058,6 +3116,23 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 	return 0;
 }
 
+static int tegra_dc_init_opp_table(struct tegra_dc *dc)
+{
+	struct tegra_core_opp_params opp_params = {};
+	int err;
+
+	err = devm_tegra_core_dev_init_opp_table(dc->dev, &opp_params);
+	if (err && err != -ENODEV)
+		return err;
+
+	if (err)
+		dc->has_opp_table = false;
+	else
+		dc->has_opp_table = true;
+
+	return 0;
+}
+
 static int tegra_dc_probe(struct platform_device *pdev)
 {
 	u64 dma_mask = dma_get_mask(pdev->dev.parent);
@@ -3123,6 +3198,10 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		tegra_powergate_power_off(dc->powergate);
 	}
 
+	err = tegra_dc_init_opp_table(dc);
+	if (err < 0)
+		return err;
+
 	dc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dc->regs))
 		return PTR_ERR(dc->regs);
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index c9c4c45c0518..3f91a10ea6c7 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -101,6 +101,8 @@ struct tegra_dc {
 	struct drm_info_list *debugfs_files;
 
 	const struct tegra_dc_soc_info *soc;
+
+	bool has_opp_table;
 };
 
 static inline struct tegra_dc *
-- 
2.33.1

