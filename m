Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1136144FB0D
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhKNTjF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhKNTiz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:38:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364B3C061767;
        Sun, 14 Nov 2021 11:36:00 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c32so37574946lfv.4;
        Sun, 14 Nov 2021 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYMzBVvFXat+EF6D7Xq1trPhz10Qnf9JVl9Iy6huEzk=;
        b=ppo1Nuy3hCzzVWf+dK+TuoyRe0srrpnDCAnnL2isE3MbnPGehdIAJ0mqeMYQ2MJMDt
         9UblzxNgCIj6S1RHfns7F/zCgeancy+xo91fCEgJNikVpyJKapMLk7HDTRzup/PGthrE
         HACW+/cjTs1RYVeZ/KLSPk5t3sf6pI3kLnGWEqwYVlzbABsjgKy/f5mknix4q4C1c8zY
         i2Ck3/PsTDUJ5EuDqrDEqwiGgfkEOP7wRB6tdMD7N4HljVUfsKobOxqcl1WgGG+mfW5c
         J28tIlCZSXyx7x90TXSMDzOARcYcsTz2rK4jC+KgWLXqOhP+WWa/Iz4d4ZJYShMcSX+u
         nQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYMzBVvFXat+EF6D7Xq1trPhz10Qnf9JVl9Iy6huEzk=;
        b=Q823d8MM6LMh8LUbQ7ZXnDCfAdklijz+ib/VnYVni5F3JGGSUJe8IJtLNrXJvg31ir
         qqwWGcOGQp9R+FpNkl+8q/oeyMlGf5XcGjJz7RWOQFaz2XNfOPmTd42qzXUeuEHuSgAw
         T8rqC8gzBFCAdAHnw6JcG/+lhKk0D/DEhNQTXAJMPNnGB/91qsPgvoEAaXB03shtD2Yg
         YrQMYQyTeI7q+rTRB5Hko/QU0v5w+pNba5/hr8UMNJWWCqqgX7Hk3x4qnLwaujnSBvc1
         rwA2z/klCNvp57d1m1yI9eXNpZ6WPq20FBGKVgI3tr5DGUdJ0LMZJCo0wnM2ihoji3dL
         /m8w==
X-Gm-Message-State: AOAM533lUfoLjYlq2fQCwzP3i62f9yF4/auYUj94ryx5FADWVaq2QHkq
        bPkyJwQJFHe+vLI+77A1wb0=
X-Google-Smtp-Source: ABdhPJx+Wz6gB8VCqF1e/R/0jBJZsGb+bImJiOHD5oJbf6GFFR3Z4Z1WTTqmqM0RthfM7uKsZ/+2vg==
X-Received: by 2002:ac2:4bc2:: with SMTP id o2mr22454206lfq.660.1636918558544;
        Sun, 14 Nov 2021 11:35:58 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:35:58 -0800 (PST)
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
Subject: [PATCH v15 02/39] soc/tegra: Add devm_tegra_core_dev_init_opp_table_common()
Date:   Sun, 14 Nov 2021 22:33:58 +0300
Message-Id: <20211114193435.7705-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Only couple drivers need to get the -ENODEV error code and majority of
drivers need to explicitly initialize the performance state. Add new
common helper which sets up OPP table for these drivers.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
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

