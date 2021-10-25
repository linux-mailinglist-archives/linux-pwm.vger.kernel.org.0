Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10843A703
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhJYWsS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbhJYWsN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74690C061767;
        Mon, 25 Oct 2021 15:45:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s19so12040764ljj.11;
        Mon, 25 Oct 2021 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2MUWDuJJpUna7beoys7HUlkLc5dT2+PUJ7Pew4QVd8=;
        b=ML4jIAvEJ8vKTsq17AYfVBKsZiuf7fZVFYxdsBt6xSXhJf4t+Iqim6iDlJD/piWXni
         fek3dcepc8dG06HIwCB9hxkpzgyX3ZeFfbfhj+jfM11+D0A2q3JYkYU2/UPA7vyvGNno
         6gjgC9GOhgNgbp/sWcH/2wvbwrSx5WnYqbzWO1FpB9SNg5WIem+yiCRS+KC2IzU4ybg6
         UlAzcjGrkSPcIfalST9W/8JB/Bp2do3N6/et5WjfyVZ3b3ytIAObcTT8fTXHRcjWyATF
         qZHYhDROEZ68g+0Lrdbt24VcudseLdSJK2SQeJh/tqwfo6zI5Z+cLTZFnHOCdXtwcFu3
         pxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2MUWDuJJpUna7beoys7HUlkLc5dT2+PUJ7Pew4QVd8=;
        b=2jTMXbJQMX2qbAW90p8V7pWFXrjXnps5epcsp8swUENBN2KfWQtK5Vb3HUyX5cMfcF
         whp/tRjBmaWf+72lpNj0qTueyiveeRoGT1T60JcvtQvqjg3guyw5Ii1PolRR7u9O6c8q
         +CBxhgh3bs+Pj1g1cZ6FEkpCueq5GqVYwhJkMRzJba9l1/DrNtVHG3a5NlBs0xDVayTv
         uiQZgMyjOoUT0MZmqCUjQuOpIpFw/rLj/T5G9wS4ON1ZVSU/VcVzx5eCJlo6jrG0WRnp
         E9OQNITtzWCQRBFuWoAJwRjyUd02kMzwvVA2XvPEh8FmSXXj4aPsM00WIgukdr5xwI5Z
         fiqw==
X-Gm-Message-State: AOAM530IgXfkEqH30aShG6isBIgrw9YWhX7L5tjCcr5Yi8wDYbZw+n5b
        oodf3CWfcc9+Zt1pewdLHko=
X-Google-Smtp-Source: ABdhPJwf9J5HuDmSJa4aWGCkbBrXSd1imh4D76BahTsUk6U/GExWJ3IrLvvMKTvVAy3s4MuYABg6tw==
X-Received: by 2002:a2e:88cf:: with SMTP id a15mr21829394ljk.378.1635201948920;
        Mon, 25 Oct 2021 15:45:48 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:48 -0700 (PDT)
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
Subject: [PATCH v14 03/39] soc/tegra: Don't print error message when OPPs not available
Date:   Tue, 26 Oct 2021 01:39:56 +0300
Message-Id: <20211025224032.21012-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Previously we assumed that devm_tegra_core_dev_init_opp_table() will
be used only by drivers that will always have device with OPP table,
but this is not true anymore. For example now Tegra30 will have OPP table
for PWM, but Tegra20 not and both use the same driver. Hence let's not
print the error message about missing OPP table in the common helper,
we can print it elsewhere.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index d930a2b4facc..bcc93e6f9205 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -127,9 +127,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	 */
 	err = devm_pm_opp_of_add_table(dev);
 	if (err) {
-		if (err == -ENODEV)
-			dev_err_once(dev, "OPP table not found, please update device-tree\n");
-		else
+		if (err != -ENODEV)
 			dev_err(dev, "failed to add OPP table: %d\n", err);
 
 		return err;
-- 
2.33.1

