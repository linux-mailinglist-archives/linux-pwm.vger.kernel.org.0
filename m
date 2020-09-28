Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA227A8A3
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 09:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgI1Ha1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 03:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1Ha1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 03:30:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEECC0613CE
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 00:30:26 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMnc5-0008WH-1s; Mon, 28 Sep 2020 09:30:21 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMnc3-0007Wv-NH; Mon, 28 Sep 2020 09:30:19 +0200
Date:   Mon, 28 Sep 2020 09:30:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/5] pwm: imx27: reset the PWM if it is not running
Message-ID: <20200928073019.led4eyfl3emv6aau@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-4-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4hv5z3dxu7ee7d2e"
Content-Disposition: inline
In-Reply-To: <20200925155330.32301-4-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4hv5z3dxu7ee7d2e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 05:53:28PM +0200, Marco Felsch wrote:
> Trigger a software reset during probe to clear the FIFO and reset the
> register values to their default. According the datasheet the DBGEN,
> STOPEN, DOZEN and WAITEN bits should be untouched by the software reset
> but this is not the case.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - new patch
>=20
>  drivers/pwm/pwm-imx27.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index b761764b8375..3b6bcd8d58b7 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -183,10 +183,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chi=
p,
>  	pwm_imx27_clk_disable_unprepare(imx);
>  }
> =20
> -static void pwm_imx27_sw_reset(struct pwm_chip *chip)
> +static void pwm_imx27_sw_reset(struct pwm_imx27_chip *imx, struct device=
 *dev)
>  {
> -	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> -	struct device *dev =3D chip->dev;
>  	int wait_count =3D 0;
>  	u32 cr;

This is an unrelated hunk that I don't expect to result in any changes
in the code. If you consider it better this way, you should at least
mention it in the commit log.

> @@ -266,7 +264,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	if (imx->enabled)
>  		pwm_imx27_wait_fifo_slot(chip, pwm);
>  	else
> -		pwm_imx27_sw_reset(chip);
> +		pwm_imx27_sw_reset(imx, chip->dev);
> =20
>  	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> @@ -370,19 +368,23 @@ static int pwm_imx27_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> -	mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> -	       MX3_PWMCR_DBGEN;
> -	pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> -		MX3_PWMCR_DBGEN;
> -	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> -
>  	/* keep clks on and clk settings unchanged if pwm is running */
>  	pwmcr =3D readl(imx->mmio_base + MX3_PWMCR);
>  	if (!(pwmcr & MX3_PWMCR_EN)) {
> -		mask =3D MX3_PWMCR_CLKSRC;
> -		pwmcr =3D FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> +		pwm_imx27_sw_reset(imx, &pdev->dev);
> +		mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +		       MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
> +		pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +			MX3_PWMCR_DBGEN |
> +			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
>  		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
>  		pwm_imx27_clk_disable_unprepare(imx);
> +	} else {
> +		mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +			MX3_PWMCR_DBGEN;
> +		pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +			MX3_PWMCR_DBGEN;
> +		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
>  	}

IMHO this is worse than the stuff I suggested for one of the earlier
patches because there is much repetition. I'd put

	mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMCR=
_DBGEN;
	value =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMC=
R_DBGEN;

before the if and just modify as necessary in the first branch of the
if.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4hv5z3dxu7ee7d2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9xkQgACgkQwfwUeK3K
7Al0HQgAmzOb6wMkEWw3F3aSS1LBhGpa/3mptRmVZzhXuemD9+Jw814QuzsE3FTo
OuuySFqZQlGBVqec2rtp/6hnOu+ZIXLaKQN4BdVMaJnAQqn6hCoTzGMRzznXds1d
uuAb/WIjLfHqIclw6indBto42o4ttnMND1SJ4R0Yb2qwTOj0NZxemrhm5I7Gugl/
rkdHRGqBFfFbMmLBSABOa+Bhf2cxXFVJEAAednkrvza84gmp5kNFL8iKszBBGuXR
1mP/meMVIOMavu13VTEAgwVqis9jTFqC7tE6DwqOzIuf6nNGkGa8PciLo9F+uWrc
tJVp1UNihHm/8O292BgkEinswVfZag==
=NWPn
-----END PGP SIGNATURE-----

--4hv5z3dxu7ee7d2e--
