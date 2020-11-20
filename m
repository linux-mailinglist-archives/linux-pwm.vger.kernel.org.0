Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD75E2BAA6F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Nov 2020 13:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKTMsW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Nov 2020 07:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgKTMsW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Nov 2020 07:48:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81DC0613CF
        for <linux-pwm@vger.kernel.org>; Fri, 20 Nov 2020 04:48:22 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kg5pr-0001b9-BC; Fri, 20 Nov 2020 13:48:19 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kg5pq-0002rg-Gt; Fri, 20 Nov 2020 13:48:18 +0100
Date:   Fri, 20 Nov 2020 13:48:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: pca9685: Add staggered-outputs property
Message-ID: <20201120124816.2ncbm75v4c5xrtw3@pengutronix.de>
References: <20201118174515.278067-1-clemens.gruber@pqgruber.com>
 <20201120082150.kyihkhphph7wosfz@pengutronix.de>
 <X7e4Zj1yejjLBFyl@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wdptpb2gnz4jdjdu"
Content-Disposition: inline
In-Reply-To: <X7e4Zj1yejjLBFyl@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wdptpb2gnz4jdjdu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 01:36:54PM +0100, Clemens Gruber wrote:
> Hi,
>=20
> On Fri, Nov 20, 2020 at 09:21:50AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Nov 18, 2020 at 06:45:15PM +0100, Clemens Gruber wrote:
> > > The pca9685 driver supports a new staggered-outputs property for redu=
ced
> > > current surges and EMI. This adds documentation for the new DT proper=
ty.
> >=20
> > Maybe point out the commit that added this support here?
>=20
> The pca9685 driver patch was not yet accepted and there will be a v2.
>=20
> Should I wait until the support is in Linus' tree and only then send a
> dt-bindings documentation patch, mentioning the commit?

Then I'd say add the dt-bindings patch to the series adding this
support.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wdptpb2gnz4jdjdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+3uw4ACgkQwfwUeK3K
7Ak15Qf8D7HdXIO7UJ0QM2vt3GNUwmc4Lfee5+zCkePW/6oohnPJD7RQCN+3/aOX
lqudlv0NVgCsm0DkcHVtrYxl6VTf5Ot1gHx+TGGJp04YAU/b9gNvGUm+AyYsHIbX
c1JHSjBBhWxOx8aFAZFCGqkiFAjg/H+o89beJgKz0aQq3Ii2sp7OUdXXioC/2N8f
YYb253k0WYEzaI9N8PEnAAvS7RQ2DkG5XiaOgpmDcPorqL6iltJ4JSD4eznAZaJp
Mdaow35DVFruvBfRRuns5TjOM7zkJQCZ/5gOyXGZ50wEjzvpEqrqFT9kQLyZxQDD
EK5+hK9X5h8ktRUKcsq0MXTtC6h/Zw==
=KXOK
-----END PGP SIGNATURE-----

--wdptpb2gnz4jdjdu--
