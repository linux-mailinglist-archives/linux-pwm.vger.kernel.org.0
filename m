Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83675F91C
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jul 2023 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGXOAi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jul 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGXOAh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2023 10:00:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E96FF
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2023 07:00:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNw70-0004Q8-UR; Mon, 24 Jul 2023 16:00:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNw70-001lxC-0w; Mon, 24 Jul 2023 16:00:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qNw6z-007Pg2-Ce; Mon, 24 Jul 2023 16:00:33 +0200
Date:   Mon, 24 Jul 2023 16:00:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] pwm: lpc32xx: remove handling of PWM channels
Message-ID: <20230724140032.g7vriv72uuvxbohd@pengutronix.de>
References: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxuj7b2oglcfin4w"
Content-Disposition: inline
In-Reply-To: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cxuj7b2oglcfin4w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 17, 2023 at 05:52:57PM +0200, Uwe Kleine-K=F6nig wrote:
> Because LPC32xx PWM controllers have only a single output which is
> registered as the only PWM device/channel per controller, it is known in
> advance that pwm->hwpwm value is always 0. On basis of this fact
> simplify the code by removing operations with pwm->hwpwm, there is no
> controls which require channel number as input.
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> this is a patch that was submitted before by Vladimir in 2016[1]. I
> stumbled over hwpwm always being 0 while doing some restructuring of all
> pwm drivers. I thought this wasn't the first time I diagnosed this and
> while searching for such a patch by me, I found Vladimir's :-)
>=20
> I added "only a" to the commit log and rebased to v6.5-rc1. I considered
> adding
> [ukl: improved wording of commit log and rebase to v6.5-rc1]
> to the commit log, but the adaptions seemed too trivial to me.
>=20
> Best regards
> Uwe
>=20
> [1] https://lore.kernel.org/linux-pwm/20161205014308.1741-2-vz@mleia.com
>=20
>  drivers/pwm/pwm-lpc32xx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
> index 86a0ea0f6955..806f0bb3ad6d 100644
> --- a/drivers/pwm/pwm-lpc32xx.c
> +++ b/drivers/pwm/pwm-lpc32xx.c
> @@ -51,10 +51,10 @@ static int lpc32xx_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	if (duty_cycles > 255)
>  		duty_cycles =3D 255;
> =20
> -	val =3D readl(lpc32xx->base + (pwm->hwpwm << 2));
> +	val =3D readl(lpc32xx->base);
>  	val &=3D ~0xFFFF;
>  	val |=3D (period_cycles << 8) | duty_cycles;
> -	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
> +	writel(val, lpc32xx->base);
> =20
>  	return 0;
>  }
> @@ -69,9 +69,9 @@ static int lpc32xx_pwm_enable(struct pwm_chip *chip, st=
ruct pwm_device *pwm)
>  	if (ret)
>  		return ret;
> =20
> -	val =3D readl(lpc32xx->base + (pwm->hwpwm << 2));
> +	val =3D readl(lpc32xx->base);
>  	val |=3D PWM_ENABLE;
> -	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
> +	writel(val, lpc32xx->base);
> =20
>  	return 0;
>  }
> @@ -81,9 +81,9 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  	struct lpc32xx_pwm_chip *lpc32xx =3D to_lpc32xx_pwm_chip(chip);
>  	u32 val;
> =20
> -	val =3D readl(lpc32xx->base + (pwm->hwpwm << 2));
> +	val =3D readl(lpc32xx->base);
>  	val &=3D ~PWM_ENABLE;
> -	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
> +	writel(val, lpc32xx->base);
> =20
>  	clk_disable_unprepare(lpc32xx->clk);
>  }
> @@ -141,9 +141,9 @@ static int lpc32xx_pwm_probe(struct platform_device *=
pdev)
>  	lpc32xx->chip.npwm =3D 1;
> =20
>  	/* If PWM is disabled, configure the output to the default value */
> -	val =3D readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
> +	val =3D readl(lpc32xx->base);
>  	val &=3D ~PWM_PIN_LEVEL;
> -	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
> +	writel(val, lpc32xx->base);

As noted by Dan Carpenter in
https://lore.kernel.org/linux-pwm/919cac5d-491e-4534-baed-bf813181192d@moro=
to.mountain
lpc32xx->chip.pwms is NULL before devm_pwmchip_add() is called so this
patch fixes a null pointer exception.

Maybe add the following to the commit log:

	Even though I wasn't aware at the time when I forward ported that patch,
	this fixes a null pointer dereference as lpc32xx->chip.pwms is NULL
	before devm_pwmchip_add() is called.

	Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
	Fixes: 3d2813fb17e5 ("pwm: lpc32xx: Don't modify HW state in .probe() afte=
r the PWM chip was registered")

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cxuj7b2oglcfin4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS+hAAACgkQj4D7WH0S
/k6Ybgf+O0RLBcqAkuO5C/Q4oINWVw+Pxw7ghWzQdcPLZ5RBleQwLyORK+arPYFl
wKhKfPbHXFWRu3ZyKUQeJcMw5ugQaEDafPAW7e3DW3zJGdp+I1C634GRRkPtzb5i
c3s2LI2twXm2Y8zaXINfttEwlWVihyLNjxZricL1WdqH/RDSbBLptGNwTtRCfIFe
zgCGHCWM7nwYICNu2ChAgPALRoGtUaohEtyTpUZ0r44tVW7W9Uhw9so/ZiqLErWo
3w9zlPjyZCZCncBiPhK9NE3SF+ItO4x4PM+fbgczk9z2N52xMLQe/+Jm0mRso7OC
5BCMOaE3hAnQbtZhBOReKuk19ynsWA==
=Xzig
-----END PGP SIGNATURE-----

--cxuj7b2oglcfin4w--
