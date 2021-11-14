Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A086144FB04
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhKNTnz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhKNTja (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:30 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E6C061767;
        Sun, 14 Nov 2021 11:36:28 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t11so30718995ljh.6;
        Sun, 14 Nov 2021 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmcymaX/CCDsjvKZ+BlarVFlOy3iTU1wE2LEPj5HoVo=;
        b=QVoRPM7LtqDuHOLWm1MC29HEJkjnB72zqcdZUlj53y23OvWuAqa/IjqMWbVKZ1dCe5
         KTG5iRgMzi3fN4X88vB3VAE7mCDKDoOSZatxoBud+uNXlgb8R0yUAHS6vkSBvV+ZN4LH
         FShMM+2v7uMr1m7KtxU8iVNPuekvvEh/4z6firy1SY9UTUNSaJACqgbbLytgqSl84dyd
         VGr06x5Aj7y4WGXuHVeIZp/FtkUSgge03k9K9f5RdyBauclGEjhStvhVPLBhGbD2kTcO
         V433kEokw1XVUFnMD27FRMCh/gfxqqrI6oeBOI+7OgOl23WH8cReYsCn8zKFa4+CU+QC
         Uexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmcymaX/CCDsjvKZ+BlarVFlOy3iTU1wE2LEPj5HoVo=;
        b=7BJpWVuBIijVa+9iCLplCSv7c7WJe/ZMk9rdldSAGdw8AotX0tOcGn/G6lrdXzCOKZ
         Mr/dfLrfScwg/cff0IWC3osXl+HMMleYwtTzLgcsxIO2dP2TjOfQw+0emZx5QTx+57jA
         UVwmQnUH1yWPUY5MQPsZJ2fkXL5eKlCqx35TvVDItFLDilSZfR/mEFT5weIZ5MbQmxfB
         0Eqy2rruomnfgUjCRHRt7tLtYPmWNBroYFU6EhOENEXx1ZtRSWk8ok0K9l2roJmvmGOH
         XmMwwl7wbH6FfOHnRUksevDmTV94HG0QNV85dZg9lVU7N9VlkP+eu2p8KsKpCkDVz6Zk
         DRwg==
X-Gm-Message-State: AOAM531b/djRUsypy3g4ZfLJNx5Y0fbM2cEv110U7BFtedne2Ob2r4vq
        vMhvNiIASfqGOthopHPY9PA=
X-Google-Smtp-Source: ABdhPJxb0PhhPD6n8iMAFQeacuKy19PXCB8pzsadQwOzQ8U5DbUiG7dZTWUE+ZwIhVTlV+zNNvtg3Q==
X-Received: by 2002:a2e:9903:: with SMTP id v3mr31613021lji.143.1636918587036;
        Sun, 14 Nov 2021 11:36:27 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:26 -0800 (PST)
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
Subject: [PATCH v15 32/39] soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
Date:   Sun, 14 Nov 2021 22:34:28 +0300
Message-Id: <20211114193435.7705-33-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All device drivers got runtime PM and OPP support. Flip the core domain
support status for Tegra20 and Tegra30 SoCs.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index de6234ec4f9b..585a05968ea9 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3070,7 +3070,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3131,7 +3131,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
-- 
2.33.1

