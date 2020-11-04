Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBC2A72D4
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgKDXtS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbgKDXpJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:09 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD61C0613CF;
        Wed,  4 Nov 2020 15:45:08 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id 74so173553lfo.5;
        Wed, 04 Nov 2020 15:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4QimH9wixy8sUB7tTt0ejrFN10+/Shho7WvFn1DTIo=;
        b=dKshQylaisfazGLbqjJynNEv/W5jHHOSC6fWy+cQSRbNrw3Sn9m13dXMnlQFzXZh+9
         jjjMBRTemz68g1I6hTq0wtO3PKN4aR0JCmqKfPw5CHwG+W4JamEdhE9GRExgA815HRbz
         5TgvpdbdQlnRuLCVAnFo/gC/os7ONW5taN1rRU1hM+ElRh5ge6rWgsJBpgKrt3sy+teM
         Hx4WUD2hRx/QvX1nsj52G22qFNIKzfNVecV+z2OoIQy5XzIB5cvNKtaDvJADYKBOq2Uv
         bshtPA2DeLq/XoR9UXw22XItF8/SMhepK34QQey16JBZ6SW9ThM36wjvBnN4QeLsYNcx
         ndSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4QimH9wixy8sUB7tTt0ejrFN10+/Shho7WvFn1DTIo=;
        b=fFjS158eZxT1YA8CtkRRRFfLxCYlUNc1bAhcUaoVcMGaQ12sxEDKZx+CKJ9RzgowhQ
         04fh9MR2JxaKS8JV+PlWYMLQM0tK1N3fbyvqetdKwtOtZg2JNwRXvs6S+cgtd+IcaB8T
         k2tG+Tow0wef6vXs8D8nAxiyCY9BuvfthgOzkDDgL5LMW3YWfcu28CORtAw/b+WZ+/I4
         +/0WUln/ljwhuDyjGhxwMyLOq66iA0U0e3GqdYm4U48mj1Vju6RA5+/BYWtQ0DolIghr
         umvmGa1o9Hii1ttz1C5WdUc7J21vRq1rvsgrMkiriZgtG3565uf+y8Si81825d3j531k
         rc/g==
X-Gm-Message-State: AOAM533b6M0HPbomYMvdjQPMPLc6WvyiWKHhcYh8eDOa760HC9k9bKVk
        2jYGWxycdaGeyBOoqQJLorQ=
X-Google-Smtp-Source: ABdhPJwc+DcATK9PEz9mXDwZxrtALkgyvN1NGIQXeYhDUAr0bKOyCG3OszTEdmeCqIUKYjNynylY6A==
X-Received: by 2002:a05:6512:3af:: with SMTP id v15mr54234lfp.144.1604533507285;
        Wed, 04 Nov 2020 15:45:07 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:06 -0800 (PST)
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
Subject: [PATCH v1 08/30] soc/tegra: regulators: Support Tegra SoC device sync state API
Date:   Thu,  5 Nov 2020 02:44:05 +0300
Message-Id: <20201104234427.26477-9-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Downscale of the CORE voltage isn't allowed because some hardware units,
which are supplied by the CORE regulator, usually left ON at a boot time.
The new sync state API resolves this problem for us. All drivers of the
devices that are known to be ON at a boot time now should sync theirs
state. Once everything is synced, the voltage of the CORE domain could
be scaled without any limitations.

Make Tegra20/30 regulator couplers to use the new sync state API.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/regulators-tegra20.c | 19 ++++++++++++++++++-
 drivers/soc/tegra/regulators-tegra30.c | 22 +++++++++++++++++++++-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/regulators-tegra20.c b/drivers/soc/tegra/regulators-tegra20.c
index 367a71a3cd10..8782e399a58c 100644
--- a/drivers/soc/tegra/regulators-tegra20.c
+++ b/drivers/soc/tegra/regulators-tegra20.c
@@ -16,6 +16,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
+#include <soc/tegra/common.h>
+
 struct tegra_regulator_coupler {
 	struct regulator_coupler coupler;
 	struct regulator_dev *core_rdev;
@@ -38,6 +40,21 @@ static int tegra20_core_limit(struct tegra_regulator_coupler *tegra,
 	int core_cur_uV;
 	int err;
 
+	/*
+	 * Tegra20 SoC has critical DVFS-capable devices that are
+	 * permanently-active or active at a boot time, like EMC
+	 * (DRAM controller) or Host1x bus for example.
+	 *
+	 * The voltage of a CORE SoC power domain shall not be dropped below
+	 * a minimum level, which is determined by device's clock rate.
+	 * This means that we can't fully allow CORE voltage scaling until
+	 * the state of all DVFS-critical CORE devices is synced.
+	 */
+	if (tegra_soc_dvfs_state_synced()) {
+		pr_info_once("voltage state synced\n");
+		return 0;
+	}
+
 	if (tegra->core_min_uV > 0)
 		return tegra->core_min_uV;
 
@@ -58,7 +75,7 @@ static int tegra20_core_limit(struct tegra_regulator_coupler *tegra,
 	 */
 	tegra->core_min_uV = core_max_uV;
 
-	pr_info("core minimum voltage limited to %duV\n", tegra->core_min_uV);
+	pr_info("core voltage initialized to %duV\n", tegra->core_min_uV);
 
 	return tegra->core_min_uV;
 }
diff --git a/drivers/soc/tegra/regulators-tegra30.c b/drivers/soc/tegra/regulators-tegra30.c
index 7f21f31de09d..f7a5260edffe 100644
--- a/drivers/soc/tegra/regulators-tegra30.c
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
+#include <soc/tegra/common.h>
 #include <soc/tegra/fuse.h>
 
 struct tegra_regulator_coupler {
@@ -39,6 +40,21 @@ static int tegra30_core_limit(struct tegra_regulator_coupler *tegra,
 	int core_cur_uV;
 	int err;
 
+	/*
+	 * Tegra30 SoC has critical DVFS-capable devices that are
+	 * permanently-active or active at a boot time, like EMC
+	 * (DRAM controller) or Host1x bus for example.
+	 *
+	 * The voltage of a CORE SoC power domain shall not be dropped below
+	 * a minimum level, which is determined by device's clock rate.
+	 * This means that we can't fully allow CORE voltage scaling until
+	 * the state of all DVFS-critical CORE devices is synced.
+	 */
+	if (tegra_soc_dvfs_state_synced()) {
+		pr_info_once("voltage state synced\n");
+		return 0;
+	}
+
 	if (tegra->core_min_uV > 0)
 		return tegra->core_min_uV;
 
@@ -59,7 +75,7 @@ static int tegra30_core_limit(struct tegra_regulator_coupler *tegra,
 	 */
 	tegra->core_min_uV = core_max_uV;
 
-	pr_info("core minimum voltage limited to %duV\n", tegra->core_min_uV);
+	pr_info("core voltage initialized to %duV\n", tegra->core_min_uV);
 
 	return tegra->core_min_uV;
 }
@@ -143,6 +159,10 @@ static int tegra30_voltage_update(struct tegra_regulator_coupler *tegra,
 	if (core_min_uV < 0)
 		return core_min_uV;
 
+	err = regulator_check_voltage(core_rdev, &core_min_uV, &core_max_uV);
+	if (err)
+		return err;
+
 	err = regulator_check_consumers(core_rdev, &core_min_uV, &core_max_uV,
 					PM_SUSPEND_ON);
 	if (err)
-- 
2.27.0

