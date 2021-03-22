Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1B343F95
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCVLXe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhCVLXA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:23:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF6DC061756
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:22:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIe7-0005k5-35; Mon, 22 Mar 2021 12:22:55 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOIe6-0000RO-C9; Mon, 22 Mar 2021 12:22:54 +0100
Date:   Mon, 22 Mar 2021 12:22:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210322112254.5mjkajkq3wnhgnd5@pengutronix.de>
References: <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
 <YFhhGpiHDELxIo9V@orome.fritz.box>
 <CAHp75Ve2FFEMsAv8S18bUDFsH2UkiQ5UvgcRtZ=j30syQtEirw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uuestpxaqacueghg"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve2FFEMsAv8S18bUDFsH2UkiQ5UvgcRtZ=j30syQtEirw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--uuestpxaqacueghg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Mar 22, 2021 at 11:38:40AM +0200, Andy Shevchenko wrote:
> On Monday, March 22, 2021, Thierry Reding <thierry.reding@gmail.com> wrot=
e:
> > On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> > > Thierry: Would you accept it if we continue to reset the registers in
> > > .probe?
> >
> > Yes, I think it's fine to continue to reset the registers since that's
> > basically what the driver already does. It'd be great if you could
> > follow up with a patch that removes the reset and leaves the hardware in
> > whatever state the bootloader has set up. Then we can take that patch
> > for a ride and see if there are any complains about it breaking. If
> > there are we can always try to fix them, but as a last resort we can
> > also revert, which then may be something we have to live with. But I
> > think we should at least try to make this consistent with how other
> > drivers do this so that people don't stumble over this particular
> > driver's
>=20
> I guess we may miss (a PCB / silicon design flaw or warm boot case) when
> boot loader left device completely untouched and device either in wrong
> state because if failed reset (saw this on PCA9555 which has a
> corresponding errata), or simply we have done a warm reset of the system.
> So, we also have to understand how to properly exit.

I don't think that not resetting is a real problem. My argumentation
goes as follows:

When the PWM driver is loaded and the PWM configuration is invalid, it
was already invalid for the time between power up (or warm start) and
PWM driver load time. Then it doesn't really hurt to keep the PWM
in this invalid state for a little moment longer until the consumer of
the PWM becomes active.

Together with the use cases where not resetting is the right thing to
do, I'm convinced not resetting is the better strategy.

> Another point, CCF has a bit =E2=80=9Cis critical=E2=80=9D, and u guess P=
WM may get the
> same and make the all assumptions much easier.

So I think complicating the PWM framework for this isn't the right thing
to do.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uuestpxaqacueghg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYfgsACgkQwfwUeK3K
7Amw2ggAlazycDEHuJVy+VGen1qCsUrXixN776gnaT+D4vnJp8F+dMz7ife4F/4+
wWaooH7WYHSA6yQyp95qwbiQZG89gR9fxEtG4zK3gaHttCAIZJUle1sqYQUXrePZ
QvMbXKDKDkFL6WQDpVW0mXPbeIxnZzxSWsgvF17KPQWU2PGg4u/1AiQEntNItcgK
syfM38UJxNncNy1OLKaiVLKu5jZ8xPD6jMJYGGTent4WephNkYv8NKLWZk6/zADC
BTytiuUuBLWIHRABbfu8UpeQZrHdGqQm/gAoz3DMnpRxJiKt9egftHknrpSUCNv9
pHQ3dB1c8achJ8wVsSpzU8gGtn+RpA==
=I+uB
-----END PGP SIGNATURE-----

--uuestpxaqacueghg--
