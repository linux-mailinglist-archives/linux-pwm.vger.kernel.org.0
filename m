Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3212D33CC
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 21:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgLHU0M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgLHU0L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 15:26:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6D1C061793
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 12:25:31 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmjY7-0002vi-U3; Tue, 08 Dec 2020 21:25:27 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmjY6-0001Ng-BT; Tue, 08 Dec 2020 21:25:26 +0100
Date:   Tue, 8 Dec 2020 21:25:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201208202526.va32uvkf6rm57a4w@pengutronix.de>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <CAGngYiUP7BBF4i8YFXREA291dBTc4JytAFV9AoSjzMYTW7MyjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="trm6j6bfjek6aps6"
Content-Disposition: inline
In-Reply-To: <CAGngYiUP7BBF4i8YFXREA291dBTc4JytAFV9AoSjzMYTW7MyjQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--trm6j6bfjek6aps6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

On Tue, Dec 08, 2020 at 01:15:10PM -0500, Sven Van Asbroeck wrote:
> On Tue, Dec 8, 2020 at 11:57 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > Is this really that complicated? I sounds to me like the only thing that
> > you need is to have some sort of usage count for the prescaler. Whenever
> > you want to use the prescaler you check that usage count. If it is zero,
> > then you can just set it to whatever you need. If it isn't zero, that
> > means somebody else is already using it and you can't change it, which
> > means you have to check if you're trying to request the value that's
> > already set. If so, you can succeed, but otherwise you'll have to fail.
>=20
> +1
> I think your suggestion is an elegant solution to get the required behavi=
our.
>=20
> One possible complication is synchronization. The sysfs interface has a l=
ock
> protecting against concurrent pwm_apply() calls. But the in-kernel
> API (e.g. pwm_apply_state()) doesn't seem to. This is not normally a prob=
lem
> when pwm bits are strictly separated. But in this case we have shared sta=
te
> (prescale value and use count), so we probably need to protect pwm_apply()
> with a mutex?

Right, you need a lock. You can look at pwm-imx-tpm.c which has a
similar limitation.
=20
> Not sure if it is currently possible *in practice* for two regulator cons=
umer
> drivers to call pwm_apply() from different threads. But Linux is slowly m=
oving
> towards asynchronous probing.

You must assume that there is concurrent access to different channels of
your hardware.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--trm6j6bfjek6aps6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/P4TMACgkQwfwUeK3K
7AlTvgf/YzgLsmgqn/aeT3CHsBXjedswCXVjC++3uWlBId74+cm5WqS+KkXvOD/z
W29RHU3w5rBFZeZMGGwGK2X7gVR55v7BSZ59ajVC9FIQb8vMZcgNi7PpINkVdJfu
BUgTmlm61uyvjt4/21srn1Vq6DY1yqWaClzlGrzy8nK0x14YRE+HayqUF8oxpnYT
JaAJTcrCtu9R2VMmrpikwLjEonux9eza7gTYku04lKHC3nERn8yoOPRr0ebmqNO7
6Ar/B0OclhWlfjzMu+UwZ5zPUzbX/U/HVVA8hlJ8qWb5z/KaafGd2bWiZ6PjyEc+
Mk34wiTinz15tKY56ELRQSfkEheKEQ==
=q7Tk
-----END PGP SIGNATURE-----

--trm6j6bfjek6aps6--
