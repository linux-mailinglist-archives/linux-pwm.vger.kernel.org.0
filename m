Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E59E43A717
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhJYWsh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhJYWsV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:21 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C923C061348;
        Mon, 25 Oct 2021 15:45:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q16so12204447ljg.3;
        Mon, 25 Oct 2021 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCCJ0mW2gwsnFPN+OPsgUTOb6pwwmydDjjp/u9hKbfY=;
        b=QxYo2YxRLTZ/QUkVuiRrnKUMCi8iGuqEstVwgsUSEQsoc6hmdMw+zQ8cHA1k7e+jeQ
         qHcynesgFZvCObbzzG8s/OVks7bTtwzpjKUP3t3xwCnPFhBLOBcUtwJ7LJ8QyP733364
         Y7mqrB7OTybWq+UzpoGZQ1frr+KhmDX2njZoTQHC6YN7ypxeHsjJR0lwz1fHkmJ27XTn
         VoOgsLDf4WEx63DqHAznvn5LOOi87i85TNtLZdcdvmvlawvuaBN/U0yB7UnNG50w5VDr
         tek6PpbQmfgzSzr8/KVws4qYlCWEadcasHxJN+GGCsmMiHlgEJ5Bd8aE9VWYZHmDYWOM
         yzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCCJ0mW2gwsnFPN+OPsgUTOb6pwwmydDjjp/u9hKbfY=;
        b=ArhtNeFbkawfY6kk81DMPLLaDo1SlHxCFn7LZKoarXYcp4FMOPczAyEDK/LXTAXyy3
         aMTOm4L+mk0Im8v1Vme9dkKU+37IMZIG8zzhMaV9hG+pzA+VY4F4E5RlyBF/pidb01ot
         4gumJQqOP7TWEzzIsrqpgXB7zzrc8tn2GJStzafZxaYnl3AIUCHeNOK3AQUBwhWGPrzi
         +u6lq3ixUWGVzijwREBfROw+DXt3ksrKFpjpjXEPgT+GQe3oOwGYy/AbxVWvcLbPUzIw
         rwXCXHx4+CO9nri7T/0DIGB511zwH37IrnNi6zzoyoKUq9NTqh0vax9o5kjIh6EYsIPd
         DukQ==
X-Gm-Message-State: AOAM531T3zuBDX8NMAV3FiID27o2dFwNGNBZV9sPN8kEoHbOZQmkiqoa
        Ps9Vj97hY3SRJGgpi15S9AHZZHaaJFk=
X-Google-Smtp-Source: ABdhPJyvIkPk0JW1nUlhm/sbKY+klJKBKRC4kwdUeSR8nEuSsxoPCzdbWKExoyLredOoboxG47izfA==
X-Received: by 2002:a2e:9b09:: with SMTP id u9mr22560700lji.111.1635201956554;
        Mon, 25 Oct 2021 15:45:56 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:56 -0700 (PDT)
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
Subject: [PATCH v14 11/39] drm/tegra: hdmi: Add OPP support
Date:   Tue, 26 Oct 2021 01:40:04 +0300
Message-Id: <20211025224032.21012-12-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The HDMI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now HDMI driver must use
OPP API for driving the controller's clock rate because OPP API takes
care of reconfiguring the domain's performance state based on HDMI clock
rate. Add OPP support to the HDMI driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/hdmi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index e5d2a4026028..9a87d351a828 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -11,10 +11,13 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <soc/tegra/common.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_debugfs.h>
@@ -1195,7 +1198,7 @@ static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
 	h_back_porch = mode->htotal - mode->hsync_end;
 	h_front_porch = mode->hsync_start - mode->hdisplay;
 
-	err = clk_set_rate(hdmi->clk, hdmi->pixel_clock);
+	err = dev_pm_opp_set_rate(hdmi->dev, hdmi->pixel_clock);
 	if (err < 0) {
 		dev_err(hdmi->dev, "failed to set HDMI clock frequency: %d\n",
 			err);
@@ -1732,7 +1735,14 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, hdmi);
-	pm_runtime_enable(&pdev->dev);
+
+	err = devm_pm_runtime_enable(&pdev->dev);
+	if (err)
+		return err;
+
+	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (err)
+		return err;
 
 	INIT_LIST_HEAD(&hdmi->client.list);
 	hdmi->client.ops = &hdmi_client_ops;
@@ -1753,8 +1763,6 @@ static int tegra_hdmi_remove(struct platform_device *pdev)
 	struct tegra_hdmi *hdmi = platform_get_drvdata(pdev);
 	int err;
 
-	pm_runtime_disable(&pdev->dev);
-
 	err = host1x_client_unregister(&hdmi->client);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to unregister host1x client: %d\n",
-- 
2.33.1

