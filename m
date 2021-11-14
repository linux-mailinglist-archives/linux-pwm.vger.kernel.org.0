Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26D44FABF
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbhKNTj0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbhKNTjG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:06 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6728C061200;
        Sun, 14 Nov 2021 11:36:09 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu18so37669910lfb.0;
        Sun, 14 Nov 2021 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrcx3ebOXSKCKj/lFYPCq7jZElHGdupDCEeFgkna+vE=;
        b=blQrJbGTBFDTVi3ct+m1h4VB6CT3Ke9sSwAimCI5ZSMbNDofSPHs7f/Lz/uB+yzyEF
         GlF1KcRy3WZvl9NdCWkNveZJ1ucjbc3IBm0LbIumyhIBBu/T/B4QFZbU8BBJg6CD3i+x
         AXmQ6Ay3FjD5+rKIbP77A801lL305pOy6iDoCql/Dabzt8WxDnPuUCN8YO4KedqYKq09
         h93iaf3nhwcTp3+FHfg9WmcCkIgcuWqb0bgpjO6HxCRSEpiylJettSpva3T+00EuLPx3
         mOXaODu6waiixOx2HmfrDLpQupjIWa75xcJkkFU8kycKu8SJiJtcYrRldgNKov0lwgq5
         qj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrcx3ebOXSKCKj/lFYPCq7jZElHGdupDCEeFgkna+vE=;
        b=nuOfO/i7tLPevs9FoZ9iLpofXqKQLOhUkXr2yk8yEt/3EvzfxskATK1xq/QBeHJj5n
         fWkyvFff/LOQSo0CmyEE8vHs3Ww9dlUlVpogp7xgy4tuOU56HcWaxI3bX4QE89ctcJ8R
         JNG4Oe9kliBL8JxMsxGAFu4ELPz/or6cLEyNLMRlNuDSR5ixVAtmgBVBUdTsZyr0ilVr
         ybMnjkS5CwbIgtNfzv4JGVOwnUXK7S6/wlhOUQwBizrpDLjZsNvTXa/Pb7pBthtBIcPD
         3+1coIoYqbUrpOI9se7S9Q+An9tYyfXFSm2q465R3wd+/Dn5qcjmZZyGXGEfekVPuF5r
         Qpog==
X-Gm-Message-State: AOAM532M8hDVX00oEab5oVbDFN5HH/WJtvh6DmqqjXizG79vYp04/JZd
        yF/U4Ma9S+s9RDHDXE1ZuPQ=
X-Google-Smtp-Source: ABdhPJwRSfDM/qBxY/QPuJNBASHm8NrGGu5+0RjC5FDoDXk/9RabcVO48up1UzIpXq09+EPpZEwRIQ==
X-Received: by 2002:a05:6512:13a5:: with SMTP id p37mr29639382lfa.474.1636918568179;
        Sun, 14 Nov 2021 11:36:08 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:07 -0800 (PST)
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
Subject: [PATCH v15 12/39] drm/tegra: gr2d: Support generic power domain and runtime PM
Date:   Sun, 14 Nov 2021 22:34:08 +0300
Message-Id: <20211114193435.7705-13-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add runtime power management and support generic power domains.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 184 ++++++++++++++++++++++++++++-------
 1 file changed, 148 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index ba3722f1b865..b4cd7655b3dc 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -8,12 +8,21 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #include "drm.h"
 #include "gem.h"
 #include "gr2d.h"
 
+enum {
+	RST_MC,
+	RST_GR2D,
+	RST_GR2D_MAX,
+};
+
 struct gr2d_soc {
 	unsigned int version;
 };
@@ -21,9 +30,11 @@ struct gr2d_soc {
 struct gr2d {
 	struct tegra_drm_client client;
 	struct host1x_channel *channel;
-	struct reset_control *rst;
 	struct clk *clk;
 
+	struct reset_control_bulk_data resets[RST_GR2D_MAX];
+	unsigned int nresets;
+
 	const struct gr2d_soc *soc;
 
 	DECLARE_BITMAP(addr_regs, GR2D_NUM_REGS);
@@ -59,15 +70,22 @@ static int gr2d_init(struct host1x_client *client)
 		goto free;
 	}
 
+	pm_runtime_enable(client->dev);
+	pm_runtime_use_autosuspend(client->dev);
+	pm_runtime_set_autosuspend_delay(client->dev, 200);
+
 	err = tegra_drm_register_client(dev->dev_private, drm);
 	if (err < 0) {
 		dev_err(client->dev, "failed to register client: %d\n", err);
-		goto detach;
+		goto disable_rpm;
 	}
 
 	return 0;
 
-detach:
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_client_iommu_detach(client);
 free:
 	host1x_syncpt_put(client->syncpts[0]);
@@ -88,10 +106,15 @@ static int gr2d_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
+	pm_runtime_dont_use_autosuspend(client->dev);
+	pm_runtime_force_suspend(client->dev);
+
 	host1x_client_iommu_detach(client);
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(gr2d->channel);
 
+	gr2d->channel = NULL;
+
 	return 0;
 }
 
@@ -104,10 +127,17 @@ static int gr2d_open_channel(struct tegra_drm_client *client,
 			     struct tegra_drm_context *context)
 {
 	struct gr2d *gr2d = to_gr2d(client);
+	int err;
+
+	err = pm_runtime_resume_and_get(client->base.dev);
+	if (err)
+		return err;
 
 	context->channel = host1x_channel_get(gr2d->channel);
-	if (!context->channel)
+	if (!context->channel) {
+		pm_runtime_put(context->client->base.dev);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -115,6 +145,7 @@ static int gr2d_open_channel(struct tegra_drm_client *client,
 static void gr2d_close_channel(struct tegra_drm_context *context)
 {
 	host1x_channel_put(context->channel);
+	pm_runtime_put(context->client->base.dev);
 }
 
 static int gr2d_is_addr_reg(struct device *dev, u32 class, u32 offset)
@@ -193,6 +224,27 @@ static const u32 gr2d_addr_regs[] = {
 	GR2D_VA_BASE_ADDR_SB,
 };
 
+static int gr2d_get_resets(struct device *dev, struct gr2d *gr2d)
+{
+	int err;
+
+	gr2d->resets[RST_MC].id = "mc";
+	gr2d->resets[RST_GR2D].id = "2d";
+	gr2d->nresets = RST_GR2D_MAX;
+
+	err = devm_reset_control_bulk_get_optional_exclusive_released(
+				dev, gr2d->nresets, gr2d->resets);
+	if (err) {
+		dev_err(dev, "failed to get reset: %d\n", err);
+		return err;
+	}
+
+	if (WARN_ON(!gr2d->resets[RST_GR2D].rstc))
+		return -ENOENT;
+
+	return 0;
+}
+
 static int gr2d_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -205,37 +257,23 @@ static int gr2d_probe(struct platform_device *pdev)
 	if (!gr2d)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, gr2d);
+
 	gr2d->soc = of_device_get_match_data(dev);
 
 	syncpts = devm_kzalloc(dev, sizeof(*syncpts), GFP_KERNEL);
 	if (!syncpts)
 		return -ENOMEM;
 
-	gr2d->rst = devm_reset_control_get(dev, NULL);
-	if (IS_ERR(gr2d->rst)) {
-		dev_err(dev, "cannot get reset\n");
-		return PTR_ERR(gr2d->rst);
-	}
-
 	gr2d->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(gr2d->clk)) {
 		dev_err(dev, "cannot get clock\n");
 		return PTR_ERR(gr2d->clk);
 	}
 
-	err = clk_prepare_enable(gr2d->clk);
-	if (err) {
-		dev_err(dev, "cannot turn on clock\n");
+	err = gr2d_get_resets(dev, gr2d);
+	if (err)
 		return err;
-	}
-
-	usleep_range(2000, 4000);
-
-	err = reset_control_deassert(gr2d->rst);
-	if (err < 0) {
-		dev_err(dev, "failed to deassert reset: %d\n", err);
-		goto disable_clk;
-	}
 
 	INIT_LIST_HEAD(&gr2d->client.base.list);
 	gr2d->client.base.ops = &gr2d_client_ops;
@@ -248,26 +286,21 @@ static int gr2d_probe(struct platform_device *pdev)
 	gr2d->client.version = gr2d->soc->version;
 	gr2d->client.ops = &gr2d_ops;
 
+	err = devm_tegra_core_dev_init_opp_table_common(dev);
+	if (err)
+		return err;
+
 	err = host1x_client_register(&gr2d->client.base);
 	if (err < 0) {
 		dev_err(dev, "failed to register host1x client: %d\n", err);
-		goto assert_rst;
+		return err;
 	}
 
 	/* initialize address register map */
 	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
 		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
 
-	platform_set_drvdata(pdev, gr2d);
-
 	return 0;
-
-assert_rst:
-	(void)reset_control_assert(gr2d->rst);
-disable_clk:
-	clk_disable_unprepare(gr2d->clk);
-
-	return err;
 }
 
 static int gr2d_remove(struct platform_device *pdev)
@@ -282,21 +315,100 @@ static int gr2d_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	err = reset_control_assert(gr2d->rst);
-	if (err < 0)
-		dev_err(&pdev->dev, "failed to assert reset: %d\n", err);
+	return 0;
+}
 
-	usleep_range(2000, 4000);
+static int __maybe_unused gr2d_runtime_suspend(struct device *dev)
+{
+	struct gr2d *gr2d = dev_get_drvdata(dev);
+	int err;
+
+	host1x_channel_stop(gr2d->channel);
+	reset_control_bulk_release(gr2d->nresets, gr2d->resets);
+
+	/*
+	 * GR2D module shouldn't be reset while hardware is idling, otherwise
+	 * host1x's cmdproc will stuck on trying to access any G2 register
+	 * after reset. GR2D module could be either hot-reset or reset after
+	 * power-gating of the HEG partition. Hence we will put in reset only
+	 * the memory client part of the module, the HEG GENPD will take care
+	 * of resetting GR2D module across power-gating.
+	 *
+	 * On Tegra20 there is no HEG partition, but it's okay to have
+	 * undetermined h/w state since userspace is expected to reprogram
+	 * the state on each job submission anyways.
+	 */
+	err = reset_control_acquire(gr2d->resets[RST_MC].rstc);
+	if (err) {
+		dev_err(dev, "failed to acquire MC reset: %d\n", err);
+		goto acquire_reset;
+	}
+
+	err = reset_control_assert(gr2d->resets[RST_MC].rstc);
+	reset_control_release(gr2d->resets[RST_MC].rstc);
+	if (err) {
+		dev_err(dev, "failed to assert MC reset: %d\n", err);
+		goto acquire_reset;
+	}
 
 	clk_disable_unprepare(gr2d->clk);
 
 	return 0;
+
+acquire_reset:
+	reset_control_bulk_acquire(gr2d->nresets, gr2d->resets);
+	reset_control_bulk_deassert(gr2d->nresets, gr2d->resets);
+
+	return err;
+}
+
+static int __maybe_unused gr2d_runtime_resume(struct device *dev)
+{
+	struct gr2d *gr2d = dev_get_drvdata(dev);
+	int err;
+
+	err = reset_control_bulk_acquire(gr2d->nresets, gr2d->resets);
+	if (err) {
+		dev_err(dev, "failed to acquire reset: %d\n", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(gr2d->clk);
+	if (err) {
+		dev_err(dev, "failed to enable clock: %d\n", err);
+		goto release_reset;
+	}
+
+	usleep_range(2000, 4000);
+
+	/* this is a reset array which deasserts both 2D MC and 2D itself */
+	err = reset_control_bulk_deassert(gr2d->nresets, gr2d->resets);
+	if (err) {
+		dev_err(dev, "failed to deassert reset: %d\n", err);
+		goto disable_clk;
+	}
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(gr2d->clk);
+release_reset:
+	reset_control_bulk_release(gr2d->nresets, gr2d->resets);
+
+	return err;
 }
 
+static const struct dev_pm_ops tegra_gr2d_pm = {
+	SET_RUNTIME_PM_OPS(gr2d_runtime_suspend, gr2d_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 struct platform_driver tegra_gr2d_driver = {
 	.driver = {
 		.name = "tegra-gr2d",
 		.of_match_table = gr2d_match,
+		.pm = &tegra_gr2d_pm,
 	},
 	.probe = gr2d_probe,
 	.remove = gr2d_remove,
-- 
2.33.1

