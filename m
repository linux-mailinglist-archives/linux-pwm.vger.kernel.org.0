Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192332F20B8
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 21:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbhAKUZI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 15:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbhAKUZH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 15:25:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C071C06179F
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 12:24:27 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3jh-0007Uq-He; Mon, 11 Jan 2021 21:24:21 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3ja-0001z8-7K; Mon, 11 Jan 2021 21:24:14 +0100
Date:   Mon, 11 Jan 2021 21:24:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] gpio: mvebu: document zero pwm duty cycle limitation
Message-ID: <20210111202413.lk3mxthlqagdhy7t@pengutronix.de>
References: <cover.1610362661.git.baruch@tkos.co.il>
 <fa809a148e2a008c124677d61ea4ecba55cea7d0.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v2xxeaykrhgusqf3"
Content-Disposition: inline
In-Reply-To: <fa809a148e2a008c124677d61ea4ecba55cea7d0.1610362661.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--v2xxeaykrhgusqf3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 01:17:06PM +0200, Baruch Siach wrote:
> Add a comment on why the code never sets the 'on' register to zero.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index eb7456fa6d86..4261e3b22b4e 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -706,6 +706,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	val =3D DIV_ROUND_UP_ULL(val, NSEC_PER_SEC);
>  	if (val > UINT_MAX)
>  		return -EINVAL;
> +	/* zero 'on' value does not work as expected for some reason */

What does the reference manual say about this? If there is no
information about this, please point this out, too. (Something like: The
reference manual is silent about this issue though.) Also I'd prefer to
read about the behaviour, so maybe mention that there is an occational
peek even when on is configured to 0. Does '$off =3D 0' has a symmetrical
issue?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--v2xxeaykrhgusqf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8s+oACgkQwfwUeK3K
7Alr7ggAnP3afhu4El+ecWi64C9XayPFiu4UfcCC6ai1wxeTxNzS7ZOG+pvAPCzv
bKmaHYLUAoJ6LcBgaeSpfZOo0D5jSsn90IHJtxvihHxZz7j9/kZ/5g7OQsrhBbR4
F8/b25GnC43fsrTJ/NRVveHbO2g1PawLWFJrkm83szPH7AuLFYtnSUYcl0mAyoBZ
RXZlHqgueE5DownntoPX/L8RRvGzesqrvSsGuepb69vzxwhgvFRyTfOOezauQOqL
7mXmAiBSLNSLFxJV34vJD6tVc5tigmgryhm2BlNYocnrSLhh5FwT902UfHrYplJK
jX3DCkWu6K7ASfwi8SQkD8hoWxBg2g==
=hvxu
-----END PGP SIGNATURE-----

--v2xxeaykrhgusqf3--
