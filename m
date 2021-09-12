Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758B040812D
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhILUOe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhILUMZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:12:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3415C061574;
        Sun, 12 Sep 2021 13:10:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m9so11323245wrb.1;
        Sun, 12 Sep 2021 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkm6XIjMcFvBv/Q8SMVuuUrOs216TrQ7UEhmgPQFIpc=;
        b=LbZ1KhiE0nod5S9udR0aox4Qlr6d6P21lS3IpT0LRwrpJGxbUh/YzxrI8re+FB0xcY
         2e9EjnLN3IvqMaviA8R7TP7UwTRjARJavBiw5Ybt/sOHrRrMXULXIKPD/9aGl/e3bOkZ
         zOZ5je+2AdYQb8j44N+2uWwlOf0nJHA1GuhGB36SgRq57SbFh9ts8hVs1DXc2xX5T0Aw
         Z73TrZR7FWz5zWqtpr6wL6NekstYxb+4bscCwltg9nNJiCxKAFxiZNpJaHhd+OFwb/tB
         M6KdH4VFi5oVk0VzPIDnkyivfL8CccQwCNM4w4esJoCWzOysk/ZZ24D9OXuVjJN6CR/v
         xQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkm6XIjMcFvBv/Q8SMVuuUrOs216TrQ7UEhmgPQFIpc=;
        b=moxLA2dBdblk92QCtSpAKi/ur+eWc4yekF1yL2BcWGsPo8/ky9NqkN/BJ1aF80gEUo
         PvM3+er5TWk8DLyvMiqo7f4iU+jlT2eVnS7WkAQnImRnO46913ds61+fWR7rxsLGr/KD
         3As/gbbFHUhu+fMgZe7OWQ6iV34ok+/VGbGSwQi0fycOJZXGhiKh3d4efgfM1fqN0iEp
         8reyISRQVaxLIbWwj4gkMf3D4CvaOThd2t15FT57Th81uSqu7LcP1Cl9FOewFZ0YdeBY
         hMH1CRfvCxlUChGDbDHQW+aC0zqHiaFVs17R0XOPDWyW1/xgasriltbvFtnCJkkCIG2J
         AKLg==
X-Gm-Message-State: AOAM530nuxfYdV2GD31FZQ6ULBoA6jfNiCHfTfPULFinWSL8som/Os5D
        Rf1CdvxtNlAHNoxGwbrS+MM=
X-Google-Smtp-Source: ABdhPJwRQqVWZfKNGnKNa/BHmWIr1OaAkwTGsK99SHVbKCllO4stLrUAeQ9C4CToCmSh6Wr+giI8oA==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr8992215wre.380.1631477434609;
        Sun, 12 Sep 2021 13:10:34 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:34 -0700 (PDT)
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
Subject: [PATCH v11 25/34] soc/tegra: fuse: Reset hardware
Date:   Sun, 12 Sep 2021 23:08:23 +0300
Message-Id: <20210912200832.12312-26-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The FUSE controller is enabled at a boot time. Reset it in order to put
hardware and clock into clean and disabled state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 25 +++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h       |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f2151815db58..cc032729a143 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
@@ -243,6 +244,30 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		goto restore;
 	}
 
+	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
+	if (IS_ERR(fuse->rst)) {
+		err = PTR_ERR(fuse->rst);
+		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
+			fuse->rst);
+		goto restore;
+	}
+
+	/*
+	 * FUSE clock is enabled at a boot time, hence this resume/suspend
+	 * disables the clock besides the h/w resetting.
+	 */
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
+		goto restore;
+
+	err = reset_control_reset(fuse->rst);
+	pm_runtime_put(&pdev->dev);
+
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to reset FUSE: %d\n", err);
+		goto restore;
+	}
+
 	/* release the early I/O memory mapping */
 	iounmap(base);
 
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index de58feba0435..1b719d85bd04 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -43,6 +43,7 @@ struct tegra_fuse {
 	void __iomem *base;
 	phys_addr_t phys;
 	struct clk *clk;
+	struct reset_control *rst;
 
 	u32 (*read_early)(struct tegra_fuse *fuse, unsigned int offset);
 	u32 (*read)(struct tegra_fuse *fuse, unsigned int offset);
-- 
2.32.0

