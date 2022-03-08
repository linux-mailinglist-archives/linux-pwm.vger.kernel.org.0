Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93E4D14BF
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Mar 2022 11:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbiCHK34 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Mar 2022 05:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbiCHK3z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Mar 2022 05:29:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548183C48F
        for <linux-pwm@vger.kernel.org>; Tue,  8 Mar 2022 02:28:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRX5N-0003aX-Mk; Tue, 08 Mar 2022 11:28:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRX5M-003Q3n-6d; Tue, 08 Mar 2022 11:28:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRX5K-007ldP-RK; Tue, 08 Mar 2022 11:28:54 +0100
Date:   Tue, 8 Mar 2022 11:28:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
Message-ID: <20220308102851.boxnml5l3npmfaxm@pengutronix.de>
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
 <20220307184750.qkbueadgqohbvv2g@pengutronix.de>
 <bfcda0d1-7855-7ab6-ef2c-950ead5f8b15@gmail.com>
 <20220307204430.24h572t6ftvjqzaq@pengutronix.de>
 <0aebcb3d-c100-cb1c-7033-3228702bc51c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ilg3jt4qzxpmn3ca"
Content-Disposition: inline
In-Reply-To: <0aebcb3d-c100-cb1c-7033-3228702bc51c@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ilg3jt4qzxpmn3ca
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2022 at 02:27:22PM -0800, Florian Fainelli wrote:
> On 3/7/22 12:44 PM, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Florian,
> >=20
> > great to get answers from you in such a timely fashion. That helps a
> > lot!
> >=20
> > On Mon, Mar 07, 2022 at 11:11:05AM -0800, Florian Fainelli wrote:
> >> On 3/7/22 10:47 AM, Uwe Kleine-K=C3=B6nig wrote:
> >>> I have a few questions here looking in more detail into the brcmstb
> >>> driver:
> >>>
> >>>  - What happens on PWM_ON(channel) =3D 0?
> >>>    I guess it just emits a flat inactive line, and refusing a small
> >>>    duty_cycle that results in PWM_ON(channel) =3D 0 is just artificia=
l?
> >>>
> >>>  - There is a line describing:
> >>>
> >>>    	W =3D cword, if cword < 2 ^ 15 else 16-bit 2's complement of cword
> >>>
> >>>    The driver only considers powers of two <=3D 2^15 for cword. Is the
> >>>    implementation just lazy, or is the comment misleading?
> >>>    At least s/</<=3D/ ?
> >>>    There is no sense in using a value > 2^15 as for each such value
> >>>    there is a smaller value with the same result, right?
> >>
> >> This was copied from the specification which now that you mention it,
> >> seems off by one in its formula, it should be <=3D. This is further
> >> confirmed with:
> >>
> >> pwm1_cword[15:0] must be less than or equal to 32768 when the
> >> variable-frequency PWM is used as a clock for the constant-frequency P=
WM.
> >> Reset value is 0x0.
> >>
> >> so I believe that the comment is wrong and so is the specification of
> >> the block that was used to write the driver.
> >=20
> > OK, so the right thing would be:
> >=20
> > 	W =3D cword with cword <=3D 32768
> >=20
> > and there is no limitation to powers of two. (However it's unclear to me
> > how this works in hardware for arbitrary values.)
> >=20
> >>>  - clk_get_rate(p->clk) is expected to return 27 MHz, right?
> >>>    (Just for my understanding, not about to hardcode this in the code)
> >>
> >> That is right.
> >=20
> > ok.
> >=20
> >>>  - The explanation about period in the comment is:
> >>>
> >>>    	The period is: (period + 1) / Fv
> >>>
> >>>    so I would have expected:
> >>>
> >>>    	pc =3D (period_ns * clkrate * cword / (NSEC_PER_SEC << 16)) - 1
> >>>
> >>>    (assuming no overflows). However the -1 isn't in the code.
> >=20
> > You didn't comment on that one, I still assume this to be correct, i.e.
> > the -1 must be coped for in the code.
> >=20
> >>>  - Duty-cycle calculation is unclear, the docs say:
> >>>
> >>>  	"on" time is on / (period + 1)
> >>>
> >>>    I suspect on time is $on / Fv though?
> >>
> >> Yes, that is also what the specification says, not sure why I wrote th=
at
> >> down TBH.
> >=20
> > OK. on / (period + 1) would be the relative duty cycle then.
> >=20
> >>>    But even with that I don't understand the +1 in
> >>>
> >>>  	dc =3D mul_u64_u64_div_u64(duty_ns + 1, rate, NSEC_PER_SEC);
> >>>
> >>> Can you enlighten me?
> >>
> >> I wish, this was 7 years ago, and I do not remember why there was a +1
> >> being added here, it might have been that this should have been a
> >> DIV_ROUND_UP().
> >=20
> > The most usual thing to do is to round down in .apply().
> >=20
> > To sum up: The hardware works in quantums Q =3D 2^16 / (W * 27 MHz).
> > (This is nice for W =3D 2^n: Q =3D 2^(16 - n) / (27 MHz))
> >=20
> > The period length is=20
> >=20
> > 	(PWM_PERIOD(channel) + 1) * Q
> >=20
> > and duty_cycle is defined by
> > =20
> > 	PWM_ON(channel) * Q
> >=20
> > . (No +1 there?)
>=20
> Yes, I think what you are saying here is correct and matches what is
> being described in the specification:
>=20
> In the case where cword < 2^15, a period in the output waveform consists
> of a single 1/27 microsecond HIGH pulse followed by LOW pulse for the
> rest of the period. In the case where cword =E2=89=A5 2^15, a period in t=
he
> output waveform consists of a single 1/27 microsecond LOW pulse followed
> by HIGH pulse for the rest of the period. In a sequence of pulse cycles,
> one cycle can have a duty cycle and period that is different from those
> of the other cycles. In order to have every cycle have exactly
> the same duty cycle and period, cword must be chosen such that
> cword=3D2^i,, i=3D0..15.

I don't understand the part "a single 1/27 microsecond", does that
assume PWM_ON(channel) =3D=3D 0 (or 1?). Otherwise bigger cword values seem
to enable inversed polarity, which might be a nice future expansion.

So non-power of two result in variing parameters such that in average
the period is (PWM_PERIOD(channel) + 1) * Q. The relative duty cycle is
right however. So for example if W =3D 0xc then every second period has
length 2^16 / (8 * 27 MHz) and the others have 2^16 / (16 * 27 MHz),
right? Well, probably they don't alternate, but we see a bunch of W=3D16
period by (the same ammount of) periods with W=3D8.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ilg3jt4qzxpmn3ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmInL98ACgkQwfwUeK3K
7AnF4gf/RhU3SS31yvkgJPhQ+6eowavthzBHUtTItsFnHooirGG745nPgVpPFBy5
aiznBFCU0WHcezZyshV3wAHu0nU8Y9Nzd4ofarI40mg9vJZd623xwQzdOca2AY8H
BB9al+2DT8CqBky+o05BkzRaWuuR/Nm/Orn6OLqpix272ObHwxNa4efSISdhHbxs
ohObDW1pZY/70+ROObXGzlC0mJe6hOzgHriNwuLkHl46n+UuxCyqmiUKQDK6I5qz
QAJ9v9YGWeZT+oDZdACzFJi9RQ3ScWx6h7pz08GwnWo6f39pp7hub5W2dfOIq6vZ
Lgyelt/Rt/Ro0o4bFplMIXuTfwFBNg==
=TBNl
-----END PGP SIGNATURE-----

--ilg3jt4qzxpmn3ca--
