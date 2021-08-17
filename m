Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0903EE2BF
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhHQBbf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbhHQBbJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:31:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406BC0617AF;
        Mon, 16 Aug 2021 18:30:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c12so17170400ljr.5;
        Mon, 16 Aug 2021 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rnq9bkX2ixJQNv9BmFWVHuIOaPxB2jJGC7dZumDQ6+g=;
        b=OhTLO+vj1vm5lGE+851g2CFGzlzjt3nZpufwJ0JLRj5BVaJqOv5XpnZ4t6FIFykDTe
         R7eSI4+JQmpLfDJXNvkuLw20a6hVxyEOfc6fYX2JHLYC66lj/UMaHPoHD28QCWb7xsPE
         ck0QHLrINepJb4SHmmiAjfr61/w6aaL8rUWnwdaj04Gxb+CYF49kFSlCFhp+PAHjBiFv
         opz07XHUvGSevI2cEHAS1+ua6hVTgr3hXi+elnaFdC1tmCA2ewZFv2BBPNmmsu3P0OH+
         Lex80AN9h9VtBkYhMDTb94z7cxiyS9kXLrm7WgkKDh0hQquViNyco07WO4wrwg6WoGxn
         VOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rnq9bkX2ixJQNv9BmFWVHuIOaPxB2jJGC7dZumDQ6+g=;
        b=Ugs+4A6TbI7do3S9b2f/ZV9H+LcObJLkCUG1uN1uv7wECOQYOkcqK/mGEKwVUVf+mF
         FAa9Seg3X7fYtum2RbjM23G75e25qhjY3inT+vyMfljVKQafY1UkVfru+VHzvdnAcTw9
         TlC3/HKO2U3OgvZdfTRBrut/JCanUECxouuAcS7qJ3yHQwm5Rs/HFjt9J50RdSv72Isu
         814ei94d2YpwtJdqGOw+YJPOT+9/MPmMOehPTOPCq23W02h9ZrLc8SPDtWdQQ8EYG4AK
         GsLGIKSXMtebjQfV4Sc6benH3cZy0iLmlkMM/3eG2Kxow/Jfai7EXGXVZQgU21Seb7FL
         IB2g==
X-Gm-Message-State: AOAM5310/A3xzstGP5AN3V6KBSEkn5dm6c4VH5kBZbuI4HcGgmyB7omI
        ulMt5LOU05Zp+htwjJguQWM=
X-Google-Smtp-Source: ABdhPJz00oZVpSy/+QIJGg2IFpP4EXHyPsIbmUOMC41xOAd6hpvBx6xCs96mwtqe7gvcDuDFogRMBg==
X-Received: by 2002:a2e:8191:: with SMTP id e17mr865236ljg.226.1629163835893;
        Mon, 16 Aug 2021 18:30:35 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:35 -0700 (PDT)
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
Subject: [PATCH v8 29/34] soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
Date:   Tue, 17 Aug 2021 04:27:49 +0300
Message-Id: <20210817012754.8710-30-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All device drivers got runtime PM and OPP support. Flip the core domain
support status for Tegra20 and Tegra30 SoCs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index fb8faf7b226a..caf9e72af246 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3042,7 +3042,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3103,7 +3103,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
-- 
2.32.0

