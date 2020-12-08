Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5A2D272C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 10:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgLHJId (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 04:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgLHJIb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 04:08:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E84C0613D6
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 01:07:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmYyC-0001O6-5W; Tue, 08 Dec 2020 10:07:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmYyA-0008Qo-Hl; Tue, 08 Dec 2020 10:07:38 +0100
Date:   Tue, 8 Dec 2020 10:07:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Sean Young <sean@mess.org>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201208090738.o43nearryrzimxtg@pengutronix.de>
References: <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
 <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
 <20201206141941.GA24807@gofer.mess.org>
 <20201207081628.tm3yg7az5k5sbivu@pengutronix.de>
 <20201207094320.GA10460@gofer.mess.org>
 <20201207135209.htp7plyotjxp37q2@pengutronix.de>
 <ad83f03b-869d-44e1-5db9-d5e91a0c0da3@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fkonw7ajelah7x52"
Content-Disposition: inline
In-Reply-To: <ad83f03b-869d-44e1-5db9-d5e91a0c0da3@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fkonw7ajelah7x52
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lino,

On Tue, Dec 08, 2020 at 01:00:02AM +0100, Lino Sanfilippo wrote:
> On 07.12.20 at 14:52, Uwe Kleine-K=F6nig wrote:
> > Given that the bcm2835 driver is quite trivial I would be happy to
> > create a series that "fixes" the driver to round down and provide a
> > prototype for pwm_round_nearest for you to test on pwm-ir-tx. A willing
> > tester and a real use-case were the single two things that stopped me
> > investing time here.
> >
>=20
> Should I send a v3 of the .apply() support for the bcm2835 driver before =
you start
> such a rework? The v3 would contain the check against truncation of the p=
eriod but
> keep the round-closest strategy as it is.

Yes, I had asking for that on my plate for today.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fkonw7ajelah7x52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/PQlcACgkQwfwUeK3K
7AlEfAgAlF91CSfmR0y8sL1xrnyfwy5xZRwJm/4MS5GVKkN0mntMY89HVntY1jg9
x3oapm4weyPx1qRvv4WetIFjGASkm5ONplmyD25T+gLVwR8Ek4HwRhufpk33k7DI
i+aQB9pzHOIrH9/AdJMhkDNPqh8U3RvbGrfPq44gCHHMv8tyYvrJJ4+vT4kI5ppf
nN5N3vcbZcWGb8R2fa3mQopjUmGI1Zd3EHwpE/+bvILxqgkvU45SpYBhcHvGD4P7
FvP9mj3mAy3Vccc+TqUBw9HoLlcvrQEXwvXpy/nQ/WhhSxAy7dlae2lgi8PcsIxL
C/mHUawcoXZDzil0k5oPmWjW3T6JrA==
=2pG3
-----END PGP SIGNATURE-----

--fkonw7ajelah7x52--
