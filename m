Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D2F211C70
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jul 2020 09:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGBHLS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jul 2020 03:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGBHLR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2020 03:11:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86571C08C5DC
        for <linux-pwm@vger.kernel.org>; Thu,  2 Jul 2020 00:11:17 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jqtND-0004jV-Sp; Thu, 02 Jul 2020 09:11:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jqtNA-0001cL-7X; Thu, 02 Jul 2020 09:11:04 +0200
Date:   Thu, 2 Jul 2020 09:11:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v16 06/11] pwm: imx27: Use 64-bit division macro and
 function
Message-ID: <20200702071104.dbuwzqufezbmxwg7@pengutronix.de>
References: <cover.1591136989.git.gurus@codeaurora.org>
 <bb43ff8ad9e0b9884722d85e51c8fdb3ef4154d1.1591136989.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pmfaddvp5kr6odrc"
Content-Disposition: inline
In-Reply-To: <bb43ff8ad9e0b9884722d85e51c8fdb3ef4154d1.1591136989.git.gurus@codeaurora.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pmfaddvp5kr6odrc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 02, 2020 at 03:31:10PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_state.period's
> datatype to u64, prepare for this transition by using
> DIV_ROUND_UP_ULL to handle a 64-bit dividend, and div64_u64 to handle a
> 64-bit divisor.
>=20
> Also handle a possible overflow in the calculation of period_cycles when
> both clk_rate and period are large numbers. This logic was unit-tested
> out by calculating period_cycles using both the existing logic and the
> proposed one, and the results are as below.
>=20
> -------------------------------------------------------------------------=
---
>  clk_rate            period           existing            proposed
> -------------------------------------------------------------------------=
---
> 1000000000   18446744073709551615    18446744072    18446744073000000000
>                    (U64_MAX)
> -------------------------------------------------------------------------=
---
> 1000000000        4294967291         4294967291         4294967291
> -------------------------------------------------------------------------=
---
>=20
> Overflow occurs in the first case with the existing logic, whereas the
> proposed logic handles it better, sacrificing some precision in a best-ef=
fort
> attempt to handle overflow. As for the second case where there are
> more typical values of period, the proposed logic handles that correctly
> too.
>=20
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-imx27.c | 48 +++++++++++++++++++++++++++++++++++++++++++=
-----
>  1 file changed, 43 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 732a6f3..147729d 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -202,7 +202,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip =
*chip,
>  	sr =3D readl(imx->mmio_base + MX3_PWMSR);
>  	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
>  	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
> -		period_ms =3D DIV_ROUND_UP(pwm_get_period(pwm),
> +		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),
>  					 NSEC_PER_MSEC);
>  		msleep(period_ms);
> =20
> @@ -212,6 +212,45 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip=
 *chip,
>  	}
>  }
> =20
> +static int pwm_imx27_calc_period_cycles(const struct pwm_state *state,
> +					unsigned long clk_rate,
> +					unsigned long *period_cycles)
> +{
> +	u64 c =3D 0, c1, c2;
> +
> +	c1 =3D clk_rate;
> +	c2 =3D state->period;
> +	if (c2 > c1) {
> +		c2 =3D c1;
> +		c1 =3D state->period;
> +	}
> +
> +	if (!c1 || !c2) {
> +		pr_err("clk rate and period should be nonzero\n");
> +		return -EINVAL;
> +	}
> +
> +	if (c2 <=3D div64_u64(U64_MAX, c1)) {
> +		c =3D c1 * c2;
> +		do_div(c, 1000000000);
> +	} else if (c2 <=3D div64_u64(U64_MAX, div64_u64(c1, 1000))) {
> +		do_div(c1, 1000);
> +		c =3D c1 * c2;
> +		do_div(c, 1000000);
> +	} else if (c2 <=3D div64_u64(U64_MAX, div64_u64(c1, 1000000))) {
> +		do_div(c1, 1000000);
> +		c =3D c1 * c2;
> +		do_div(c, 1000);
> +	} else if (c2 <=3D div64_u64(U64_MAX, div64_u64(c1, 1000000000))) {
> +		do_div(c1, 1000000000);
> +		c =3D c1 * c2;

	} else {
		???

> +	}
> +
> +	*period_cycles =3D c;
> +
> +	return 0;
> +}
> +
>  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   const struct pwm_state *state)
>  {
> @@ -226,10 +265,9 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	pwm_get_state(pwm, &cstate);
> =20
>  	clkrate =3D clk_get_rate(imx->clk_per);
> -	c =3D clkrate * state->period;
> -
> -	do_div(c, NSEC_PER_SEC);
> -	period_cycles =3D c;
> +	ret =3D pwm_imx27_calc_period_cycles(state, clkrate, &period_cycles);
> +	if (ret)
> +		return ret;

I would expect this problem to be generic enough that it justifies a
function in pwm-core (or even more generic?).

Something like:

	/*
	 * calculates *result =3D a * b / c.
	 * Returns false on overflow (and doesn't assign result in this
	 * case); true otherwise.
	 */
	static inline bool multdiv(u64 *result, u64 a, u64 b, u64 c)

I'd split this out in a separate patch though? (Or is imx27 the only
driver in this series with this problem?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pmfaddvp5kr6odrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl79iIQACgkQwfwUeK3K
7AlGQQf/YBexFB1ai+pPDHrFQVavahBrGhIr3GofglYjZ6xWCEKJlD2hk9BnErnL
wPeMYoURilWKtGGtEKKG4W2O/wgp4iaDaVu0/dds2D2wGCWWHuh5OSOH7WIMhq7n
SpveSEEZsiF6bPcpW4oibeBey4Wbl8y2izDZxnAsvdGHozeDhe+M3tAz3TaHRdgF
4dp78bj8PYTPTBWjZbozOX9oLnK9c0gZyDHSfmzYqUk4LQcgQWePaahsQF27ND+5
xJPWn3v/DL1ldqthpqjhF0k/S4NLIhqpkb6bNNIe/rbDOgODdk8w5Ggf+qtK0lZX
Q54WH94G0Og4f4PGlDVbb5Ve9bCefw==
=jUZy
-----END PGP SIGNATURE-----

--pmfaddvp5kr6odrc--
