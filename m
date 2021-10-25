Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029FB43A6DF
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhJYWsR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhJYWsM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD669C061745;
        Mon, 25 Oct 2021 15:45:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z6so211743lji.12;
        Mon, 25 Oct 2021 15:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfYN7XHpH+9woQPLaDemd7XarYfLNqssALI4rIMlpEY=;
        b=TIcjAVSSZ/UNHVrpIadHBggfdiSAKY9zyphvZ3bUq5dXMuQXjVJqG9s/pYzfIC5rN1
         maI4zSszTvzmQqyBcGtzMvrwyfdqFHUMA2weUwivQEV8H4B/c9sbRF1tFtaysd8VbPkf
         rw+IXfCczdRUgkorMrKG4iQGVcuO3D73WHf8W+2JXjRovBeB1zNeE/jBV0awGAo31Mbl
         KQjERexoLk2//Z8Dhej47KRzZUrJxJnQ42GVySpddmhDTdqBi+G0oZZQIg20JvCAaatH
         V4VMVzJTiXYw3Zse3XYAGo18X5+9dMAw5PZwlRstda/9qKUHu7LSQWfogniULPCFkTWS
         R1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfYN7XHpH+9woQPLaDemd7XarYfLNqssALI4rIMlpEY=;
        b=Npt/ipCvV5wft401CzG1dQwbybaOcJNV3CcYT86lmrmMtD1onVQQ3AQMqza4QpFT2t
         YM4Gfo3NGlsEzu1jjNUrLijq/wWIuAnVUUS3R/7XXySAaiHGKzanMFcMzDTL04F4mcfe
         BVHI7Q4nu9g4/xQLOyVoIwPQ2JNdbc+tQS4mC81UWsA3ztY0IGr0JUXtj3BHK9QQi3wH
         Wr49ujgtR/TdVyMtC8OLjx+aVXMlyVG7pChrz9wUbFPSeltiX/bbCzIlR6aytK2Yip9J
         lKCDscDnWnc//CYDrjC7Bc/2h/XAkFmcNkb+cK3CWA4rjzgCnFW+RTjycFhBG61IbFON
         Na8A==
X-Gm-Message-State: AOAM533TQHr8fEfxxvxfZKKjrbhWgMrtZOTLq+7alcAdQHE4LYvu4nfL
        miWTgL68eJlXyyUDRhgo+CcBThlJ8NM=
X-Google-Smtp-Source: ABdhPJx+D1XFwTP5mWwDmLmQmWmYlnzBAJkt9DAZjsILcYyCGJDBNtGhKPR9ckO6xOTTUZ8zTm38Pg==
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr21879679lji.530.1635201948023;
        Mon, 25 Oct 2021 15:45:48 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:47 -0700 (PDT)
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
Subject: [PATCH v14 02/39] soc/tegra: Add devm_tegra_core_dev_init_opp_table_common()
Date:   Tue, 26 Oct 2021 01:39:55 +0300
Message-Id: <20211025224032.21012-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Only couple drivers need to get the -ENODEV error code and majority of
drivers need to explicitly initialize the performance state. Add new
common helper which sets up OPP table for these drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/common.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index af41ad80ec21..8ec1ac07fc85 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -39,4 +39,19 @@ devm_tegra_core_dev_init_opp_table(struct device *dev,
 }
 #endif
 
+static inline int
+devm_tegra_core_dev_init_opp_table_common(struct device *dev)
+{
+	struct tegra_core_opp_params opp_params = {};
+	int err;
+
+	opp_params.init_state = true;
+
+	err = devm_tegra_core_dev_init_opp_table(dev, &opp_params);
+	if (err != -ENODEV)
+		return err;
+
+	return 0;
+}
+
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.33.1

