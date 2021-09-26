Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96B418C7C
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhIZWqC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhIZWpH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:45:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C8C061783;
        Sun, 26 Sep 2021 15:43:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u18so67078982lfd.12;
        Sun, 26 Sep 2021 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myD2habKvt7RXAHJbtKPfyU4WLnqnb1bLB54hjelw1E=;
        b=mIfxe0TF/9Pcmy48yz0Fsm9ZchpGfpzi0SLlaP45hHx+C8LQ6p9xMjB3D70WA9M6r4
         f9Aargip+FhmIUdB55HLiFKB+j0CuPHT9193U5qmsrnbn/Shc1W+Vlq4RScSptQph0b2
         zgkvwA9uw/jspllbPLhMek7qZa3C+M4uXTPhgu+iJy9ui2A9cQvS5x86VDhpjfBZa516
         68hec1KCKBc+8zQLs7jcGuH8GoDG8SM6R1dQGUDeR7s+JPShQDnHP4x9Fz7CwQzH2hyu
         MW3MHHj7ACUbOHnjE0xhpImyVDrgU2Fi29vssm/QIqucYYRqM4SuFJTS04LbgtjS8oZZ
         51Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myD2habKvt7RXAHJbtKPfyU4WLnqnb1bLB54hjelw1E=;
        b=wD7F5REttfP5KsJDKetfjsK2PbYk+0+8sb1JYVquF3575rY8tr5oMamA/OrP+axDdV
         yF2vq6ai9wA2UwL1ELdwv/O09/75DoUMs0ztoMdWgYY+EsBW/aKBXBR7/2lK84MGIfrq
         0F3n5leYsGz4o7VmCXHY5BEve8gIRYN1skwLUfl8pv3NZw9kHH9jwdD51qrJv9PBOfFV
         7OVoUvAInSIvM5jH8nXLMjgW39GBDCOeQp966UC7ijmlOOClb2gMkrKw3ZCrhF4Df8OR
         xkq9qpIz4R/c/L+RkzEJR2x1LBQa2fFTgHGk6SjXzRYPA4reaHYlvy2qTQohnFdO96vR
         B6sg==
X-Gm-Message-State: AOAM530OWcIPFQttraLv2y1VeDZEAL3S/caeVDIqXxOcW4pG8ImKIrlj
        eYUVCBKe2sE1Uu+BL4FfRUU=
X-Google-Smtp-Source: ABdhPJz2GN71oCn5sxPfcYLYhElIbf9KK/DAi0VeYmiU+Ndj/lzTslJMlCVfBT6aWvUUtQxHZElN8g==
X-Received: by 2002:a2e:88ce:: with SMTP id a14mr24867181ljk.96.1632696180464;
        Sun, 26 Sep 2021 15:43:00 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:43:00 -0700 (PDT)
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
Subject: [PATCH v13 29/35] soc/tegra: pmc: Rename core power domain
Date:   Mon, 27 Sep 2021 01:40:52 +0300
Message-Id: <20210926224058.1252-30-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

CORE power domain uses name of device-tree node, which is inconsistent with
the names of PMC domains. Set the name to "core" to make it consistent.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6759f19b9cd6..3e52ceada60c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1353,7 +1353,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	if (!genpd)
 		return -ENOMEM;
 
-	genpd->name = np->name;
+	genpd->name = "core";
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-- 
2.32.0

