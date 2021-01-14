Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB42F6C06
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 21:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbhANU1F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhANU1F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Jan 2021 15:27:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F592C061575
        for <linux-pwm@vger.kernel.org>; Thu, 14 Jan 2021 12:26:23 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l09C2-0004rm-Iw; Thu, 14 Jan 2021 21:26:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l09Bh-0004DJ-Pg; Thu, 14 Jan 2021 21:25:45 +0100
Date:   Thu, 14 Jan 2021 21:25:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/5] gpio: mvebu: document zero pwm duty cycle
 limitation
Message-ID: <20210114202545.7wnc5ikeffc45xk5@pengutronix.de>
References: <cover.1610628807.git.baruch@tkos.co.il>
 <7c18dd67d3bf3e3ed9a8efa2edd33e8f29f09a7a.1610628807.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hge5vgglsebamct3"
Content-Disposition: inline
In-Reply-To: <7c18dd67d3bf3e3ed9a8efa2edd33e8f29f09a7a.1610628807.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hge5vgglsebamct3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Thu, Jan 14, 2021 at 08:57:37PM +0200, Baruch Siach wrote:
> Add a comment on why the code never sets on/off registers to zero.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Analyzed-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 6b017854ce61..09780944bef9 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -706,6 +706,10 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	do_div(val, NSEC_PER_SEC);
>  	if (val > UINT_MAX)
>  		return -EINVAL;
> +	/*
> +	 * Zero on/off values don't work as expected. Experimentation shows
> +	 * that zero value is treated as 2^32. This behavior is not documented.
> +	 */

This is too easy. The right thing to do is to adapt .apply and
=2Eget_state to use this new information.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hge5vgglsebamct3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAAqMYACgkQwfwUeK3K
7AlmJwf9GztxWNGUNA7xwfNxRj0OpJmvmVIpB+/qigom1z/lWYqiIj6xLhlqgtFd
aYf3zzT4UqkeqfWuT1Q3FYqLw/89NJa007FFpwiKP1PrUT3NU6WSBN+WOEoXxrk/
Wq28Q4xOq/IDkjZ0rNnvFJRUq8l6Vrle+9sObIdU11e8tCS0Oblkj8SQd9MbEqHi
Dfc8h4vAuaQMdREJuuYb3t17D3x52ICHCnY/97LUC224/7f5Tkjiz+tXWpc23she
is8oF74DzFLMVzumMIbXitQiKJd56oMty7Fp/igY72Y42M79lx4HkoN8VxRYQcT6
eIvt5Sgb9CBb7D7BYiIFiVUcxgKzBw==
=KT+B
-----END PGP SIGNATURE-----

--hge5vgglsebamct3--
