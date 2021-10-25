Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEF43A77F
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhJYWuK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbhJYWtJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:49:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10752C061232;
        Mon, 25 Oct 2021 15:46:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq11so13208692lfb.10;
        Mon, 25 Oct 2021 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ym92eBTuyCQ1IpgK/+kfEiPKPjSSIdO4L48BfylV5wI=;
        b=mtsYWdEcZTH7RZU/6KoIxTVD72ue2t1qOhEj9zFAFWmtNqSX8f6MIPfsYFHM3XhCiQ
         c4IKu8M7ct3H1prdjTq6iYXI0HDKSxnl4zTFUMUuh6pa6XeZILXvaiFDr+IzY8V5OA56
         f2MM828ePFitN89Z2LEoEMrrYjTRRCS6JJFjGHSqJNXOOzc7E2nchIs9lzdmvyOiS9RA
         Sxdelcb8VRX+uXT2e2E3KnY4Xlz6qgAvs+DJyFuRsY4M67E3vwQ2gtUrimjkLDtsfgOp
         iUQlyl+GsRmDXBh07DPcq6od2WXKfgYO5TG54hfr98A/9ORo9erHtAC5WfUM5VstXXCx
         JO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ym92eBTuyCQ1IpgK/+kfEiPKPjSSIdO4L48BfylV5wI=;
        b=k5EOrMjRuCtDtR7NztJV2EX6cKNBMtgCn4seBZ/ziMw+jg2MvrrmmNWIrWws7l4kcO
         fxSl9Fw69/qyg7WEJ1CpzDfogbCNp/VZzHUKASaIj6d7msNUEFl/GAw46WST1YRMXVqk
         heLbAQRfesDLkt890lIs6vSXPiA2mYLgtSZr6BHk4WvYLdG7t4nNgXh+I2pv0yavFbEm
         QamT2Zxzki10sol+jr19v50bGe/IPXysBbOtZ63w2mplG1qVHS2aerE90ocBLv8NpfHb
         xBXvj7y89ZewoCKzEAUpD8aIOEbihg6LqVMCh80YZANMpJEFi0hMF8qFoqnhbZYxf02v
         Hp1Q==
X-Gm-Message-State: AOAM530BdR/Ig3sX4vWCI2HtrC3Ce1KSl1zHItAn/HhRhesAINgsYr4x
        +F0hoWBN1RDG2RVjyADgUd4=
X-Google-Smtp-Source: ABdhPJzdwfsakF9qSN2ahkeoN2c/9R3FWz+XrepdCS/lEUPKN8/Q8aJ/9rj5ofyEaX0C+kdMr3fHdg==
X-Received: by 2002:a05:6512:e9e:: with SMTP id bi30mr11526102lfb.479.1635201967316;
        Mon, 25 Oct 2021 15:46:07 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:07 -0700 (PDT)
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
Subject: [PATCH v14 23/39] spi: tegra20-slink: Add OPP support
Date:   Tue, 26 Oct 2021 01:40:16 +0300
Message-Id: <20211025224032.21012-24-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The SPI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now SPI driver must use OPP
API for driving the controller's clock rate because OPP API takes care
of reconfiguring the domain's performance state in accordance to the
rate. Add OPP support to the driver.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 33302f6b42d7..584fa25d3918 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -18,12 +18,15 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
+#include <soc/tegra/common.h>
+
 #define SLINK_COMMAND			0x000
 #define SLINK_BIT_LENGTH(x)		(((x) & 0x1f) << 0)
 #define SLINK_WORD_SIZE(x)		(((x) & 0x1f) << 5)
@@ -680,7 +683,7 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	bits_per_word = t->bits_per_word;
 	speed = t->speed_hz;
 	if (speed != tspi->cur_speed) {
-		clk_set_rate(tspi->clk, speed * 4);
+		dev_pm_opp_set_rate(tspi->dev, speed * 4);
 		tspi->cur_speed = speed;
 	}
 
@@ -1066,6 +1069,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
+	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (ret)
+		goto exit_free_master;
+
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
-- 
2.33.1

