Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51DA408090
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhILUMW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbhILULZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:11:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67EC0613D8;
        Sun, 12 Sep 2021 13:10:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso5422817wmb.2;
        Sun, 12 Sep 2021 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7l87AQCg+9YN7Ynq6M+cEyBEDSi0ioOxwMZ9EVF2Htg=;
        b=nB9cTZMGl6CjAdOD9Ws4Mi5qhbKKNpMj6XQKojq0aVH6lJbsn+PIwHwueE8ft7uEkA
         b+ssg7127SbJrBAlzwGOoePb7P4bXOAFx/jNdG14mRD4MRFCVQcJPw25+rCSx2O39I84
         dXgHPa+7owiTAeZW5BvBdDTeWIQz4eV9hsWVphrHD4uET8mkPifIX0BB84e1c69Mu8Bf
         ++6sBp/HD3oarRYm62hGlR8bNX0ynZsv3qiiu9rZ9eALuBIvwUk8A6kzi4POHOEHOtJ/
         1SrMV7Ittq6Vf3/eigNNV1a0xr/dwrbq8FWsONPxPiY4Z6lZV3iC+LirVo7XmbBtIxLE
         cSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7l87AQCg+9YN7Ynq6M+cEyBEDSi0ioOxwMZ9EVF2Htg=;
        b=hz6Rps4cMvF60r5q4G4kQJUvp+9lp6N5hNH4/0b5eh2kdtHjss5K1zTeg2F+GL1ND6
         9YvvCYDKb6tJHuzY68Kag9tp6f9oH7Tax9aCGhDk+ChuvLLpDJyg59oQettW9A0dM5fr
         7P+gRDL0v7r3f1tVcjMbP+mSWTg8ADQHc7h243QoMtdFlkS3ZY8zHth8FJ9xPRGwnkT7
         jKhPOGVG3Llo6kYcoh0OQGY9PafkMQRhPCUVKgJDlJ7bzHddpMGoW+VyIz0q2aWF4t3b
         UADabJ7sKo9x2Z2uzr6ecyo8IOBPBq1iPnL5D+Ig5GVetdmiXGFc/O62+7sKYZXKY50O
         0LRw==
X-Gm-Message-State: AOAM530graQW8GmsVkygm8/EJr+DklZwRuE9vXGz9hdYgOhIWWmVjdBs
        ZB5vZ9cLpLqQvOQPOFtv+dY=
X-Google-Smtp-Source: ABdhPJyDLZq1Vp3bNXgPEjVjjvWaakODfLJyAE1dEA8P1l+OfMMXmH63qqtr7IXV0blfBKR9sqmIAA==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr7919714wmc.132.1631477407551;
        Sun, 12 Sep 2021 13:10:07 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:07 -0700 (PDT)
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
Subject: [PATCH v11 14/34] drm/tegra: gr3d: Support generic power domain and runtime PM
Date:   Sun, 12 Sep 2021 23:08:12 +0300
Message-Id: <20210912200832.12312-15-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add runtime power management and support generic power domains.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 388 ++++++++++++++++++++++++++++++-----
 1 file changed, 332 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 24442ade0da3..5879402ae55e 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -5,32 +5,47 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/host1x.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/pmc.h>
 
 #include "drm.h"
 #include "gem.h"
 #include "gr3d.h"
 
+enum {
+	RST_MC,
+	RST_GR3D,
+	RST_MC2,
+	RST_GR3D2,
+	RST_GR3D_MAX,
+};
+
 struct gr3d_soc {
 	unsigned int version;
+	unsigned int num_clocks;
+	unsigned int num_resets;
 };
 
 struct gr3d {
 	struct tegra_drm_client client;
 	struct host1x_channel *channel;
-	struct clk *clk_secondary;
-	struct clk *clk;
-	struct reset_control *rst_secondary;
-	struct reset_control *rst;
 
 	const struct gr3d_soc *soc;
+	struct clk_bulk_data *clocks;
+	unsigned int nclocks;
+	struct reset_control_bulk_data resets[RST_GR3D_MAX];
+	unsigned int nresets;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
 };
@@ -109,16 +124,24 @@ static int gr3d_open_channel(struct tegra_drm_client *client,
 			     struct tegra_drm_context *context)
 {
 	struct gr3d *gr3d = to_gr3d(client);
+	int err;
 
 	context->channel = host1x_channel_get(gr3d->channel);
 	if (!context->channel)
 		return -ENOMEM;
 
+	err = pm_runtime_resume_and_get(client->base.dev);
+	if (err) {
+		host1x_channel_put(context->channel);
+		return err;
+	}
+
 	return 0;
 }
 
 static void gr3d_close_channel(struct tegra_drm_context *context)
 {
+	pm_runtime_put_sync(context->client->base.dev);
 	host1x_channel_put(context->channel);
 }
 
@@ -155,14 +178,20 @@ static const struct tegra_drm_client_ops gr3d_ops = {
 
 static const struct gr3d_soc tegra20_gr3d_soc = {
 	.version = 0x20,
+	.num_clocks = 1,
+	.num_resets = 2,
 };
 
 static const struct gr3d_soc tegra30_gr3d_soc = {
 	.version = 0x30,
+	.num_clocks = 2,
+	.num_resets = 4,
 };
 
 static const struct gr3d_soc tegra114_gr3d_soc = {
 	.version = 0x35,
+	.num_clocks = 1,
+	.num_resets = 2,
 };
 
 static const struct of_device_id tegra_gr3d_match[] = {
@@ -278,69 +307,240 @@ static const u32 gr3d_addr_regs[] = {
 	GR3D_GLOBAL_SAMP23SURFADDR(15),
 };
 
-static int gr3d_probe(struct platform_device *pdev)
+static int gr3d_power_up_legacy_domain(struct device *dev, const char *name,
+				       unsigned int id)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct host1x_syncpt **syncpts;
-	struct gr3d *gr3d;
+	struct gr3d *gr3d = dev_get_drvdata(dev);
+	struct reset_control *reset;
+	struct clk *clk;
 	unsigned int i;
 	int err;
 
-	gr3d = devm_kzalloc(&pdev->dev, sizeof(*gr3d), GFP_KERNEL);
-	if (!gr3d)
-		return -ENOMEM;
-
-	gr3d->soc = of_device_get_match_data(&pdev->dev);
+	/*
+	 * Tegra20 device-tree doesn't specify 3d clock name and there is only
+	 * one clock for Tegra20. Tegra30+ device-trees always specified names
+	 * for the clocks.
+	 */
+	if (gr3d->nclocks == 1) {
+		if (id == TEGRA_POWERGATE_3D1)
+			return 0;
+
+		clk = gr3d->clocks[0].clk;
+	} else {
+		for (i = 0; i < gr3d->nclocks; i++) {
+			if (WARN_ON(!gr3d->clocks[i].id))
+				continue;
+
+			if (!strcmp(gr3d->clocks[i].id, name)) {
+				clk = gr3d->clocks[i].clk;
+				break;
+			}
+		}
 
-	syncpts = devm_kzalloc(&pdev->dev, sizeof(*syncpts), GFP_KERNEL);
-	if (!syncpts)
-		return -ENOMEM;
+		if (WARN_ON(i == gr3d->nclocks))
+			return -EINVAL;
+	}
 
-	gr3d->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(gr3d->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
-		return PTR_ERR(gr3d->clk);
+	/*
+	 * We use array of resets, which includes MC resets, and MC
+	 * reset shouldn't be asserted while hardware is gated because
+	 * MC flushing will fail for gated hardware. Hence for legacy
+	 * PD we request the individual reset separately.
+	 */
+	reset = reset_control_get_exclusive_released(dev, name);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	err = reset_control_acquire(reset);
+	if (err) {
+		dev_err(dev, "failed to acquire %s reset: %d\n", name, err);
+	} else {
+		err = tegra_powergate_sequence_power_up(id, clk, reset);
+		reset_control_release(reset);
 	}
 
-	gr3d->rst = devm_reset_control_get(&pdev->dev, "3d");
-	if (IS_ERR(gr3d->rst)) {
-		dev_err(&pdev->dev, "cannot get reset\n");
-		return PTR_ERR(gr3d->rst);
+	reset_control_put(reset);
+	if (err)
+		return err;
+
+	/*
+	 * tegra_powergate_sequence_power_up() leaves clocks enabled
+	 * while GENPD not, hence keep clock-enable balanced.
+	 */
+	clk_disable_unprepare(clk);
+
+	return 0;
+}
+
+static void gr3d_del_link(void *link)
+{
+	device_link_del(link);
+}
+
+static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
+{
+	static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };
+	const u32 link_flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
+	struct device **opp_virt_devs, *pd_dev;
+	struct device_link *link;
+	unsigned int i;
+	int err;
+
+	err = of_count_phandle_with_args(dev->of_node, "power-domains",
+					 "#power-domain-cells");
+	if (err < 0) {
+		if (err != -ENOENT)
+			return err;
+
+		/*
+		 * Older device-trees don't use GENPD. In this case we should
+		 * toggle power domain manually.
+		 */
+		err = gr3d_power_up_legacy_domain(dev, "3d",
+						  TEGRA_POWERGATE_3D);
+		if (err)
+			return err;
+
+		err = gr3d_power_up_legacy_domain(dev, "3d2",
+						  TEGRA_POWERGATE_3D1);
+		if (err)
+			return err;
+
+		return 0;
 	}
 
-	if (of_device_is_compatible(np, "nvidia,tegra30-gr3d")) {
-		gr3d->clk_secondary = devm_clk_get(&pdev->dev, "3d2");
-		if (IS_ERR(gr3d->clk_secondary)) {
-			dev_err(&pdev->dev, "cannot get secondary clock\n");
-			return PTR_ERR(gr3d->clk_secondary);
+	/*
+	 * The PM domain core automatically attaches a single power domain,
+	 * otherwise it skips attaching completely. We have a single domain
+	 * on Tegra20 and two domains on Tegra30+.
+	 */
+	if (dev->pm_domain)
+		return 0;
+
+	err = devm_pm_opp_attach_genpd(dev, opp_genpd_names, &opp_virt_devs);
+	if (err)
+		return err;
+
+	for (i = 0; opp_genpd_names[i]; i++) {
+		pd_dev = opp_virt_devs[i];
+		if (!pd_dev) {
+			dev_err(dev, "failed to get %s power domain\n",
+				opp_genpd_names[i]);
+			return -EINVAL;
 		}
 
-		gr3d->rst_secondary = devm_reset_control_get(&pdev->dev,
-								"3d2");
-		if (IS_ERR(gr3d->rst_secondary)) {
-			dev_err(&pdev->dev, "cannot get secondary reset\n");
-			return PTR_ERR(gr3d->rst_secondary);
+		link = device_link_add(dev, pd_dev, link_flags);
+		if (!link) {
+			dev_err(dev, "failed to link to %s\n", dev_name(pd_dev));
+			return -EINVAL;
 		}
+
+		err = devm_add_action_or_reset(dev, gr3d_del_link, link);
+		if (err)
+			return err;
 	}
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D, gr3d->clk,
-						gr3d->rst);
+	return 0;
+}
+
+static int gr3d_set_opp(struct dev_pm_set_opp_data *data)
+{
+	struct gr3d *gr3d = dev_get_drvdata(data->dev);
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < gr3d->nclocks; i++) {
+		err = clk_set_rate(gr3d->clocks[i].clk, data->new_opp.rate);
+		if (err) {
+			dev_err(data->dev, "failed to set %s rate to %lu: %d\n",
+				gr3d->clocks[i].id, data->new_opp.rate, err);
+			goto restore;
+		}
+	}
+
+	return 0;
+
+restore:
+	while (i--)
+		clk_set_rate(gr3d->clocks[i].clk, data->old_opp.rate);
+
+	return err;
+}
+
+static int gr3d_get_clocks(struct device *dev, struct gr3d *gr3d)
+{
+	int err;
+
+	err = devm_clk_bulk_get_all(dev, &gr3d->clocks);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to power up 3D unit\n");
+		dev_err(dev, "failed to get clock: %d\n", err);
 		return err;
 	}
+	gr3d->nclocks = err;
 
-	if (gr3d->clk_secondary) {
-		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D1,
-							gr3d->clk_secondary,
-							gr3d->rst_secondary);
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"failed to power up secondary 3D unit\n");
-			return err;
-		}
+	if (gr3d->nclocks != gr3d->soc->num_clocks) {
+		dev_err(dev, "invalid number of clocks: %u\n", gr3d->nclocks);
+		return -ENOENT;
 	}
 
+	return 0;
+}
+
+static int gr3d_get_resets(struct device *dev, struct gr3d *gr3d)
+{
+	int err;
+
+	gr3d->resets[RST_MC].id = "mc";
+	gr3d->resets[RST_MC2].id = "mc2";
+	gr3d->resets[RST_GR3D].id = "3d";
+	gr3d->resets[RST_GR3D2].id = "3d2";
+	gr3d->nresets = gr3d->soc->num_resets;
+
+	err = devm_reset_control_bulk_get_optional_exclusive_released(
+				dev, gr3d->nresets, gr3d->resets);
+	if (err) {
+		dev_err(dev, "failed to get reset: %d\n", err);
+		return err;
+	}
+
+	if (WARN_ON(!gr3d->resets[RST_GR3D].rstc) ||
+	    WARN_ON(!gr3d->resets[RST_GR3D2].rstc && gr3d->nresets == 4))
+		return -ENOENT;
+
+	return 0;
+}
+
+static int gr3d_probe(struct platform_device *pdev)
+{
+	struct host1x_syncpt **syncpts;
+	struct gr3d *gr3d;
+	unsigned int i;
+	int err;
+
+	gr3d = devm_kzalloc(&pdev->dev, sizeof(*gr3d), GFP_KERNEL);
+	if (!gr3d)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, gr3d);
+
+	gr3d->soc = of_device_get_match_data(&pdev->dev);
+
+	syncpts = devm_kzalloc(&pdev->dev, sizeof(*syncpts), GFP_KERNEL);
+	if (!syncpts)
+		return -ENOMEM;
+
+	err = gr3d_get_clocks(&pdev->dev, gr3d);
+	if (err)
+		return err;
+
+	err = gr3d_get_resets(&pdev->dev, gr3d);
+	if (err)
+		return err;
+
+	err = gr3d_init_power(&pdev->dev, gr3d);
+	if (err)
+		return err;
+
 	INIT_LIST_HEAD(&gr3d->client.base.list);
 	gr3d->client.base.ops = &gr3d_client_ops;
 	gr3d->client.base.dev = &pdev->dev;
@@ -352,20 +552,36 @@ static int gr3d_probe(struct platform_device *pdev)
 	gr3d->client.version = gr3d->soc->version;
 	gr3d->client.ops = &gr3d_ops;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 200);
+
+	err = devm_pm_opp_register_set_opp_helper(&pdev->dev, gr3d_set_opp);
+	if (err)
+		goto disable_rpm;
+
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		goto disable_rpm;
+
 	err = host1x_client_register(&gr3d->client.base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto disable_rpm;
 	}
 
 	/* initialize address register map */
 	for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
 		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
 
-	platform_set_drvdata(pdev, gr3d);
-
 	return 0;
+
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return err;
 }
 
 static int gr3d_remove(struct platform_device *pdev)
@@ -380,23 +596,83 @@ static int gr3d_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	if (gr3d->clk_secondary) {
-		reset_control_assert(gr3d->rst_secondary);
-		tegra_powergate_power_off(TEGRA_POWERGATE_3D1);
-		clk_disable_unprepare(gr3d->clk_secondary);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused gr3d_runtime_suspend(struct device *dev)
+{
+	struct gr3d *gr3d = dev_get_drvdata(dev);
+	int err;
+
+	host1x_channel_stop(gr3d->channel);
+
+	err = reset_control_bulk_assert(gr3d->nresets, gr3d->resets);
+	if (err) {
+		dev_err(dev, "failed to assert reset: %d\n", err);
+		return err;
+	}
+
+	usleep_range(10, 20);
+
+	/*
+	 * Older device-trees don't specify MC resets and power-gating can't
+	 * be done safely in that case. Hence we will keep the power ungated
+	 * for older DTBs. For newer DTBs, GENPD will perform the power-gating.
+	 */
+
+	clk_bulk_disable_unprepare(gr3d->nclocks, gr3d->clocks);
+	reset_control_bulk_release(gr3d->nresets, gr3d->resets);
+
+	return 0;
+}
+
+static int __maybe_unused gr3d_runtime_resume(struct device *dev)
+{
+	struct gr3d *gr3d = dev_get_drvdata(dev);
+	int err;
+
+	err = reset_control_bulk_acquire(gr3d->nresets, gr3d->resets);
+	if (err) {
+		dev_err(dev, "failed to acquire reset: %d\n", err);
+		return err;
+	}
+
+	err = clk_bulk_prepare_enable(gr3d->nclocks, gr3d->clocks);
+	if (err) {
+		dev_err(dev, "failed to enable clock: %d\n", err);
+		goto release_reset;
 	}
 
-	reset_control_assert(gr3d->rst);
-	tegra_powergate_power_off(TEGRA_POWERGATE_3D);
-	clk_disable_unprepare(gr3d->clk);
+	err = reset_control_bulk_deassert(gr3d->nresets, gr3d->resets);
+	if (err) {
+		dev_err(dev, "failed to deassert reset: %d\n", err);
+		goto disable_clk;
+	}
 
 	return 0;
+
+disable_clk:
+	clk_bulk_disable_unprepare(gr3d->nclocks, gr3d->clocks);
+release_reset:
+	reset_control_bulk_release(gr3d->nresets, gr3d->resets);
+
+	return err;
 }
 
+static const struct dev_pm_ops tegra_gr3d_pm = {
+	SET_RUNTIME_PM_OPS(gr3d_runtime_suspend, gr3d_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 struct platform_driver tegra_gr3d_driver = {
 	.driver = {
 		.name = "tegra-gr3d",
 		.of_match_table = tegra_gr3d_match,
+		.pm = &tegra_gr3d_pm,
 	},
 	.probe = gr3d_probe,
 	.remove = gr3d_remove,
-- 
2.32.0

