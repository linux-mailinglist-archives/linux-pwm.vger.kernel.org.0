Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC52304AA
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 09:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgG1HxI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgG1HxI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 03:53:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14CC0619D2
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 00:53:08 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0KPz-0000Xc-1D; Tue, 28 Jul 2020 09:52:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0KPx-0005ju-OS; Tue, 28 Jul 2020 09:52:57 +0200
Date:   Tue, 28 Jul 2020 09:52:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH RCC 1/6] pwm: Add different PWM output types support
Message-ID: <20200728075257.efhsju2odehpbv6f@pengutronix.de>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-2-martin.botka1@gmail.com>
 <20200727201034.dkc6qkkbte6qeiba@pengutronix.de>
 <CADQ2G_GxpWk1AK4OQPZZuk=vCmostC4vEGSHjj01WMzFxpD7CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffexrllbpegueh2g"
Content-Disposition: inline
In-Reply-To: <CADQ2G_GxpWk1AK4OQPZZuk=vCmostC4vEGSHjj01WMzFxpD7CA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ffexrllbpegueh2g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Mon, Jul 27, 2020 at 10:56:31PM +0200, Martin Botka wrote:
> Mo 27. 7. 2020 at 22:10 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.d=
e> wrote:
> > On Fri, Jul 24, 2020 at 11:36:51PM +0200, Martin Botka wrote:
> > > +/*
> > > + * pwm_output_type_support()
> > > + * @pwm: PWM device
> > > + *
> > > + * Returns:  output types supported by the PWM device
> > > + */
> > > +static inline int pwm_get_output_type_supported(struct pwm_device *p=
wm)
> > > +{
> > > +     if (pwm->chip->ops->get_output_type_supported !=3D NULL)
> > > +             return pwm->chip->ops->get_output_type_supported(pwm->c=
hip, pwm);
> > > +     else
> > > +             return PWM_OUTPUT_FIXED;
> > > +}
> >
> > I don't like this "advertising" for specific functions. I'd prefer to
> > handle this in .apply(), fix all drivers to return -ESOMETHING when the
> > request cannot be fulfilled.
>=20
> I will have to disagree on this one. As the functions are called in
> multiple places it would just make mess in the driver.

Note this is something where (I think) I don't agree with Thierry
either. This popped up just yesterday, see

	https://www.spinics.net/lists/linux-pwm/msg13290.html

For sure I want at most one such function per driver, so if we really
want to go this path and introduce a capability indicator, this should
be named differently and have a different prototype.

> As the driver is even now not exactly the definition of clean driver i
> would not like to make it even more messy.

> > Having said that I wonder if this output pattern is a common enough
> > property to add support for it in the PWM framework.
> >
>=20
> I have gotten an email from Guru Das Srinagesh regarding this exact
> issue you are pointing to. Yes the output pattern will be dropped in
> V2.

That's good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ffexrllbpegueh2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8f2VYACgkQwfwUeK3K
7Alnywf/SIGQWkLjR0aBwi+oKzPM6FMrSXE1VRXH1Z3ME+VOpYebHm6ovqTZzC7k
Ipjlp6pBDOdTr9Ul9WM0m/4S0hIyhy5uFoWVz/hyYiWJZI5ap/6uJejptxkhFM5c
HXtbKDII0lsA7PtRD/eOkxLyyQpsTpCVTcGHfd0JXMMAcSFaKRQNhxzhi+opTU9A
1MUL2cAqOucGsvi/H6prnAMSK5fE7Q2AW+LFr5o4/csFSETILkghWqnI13jSJde9
KTDWojmDkOyrZeV7uK0A4QgkJdivbgt1H1mRVPKbjvQkYc771OgGfclOD6b2WG16
3mFFN+NWq8PKvHunB/GRzRRI5uw8CA==
=VgSE
-----END PGP SIGNATURE-----

--ffexrllbpegueh2g--
