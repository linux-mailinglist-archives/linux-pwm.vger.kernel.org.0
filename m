Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4593C40F33E
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Sep 2021 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhIQH3Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Sep 2021 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbhIQH3X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Sep 2021 03:29:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54BC0613C1
        for <linux-pwm@vger.kernel.org>; Fri, 17 Sep 2021 00:28:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR8Ht-0006D4-G5; Fri, 17 Sep 2021 09:27:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR8Hr-0006Xr-8F; Fri, 17 Sep 2021 09:27:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mR8Hr-0004PR-6m; Fri, 17 Sep 2021 09:27:55 +0200
Date:   Fri, 17 Sep 2021 09:27:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [RFC PATCH v1 07/20] gpio: Add output event generation method to
 GPIOLIB and PMC Driver
Message-ID: <20210917072755.d4ynxkp4scxrk6rq@pengutronix.de>
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com>
 <20210824164801.28896-8-lakshmi.sowjanya.d@intel.com>
 <CACRpkdYJkPgaz-BvQ1X0PHRCCbn0hrMDabouDwHkn+pr9d-dSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="riqk2pxwp7ut5zxn"
Content-Disposition: inline
In-Reply-To: <CACRpkdYJkPgaz-BvQ1X0PHRCCbn0hrMDabouDwHkn+pr9d-dSQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--riqk2pxwp7ut5zxn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 16, 2021 at 11:42:04PM +0200, Linus Walleij wrote:
> Hi Lakshmi,
>=20
> On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrote:
>=20
> > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> >
> > Intel Timed I/O hardware supports output scheduled in hardware. Enable
> > this functionality using GPIOlib
> >
> > Adds GPIOlib generate_output() hook into the driver. The driver is
> > supplied with a timestamp in terms of realtime system clock (the same
> > used for input timestamping). The driver must know how to translate this
> > into a timebase meaningful for the hardware.
> >
> > Adds userspace write() interface. Output can be selected using the line
> > event create ioctl. The write() interface takes a single timestamp
> > event request parameter. An output edge rising or falling is generated
> > for each event request.
> >
> > The user application supplies a trigger time in terms of the realtime
> > clock the driver converts this into the corresponding ART clock value
> > that is used to 'arm' the output.
> >
> > Work around device quirk that doesn't allow the output to be explicitly
> > set. Instead, count the output edges and insert an additional edge as
> > needed to reset the output to zero.
> >
> > Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
> > Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> > Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> > Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
>=20
> So this is some street organ machine that generates sequences
> with determined timing between positive and negative edges
> right?
>=20
> I can't see how this hardware is different from a PWM, or well
> I do to some extent, you can control the period of several
> subsequent waves, but that is really just an elaborate version
> of PWM in my book.

=46rom looking in the patch I think this is more versatile than the PWM
framework abstracts. I wonder if there is a usecase for the
functionality that cannot be expressed using pwm_apply_state?!

I remember we had approaches before that implemented repeating patterns
(something like: active for 5ms, inactive for 10 ms, active for 30 ms,
inactive for 10 ms, repeat) and limiting the number of periods
(something like: .duty_cycle =3D 5ms, .period =3D 20ms, after 5 periods go
into inactive state). These were considered to be too special to be
abstracted in drivers/pwm.

> It seems to me that this part of the functionality belongs in the
> PWM subsystem which already has interfaces for similar
> things, and you should probably extend PWM to handle
> random waveforms rather than trying to shoehorn this
> into the GPIO subsystem.

I agree that GPIO is a worse candidate than PWM to abstract that. But
I'm not convinced (yet?) that it's a good idea to extend PWM
accordingly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--riqk2pxwp7ut5zxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFEQ3cACgkQwfwUeK3K
7AnLYQf9GjzSXlKt9YzS04WE2zmEQ28c5pFcvP2AuC1KNzcI+jIIAdp5e4IUltNL
U9n1Ghs7cUbiHNelhrSfCD3RYZU2uDJ8zyFa5gbQU2CYnNbDzQghefSWphfepB3s
XABiqd7KSB8nV7ozZJjnA0Df8XDmPvZ7hJ7nOU3Fp19wW0qm28KJ+Dmof+8EzRf2
kd3QMMdzFZaHvMt14T5uYr205VdwYhZBVntnqNHoXBVMFGkwPhCx18fzZ+5LXBTW
KcpveBgQPV7U2y9oXpGH7gsi85SfmpBQ+BCaDmSvfNQ6CXfBmClBFV1fUKfHxKsi
AqZ/iyU9HybkRXEYZfJM6NnL4iE3Vw==
=s0o9
-----END PGP SIGNATURE-----

--riqk2pxwp7ut5zxn--
