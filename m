Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5408B27A8FA
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI1Hro (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgI1Hro (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 03:47:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9CCC0613CE
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 00:47:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMnso-0002e8-7T; Mon, 28 Sep 2020 09:47:38 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMnsm-0000qr-LI; Mon, 28 Sep 2020 09:47:36 +0200
Date:   Mon, 28 Sep 2020 09:47:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 4/5] pwm: imx27: fix disable state for inverted PWMs
Message-ID: <20200928074736.l63eecosjbyrcewe@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-5-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oqhhjjywpdbfjcwj"
Content-Disposition: inline
In-Reply-To: <20200925155330.32301-5-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oqhhjjywpdbfjcwj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 25, 2020 at 05:53:29PM +0200, Marco Felsch wrote:
> Up to now disabling the PWM is done using the PWMCR.EN register bit.
> Setting this bit to zero results in the output pin driving a low value
> independent of the polarity setting (PWMCR.POUTC).
>=20
> There is only little documentation about expectations and requirements
> in the PWM framework but the usual expectation seems to be that
> disabling a PWM together with setting .duty_cycle =3D 0 results in the
> output driving the inactive level. The pwm-bl driver for example uses
> this setting to disable the backlight and with the pwm-imx27 driver
> this results in an enabled backlight if the pwm signal is inverted.

This sounds as if the pwm-imx27 behaviour is a reason to believe that
=2Eduty_cycle =3D 0 + .enabled =3D false should drive the inactive level.

I'd write:
	The pwm-bl driver for example uses this setting to disable the
	backlight. Up to now however, this request makes the pwm-imx27
	enable the backlight if the PWM signal is inverted.

> Keep the PWMCR.EN bit always enabled and simulate a disabled PWM using
> duty_cycle =3D 0 to fix this. Furthermore we have to drop the sw-reset
> from apply() otherwise the PWMCR.EN is cleared too. Therefore the
> pwm_imx27_wait_fifo_slot() is extended and renamed to guarantee a free
> FIFO slot and to reflect the new meaning.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - fix driver remove function
> - rename pwm_imx27_wait_fifo_slot
> - pwm_imx27_get_fifo_slot now returns the number of used fifo slots
>   rather than 0 on success (needed for next patch).
>=20
>  drivers/pwm/pwm-imx27.c | 78 ++++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 3b6bcd8d58b7..07c6a263a39c 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -141,12 +141,9 @@ static void pwm_imx27_get_state(struct pwm_chip *chi=
p,
>  	if (ret < 0)
>  		return;
> =20
> -	val =3D readl(imx->mmio_base + MX3_PWMCR);
> +	state->enabled =3D imx->enabled;
> =20
> -	if (val & MX3_PWMCR_EN)
> -		state->enabled =3D true;
> -	else
> -		state->enabled =3D false;
> +	val =3D readl(imx->mmio_base + MX3_PWMCR);

I'm not a big fan. IMHO the driver should report about reality and the
framework (and maybe the consumers) should be able to handle that
=2Eget_state() reports

	.enabled =3D true
	.duty_cycle =3D 0

after

	.enabled =3D false

was requested.

>  	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
>  	case MX3_PWMCR_POUTC_NORMAL:
> @@ -169,8 +166,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
>  	state->period =3D DIV_ROUND_UP_ULL(tmp, pwm_clk);
> =20
>  	/*
> -	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
> -	 * use the cached value.
> +	 * Use the cached value if the PWM is disabled since we are using the
> +	 * PWMSAR to disable the PWM (see the notes in pwm_imx27_apply())
>  	 */
>  	if (state->enabled)
>  		val =3D readl(imx->mmio_base + MX3_PWMSAR);
> @@ -199,8 +196,8 @@ static void pwm_imx27_sw_reset(struct pwm_imx27_chip =
*imx, struct device *dev)
>  		dev_warn(dev, "software reset timeout\n");
>  }
> =20
> -static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
> -				     struct pwm_device *pwm)
> +static int pwm_imx27_get_fifo_slot(struct pwm_chip *chip,
> +				   struct pwm_device *pwm)
>  {
>  	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
>  	struct device *dev =3D chip->dev;
> @@ -216,9 +213,13 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip=
 *chip,
>  		msleep(period_ms);
> =20
>  		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> -		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))
> +		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr)) {
>  			dev_warn(dev, "there is no free FIFO slot\n");
> +			return -EBUSY;
> +		}
>  	}
> +
> +	return fifoav;
>  }
> =20
>  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -257,16 +258,25 @@ static int pwm_imx27_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	else
>  		period_cycles =3D 0;
> =20
> +	/* Wait for a free FIFO slot */
> +	ret =3D pwm_imx27_get_fifo_slot(chip, pwm);
> +	if (ret < 0)
> +		goto out;
> +
>  	/*
> -	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
> -	 * the FIFO if the PWM was disabled and is about to be enabled.
> +	 * We can't use the enable bit to control the en-/disable squence
> +	 * correctly because the output pin is pulled low if setting this bit
> +	 * to '0' regardless of the poutc value. Instead we have to use the
> +	 * sample register. According the RM:

According to the reference manual:

> +	 * A value of zero in the sample register will result in the PWMO output
> +	 * signal always being low/high (POUTC =3D 00 it will be low and
> +	 * POUTC =3D 01 it will be high), and no output waveform will be produc=
ed.
> +	 * If the value in this register is higher than the PERIOD

Did you forget to insert the end of this sentence here?

>  	 */
> -	if (imx->enabled)
> -		pwm_imx27_wait_fifo_slot(chip, pwm);
> +	if (state->enabled)
> +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>  	else
> -		pwm_imx27_sw_reset(imx, chip->dev);
> -
> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +		writel(0, imx->mmio_base + MX3_PWMSAR);
>  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);

I think you can simplify the code a bit using the following idiom:

	/*=20
	 * comment as above
	 */
=09
	if (!state->enabled)
		duty_cycle =3D 0;

	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);

With the change from the next patch I could also imagine to write a
smaller period in the !enabled case. The upside would be that the second
call in:

	pwm_apply(mypwm, { .enabled =3D false, .period =3D 3s });
	pwm_apply(mypwm, { .enabled =3D true, ... });

wouldn't take longer than a second in the average case.

@Thierry, we really need to agree on the expected behaviour in these
cases and document them.

>  	/*
> @@ -276,15 +286,10 @@ static int pwm_imx27_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	imx->duty_cycle =3D duty_cycles;
> =20
>  	cr =3D MX3_PWMCR_PRESCALER_SET(prescale);
> -
>  	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> -		cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> -				MX3_PWMCR_POUTC_INVERTED);
> -
> -	if (state->enabled)
> -		cr |=3D MX3_PWMCR_EN;
> +		cr |=3D FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_INVERTED);
> =20
> -	mask =3D MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
> +	mask =3D MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC;
> =20
>  	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
> =20
> @@ -373,10 +378,13 @@ static int pwm_imx27_probe(struct platform_device *=
pdev)
>  	if (!(pwmcr & MX3_PWMCR_EN)) {
>  		pwm_imx27_sw_reset(imx, &pdev->dev);
>  		mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> -		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
> +		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC | MX3_PWMCR_POUTC |
> +		       MX3_PWMCR_EN;
>  		pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
>  			MX3_PWMCR_DBGEN |
> -			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> +			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> +			FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_OFF) |
> +			MX3_PWMCR_EN;
>  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
>  		pwm_imx27_clk_disable_unprepare(imx);
>  	} else {
> @@ -385,6 +393,7 @@ static int pwm_imx27_probe(struct platform_device *pd=
ev)
>  		pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
>  			MX3_PWMCR_DBGEN;
>  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> +		imx->enabled =3D true;
>  	}
> =20
>  	return pwmchip_add(&imx->chip);
> @@ -392,11 +401,22 @@ static int pwm_imx27_probe(struct platform_device *=
pdev)
> =20
>  static int pwm_imx27_remove(struct platform_device *pdev)
>  {
> -	struct pwm_imx27_chip *imx;
> +	struct pwm_imx27_chip *imx =3D platform_get_drvdata(pdev);
> +	int ret;
> =20
> -	imx =3D platform_get_drvdata(pdev);
> +	ret =3D pwm_imx27_clk_prepare_enable(imx);
> +	if (ret)
> +		return ret;
> =20
> -	return pwmchip_remove(&imx->chip);
> +	ret =3D pwmchip_remove(&imx->chip);
> +	if (ret)
> +		return ret;
> +
> +	/* Ensure module is disabled after remove */
> +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, MX3_PWMCR_EN, 0);
> +	pwm_imx27_clk_disable_unprepare(imx);

This is wrong. You are supposed to assume the PWM is already off in
=2Eremove and don't touch it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oqhhjjywpdbfjcwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9xlRUACgkQwfwUeK3K
7AkYtAf/essKTX1Y0/fkPpESB9VMRBCFWld1isiRVGNNXI0j6HKn+mzYPsoUArSc
t2owkH6Zx8Cp5OZa/6Uo2X8hAb1wJXhndE8sPHCj0syuo1pRXkma6zPaGi83LM8S
iGlzClTaleNR5j/oYYLq4Gkgx3jIzOrbFw8v7LIb5WiIRQ2a+L9onlfeYpdiIapl
AG+tTqFP8gMLnCHjY2b7GycWiCnIfwuOXDg8TqadtAJY5g72/UDgRn4NsmSxtKwo
H9UoPYG2+Q4MUspXH3F8etYOdPJxleWFuMcWuKBNWLr9UgYeb/VSQQbU/X7JY0ZO
mpIk89PHls+a4eiuiaBz0u3+NkW+2g==
=vYP6
-----END PGP SIGNATURE-----

--oqhhjjywpdbfjcwj--
