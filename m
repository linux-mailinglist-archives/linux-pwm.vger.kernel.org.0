Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363FD1E1A89
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 07:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgEZFGN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 01:06:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10483 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgEZFGN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 01:06:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecca36c0000>; Mon, 25 May 2020 22:04:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 May 2020 22:06:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 May 2020 22:06:12 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 05:06:12 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 26 May 2020 05:06:12 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ecca3c00000>; Mon, 25 May 2020 22:06:11 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>, <kamil@wypas.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>
CC:     <bbasu@nvidia.com>, <bbiswas@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove module support
Date:   Tue, 26 May 2020 10:36:04 +0530
Message-ID: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590469484; bh=YNG08g8NnR/+zB8mCjRyNEMkFDmY+YHQZPfszu7vlRU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=QJTlDTnceYS2J34I7iRMFfYK2CYe10VK6NMuTxJQZBoooYRyUKE12HKCU2sswxDCQ
         ifEpevlvL3eBaDVkiWbDEUE8LpyiINY4oX9JpJTnW/TIgdGR1TyA4cXnM0JU7p/1Tp
         Y2nYyLiEQ7GeGuoQ/YWP9T27luL6BB1xqiW5Ag0fgLj5VYwW1xnylRdhX1AIbzJt64
         7bQiubyFZ0+GW4TtA+fMoLSMqbjirsBlRYwh6FzExvVgenMo1IxalBu7e9uK6NQus6
         BqBL5dbWm2JenHevUxYitomVWMRuNnybwweUJRt+bmQk3x7NPOs6wCZ0hlD35GQGyw
         Beo3fsxLdc/ew==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This change has 2 parts:
1. Add support for profiles mode settings.
    This allows different fan settings for trip point temp/hyst/pwm.
    T194 has multiple fan-profiles support.

2. Add pwm-fan remove support. This is essential since the config is
    tristate capable.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 drivers/hwmon/pwm-fan.c | 112 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 30b7b3e..26db589 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -3,8 +3,10 @@
  * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2020, NVIDIA Corporation.
  *
  * Author: Kamil Debski <k.debski@samsung.com>
+ * Author: Sandipan Patra <spatra@nvidia.com>
  */
 
 #include <linux/hwmon.h>
@@ -21,6 +23,8 @@
 #include <linux/timer.h>
 
 #define MAX_PWM 255
+/* Based on OF max device tree node name length */
+#define MAX_PROFILE_NAME_LENGTH	31
 
 struct pwm_fan_ctx {
 	struct mutex lock;
@@ -38,6 +42,12 @@ struct pwm_fan_ctx {
 	unsigned int pwm_fan_state;
 	unsigned int pwm_fan_max_state;
 	unsigned int *pwm_fan_cooling_levels;
+
+	unsigned int pwm_fan_profiles;
+	const char **fan_profile_names;
+	unsigned int **fan_profile_cooling_levels;
+	unsigned int fan_current_profile;
+
 	struct thermal_cooling_device *cdev;
 };
 
@@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 				       struct pwm_fan_ctx *ctx)
 {
 	struct device_node *np = dev->of_node;
+	struct device_node *base_profile = NULL;
+	struct device_node *profile_np = NULL;
+	const char *default_profile = NULL;
 	int num, i, ret;
 
-	if (!of_find_property(np, "cooling-levels", NULL))
-		return 0;
+	num = of_property_count_u32_elems(np, "cooling-levels");
+	if (num <= 0) {
+		base_profile = of_get_child_by_name(np, "profiles");
+		if (!base_profile) {
+			dev_err(dev, "Wrong Data\n");
+			return -EINVAL;
+		}
+	}
+
+	if (base_profile) {
+		ctx->pwm_fan_profiles =
+			of_get_available_child_count(base_profile);
+
+		if (ctx->pwm_fan_profiles <= 0) {
+			dev_err(dev, "Profiles used but not defined\n");
+			return -EINVAL;
+		}
 
-	ret = of_property_count_u32_elems(np, "cooling-levels");
-	if (ret <= 0) {
-		dev_err(dev, "Wrong data!\n");
-		return ret ? : -EINVAL;
+		ctx->fan_profile_names = devm_kzalloc(dev,
+			sizeof(const char *) * ctx->pwm_fan_profiles,
+							GFP_KERNEL);
+		ctx->fan_profile_cooling_levels = devm_kzalloc(dev,
+			sizeof(int *) * ctx->pwm_fan_profiles,
+							GFP_KERNEL);
+
+		if (!ctx->fan_profile_names
+				|| !ctx->fan_profile_cooling_levels)
+			return -ENOMEM;
+
+		ctx->fan_current_profile = 0;
+		i = 0;
+		for_each_available_child_of_node(base_profile, profile_np) {
+			num = of_property_count_u32_elems(profile_np,
+							"cooling-levels");
+			if (num <= 0) {
+				dev_err(dev, "No data in cooling-levels inside profile node!\n");
+				return -EINVAL;
+			}
+
+			of_property_read_string(profile_np, "name",
+						&ctx->fan_profile_names[i]);
+			if (default_profile &&
+				!strncmp(default_profile,
+				ctx->fan_profile_names[i],
+				MAX_PROFILE_NAME_LENGTH))
+				ctx->fan_current_profile = i;
+
+			ctx->fan_profile_cooling_levels[i] =
+				devm_kzalloc(dev, sizeof(int) * num,
+							GFP_KERNEL);
+			if (!ctx->fan_profile_cooling_levels[i])
+				return -ENOMEM;
+
+			of_property_read_u32_array(profile_np, "cooling-levels",
+				ctx->fan_profile_cooling_levels[i], num);
+			i++;
+		}
 	}
 
-	num = ret;
 	ctx->pwm_fan_cooling_levels = devm_kcalloc(dev, num, sizeof(u32),
 						   GFP_KERNEL);
 	if (!ctx->pwm_fan_cooling_levels)
 		return -ENOMEM;
 
-	ret = of_property_read_u32_array(np, "cooling-levels",
-					 ctx->pwm_fan_cooling_levels, num);
-	if (ret) {
-		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
-		return ret;
+	if (base_profile) {
+		memcpy(ctx->pwm_fan_cooling_levels,
+		  ctx->fan_profile_cooling_levels[ctx->fan_current_profile],
+						num);
+	} else {
+		ret = of_property_read_u32_array(np, "cooling-levels",
+				ctx->pwm_fan_cooling_levels, num);
+		if (ret) {
+			dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
+			return -EINVAL;
+		}
 	}
 
 	for (i = 0; i < num; i++) {
@@ -390,6 +458,25 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int pwm_fan_remove(struct platform_device *pdev)
+{
+	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
+	struct pwm_args args;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_THERMAL))
+		thermal_cooling_device_unregister(ctx->cdev);
+
+	pwm_get_args(ctx->pwm, &args);
+	pwm_config(ctx->pwm, 0, args.period);
+	pwm_disable(ctx->pwm);
+
+	return 0;
+}
+
+
 static int pwm_fan_disable(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
@@ -465,6 +552,7 @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
 
 static struct platform_driver pwm_fan_driver = {
 	.probe		= pwm_fan_probe,
+	.remove         = pwm_fan_remove,
 	.shutdown	= pwm_fan_shutdown,
 	.driver	= {
 		.name		= "pwm-fan",
-- 
2.7.4

