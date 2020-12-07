Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B482D1290
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 14:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLGNw7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 08:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLGNw7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 08:52:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074A1C0613D1
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 05:52:19 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmGvz-0001Lj-4d; Mon, 07 Dec 2020 14:52:11 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmGvx-0004wY-JA; Mon, 07 Dec 2020 14:52:09 +0100
Date:   Mon, 7 Dec 2020 14:52:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201207135209.htp7plyotjxp37q2@pengutronix.de>
References: <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
 <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
 <20201207094320.GA10460@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwodz2pit7heximm"
Content-Disposition: inline
In-Reply-To: <20201207094320.GA10460@gofer.mess.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zwodz2pit7heximm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Dec 07, 2020 at 09:43:20AM +0000, Sean Young wrote:
> Thank you for taking the time to explain your thinking.

I'm happy you have an open ear for it. With this I really enjoy spending
the time to find the right arguments and examples.

> On Mon, Dec 07, 2020 at 09:16:28AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sun, Dec 06, 2020 at 02:19:41PM +0000, Sean Young wrote:
> > > On Sat, Dec 05, 2020 at 08:25:10PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Sat, Dec 05, 2020 at 05:34:44PM +0000, Sean Young wrote:
> > > > > What real life uses-cases are there for round down? If you want t=
o round
> > > > > down, is there any need for round up?
> > > >=20
> > > > The scenario I have in mind is for driving a motor. I have to admit
> > > > however that usually the period doesn't matter much and it's the
> > > > duty_cycle that defines the motor's speed. So for this case the
> > > > conservative behaviour is round-down to not make the motor run fast=
er
> > > > than expected.
> > >=20
> > > I am reading here that for driving motors, only the duty cycle matter=
s,
> > > not the period.
> >=20
> > There is an upper limit (usually around 1 ms) for the period, but if you
> > choose 0.1 ms or 0.001 ms doesn't matter much AFAICT.
> >=20
> > @Thierry: Do you have further use cases in mind?

I asked in the hardware department of the company I work for and they
had another usecase: Motors where for example a 1 ms pulse means "move
forwards" and 2 ms means "move backwards". They had the same idea as I
had: You want to know beforehand the result of a given
pwm_apply_state().

> > > > For other usecases (fan, backlight, LED) exactness typically doesn't
> > > > matter that much.
> > >=20
> > > So, the use-cases you have are driving motor, fan, backlight, and led.
> > > And in all these cases the exact Hz does not matter.
> > >=20
> > > The only uses case where the exact Hz does matter is pwm-ir-tx.=20
> > >=20
> > > So, I gather there are no use-cases for round-down. Yes, should round=
-down
> > > be needed, then this is more difficult to implement if the driver alw=
ays
> > > does a round-closest. But, since there is no reason to have round-dow=
n,
> > > this is all academic.
> > >=20
> > > Your policy of forcing new pwm drivers to use round-down is breaking
> > > pwm-ir-tx.
> >=20
> > So you're indeed suggesting that the "right" rounding strategy for
> > lowlevel drivers should be:
> >=20
> >  - Use the period length closest to the requested period (in doubt round
> >    down?)
> >  - With the chosen period length use the biggest duty_cycle not bigger
> >    than the requested duty_cycle.
> >=20
> > While this seems technically fine I think for maintenance this is a
> > nightmare.
> >=20
> > My preference would be to stick to the rounding strategy we used so far
> > (i.e.:
> >=20
> >  - Use the biggest period length not bigger than the requested period
> >  - With the chosen period length use the biggest duty_cycle not bigger
> >    than the requested duty_cycle.
> >=20
> > ) and for pwm-ir-tx add support to the PWM API to still make it possible
> > (and easy) to select the best setting.
> >=20
> > The reasons why I think that this rounding-down strategy is the best
> > are (in order of importance):
> >=20
> >  - It is easier to implement correctly [1]
>=20
> Yes, you are right. You have given a great example where a simple
> DIV_ROUND_CLOSEST() does not give the result you want.
>=20
> >  - Same rounding method for period and duty cycle
> >  - most drivers already do this (I think)
> >=20
> > The (IMHO nice) result would then mean:
> >=20
> >  - All consumers can get the setting they want; and
>=20
> Once there is a nice pwm api for selecting round-nearest, then yes.
>=20
> For the uses cases you've given, fan, backlight, and led a round-nearest
> is the rounding they would want, I would expect.

maybe, yes. Maybe it is also not important enough to spend the extra
cycles getting round nearest and so sticking to round-down is good
enough.

> >  - Code in lowlevel drivers is simple and the complexity is in common
> >    code and so a single place.
> >=20
> > And it would also allow the pwm-ir-tx driver to notice if the PWM to be
> > used can for example only support frequencies under 400 kHz.
>=20
> I doubt pwm-ir-tx cares about this, however it is a nice-to-have. It would
> also be nice if the rounding could be used with atomic configuration
> as well.

I cannot follow, you created 11fc4edc483bea8bf0efa0cc726886d2342f6fa6
because 476.2 Mhz was too bad. So you seem to be interested in
deviations and part of the problem is that you don't get feedback about
how your request is fulfilled.

> Please let me know when/if this new API exists for pwm so that pwm-ir-tx
> can select the right rounding.

Given that the bcm2835 driver is quite trivial I would be happy to
create a series that "fixes" the driver to round down and provide a
prototype for pwm_round_nearest for you to test on pwm-ir-tx. A willing
tester and a real use-case were the single two things that stopped me
investing time here.

> > [1] Consider a PWM with a parent frequency of 66 MHz, to select the
> >     period you can pick an integer divider "div" resulting in the period
> >     4096 / (pclk * d). So the obvious implementation for round-nearest
> >     would be:
> >=20
> >     	pclk =3D clk_get_rate(myclk);
> > 	div =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC * 4096, targetperiod * pclk);
>=20
> Note NSEC_PER_SEC * 4096 >> 2^32 so this would need to be
> DIV_ROUND_CLOSEST_ULL.

Yeah, I ignored all these nasty little details like ranges of integers
and the valid range for div etc. for the sake of simplicity.
=20
> >     , right?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zwodz2pit7heximm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/OM4YACgkQwfwUeK3K
7AmVKgf+MRSChQ/VXQbRD7/1ldf7VjErIvSxN+a1SuD6OkSOVWqPvalyG0n/nq61
fkmOQ3zvNnvElDpWUzB4gv+hm4dDKJ600hYG6C0MGGte3rvGdWPQkQveXrPldGZ9
GqEWGosKq1MzqaYO2gc+cyyKXu14g2ylr0rAEH5SJXLwxRhuX4c1dREMsTVuv2Hj
aLGMnvxGCBlQBjTQ4Fhc7Ap5TlGI2yD+CYMyHiGj/8aFbRIa/iLJ13HeDVCqLSxU
2rBIpzaTrHbz13jeZUaG39U8wFyVjY5AwyehRKjOzKVGOrZM5F8edUKh+6LaB/sS
xvVeTFiCZ69clhkPqCdZVm6wiVvnnw==
=TYIu
-----END PGP SIGNATURE-----

--zwodz2pit7heximm--
