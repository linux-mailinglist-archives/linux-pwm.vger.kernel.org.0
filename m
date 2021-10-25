Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8143A7BD
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhJYWvd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbhJYWuC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:50:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C195C07978D;
        Mon, 25 Oct 2021 15:46:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o11so19485216ljg.10;
        Mon, 25 Oct 2021 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1MsgTWaMU7L5hsoQyQaWcgiqMKdd8mOxB+as8zU9xk=;
        b=ESW5TVtukQQHsP1xA1tsnaOoIjIQu87u6518JmR4shcn7KtAWPxPFh3d0xpoDsI6wM
         YyP2MT3Eu+6fIplBUYjaf0WSmG+CDCMsMvMiidRkeq9ZtD5jB9qMIibBJqrqgCUM/bKv
         pWnLiISUU3Z6rNE17YU25yFK/efAJIdE8Gt8dzjGEIznWXy5DlEdOLDN6teWTGMHUNKY
         1zyAUKVMTWnAk+7boP6tufnTpZEe8brt5G0s4+mIA9wod8aobxx3bnsTKl9oNjn7ru+Y
         QdDqeZIrycYFFAEbEuLO0p1eLh2LDrr2oPkhVFiJCXWmGtGfQS2q2OhwgibVnvCC58SF
         vmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1MsgTWaMU7L5hsoQyQaWcgiqMKdd8mOxB+as8zU9xk=;
        b=CUFsnx6/IQ8RxKap7R1LuQP4hn4DfMPKXDjQpWx3jP4EURSBALAQxBSCkHq27LP1kP
         0XKYEohxuNuZ10qQYq60tAKOoT7enmQ4u7kjTSP0PIn8SObrwkvovfwgd4gjSWtNW8XM
         qLU3tG784i+ojpxWuYXmuUffe+kHghgpSt5K45UajlyckAiKXfTBy8kRNsGdo8YDpw00
         Lg6hjA1QlCMf+AswY3EP22zLYJc3OqLP2EgTXlgI3jz2+HlGQK87mSsh5bkWqulp1Eh7
         izSv+lJmR/gGhaaPrHXyeX3nZtk0zafyymv5dto1qo+8c2pxbDvrvS56JxUdK4714+mm
         94Gw==
X-Gm-Message-State: AOAM533rf1kCdw8b1eUhD2IPliukmGJM5fbIRvu/Cs/1ZTOWsEnY9jpF
        pG2LvSj0gXVDrAo/453CAuw=
X-Google-Smtp-Source: ABdhPJx5gPntgOyZIHqj2um0ceQNxg/n93Di/GFAUn7kVG4nQHeNw/wbNxrIgWWvvCnUBeaoVmYQag==
X-Received: by 2002:a2e:8785:: with SMTP id n5mr22579743lji.52.1635201975524;
        Mon, 25 Oct 2021 15:46:15 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:15 -0700 (PDT)
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
Subject: [PATCH v14 32/39] soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
Date:   Tue, 26 Oct 2021 01:40:25 +0300
Message-Id: <20211025224032.21012-33-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
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
index 4665b7214f1c..ad8f33a5daa1 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3041,7 +3041,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3102,7 +3102,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
-	.supports_core_domain = false,
+	.supports_core_domain = true,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
-- 
2.33.1

