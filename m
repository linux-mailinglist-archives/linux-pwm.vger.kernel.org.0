Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6F3602A8
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhDOGtZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 02:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOGtY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 02:49:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33446C061574
        for <linux-pwm@vger.kernel.org>; Wed, 14 Apr 2021 23:49:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWvo8-0002Xv-UD; Thu, 15 Apr 2021 08:48:56 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWvo8-0005YD-GV; Thu, 15 Apr 2021 08:48:56 +0200
Date:   Thu, 15 Apr 2021 08:48:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <20210415064854.glrvk7d634bisb34@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
 <YHR3wP4Fk3jidnri@workstation.tuxnet>
 <20210412201019.vouxx4daumusrcvr@pengutronix.de>
 <YHWKehtYFSaHt1hC@workstation.tuxnet>
 <20210413193818.r7oqzdzbxqf5sjj3@pengutronix.de>
 <YHbbaiwK9Tasb7NF@workstation.tuxnet>
 <20210414192131.2o4c2eia6jnjatp2@pengutronix.de>
 <YHdGXG3PbsmicK7U@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kij3efdivtjivdyy"
Content-Disposition: inline
In-Reply-To: <YHdGXG3PbsmicK7U@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kij3efdivtjivdyy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2021 at 09:45:32PM +0200, Clemens Gruber wrote:
> On Wed, Apr 14, 2021 at 09:21:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Apr 14, 2021 at 02:09:14PM +0200, Clemens Gruber wrote:
> > > Hi Uwe,
> > >=20
> > > On Tue, Apr 13, 2021 at 09:38:18PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > Hello Clemens,
> > > >=20
> > > > On Tue, Apr 13, 2021 at 02:11:38PM +0200, Clemens Gruber wrote:
> > > > > On Mon, Apr 12, 2021 at 10:10:19PM +0200, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > On Mon, Apr 12, 2021 at 06:39:28PM +0200, Clemens Gruber wrote:
> > > > > > > With your suggested round-down, the example with frequency of=
 200 Hz
> > > > > > > would no longer result in 30 but 29 and that contradicts the =
datasheet.
> > > > > >=20
> > > > > > Well, with PRESCALE =3D 30 we get a frequency of 196.88 Hz and =
with
> > > > > > PRESCALE =3D 29 we get a frequency of 203.45 Hz. So no matter i=
f you pick
> > > > > > 29 or 30, you don't get 200 Hz. And which of the two possible v=
alues is
> > > > > > the better one depends on the consumer, no matter what rounding
> > > > > > algorithm the data sheet suggests. Also note that the math here=
 contains
> > > > > > surprises you don't expect at first. For example, what PRESCALE=
 value
> > > > > > would you pick to get 284 Hz? [If my mail was a video, I'd sugg=
est to
> > > > > > press Space now to pause and let you think first :-)] The data =
sheet's
> > > > > > formula suggests:
> > > > > >=20
> > > > > > 	round(25 MHz / (4096 * 284)) - 1 =3D 20
> > > > > >=20
> > > > > > The resulting frequency when picking PRESCALE =3D 20 is 290.644=
 Hz (so an
> > > > > > error of 6.644 Hz). If instead you pick PRESCALE =3D 21 you get=
 277.433 Hz
> > > > > > (error =3D 6.567 Hz), so 21 is the better choice.
> > > > > >=20
> > > > > > Exercise for the reader:
> > > > > >  What is the correct formula to really determine the PRESCALE v=
alue that
> > > > > >  yields the best approximation (i.e. minimizing
> > > > > >  abs(real_freq - target_freq)) for a given target_freq?
> > > >=20
> > > > I wonder if you tried this.
> > >=20
> > > We could calculate both round-up and round-down and decide which one =
is
> > > closer to "real freq" (even though that is not the actual frequency b=
ut
> > > just our backwards-calculated frequency).
> >=20
> > Yeah, the backwards-calculated frequency is the best assumption we
> > have.
> >=20
> > > But I can't give you a formula with minimized abs(real_freq-target_fr=
eq)
> > > Is it a different round point than 0.5 and maybe relative to f ?
> > >=20
> > > Please enlighten us :-)
> >=20
> > Sorry, I cannot. I spend ~20 min today after lunch with pencil and
> > paper, but without success. I was aware that it isn't trivial and this
> > is the main reason I established round-down as default for new drivers
> > instead of round-nearest.
>=20
> Oh, I thought you already solved it. I tried too for a while but was
> unsuccessful. Not trivial indeed!
>=20
> But regarding you establishing round-down: Wouldn't it be even better if
> the driver did what I suggested above, namely calculate backwards from
> both the rounded-up as well as the rounded-down prescale value and then
> write the one with the smallest abs(f_target - f_real) to the register?

No, I don't think so for several reasons. First, just rounding down is
easier (and keeping lowlevel drivers rules and implementation easy is
IMHO a good goal). The second reason is that round-nearest is a bit
ambigous because round to the nearest frequency is slightly different to
round to the nearest period length. So to actually implement (or use)
it correctly, people have to grasp that difference. Compared to that
rounding down the period length corresponds 1:1 to rounding up
frequency. That's easy.

For the third reason I have to backup a bit: I intend to introduce a
function pwm_round_rate that predicts what pwm_apply_rate will actually
implement. Of course it must have the same rounding rules. This allows
to implement efficient search for consumers that e.g. prefer
round-nearest time, or round-nearest frequency. I'm convinced that
searching the optimal request to make is easier if round_rate uses
round-down and not round-nearest.

All three reasons boil down to "the math for round-down is just simpler
(for implementers and for users) than with round-nearest".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kij3efdivtjivdyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB34dMACgkQwfwUeK3K
7AkZWgf/SJH5gUNhVoq0Ss5l1e4cNXs73avV6WBUWFp9ZanIcKrNAo+vsErxneq3
riw2RUutTTaVybfzlbwfeGJJVLrnnKDKIgp6DJPsHXVS3puf0hfjsVlSVmwpisnV
xkfpshaAfWXdH+IBQFBj9p7CJsaqeVsV2Dwm8+A9Ud7J9LYduqNvKLq1eW1CbwcW
NOJNIFQqB+Am4AnD8W7/jMbnKoXlhSG2Cc4+HSNjoczDw8029wYIMP1GBY62a7Q1
OmhP696dLosuUs/T73ZZg65EojAZfg7qRaBFmgBlLtDFJHSl1njj1F0x7Qj277ut
u4/11FzWpidfcR2e5PZiq0E5INSYqQ==
=gN4c
-----END PGP SIGNATURE-----

--kij3efdivtjivdyy--
