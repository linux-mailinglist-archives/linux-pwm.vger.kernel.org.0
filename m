Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA3408089
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhILUMU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhILULX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:11:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42CC061766;
        Sun, 12 Sep 2021 13:10:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u15so5263990wru.6;
        Sun, 12 Sep 2021 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4Ar1sKgIFsBbBlQEbxczmgkR6jb9rRmAkGMRfPTYAk=;
        b=YMdyYmNoxX4KImCuCRLUvz/BqMMXR5rO/ohqxfdi+mTYs5uVb0oI3en6K3byOuFSHt
         9Nb7e6cfL9j4u/SjKcA3JziAv0/OTLf3mD0oFecJq4bG9QBKvu4x1lxC8h15JR9l45j+
         Z6BvRSvRvbMILiob8JZjsgQZEsky75tbyg8MeBG07ad/YTw59XmBxe5t6bLi1/KyXFuX
         lI3PcSuareoPYwvfh167/4E68rpLLQ4YDKhYlNLIcvHKtxZEfJpz5C40xNaUy1IJizeA
         Gq3BzDtjB8Jv6QayTw8QHzMcp+OSkDOOninALWHm8ldO1Sn23T7ZUAWX+1x1WmepJ+ZP
         Tqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4Ar1sKgIFsBbBlQEbxczmgkR6jb9rRmAkGMRfPTYAk=;
        b=sj9/ABdcMMH7XR0P+3VeQATtFX2S+DEaRw6BqVIuzN3gQnSgDJWaXbx3dHffsSyw1J
         AoM+3NnhupnrowSWqgK+mUgKSl6ji7mSz8767Ki9w8sLrbjp7UxfaMWH93bhyTGkmjsq
         MpsrFp5RzeIq1f32YAAwW0bzNBeupqhmY/avGAkMW/XRZHaGpyuRUREmwvOB2jUFXLDJ
         0GY0WkkWrS7gnmxsPlnE0F76PEpihbpm2GOpU1aTbS9nC+y66rOlGCeHPaksuqwlyItR
         Ddr3NewM/1xTqwu4FY9l2IwQ7evI7DkmzLmvgNjTDUwjR5j7CGF87Dwhn80Bc+1qZpcz
         C9gQ==
X-Gm-Message-State: AOAM533zslxR7YSfs2azN0TYTMG2F29yOpozUxY4XnotFXai45LuHA7W
        0XSJ5HCHW2UWP6OxMAL6+uY=
X-Google-Smtp-Source: ABdhPJyuGuFbyyKP3Wm2YAHNQkU+8Sudg2ERER1D3crjEYEKcD2fS5mQ70fXmO1xz59pbj46NGGCqw==
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr9073091wrx.147.1631477405354;
        Sun, 12 Sep 2021 13:10:05 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:05 -0700 (PDT)
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
Subject: [PATCH v11 13/34] drm/tegra: gr2d: Support generic power domain and runtime PM
Date:   Sun, 12 Sep 2021 23:08:11 +0300
Message-Id: <20210912200832.12312-14-digetx@gmail.com>
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
 drivers/gpu/drm/tegra/gr2d.c | 155 +++++++++++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index de288cba3905..13df8f118f75 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -7,11 +7,21 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include <soc/tegra/common.h>
 
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
@@ -21,6 +31,9 @@ struct gr2d {
 	struct host1x_channel *channel;
 	struct clk *clk;
 
+	struct reset_control_bulk_data resets[RST_GR2D_MAX];
+	unsigned int nresets;
+
 	const struct gr2d_soc *soc;
 
 	DECLARE_BITMAP(addr_regs, GR2D_NUM_REGS);
@@ -101,16 +114,24 @@ static int gr2d_open_channel(struct tegra_drm_client *client,
 			     struct tegra_drm_context *context)
 {
 	struct gr2d *gr2d = to_gr2d(client);
+	int err;
 
 	context->channel = host1x_channel_get(gr2d->channel);
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
 
 static void gr2d_close_channel(struct tegra_drm_context *context)
 {
+	pm_runtime_put_sync(context->client->base.dev);
 	host1x_channel_put(context->channel);
 }
 
@@ -190,6 +211,27 @@ static const u32 gr2d_addr_regs[] = {
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
@@ -202,6 +244,8 @@ static int gr2d_probe(struct platform_device *pdev)
 	if (!gr2d)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, gr2d);
+
 	gr2d->soc = of_device_get_match_data(dev);
 
 	syncpts = devm_kzalloc(dev, sizeof(*syncpts), GFP_KERNEL);
@@ -214,11 +258,9 @@ static int gr2d_probe(struct platform_device *pdev)
 		return PTR_ERR(gr2d->clk);
 	}
 
-	err = clk_prepare_enable(gr2d->clk);
-	if (err) {
-		dev_err(dev, "cannot turn on clock\n");
+	err = gr2d_get_resets(dev, gr2d);
+	if (err)
 		return err;
-	}
 
 	INIT_LIST_HEAD(&gr2d->client.base.list);
 	gr2d->client.base.ops = &gr2d_client_ops;
@@ -231,20 +273,31 @@ static int gr2d_probe(struct platform_device *pdev)
 	gr2d->client.version = gr2d->soc->version;
 	gr2d->client.ops = &gr2d_ops;
 
+	pm_runtime_enable(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 200);
+
+	err = devm_tegra_core_dev_init_opp_table_common(dev);
+	if (err)
+		goto disable_rpm;
+
 	err = host1x_client_register(&gr2d->client.base);
 	if (err < 0) {
 		dev_err(dev, "failed to register host1x client: %d\n", err);
-		clk_disable_unprepare(gr2d->clk);
-		return err;
+		goto disable_rpm;
 	}
 
 	/* initialize address register map */
 	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
 		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
 
-	platform_set_drvdata(pdev, gr2d);
-
 	return 0;
+
+disable_rpm:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+
+	return err;
 }
 
 static int gr2d_remove(struct platform_device *pdev)
@@ -259,15 +312,101 @@ static int gr2d_remove(struct platform_device *pdev)
 		return err;
 	}
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
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
+
 	clk_disable_unprepare(gr2d->clk);
 
 	return 0;
+
+acquire_reset:
+	reset_control_bulk_acquire(gr2d->nresets, gr2d->resets);
+	reset_control_bulk_deassert(gr2d->nresets, gr2d->resets);
+
+	return err;
 }
 
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
+}
+
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
2.32.0

