Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040EA418CA4
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhIZWqZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhIZWoS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9CC061570;
        Sun, 26 Sep 2021 15:42:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y26so29087723lfa.11;
        Sun, 26 Sep 2021 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31z6ju9IxXkuW5YuopLRzoIoj/otNjt9+lw55F7t8U0=;
        b=LLfiLqLR3Uv7MtvTYWmjc+gcUe3dYi7j5vfpS6/nXEonrzdADV499jnt5g3VHYmD2P
         IaJ9zQyJW0W//HcMG4bBA5YT4Fr5lc1ID60Ts+UOEA9GovTWKNfpdh0YDJCPL44Z6Fg3
         fJxIp994pumpxP8I7tQp1FOAcJkOoFY2+usFlO+SvVbk1/LGRkkmiMG3iaGgF4UAC2ql
         0Ri9qBnHW1OOaczmHUjlOfjPGmyKdENaX5Dw0spWFIN7YfCE4HgZSBe2T0njdEUSsEJZ
         nuNGVhBSXtbuozBRSxrfynWwPezZ2KvPJ2V+KcepW/7yyNDq4dqvqfngbeBJJgDmQpw2
         /6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31z6ju9IxXkuW5YuopLRzoIoj/otNjt9+lw55F7t8U0=;
        b=ld1o450rbkkDSbhPNs0GuNbjkj3ULRsbVhLLuk+ZGQelRIcvV5hl00+T8L2vIqoWL9
         SjWSoGYNhigl5oG5NR+IZeNsR+8B58onLusLUeYplvCKugTWwrMt9OJoMApiFqpAbAVx
         1BfQtoR+DfWAa5dBHBfrWQWh/pH8j/RPHTfyKCNIGL55HAu0YBbYD6/Dy/ldVUbg7dsM
         YTkGGcKYpzT/Zcfu3C6QvEXxzMh0K2RktBlKnU+vJy/aJDBLhI5VimXZhP6LUU9NX5HR
         An+nHYhzTagu7nCwDTkYIPprq/dJG7d0bqljaM1g7hEXwIVqkIm+uYlqs3CbRP3zy+9M
         6TVw==
X-Gm-Message-State: AOAM5305hXk9egfJmo9C04VA03a7R2fOmyvwMdE6a7tg3A8t9xNMUbux
        Ur34HjNCsy1FTUu69dh+r98=
X-Google-Smtp-Source: ABdhPJylJVQRDOfsnswWdBhvajz1HdfChCZWUg3V/0pQG3UKT9LOlK10u4P3TFgY9egIg+K11N0IHA==
X-Received: by 2002:a05:6512:3c92:: with SMTP id h18mr20860545lfv.656.1632696160164;
        Sun, 26 Sep 2021 15:42:40 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v13 12/35] drm/tegra: hdmi: Add OPP support
Date:   Mon, 27 Sep 2021 01:40:35 +0300
Message-Id: <20210926224058.1252-13-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
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
2.32.0

