Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C241934D687
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 20:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhC2SCR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhC2SCK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 14:02:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A6AC061574
        for <linux-pwm@vger.kernel.org>; Mon, 29 Mar 2021 11:02:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQwDH-0004Gs-73; Mon, 29 Mar 2021 20:02:07 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQwDG-0001XY-IO; Mon, 29 Mar 2021 20:02:06 +0200
Date:   Mon, 29 Mar 2021 20:02:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <20210329180206.rejl32uajslpvbgi@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="noem5j55dbfdgb7z"
Content-Disposition: inline
In-Reply-To: <YGILdjZBCc2vVlRd@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--noem5j55dbfdgb7z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > The PCA9685 supports staggered LED output ON times to minimize current
> > > surges and reduce EMI.
> > > When this new option is enabled, the ON times of each channel are
> > > delayed by channel number x counter range / 16, which avoids asserting
> > > all enabled outputs at the same counter value while still maintaining
> > > the configured duty cycle of each output.
> > >=20
> > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> >=20
> > Is there a reason to not want this staggered output? If it never hurts I
> > suggest to always stagger and drop the dt property.
>=20
> There might be applications where you want multiple outputs to assert at
> the same time / to be synchronized.
> With staggered outputs mode always enabled, this would no longer be
> possible as they are spread out according to their channel number.
>=20
> Not sure how often that usecase is required, but just enforcing the
> staggered mode by default sounds risky to me.

There is no such guarantee in the PWM framework, so I don't think we
need to fear breaking setups. Thierry?

One reason we might not want staggering is if we have a consumer who
cares about config transitions. (This however is moot it the hardware
doesn't provide sane transitions even without staggering.)

Did I already ask about races in this driver? I assume there is a
free running counter and the ON and OFF registers just define where in
the period the transitions happen, right? Given that changing ON and OFF
needs two register writes probably all kind of strange things can
happen, right? (Example thought: for simplicity's sake I assume ON is
always 0. Then if you want to change from OFF =3D 0xaaa to OFF =3D 0xccc we
might see a period with 0xacc. Depending on how the hardware works we
might even see 4 edges in a single period then.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--noem5j55dbfdgb7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBiFhoACgkQwfwUeK3K
7AmvxQf+Kp1rfako1h3M55rltPehAc3AA2Mm7QgxbFli1DO8l1yv/rHyDhoWqVGW
OnGEYoCJvn3mvjJVWPHgnjwFQBoHDgsrClihzVNX+2oqM9arkRnDbZ3QE6QnBIBI
eGo+kSSfsQIv7uUEyL2m2CuHivqDIGsS8khw6LdoTHzvp13vK/ICGm5zVKiRBkE2
bFSrKsuBn89LN+uYjULYcDs0nWtd61ah6ULENwttDvihVedCK55JxkFxLNUg5XRS
0SYZBvuTwjQeepWttbVCiLtpHL+dbc39ZYNQcSo7G7lS1bgj2WGTVVdb+x5xuAeC
jJwGG+TgKT6QA9h41S/8Y9lzUyWT1w==
=QR6o
-----END PGP SIGNATURE-----

--noem5j55dbfdgb7z--
