Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F85418C33
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhIZWpT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhIZWof (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED3C061777;
        Sun, 26 Sep 2021 15:42:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u8so67671565lff.9;
        Sun, 26 Sep 2021 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuKrXeUQQi+X+gXF6rgX7l9I20zb6cKrHqHuf0Fo3Dc=;
        b=dn51Amd+ZiuI77hrmQemh5v3PyNv/szhsuuUhMOhdqHANVdlmgYMameiyltwAXjJ4H
         qMj2vmzeaODnsYi/Foe6McLqQLzWfpYrTzDHFIAhSExXreqkUt4AzPD/RItbIhdoldlt
         LTEQml73Z++0qMvdoC/Do/aWaR+MqANOnnel2oyp+EdePmv+tPaGtAhkKt4kQ+aaYsIk
         c38IP1u811Yi/1b/fXhiTcKXI1tPrntNyHdVKRW7EV6xzQDBPEkpjDjF6WLOlRj4g7eO
         UVttcL9BenvV9Mq+cdNhN0ftjW9zKOHKhpeYNze8AGR7F1AqvLHpGIn2fQ2eMeN4vDLt
         RbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuKrXeUQQi+X+gXF6rgX7l9I20zb6cKrHqHuf0Fo3Dc=;
        b=PactRU8bjOVT+Zjp03yXcxcREpok9ZTC5EgG8Px3GB2r71UmVlid1nEHPdGlA5J98f
         sOVJbC0Jjja0gJJdHGRxvDM01tso2lpOba6EB32ohFQX42r0RTWqlDUtHut2dFWiGRim
         drTRwugWJZvby2NAzAxIfiW4fo0hc4lMJDmE5lqfHV7X21qe5Sti+EnzwtnAEHwT5W0I
         f+u9koexFgbf+PdE4PnwV7If41viIg9TibQc4WlfTdcuC0Encio5J9ZFv8HUNcCrfG1l
         AePR2j928cTvETgiWRK+6IaSiGGjgKpblDfiqKLWmdBEAGiioliScwOVd5gYCAMnDPaG
         p5bQ==
X-Gm-Message-State: AOAM531N92zjxt4S1m3YmzRhk82dp22cxjVSd767Y0f0Q+pLn02HkBBb
        5AegCvvqKzYxmgKpc43W4w8=
X-Google-Smtp-Source: ABdhPJwAQdBa0bMUBgP5K5DEgHKTvbjdloNJFNRgxFsvhBIQJF5xLXGg67bpUH9/UyyvyAx5OqFK9g==
X-Received: by 2002:a05:6512:50f:: with SMTP id o15mr20603071lfb.337.1632696176740;
        Sun, 26 Sep 2021 15:42:56 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v13 26/35] soc/tegra: fuse: Use resource-managed helpers
Date:   Mon, 27 Sep 2021 01:40:49 +0300
Message-Id: <20210926224058.1252-27-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
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
2.32.0

