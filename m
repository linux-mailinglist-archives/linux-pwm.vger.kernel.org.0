Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B22C8802
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 16:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgK3PcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 10:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgK3PcE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Nov 2020 10:32:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107EC0613D2
        for <linux-pwm@vger.kernel.org>; Mon, 30 Nov 2020 07:31:23 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjl8v-0000p3-UN; Mon, 30 Nov 2020 16:31:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjl8Q-0000Q5-K1; Mon, 30 Nov 2020 16:30:38 +0100
Date:   Mon, 30 Nov 2020 16:30:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] gpio: mvebu: fix potential user-after-free on probe
Message-ID: <20201130153036.p3gdsauxsmas3rbo@pengutronix.de>
References: <4db704460547d715a1d9cf86d51612b347e38a7b.1606748993.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wnqbim4d3bbi66xo"
Content-Disposition: inline
In-Reply-To: <4db704460547d715a1d9cf86d51612b347e38a7b.1606748993.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wnqbim4d3bbi66xo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 05:09:53PM +0200, Baruch Siach wrote:
> When mvebu_pwm_probe() fails IRQ domain is not released. Goto the
> err_domain label on failure to release IRQ domain.
>=20
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Don't leak pwm resources (Uwe Kleine-K=F6nig)
>=20
> This is split out of the "gpio: mvebu: Armada 8K/7K PWM support" series.
> I'll rebase the series v2 on top on this fix.
> ---
>  drivers/gpio/gpio-mvebu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 433e2c3f3fd5..c53ed975a180 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -1255,8 +1255,11 @@ static int mvebu_gpio_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
> -	if (IS_ENABLED(CONFIG_PWM))
> -		return mvebu_pwm_probe(pdev, mvchip, id);
> +	if (IS_ENABLED(CONFIG_PWM)) {
> +		err =3D mvebu_pwm_probe(pdev, mvchip, id);
> +		if (err)
> +			goto err_domain;

I only looked quickly, but I wonder if you need to undo
irq_alloc_domain_generic_chips(), too?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wnqbim4d3bbi66xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/FEBoACgkQwfwUeK3K
7An/owf/W6KGXP9GtEVQVnd4DuNU0sk4sm9aIL3RGojIC/oBbLxqRLoVqns0Nsvq
uD+dukpN3jJ3R007GPzfWAq4KCA5mEB3CANQPucR3ZEAF7tRT52fUcxfBWx20ENz
+LHZVtzHTmHAYmWq6wTsrAKczcYO+604J+FGtfIh6Uv0Q1gGEAecaxrP2+3iyxLo
gN9WlSZlFQMkMeMYklvmUlYrqo3FhrCKAcz8Wi4K8PuciFSErzeekAw64tjmW2Zu
m8SGdIj0J3ISuuvTl2Ty5gnGqkm5h6hKmh+8QVA/EJ0sQEQwEv2q0hQSZs3Oi/Gh
rBbjGIZPo++DpGq01WuqsCxGXAfVBw==
=5Tda
-----END PGP SIGNATURE-----

--wnqbim4d3bbi66xo--
