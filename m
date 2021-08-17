Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6D3EE37C
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhHQBdf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhHQBav (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026FC0613CF;
        Mon, 16 Aug 2021 18:30:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h9so30219398ljq.8;
        Mon, 16 Aug 2021 18:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OiZ4j31PBjUgj6NMuu1gRDwGRqT/foQN2QYxiwSoqj4=;
        b=kn4kT2Hz//hHPdVcdZ/vDzNa1AeB3fmoQ2KajKAe8K7HeAMLN9J+RLJn4O28AknXce
         O2Uwz+3Yl0HQPwUdJJ7gnzB+AAvuNYEvsVKU5gzzehu4Ot/microMtTIcN2BWF9rXCaz
         B8yn4zAA/jxH8Gy0lwR0fopTYPFhuNd2yvKwuGedIegQZfEuPz+7R7Lfy/3hj0LXXZRu
         /2zacj4fZCA9HTFFaFNhgAdlvb+Sffe0y/0KJLEluMiCSdWTI1ZcpPIFPI8Lfvx35l+v
         IjrIHeypjpz8Nd6Z+KW5WqXJWbCNUfPhk2W6I1nnjI74cdD5bp9O6HY8in4VjsotEekV
         Tl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiZ4j31PBjUgj6NMuu1gRDwGRqT/foQN2QYxiwSoqj4=;
        b=GfYDntsWwpEth+xNGBJbX/kWJr7RzVtwHN2nH+oxBM5nTDLthD7D1N1UZpsaHb9MJZ
         GBgEYD+gCd0AMWM+vjsY37nDhUUhqvGkzsC8o7RRCJ8WqgXDl6xr1L1FOgzUh5c+Wnw+
         DkzECpFmhqXDwNRDQsdDG8TRodQwHFE+agekozNth53P67M4vCD3/nVhd874+y7K3KJh
         pe+1gvo1jNWyjNRMagSQwpyrYll5msrbnlImSJ4SIvsKSNA8GRHL9qUPvey9jfRhQCNp
         Xp13i2EQJyNhre3CfFVbwzAE2i7UJJRXeUbzWt3J65dTRcIAT15CFOTGCENnLOeb32L8
         dzRg==
X-Gm-Message-State: AOAM532vh8tdGoRjdHsMesEHQcbWCW3i4wf13ijB4GtPIdeAjkf5ELlu
        pUQZLuECrsYGWp5YW729n58=
X-Google-Smtp-Source: ABdhPJzs3U6yU/CHeEWumMqhudKOiOVdPxHW87EZcifX16I4zyesaHC8qzahhba2hNw8USFhBY7eAw==
X-Received: by 2002:a2e:9593:: with SMTP id w19mr836879ljh.323.1629163817004;
        Mon, 16 Aug 2021 18:30:17 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v8 13/34] drm/tegra: hdmi: Add OPP support
Date:   Tue, 17 Aug 2021 04:27:33 +0300
Message-Id: <20210817012754.8710-14-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
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
 drivers/gpu/drm/tegra/hdmi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index e5d2a4026028..aa13028480f7 100644
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
@@ -1516,6 +1519,12 @@ static int tegra_hdmi_runtime_resume(struct host1x_client *client)
 		return err;
 	}
 
+	err = dev_pm_opp_sync(dev);
+	if (err) {
+		dev_err(dev, "failed to sync OPP: %d\n", err);
+		goto put_rpm;
+	}
+
 	err = clk_prepare_enable(hdmi->clk);
 	if (err < 0) {
 		dev_err(dev, "failed to enable clock: %d\n", err);
@@ -1708,6 +1717,10 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 
 	hdmi->output.dev = &pdev->dev;
 
+	err = devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);
+	if (err)
+		return err;
+
 	err = tegra_output_probe(&hdmi->output);
 	if (err < 0)
 		return err;
-- 
2.32.0

