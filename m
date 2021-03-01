Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A976932944E
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 22:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhCAVzv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 16:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244605AbhCAVxd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 16:53:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92313C06178B
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 13:52:52 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqTA-0003uP-Ul; Mon, 01 Mar 2021 22:52:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqTA-0000yM-Aq; Mon, 01 Mar 2021 22:52:48 +0100
Date:   Mon, 1 Mar 2021 22:52:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210301215248.ekclgxc7dq6asdz5@pengutronix.de>
References: <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
 <CAGngYiXxfz7rtsw4zSj5QX7Lj7hvnoESqyUE_2__=oDaRmGGJQ@mail.gmail.com>
 <CAGngYiV5GGJvHTwG7k6mv76uR1RLnHOJoO8+d2ofiZAQi3K0BA@mail.gmail.com>
 <YBg5MlvJQ0N2u+j6@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj4wfq3selp6pd7x"
Content-Disposition: inline
In-Reply-To: <YBg5MlvJQ0N2u+j6@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gj4wfq3selp6pd7x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 01, 2021 at 06:24:02PM +0100, Clemens Gruber wrote:
> Hi Sven, Thierry, Uwe,
>=20
> On Fri, Jan 29, 2021 at 05:16:51PM -0500, Sven Van Asbroeck wrote:
> > Hi Clemens,
> >=20
> > On Fri, Jan 29, 2021 at 4:24 PM Sven Van Asbroeck <thesven73@gmail.com>=
 wrote:
> > >
> > > LEN_ON =3D 409, LED_OFF =3D 1228 and
> > > LED_ON =3D 419, LED_OFF =3D 1238
> > > produce the same result. you can't see the difference between the two
> > > when scoping the channel. there are probably more ways to do this,
> > > some might surprise us. It's a tricky chip.
> >=20
> > Please ignore this example, it's bogus. In my defence, it's a Friday
> > afternoon here :)
>=20
> Happens to the best of us :)
>=20
> >=20
> > But consider the following: imagine the bootloader has enabled a few
> > pwm channels, and the driver's .probe() has left them on/unchanged.
> > Then the user enables another pwm channel, and tries to change the
> > period/prescaler. How would pca9685_may_change_prescaler() know
> > if changing the prescaler is allowed?
> >=20
> > And the following: imagine the bootloader has enabled a few
> > pwm channels, and the driver's .probe() has left them on/unchanged.
> > After .probe(), the runtime_pm will immediately put the chip to sleep,
> > because it's unaware that some channels are alive.
>=20
> (We could read out the state in .probe. If a pwm is already enabled by
> the bootloader, then the user can't change the period. Also, the chip
> would not be put to sleep.
>=20
> The user then can export channels and see if they are enabled. If he
> wants to change the period, he needs to find the one enabled by the
> bootloader and change the period there, before he requests more.
> If the bootloader enabled more than one, then he has to disable all but
> one to change the period.
>=20
> Or did I miss something?)
>=20
> >=20
> > I'm sure I'm overlooking a few complications here. probe not changing
> > the existing configuration, will add a lot of complexity to the driver.
> > I'm not saying this is necessarily bad, just a tradeoff. Or, a manageme=
nt
> > decision.
>=20
> But I agree that it is simpler if we keep the resets in probe. It would
> also avoid a potentially breaking change for users that do not reset
> their pca9685 chips in their bootloader code.

I would prefer to drop the reset. If the bootloader left with an invalid
state, this is active for sure until the PWM driver is loaded. If you
don't reset, the time is extended (usually) until the consumer comes
along and corrects the setting. So the downside of not resetting is
quite limited, but if you disable the PWM in .probe() the effect can be
worse. And consistency dictates to not reset.

> Removing the resets could then be left as something to discuss further
> in the future and something that belongs in a separate patch series?

That would be fine for me, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gj4wfq3selp6pd7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA9YiwACgkQwfwUeK3K
7AlgXwgAnzhuKRCBTL0mE5C8Cm2uGnKevigkpVEBf8j4eBCtBhp4/q5+3Gk6B1U+
8ejxoyhnYh29dsZH5xHY/ud28aV1u3F6IP7TDRc/crSxR2JDWTa+2EqDnEI6/k9G
eLdd1zwGJ/kM7A55JKz/fsIFy5ttO2m6Chno76A7btGGGxfPzsSMktszIiM8Q06z
adB13RWo5H8eHIfnEox/2/s7KYDpHpRXAJEwKVXjezIsw6QqYEosV8L0u+LxGPSy
0EA+J1lrMfmb+Z1wqIy+orgCV6UIbseTqfauisL/JKuNf0iPa7mA2fpwuxJRM53D
G8bHpMRHJjDqnnEBe4739grlLK+Xvw==
=fR4v
-----END PGP SIGNATURE-----

--gj4wfq3selp6pd7x--
