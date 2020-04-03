Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B5219D6C9
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgDCMfK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 08:35:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12476 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgDCMfK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 08:35:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e872d1a0000>; Fri, 03 Apr 2020 05:33:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Apr 2020 05:35:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Apr 2020 05:35:09 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Apr
 2020 12:35:08 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Apr 2020 12:35:09 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e872d7a0000>; Fri, 03 Apr 2020 05:35:08 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jonathanh@nvidia.com>
CC:     <bbasu@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Date:   Fri, 3 Apr 2020 18:05:03 +0530
Message-ID: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585917210; bh=SYS3vdECv0ZXlLBQF+6iQhj+wQ1YRaHGnboJxduGkVU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=TE2LwhOxmbiB5ep0DTE9I92w7enAAm+wO8gl3WQ6R5P9Nkb5JlEgEwniETwrlX1LM
         y2HiO9fs21duqc64qD+ctPOXdkMTVhXEamSe765g9z2cyYKzD7K3uKu/kDO7eEeQne
         dPaoe69ra/g6ViN0aEqmc5bGuU1SFgsNJ7wkDL/eyfwJbdsHBuKXI70HGDL2WL3y3A
         p+LVoN7mmdqsytVuQFJNgYWP18Sjzw4B3BYCuGwUi1WGHGAtVHuGEVSGT1yLaFFE/B
         /1AbJRw1m/o7KhkOXwVZrwCtbsfrAZEZa1FA9m1vGSPN51tRWDUX+EJVQwtJhZmcO7
         iEklmlEZ698qA==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Added support for dynamic clock freq configuration in pwm kernel driver.
Earlier the pwm driver used to cache boot time clock rate by pwm clock
parent during probe. Hence dynamically changing pwm frequency was not
possible for all the possible ranges. With this change, dynamic calculation
is enabled and it is able to set the requested period from sysfs knob
provided the value is supported by clock source.

Changes mainly have 2 parts:
  - T186 and later chips [1]
  - T210 and prior chips [2]

For [1] - Changes implemented to set pwm period dynamically and
          also checks added to allow only if requested period(ns) is
          below or equals to higher range.

For [2] - Only checks if the requested period(ns) is below or equals
          to higher range defined by max clock limit. The limitation
          in T210 or prior chips are due to the reason of having only
          one pwm-controller supporting multiple channels. But later
          chips have multiple pwm controller instances each having
	  single channel support.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index aa12fb3..d3ba33c 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -4,7 +4,7 @@
  *
  * Tegra pulse-width-modulation controller driver
  *
- * Copyright (c) 2010, NVIDIA Corporation.
+ * Copyright (c) 2010-2020, NVIDIA Corporation.
  * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
  */
 
@@ -83,10 +83,51 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (u32)c << PWM_DUTY_SHIFT;
 
 	/*
+	 * Its okay to ignore the fraction part since we will be trying to set
+	 * slightly lower value to rate than the actual required rate
+	 */
+	rate = NSEC_PER_SEC/period_ns;
+
+	/*
+	 *  Period in nano second has to be <= highest allowed period
+	 *  based on the max clock rate of the pwm controller.
+	 *
+	 *  higher limit = max clock limit >> PWM_DUTY_WIDTH
+	 */
+	if (rate > (pc->soc->max_frequency >> PWM_DUTY_WIDTH))
+		return -EINVAL;
+
+	/*
 	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
-	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
+	if (pc->soc->num_channels == 1) {
+		/*
+		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * with the hieghest applicable rate that the controller can
+		 * provide. Any further lower value can be derived by setting
+		 * PFM bits[0:12].
+		 * Higher mark is taken since BPMP has round-up mechanism
+		 * implemented.
+		 */
+		rate = rate << PWM_DUTY_WIDTH;
+
+		err = clk_set_rate(pc->clk, rate);
+		if (err < 0)
+			return -EINVAL;
+
+		rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
+	} else {
+		/*
+		 * This is the case for SoCs who support multiple channels:
+		 *
+		 * clk_set_rate() can not be called again in config because
+		 * T210 or any prior chip supports one pwm-controller and
+		 * multiple channels. Hence in this case cached clock rate
+		 * will be considered which was stored during probe.
+		 */
+		rate = pc->clk_rate >> PWM_DUTY_WIDTH;
+	}
 
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
 	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
-- 
2.7.4

