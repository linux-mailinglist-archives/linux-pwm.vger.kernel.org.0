Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D90E4D08B3
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 21:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiCGUpe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 15:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiCGUpd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 15:45:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E0F8118B
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 12:44:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRKDc-0003Bm-Rn; Mon, 07 Mar 2022 21:44:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRKDb-003IlA-OO; Mon, 07 Mar 2022 21:44:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRKDa-007eAO-Bp; Mon, 07 Mar 2022 21:44:34 +0100
Date:   Mon, 7 Mar 2022 21:44:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
Message-ID: <20220307204430.24h572t6ftvjqzaq@pengutronix.de>
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
 <20220307184750.qkbueadgqohbvv2g@pengutronix.de>
 <bfcda0d1-7855-7ab6-ef2c-950ead5f8b15@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxlj6j5lkfmlv6c6"
Content-Disposition: inline
In-Reply-To: <bfcda0d1-7855-7ab6-ef2c-950ead5f8b15@gmail.com>
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


--wxlj6j5lkfmlv6c6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Florian,

great to get answers from you in such a timely fashion. That helps a
lot!

On Mon, Mar 07, 2022 at 11:11:05AM -0800, Florian Fainelli wrote:
> On 3/7/22 10:47 AM, Uwe Kleine-K=F6nig wrote:
> > I have a few questions here looking in more detail into the brcmstb
> > driver:
> >=20
> >  - What happens on PWM_ON(channel) =3D 0?
> >    I guess it just emits a flat inactive line, and refusing a small
> >    duty_cycle that results in PWM_ON(channel) =3D 0 is just artificial?
> >=20
> >  - There is a line describing:
> >=20
> >    	W =3D cword, if cword < 2 ^ 15 else 16-bit 2's complement of cword
> >=20
> >    The driver only considers powers of two <=3D 2^15 for cword. Is the
> >    implementation just lazy, or is the comment misleading?
> >    At least s/</<=3D/ ?
> >    There is no sense in using a value > 2^15 as for each such value
> >    there is a smaller value with the same result, right?
>=20
> This was copied from the specification which now that you mention it,
> seems off by one in its formula, it should be <=3D. This is further
> confirmed with:
>=20
> pwm1_cword[15:0] must be less than or equal to 32768 when the
> variable-frequency PWM is used as a clock for the constant-frequency PWM.
> Reset value is 0x0.
>=20
> so I believe that the comment is wrong and so is the specification of
> the block that was used to write the driver.

OK, so the right thing would be:

	W =3D cword with cword <=3D 32768

and there is no limitation to powers of two. (However it's unclear to me
how this works in hardware for arbitrary values.)

> >  - clk_get_rate(p->clk) is expected to return 27 MHz, right?
> >    (Just for my understanding, not about to hardcode this in the code)
>=20
> That is right.

ok.

> >  - The explanation about period in the comment is:
> >=20
> >    	The period is: (period + 1) / Fv
> >=20
> >    so I would have expected:
> >=20
> >    	pc =3D (period_ns * clkrate * cword / (NSEC_PER_SEC << 16)) - 1
> >=20
> >    (assuming no overflows). However the -1 isn't in the code.

You didn't comment on that one, I still assume this to be correct, i.e.
the -1 must be coped for in the code.

> >  - Duty-cycle calculation is unclear, the docs say:
> >=20
> >  	"on" time is on / (period + 1)
> >=20
> >    I suspect on time is $on / Fv though?
>=20
> Yes, that is also what the specification says, not sure why I wrote that
> down TBH.

OK. on / (period + 1) would be the relative duty cycle then.

> >    But even with that I don't understand the +1 in
> >=20
> >  	dc =3D mul_u64_u64_div_u64(duty_ns + 1, rate, NSEC_PER_SEC);
> >=20
> > Can you enlighten me?
>=20
> I wish, this was 7 years ago, and I do not remember why there was a +1
> being added here, it might have been that this should have been a
> DIV_ROUND_UP().

The most usual thing to do is to round down in .apply().

To sum up: The hardware works in quantums Q =3D 2^16 / (W * 27 MHz).
(This is nice for W =3D 2^n: Q =3D 2^(16 - n) / (27 MHz))

The period length is=20

	(PWM_PERIOD(channel) + 1) * Q

and duty_cycle is defined by
=20
	PWM_ON(channel) * Q

=2E (No +1 there?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wxlj6j5lkfmlv6c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmImbqsACgkQwfwUeK3K
7AlpcAf9HfpHd/A9/RHRyht0U/6hlR4swHDAAnIGPFULGEgvXxNR/TsCwiVsWIxC
BYDeokluFQBMBtKxbYtqVS/C4Oco4EdC4PcpEGF/TeVLZwqdfZ16tct4uRECwBOU
yqBeMZtEVzVDLmpOgxaU1bUerHE4FveS3TjzJe3WvyAj9XyhTpWazg55yoC+JR2B
jsQBKKGho9Vu/C9/SEV2Pb8U7DN6hLG+MKCJuO35MU46SS+wDySU3FtIYb2cvB+0
nJEoK0RpD4dsQ+YLw32HlMKyagOUSZ4pmPTMthL/fSMD8Ll5jNrMyXFKCY7ZEq4U
K1H7TWzxn50WMD/4IYY3YJW7OaaJ7Q==
=1gj5
-----END PGP SIGNATURE-----

--wxlj6j5lkfmlv6c6--
