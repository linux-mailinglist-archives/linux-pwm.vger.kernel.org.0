Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F58344023
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCVLs5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhCVLsa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:48:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98971C061756
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:48:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOJ2p-000161-16; Mon, 22 Mar 2021 12:48:27 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOJ2o-0002Vt-LM; Mon, 22 Mar 2021 12:48:26 +0100
Date:   Mon, 22 Mar 2021 12:48:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210322114826.ahwhbqxjxfg3nmrf@pengutronix.de>
References: <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
 <YFhhGpiHDELxIo9V@orome.fritz.box>
 <CAHp75Ve2FFEMsAv8S18bUDFsH2UkiQ5UvgcRtZ=j30syQtEirw@mail.gmail.com>
 <20210322112254.5mjkajkq3wnhgnd5@pengutronix.de>
 <CAHp75VfedZyFF46koLOg13t_TzMbwj5zBYU2zBA52vRRtb202g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5irkqxzmkpzjow3i"
Content-Disposition: inline
In-Reply-To: <CAHp75VfedZyFF46koLOg13t_TzMbwj5zBYU2zBA52vRRtb202g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5irkqxzmkpzjow3i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 01:40:57PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 1:22 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 22, 2021 at 11:38:40AM +0200, Andy Shevchenko wrote:
> > > On Monday, March 22, 2021, Thierry Reding <thierry.reding@gmail.com> =
wrote:
> > > > On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> > > > > Thierry: Would you accept it if we continue to reset the register=
s in
> > > > > .probe?
> > > >
> > > > Yes, I think it's fine to continue to reset the registers since tha=
t's
> > > > basically what the driver already does. It'd be great if you could
> > > > follow up with a patch that removes the reset and leaves the hardwa=
re in
> > > > whatever state the bootloader has set up. Then we can take that pat=
ch
> > > > for a ride and see if there are any complains about it breaking. If
> > > > there are we can always try to fix them, but as a last resort we can
> > > > also revert, which then may be something we have to live with. But I
> > > > think we should at least try to make this consistent with how other
> > > > drivers do this so that people don't stumble over this particular
> > > > driver's
> > >
> > > I guess we may miss (a PCB / silicon design flaw or warm boot case) w=
hen
> > > boot loader left device completely untouched and device either in wro=
ng
> > > state because if failed reset (saw this on PCA9555 which has a
> > > corresponding errata), or simply we have done a warm reset of the sys=
tem.
> > > So, we also have to understand how to properly exit.
> >
> > I don't think that not resetting is a real problem. My argumentation
> > goes as follows:
> >
> > When the PWM driver is loaded and the PWM configuration is invalid, it
> > was already invalid for the time between power up (or warm start) and
> > PWM driver load time. Then it doesn't really hurt to keep the PWM
> > in this invalid state for a little moment longer until the consumer of
> > the PWM becomes active.
>=20
> But this won't work in the cases when we have a chip with a shared
> settings for period and/or duty cycle. You will never have a user come
> due to -EBUSY.

That's wrong, the first consumer to enable the PWM (in software) is
supposed to be able to change the settings.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5irkqxzmkpzjow3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYhAcACgkQwfwUeK3K
7Al+/gf+KpevRNoTs82vxuWQJH4jxHJSMxSLY+TsNTxPSRog+bTjOsA7aR0tHs/S
FyX4mIVRSkD1Gq+0j9Te/C1t7W/q5cHik4gwb3WXQ0Pez02viyy8R6JbAOOjonmL
mILr0rg77htKLxgb8MXY1QVrsNuqe5tt3npHpW4FCooSrqm0B6M2D5KW53chxoyu
f7f5uT3cv8VS1ScstW11FjuTcrWeO3V5w653lA1YScp8LHAp52FFSWh30Um8Pe82
W3PRd0XUbjnrmMWz386ficKkRplWm9TyGGdc8pTBaTiu+NZT6q1ZO08cLlS343j/
Kf3wCXQOxiEfbSQ/Te0hPEoP7sliOw==
=Ljaj
-----END PGP SIGNATURE-----

--5irkqxzmkpzjow3i--
