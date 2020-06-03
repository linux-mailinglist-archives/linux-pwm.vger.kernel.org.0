Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A561ED45C
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgFCQ3T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Jun 2020 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFCQ3T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 12:29:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324CC08C5C0
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 09:29:19 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jgWGJ-0006lc-9a; Wed, 03 Jun 2020 18:29:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jgWGI-0003qv-Km; Wed, 03 Jun 2020 18:29:06 +0200
Date:   Wed, 3 Jun 2020 18:29:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com,
        ldewangan@nvidia.com, kyarlagadda@nvidia.com,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Message-ID: <20200603162906.vyfynqtxa7mpjxxv@taurus.defre.kleine-koenig.org>
References: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aolxn5mvfn62f3oc"
Content-Disposition: inline
In-Reply-To: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aolxn5mvfn62f3oc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 01, 2020 at 10:50:36AM +0530, Sandipan Patra wrote:
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
=2Ede>
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
> + * e.g. if source clock rate is 408 MHz, maximum output frequency can be:
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

I'd prefer to have no empty lines in the in Limitations paragraph to be
able to get all infos using something like:

	sed -rn '/\* Limitations:/,/^ \*\/?$/p' drivers/pwm/pwm-tegra.c

> + * -	If the register is reconfigured while PWM is running,
> + *	it does not complete the currently running period.
> + *
> + * -	If the user input duty is beyond acceptible limits,
> + *	-EINVAL is returned.

s/acceptible/acceptable/ (but in fact this isn't a limitation, so I'd
drop this here, as pointed out in v2).

In v2 I mentioned a few things to add here.

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

In v2 I requested to move this into the if block below. You replied to
want to move it accordingly.

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

It looks a bit strange that the algorithm to calculate the clock
settings depends on the number of channels. Looks like a wrong
abstraction.

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

I would have put this in a separate change.

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

To ensure that required_clk_rate in tegra_pwm_config doesn't get bigger
than pwm->soc->max_frequency this isn't the right formula I think. I'd
use

	pwm->min_period_ns =3D DIV_ROUNDUP(NSEC_PER_SEC, pwm->soc->max_frequency >=
> PWM_DUTY_WIDTH);

=2E Can you confirm?

Best regards
Uwe

--aolxn5mvfn62f3oc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7Xz88ACgkQwfwUeK3K
7AlrAAf/aYBSEFxW/wXZ2OQi20KmCo1gebNdYjqppcGWBHFcslo+Zy//4zemJatL
/zx40sFn60GynifMqDb3vGsgAtt3DCZsb9+MC3H8PQLXa70yaWeJ1n9oEapQ5UIk
tD5GGH8Pa/dBdM7cH5bWjcziQ1elZZXDV8q7X5G/IJF79hHvoDYTnSJbeO1RVxG6
XBopnHUquZladbAMRLK6mXUdiU1d0dRVcDCdMGqoypAkFbUNgVWXnVq6SpQqvice
m+BUzT7ekqJ/0vE54NRJeudBnGkjmkuGMuX14+GJJqbO0NZVKPyi5XREm+eqlzvq
1rD4TCb2n45vagAbws+IpFaRWueWkg==
=t6tJ
-----END PGP SIGNATURE-----

--aolxn5mvfn62f3oc--
