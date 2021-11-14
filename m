Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54144FA31
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhKNTi7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhKNTix (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:38:53 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D247C061766;
        Sun, 14 Nov 2021 11:35:59 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e9so30696219ljl.5;
        Sun, 14 Nov 2021 11:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oXDZz/nBiCoTxlA9cxo84oljRiezPiTcqnco4cDqBk=;
        b=UGiBcLX07i5tcZxvhl3xcl9985grLoBUJAa4nRMHfBtuA9SzMfsuQOokNs05nW45Kf
         fQ8FsDl1gXUKd7aOzVAj++iGHO6pht7jhYaLJORIroBQUJOJO9rPq9oxaRguXpOkR2es
         HKP3ddYdww1CTi2F/hA7kDwJyxua+kdEMfbP1LtJkhMKVUVe5qNFLOEgGsUnr96BFYvp
         R/9sL5Cmvuv2na9Be//dTaiIzeOCk4fJifZc/ZGwfRCEQEINzhrhJS2O8CXYanKCr3eD
         32uE6FSYjQMmoQ3FUb4jLKgEQ72IGAqmoXuUJB74Hm9gM0+EPjBtUTu6PyutHzCoCoz+
         OWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oXDZz/nBiCoTxlA9cxo84oljRiezPiTcqnco4cDqBk=;
        b=AkRAGrbCx3k2jmEpOq0StMIpNiuxxkYlWxdhUO5mq1FuzZpyKOCGWJ8/I5SNqGxjYu
         Re+6Z7GqEtR4S+DRnBoaYWwbM6a6tFUXNv1j/cd1VppWh0yzD2aHgbCthHatkaH3372A
         3Fgow4LMCGUOhPC8kYwVk5SGL/GVRbxnN8nv4y5ysxUcp9pS/WNGNmiee3gqrzVJwyMJ
         OW4tpzisbhWRUi0Zz3Kd+OR/9xfwatKg245TWuTjfABGuysdDqH8A57ikVxuwDfWJq7+
         NO3o9cQCxLwWsW10NaB+ZL1arA2aGjTTYgDHt1OWN3p1e5PZc8zSQbt0VKZz/WCuOiYs
         hB9A==
X-Gm-Message-State: AOAM533O3MgrugOViqF6M/O8gtytnZR6ZW6G7Zz0Hh9t7Nv0gG4x0JjK
        wtSCklL8oEAuRaQk31uocJ0=
X-Google-Smtp-Source: ABdhPJyNBM6ekkt/rg2AVG2uuJ/lXhjS09khr+YszZ8itWbaLgdOiAar/DdNSG4Di+eXJpFjV0CQkA==
X-Received: by 2002:a05:651c:308:: with SMTP id a8mr34365352ljp.149.1636918557606;
        Sun, 14 Nov 2021 11:35:57 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:35:57 -0800 (PST)
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
Subject: [PATCH v15 01/39] soc/tegra: Enable runtime PM during OPP state-syncing
Date:   Sun, 14 Nov 2021 22:33:57 +0300
Message-Id: <20211114193435.7705-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

GENPD core now can set up domain's performance state properly while device
is RPM-suspended. Runtime PM of a device must be enabled during setup
because GENPD checks whether device is suspended and check doesn't work
while RPM is disabled. Instead of replicating the boilerplate RPM-enable
code around OPP helper for each driver, let's make OPP helper to take care
of enabling it.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd33e99249c3..35c882da55fc 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 
 #include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
@@ -43,6 +44,7 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
 {
 	unsigned long rate;
 	struct clk *clk;
+	bool rpm_enabled;
 	int err;
 
 	clk = devm_clk_get(dev, NULL);
@@ -57,8 +59,31 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
 		return -EINVAL;
 	}
 
+	/*
+	 * Runtime PM of the device must be enabled in order to set up
+	 * GENPD's performance properly because GENPD core checks whether
+	 * device is suspended and this check doesn't work while RPM is
+	 * disabled. This makes sure the OPP vote below gets cached in
+	 * GENPD for the device. Instead, the vote is done the next time
+	 * the device gets runtime resumed.
+	 */
+	rpm_enabled = pm_runtime_enabled(dev);
+	if (!rpm_enabled)
+		pm_runtime_enable(dev);
+
+	/* should never happen in practice */
+	if (!pm_runtime_enabled(dev)) {
+		dev_WARN(dev, "failed to enable runtime PM\n");
+		pm_runtime_disable(dev);
+		return -EINVAL;
+	}
+
 	/* first dummy rate-setting initializes voltage vote */
 	err = dev_pm_opp_set_rate(dev, rate);
+
+	if (!rpm_enabled)
+		pm_runtime_disable(dev);
+
 	if (err) {
 		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
 		return err;
-- 
2.33.1

