Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044C6408122
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhILUOb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbhILUM2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:12:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C4FC06139D;
        Sun, 12 Sep 2021 13:10:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t18so11368307wrb.0;
        Sun, 12 Sep 2021 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/fuQ9/4B7O6NkGtlvGWmoFCTTuIvWwpexDnS+rspmU=;
        b=KqnSWSQwDdW+LsvhctV39BvkSonyOFoR8QZGL7wOrdePQCSFcXxBl/w5qvUrkyWCTf
         j/cfCy5Iw/mulmidbJzcfnMT1d9vxz0lmUcn3+e2cllkjmFEu9TkMN2YK4jbXamBj8f1
         qckhs3v3e7W2vjUni0tk4wmjOxt6uJG4GbpATnfH3pGBcCQjmcQqfSYN+V09NCV9rcZN
         TacNyjSdgre93p6KLKixeUnN7Kw8F/V5phgXRtEHZ5TaelM/s5p//+bw4Ck3Outu2D/S
         fg3vzFHm1zZLJCFr4E+jI62feQVIpBbKoChYrjaPqZFNM2EHoXfjGJ67uJLjRyYmzPAR
         GhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/fuQ9/4B7O6NkGtlvGWmoFCTTuIvWwpexDnS+rspmU=;
        b=HLh4UBoycSiIc62Yj+2IQ6wanZmw39d7Lse6dBMQ6JO5RKTD4YMepRWwc+8mIth0ZQ
         ni7sbSeseTJLSBtW0EW5w3Yu2ZqCtEWAbH7sYbCDnfqBX6CEKYaNTNmTsPDPXR1tbys9
         h+hmL748l8aZicpS6RwB0aAU0+IRS2ucBMMxW6FAAnlCAnbGiZKhN1qPb6qQBOF4XkqL
         ZwRLOuMJYWjztW2rBlf1eMeuER4wQD0U5kxANfs0VAxJPvshJDNVeRs5jKXu8pBjHIbv
         /a9J2vKRX5TaqCXlpJlZEG/6hzhj53x+XBbtsTLWHuNl6kQbmoPV7PnUcrqCGAjAdhVB
         qsxw==
X-Gm-Message-State: AOAM530HgiN8/CmYPM+G9Oz/cuvUfeJJ4U064qeeGEtu3+csfDC5mfEa
        Z1H1s0GKi8hdA3m9MdSYtE0=
X-Google-Smtp-Source: ABdhPJx2T8jeUvLIRwUiWYF42kYGMTgqyMxMsfziWllGOoP3lQwH9NfZN9gWz+QVvhs3feNVef169w==
X-Received: by 2002:adf:f911:: with SMTP id b17mr8988366wrr.412.1631477444652;
        Sun, 12 Sep 2021 13:10:44 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:44 -0700 (PDT)
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
Subject: [PATCH v11 29/34] soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
Date:   Sun, 12 Sep 2021 23:08:27 +0300
Message-Id: <20210912200832.12312-30-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
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
index 5e1fc873bf8f..74de84a014e9 100644
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

