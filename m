Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA29340811E
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhILUOa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237033AbhILUM0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:12:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D45C061768;
        Sun, 12 Sep 2021 13:10:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u15so5265442wru.6;
        Sun, 12 Sep 2021 13:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6ifLJNQpWHL/aW6APbCXiXF4Xey3uNJjXkEDYLDpf0=;
        b=ZfKwSrRJYOUFhAoytmkutWh0G4OM3EDXtdlI9nE+QFtPei+2E4JdDl9Wka9E5pH3YS
         04uPK1Tw8S/mpSJek9+01/hZUOudukqiP1FHYcqijmNUw3d/ou4/LVcqog6TND7k1ctk
         nhrCXGQ6H7XuuSz39ea5BGGnr4/poWAHAjMjQDsmYxL4FiyE8A3sMYfTHP3veVbXO+uo
         d9x7efPI4RBayLlBeljU0f1eSkDX3OfNSksY6kDtJWGRBn8yGTD1egqNKbd5IoFywF9B
         P5raiK7sTUwh7OkLsuO0sINvzimEE1qvWRuqPCO+jbWgCSh5d3Bgwic9fGMsNaWhx7YO
         E6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6ifLJNQpWHL/aW6APbCXiXF4Xey3uNJjXkEDYLDpf0=;
        b=opNkQv4GL2p4rKmnVZxndhirt5HO86rNkyFFU8EoP0AbTk0l5F01AMpzQngTp/zXVw
         qWjHfbroQ1EHk9Vfj7XZq/MCERRnfzlYum5hMlKL4cRfOKW89tjshOAhB+ZGxCDr5h2H
         avyWy5S7CaattDMPBopUrs1fHwEp3FQPvF9Jgk+aPCsFaglcDrpcMs8vXGO0sQGeuSDS
         H7aDnvCzUPAHR4fv0cCNQrmJesfGH5Mmy2TXCQPGUBhqhUc+T9Hlzzr01wq/+hPxr3/Z
         MToAeVIp1W3RgDx97Ausl6cuSAYjQrQYb9r918sXzAbTBgX5/CwXmIt2O9GXduyPun0q
         EY1A==
X-Gm-Message-State: AOAM532qQHFfYQdST0F/ztPoBYgyqGuNYTbJTUnfTjT2ZkXJMFcbRlcm
        b1ucJmsMnn51PD0uE9RtUaY=
X-Google-Smtp-Source: ABdhPJy5R0R2cYZ9ytbAqF/pKeienf/EwQwWGSDMVrYLML+XPPmZs/giSU/21wa5JsLrvKFXP2DpUQ==
X-Received: by 2002:adf:8170:: with SMTP id 103mr9108790wrm.167.1631477442191;
        Sun, 12 Sep 2021 13:10:42 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:41 -0700 (PDT)
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
Subject: [PATCH v11 28/34] soc/tegra: pmc: Change name of core power domain
Date:   Sun, 12 Sep 2021 23:08:26 +0300
Message-Id: <20210912200832.12312-29-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
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
index fb8faf7b226a..5e1fc873bf8f 100644
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

