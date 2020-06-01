Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0951EA376
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgFAMGY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 08:06:24 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19412 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgFAMGY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 08:06:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed4eee90000>; Mon, 01 Jun 2020 05:04:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Jun 2020 05:06:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 01 Jun 2020 05:06:23 -0700
Received: from [10.26.75.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jun
 2020 12:06:21 +0000
Subject: Re: [PATCH V4] pwm: tegra: dynamic clk freq configuration by PWM
 driver
To:     Sandipan Patra <spatra@nvidia.com>, <treding@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>
CC:     <bbasu@nvidia.com>, <ldewangan@nvidia.com>,
        <kyarlagadda@nvidia.com>, <linux-pwm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bf426520-4b95-093c-721e-cc3965b63aff@nvidia.com>
Date:   Mon, 1 Jun 2020 13:06:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591013097; bh=0btnqTmhPiPE7D30ZWO5vBR9veyjxzgzTVf7egc0MLg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eaqxpDi8MjsCfvXZW2VAVToMwC/QHAuIRlUZkmxX/xv4LChLqKVfgxs9BohE/rrJW
         aKWne3ONHYWgTxAAwC7ETfSxGsba/kBEaBhUwF8vcN8wbMK9NO+2JxcpG03ZAY1SVt
         HlHZGWhJyCFsm9ZkO9iDtg/JPHHMtRFMEwdWCWKyoATuDH3cdxV6BG4YnpPbWNCmnj
         Ut+pExqgmdYl3i6HV4DQb1wjw7RqgoEREw5eCbShNYVmkDyXMdIdyOGidi6vce5pXg
         jRnL5XiYjsC800FYVIlm+tvTqf/VqAVmZHZ/FqIkegz4yjEBVLBs1i8MFc9jxUD//9
         gTku3DYSHOPjw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 01/06/2020 06:20, Sandipan Patra wrote:
> Added support for dynamic clock freq configuration in pwm kernel driver.
> Earlier the pwm driver used to cache boot time clock rate by pwm clock
> parent during probe. Hence dynamically changing pwm frequency was not
> possible for all the possible ranges. With this change, dynamic calculati=
on
> is enabled and it is able to set the requested period from sysfs knob
> provided the value is supported by clock source.
>=20
> Changes mainly have 2 parts:
>   - T186 and later chips [1]
>   - T210 and prior chips [2]
>=20
> For [1] - Changes implemented to set pwm period dynamically and
>           also checks added to allow only if requested period(ns) is
>           below or equals to higher range.
>=20
> For [2] - Only checks if the requested period(ns) is below or equals
>           to higher range defined by max clock limit. The limitation
>           in T210 or prior chips are due to the reason of having only
>           one pwm-controller supporting multiple channels. But later
>           chips have multiple pwm controller instances each having
> 	  single channel support.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> PATCH V4:
> 1. Code comments fixes
>=20
> PATCH V3:
> 1. Return -EINVAL if requested period does not fall inside limit.
> 2. Store the new clock rate for further references.
> 3. Variable name change reverted.
> 4. Comments corrected and new comments are added.
>=20
> PATCH V2:
> 1. Maximum frequency calculation is moved to probe.
> 2. Added descriptions for PWM register bits and functional behavior
>    of the controller when new configuration is applied.
> 3. Setting period with possible value when supplied period is below limit=
.
> 4. Corrected the earlier code comment:
>    plus 1 instead of minus 1 during pwm calculation
>=20
>  drivers/pwm/pwm-tegra.c | 80 +++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 76 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index d26ed8f..1daf591 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -4,8 +4,36 @@
>   *
>   * Tegra pulse-width-modulation controller driver
>   *
> - * Copyright (c) 2010, NVIDIA Corporation.
> + * Copyright (c) 2010-2020, NVIDIA Corporation.
>   * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix=
.de>
> + *
> + * Overview of Tegra Pulse Width Modulator Register:
> + * 1. 13-bit: Frequency division (SCALE)
> + * 2. 8-bit : Pulse division (DUTY)
> + * 3. 1-bit : Enable bit
> + *
> + * The PWM clock frequency is divided by 256 before subdividing it based
> + * on the programmable frequency division value to generate the required
> + * frequency for PWM output. The maximum output frequency that can be
> + * achieved is (max rate of source clock) / 256.
> + * e.g. if source clock rate is 408 MHz, maximum output frequency can be=
:
> + * 408 MHz/256 =3D 1.6 MHz.
> + * This 1.6 MHz frequency can further be divided using SCALE value in PW=
M.
> + *
> + * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
> + * To achieve 100% duty cycle, program Bit [24] of this register to
> + * 1=E2=80=99b1. In which case the other bits [23:16] are set to don't c=
are.
> + *
> + * Limitations:
> + * -	When PWM is disabled, the output is driven to inactive.
> + * -	It does not allow the current PWM period to complete and
> + *	stops abruptly.
> + *
> + * -	If the register is reconfigured while PWM is running,
> + *	it does not complete the currently running period.
> + *
> + * -	If the user input duty is beyond acceptible limits,
> + *	-EINVAL is returned.
>   */
> =20
>  #include <linux/clk.h>
> @@ -41,6 +69,7 @@ struct tegra_pwm_chip {
>  	struct reset_control*rst;
> =20
>  	unsigned long clk_rate;
> +	unsigned long min_period_ns;
> =20
>  	void __iomem *regs;
> =20
> @@ -68,7 +97,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  {
>  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
>  	unsigned long long c =3D duty_ns, hz;
> -	unsigned long rate;
> +	unsigned long rate, required_clk_rate;
>  	u32 val =3D 0;
>  	int err;
> =20
> @@ -83,9 +112,47 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	val =3D (u32)c << PWM_DUTY_SHIFT;
> =20
>  	/*
> +	 *  min period =3D max clock limit >> PWM_DUTY_WIDTH
> +	 */
> +	if (period_ns < pc->min_period_ns)
> +		return -EINVAL;
> +
> +	/*
>  	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
>  	 * cycles at the PWM clock rate will take period_ns nanoseconds.
> +	 *
> +	 * num_channels: If single instance of PWM controller has multiple
> +	 * channels (e.g. Tegra210 or older) then it is not possible to
> +	 * configure separate clock rates to each of the channels, in such
> +	 * case the value stored during probe will be referred.
> +	 *
> +	 * If every PWM controller instance has one channel respectively, i.e.
> +	 * nums_channels =3D=3D 1 then only the clock rate can be modified
> +	 * dynamically (e.g. Tegra186 or Tegra194).
>  	 */
> +	if (pc->soc->num_channels =3D=3D 1) {
> +		/*
> +		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
> +		 * with the maximum possible rate that the controller can
> +		 * provide. Any further lower value can be derived by setting
> +		 * PFM bits[0:12].
> +		 *
> +		 * required_clk_rate is a reference rate for source clock and
> +		 * it is derived based on user requested period. By setting the
> +		 * source clock rate as required_clk_rate, PWM controller will
> +		 * be able to configure the requested period.
> +		 */
> +		required_clk_rate =3D
> +			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
> +
> +		err =3D clk_set_rate(pc->clk, required_clk_rate);
> +		if (err < 0)
> +			return -EINVAL;
> +
> +		/* Store the new rate for further references */
> +		pc->clk_rate =3D clk_get_rate(pc->clk);
> +	}
> +
>  	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> =20
>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> @@ -94,7 +161,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
> =20
>  	/*
>  	 * Since the actual PWM divider is the register's frequency divider
> -	 * field minus 1, we need to decrement to get the correct value to
> +	 * field plus 1, we need to decrement to get the correct value to
>  	 * write to the register.
>  	 */
>  	if (rate > 0)
> @@ -205,6 +272,10 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>  	 */
>  	pwm->clk_rate =3D clk_get_rate(pwm->clk);
> =20
> +	/* Set minimum limit of PWM period for the IP */
> +	pwm->min_period_ns =3D
> +	    (NSEC_PER_SEC / (pwm->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
> +
>  	pwm->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "pwm");
>  	if (IS_ERR(pwm->rst)) {
>  		ret =3D PTR_ERR(pwm->rst);
> @@ -312,5 +383,6 @@ static struct platform_driver tegra_pwm_driver =3D {
>  module_platform_driver(tegra_pwm_driver);
> =20
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("NVIDIA Corporation");
> +MODULE_AUTHOR("Sandipan Patra <spatra@nvidia.com>");
> +MODULE_DESCRIPTION("Tegra PWM controller driver");
>  MODULE_ALIAS("platform:tegra-pwm");
>

Thanks. LGTM.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

--=20
nvpublic
