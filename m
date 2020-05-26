Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30B1E20DA
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgEZLZn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 07:25:43 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12782 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgEZLZm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 07:25:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eccfc5d0002>; Tue, 26 May 2020 04:24:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 04:25:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 May 2020 04:25:42 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 11:25:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 26 May 2020 11:25:42 +0000
Received: from sandipan-pc.nvidia.com (Not Verified[10.24.42.163]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eccfcb30000>; Tue, 26 May 2020 04:25:41 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>
CC:     <bbasu@nvidia.com>, <ldewangan@nvidia.com>,
        <kyarlagadda@nvidia.com>, <linux-pwm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH V3] pwm: tegra: dynamic clk freq configuration by PWM driver
Date:   Tue, 26 May 2020 16:55:35 +0530
Message-ID: <1590492335-25857-1-git-send-email-spatra@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590492253; bh=mTyV0NtNO6/CpCc0PNLoEi91+CZwIZPOQmNkyg6wDto=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=kCJBm57x4t5C7cdI4+08bu7koGK7JtWP8y1yIZp+gc1MyHjBQXtCkhwJQVpPj9Cxs
         /0QjNNbYy+OaftsY2aPnt0THolXDTF+xiGksS5hOncjSKovTfqJaABNGYYcjTv2Ah3
         wxltxpyIVFg6jUCVSpiayySobHlsABgWWKPBSu0iBvnTGb85skrCtliLeGRyk9WstS
         VoASw1l31fmnSGby2efPRQlsB0nxCtUJw07fCi7qMLIv34tTeBElwb39l5Lg7Fh+6w
         52ZsdrPYcUFm+0VyFrL8ge8UJPueBkuahtJOsisCpbYTmvjLj1XJReG/03QKMS5RDl
         Egu42f1Fm0DHA==
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

PATCH V3:
1. Return -EINVAL if requested period does not fall inside limit.
2. Store the new clock rate for further references.
3. Varible name change reverted.
4. Comments corrected and new comments are added.

 drivers/pwm/pwm-tegra.c | 85 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index d26ed8f..c6e5dcf 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -4,8 +4,35 @@
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
+ * e.g. if source clock rate is 408 MHz, maximum output frequency can be:
+ * 408 MHz/256 =3D 1.6 MHz.
+ * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
+ *
+ * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
+ * To achieve 100% duty cycle, program Bit [24] of this register to
+ * 1=E2=80=99b1. In which case the other bits [23:16] are set to don't car=
e.
+ *
+ * Limitations:
+ * -	When PWM is disabled, the output is driven to inactive.
+ * -	It does not allow the current PWM period to complete and
+ *	stops abruptly.
+ *
+ * -	If the register is reconfigured while PWM is running,
+ *	it does not complete the currently running period.
+ *
+ * -	If the user input duty is beyond acceptible limits,
+ *	-EINVAL is returned.
  */
=20
 #include <linux/clk.h>
@@ -41,6 +68,7 @@ struct tegra_pwm_chip {
 	struct reset_control*rst;
=20
 	unsigned long clk_rate;
+	unsigned long min_period_ns;
=20
 	void __iomem *regs;
=20
@@ -68,7 +96,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct=
 pwm_device *pwm,
 {
 	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
 	unsigned long long c =3D duty_ns, hz;
-	unsigned long rate;
+	unsigned long rate, required_clk_rate;
 	u32 val =3D 0;
 	int err;
=20
@@ -83,9 +111,51 @@ static int tegra_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 	val =3D (u32)c << PWM_DUTY_SHIFT;
=20
 	/*
+	 *  Period in nano second has to be <=3D highest allowed period
+	 *  based on max clock rate of the pwm controller.
+	 *
+	 *  higher limit =3D max clock limit >> PWM_DUTY_WIDTH
+	 *  lower limit =3D min clock limit >> PWM_DUTY_WIDTH >> PWM_SCALE_WIDTH
+	 */
+	if (period_ns < pc->min_period_ns)
+		return -EINVAL;
+
+	/*
 	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
+	 *
+	 * num_channels: If single instance of PWM controller has multiple
+	 * channels (e.g. Tegra210 or older) then it is not applicable to
+	 * configure separate clock rates to each of the channels, in such
+	 * case the value stored during probe will be referred.
+	 *
+	 * If every PWM controller instance has one channel respectively, i.e.
+	 * nums_channels =3D=3D 1 then only the clock rate can be modified
+	 * dynamically (e.g. Tegra186 or Tegra194).
 	 */
+	if (pc->soc->num_channels =3D=3D 1) {
+		/*
+		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * with the highest applicable rate that the controller can
+		 * provide. Any further lower value can be derived by setting
+		 * PFM bits[0:12].
+		 *
+		 * required_clk_rate is a reference rate for source clock and
+		 * it is derived based on user requested period. By setting the
+		 * source clock rate as required_clk_rate, PWM controller will
+		 * be able to configure the requested period.
+		 */
+		required_clk_rate =3D
+			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
+
+		err =3D clk_set_rate(pc->clk, required_clk_rate);
+		if (err < 0)
+			return -EINVAL;
+
+		/* Store the new rate for further references */
+		pc->clk_rate =3D clk_get_rate(pc->clk);
+	}
+
 	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
=20
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
@@ -94,7 +164,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struc=
t pwm_device *pwm,
=20
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
-	 * field minus 1, we need to decrement to get the correct value to
+	 * field plus 1, we need to decrement to get the correct value to
 	 * write to the register.
 	 */
 	if (rate > 0)
@@ -205,6 +275,10 @@ static int tegra_pwm_probe(struct platform_device *pde=
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
@@ -312,5 +386,6 @@ static struct platform_driver tegra_pwm_driver =3D {
 module_platform_driver(tegra_pwm_driver);
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("NVIDIA Corporation");
+MODULE_AUTHOR("Sandipan Patra <spatra@nvidia.com>");
+MODULE_DESCRIPTION("Tegra PWM controller driver");
 MODULE_ALIAS("platform:tegra-pwm");
--=20
2.7.4

