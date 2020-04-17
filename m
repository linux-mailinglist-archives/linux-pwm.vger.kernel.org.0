Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFB1ADE60
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Apr 2020 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgDQNcm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Apr 2020 09:32:42 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2466 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgDQNcm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Apr 2020 09:32:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e99af8a0000>; Fri, 17 Apr 2020 06:30:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 06:32:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 17 Apr 2020 06:32:41 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 13:32:41 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 13:32:41 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e99aff60002>; Fri, 17 Apr 2020 06:32:40 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jonathanh@nvidia.com>
CC:     <bbasu@nvidia.com>, <bbiswas@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 2/2] hwmon: pwm-fan: Add profile support and add remove module support
Date:   Fri, 17 Apr 2020 19:02:42 +0530
Message-ID: <1587130362-6149-2-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
References: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587130250; bh=sUsMPeOzmFx7PoX+RIgn634kmx6Ja5Z/eOIJTdL8m/4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=knXCgGMMCkrV4e9fKztshyDoP3Its64oMhQJwesBlbdackx+dXY5JKhXTaGZS4WHJ
         pfoJegCIqy2gTXG6VcCrwnfyw/GDk8pb8uJbrz4zw2XBf4eREhmhyDDQEiqnjhHvcj
         URHhrzCzVQM24MCah6z1MU62qbrqtposyIqnN3+MKyRwEcbGY/i3uP/U2x7wShqPou
         9ON5kDxiDWUH7gfnvis7NZ1okOcXfVB4NOZahtxJKOtrd0GUWtlrM7Y6sJBS/EBGaS
         +gdMLWZsIIZC5UzYkfEWudc7EEXl9WrkEh4GK+DObLmtJ94tT0jv5ZHmwo3BbXDIBM
         RTy5EkxvHXJHg==
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
 drivers/hwmon/pwm-fan.c | 113 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 30b7b3e..6332ed8 100644
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
@@ -476,6 +564,7 @@ static struct platform_driver pwm_fan_driver = {
 module_platform_driver(pwm_fan_driver);
 
 MODULE_AUTHOR("Kamil Debski <k.debski@samsung.com>");
+MODULE_AUTHOR("Sandipan Patra <spatra@nvidia.com>");
 MODULE_ALIAS("platform:pwm-fan");
 MODULE_DESCRIPTION("PWM FAN driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

