Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4741539DE63
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFGONZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 10:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFGONZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 10:13:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B3C061766
        for <linux-pwm@vger.kernel.org>; Mon,  7 Jun 2021 07:11:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqFyS-0004K4-3e; Mon, 07 Jun 2021 16:11:28 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqFyH-0003VO-7M; Mon, 07 Jun 2021 16:11:17 +0200
Date:   Mon, 7 Jun 2021 16:11:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/7] pwm: core: Always require PWM flags to be provided
Message-ID: <20210607141117.24bvqiafy4cndoj4@pengutronix.de>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
 <20210531194947.10770-2-andriy.shevchenko@linux.intel.com>
 <20210606213054.bmqgs5hehbowa62d@pengutronix.de>
 <YL3grTQ00lFCXyCp@smile.fi.intel.com>
 <20210607095324.yaiu5lzb5zgoejpa@pengutronix.de>
 <YL3xuJyAcbPLW7yG@smile.fi.intel.com>
 <YL3zDUWsY9mUW0eQ@smile.fi.intel.com>
 <YL4HrZTb+fmW4UTf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zdgor72n6fpmyvqy"
Content-Disposition: inline
In-Reply-To: <YL4HrZTb+fmW4UTf@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zdgor72n6fpmyvqy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Jun 07, 2021 at 02:49:01PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 07, 2021 at 01:21:01PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 07, 2021 at 01:15:20PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 07, 2021 at 11:53:24AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Jun 07, 2021 at 12:02:37PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, Jun 06, 2021 at 11:30:54PM +0200, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > On Mon, May 31, 2021 at 10:49:42PM +0300, Andy Shevchenko wrote:
> > > > > > > It makes little sense to make PWM flags optional since in case
> > > > > > > of multi-channel consumer the flags can be optional only for
> > > > > > > the last listed channel.
> > > > > >=20
> > > > > > I think the same holds true for dt references.
> > > > >=20
> > > > > Can you elaborate this? I haven't got what you are talking about,=
 not a DT
> > > > > expert here.
> > > >=20
> > > > Ah no, I mixed that up. While the function that parses the phandle =
is
> > > > flexible, for each pwm controller the number of arguments is fixed,=
 so
> > > >=20
> > > > 	pwms =3D <&pwm1 100000 &pwm2 100000 &pwm3 1000000>;
> > > >=20
> > > > cannot be interpreted as 3-argument references to two PWMs. This is
> > > > different to ACPI (I guess, not an ACPI expert here :-) because &pw=
m1
> > > > "knows" if it needs 1 or 2 additional parameters (#pwm-cells).
> > >=20
> > > It's not about ACPI, it's about "the ACPI glue layer in Linux kernel".
> > > Used API is a part of it and it does allow only two cases, either NUL=
L entry
> > > (by having 0 as an argument) or full-length supplied tuple (in case o=
f PWM it's
> > > 3, so, means 4 parameters.
> > >=20
> > > Let's consider examples:
> > >=20
> > > (0, 0, x3, y3, z3, t3) // NULL, NULL, PWM3
> > > (x1, y1, z1, t1, 0, x3, y3, z3, t3) // PWM1, NULL, PWM3
> > >=20
> > > So, making last parameter "flexible" will work only for the last tupl=
e in the
> > > array.
> > >=20
> > > Read this [1] for further information.
> > >=20
> > > [1]: https://elixir.bootlin.com/linux/latest/source/drivers/acpi/prop=
erty.c#L629
> >=20
> > Hmm... I have read the actual implementation and it seems it's possible=
 to have
> > flexible array, so this patch needs to be reconsidered.
>=20
> I was thinking more about it and what we have here is positional-dependent
> arguments. Either way we might end up in the same situation (when we need=
 to
> parse arguments based on their positions, rather than always have them be=
ing
> present). So, while I won't change documentation example (to be more stri=
cter
> there), I will drop this change.
>=20
> Also, the PWM initial state doesn't include duty cycle. Any explanations =
why is
> that?

This isn't technically the initial state. It's a hint to the consumer
which period to pick. The duty-cycle is usually variable, but if I
designed the binding today I would not include the period in the pwm
handle. But to discuss this is moot---the binding is as it is.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zdgor72n6fpmyvqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC+KQEACgkQwfwUeK3K
7AmoCgf7BALxWbL2VI8+acrc4CorcueM4VAe+cJtBXASfcqn/W4hS39ZwYumlJpX
EGyOfnnV73WcPqD63fUTAtKvdoTAuXQd/7ziOw4AzQZmx1UaX/tXtvSgJ5Nx8Pq1
U22dLPoIHLw8oTrWx0s58iz9a9fSGjUufUf/ZqAVlDToDSKKvvWrDTn5IYp3OwFk
kTh9+MRaqMoS8tR+IMwU4VGngj4aZMzytgguuDCxKGRP8OB5HWoj/yxRuCNbmvMM
EbLVzs+VE/nRCNA/smqzpTiG6KX2vywcHgyRbgqCRy5COvAO/sZj4tHEyAORCBFW
hUPFmkPha4xmcoS/UVZYqLzd0EH3VA==
=AzX/
-----END PGP SIGNATURE-----

--zdgor72n6fpmyvqy--
