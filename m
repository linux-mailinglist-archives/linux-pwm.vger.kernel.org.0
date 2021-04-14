Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9635FB93
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Apr 2021 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbhDNTWC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Apr 2021 15:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347532AbhDNTV6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 15:21:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B3C061574
        for <linux-pwm@vger.kernel.org>; Wed, 14 Apr 2021 12:21:36 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWl4u-0001zT-NY; Wed, 14 Apr 2021 21:21:32 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWl4u-00008G-1Y; Wed, 14 Apr 2021 21:21:32 +0200
Date:   Wed, 14 Apr 2021 21:21:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <20210414192131.2o4c2eia6jnjatp2@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
 <YHR3wP4Fk3jidnri@workstation.tuxnet>
 <20210412201019.vouxx4daumusrcvr@pengutronix.de>
 <YHWKehtYFSaHt1hC@workstation.tuxnet>
 <20210413193818.r7oqzdzbxqf5sjj3@pengutronix.de>
 <YHbbaiwK9Tasb7NF@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="inuazthvvxg6ghkd"
Content-Disposition: inline
In-Reply-To: <YHbbaiwK9Tasb7NF@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--inuazthvvxg6ghkd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2021 at 02:09:14PM +0200, Clemens Gruber wrote:
> Hi Uwe,
>=20
> On Tue, Apr 13, 2021 at 09:38:18PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Clemens,
> >=20
> > On Tue, Apr 13, 2021 at 02:11:38PM +0200, Clemens Gruber wrote:
> > > On Mon, Apr 12, 2021 at 10:10:19PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Apr 12, 2021 at 06:39:28PM +0200, Clemens Gruber wrote:
> > > > > With your suggested round-down, the example with frequency of 200=
 Hz
> > > > > would no longer result in 30 but 29 and that contradicts the data=
sheet.
> > > >=20
> > > > Well, with PRESCALE =3D 30 we get a frequency of 196.88 Hz and with
> > > > PRESCALE =3D 29 we get a frequency of 203.45 Hz. So no matter if yo=
u pick
> > > > 29 or 30, you don't get 200 Hz. And which of the two possible value=
s is
> > > > the better one depends on the consumer, no matter what rounding
> > > > algorithm the data sheet suggests. Also note that the math here con=
tains
> > > > surprises you don't expect at first. For example, what PRESCALE val=
ue
> > > > would you pick to get 284 Hz? [If my mail was a video, I'd suggest =
to
> > > > press Space now to pause and let you think first :-)] The data shee=
t's
> > > > formula suggests:
> > > >=20
> > > > 	round(25 MHz / (4096 * 284)) - 1 =3D 20
> > > >=20
> > > > The resulting frequency when picking PRESCALE =3D 20 is 290.644 Hz =
(so an
> > > > error of 6.644 Hz). If instead you pick PRESCALE =3D 21 you get 277=
=2E433 Hz
> > > > (error =3D 6.567 Hz), so 21 is the better choice.
> > > >=20
> > > > Exercise for the reader:
> > > >  What is the correct formula to really determine the PRESCALE value=
 that
> > > >  yields the best approximation (i.e. minimizing
> > > >  abs(real_freq - target_freq)) for a given target_freq?
> >=20
> > I wonder if you tried this.
>=20
> We could calculate both round-up and round-down and decide which one is
> closer to "real freq" (even though that is not the actual frequency but
> just our backwards-calculated frequency).

Yeah, the backwards-calculated frequency is the best assumption we
have.

> But I can't give you a formula with minimized abs(real_freq-target_freq)
> Is it a different round point than 0.5 and maybe relative to f ?
>=20
> Please enlighten us :-)

Sorry, I cannot. I spend ~20 min today after lunch with pencil and
paper, but without success. I was aware that it isn't trivial and this
is the main reason I established round-down as default for new drivers
instead of round-nearest.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--inuazthvvxg6ghkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB3QLgACgkQwfwUeK3K
7AnqbQf+O7AIVRO+G24LPhBJpVA9DGMwHmVgChEtFmCRO725hO1rE7mO20DH7WAU
+c9RxmhoT8Txdv3tAFWSKqhO6CJUvnn2YdJ5lAXCV5+xrKFFKjhcc/Xu/wH381f6
jkAfpvyK3s3aQU3hrKYfSbzTiMfXymrrSUX9UeqqNsoX8WefwCTifnrmcbLMlIEu
D9C0mQpHqzDuWu4K/V+Uc4jHbJ8G/uMS6cuymJCpk/2Q2kHsMeGmxHYoCJBTmQNW
LMG6luBZ5xLbleVFEPTCqZ3Iv3ELzRmRueRgd3xVX4xkH7o3s8l5EkbzRW+fOfbA
QVSvu1Vyry4vUpB5QtWnrpyh/vjvmQ==
=N4NK
-----END PGP SIGNATURE-----

--inuazthvvxg6ghkd--
