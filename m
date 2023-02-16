Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3045F69957B
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Feb 2023 14:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBPNPx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Feb 2023 08:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjBPNPo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Feb 2023 08:15:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35A6190
        for <linux-pwm@vger.kernel.org>; Thu, 16 Feb 2023 05:15:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSe6f-0004RR-SZ; Thu, 16 Feb 2023 14:15:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSe6c-005Mov-MS; Thu, 16 Feb 2023 14:15:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSe6c-0042rY-QL; Thu, 16 Feb 2023 14:15:22 +0100
Date:   Thu, 16 Feb 2023 14:15:21 +0100
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
        <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230216131521.ruc227dcdqcy4ulj@pengutronix.de>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
 <OS0PR01MB5922D6990B0AC75AA278FE1386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230216075231.xnmblxocmlsab5nv@pengutronix.de>
 <OS0PR01MB5922D010C619D3A35564CF6386A09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elohf4lrpr26webf"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D010C619D3A35564CF6386A09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--elohf4lrpr26webf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Thu, Feb 16, 2023 at 10:06:42AM +0000, Biju Das wrote:
> > Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> > On Wed, Feb 15, 2023 at 07:14:12PM +0000, Biju Das wrote:
> > > > Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM
> > > > driver
> > > >
> > > > On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > > > > Add support for RZ/G2L MTU3a PWM driver. The IP supports following
> > > > > PWM modes
> > > > >
> > > > > 1) PWM mode{1,2}
> > > > > 2) Reset-synchronized PWM mode
> > > > > 3) Complementary PWM mode{1,2,3}
> > > >
> > > > It's unclear to me what "PWM mode1" and the other modes are. I
> > > > suspect this is some chip specific naming that isn't understandable
> > > > for outsiders? Would be great to explain that a bit more.
> > >
> > > Ok I will add below to Limitation sections. Is it ok?
> > >
> > > PWM Mode 1: PWM waveforms are output from the MTIOCnA and MTIOCnC pins
> > > by pairing TGRA with TGRB and TGRC with TGRD. The levels specified by
> > > the TIOR.IOA[3:0] and IOC[3:0] bits are output from the MTIOCnA and
> > > MTIOCnC pins at compare matches A and C, and the level specified by
> > > the TIOR.IOB[3:0] and IOD[3:0] bits are output at compare matches B a=
nd D
> > (n =3D 0 to 4, 6, 7).
> > >
> > >
> > > PWM Mode 2: PWM waveform output is generated using one TGR as the
> > > cycle register and the others as duty registers.
> > >
> > > Reset-Synchronized PWM Mode: In the reset-synchronized PWM mode, three
> > > phases of positive and negative PWM waveforms (six phases in total)
> > > that share a common wave transition point can be output by combining
> > > MTU3 and MTU4 and
> > > MTU6 and MTU7.
> > >
> > > Complementary PWM Mode: In complementary PWM mode, dead time can be
> > > set for PWM waveforms to be output. The dead time is the period during
> > > which the upper and lower arm transistors are set to the inactive
> > > level in order to prevent short-circuiting of the arms.Six
> > > positive-phase and six negative-phase PWM waveforms (12 phases in
> > > total)with dead time can be output by combining MTU3/ MTU4 and MTU6/M=
TU7.
> > >
> > > In complementary PWM mode, nine registers (compare registers, buffer
> > > registers, and temporary registers) are used to control the duty rati=
o for
> > the PWM output.
> > > Complementary PWM mode 1 (transfer at crest) Complementary PWM mode 2
> > > (transfer at trough) Complementary PWM mode 3 (transfer at crest and
> > > trough)
> >=20
> > I read it five times now and still don't get it. The problem (maybe) is=
 that
> > there are many abbreviations I don't understand. Most critical is:
> > What is a TGR?
>=20
> Basically it is Timer General register(TGR) functions as either output co=
mpare or=20
> input capture or buffer registers.
>=20
> For the PWMMode1, it is just output-compare
>=20
> TGRA is used for setting period and also the compare-match output is used=
 as clearing the counter.
> TGRB is used for setting duty cycle.
>=20
> This will produce PWM output on MTIOC0A pin.
>=20
> The output of wave form depends upon setting on TIOR
> Currently it is set as, Initial output is low. High output at compare mat=
ch.

Then I suggest to not talk at all about mode 1 or mode 2. Just mention
that you use one counter and two match components to configure
duty_cycle and period.
=20
> > > OK, will call get_rate() after enable. Runtime PM use
> > > clockenable/disable Frequently, so unnecessary to use
> > > clk_rate_exclusive_{get,put}. Is it ok?
> >=20
> > One doesn't have to do with the other. After calling
> > clk_rate_exclusive_get() you can be sure that no other driver does anyt=
hing
> > to change the clk which would mess with the emitted signals.
> >=20
> > I don't know the exact semantics of clk_rate_exclusive_get(), but I'd a=
ssume
> > that even if you disable the clock you should be able to rely on it run=
ning
> > at the same rate after reenable.
>=20
> I believe usage of clk_rate_exclusive_get() is platform
> Dependent.

Yeah, it depends on the platform if the clk will actually change behind
your back. But making it explicit that the clk must not change is a good
idea in general. Your driver might be used later on a platform where it
matters or it might be used as a template for the next pwm driver.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--elohf4lrpr26webf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPuLGYACgkQwfwUeK3K
7An47wf+NJ8iwEI9wTCRjviMb9pFANpxb7wfYpU+gixTIMSLGkIIY6Sv+g4v8mqb
orQd0rStQqhUdLoIyeeDVy+vFaguWj1vOEk8MBcwc1owaMVgEwngL+7Dj4zxrGoz
okgfhE40FeOxP/ccEv98nwHGfcspWuqXqHczwp4Zi9/9Lm2CUNF1nqBzEzrg2K7S
CrJ8fbcoMogDDsPA0tiz+ivOnpTzr1KGvk9B48lQkPsk9f8GhhvTYSo+GZ8MbyxJ
Xx4z2OmhobT5udyJ2Gr3Z30z2VWrQPlPHkMIMUYkgADpFZOvAYG/UTycgVmYVgcz
C7CFrHQAKMyYQ+K1HoVPG+R02sN9hw==
=IDVb
-----END PGP SIGNATURE-----

--elohf4lrpr26webf--
