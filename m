Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350BF44FB01
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhKNTnh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhKNTja (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:30 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8186C061746;
        Sun, 14 Nov 2021 11:36:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b1so31690175lfs.13;
        Sun, 14 Nov 2021 11:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fItgMJ65iQSV+grlztB0lQCNjAn4l4vCQ8OPUC2n0iM=;
        b=p7bP1P6r4dEikXS5YUjD4B1/CGf6lvJ6idSQeufZhdoMPZNLSpKj9R6K9ngCLl1aZ6
         w6FiXIx1EhIKNCySvfZ9dq6eK83Ass5BFjbtVZJxOeyNraegN1qyU1UCHoL073F6P8Jq
         hCtbPVZN3AHUyFfecXtTr4dj5Mcp/c9x+3SK7N41ST1QsDFdYaRzejn9zUP65Xbt1rdr
         4X6+EYQ06asjrmCH5HZEJuz8XEX4fBiNCXSCBk4t6/dARk5uivUbY8e5kQ6id6QS039w
         aepKfzngjEW5flAb9jo/i3puoqlYQwFUXBqEVehix3lbGsr/aQ9Hmi3LWp2clmwno6pn
         J/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fItgMJ65iQSV+grlztB0lQCNjAn4l4vCQ8OPUC2n0iM=;
        b=zu9Ed6x5r+Dr+cw6PE+K1pIWdwH6ZC6Vw+koe/v2x7Crd+cY5CsgpPQj1gDVrSi2Id
         4NNx0iDol4rdNMdJX3JnzhW3pdttq3iat/3ftE08xGWEyJPHbPdXlMpRgpiVKQTtNbJP
         0upNRbjeWa15oDbxwiWMrTvjp1+SrjyKkq836J5lnH1/noerGDZg/+2aY2Uozn/4wVHd
         wvSeoJlmM/xugCS4WoZmP5+geOMM108U48frn73kZij+16weamyKColE87I6SS81eHHt
         +HXW4TpD6UBlxpcFAVABOjQUC54Fl1c/W47aDixds8lVEeFkf07dKs1APhTFLXGgets/
         LKCg==
X-Gm-Message-State: AOAM530UR410sVhXSXjkJj62/wd7RJIITc73YpFnpGyKUNXmiPhPaSMJ
        uT6UdrQvlYclQQQElZE9OQc=
X-Google-Smtp-Source: ABdhPJzxAEbohXOKyUE7xn/hkXFl/4SfVadu4MW7os0XYNeheDcZ/TU+PAIPqaAHEjm2ORClibXzPg==
X-Received: by 2002:a05:6512:3d1d:: with SMTP id d29mr30408424lfv.685.1636918586150;
        Sun, 14 Nov 2021 11:36:26 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:25 -0800 (PST)
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
Subject: [PATCH v15 31/39] soc/tegra: pmc: Rename core power domain
Date:   Sun, 14 Nov 2021 22:34:27 +0300
Message-Id: <20211114193435.7705-32-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

CORE power domain uses name of device-tree node, which is inconsistent with
the names of PMC domains. Set the name to "core" to make it consistent.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index e1fae1a5e36a..de6234ec4f9b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1369,7 +1369,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 	if (!genpd)
 		return -ENOMEM;
 
-	genpd->name = np->name;
+	genpd->name = "core";
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
-- 
2.33.1

