Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25D827A944
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1IEd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1IEc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 04:04:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27FC0613CE
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 01:04:32 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMo94-0004IN-Ow; Mon, 28 Sep 2020 10:04:26 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMo93-0002Ww-LL; Mon, 28 Sep 2020 10:04:25 +0200
Date:   Mon, 28 Sep 2020 10:04:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 5/5] pwm: imx27: wait till the duty cycle is applied
Message-ID: <20200928080425.ugyrgznw6o3kwdz5@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-6-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pz2wqxelfpmffj6v"
Content-Disposition: inline
In-Reply-To: <20200925155330.32301-6-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pz2wqxelfpmffj6v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 05:53:30PM +0200, Marco Felsch wrote:
> Currently the driver don't check if the new state was applied or not.

s/don't/doesn't/

> This can cause glitches on the output pin if the new state disables the
> PWM. In this case the PWM clocks are disabled before the new duty cycle
> value gets applied.

Hmm, the problem that is addressed here is that .apply() might turn off
the clock input for the counter before the inactive value is on the pin,
right? So an alternative fix would be to not disable the clock, wouldn't
it?

> The fix is to wait till the desired duty cycle was applied.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - new patch
>=20
>  drivers/pwm/pwm-imx27.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 07c6a263a39c..ffa00bcd81da 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -222,6 +222,26 @@ static int pwm_imx27_get_fifo_slot(struct pwm_chip *=
chip,
>  	return fifoav;
>  }
> =20
> +static int pwm_imx27_wait_till_applied(struct pwm_chip *chip,
> +				       struct pwm_device *pwm)
> +{
> +	unsigned int attempts =3D 4;
> +	unsigned int period_ms;
> +	int busy_slots;
> +
> +	do {
> +		busy_slots =3D pwm_imx27_get_fifo_slot(chip, pwm);
> +		if (busy_slots =3D=3D 0)
> +			return 0;
> +
> +		period_ms =3D DIV_ROUND_UP(pwm_get_period(pwm),

I was glad you removed the call to pwm_get_state() from .apply(), now it is
back in disguised form here :-\ Also the value shouldn't change over the
iteration of this loop, so determining it once should be enough.

> +					 NSEC_PER_MSEC);
> +		msleep(period_ms);
> +	} while (attempts--);
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   const struct pwm_state *state)
>  {
> @@ -277,6 +297,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>  	else
>  		writel(0, imx->mmio_base + MX3_PWMSAR);
> +
> +	ret =3D pwm_imx27_wait_till_applied(chip, pwm);
> +	if (ret)
> +		goto out;
> +

The framework doesn't define (and this is a problem there) if .apply is
supposed to sleep. OTOH at least sun4i has a similar behaviour.
Thierry, what is your thought on this?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pz2wqxelfpmffj6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9xmQYACgkQwfwUeK3K
7AkDxwf/ceYbRvImTg6DE6b5Llz4emSThQvLOmZyIcwIz5jHncFavGSvxHKuEogo
0WhIbR8vUjdGShE9gWPJ4kCD9raK0kswWqQKw6BZNXwuUc0EZhxM8QmpUpxq5yfJ
N+E/0qClSmO9qIQnyhvpMJRjpqq5YBT8fmpT4/lJyfnUYNiDLKBxvZ7bjQyvoSdI
iSNm1sYbXZfn9PCqZiggVOjrdIAdj35gnwP05THlIomGOfOnBia9CIQjOA3wQ+tV
a5ZpqbkDnmH1nZ1mhBudZ3C/qyi1CV+jgvZTrVAMTklpktbHac+nTkDDKhAuOcd6
zUcBrnWyRSnCvDEOUM/6MtGuSXI80g==
=QGCK
-----END PGP SIGNATURE-----

--pz2wqxelfpmffj6v--
