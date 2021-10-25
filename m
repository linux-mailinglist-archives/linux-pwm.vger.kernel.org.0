Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A143A7A8
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhJYWui (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbhJYWth (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:49:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A804C079783;
        Mon, 25 Oct 2021 15:46:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o11so19484969ljg.10;
        Mon, 25 Oct 2021 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vh+d6UNMnZ6MOnoLHUj11In0tvNGndmbN9w3wCCbo0=;
        b=Nc2C8vUiw+PSKkcJCloEe15rwg20peWleu7WmfljdDtMJGDty0rQCvSi7wAqYS7Vqf
         iy+54tgTcW8kZDomYOsgsZb1FVZRcKGjLr8qNcrNRn3633PuJs5m5R4tadgPyZ3bqoB6
         2HliXYkvpt52dl22S3esrlIfF/wJHsdNcwaml47Ykkq7XjIXERmG3XKOP38YVQQfWn9e
         Z7j7IAaigsFmaIGeEmxVzqfXOSG3hThQzu8/jTitla5eWVCmzLUtkZHXpO6j0ULyiZp1
         aUHI5tVy+3Erib+svnnQGaq1UOf5x8yjxlNDbPLUYKbRivh8s77jrii0GQQA4yUNJVuQ
         rPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vh+d6UNMnZ6MOnoLHUj11In0tvNGndmbN9w3wCCbo0=;
        b=AnizyCNusU6EiS2AxDz52SM56pV4a/LudyifhMjBbBfnyqUgr9T+E2Pnm+RuO2aQcO
         Irv8kLMvY0nqBJYWxX0AONgA2zjNy/jfmPVSx3M+bBFlmZm3RJ1S0IJdZ9rF+PcU7W6Z
         R3Q+3OywKVcw9twGwAlyGQGa3JHSlZ9Q3exRVr6meu+IesXsZ+Gjqch1shXc40Qn7B50
         tSixpTWTb13D8dM5QvqbKd8TEmU1wJdf3ba4bYagUZZJ1flVuR3XS6WWDy6xGXjp4xOR
         bHJ0tVGRbkTgo6TF/DBomOj03zV0/Glit1DOyFV9oRCCPsuCPHosI8xwm2q/jEcYLvcZ
         kP4Q==
X-Gm-Message-State: AOAM532uvZXiO2nxfKsKcDekYYOhyeGx8YOxsLSbruJuJAq0XhhmAT0O
        nN+x5c70C9XsXpeWYbNqdt0=
X-Google-Smtp-Source: ABdhPJw+rtMYsLz483wg7dwfD/9/f8HXEPiQoULwSeMoq5Lr4ZB2nl3vMKUgjuHPpGuLQZZr9d+NXA==
X-Received: by 2002:a2e:b0ce:: with SMTP id g14mr22266750ljl.116.1635201971974;
        Mon, 25 Oct 2021 15:46:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:11 -0700 (PDT)
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
Subject: [PATCH v14 28/39] soc/tegra: fuse: Use resource-managed helpers
Date:   Tue, 26 Oct 2021 01:40:21 +0300
Message-Id: <20211025224032.21012-29-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use resource-managed helpers to make code cleaner and more correct,
properly releasing all resources in case of driver probe error.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   | 32 ++++++++++++++------------
 drivers/soc/tegra/fuse/fuse-tegra20.c | 33 ++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index cc032729a143..fe4f935ce73a 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -182,6 +182,12 @@ static const struct nvmem_cell_info tegra_fuse_cells[] = {
 	},
 };
 
+static void tegra_fuse_restore(void *base)
+{
+	fuse->clk = NULL;
+	fuse->base = base;
+}
+
 static int tegra_fuse_probe(struct platform_device *pdev)
 {
 	void __iomem *base = fuse->base;
@@ -189,13 +195,16 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	int err;
 
+	err = devm_add_action(&pdev->dev, tegra_fuse_restore, base);
+	if (err)
+		return err;
+
 	/* take over the memory region from the early initialization */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	fuse->phys = res->start;
 	fuse->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(fuse->base)) {
 		err = PTR_ERR(fuse->base);
-		fuse->base = base;
 		return err;
 	}
 
@@ -205,19 +214,20 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to get FUSE clock: %ld",
 				PTR_ERR(fuse->clk));
 
-		fuse->base = base;
 		return PTR_ERR(fuse->clk);
 	}
 
 	platform_set_drvdata(pdev, fuse);
 	fuse->dev = &pdev->dev;
 
-	pm_runtime_enable(&pdev->dev);
+	err = devm_pm_runtime_enable(&pdev->dev);
+	if (err)
+		return err;
 
 	if (fuse->soc->probe) {
 		err = fuse->soc->probe(fuse);
 		if (err < 0)
-			goto restore;
+			return err;
 	}
 
 	memset(&nvmem, 0, sizeof(nvmem));
@@ -241,7 +251,7 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		err = PTR_ERR(fuse->nvmem);
 		dev_err(&pdev->dev, "failed to register NVMEM device: %d\n",
 			err);
-		goto restore;
+		return err;
 	}
 
 	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
@@ -249,7 +259,7 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		err = PTR_ERR(fuse->rst);
 		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
 			fuse->rst);
-		goto restore;
+		return err;
 	}
 
 	/*
@@ -258,26 +268,20 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 	 */
 	err = pm_runtime_resume_and_get(&pdev->dev);
 	if (err)
-		goto restore;
+		return err;
 
 	err = reset_control_reset(fuse->rst);
 	pm_runtime_put(&pdev->dev);
 
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to reset FUSE: %d\n", err);
-		goto restore;
+		return err;
 	}
 
 	/* release the early I/O memory mapping */
 	iounmap(base);
 
 	return 0;
-
-restore:
-	fuse->clk = NULL;
-	fuse->base = base;
-	pm_runtime_disable(&pdev->dev);
-	return err;
 }
 
 static int __maybe_unused tegra_fuse_runtime_resume(struct device *dev)
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 8ec9fc5e5e4b..12503f563e36 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -94,9 +94,28 @@ static bool dma_filter(struct dma_chan *chan, void *filter_param)
 	return of_device_is_compatible(np, "nvidia,tegra20-apbdma");
 }
 
+static void tegra20_fuse_release_channel(void *data)
+{
+	struct tegra_fuse *fuse = data;
+
+	dma_release_channel(fuse->apbdma.chan);
+	fuse->apbdma.chan = NULL;
+}
+
+static void tegra20_fuse_free_coherent(void *data)
+{
+	struct tegra_fuse *fuse = data;
+
+	dma_free_coherent(fuse->dev, sizeof(u32), fuse->apbdma.virt,
+			  fuse->apbdma.phys);
+	fuse->apbdma.virt = NULL;
+	fuse->apbdma.phys = 0x0;
+}
+
 static int tegra20_fuse_probe(struct tegra_fuse *fuse)
 {
 	dma_cap_mask_t mask;
+	int err;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -105,13 +124,21 @@ static int tegra20_fuse_probe(struct tegra_fuse *fuse)
 	if (!fuse->apbdma.chan)
 		return -EPROBE_DEFER;
 
+	err = devm_add_action_or_reset(fuse->dev, tegra20_fuse_release_channel,
+				       fuse);
+	if (err)
+		return err;
+
 	fuse->apbdma.virt = dma_alloc_coherent(fuse->dev, sizeof(u32),
 					       &fuse->apbdma.phys,
 					       GFP_KERNEL);
-	if (!fuse->apbdma.virt) {
-		dma_release_channel(fuse->apbdma.chan);
+	if (!fuse->apbdma.virt)
 		return -ENOMEM;
-	}
+
+	err = devm_add_action_or_reset(fuse->dev, tegra20_fuse_free_coherent,
+				       fuse);
+	if (err)
+		return err;
 
 	fuse->apbdma.config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	fuse->apbdma.config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-- 
2.33.1

