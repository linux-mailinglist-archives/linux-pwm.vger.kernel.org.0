Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3BA2799BD
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Sep 2020 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZNqs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Sep 2020 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZNqs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Sep 2020 09:46:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1050AC0613CE
        for <linux-pwm@vger.kernel.org>; Sat, 26 Sep 2020 06:46:48 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMAXC-0001gX-AZ; Sat, 26 Sep 2020 15:46:42 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMAXB-00020o-8F; Sat, 26 Sep 2020 15:46:41 +0200
Date:   Sat, 26 Sep 2020 15:46:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/5] pwm: imx27: move constant PWMCR register values
 into probe
Message-ID: <20200926134641.fkqhoez4j3fktbnh@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wnokfvuhnuqgefeb"
Content-Disposition: inline
In-Reply-To: <20200925155330.32301-3-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wnokfvuhnuqgefeb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 05:53:27PM +0200, Marco Felsch wrote:
> The STOPEN, DOZEN, WAITEN, DBGEN and the CLKSRC bit values never change.
> So it should be safe to move this bit settings into probe() and change
> only the necessary bits during apply(). Therefore I added the
> pwm_imx27_update_bits() helper.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v2:
> - drop software reset from the logic
> - fix setting STOPEN, DOZEN, WAITEN and DBGEN bits in case the pwm is
>   already enabled
>=20
>  drivers/pwm/pwm-imx27.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 7edac4ac6395..b761764b8375 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -96,6 +96,16 @@ struct pwm_imx27_chip {
> =20
>  #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip=
, chip)
> =20
> +static void pwm_imx27_update_bits(void __iomem *reg, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp =3D readl(reg);
> +	tmp &=3D ~mask;
> +	tmp |=3D val & mask;
> +	return writel(tmp, reg);
> +}
> +
>  static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
>  {
>  	int ret;
> @@ -221,7 +231,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	unsigned long long c;
>  	unsigned long long clkrate;
>  	int ret;
> -	u32 cr;
> +	u32 cr, mask;
> =20
>  	ret =3D pwm_imx27_clk_prepare_enable(imx);
>  	if (ret)
> @@ -267,10 +277,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	 */
>  	imx->duty_cycle =3D duty_cycles;
> =20
> -	cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> -	     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> -	     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> -	     MX3_PWMCR_DBGEN;
> +	cr =3D MX3_PWMCR_PRESCALER_SET(prescale);
> =20
>  	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
>  		cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> @@ -279,7 +286,9 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	if (state->enabled)
>  		cr |=3D MX3_PWMCR_EN;
> =20
> -	writel(cr, imx->mmio_base + MX3_PWMCR);
> +	mask =3D MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
> +
> +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
> =20
>  	if (imx->enabled !=3D state->enabled) {
>  		if (state->enabled) {
> @@ -314,7 +323,7 @@ static int pwm_imx27_probe(struct platform_device *pd=
ev)
>  {
>  	struct pwm_imx27_chip *imx;
>  	int ret;
> -	u32 pwmcr;
> +	u32 pwmcr, mask;
> =20
>  	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
>  	if (imx =3D=3D NULL)
> @@ -361,10 +370,20 @@ static int pwm_imx27_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> -	/* keep clks on if pwm is running */
> +	mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +	       MX3_PWMCR_DBGEN;
> +	pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +		MX3_PWMCR_DBGEN;
> +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
> +
> +	/* keep clks on and clk settings unchanged if pwm is running */
>  	pwmcr =3D readl(imx->mmio_base + MX3_PWMCR);
> -	if (!(pwmcr & MX3_PWMCR_EN))
> +	if (!(pwmcr & MX3_PWMCR_EN)) {
> +		mask =3D MX3_PWMCR_CLKSRC;
> +		pwmcr =3D FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> +		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
>  		pwm_imx27_clk_disable_unprepare(imx);
> +	}

You're doing more register accesses here than necessary, that is 3 reads
and two writes while one read and (maybe) one write would be enough.
(Though this doesn't work if you want to use the pwm_imx27_update_bits
helper.)

You'd need to do something like:

	val =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMCR_=
DBGEN;
	mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN | MX3_PWMCR=
_DBGEN;

	pwmcr =3D readl(imx->mmio_base + MX3_PWMCR);

	if (pwmcr & MX3_PWMCR_EN) {
		imx->enabled =3D true;
	} else {
		val |=3D FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
		mask |=3D MX3_PWMCR_CLKSRC;
	}

	pwmcr_new =3D (pwmcr & ~mask) | val;

	if (pwmcr_new !=3D val)
		writel(imx->mmio_base + MX3_PWMCR, pwmcr_new);

	if (!imx->enabled)
		pwm_imx27_clk_disable_unprepare(imx);

Hmm, not sure this is pretty enough to actually recommend this. I let
you decide.

>  	return pwmchip_add(&imx->chip);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wnokfvuhnuqgefeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9vRj4ACgkQwfwUeK3K
7AlJ4wf/RIgOfPRFMYAH2/MrBtl5qs1r5EsPm7rr2ilfHM7zjsyqkgwuwirRJj9+
yXBQtvdCMeJclVo6QuGOnmepX7PsBHX6TYN+WEqjxtOg6FOOQESq95Ba3BJ3gsTO
mTgEE4ZmWZmUwiD/uew7MFpVLfCdzMT3+6sLxGLhT3Ob6HCDUNMp/jZ51qNhDW3Q
ivlLvvyuYGuM4oYk4l2iOFLoye6ohsi+Ud0gjcrwA2in1v5p/0bPpdx42cez8Gj5
vAqSdT9fE0Ksi5MD4nKdPkTXpa6WVsGhWdr4IVVGzrNYDTMvwQoH/KStUMimWSXe
Mi6OCpV8hbGjz2MA6LwIUeuioilaJQ==
=uNjC
-----END PGP SIGNATURE-----

--wnokfvuhnuqgefeb--
