Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955932E1007
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 23:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLVWMW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Dec 2020 17:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgLVWMW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 17:12:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22958C0613D3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Dec 2020 14:11:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krpsY-0007b6-6D; Tue, 22 Dec 2020 23:11:38 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krpsW-0001DP-CR; Tue, 22 Dec 2020 23:11:36 +0100
Date:   Tue, 22 Dec 2020 23:11:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm2835: Improve period and duty cycle calculation
Message-ID: <20201222221136.cjsjyavfpynrtisj@pengutronix.de>
References: <20201221165501.717101-1-u.kleine-koenig@pengutronix.de>
 <3e202765-d747-148c-160d-21bacede6f13@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="irgthj4ae4qu4cp3"
Content-Disposition: inline
In-Reply-To: <3e202765-d747-148c-160d-21bacede6f13@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--irgthj4ae4qu4cp3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lino,

On Tue, Dec 22, 2020 at 05:34:00PM +0100, Lino Sanfilippo wrote:
> On 21.12.20 at 17:55, Uwe Kleine-K=F6nig wrote:
> > With an input clk rate bigger than 2000000000, scaler would have been
> > zero which then would have resulted in a division by zero.
> >
> > Also the originally implemented algorithm divided by the result of a
> > division. This nearly always looses precision. Consider a requested per=
iod
> > of 1000000 ns. With an input clock frequency of 32786885 Hz the hardware
> > was configured with an actual period of 983869.007 ns (PERIOD =3D 32258)
> > while the hardware can provide 1000003.508 ns (PERIOD =3D 32787).
> > And note if the input clock frequency was 32786886 Hz instead, the hard=
ware
> > was configured to 1016656.477 ns (PERIOD =3D 33333) while the optimal
> > setting results in 1000003.477 ns (PERIOD =3D 32787).
> >
> > This patch implements proper range checking and only divides once for
> > the calculation of period (and similar for duty_cycle).
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >
> > during review of the bcm2835 driver I noticed this double division.
> >
> > I think the practical relevance is low however because the clock rate is
> > fixed to 10 MHz on this platform which doesn't result in these
> > deviations. (Is this right, what is the actual rate?)
>=20
> clk_get_rate() on my Raspberry Pi 4 returns 9999999.

oh, then my patch is a real improvement, but the problems are not as bad
as my examples above. So when a period of 350ns was requested, the old
algorithm provided 400.000040000004 ns and the improved yields
300.000030000003 ns.

> I tested this on the RP and everything still works so far, so FWIW
> Tested-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Thanks.

> > +	if (state->period > max_period)
> > +		period =3D max_period;
> > +	else
> > +		period =3D state->period;
> > +
>=20
> We return EINVAL if the value for period is too small, so should we not d=
o the
> same for the case that the value is too high?

Ah, I didn't notice I changed the behaviour here, but indeed this is
what I think is the right behaviour. (i.e. configure the biggest
possible period not bigger than the requested period.)

But this change doesn't belong into this patch, so I will fixup and
resend.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--irgthj4ae4qu4cp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/ibxUACgkQwfwUeK3K
7Al0TggAlNZJU9keg2KuBfDfvuc9GlqOnv3AoNI3L5j2OxJu0gXqplwdYdVTEehL
IrVnX4MdXj57brOhkGVrG9Wqok7K3fD/2ZwGf5LqxrOUMH1AQopTF9skW0KvtnSh
lOm4i2jloqO0Pkg0v6zECLz+w2ysFd6p7IThV//WDLcjXLr9b/O0HBrMmA4WvSyZ
vGtliEcHDGUS+tSmroupqE/pHy5R/kF4WyR0uSJ6reBYpxmJUKDmSHdv48+z5YPB
2gX9XKv5cDSAJqrzKVY9LTQMi1BrqNLRQ2W3donDgBkeW5hkHaBMaYEVSY1ZKSEr
kWuuTuOHMqZ6owOmvyqWXIm5P1MQhQ==
=GtRy
-----END PGP SIGNATURE-----

--irgthj4ae4qu4cp3--
