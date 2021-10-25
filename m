Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3043A6D9
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhJYWsN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhJYWsL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1161C061745;
        Mon, 25 Oct 2021 15:45:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u5so15043240ljo.8;
        Mon, 25 Oct 2021 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aHKo9U8G+hLWY9EhoAIxvumgKe10bBXiBCDSZoonsq8=;
        b=QfDo7hKR9f1y0W42WzUitoiDe2dQwmdRrti4UPRTDFdgXbYLWLzYVGBdbyMN2l14vP
         2k2/WQdJoIWBsqg4kd+P5TCqyMpygXBiu+8+KK1ozP93q3NeZPxKZSegtI9JDk2/jXb8
         360vXgS5USACZksuTnMOdWGqPboITPUj3cobNlRkD2OZc3111rzItscq4VhjF4RwN+M4
         LGJcaqhbjUVtwuXHb2DB5aZflfWpa0tdTyvr5k0x3mauWlQt/kd7AH1W3JpaOb7923rH
         Qw1OInFLOkHS+j9JnckHCUIC1IrRYNlwHZzp0uH1fW9Shl98KCBPgLLUMh+DwzEOtBaa
         6pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aHKo9U8G+hLWY9EhoAIxvumgKe10bBXiBCDSZoonsq8=;
        b=RGmsBVjjnJ8XEUV2Wf1nBOE2rZm0w0cnKmjMOL0vdEEQiVy/ZUSpabrCZrViahTOaO
         pGtd0+BsXyudExvlLA9Z7MsjuLb+wRyhQbrE5V6MlXiWpbuzLau+A5iACPRtRQLRqd7G
         Ta6BczUjMu+Z27ZA2slixOXe3BOpewU5cPhwKFNjCic4EjK/wWogqyRhvt5RxxVgj19Y
         eDJcEZk0R5Xzmi7n/clv0KoV/4EpQ2QhdHe7pCKo+mG3YIE8SLh8im3G7NPXo/E5COY4
         Lwk1lD3jz3+7uY7hgdcTI8cZgiLmC3484/3PetRGJZZoSF0irgzOi1Gx1ecBegV6yyTF
         kF1g==
X-Gm-Message-State: AOAM532w/zMzM0nfcxECO5SD3wu/GtCGDtgjlQdhKYoX8lVVxvSxdb8F
        65HWTKzk7csF0tlj1OXk7Fk=
X-Google-Smtp-Source: ABdhPJwXtANvmUyK02F8DsRd7yaKx9hqiVWiYDN+fdBuGsFPP4+XNKGmf08wj+plJ6DP/RAXnV6Zhg==
X-Received: by 2002:a2e:a364:: with SMTP id i4mr22671083ljn.326.1635201947067;
        Mon, 25 Oct 2021 15:45:47 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:46 -0700 (PDT)
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
Subject: [PATCH v14 01/39] soc/tegra: Enable runtime PM during OPP state-syncing
Date:   Tue, 26 Oct 2021 01:39:54 +0300
Message-Id: <20211025224032.21012-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd33e99249c3..d930a2b4facc 100644
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
@@ -57,8 +59,22 @@ static int tegra_core_dev_init_opp_state(struct device *dev)
 		return -EINVAL;
 	}
 
+	/*
+	 * Runtime PM of the device must be enabled in order to set up
+	 * GENPD's performance properly because GENPD core checks whether
+	 * device is suspended and this check doesn't work while RPM is
+	 * disabled.
+	 */
+	rpm_enabled = pm_runtime_enabled(dev);
+	if (!rpm_enabled)
+		pm_runtime_enable(dev);
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

