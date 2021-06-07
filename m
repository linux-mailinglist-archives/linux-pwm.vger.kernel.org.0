Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B453A39D91D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 11:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGJzX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 05:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhFGJzW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 05:55:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6CC061766
        for <linux-pwm@vger.kernel.org>; Mon,  7 Jun 2021 02:53:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqBwk-0001fz-Bq; Mon, 07 Jun 2021 11:53:26 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqBwi-0002NJ-UK; Mon, 07 Jun 2021 11:53:24 +0200
Date:   Mon, 7 Jun 2021 11:53:24 +0200
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
Message-ID: <20210607095324.yaiu5lzb5zgoejpa@pengutronix.de>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
 <20210531194947.10770-2-andriy.shevchenko@linux.intel.com>
 <20210606213054.bmqgs5hehbowa62d@pengutronix.de>
 <YL3grTQ00lFCXyCp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lb55oeagrspejzv"
Content-Disposition: inline
In-Reply-To: <YL3grTQ00lFCXyCp@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7lb55oeagrspejzv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Jun 07, 2021 at 12:02:37PM +0300, Andy Shevchenko wrote:
> On Sun, Jun 06, 2021 at 11:30:54PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Andy,
> >=20
> > On Mon, May 31, 2021 at 10:49:42PM +0300, Andy Shevchenko wrote:
> > > It makes little sense to make PWM flags optional since in case
> > > of multi-channel consumer the flags can be optional only for
> > > the last listed channel.
> >=20
> > I think the same holds true for dt references.
>=20
> Can you elaborate this? I haven't got what you are talking about, not a DT
> expert here.

Ah no, I mixed that up. While the function that parses the phandle is
flexible, for each pwm controller the number of arguments is fixed, so

	pwms =3D <&pwm1 100000 &pwm2 100000 &pwm3 1000000>;

cannot be interpreted as 3-argument references to two PWMs. This is
different to ACPI (I guess, not an ACPI expert here :-) because &pwm1
"knows" if it needs 1 or 2 additional parameters (#pwm-cells).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7lb55oeagrspejzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC97JEACgkQwfwUeK3K
7AkwKQf+Kr/v7TNGd1OK/MPsBBPYrJH4xu32gFZWqyOCnbPWtE7R9FU+0QqL1gWC
PN9HUKjc7ZHA+RAuIHxYKXdIHs5iR+h+zsGKz7XoMfm1fWD5BSifVFufQ9oovkpb
X/64tcxzMbeKLsoG5OhQCPu4iuGVZtXai0qUkjoqs8T29uGVYeIT/OPdRJKv1BzB
lajYqO4c1wmIVc1nQmSy8NARMLtX4K74Fqr76JB/rmkNahZAEgYG5p18jX7H48g6
miNFSsw3ZEHlNaPu1IrG6IMj4xuTP+LX9ayhsUKuCaA3qBCbf86mRXibx3D/El28
ubw/MUJDPyXTYvMaW+stj2mVkp9PfA==
=Wle7
-----END PGP SIGNATURE-----

--7lb55oeagrspejzv--
