Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6C2F20EC
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 21:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbhAKUgV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 15:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbhAKUgV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 15:36:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD69C0617A5
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 12:35:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3uY-0000KK-UG; Mon, 11 Jan 2021 21:35:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3uX-0002Pk-DQ; Mon, 11 Jan 2021 21:35:33 +0100
Date:   Mon, 11 Jan 2021 21:35:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6eqjen7ca3if66k7"
Content-Disposition: inline
In-Reply-To: <X9uYqGboZg5DuEtf@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6eqjen7ca3if66k7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Dec 17, 2020 at 06:43:04PM +0100, Clemens Gruber wrote:
> On Wed, Dec 16, 2020 at 11:00:59PM -0500, Sven Van Asbroeck wrote:
> > On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
> > <clemens.gruber@pqgruber.com> wrote:
> > >
> > > Implements .get_state to read-out the current hardware state.
> > >
> >=20
> > I am not convinced that we actually need this.
> >=20
> > Looking at the pwm core, .get_state() is only called right after .reque=
st(),
> > to initialize the cached value of the state. The core then uses the cac=
hed
> > value throughout, it'll never read out the h/w again, until the next .r=
equest().
> >=20
> > In our case, we know that the state right after request is always disab=
led,
> > because:
> > - we disable all pwm channels on probe (in PATCH v5 4/7)
> > - .free() disables the pwm channel
> >=20
> > Conclusion: .get_state() will always return "pwm disabled", so why do we
> > bother reading out the h/w?
>=20
> If there are no plans for the PWM core to call .get_state more often in
> the future, we could just read out the period and return 0 duty and
> disabled.
>=20
> Thierry, Uwe, what's your take on this?

I have some plans here. In the past I tried to implement them (see
commit 01ccf903edd65f6421612321648fa5a7f4b7cb10), but this failed
(commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3).

> > Of course, if we choose to leave the pwm enabled after .free(), then
> > .get_state() can even be left out! Do we want that? Genuine question, I=
 do
> > not know the answer.
>=20
> I do not think we should leave it enabled after free. It is less
> complicated if we know that unrequested channels are not in use.

My position here is: A consumer should disable a PWM before calling
pwm_put. The driver should however not enforce this and so should not
modify the hardware state in .free().

Also .probe should not change the PWM configuration.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6eqjen7ca3if66k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8tpEACgkQwfwUeK3K
7AkRsQgAnCkcI6CD5+4yHEP53z9NOpLtG4hjX8K48a1FshFpnfbrkYfebDxyIgD5
9Xd2rm8WrSoCfxK+WC6cwNCQwy0jWtFzYtI1LGZ2sD5hPwY/r0ageTnCwuI6I2HE
IJTZC0UG3t+Q4+e+rJozzwv413tiULPN1fjp28m043+blBSmBEjsiAS2+75vCQ2U
nYp9LhbXPUo5RzkQLDfbDTC4UkAWp6u5jqV7r6K43ybt/dHXGGojADaVuEUuKhAF
Yzo8WRNQ2/+LN8wGSkwI/4GSDaji69c4lzr8ZVKydPy1v5LkqF4HFFui5vtyIChv
yS0Wp+HeYzhHtNhg8Ax6pYKtKZ3uAA==
=9sCU
-----END PGP SIGNATURE-----

--6eqjen7ca3if66k7--
