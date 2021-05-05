Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF937349B
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 07:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhEEFQ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 01:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhEEFQz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 May 2021 01:16:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3343C061574
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 22:15:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1le9sx-0004ZY-69; Wed, 05 May 2021 07:15:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1le9su-0003wj-88; Wed, 05 May 2021 07:15:44 +0200
Date:   Wed, 5 May 2021 07:15:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20210505051534.id36dvocqfqg3jqc@pengutronix.de>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfct2nxju7gee3fc"
Content-Disposition: inline
In-Reply-To: <20201021201224.3430546-3-bjorn.andersson@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nfct2nxju7gee3fc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Wed, Oct 21, 2020 at 01:12:22PM -0700, Bjorn Andersson wrote:
> +static const unsigned int lpg_clk_table[NUM_PWM_PREDIV][NUM_PWM_CLK] =3D=
 {
> +	{
> +		1 * (NSEC_PER_SEC / 1024),
> +		1 * (NSEC_PER_SEC / 32768),
> +		1 * (NSEC_PER_SEC / 19200000),
> +	},
> +	{
> +		3 * (NSEC_PER_SEC / 1024),
> +		3 * (NSEC_PER_SEC / 32768),

1000000000 / 32768 is 30517.578125. Because of the parenthesis this is
truncated to 30517. Multiplied by 3 this results in 91551. The exact
result is 91552.734375 however.

> +		3 * (NSEC_PER_SEC / 19200000),
> +	},
> +	{
> +		5 * (NSEC_PER_SEC / 1024),
> +		5 * (NSEC_PER_SEC / 32768),
> +		5 * (NSEC_PER_SEC / 19200000),
> +	},
> +	{
> +		6 * (NSEC_PER_SEC / 1024),
> +		6 * (NSEC_PER_SEC / 32768),
> +		6 * (NSEC_PER_SEC / 19200000),
> +	},
> +};
> +
> +/*
> + * PWM Frequency =3D Clock Frequency / (N * T)
> + *      or
> + * PWM Period =3D Clock Period * (N * T)
> + *      where
> + * N =3D 2^9 or 2^6 for 9-bit or 6-bit PWM size
> + * T =3D Pre-divide * 2^m, where m =3D 0..7 (exponent)
> + *
> + * This is the formula to figure out m for the best pre-divide and clock:
> + * (PWM Period / N) =3D (Pre-divide * Clock Period) * 2^m
> + */
> +static void lpg_calc_freq(struct lpg_channel *chan, unsigned int period_=
us)
> +{
> +	int             n, m, clk, div;
> +	int             best_m, best_div, best_clk;
> +	unsigned int    last_err, cur_err, min_err;
> +	unsigned int    tmp_p, period_n;
> +
> +	if (period_us =3D=3D chan->period_us)
> +		return;
> +
> +	/* PWM Period / N */
> +	if (period_us < UINT_MAX / NSEC_PER_USEC)
> +		n =3D 6;
> +	else
> +		n =3D 9;
> +
> +	period_n =3D ((u64)period_us * NSEC_PER_USEC) >> n;
> +
> +	min_err =3D UINT_MAX;
> +	last_err =3D UINT_MAX;
> +	best_m =3D 0;
> +	best_clk =3D 0;
> +	best_div =3D 0;
> +	for (clk =3D 0; clk < NUM_PWM_CLK; clk++) {
> +		for (div =3D 0; div < NUM_PWM_PREDIV; div++) {
> +			/* period_n =3D (PWM Period / N) */
> +			/* tmp_p =3D (Pre-divide * Clock Period) * 2^m */
> +			tmp_p =3D lpg_clk_table[div][clk];
> +			for (m =3D 0; m <=3D NUM_EXP; m++) {
> +				cur_err =3D abs(period_n - tmp_p);
> +				if (cur_err < min_err) {
> +					min_err =3D cur_err;
> +					best_m =3D m;
> +					best_clk =3D clk;
> +					best_div =3D div;
> +				}
> +
> +				if (m && cur_err > last_err)
> +					/* Break for bigger cur_err */
> +					break;
> +
> +				last_err =3D cur_err;
> +				tmp_p <<=3D 1;

This is inexact. Consider again the case where tmp_p is
3 * (NSEC_PER_SEC / 32768). The values you use and the exact values are:

	m     |       0        |      1       |      2      |      3     | ... |  =
      7 |
	tmp_p |   91551        | 183102       | 366204      | 732408     |     | 1=
1718528 |
        actual|   91552.734375 | 183105.46875 | 366210.9375 | 732421.875 | =
=2E.. | 11718750 |

So while you save some cycles by precalculating the values in
lpg_clk_table, you trade that for lost precision.

> +			}
> +		}
> +	}

Please don't pick a period that is longer than the requested period (for
the PWM functionality that is).

This can be simplified, you can at least calculate the optimal m
directly.

> +	/* Use higher resolution */
> +	if (best_m >=3D 3 && n =3D=3D 6) {
> +		n +=3D 3;
> +		best_m -=3D 3;
> +	}
> +
> +	chan->clk =3D best_clk;
> +	chan->pre_div =3D best_div;
> +	chan->pre_div_exp =3D best_m;
> +	chan->pwm_size =3D n;
> +
> +	chan->period_us =3D period_us;
> +}
> +
> +static void lpg_calc_duty(struct lpg_channel *chan, unsigned int duty_us)
> +{
> +	unsigned int max =3D (1 << chan->pwm_size) - 1;
> +	unsigned int val =3D div_u64((u64)duty_us << chan->pwm_size, chan->peri=
od_us);

Please use the actually implemented period here instead of the
requested. This improves precision, see commit
8035e6c66a5e98f098edf7441667de74affb4e78 for a similar case.

> +
> +	chan->pwm_value =3D min(val, max);
> +}
> +
> [...]
> +static const struct pwm_ops lpg_pwm_ops =3D {
> +	.request =3D lpg_pwm_request,
> +	.apply =3D lpg_pwm_apply,

Can you please test your driver with PWM_DEBUG enabled? The first thing
this will critizise is that there is no .get_state callback.

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int lpg_add_pwm(struct lpg *lpg)
> +{
> +	int ret;
> +
> +	lpg->pwm.base =3D -1;

Please drop this assignment.

> +	lpg->pwm.dev =3D lpg->dev;
> +	lpg->pwm.npwm =3D lpg->num_channels;
> +	lpg->pwm.ops =3D &lpg_pwm_ops;
> +
> +	ret =3D pwmchip_add(&lpg->pwm);
> +	if (ret)
> +		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
> +
> +	return ret;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nfct2nxju7gee3fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCSKfEACgkQwfwUeK3K
7Al9ygf/bU/6B7Ntl8/pP+mK0TPaycVdEj9/DxGD52Qhkz+3aBZrPcmrVjdlOzs3
LmxWiAw2CY8fFdodxvV6LeYSDkaKqwriMsyX/vnmAzQ8eURXHJ66zFjhB/f9bhKm
oPxXJ1N8VCfRrlNfRvezu3E3pkowR1yx+BTUS2jKZ8ls+bu/C+Fsg9W9fSOpehYQ
n/MIaJG7kEsyNPpzMYYyfaY3ztTdm6h16jxW5JhLGPIbVd/t67EvkEVs50ytE1vS
BNF40fgnzWje5zjlS/QpuTN3sayw02ffhrmk3Xv/MJ2ChLwPU5nhpgkTDZmL3hzz
Gwy4Q9ptZ1iTIKZXvUOx+JWZMBc96w==
=bwV7
-----END PGP SIGNATURE-----

--nfct2nxju7gee3fc--
