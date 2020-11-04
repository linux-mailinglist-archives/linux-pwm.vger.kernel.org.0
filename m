Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDA2A72C3
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgKDXtA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733100AbgKDXpL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:11 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841EAC0613CF;
        Wed,  4 Nov 2020 15:45:11 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id b1so135117lfp.11;
        Wed, 04 Nov 2020 15:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2xq+lt/r2Mvqw9qSWZAnUmoqhbrNvrI4eJy0ZnOQ64=;
        b=Fy4CNvg3obv1cUoJtvGJ21pgRv1s2vfQZ+17zG35XkFJhQGYivEOExVUbw2fEdaRGa
         ++APIIMcHAGfK/1E9UJY24YPYHy4O2A9bQts/vv5m93fdQ9Ty43C78419zh7Bf2Vk6r9
         eWJVZOlxAkZ9v7Ov0+UUojl1qFdIk+/oVtB43e+1brDo2GrOzQvvt5/leRClxlavjH+s
         AAp/ILGa8GQVEJSYwfOTryVzVXbkOSIpE9V4g+GcD0T8TD4yXfHl7kDjwklc+guJZO9G
         DEJIhAku8uEOKHuOLL0c0EpROBzWbTmnQkPSAJLtnb3obN2xwV8jKIKLXEQEzpvfiJ70
         cqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2xq+lt/r2Mvqw9qSWZAnUmoqhbrNvrI4eJy0ZnOQ64=;
        b=d952vZdnxbRQLFKsTzD3DeSuo1xhTZy9gJZdK3OibRSILvGexbP+MU+T+OD5Vng+Ry
         c9iu1CGkvDiGdmf9UVzCeGN15JHLNDR3I8fWQlhw/wrlAJm5+MypxfSXE8385nfOGl6H
         B3HOmcprZjIshfwRskfZ7cFas7ctuotTw5zlFtSBjdZSSsV9Deeumit2qgavuDcEy6B2
         XuNZEujQ1lh9cc30x7oWWMvMiglgKkiV9ceo8Jumv0BdpwzI1IUfdvXkwicKb6Fc+9uj
         j/fRmXivwHN0W2n6aU/X1IqBOhZVjStfgvQBb6QuGPw9pFG3RFJdtcz69ACqIiqBo9Yv
         z1sA==
X-Gm-Message-State: AOAM530Xr3YAPbomxR43P0oep++3IRsmYBA39SApzlNV5HjS5B08u72a
        38vIYwrMpjWf6EiqGbkovVw=
X-Google-Smtp-Source: ABdhPJwqoSMi1rb7vw1Ft82ab6MuGmnvmcXXmGI4LnfUQssU2WJfQ903eLKfiwjg+DKW6GcnoqGrow==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr52539lfu.220.1604533509991;
        Wed, 04 Nov 2020 15:45:09 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:45:09 -0800 (PST)
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
Subject: [PATCH v1 10/30] regulator: Allow skipping disabled regulators in regulator_check_consumers()
Date:   Thu,  5 Nov 2020 02:44:07 +0300
Message-Id: <20201104234427.26477-11-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add option which allows regulator_check_consumers() to skip accounting of
a disabled consumer regulators.

This new option is needed for the NVIDIA Tegra voltage couplers in order
to properly calculate a lowest possible voltage for the CORE regulator.
The requirements of a disabled consumer regulators should not be accounted
by the Tegra voltage balancers because disabled state means that hardware
is inactive. In particular disabled state shouldn't be accounted for the
consumers which belong to the CORE voltage domain, meanwhile CPU domain
should continue to account the disabled state.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c                       | 12 ++++++++----
 drivers/soc/samsung/exynos-regulator-coupler.c |  2 +-
 drivers/soc/tegra/regulators-tegra20.c         |  6 +++---
 drivers/soc/tegra/regulators-tegra30.c         |  6 +++---
 include/linux/regulator/coupler.h              |  6 ++++--
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f258ded39ce0..015dcd8408d9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -462,7 +462,8 @@ static int regulator_check_states(suspend_state_t state)
  */
 int regulator_check_consumers(struct regulator_dev *rdev,
 			      int *min_uV, int *max_uV,
-			      suspend_state_t state)
+			      suspend_state_t state,
+			      bool skip_disabled_regulators)
 {
 	struct regulator *regulator;
 	struct regulator_voltage *voltage;
@@ -476,6 +477,9 @@ int regulator_check_consumers(struct regulator_dev *rdev,
 		if (!voltage->min_uV && !voltage->max_uV)
 			continue;
 
+		if (skip_disabled_regulators && !regulator->enable_count)
+			continue;
+
 		if (*max_uV > voltage->max_uV)
 			*max_uV = voltage->max_uV;
 		if (*min_uV < voltage->min_uV)
@@ -3662,7 +3666,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 
 		ret = regulator_check_consumers(rdev,
 						&desired_min_uV,
-						&desired_max_uV, state);
+						&desired_max_uV, state, false);
 		if (ret < 0)
 			return ret;
 
@@ -3681,7 +3685,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 
 		ret = regulator_check_consumers(c_rdevs[i],
 						&tmp_min,
-						&tmp_max, state);
+						&tmp_max, state, false);
 		if (ret < 0)
 			return ret;
 
@@ -4119,7 +4123,7 @@ int regulator_sync_voltage(struct regulator *regulator)
 	if (ret < 0)
 		goto out;
 
-	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, 0);
+	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, 0, false);
 	if (ret < 0)
 		goto out;
 
diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
index 61a156b44a48..9bd99a93e3e0 100644
--- a/drivers/soc/samsung/exynos-regulator-coupler.c
+++ b/drivers/soc/samsung/exynos-regulator-coupler.c
@@ -41,7 +41,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 
 		ret = regulator_check_consumers(c_rdevs[i],
 						&tmp_min,
-						&tmp_max, state);
+						&tmp_max, state, false);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/soc/tegra/regulators-tegra20.c b/drivers/soc/tegra/regulators-tegra20.c
index 8782e399a58c..8c31acb5fdc6 100644
--- a/drivers/soc/tegra/regulators-tegra20.c
+++ b/drivers/soc/tegra/regulators-tegra20.c
@@ -136,7 +136,7 @@ static int tegra20_core_rtc_update(struct tegra_regulator_coupler *tegra,
 		return err;
 
 	err = regulator_check_consumers(core_rdev, &core_min_uV, &core_max_uV,
-					PM_SUSPEND_ON);
+					PM_SUSPEND_ON, true);
 	if (err)
 		return err;
 
@@ -246,12 +246,12 @@ static int tegra20_cpu_voltage_update(struct tegra_regulator_coupler *tegra,
 		return err;
 
 	err = regulator_check_consumers(cpu_rdev, &cpu_min_uV, &cpu_max_uV,
-					PM_SUSPEND_ON);
+					PM_SUSPEND_ON, false);
 	if (err)
 		return err;
 
 	err = regulator_check_consumers(cpu_rdev, &cpu_min_uV_consumers,
-					&cpu_max_uV, PM_SUSPEND_ON);
+					&cpu_max_uV, PM_SUSPEND_ON, false);
 	if (err)
 		return err;
 
diff --git a/drivers/soc/tegra/regulators-tegra30.c b/drivers/soc/tegra/regulators-tegra30.c
index fcf824f73131..d92aafa736bc 100644
--- a/drivers/soc/tegra/regulators-tegra30.c
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -164,7 +164,7 @@ static int tegra30_voltage_update(struct tegra_regulator_coupler *tegra,
 		return err;
 
 	err = regulator_check_consumers(core_rdev, &core_min_uV, &core_max_uV,
-					PM_SUSPEND_ON);
+					PM_SUSPEND_ON, true);
 	if (err)
 		return err;
 
@@ -175,12 +175,12 @@ static int tegra30_voltage_update(struct tegra_regulator_coupler *tegra,
 	cpu_min_uV = core_min_uV - max_spread;
 
 	err = regulator_check_consumers(cpu_rdev, &cpu_min_uV, &cpu_max_uV,
-					PM_SUSPEND_ON);
+					PM_SUSPEND_ON, false);
 	if (err)
 		return err;
 
 	err = regulator_check_consumers(cpu_rdev, &cpu_min_uV_consumers,
-					&cpu_max_uV, PM_SUSPEND_ON);
+					&cpu_max_uV, PM_SUSPEND_ON, false);
 	if (err)
 		return err;
 
diff --git a/include/linux/regulator/coupler.h b/include/linux/regulator/coupler.h
index 5f86824bd117..4e076567b823 100644
--- a/include/linux/regulator/coupler.h
+++ b/include/linux/regulator/coupler.h
@@ -55,7 +55,8 @@ int regulator_coupler_register(struct regulator_coupler *coupler);
 const char *rdev_get_name(struct regulator_dev *rdev);
 int regulator_check_consumers(struct regulator_dev *rdev,
 			      int *min_uV, int *max_uV,
-			      suspend_state_t state);
+			      suspend_state_t state,
+			      bool skip_disabled_regulators);
 int regulator_check_voltage(struct regulator_dev *rdev,
 			    int *min_uV, int *max_uV);
 int regulator_get_voltage_rdev(struct regulator_dev *rdev);
@@ -75,7 +76,8 @@ static inline const char *rdev_get_name(struct regulator_dev *rdev)
 }
 static inline int regulator_check_consumers(struct regulator_dev *rdev,
 					    int *min_uV, int *max_uV,
-					    suspend_state_t state)
+					    suspend_state_t state,
+					    bool skip_disabled_regulators))
 {
 	return -EINVAL;
 }
-- 
2.27.0

