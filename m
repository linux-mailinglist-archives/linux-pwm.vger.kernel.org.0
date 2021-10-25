Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0E43A7BB
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhJYWvL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhJYWuB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:50:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C45C0432C0;
        Mon, 25 Oct 2021 15:46:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d13so11276673ljg.0;
        Mon, 25 Oct 2021 15:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhJhoHa09g0eMXcPzvcsak7Gc2B+P6Q69tbTx8m4NvQ=;
        b=g4lNDzaXWoWnLUPZ36g5NPwv1hrjOWOnXwPfD+IvI+6zsWnp5DCMdjyRCMdQTTmCe3
         LgqIbs3O45c7jIcep2OzjdpPzmecNIqPCCwbOxhL6GhiRjv83y5f9E6AkmEOpKfq49dc
         N1iCKrMuxF5ghJLJ7iLcB+8Y0x3sAki9QxI30bG3pozVBsTlLSWv44KDuhwTOl6/P+o9
         i4to7W/zgwTrNK9xiza9rpv0rL4fJY4Bbv4/W1mNOW8sS/Hrd6HX6B77Mma0Jp0POqv/
         +ES8lNPKt3dv6y+iiUf5NhGpOHAgv604vY4m5nPNJnOuOfgADErV1ZQ6PGPzH12N2TcF
         X3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhJhoHa09g0eMXcPzvcsak7Gc2B+P6Q69tbTx8m4NvQ=;
        b=RH7oPuu5hanYItgQsd1hIky6L0o4wMwvlxBlKqEV/DNZbpgJWQ+ERvRHvvCDrgMwsr
         v6q2auiKJGhiZK2DKoP/4GffpDnSZq8GKpOdPNiGERtLowco4qkSUhR1hcSf4Evw40q2
         VoyvXWXqri6sFvnRdL4ebFuY6Y6PE278BGofpJq7DnGf/aiPFSeRtCalo7tWWR2mRe1F
         chzcrYyFUrp6q9xtotUfcdK+IODTvNDXqRaCy3aMhk9o9Ye0Mf6c9lF4VX9MLE69pZN0
         fI6Ca1OlvhERNugC9P0O//igxVzARi1vESATVO3lX6gz+oGX6Lhi6W1gHsVEiAs3s98G
         10iQ==
X-Gm-Message-State: AOAM5325VcURGEwVzb/7nmtgIc2kPt/WaoF67y0BJQpd7yhCtAW1AAv+
        ttEK5iwp5gqRjeD2peHD/ag=
X-Google-Smtp-Source: ABdhPJx19huNzK+qkOsecJzciIfqsQoAzle0v8di7zqWT9JJN0+HUZjnnILNgbhPItf4hiomO38dkA==
X-Received: by 2002:a2e:9891:: with SMTP id b17mr22400671ljj.391.1635201974621;
        Mon, 25 Oct 2021 15:46:14 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:14 -0700 (PDT)
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
Subject: [PATCH v14 31/39] soc/tegra: pmc: Rename core power domain
Date:   Tue, 26 Oct 2021 01:40:24 +0300
Message-Id: <20211025224032.21012-32-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
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
index 5c6d58a27c39..4665b7214f1c 100644
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
2.33.1

