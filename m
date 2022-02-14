Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A524B59FD
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357499AbiBNSfO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 13:35:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357482AbiBNSfO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 13:35:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E50652E4
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 10:35:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJgBj-0007Cd-Ad; Mon, 14 Feb 2022 19:35:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJgBi-00GbF7-7e; Mon, 14 Feb 2022 19:35:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJgBg-003BFG-RK; Mon, 14 Feb 2022 19:35:00 +0100
Date:   Mon, 14 Feb 2022 19:34:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
Message-ID: <20220214183457.fdio34lhxe2umpll@pengutronix.de>
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
 <83f9a9b2-4a01-1f98-4783-d221cc3adf4f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gb2cregpe7fmpny5"
Content-Disposition: inline
In-Reply-To: <83f9a9b2-4a01-1f98-4783-d221cc3adf4f@gmail.com>
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


--gb2cregpe7fmpny5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 09:18:49AM -0800, Florian Fainelli wrote:
> On 2/14/22 12:23 AM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > here are a few cleanups for the brcmstb PWM driver. There are a few
> > issues left with it, that I'm not addressing for now. Just mention it in
> > case someone wants to work on this driver:
> >=20
> >  - There is no .get_state() callback
> >    (That needs to be implemented by some with hardware and
> >    documentation)

Assuming you have access to documentation, can you confirm, that the
registers that define the PWM's behaviour are readable? If I knew that I
could come up with an implementation for .get_state().

> >  - There are a few places where an overflow can happen in
> >    brcmstb_pwm_config() that are not handled
> >=20
> >  - The loop in brcmstb_pwm_config() to calculate cword is ineffective,
> >    cword could be calculated ad hoc.
> >=20
> >  - I don't understand
> >=20
> >                 /*
> >                  * We can be called with separate duty and period updat=
es,
> >                  * so do not reject dc =3D=3D 0 right away
> >                  */
> >                 if (pc =3D=3D PWM_PERIOD_MIN || (dc < PWM_ON_MIN && dut=
y_ns))
> >                         return -EINVAL;
> >=20
> >    The usual policy is "With the selected period, pick the biggest
> >    possible duty_cycle that isn't bigger thatn the requested duty_cycle.
> >    So should this case be handled using dc =3D 0 instead?
> >    But as I don't understand the real issue here (is this about changing
> >    period and duty at the same time?), I don't want to touch that.
>=20
> IIRC, I was testing using a shell script that would exercise corner
> cases by modifying the /sys/class/pwm/*/{period,duty_cycle} separately
> was able to run into that. Let me see if I can dig up that script.

When you find it, it would be great to document the problem in a way
that it's still understandable some time later.

> Can you give me a day or two to make sure your changes work properly? I
> need to locate a board with an exposed PWM header so I can put a scope
> on it. Thanks!

Sure, in my experience it takes longer than two days on average until
Thierry picks up PWM patches. Thanks for your willingness to test!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gb2cregpe7fmpny5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIKoM4ACgkQwfwUeK3K
7An3wQf+Kvn4s9Tv/9oQmCJNr8INWBesU8uLZhFjSZp7Xl4IlaDiOnq6nk//Estb
pummx4EFeBthmTLJcUpTZ1LLyOSg+n47Vd+jGqUOkLHeblIWl7jwAjLdwMLT4AxP
eUH85JpY6x6k/3rBmtjgfA9RNfuUkwFxk6wp6DJxhEOTetfJU37BYhFsZUar03rH
3Gv/SDdTMHmz6OcuclRpil0a+6REJwzP2WrunrsToMn8zGoXr1mU3OWGEaR1vB9p
3+LQJFscQL3CMy1VDzNqZwyl1kSM5/hCNnylEab1qIspBRhTEos/Kqv5HFx4Wiv8
vCYjhUHSZb2OKt7GL+UK4x6yC8gFqA==
=aWKk
-----END PGP SIGNATURE-----

--gb2cregpe7fmpny5--
