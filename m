Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524ED2F464A
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 09:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAMISq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 03:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbhAMISq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 03:18:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203A4C061786
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jan 2021 00:18:06 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzbLg-00046N-Tq; Wed, 13 Jan 2021 09:17:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzbLV-0006Pt-Si; Wed, 13 Jan 2021 09:17:37 +0100
Date:   Wed, 13 Jan 2021 09:17:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     g@pengutronix.de, Thierry Reding <thierry.reding@gmail.com>,
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
Subject: Re: [PATCH 1/5] gpio: mvebu: fix pwm get_state period calculation
Message-ID: <20210113081723.mdd3dlvskrbmbb6t@pengutronix.de>
References: <cover.1610362661.git.baruch@tkos.co.il>
 <e3afc6e297e495322971c26a79c6f841d5952fd1.1610362661.git.baruch@tkos.co.il>
 <20210111201711.ym46w7dy62ux66zb@pengutronix.de>
 <87ft35xs0z.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ywgutydfbazompzo"
Content-Disposition: inline
In-Reply-To: <87ft35xs0z.fsf@tarshish>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ywgutydfbazompzo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 08:36:12AM +0200, Baruch Siach wrote:
> Hi Uwe,
>=20
> On Mon, Jan 11 2021, Uwe Kleine-K=F6nig wrote:
> > $Subject ~=3D s/get_state/.get_state/ ?
>=20
> Ack.
>=20
> > On Mon, Jan 11, 2021 at 01:17:02PM +0200, Baruch Siach wrote:
> >> The period is the sum of on and off values.
> >>=20
> >> Reported-by: Russell King <linux@armlinux.org.uk>
> >> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >>  drivers/gpio/gpio-mvebu.c | 19 ++++++++-----------
> >>  1 file changed, 8 insertions(+), 11 deletions(-)
> >>=20
> >> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> >> index 672681a976f5..a912a8fed197 100644
> >> --- a/drivers/gpio/gpio-mvebu.c
> >> +++ b/drivers/gpio/gpio-mvebu.c
> >> @@ -676,20 +676,17 @@ static void mvebu_pwm_get_state(struct pwm_chip =
*chip,
> >>  	else
> >>  		state->duty_cycle =3D 1;
> >> =20
> >> +	val =3D (unsigned long long) u; /* on duration */
> >>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
> >> -	val =3D (unsigned long long) u * NSEC_PER_SEC;
> >> +	val +=3D (unsigned long long) u; /* period =3D on + off duration */
> >> +	val *=3D NSEC_PER_SEC;
> >>  	do_div(val, mvpwm->clk_rate);
> >> -	if (val < state->duty_cycle) {
> >> +	if (val > UINT_MAX)
> >> +		state->period =3D UINT_MAX;
> >> +	else if (val)
> >> +		state->period =3D val;
> >> +	else
> >>  		state->period =3D 1;
> >> -	} else {
> >> -		val -=3D state->duty_cycle;
> >> -		if (val > UINT_MAX)
> >> -			state->period =3D UINT_MAX;
> >> -		else if (val)
> >> -			state->period =3D val;
> >> -		else
> >> -			state->period =3D 1;
> >> -	}
> >
> > The patch looks good, the patch description could be a bit more verbose.
> > Something like:
> >
> > 	Calculate the period as
> >
> > 		($on + $off) / clkrate
> >
> > 	instead of
> >
> > 		$off / clkrate - $on / clkrate
> >
> > 	.
>=20
> I take this to refer to the next patch (2/5). This patch changes from
> buggy
>=20
>   $on / clkrate

No, the previous calculation had

-		val -=3D state->duty_cycle;

which accounts for "- $on / clkrate".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ywgutydfbazompzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+rJEACgkQwfwUeK3K
7Anjygf/faMPolAodZOGsp+6XqGwafR+N/b6zcBQg9nYke6vKN9qMu2JpJ6QdNpR
3mDWIC151XibEiMQ5Z+6eWULOYSv3TcC3OikvLKycUGCoyVJEtoHuevBB6o0nTNP
pQ8+7xgeEhju5Rjppq1Av6I1d9wBZMwmXhR2rJKBBnuyhtLSnF1wM/tMtTdeDEcz
q5xx8EqKE2/xORN+Xj6tVlC86X35kU3dbfnjlw2gHOf2yPlTRHemR3clLsBoMN/m
U8r5yGx32WjMzrt00HAJ+tl4u+FAGOqyEDVAA04ZlIBYiy1hnpCpf7Cmf9dCjD3b
xLb8DlVnbQ2yolV/AHsyIvy+QPNBhg==
=6Ymi
-----END PGP SIGNATURE-----

--ywgutydfbazompzo--
