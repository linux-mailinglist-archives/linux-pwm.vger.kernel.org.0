Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4FE1B10C2
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2020 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgDTPxo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Apr 2020 11:53:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1696 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgDTPxn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Apr 2020 11:53:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9dc57a0000>; Mon, 20 Apr 2020 08:53:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 08:53:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Apr 2020 08:53:43 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 15:53:42 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Apr 2020 15:53:42 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9dc5830000>; Mon, 20 Apr 2020 08:53:42 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jonathanh@nvidia.com>
CC:     <bbasu@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH V2] pwm: tegra: dynamic clk freq configuration by PWM driver
Date:   Mon, 20 Apr 2020 21:24:03 +0530
Message-ID: <1587398043-18767-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587398010; bh=LLKrRYVhJgU3tNektpkMgC8uBrNsN2ZKgfywrWWlaUM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=oNeMaw4ZTGDsQtkdC+rSFivTVQOmu2K+YfqUWS16vGAsw40OT0GJCDVoX+/eo8ugb
         QqJGhjYwoTkZ/TV8wCcgov00k3JpCG+StZy/wAwedBodJCpNR5XUqYBhfDghyxzsrw
         WODvJkpGPdkr1rS3d423kOPHKsmre47bF7nuoPARX0lSBqhNoEYMjmQlKr9NOkiF1K
         qKm2CBU+xh4QRAxCPsD0wG7Iiuy886I1CZvQeW2p7bZIKeQrHnC7cQZCrXIm59RLTA
         uFgoeoI/cwMd7hGvlZq+lGHY0VFivD3ERI74ohmZI7AePHJaQyYkXAQkPhRn8EMeWG
         syo9Zqsjtb8Ag==
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
V2:
1. Min period_ns calculation is moved to probe.
2. Added descriptioins for PWM register bits and regarding behaviour
   of the controller when new configuration is applied or pwm is disabled.
3. Setting period with possible value when supplied period is below limit.
4. Corrected the earlier code comment:
   plus 1 instead of minus 1 during pwm calculation

 drivers/pwm/pwm-tegra.c | 110 +++++++++++++++++++++++++++++++++++++++++---=
----
 1 file changed, 94 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index d26ed8f..7a36325 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -4,8 +4,39 @@
  *
  * Tegra pulse-width-modulation controller driver
  *
- * Copyright (c) 2010, NVIDIA Corporation.
- * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.d=
e>
+ * Copyright (c) 2010-2020, NVIDIA Corporation.
+ *
+ * Overview of Tegra Pulse Width Modulator Register:
+ * 1. 13-bit: Frequency division (SCALE)
+ * 2. 8-bit : Puls division (DUTY)
+ * 3. 1-bit : Enable bit
+ *
+ * The PWM clock frequency is divided by 256 before subdividing it based
+ * on the programmable frequency division value to generate the required
+ * frequency for PWM output. The maximum output frequency that can be
+ * achieved is (max rate of source clock) / 256.
+ * i.e. if source clock rate is 408 MHz, maximum output frequency cab be:
+ * 408 MHz/256 =3D 1.6 MHz.
+ * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
+ *
+ * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
+ * To achieve 100% duty cycle, program Bit [24] of this register to
+ * 1=E2=80=99b1. In which case the other bits [23:16] are set to don't car=
e.
+ *
+ * Limitations and known facts:
+ * -	When PWM is disabled, the output is driven to 0.
+ * -	It does not allow the current PWM period to complete and
+ *	stops abruptly.
+ *
+ * -	If the register is reconfigured while pwm is running,
+ *	It does not let the currently running period to complete.
+ *
+ * -	Pulse width of the pwm can never be out of bound.
+ *	It's taken care at HW and SW
+ * -	If the user input duty is below limit, then driver sets it to
+ *	minimum possible value.
+ * -	If anything else goes wrong for setting duty or period,
+ *	-EINVAL is returned.
  */
=20
 #include <linux/clk.h>
@@ -41,6 +72,7 @@ struct tegra_pwm_chip {
 	struct reset_control*rst;
=20
 	unsigned long clk_rate;
+	unsigned long min_period_ns;
=20
 	void __iomem *regs;
=20
@@ -67,8 +99,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
-	unsigned long long c =3D duty_ns, hz;
-	unsigned long rate;
+	unsigned long long p_width =3D duty_ns, period_hz;
+	unsigned long rate, required_clk_rate;
+	unsigned long pfm; /* Frequency divider */
 	u32 val =3D 0;
 	int err;
=20
@@ -77,37 +110,77 @@ static int tegra_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c *=3D (1 << PWM_DUTY_WIDTH);
-	c =3D DIV_ROUND_CLOSEST_ULL(c, period_ns);
+	p_width *=3D (1 << PWM_DUTY_WIDTH);
+	p_width =3D DIV_ROUND_CLOSEST_ULL(p_width, period_ns);
=20
-	val =3D (u32)c << PWM_DUTY_SHIFT;
+	val =3D (u32)p_width << PWM_DUTY_SHIFT;
+
+	/*
+	 *  Period in nano second has to be <=3D highest allowed period
+	 *  based on max clock rate of the pwm controller.
+	 *
+	 *  higher limit =3D max clock limit >> PWM_DUTY_WIDTH
+	 *  lower limit =3D min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDTH
+	 */
+	if (period_ns < pc->min_period_ns) {
+		period_ns =3D pc->min_period_ns;
+		pr_warn("Period is adjusted to allowed value (%d ns)\n",
+				period_ns);
+	}
=20
 	/*
 	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
-	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
+	if (pc->soc->num_channels =3D=3D 1) {
+		/*
+		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * with the hieghest applicable rate that the controller can
+		 * provide. Any further lower value can be derived by setting
+		 * PFM bits[0:12].
+		 * Higher mark is taken since BPMP has round-up mechanism
+		 * implemented.
+		 */
+		required_clk_rate =3D
+			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
+
+		err =3D clk_set_rate(pc->clk, required_clk_rate);
+		if (err < 0)
+			return -EINVAL;
+
+		rate =3D clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
+	} else {
+		/*
+		 * This is the case for SoCs who support multiple channels:
+		 *
+		 * clk_set_rate() can not be called again in config because
+		 * T210 or any prior chip supports one pwm-controller and
+		 * multiple channels. Hence in this case cached clock rate
+		 * will be considered which was stored during probe.
+		 */
+		rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
+	}
=20
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
-	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
-	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
+	period_hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
+	pfm =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, period_hz);
=20
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
-	 * field minus 1, we need to decrement to get the correct value to
+	 * field plus 1, we need to decrement to get the correct value to
 	 * write to the register.
 	 */
-	if (rate > 0)
-		rate--;
+	if (pfm > 0)
+		pfm--;
=20
 	/*
-	 * Make sure that the rate will fit in the register's frequency
+	 * Make sure that pfm will fit in the register's frequency
 	 * divider field.
 	 */
-	if (rate >> PWM_SCALE_WIDTH)
+	if (pfm >> PWM_SCALE_WIDTH)
 		return -EINVAL;
=20
-	val |=3D rate << PWM_SCALE_SHIFT;
+	val |=3D pfm << PWM_SCALE_SHIFT;
=20
 	/*
 	 * If the PWM channel is disabled, make sure to turn on the clock
@@ -205,6 +278,10 @@ static int tegra_pwm_probe(struct platform_device *pde=
v)
 	 */
 	pwm->clk_rate =3D clk_get_rate(pwm->clk);
=20
+	/* Set minimum limit of PWM period for the IP */
+	pwm->min_period_ns =3D
+	    (NSEC_PER_SEC / (pwm->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+
 	pwm->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pwm->rst)) {
 		ret =3D PTR_ERR(pwm->rst);
@@ -313,4 +390,5 @@ module_platform_driver(tegra_pwm_driver);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("NVIDIA Corporation");
+MODULE_AUTHOR("Sandipan Patra <spatra@nvidia.com>");
 MODULE_ALIAS("platform:tegra-pwm");
--=20
2.7.4

