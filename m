Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD25244FA3B
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhKNTjJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhKNTi6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:38:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB3C0613B9;
        Sun, 14 Nov 2021 11:36:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z34so37499656lfu.8;
        Sun, 14 Nov 2021 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGt0BYEmXAksyhDFPu2BDGLoJLdnyV3VilAtYqDDqgs=;
        b=lVqJAOeNI0okpK+ZNPrPpQzhKhnvBynLj6rEd5DozN5lsk4t7hvTL+CgzdLf5NesKP
         llHomqAOkg5bAWNLo7neo17ZmmABy46e5gJrTg1ghb+ivk1IFEjkLEP/1PaHaTEI7DDU
         s8occ9jGoqqBZUqKdoUNcNCoTICQXgG17ow2VYDDlCZHDUTBciRSFYSuNef/PGF910Cw
         WCL+AZZDNxa0mTnCCIi5slFWeDBu38zmI056Lxwsbw6ErQxX3oSqjbjs5jY318csw4FG
         3tW3yCimiKuZW1MArDrTyNWNZLAx36+vRAimvL2Jy9qTn53Y9qBFxrUcYy6ZveN7kObk
         jDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGt0BYEmXAksyhDFPu2BDGLoJLdnyV3VilAtYqDDqgs=;
        b=U6ccgjhCN3pNOTxOQh2rIZ4Uklwqy0vnbfEY/dn94WGzqKqR/eeEBndcbYHp19UgV4
         nD3KLvK6K4b8SZBnMQL9qSDA5fUZphrT2kMf/1e+WjUnSEoXlhBj0OIGBdbtApdVrWJU
         YhBQP6EbloUEbQBCrgEfkb+D93LyAfAMNPodN3ZS1cyL0OsmknZNEu2+bVl6dinyk+WR
         hrhgqR7Tikfd0oAu1QBqzyxrCH/p6d30bhZXN+qXdRJiS/SZa/BdqvWESZof/+TXdyNM
         Zo+Tu8WDVNxy39FaKGcnWZPdqkKUREExn3Mao48agFNH+lPlES05VitEhzIfsBRY95rh
         6zkg==
X-Gm-Message-State: AOAM533oQs3jJFZyTSBhuSqkiw4GA0ewHzi9Kqt1M30VCqxpGArNA9IY
        tFTS5QVkppsBy1E0MBXXobc=
X-Google-Smtp-Source: ABdhPJyY+x77AHzGE324Voq1Crep3/hYOUHM6QvyVpOEpDOayjzVPnC7YoCw0MpQChNlRezJlYre7A==
X-Received: by 2002:a05:6512:5c2:: with SMTP id o2mr25852093lfo.8.1636918559591;
        Sun, 14 Nov 2021 11:35:59 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:35:59 -0800 (PST)
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
Subject: [PATCH v15 03/39] soc/tegra: Don't print error message when OPPs not available
Date:   Sun, 14 Nov 2021 22:33:59 +0300
Message-Id: <20211114193435.7705-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 35c882da55fc..32c346b72635 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -136,9 +136,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
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

