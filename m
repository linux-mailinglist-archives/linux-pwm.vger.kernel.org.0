Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CF2146F9
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Jul 2020 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGDPnU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Jul 2020 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgGDPnU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Jul 2020 11:43:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759FCC08C5DE
        for <linux-pwm@vger.kernel.org>; Sat,  4 Jul 2020 08:43:20 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jrkJx-0007Ek-3w; Sat, 04 Jul 2020 17:43:17 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jrkJw-0007cZ-2M; Sat, 04 Jul 2020 17:43:16 +0200
Date:   Sat, 4 Jul 2020 17:43:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200704154313.qjaxtlz62y6kjytj@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
 <CAHp75Vdii+w4nNErG_z_YHwsTYWR9PeJsKk53szk4p-rop-Htw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nbvhjrv6doy6cgjl"
Content-Disposition: inline
In-Reply-To: <CAHp75Vdii+w4nNErG_z_YHwsTYWR9PeJsKk53szk4p-rop-Htw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nbvhjrv6doy6cgjl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 02:23:09PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 3, 2020 at 5:53 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sun, May 03, 2020 at 12:54:53PM +0200, Miquel Raynal wrote:
>=20
> ...
>=20
> > > +     ret =3D regmap_read(pca_chip->regmap, reg, &val);
> > > +     mutex_unlock(&pca_chip->i2c_lock);
> > > +     if (ret < 0) {
> > > +             dev_err(dev, "Cannot retrieve PWM intensity (%d)\n", re=
t);
> >
> > Please use %pe for error codes.
>=20
> %pe is mainly for error pointers, with plain integers it will look
> awkward a bit.

Yeah, the right usage is:

	dev_err(dev, "Cannot retrieve PWM intensity (%pe)\n", ERR_PTR(ret));

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nbvhjrv6doy6cgjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8Ao44ACgkQwfwUeK3K
7AndkAf/VoVfxQww+BvyjBD+Vd05dYxw5ADB0MHirOdCfxKKnri7eYlXBGfEdlCB
/MFlEhNXyr3sKDizZYtutASSaoncUhCRpxPMMWdRLo2B+ABWwbM0g/gWkLOyqDci
RDaMvOYHkYSJrKsj05aDUUFLl3LsJP0Pd6Ie2F7ME1FtmElZ6RUL2+16OMEo1Mtu
pEKjKy3ekggM4K94GtzboiFOPqf3OtExBCXnsNs8dZ0khSZVQXlrAQnd1WkKQRP8
/i3VZ1Ak0RNWPJkC4zX3OcQC9j4BsvXFmlHpN8raGXhFqkhJlXL10+fYuZLdyN24
z5XiVw9YzHcxhofr+108N7KU3Emt4A==
=neRI
-----END PGP SIGNATURE-----

--nbvhjrv6doy6cgjl--
