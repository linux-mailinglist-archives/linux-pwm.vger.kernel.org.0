Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171DE3D415E
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jul 2021 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhGWTcl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jul 2021 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGWTck (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jul 2021 15:32:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ECDC061575
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jul 2021 13:13:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m71XV-0005Yj-8f; Fri, 23 Jul 2021 22:12:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m71XR-0005GT-1q; Fri, 23 Jul 2021 22:12:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m71XR-0000Yi-05; Fri, 23 Jul 2021 22:12:53 +0200
Date:   Fri, 23 Jul 2021 22:12:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210723201250.x4ki5ackfznmn4aw@pengutronix.de>
References: <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
 <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
 <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
 <3F12A498-DF5C-4954-8BCE-8C0C66BC9734@aspeedtech.com>
 <4BC9AEF6-31EA-4EDA-BCB2-7E4D44B6D5D2@aspeedtech.com>
 <20210721124859.clv6qlitbyomdz6s@pengutronix.de>
 <7F794DD8-0FC6-491D-B071-CAD6C216E044@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="toxq6bq4j46rzjqb"
Content-Disposition: inline
In-Reply-To: <7F794DD8-0FC6-491D-B071-CAD6C216E044@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--toxq6bq4j46rzjqb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2021 at 04:23:23AM +0000, Billy Tsai wrote:
> On 2021/7/23, 3:17 AM, "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.=
de> wrote:
>=20
>     On Wed, Jul 21, 2021 at 10:52:21AM +0000, Billy Tsai wrote:
>     >> Hi Uwe,
>     >>=20
>     >>     On 2021/7/16, 6:13 PM, "Uwe Kleine-K=F6nig" <u.kleine-koenig@p=
engutronix.de> wrote:
>     >>=20
>     >>         On Fri, Jul 16, 2021 at 09:22:22AM +0000, Billy Tsai wrote:
>     >>         >> On 2021/7/16, 3:10 PM, "Uwe Kleine-K=F6nig" <u.kleine-k=
oenig@pengutronix.de> wrote:
>     >>         >>=20
>     >>         >>     On Fri, Jul 16, 2021 at 01:48:20AM +0000, Billy Tsa=
i wrote:
>     >>         >>     >> On 2021/7/15, 11:06 PM, "Uwe Kleine-K=F6nig" <u.=
kleine-koenig@pengutronix.de>> wrote:
>     >>         >>     >>     > Another is: The PWM doesn't support duty_c=
ycle 0, on such a request the
>     >>         >>     >>     > PWM is disabled which results in a constan=
t inactive level.
>     >>         >>     >>=20
>     >>         >>     >>     > (This is correct, is it? Or does it yield =
a constant 0 level?)
>     >>         >>     >>=20
>     >>         >>     >> Our pwm can support duty_cycle 0 by unset CLK_EN=
ABLE.
>     >>         >>=20
>     >>         >>     > This has a slightly different semantic though. So=
me consumer might
>     >>         >>     > expect that the following sequence:
>     >>         >>=20
>     >>         >>     >	pwm_apply(mypwm, { .period =3D 10000, .duty_cycle=
 =3D 10000, .enabled =3D true })
>     >>         >>     >	pwm_apply(mypwm, { .period =3D 10000, .duty_cycle=
 =3D 0, .enabled =3D true })
>     >>         >>     >	pwm_apply(mypwm, { .period =3D 10000, .duty_cycle=
 =3D 10000, .enabled =3D true })
>     >>         >>=20
>     >>         >>     > results in the output being low for an integer mu=
ltiple of 10 =B5s. This
>     >>         >>     > isn't given with setting CLK_ENABLE to zero, is i=
t? (I didn't recheck,
>     >>         >>     > if the PWM doesn't complete periods on reconfigur=
ation this doesn't
>     >>         >>     > matter much though.)
>     >>         >> Thanks for the explanation.
>     >>         >> Our hardware actually can only support duty from 1/256 =
to 256/256.
>     >>         >> For this situation I can do possible solution:
>     >>         >> We can though change polarity to meet this requirement.=
 Inverse the pin and use
>     >>         >> duty_cycle 100.=20
>     >>         >> But I think this is not a good solution for this proble=
m right?
>     >>=20
>     >>         > If this doesn't result in more glitches that would be fi=
ne for me.
>     >>         > (Assuming it is documented good enough in the code to be
>     >>         > understandable.)
>     >>=20
>     >>     > The polarity of our pwm controller will affect the duty cycl=
e range:
>     >>     > PWM_POLARITY_INVERSED : Support duty_cycle from 0% to 99%
>     >>     > PWM_POLARITY_NORMAL: Support duty_cycle from 1% to 100%
>     >>     > Dynamic change polarity will result in more glitches. Thus, =
this will become
>     >>     > a trade-off between 100% and 0% duty_cycle support for user =
to use our pwm device.
>     >>     > I will document it and send next patch.
>     >>=20
>     >> For handling the situation that the user want to set the duty cycl=
e to 0%, the driver can:
>     >> 1. Just return the error.
>     >> 2. Use the minimum duty cycle value.
>     >> I don't know which solution will be the better way or others.
>     >> I would be grateful if you can give me some suggestion about this =
problem.
>=20
>     > I thought if you disable the PWM it emits the inactive level? Then =
this
>     > is the best you can do if duty_cycle =3D 0 is requested.
>=20
> Thanks for your quick reply.
> When duty_cycle =3D 0 is requested my driver currently will emit the inac=
tive level.
> So, the next patch I need to do is to add the comment about this?

Not sure I got the complete picture now. The things I consider important
are:

 - If your hardware cannot emit a 100% or 0% relative duty cycle, note
   this in the Limitations section

 - Assuming your PWM emits the inactive level when disabled (that is 0
   for PWM_POLARITY_NORMAL and 1 for PWM_POLARITY_INVERSED) this is the
   best that can be done when a 0% relative duty cycle is requested
   (assuming the hardware cannot implement that in a normal way).

I hope this answered your remaining questions.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--toxq6bq4j46rzjqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmD7Ir8ACgkQwfwUeK3K
7AkC4Qf/UySDPXNcbHOt72z/xM5f81I/l//h6KQb/ov/i2Acp8sazD1ANZ2+oN1/
ZeecnsddK2CbLAHwuB53a7PUNfUmnFFf0hqaJGqG4k7ijswU+ln8mGj3Riaz1/8f
P2fVTq62m7qmG7qF0WZoGcip9PHD0RO4yYOE/MwriQqsZV8e0z+rmd1xE536ys73
A1JdFOThHpA8ZeQNbLaEvXkfHQ8qcamXcWGmnSgWyC6sUqYtRvyu+MPCgQs//ANB
N+zGyKRfytVIl70GdbioHUn7vNQLwTVkfliecpdoCbdZaCpdQEzuZQVwztuEVctH
siL6R66w7b074QtT3qfOvoKcLmeqIg==
=LY3j
-----END PGP SIGNATURE-----

--toxq6bq4j46rzjqb--
