Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE5E2D2751
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 10:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgLHJSj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 04:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgLHJSi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 04:18:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB002C061793
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 01:17:58 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmZ88-00038m-HV; Tue, 08 Dec 2020 10:17:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmZ87-0000ts-RK; Tue, 08 Dec 2020 10:17:55 +0100
Date:   Tue, 8 Dec 2020 10:17:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201208091755.hzsjrvbvsaeeyu7j@pengutronix.de>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <CAGngYiW6_T8GjLvHrzNk+nUN5L81BwivBTRQ4GofF8LOf1qexA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w7erqnmdibsumirg"
Content-Disposition: inline
In-Reply-To: <CAGngYiW6_T8GjLvHrzNk+nUN5L81BwivBTRQ4GofF8LOf1qexA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--w7erqnmdibsumirg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

On Mon, Dec 07, 2020 at 05:34:58PM -0500, Sven Van Asbroeck wrote:
> On Mon, Dec 7, 2020 at 5:00 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > This is not acceptable, if you have two PWM outputs and a consumer
> > modifies one of them the other must change. So if this chip only
> > supports a single period length of all channels, the first consumer
> > enabling a channel defines the period to be used. All later consumers
> > must live with that. (Also the first must be denied modifying the period
> > if a second consumer has enabled its PWM.)
>=20
> That makes sense. However, a possible wrinkle: when more than one pwm cha=
nnel
> is requested, which one is able to change the period?
>=20
> Example:
> 1. start with all pwms free
> 2. pwm_request(0), pwm_apply(period=3D200Hz)
> 3. pwm_request(1)
> 4. pwm_apply(1, period=3D400Hz) fails?

Yes, pwm_apply_state is supposed to fail here (Sidenote: period
is measured in ns, not Hz)

> 5. pwm_apply(0, period=3D400Hz) succeeds?

This succeeds iff channel 1 isn't enabled. (Unless changing might
change the polarity of pwm #1 even if disabled.)

> And if (5) succeeds, then pwm_get_state(1) will still return period=3D200=
Hz,
> because the pwm core doesn't realize anything has changed. Are you ok
> with this behaviour?

"if (5) succeeds" implies channel 1 is disabled (it might otherwise have
been enabled by the bootloader or a previous consumer).

With that sorted out, I'm ok that pwm_get_state() reports .period=3D200Hz
(or whatever other value) because it also reports .enabled =3D false which
makes every interpretation of the other values in pwm_state (apart from
=2Epolarity) moot.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w7erqnmdibsumirg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/PRMEACgkQwfwUeK3K
7AlKtwf9GTIu54y6Y9y21dtPvGrGeTZoFJW/gPIFrMnM5soegyUzbmttauya0GSW
HZl1Mo5GaFxMjiNLfQmllwCJAQDqt9qOYczcUq8DDdBi0RUK8rO2dFJ5TFfCGhWj
urttYRwEZuUBz9cZnG6CAI2hoSeC7mgn3VY4SDzG9J6AdmsjO/7w4hRBag+q4u8x
wMlR1pMr1dVQxLk6TYUSHOV9ghKfvAjf5V37rIQHmGYI2MO4rqBaQJRjoCgWLQq6
rZI6LNbu6y5wQPSi+ptc5F7pJYQbkMtfHI2F3BQ1938kMU3pUMUh1tOy4XTkw22B
ikfdwZNvbL2JTXh2P7tD72TIOIjQNw==
=a93B
-----END PGP SIGNATURE-----

--w7erqnmdibsumirg--
