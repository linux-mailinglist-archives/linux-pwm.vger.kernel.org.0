Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4478943A6E9
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhJYWsU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhJYWsQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B4C061745;
        Mon, 25 Oct 2021 15:45:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g36so15198863lfv.3;
        Mon, 25 Oct 2021 15:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nND07Ma4wigipu272DXl+wJcYpw45yQSr7vTYzCwXA0=;
        b=Cb4kZk1sBiNddHaqlx1Sc+CooBvwTvHUaoTq+Z5Zu+DjYAknpUbBdxg9z1v+8ScDzu
         fDYt3lSQrnMkCSeaaIaKBF4Ux1VnvgYGhBX44Mu2/eTxyp7L816SpBKaxiOZ+5MgQZmT
         mwXuMguVsUzwolD6tRYTm3XmLA6Y/PqLOWT/OsNGQoDntpZkP2Pp9PERmQBfgBNboa0P
         +Lx5JBYlTxj+J8t0QpUL4hdf3Ro6HfoJJ9rIXHV0uPUET1zRA4YYip99McZapPoK/Iq/
         lJAqC1w3/2qqNuGjpzyhFPFSVKEU64EcK904RTAzb7D48NPHryiGsodCpWXrulkQ7EQD
         6cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nND07Ma4wigipu272DXl+wJcYpw45yQSr7vTYzCwXA0=;
        b=AYjD711COM78xKYBFI9hRLo7dS9FG7B/c/2czX82q+k3fNzhcy8g91Jq27f8CKIIHS
         WP8uZb7MGQi6GRSDymHD9Nrh+tkX+eQq8PCg508Pc63JDpPFhkpynamu83i/UuW2+yUg
         LHavAjWDiSH0Rl93AzU7rFV+7N9ONyviZi0oZ7AAMZCz+6XtGCMtcbzwlSMYKju6fw6W
         Y/7LctuI6eoLnRx8ebqTVU9RbwxHwaeF3/uHP7R2noT6LrNB9rRFH7UhzKENWUAdAfuD
         H6XChF3bnj1i7XxPpvvWvjzYkf2xYc/7pErZEyBe3/1XsmJcyp/4CKG1IO/xNsZ0JlUE
         nZXQ==
X-Gm-Message-State: AOAM530B+cZupnmPMP+J6sQF8vEUBw732srWyNeTdPsQoosEB7a106vw
        xCIw1xf1VYW3fgo4VCKQP8DAAd6CbeM=
X-Google-Smtp-Source: ABdhPJzSyqVEmHirPR+OR930jz62xICDoTKi3vVUyrRNus6Z7sIS8bngCTkkSU/3L+kUhbluDuvxww==
X-Received: by 2002:ac2:4c04:: with SMTP id t4mr16511221lfq.525.1635201950892;
        Mon, 25 Oct 2021 15:45:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:50 -0700 (PDT)
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
Subject: [PATCH v14 05/39] clk: tegra: Support runtime PM and power domain
Date:   Tue, 26 Oct 2021 01:39:58 +0300
Message-Id: <20211025224032.21012-6-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Clock-and-Reset controller resides in a core power domain on NVIDIA
Tegra SoCs.  In order to support voltage scaling of the core power domain,
we hook up DVFS-capable clocks to the core GENPD for managing of the
GENPD's performance state based on the clock changes.

Some clocks don't have any specific physical hardware unit that backs
them, like root PLLs and system clock and they have theirs own voltage
requirements.  This patch adds new clk-device driver that backs the clocks
and provides runtime PM functionality for them.  A virtual clk-device is
created for each such DVFS-capable clock at the clock's registration time
by the new tegra_clk_register() helper.  Driver changes clock's device
GENPD performance state based on clk-rate notifications.

In result we have this sequence of events:

  1. Clock driver creates virtual device for selective clocks, enables
     runtime PM for the created device and registers the clock.
  2. Clk-device driver starts to listen to clock rate changes.
  3. Something changes clk rate or enables/disables clk.
  4. CCF core propagates the change through the clk tree.
  5. Clk-device driver gets clock rate-change notification or GENPD core
     handles prepare/unprepare of the clock.
  6. Clk-device driver changes GENPD performance state on clock rate
     change.
  7. GENPD driver changes voltage regulator state change.
  8. The regulator state is committed to hardware via I2C.

We rely on fact that DVFS is not needed for Tegra I2C and that Tegra I2C
driver already keeps clock always-prepared.  Hence I2C subsystem stays
independent from the clk power management and there are no deadlock spots
in the sequence.

Currently all clocks are registered very early during kernel boot when the
device driver core isn't available yet.  The clk-device can't be created
at that time.  This patch splits the registration of the clocks in two
phases:

  1. Register all essential clocks which don't use RPM and are needed
     during early boot.

  2. Register at a later boot time the rest of clocks.

This patch adds power management support for Tegra20 and Tegra30 clocks.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/Makefile      |   1 +
 drivers/clk/tegra/clk-device.c  | 199 ++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-pll.c     |   2 +-
 drivers/clk/tegra/clk-super.c   |   2 +-
 drivers/clk/tegra/clk-tegra20.c |  77 +++++++++---
 drivers/clk/tegra/clk-tegra30.c | 116 ++++++++++++++-----
 drivers/clk/tegra/clk.c         |  75 +++++++++++-
 drivers/clk/tegra/clk.h         |   2 +
 8 files changed, 420 insertions(+), 54 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-device.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index 7b1816856eb5..a0715cdfc1a4 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					+= clk.o
 obj-y					+= clk-audio-sync.o
+obj-y					+= clk-device.o
 obj-y					+= clk-dfll.o
 obj-y					+= clk-divider.o
 obj-y					+= clk-periph.o
diff --git a/drivers/clk/tegra/clk-device.c b/drivers/clk/tegra/clk-device.c
new file mode 100644
index 000000000000..c58beaf8afbc
--- /dev/null
+++ b/drivers/clk/tegra/clk-device.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include <soc/tegra/common.h>
+
+#include "clk.h"
+
+/*
+ * This driver manages performance state of the core power domain for the
+ * independent PLLs and system clocks.  We created a virtual clock device
+ * for such clocks, see tegra_clk_dev_register().
+ */
+
+struct tegra_clk_device {
+	struct notifier_block clk_nb;
+	struct device *dev;
+	struct clk_hw *hw;
+	struct mutex lock;
+};
+
+static int tegra_clock_set_pd_state(struct tegra_clk_device *clk_dev,
+				    unsigned long rate)
+{
+	struct device *dev = clk_dev->dev;
+	struct dev_pm_opp *opp;
+	unsigned int pstate;
+
+	opp = dev_pm_opp_find_freq_ceil(dev, &rate);
+	if (opp == ERR_PTR(-ERANGE)) {
+		/*
+		 * Some clocks may be unused by a particular board and they
+		 * may have uninitiated clock rate that is overly high.  In
+		 * this case clock is expected to be disabled, but still we
+		 * need to set up performance state of the power domain and
+		 * not error out clk initialization.  A typical example is
+		 * a PCIe clock on Android tablets.
+		 */
+		dev_dbg(dev, "failed to find ceil OPP for %luHz\n", rate);
+		opp = dev_pm_opp_find_freq_floor(dev, &rate);
+	}
+
+	if (IS_ERR(opp)) {
+		dev_err(dev, "failed to find OPP for %luHz: %pe\n", rate, opp);
+		return PTR_ERR(opp);
+	}
+
+	pstate = dev_pm_opp_get_required_pstate(opp, 0);
+	dev_pm_opp_put(opp);
+
+	return dev_pm_genpd_set_performance_state(dev, pstate);
+}
+
+static int tegra_clock_change_notify(struct notifier_block *nb,
+				     unsigned long msg, void *data)
+{
+	struct clk_notifier_data *cnd = data;
+	struct tegra_clk_device *clk_dev;
+	int err = 0;
+
+	clk_dev = container_of(nb, struct tegra_clk_device, clk_nb);
+
+	mutex_lock(&clk_dev->lock);
+	switch (msg) {
+	case PRE_RATE_CHANGE:
+		if (cnd->new_rate > cnd->old_rate)
+			err = tegra_clock_set_pd_state(clk_dev, cnd->new_rate);
+		break;
+
+	case ABORT_RATE_CHANGE:
+		err = tegra_clock_set_pd_state(clk_dev, cnd->old_rate);
+		break;
+
+	case POST_RATE_CHANGE:
+		if (cnd->new_rate < cnd->old_rate)
+			err = tegra_clock_set_pd_state(clk_dev, cnd->new_rate);
+		break;
+
+	default:
+		break;
+	}
+	mutex_unlock(&clk_dev->lock);
+
+	return notifier_from_errno(err);
+}
+
+static int tegra_clock_sync_pd_state(struct tegra_clk_device *clk_dev)
+{
+	unsigned long rate;
+	int ret;
+
+	mutex_lock(&clk_dev->lock);
+
+	rate = clk_hw_get_rate(clk_dev->hw);
+	ret = tegra_clock_set_pd_state(clk_dev, rate);
+
+	mutex_unlock(&clk_dev->lock);
+
+	return ret;
+}
+
+static int tegra_clock_probe(struct platform_device *pdev)
+{
+	struct tegra_core_opp_params opp_params = {};
+	struct tegra_clk_device *clk_dev;
+	struct device *dev = &pdev->dev;
+	struct clk *clk;
+	int err;
+
+	if (!dev->pm_domain)
+		return -EINVAL;
+
+	clk_dev = devm_kzalloc(dev, sizeof(*clk_dev), GFP_KERNEL);
+	if (!clk_dev)
+		return -ENOMEM;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	clk_dev->dev = dev;
+	clk_dev->hw = __clk_get_hw(clk);
+	clk_dev->clk_nb.notifier_call = tegra_clock_change_notify;
+	mutex_init(&clk_dev->lock);
+
+	platform_set_drvdata(pdev, clk_dev);
+
+	/*
+	 * Runtime PM was already enabled for this device by the parent clk
+	 * driver and power domain state should be synced under clk_dev lock,
+	 * hence we don't use the common OPP helper that initializes OPP
+	 * state. For some clocks common OPP helper may fail to find ceil
+	 * rate, it's handled by this driver.
+	 */
+	err = devm_tegra_core_dev_init_opp_table(dev, &opp_params);
+	if (err)
+		return err;
+
+	err = clk_notifier_register(clk, &clk_dev->clk_nb);
+	if (err) {
+		dev_err(dev, "failed to register clk notifier: %d\n", err);
+		return err;
+	}
+
+	/*
+	 * The driver is attaching to a potentially active/resumed clock, hence
+	 * we need to sync the power domain performance state in a accordance to
+	 * the clock rate if clock is resumed.
+	 */
+	err = tegra_clock_sync_pd_state(clk_dev);
+	if (err)
+		goto unreg_clk;
+
+	return 0;
+
+unreg_clk:
+	clk_notifier_unregister(clk, &clk_dev->clk_nb);
+
+	return err;
+}
+
+/*
+ * Tegra GENPD driver enables clocks during NOIRQ phase. It can't be done
+ * for clocks served by this driver because runtime PM is unavailable in
+ * NOIRQ phase. We will keep clocks resumed during suspend to mitigate this
+ * problem. In practice this makes no difference from a power management
+ * perspective since voltage is kept at a nominal level during suspend anyways.
+ */
+static const struct dev_pm_ops tegra_clock_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_resume_and_get, pm_runtime_put)
+};
+
+static const struct of_device_id tegra_clock_match[] = {
+	{ .compatible = "nvidia,tegra20-sclk" },
+	{ .compatible = "nvidia,tegra30-sclk" },
+	{ .compatible = "nvidia,tegra30-pllc" },
+	{ .compatible = "nvidia,tegra30-plle" },
+	{ .compatible = "nvidia,tegra30-pllm" },
+	{ }
+};
+
+static struct platform_driver tegra_clock_driver = {
+	.driver = {
+		.name = "tegra-clock",
+		.of_match_table = tegra_clock_match,
+		.pm = &tegra_clock_pm,
+		.suppress_bind_attrs = true,
+	},
+	.probe = tegra_clock_probe,
+};
+builtin_platform_driver(tegra_clock_driver);
diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index eaa079c177c3..100b5d9b7e26 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1914,7 +1914,7 @@ static struct clk *_tegra_clk_register_pll(struct tegra_clk_pll *pll,
 	/* Data in .init is copied by clk_register(), so stack variable OK */
 	pll->hw.init = &init;
 
-	return clk_register(NULL, &pll->hw);
+	return tegra_clk_dev_register(&pll->hw);
 }
 
 struct clk *tegra_clk_register_pll(const char *name, const char *parent_name,
diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index 6099c6e9acd4..a98a420398fa 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -226,7 +226,7 @@ struct clk *tegra_clk_register_super_mux(const char *name,
 	/* Data in .init is copied by clk_register(), so stack variable OK */
 	super->hw.init = &init;
 
-	clk = clk_register(NULL, &super->hw);
+	clk = tegra_clk_dev_register(&super->hw);
 	if (IS_ERR(clk))
 		kfree(super);
 
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 3664593a5ba4..be3c33441cfc 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -6,8 +6,11 @@
 #include <linux/io.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/clk/tegra.h>
 #include <linux/delay.h>
 #include <dt-bindings/clock/tegra20-car.h>
@@ -414,7 +417,7 @@ static struct tegra_clk_pll_params pll_e_params = {
 	.fixed_rate = 100000000,
 };
 
-static struct tegra_devclk devclks[] __initdata = {
+static struct tegra_devclk devclks[] = {
 	{ .con_id = "pll_c", .dt_id = TEGRA20_CLK_PLL_C },
 	{ .con_id = "pll_c_out1", .dt_id = TEGRA20_CLK_PLL_C_OUT1 },
 	{ .con_id = "pll_p", .dt_id = TEGRA20_CLK_PLL_P },
@@ -710,13 +713,6 @@ static void tegra20_super_clk_init(void)
 			      NULL);
 	clks[TEGRA20_CLK_CCLK] = clk;
 
-	/* SCLK */
-	clk = tegra_clk_register_super_mux("sclk", sclk_parents,
-			      ARRAY_SIZE(sclk_parents),
-			      CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
-			      clk_base + SCLK_BURST_POLICY, 0, 4, 0, 0, NULL);
-	clks[TEGRA20_CLK_SCLK] = clk;
-
 	/* twd */
 	clk = clk_register_fixed_factor(NULL, "twd", "cclk", 0, 1, 4);
 	clks[TEGRA20_CLK_TWD] = clk;
@@ -1014,7 +1010,7 @@ static struct tegra_cpu_car_ops tegra20_cpu_car_ops = {
 #endif
 };
 
-static struct tegra_clk_init_table init_table[] __initdata = {
+static struct tegra_clk_init_table init_table[] = {
 	{ TEGRA20_CLK_PLL_P, TEGRA20_CLK_CLK_MAX, 216000000, 1 },
 	{ TEGRA20_CLK_PLL_P_OUT1, TEGRA20_CLK_CLK_MAX, 28800000, 1 },
 	{ TEGRA20_CLK_PLL_P_OUT2, TEGRA20_CLK_CLK_MAX, 48000000, 1 },
@@ -1052,11 +1048,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
 };
 
-static void __init tegra20_clock_apply_init_table(void)
-{
-	tegra_init_from_table(init_table, clks, TEGRA20_CLK_CLK_MAX);
-}
-
 /*
  * Some clocks may be used by different drivers depending on the board
  * configuration.  List those here to register them twice in the clock lookup
@@ -1076,6 +1067,8 @@ static const struct of_device_id pmc_match[] __initconst = {
 	{ },
 };
 
+static bool tegra20_car_initialized;
+
 static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 					       void *data)
 {
@@ -1083,6 +1076,16 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 	struct clk_hw *hw;
 	struct clk *clk;
 
+	/*
+	 * Timer clocks are needed early, the rest of the clocks shouldn't be
+	 * available to device drivers until clock tree is fully initialized.
+	 */
+	if (clkspec->args[0] != TEGRA20_CLK_RTC &&
+	    clkspec->args[0] != TEGRA20_CLK_TWD &&
+	    clkspec->args[0] != TEGRA20_CLK_TIMER &&
+	    !tegra20_car_initialized)
+		return ERR_PTR(-EPROBE_DEFER);
+
 	clk = of_clk_src_onecell_get(clkspec, data);
 	if (IS_ERR(clk))
 		return clk;
@@ -1149,10 +1152,48 @@ static void __init tegra20_clock_init(struct device_node *np)
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA20_CLK_CLK_MAX);
 
 	tegra_add_of_provider(np, tegra20_clk_src_onecell_get);
-	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
-
-	tegra_clk_apply_init_table = tegra20_clock_apply_init_table;
 
 	tegra_cpu_car_ops = &tegra20_cpu_car_ops;
 }
-CLK_OF_DECLARE(tegra20, "nvidia,tegra20-car", tegra20_clock_init);
+CLK_OF_DECLARE_DRIVER(tegra20, "nvidia,tegra20-car", tegra20_clock_init);
+
+/*
+ * Clocks that use runtime PM can't be created at the tegra20_clock_init
+ * time because drivers' base isn't initialized yet, and thus platform
+ * devices can't be created for the clocks.  Hence we need to split the
+ * registration of the clocks into two phases.  The first phase registers
+ * essential clocks which don't require RPM and are actually used during
+ * early boot.  The second phase registers clocks which use RPM and this
+ * is done when device drivers' core API is ready.
+ */
+static int tegra20_car_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+
+	clk = tegra_clk_register_super_mux("sclk", sclk_parents,
+			      ARRAY_SIZE(sclk_parents),
+			      CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			      clk_base + SCLK_BURST_POLICY, 0, 4, 0, 0, NULL);
+	clks[TEGRA20_CLK_SCLK] = clk;
+
+	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
+	tegra_init_from_table(init_table, clks, TEGRA20_CLK_CLK_MAX);
+	tegra20_car_initialized = true;
+
+	return 0;
+}
+
+static const struct of_device_id tegra20_car_match[] = {
+	{ .compatible = "nvidia,tegra20-car" },
+	{ }
+};
+
+static struct platform_driver tegra20_car_driver = {
+	.driver = {
+		.name = "tegra20-car",
+		.of_match_table = tegra20_car_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = tegra20_car_probe,
+};
+builtin_platform_driver(tegra20_car_driver);
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 64121bc66d85..04b496123820 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -7,8 +7,11 @@
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/clk/tegra.h>
 
 #include <soc/tegra/pmc.h>
@@ -532,7 +535,7 @@ static unsigned long tegra30_input_freq[] = {
 	[12] = 26000000,
 };
 
-static struct tegra_devclk devclks[] __initdata = {
+static struct tegra_devclk devclks[] = {
 	{ .con_id = "pll_c", .dt_id = TEGRA30_CLK_PLL_C },
 	{ .con_id = "pll_c_out1", .dt_id = TEGRA30_CLK_PLL_C_OUT1 },
 	{ .con_id = "pll_p", .dt_id = TEGRA30_CLK_PLL_P },
@@ -812,11 +815,6 @@ static void __init tegra30_pll_init(void)
 {
 	struct clk *clk;
 
-	/* PLLC */
-	clk = tegra_clk_register_pll("pll_c", "pll_ref", clk_base, pmc_base, 0,
-				     &pll_c_params, NULL);
-	clks[TEGRA30_CLK_PLL_C] = clk;
-
 	/* PLLC_OUT1 */
 	clk = tegra_clk_register_divider("pll_c_out1_div", "pll_c",
 				clk_base + PLLC_OUT, 0, TEGRA_DIVIDER_ROUND_UP,
@@ -826,11 +824,6 @@ static void __init tegra30_pll_init(void)
 				0, NULL);
 	clks[TEGRA30_CLK_PLL_C_OUT1] = clk;
 
-	/* PLLM */
-	clk = tegra_clk_register_pll("pll_m", "pll_ref", clk_base, pmc_base,
-			    CLK_SET_RATE_GATE, &pll_m_params, NULL);
-	clks[TEGRA30_CLK_PLL_M] = clk;
-
 	/* PLLM_OUT1 */
 	clk = tegra_clk_register_divider("pll_m_out1_div", "pll_m",
 				clk_base + PLLM_OUT, 0, TEGRA_DIVIDER_ROUND_UP,
@@ -880,9 +873,6 @@ static void __init tegra30_pll_init(void)
 			       ARRAY_SIZE(pll_e_parents),
 			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + PLLE_AUX, 2, 1, 0, NULL);
-	clk = tegra_clk_register_plle("pll_e", "pll_e_mux", clk_base, pmc_base,
-			     CLK_GET_RATE_NOCACHE, &pll_e_params, NULL);
-	clks[TEGRA30_CLK_PLL_E] = clk;
 }
 
 static const char *cclk_g_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
@@ -971,14 +961,6 @@ static void __init tegra30_super_clk_init(void)
 			      NULL);
 	clks[TEGRA30_CLK_CCLK_LP] = clk;
 
-	/* SCLK */
-	clk = tegra_clk_register_super_mux("sclk", sclk_parents,
-				  ARRAY_SIZE(sclk_parents),
-				  CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
-				  clk_base + SCLK_BURST_POLICY,
-				  0, 4, 0, 0, NULL);
-	clks[TEGRA30_CLK_SCLK] = clk;
-
 	/* twd */
 	clk = clk_register_fixed_factor(NULL, "twd", "cclk_g",
 					CLK_SET_RATE_PARENT, 1, 2);
@@ -1214,7 +1196,7 @@ static struct tegra_cpu_car_ops tegra30_cpu_car_ops = {
 #endif
 };
 
-static struct tegra_clk_init_table init_table[] __initdata = {
+static struct tegra_clk_init_table init_table[] = {
 	{ TEGRA30_CLK_UARTA, TEGRA30_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA30_CLK_UARTB, TEGRA30_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA30_CLK_UARTC, TEGRA30_CLK_PLL_P, 408000000, 0 },
@@ -1259,11 +1241,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_CLK_MAX, TEGRA30_CLK_CLK_MAX, 0, 0 },
 };
 
-static void __init tegra30_clock_apply_init_table(void)
-{
-	tegra_init_from_table(init_table, clks, TEGRA30_CLK_CLK_MAX);
-}
-
 /*
  * Some clocks may be used by different drivers depending on the board
  * configuration.  List those here to register them twice in the clock lookup
@@ -1294,12 +1271,24 @@ static struct tegra_audio_clk_info tegra30_audio_plls[] = {
 	{ "pll_a", &pll_a_params, tegra_clk_pll_a, "pll_p_out1" },
 };
 
+static bool tegra30_car_initialized;
+
 static struct clk *tegra30_clk_src_onecell_get(struct of_phandle_args *clkspec,
 					       void *data)
 {
 	struct clk_hw *hw;
 	struct clk *clk;
 
+	/*
+	 * Timer clocks are needed early, the rest of the clocks shouldn't be
+	 * available to device drivers until clock tree is fully initialized.
+	 */
+	if (clkspec->args[0] != TEGRA30_CLK_RTC &&
+	    clkspec->args[0] != TEGRA30_CLK_TWD &&
+	    clkspec->args[0] != TEGRA30_CLK_TIMER &&
+	    !tegra30_car_initialized)
+		return ERR_PTR(-EPROBE_DEFER);
+
 	clk = of_clk_src_onecell_get(clkspec, data);
 	if (IS_ERR(clk))
 		return clk;
@@ -1357,10 +1346,75 @@ static void __init tegra30_clock_init(struct device_node *np)
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA30_CLK_CLK_MAX);
 
 	tegra_add_of_provider(np, tegra30_clk_src_onecell_get);
+
+	tegra_cpu_car_ops = &tegra30_cpu_car_ops;
+}
+CLK_OF_DECLARE_DRIVER(tegra30, "nvidia,tegra30-car", tegra30_clock_init);
+
+/*
+ * Clocks that use runtime PM can't be created at the tegra30_clock_init
+ * time because drivers' base isn't initialized yet, and thus platform
+ * devices can't be created for the clocks.  Hence we need to split the
+ * registration of the clocks into two phases.  The first phase registers
+ * essential clocks which don't require RPM and are actually used during
+ * early boot.  The second phase registers clocks which use RPM and this
+ * is done when device drivers' core API is ready.
+ */
+static int tegra30_car_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+
+	/* PLLC */
+	clk = tegra_clk_register_pll("pll_c", "pll_ref", clk_base, pmc_base, 0,
+				     &pll_c_params, NULL);
+	clks[TEGRA30_CLK_PLL_C] = clk;
+
+	/* PLLE */
+	clk = tegra_clk_register_plle("pll_e", "pll_e_mux", clk_base, pmc_base,
+				      CLK_GET_RATE_NOCACHE, &pll_e_params, NULL);
+	clks[TEGRA30_CLK_PLL_E] = clk;
+
+	/* PLLM */
+	clk = tegra_clk_register_pll("pll_m", "pll_ref", clk_base, pmc_base,
+				     CLK_SET_RATE_GATE, &pll_m_params, NULL);
+	clks[TEGRA30_CLK_PLL_M] = clk;
+
+	/* SCLK */
+	clk = tegra_clk_register_super_mux("sclk", sclk_parents,
+					   ARRAY_SIZE(sclk_parents),
+					   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+					   clk_base + SCLK_BURST_POLICY,
+					   0, 4, 0, 0, NULL);
+	clks[TEGRA30_CLK_SCLK] = clk;
+
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
+	tegra_init_from_table(init_table, clks, TEGRA30_CLK_CLK_MAX);
+	tegra30_car_initialized = true;
 
-	tegra_clk_apply_init_table = tegra30_clock_apply_init_table;
+	return 0;
+}
 
-	tegra_cpu_car_ops = &tegra30_cpu_car_ops;
+static const struct of_device_id tegra30_car_match[] = {
+	{ .compatible = "nvidia,tegra30-car" },
+	{ }
+};
+
+static struct platform_driver tegra30_car_driver = {
+	.driver = {
+		.name = "tegra30-car",
+		.of_match_table = tegra30_car_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = tegra30_car_probe,
+};
+
+/*
+ * Clock driver must be registered before memory controller driver,
+ * which doesn't support deferred probing for today and is registered
+ * from arch init-level.
+ */
+static int tegra30_car_init(void)
+{
+	return platform_driver_register(&tegra30_car_driver);
 }
-CLK_OF_DECLARE(tegra30, "nvidia,tegra30-car", tegra30_clock_init);
+postcore_initcall(tegra30_car_init);
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index f6cdce441cf7..26bda45813c0 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -9,14 +9,19 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/clk/tegra.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset-controller.h>
+#include <linux/string.h>
 
 #include <soc/tegra/fuse.h>
 
 #include "clk.h"
 
 /* Global data of Tegra CPU CAR ops */
+static struct device_node *tegra_car_np;
 static struct tegra_cpu_car_ops dummy_car_ops;
 struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
 
@@ -261,8 +266,8 @@ void __init tegra_init_dup_clks(struct tegra_clk_duplicate *dup_list,
 	}
 }
 
-void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
-				  struct clk *clks[], int clk_max)
+void tegra_init_from_table(struct tegra_clk_init_table *tbl,
+			   struct clk *clks[], int clk_max)
 {
 	struct clk *clk;
 
@@ -320,6 +325,8 @@ void __init tegra_add_of_provider(struct device_node *np,
 {
 	int i;
 
+	tegra_car_np = np;
+
 	for (i = 0; i < clk_num; i++) {
 		if (IS_ERR(clks[i])) {
 			pr_err
@@ -348,7 +355,7 @@ void __init tegra_init_special_resets(unsigned int num,
 	special_reset_deassert = deassert;
 }
 
-void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
+void tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
 {
 	int i;
 
@@ -372,6 +379,68 @@ struct clk ** __init tegra_lookup_dt_id(int clk_id,
 		return NULL;
 }
 
+static struct device_node *tegra_clk_get_of_node(struct clk_hw *hw)
+{
+	struct device_node *np;
+	char *node_name;
+
+	node_name = kstrdup(hw->init->name, GFP_KERNEL);
+	if (!node_name)
+		return NULL;
+
+	strreplace(node_name, '_', '-');
+
+	for_each_child_of_node(tegra_car_np, np) {
+		if (!strcmp(np->name, node_name))
+			break;
+	}
+
+	kfree(node_name);
+
+	return np;
+}
+
+struct clk *tegra_clk_dev_register(struct clk_hw *hw)
+{
+	struct platform_device *pdev, *parent;
+	const char *dev_name = NULL;
+	struct device *dev = NULL;
+	struct device_node *np;
+
+	np = tegra_clk_get_of_node(hw);
+
+	if (!of_device_is_available(np))
+		goto put_node;
+
+	dev_name = kasprintf(GFP_KERNEL, "tegra_clk_%s", hw->init->name);
+	if (!dev_name)
+		goto put_node;
+
+	parent = of_find_device_by_node(tegra_car_np);
+	if (parent) {
+		pdev = of_platform_device_create(np, dev_name, &parent->dev);
+		put_device(&parent->dev);
+
+		if (!pdev) {
+			pr_err("%s: failed to create device for %pOF\n",
+			       __func__, np);
+			goto free_name;
+		}
+
+		dev = &pdev->dev;
+		pm_runtime_enable(dev);
+	} else {
+		WARN(1, "failed to find device for %pOF\n", tegra_car_np);
+	}
+
+free_name:
+	kfree(dev_name);
+put_node:
+	of_node_put(np);
+
+	return clk_register(dev, hw);
+}
+
 tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
 
 static int __init tegra_clocks_apply_init_table(void)
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 0c3ba0ccce1a..5d80d8b79b8e 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -927,4 +927,6 @@ struct clk *tegra20_clk_register_emc(void __iomem *ioaddr, bool low_jitter);
 struct clk *tegra210_clk_register_emc(struct device_node *np,
 				      void __iomem *regs);
 
+struct clk *tegra_clk_dev_register(struct clk_hw *hw);
+
 #endif /* TEGRA_CLK_H */
-- 
2.33.1

