Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB42D0B96
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 09:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgLGIRU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 03:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLGIRT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 03:17:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80409C0613D2
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 00:16:39 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmBh8-0000Zr-Up; Mon, 07 Dec 2020 09:16:30 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmBh6-0004km-HV; Mon, 07 Dec 2020 09:16:28 +0100
Date:   Mon, 7 Dec 2020 09:16:28 +0100
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
Message-ID: <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
References: <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7t4bbhedmu7hxrs"
Content-Disposition: inline
In-Reply-To: <20201206141941.GA24807@gofer.mess.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--r7t4bbhedmu7hxrs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 06, 2020 at 02:19:41PM +0000, Sean Young wrote:
> Hello Uwe,
>=20
> On Sat, Dec 05, 2020 at 08:25:10PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sat, Dec 05, 2020 at 05:34:44PM +0000, Sean Young wrote:
> > > What real life uses-cases are there for round down? If you want to ro=
und
> > > down, is there any need for round up?
> >=20
> > The scenario I have in mind is for driving a motor. I have to admit
> > however that usually the period doesn't matter much and it's the
> > duty_cycle that defines the motor's speed. So for this case the
> > conservative behaviour is round-down to not make the motor run faster
> > than expected.
>=20
> I am reading here that for driving motors, only the duty cycle matters,
> not the period.

There is an upper limit (usually around 1 ms) for the period, but if you
choose 0.1 ms or 0.001 ms doesn't matter much AFAICT.

@Thierry: Do you have further use cases in mind?

> > For other usecases (fan, backlight, LED) exactness typically doesn't
> > matter that much.
>=20
> So, the use-cases you have are driving motor, fan, backlight, and led.
> And in all these cases the exact Hz does not matter.
>=20
> The only uses case where the exact Hz does matter is pwm-ir-tx.=20
>=20
> So, I gather there are no use-cases for round-down. Yes, should round-down
> be needed, then this is more difficult to implement if the driver always
> does a round-closest. But, since there is no reason to have round-down,
> this is all academic.
>=20
> Your policy of forcing new pwm drivers to use round-down is breaking
> pwm-ir-tx.

So you're indeed suggesting that the "right" rounding strategy for
lowlevel drivers should be:

 - Use the period length closest to the requested period (in doubt round
   down?)
 - With the chosen period length use the biggest duty_cycle not bigger
   than the requested duty_cycle.

While this seems technically fine I think for maintenance this is a
nightmare.

My preference would be to stick to the rounding strategy we used so far
(i.e.:

 - Use the biggest period length not bigger than the requested period
 - With the chosen period length use the biggest duty_cycle not bigger
   than the requested duty_cycle.

) and for pwm-ir-tx add support to the PWM API to still make it possible
(and easy) to select the best setting.

The reasons why I think that this rounding-down strategy is the best
are (in order of importance):

 - It is easier to implement correctly [1]
 - Same rounding method for period and duty cycle
 - most drivers already do this (I think)

The (IMHO nice) result would then mean:

 - All consumers can get the setting they want; and
 - Code in lowlevel drivers is simple and the complexity is in common
   code and so a single place.

And it would also allow the pwm-ir-tx driver to notice if the PWM to be
used can for example only support frequencies under 400 kHz.

Best regards
Uwe

[1] Consider a PWM with a parent frequency of 66 MHz, to select the
    period you can pick an integer divider "div" resulting in the period
    4096 / (pclk * d). So the obvious implementation for round-nearest
    would be:

    	pclk =3D clk_get_rate(myclk);
	div =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC * 4096, targetperiod * pclk);

    , right?

    With targetperiod =3D 2641 ns this picks div =3D 23 and so a period of
    2698.2872200263505 ns (delta =3D 57.2872200263505 ns).
    The optimal divider however is div =3D 24. (implemented period =3D
    2585.8585858585857 ns, delta =3D 55.14141414141448 ns)

    For round-down the correct implementation is:

    	pclk =3D clk_get_rate(myclk);
	div =3D DIV_ROUND_UP(NSEC_PER_SEC * 4096, targetperiod * pclk);

    Exercise for the reader: Come up with a correct implementation for
    "round-nearest" and compare its complexity to the round-down code.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r7t4bbhedmu7hxrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/N5NkACgkQwfwUeK3K
7AmLpgf+Py+CFKFZtAi0EaZORlcfGV4BYD8OXxpWshzSlh6wvKWG23vobo2NLu1e
ZcJ+MuEwIqQvH4KlxSOPEBR/JbTIBECwNO/VZ4lG3GDJGoMvPm1M5FYZGdT4YaHK
u/R4JHtAXajn77RjlQtJv9r2L3ZZJznVVGhkOJfpYMXeCY0wmIL7uiqMey0UOFYQ
PGfR4oev1WglnyNXZD2vruMW6k4Oj9HfvB5pCxLdF82qqXo3VE9Vf0vGAsL3POay
cR3rtka0wut1GTtuo1ZChEbvywGQiyMMM8OU6Zq/clRBJvxwjhmiX3NKinfzZ3jd
/pOFxeyIxM6QzrwbVKbKtCKTO3F/iQ==
=ukN6
-----END PGP SIGNATURE-----

--r7t4bbhedmu7hxrs--
