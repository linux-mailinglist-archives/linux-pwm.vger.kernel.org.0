Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF8C271E77
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIUJBf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIUJBf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2020 05:01:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F148C061755
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2020 02:01:35 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHhQ-0005AG-PH; Mon, 21 Sep 2020 11:01:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHhO-0000m3-MR; Mon, 21 Sep 2020 11:01:26 +0200
Date:   Mon, 21 Sep 2020 11:01:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] pwm: imx27: move static pwmcr values into probe()
 function
Message-ID: <20200921090126.biff7xjjdju7xn3b@pengutronix.de>
References: <20200909130739.26717-1-m.felsch@pengutronix.de>
 <20200909130739.26717-3-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fm4ggtlkti5a2zhz"
Content-Disposition: inline
In-Reply-To: <20200909130739.26717-3-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fm4ggtlkti5a2zhz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

the usage of "static" in the subject is unclear. I guess you mean:

	pwm: imx27: setup some PWMCR bits in .probe()

On Wed, Sep 09, 2020 at 03:07:38PM +0200, Marco Felsch wrote:
> The STOPEN, DOZEN, WAITEN, DBGEN and the CLKSRC bit values never change.
> So it should be save to move this bit settings into probe() and change

s/save/safe/

> only the necessary bits during apply(). Therefore I added the
> pwm_imx27_update_bits() helper.
>=20
> Furthermore the patch adds the support to reset the pwm device during
> probe() if the pwm device is disabled.

IMHO this needs a better motivation ...

> Both steps are required in preparation of the further patch which fixes
> the "pwm-disabled" state for inverted pwms.

=2E.. and should maybe go into this other patch?

> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx27.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 3cf9f1774244..30388a9ece04 100644
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
> @@ -183,10 +193,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chi=
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

This change is fine, but it does belong into a separate patch.

>  	int wait_count =3D 0;
>  	u32 cr;
> =20
> @@ -232,7 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	unsigned long long c;
>  	unsigned long long clkrate;
>  	int ret;
> -	u32 cr;
> +	u32 cr, mask;
> =20
>  	ret =3D pwm_imx27_clk_prepare_enable(imx);
>  	if (ret)
> @@ -269,7 +277,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	if (cstate.enabled) {
>  		pwm_imx27_wait_fifo_slot(chip, pwm);
>  	} else {
> -		pwm_imx27_sw_reset(chip);
> +		pwm_imx27_sw_reset(imx, chip->dev);
>  	}
> =20
>  	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> @@ -281,10 +289,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
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
> @@ -293,7 +298,9 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	if (state->enabled)
>  		cr |=3D MX3_PWMCR_EN;
> =20
> -	writel(cr, imx->mmio_base + MX3_PWMCR);
> +	mask =3D MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
> +
> +	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
> =20
>  	if (!state->enabled)
>  		pwm_imx27_clk_disable_unprepare(imx);
> @@ -364,10 +371,20 @@ static int pwm_imx27_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> -	/* keep clks on if pwm is running */
> +	/* Keep clks on and pwm settings unchanged if the PWM is already runnin=
g */
>  	pwmcr =3D readl(imx->mmio_base + MX3_PWMCR);
> -	if (!(pwmcr & MX3_PWMCR_EN))
> +	if (!(pwmcr & MX3_PWMCR_EN)) {
> +		u32 mask;
> +
> +		pwm_imx27_sw_reset(imx, &pdev->dev);
> +		mask =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +			MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
> +		pwmcr =3D MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +			MX3_PWMCR_DBGEN |
> +			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
> +		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
>  		pwm_imx27_clk_disable_unprepare(imx);
> +	}

So you don't enforce MX3_PWMCR_STOPEN (and the others) if the PWM is
already running. Is this by design?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fm4ggtlkti5a2zhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9oa+MACgkQwfwUeK3K
7Alc6wgAmZXga9YO8LLWZ9sCJg8m5uAHMFrzbIaEYvr+HPn4+yC57RYRcCyblzgN
CoD1FZFhS9Wkmem00XcfDfRYsaf9wFJPyyuDbpc0U4/yCWnpTPIt2dlhmnXo+/zJ
Ddgv02QxNMRLjCXMy4c8YGpmBv36HssZnLMhlX7RJPxEq5eiACC41r4FMJe8XKnD
BOnuC+HDGOfcCfH96gMP2mK/kRWdC7aigjVKlC+dLdrKEWF6JgJN6vpZTX5Lry0v
+etv8HS9H8zR/Oc8zoQCSbAsgUbpNIqvWJgHRUYS7G2gs16jZPdocZJ24nNzvseU
4zVeXeAwPfbrWDCkdN4ZDZTJYu+svA==
=P1GE
-----END PGP SIGNATURE-----

--fm4ggtlkti5a2zhz--
