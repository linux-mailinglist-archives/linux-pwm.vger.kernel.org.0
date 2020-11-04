Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4996A2A7293
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbgKDXsJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733119AbgKDXpS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:18 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21732C0613CF;
        Wed,  4 Nov 2020 15:45:17 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id l10so319613lji.4;
        Wed, 04 Nov 2020 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YgLGCQXpeJZfFmnY68KfLbg6dxMT669Npx+3tSC26GM=;
        b=dk0U6+f2C7VUHqKjoUYB2aK076wm5BwTdxiZCbd3uUa2zyQ/d9CMUV1ZZ2KQnMlzTd
         LOTeSud3rh7assb6Ia+jQ7NJHowfjFWLm6fMk9pZ+9uxzOyB1LBVVTUpMvxx0PKMn4/5
         9N4ZLclTjASGE17Rz3h91aI4xowOgbChE1arhBHxVL0uhW3EC9qdqOO10uz3RCXLN7Wj
         3BJqQEe5hU+a6BCLXRJrugoDEN2jIeHOloGArD48l5Td7waZukBXuXzTJmJf1x3367PS
         dXyJ9COq9Dw6zJnHxnS+Vr6bxEFd07O7yswItLDV0bQTaYIIwskDu0ONAT/mi5jC57qF
         lxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YgLGCQXpeJZfFmnY68KfLbg6dxMT669Npx+3tSC26GM=;
        b=g3EUVibzUP1cvPPX09NnZneFG1cYkFapCBi9MNO/cCXwqrya7hi2baf4okbM7xZvtK
         3rKkKdfB+yZH5tUBNkDoIvM2Y8esLqIPBtlPKYTII5t5xKXnrIxaW383azXzTquidneO
         3Xm9njY2MZun5Dy4LfGgjz4zGaQLxF9WNCVTTqvdI0go16VdTiJmrM5aIHm6UlwZh8KT
         +GMHMq74qYcfhiDUHTndyEbYNiXkzeHjsSFOuxxA5+0XotYINlvL40m5TDmvtcXQDv5v
         zzYvMhTgzc5h1BxgpDI6/MUCCg6suZn3oGKQCv7+513ZtIkUTr0lVTKp4k3iPUXqiuNW
         XYpQ==
X-Gm-Message-State: AOAM5316SH/7IQLlKcdVlTqjJHWXOiEcQ+c1SQ096gKi8+xWNS5zoFYq
        9/4AQj4y/16ZS5KtV2aAnHc=
X-Google-Smtp-Source: ABdhPJygW7zhBUwueiGc0u5rCNdcAaQu9G8QeXXpn9e/yoz5YItRyw+RW6puxRSf6SsG6DlthKdyjg==
X-Received: by 2002:a2e:819a:: with SMTP id e26mr134454ljg.469.1604533515613;
        Wed, 04 Nov 2020 15:45:15 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:15 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 14/30] drm/tegra: gr3d: Support OPP and SoC core voltage scaling
Date:   Thu,  5 Nov 2020 02:44:11 +0300
Message-Id: <20201104234427.26477-15-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add OPP and SoC core voltage scaling support to the GR3D driver.
This is required for enabling system-wide DVFS on Tegra SoCs.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 136 +++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index b0b8154e8104..0c6efc55f9bc 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -11,7 +11,9 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/pm_opp.h>
 
+#include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
 #include "drm.h"
@@ -278,6 +280,135 @@ static const u32 gr3d_addr_regs[] = {
 	GR3D_GLOBAL_SAMP23SURFADDR(15),
 };
 
+static int gr3d_init_opp_state(struct device *dev, struct gr3d *gr3d)
+{
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	int err;
+
+	/*
+	 * If voltage regulator presents, then we could select the fastest
+	 * clock rate, but driver doesn't support power management and
+	 * frequency scaling yet, hence the top freq OPP will vote for a
+	 * very high voltage that will produce lot's of heat.  Let's select
+	 * OPP for the current/default rate for now.
+	 *
+	 * Clock rate should be pre-initialized (i.e. it's non-zero) either
+	 * by clock driver or by assigned clocks in a device-tree.
+	 */
+	rate = clk_get_rate(gr3d->clk);
+
+	/* find suitable OPP for the clock rate supportable by SoC speedo ID */
+	opp = dev_pm_opp_find_freq_ceil(dev, &rate);
+
+	/*
+	 * dev_pm_opp_set_rate() doesn't search for a floor clock rate and it
+	 * will error out if default clock rate is too high, i.e. unsupported
+	 * by a SoC hardware version.  Hence will find floor rate by ourselves.
+	 */
+	if (opp == ERR_PTR(-ERANGE))
+		opp = dev_pm_opp_find_freq_floor(dev, &rate);
+
+	err = PTR_ERR_OR_ZERO(opp);
+	if (err) {
+		dev_err(dev, "failed to get OPP for %ld Hz: %d\n",
+			rate, err);
+		return err;
+	}
+
+	dev_pm_opp_put(opp);
+
+	/*
+	 * First dummy rate-set initializes voltage vote by setting voltage
+	 * in accordance to the clock rate.  We need to do this because GR2D
+	 * currently doesn't support power management and clock is permanently
+	 * enabled.
+	 */
+	err = dev_pm_opp_set_rate(dev, rate);
+	if (err) {
+		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void gr3d_deinit_opp_table(void *data)
+{
+	struct device *dev = data;
+	struct opp_table *opp_table;
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_put_supported_hw(opp_table);
+	dev_pm_opp_put_regulators(opp_table);
+	dev_pm_opp_put_opp_table(opp_table);
+}
+
+static int devm_gr3d_init_opp_table(struct device *dev, struct gr3d *gr3d)
+{
+	struct opp_table *opp_table, *hw_opp_table;
+	const char *rname = "core";
+	u32 hw_version;
+	int err;
+
+	/* voltage scaling is optional */
+	if (device_property_present(dev, "core-supply"))
+		opp_table = dev_pm_opp_set_regulators(dev, &rname, 1);
+	else
+		opp_table = dev_pm_opp_get_opp_table(dev);
+
+	if (IS_ERR(opp_table))
+		return dev_err_probe(dev, PTR_ERR(opp_table),
+				     "failed to prepare OPP table\n");
+
+	if (gr3d->soc->version == 0x20)
+		hw_version = BIT(tegra_sku_info.soc_process_id);
+	else
+		hw_version = BIT(tegra_sku_info.soc_speedo_id);
+
+	hw_opp_table = dev_pm_opp_set_supported_hw(dev, &hw_version, 1);
+	err = PTR_ERR_OR_ZERO(hw_opp_table);
+	if (err) {
+		dev_err(dev, "failed to set supported HW: %d\n", err);
+		goto put_table;
+	}
+
+	/*
+	 * OPP table presence is optional and we want the set_rate() of OPP
+	 * API to work similarly to clk_set_rate() if table is missing in a
+	 * device-tree.  The add_table() errors out if OPP is missing in DT.
+	 */
+	if (device_property_present(dev, "operating-points-v2")) {
+		err = dev_pm_opp_of_add_table(dev);
+		if (err) {
+			dev_err(dev, "failed to add OPP table: %d\n", err);
+			goto put_hw;
+		}
+
+		err = gr3d_init_opp_state(dev, gr3d);
+		if (err)
+			goto remove_table;
+	}
+
+	err = devm_add_action(dev, gr3d_deinit_opp_table, dev);
+	if (err)
+		goto remove_table;
+
+	dev_info(dev, "OPP HW ver. 0x%x\n", hw_version);
+
+	return 0;
+
+remove_table:
+	dev_pm_opp_of_remove_table(dev);
+put_hw:
+	dev_pm_opp_put_supported_hw(opp_table);
+put_table:
+	dev_pm_opp_put_regulators(opp_table);
+
+	return err;
+}
+
 static int gr3d_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -302,6 +433,11 @@ static int gr3d_probe(struct platform_device *pdev)
 		return PTR_ERR(gr3d->clk);
 	}
 
+	err = devm_gr3d_init_opp_table(&pdev->dev, gr3d);
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "failed to initialize OPP\n");
+
 	gr3d->rst = devm_reset_control_get(&pdev->dev, "3d");
 	if (IS_ERR(gr3d->rst)) {
 		dev_err(&pdev->dev, "cannot get reset\n");
-- 
2.27.0

