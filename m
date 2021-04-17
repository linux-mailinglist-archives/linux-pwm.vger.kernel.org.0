Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743BF3630FA
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhDQPop (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbhDQPop (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 11:44:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E81C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 08:44:19 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXn7F-0002qG-SU; Sat, 17 Apr 2021 17:44:13 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXn7F-0006BO-FJ; Sat, 17 Apr 2021 17:44:13 +0200
Date:   Sat, 17 Apr 2021 17:44:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <20210417154413.dk2ayjx4y3vo7mnd@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <YHmXPyf+XjgJs3C8@orome.fritz.box>
 <YHmzNaxMjPJMcPmK@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnu6i5tqpbwo77xn"
Content-Disposition: inline
In-Reply-To: <YHmzNaxMjPJMcPmK@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pnu6i5tqpbwo77xn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 16, 2021 at 05:54:29PM +0200, Clemens Gruber wrote:
> On Fri, Apr 16, 2021 at 03:55:11PM +0200, Thierry Reding wrote:
> > On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> > >=20
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> > >  include/dt-bindings/pwm/pwm.h                 | 1 +
> > >  2 files changed, 4 insertions(+)
> >=20
> > Rob, what are your thoughts on this? I've been thinking about this some
> > more and I'm having second thoughts about putting this into device tree
> > because it doesn't actually describe a property of the PWM hardware but
> > rather a use-case specific hint. It's a bit of a gray area because this
> > is just part of the PWM specifier which already has use-case specific
> > "configuration", such as the period and the polarity.

This is something I'd prefer over making it part of the device tree API.
I still don't think it's a good idea but when we keep it in-kernel we
can at least easier modify it in the future.

> > Perhaps a better place for this is within the PWM API? We could add the
> > same information into struct pwm_state and then consumers that don't
> > care about specifics of the signal (such as pwm-backlight) can set that
> > flag when they request a state to be applied.
>=20
> I just want to note that in my opinion, this is not a flag that is
> changed often, so is it really a good idea to require setting this
> wherever PWM state is applied? Also, this can't be read-out in
> .get_state.

Not being able to read it out isn't a problem in my eyes.

> Thierry: If this discussion carries on and a v10 is required: Could you
> maybe merge the uncontroversial patches 1 to 3 of v9 separately and
> maybe get those in 5.12 ? Patches 4 to 8 can probably wait for 5.13 and
> have some time in linux-next.

I'm ok in getting those into next now and than into the upcoming merge
window. That won't make them part of 5.12 however, but 5.13-rc1. IMHO
patches 7 and 8 can go in, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pnu6i5tqpbwo77xn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7AkoACgkQwfwUeK3K
7AlHjwgAkM6agKrKkVI46Cb6cL1zJJ/NmFQvWDmwGF0c2zE7ODULf+RXWBWsbG6v
cd7mYxS1yikwcyemX2OgLp4y7NHM6PWfgrJkIAn8BeH3BSDP5S70KYKscVyLenfr
+pZvuYKDYD0hsrD2QcL60uhQwbL5B3cHxFtzFT3mNhEpw0u1hbvFp9rQAwQSiro6
MBMy7CMmieTA0r83drbHhXwBNVD4pLj1Glq8FUdyy2GIjVkY3O2qDlUI8L5eNn6u
2JMvDzuLIZ5xZ3tloA3tynWQge98u9yWF0x4s5+997IrR4+NSZ8INpuas+R0LaXl
0PNu0UD9AJIw6dkZyYalGKSLqgAJSw==
=rkie
-----END PGP SIGNATURE-----

--pnu6i5tqpbwo77xn--
