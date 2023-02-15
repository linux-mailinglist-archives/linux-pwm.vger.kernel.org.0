Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB8697A48
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Feb 2023 11:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjBOK5r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Feb 2023 05:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjBOK5q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Feb 2023 05:57:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A02594D
        for <linux-pwm@vger.kernel.org>; Wed, 15 Feb 2023 02:57:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFTi-0005Hn-FB; Wed, 15 Feb 2023 11:57:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFTe-0055WA-TP; Wed, 15 Feb 2023 11:57:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSFTf-003j7E-9m; Wed, 15 Feb 2023 11:57:31 +0100
Date:   Wed, 15 Feb 2023 11:57:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230215105731.4yhwgdbux7mogf4j@pengutronix.de>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
 <OS0PR01MB59227E0E659C292D775474BF86A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4ly3tz3y5q36lp7"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59227E0E659C292D775474BF86A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--b4ly3tz3y5q36lp7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Wed, Feb 15, 2023 at 10:31:20AM +0000, Biju Das wrote:
> > On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > > Add support for RZ/G2L MTU3a PWM driver. The IP supports following PWM
> > > modes
> > >
> > > 1) PWM mode{1,2}
> > > 2) Reset-synchronized PWM mode
> > > 3) Complementary PWM mode{1,2,3}
> >=20
> > It's unclear to me what "PWM mode1" and the other modes are. I suspect =
this
> > is some chip specific naming that isn't understandable for outsiders? W=
ould
> > be great to explain that a bit more.
>=20
> I will give some details about PWM modes mentioned in the HW manual here.
> I will respond to other comments later.
>=20
> PWM Mode 1
> ------------
> n =3D {0,1,2,3,4,6,7}
> MTIOC0A:-MTU0 TGRA input capture input/output compare output/PWM output p=
in
> TGRA: Timer General Register A
> TIOR: Timer I/O control register
> In PWM mode 1, PWM waveforms in up to 12 phases can be output
>=20
> PWM waveforms are output from the MTIOCnA and MTIOCnC pins by pairing TGRA
> with TGRB and TGRC with TGRD. The levels specified by the TIOR.IOA[3:0] a=
nd
> IOC[3:0] bits are output from the MTIOCnA and MTIOCnC pins at compare mat=
ches
> A and C, and the level specified by the TIOR.IOB[3:0] and IOD[3:0] bits a=
re
> output at compare matches B and D (n =3D 0 to 4, 6, 7). The initial outpu=
t value
> is set in TGRA or TGRC. If the values set in paired TGRs are identical, t=
he
> output value does not change even when a compare match occurs.
>=20
> PWM Mode 2
> ----------
> n =3D {0,1,2}
>=20
> PWM waveform output is generated using one TGR as the cycle register and =
the
> others as duty registers. The level specified in TIOR is output at compar=
e matches.
> Upon counter clearing by a cycle register compare match, the initial valu=
e set
> in TIOR is output from each pin. If the values set in the cycle and duty =
registers
> are identical, the output value does not change even when a compare match=
 occurs.
>=20
> In PWM mode 2, up to eight phases of PWM waveforms can be output when syn=
chronous
> clearing is used as synchronous operation in the channels that cannot be =
placed in
> PWM mode 2.

Why is PWM Mode 1 about two outputs? These could be abstracted as two
individual PWMs, couldn't they? In this mode you could implement a phase
shift, but the period is limited to the overflow time of the timers.

In Mode 2 the period is more flexible, but no phase shift is possible
(apart from inversed polarity).

Did I get this right?

> Reset-Synchronized PWM Mode:
> ---------------------------
> In the reset-synchronized PWM mode, three phases of positive and negative=
 PWM
> waveforms (six phases in total) that share a common wave transition point=
 can
> be output by combining MTU3 and MTU4 and MTU6 and MTU7.
>=20
> When set for reset-synchronized PWM mode, the MTIOC3B, MTIOC3D, MTIOC4A, =
MTIOC4C,
> MTIOC4B, MTIOC4D, MTIOC6B, MTIOC6D, MTIOC7A, MTIOC7C, MTIOC7B, and MTIOC7=
D pins
> function as PWM output pins and timer counters 6 and 12 (MTU3.TCNT and MT=
U6.TCNT)
> functions as an up-counter
>=20
>=20
> Complementary PWM Mode:
> ----------------------
>=20
> In complementary PWM mode, dead time can be set for PWM waveforms to be o=
utput.
> The dead time is the period during which the upper and lower arm transist=
ors are
> set to the inactive level in order to prevent short-circuiting of the arm=
s.
> Six positive-phase and six negative-phase PWM waveforms (12 phases in tot=
al)=20
> with dead time can be output by combining MTU3/ MTU4 and MTU6/MTU7. PWM w=
aveforms
> without dead time can also be output.
>=20
> In complementary PWM mode, nine registers (compare registers, buffer regi=
sters,
> and temporary registers) are used to control the duty ratio for the PWM o=
utput.
>=20
> Complementary PWM mode 1 (transfer at crest)
> Complementary PWM mode 2 (transfer at trough)
> Complementary PWM mode 3 (transfer at crest and trough)

These two modes are more general than the PWM framework supports. There
was a series some time ago to implement settings with two outputs, but
we didn't agree on an abstraction and the effort died. So for now these
are out of scope, right?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b4ly3tz3y5q36lp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPsupcACgkQwfwUeK3K
7AmbVwf9EQPzyfcDCH93ywofZkSk35/TNZC9n4BbiLbpE7va5/m1ytts9QMYsbYw
T6Tbt0q3E2TJzVGd1+a4gfAWm76Fc3dx8mOVQnqzkwK1ws87qB2vYbUKOqvrhJ5d
A9jjSsZrqIhi2FD08sIiaKBDI/jvLzjh2XeoU8JnmEVN69KEz8GZCuP/9gYD+qsx
DRcP8HrpkrJa9+gfhbPKd045AO3WRLuT5ykbVqWmkRAqB5J0uYoWRo4zJ4IsiS5B
psLpxCGWTeVSjSb0sbFS5HgPFFIPzfnWHZKHvu+LvYObo/YL+MYoMvJ1t8PnQPeE
z7zs34qX5aCNXZWEm6CalqfvMp4sQg==
=/XXg
-----END PGP SIGNATURE-----

--b4ly3tz3y5q36lp7--
