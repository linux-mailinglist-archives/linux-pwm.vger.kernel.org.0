Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB71165EE11
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jan 2023 15:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjAEOAm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Jan 2023 09:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjAEOAV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Jan 2023 09:00:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB3358318
        for <linux-pwm@vger.kernel.org>; Thu,  5 Jan 2023 05:58:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDQl2-0005Ob-KJ; Thu, 05 Jan 2023 14:58:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDQl1-0040N9-V2; Thu, 05 Jan 2023 14:58:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDQl1-00AQbv-7U; Thu, 05 Jan 2023 14:58:11 +0100
Date:   Thu, 5 Jan 2023 14:58:11 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Axel Lin <axel.lin@ingics.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: ab8500:
Message-ID: <20230105135811.2wrrfk43w7mouyvr@pengutronix.de>
References: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
 <a9e4c773-4cc3-60b7-d8fc-cf0956657209@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rsus5w6gdekmk4ky"
Content-Disposition: inline
In-Reply-To: <a9e4c773-4cc3-60b7-d8fc-cf0956657209@pengutronix.de>
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


--rsus5w6gdekmk4ky
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ahmad,

On Wed, Jan 04, 2023 at 10:21:56AM +0100, Ahmad Fatoum wrote:
> On 04.01.23 00:18, Uwe Kleine-K=F6nig wrote:
> > The .apply() callback only considered the 10 low bits of .duty_cycle and
> > didn't check .period at all.
> >=20
> > My best guess is the period is fixed at 1024 ns =3D 0x400 ns. Based on
> > that assumption refuse configurations that request a lower period (as
> > usual for PWM drivers) and configure a duty cycle of 0x3ff ns for all
> > bigger requests.
> >=20
> > This improves behaviour for a few requests:
> >=20
> >   request  | previous result | new result
> > -----------+-----------------+------------
> >  1024/1024 |          0/1024 |  1023/1024
> >  4000/5000 |        928/1024 |  1023/1024
> >  5000/5000 |        904/1024 |  1023/1024
> >=20
> > (Values specified as duty_cycle / period in ns)
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-ab8500.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
> > index ad37bc46f272..a7f64371449b 100644
> > --- a/drivers/pwm/pwm-ab8500.c
> > +++ b/drivers/pwm/pwm-ab8500.c
> > @@ -37,6 +37,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >  	u8 reg;
> >  	unsigned int higher_val, lower_val;
> >  	struct ab8500_pwm_chip *ab8500 =3D ab8500_pwm_from_chip(chip);
> > +	unsigned int duty_cycle;
> > =20
> >  	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >  		return -EINVAL;
> > @@ -52,16 +53,25 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  		return ret;
> >  	}
> > =20
> > +	/* The period is fixed at 0x400 ns */
> > +	if (state->period < 0x400)
>=20
> If it's fixed, why < instead of =3D=3D ?

The usual policy for a driver is to configure the hightest period not
bigger than the requested policy. As this HW only does 0x400 ns, it
implements 0x400 if the request is >=3D 0x400 and fails otherwise.
=20
> > +		return -EINVAL;
> > +
> > +	if (state->duty_cycle >=3D 0x400)
> > +		duty_cycle =3D 0x3ff;
> > +	else
> > +		duty_cycle =3D state->duty_cycle;
>=20
> You can use duty_cycle =3D min(state->duty_cycle, 0x3ff); here

yes, (though I'd have to use

	duty_cycle =3D min_t(u64, state->duty_cycle, 0x3ff);

) but I think the original suggestion is easier to read.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rsus5w6gdekmk4ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO213AACgkQwfwUeK3K
7AnUtAf+Oyr2dy5TNFMAKto3W5jNP5GLpUwColxJ1OkgXKB5NK9xmSzU+iGUKTyt
1oBH6mjgKE8elHajtbgsyp8iYufyp4bgcv9BevpiklWQpyM+0p9RyOSdRYmidjoF
7C6v+9EHtmyZKyZYlDW6CgnB26UgjxWmL1u07lvBXUQcFV1Fe2gF+A9iu3DKC7xI
+Q0+yhO7L1P224WmDzVK9+Wrcavot64cD1Te64EhXg2bvx/hjUSniudgRAQGKDLV
mBDMWCVZbmAywEhtLP6KQBdp+PKYRvYKsIf3rv07cNSQIjjG4Z5f4m54pTbof1Cr
qYDP7pBfSFD8CFG9CRxiMPoQYNjNuw==
=lkfz
-----END PGP SIGNATURE-----

--rsus5w6gdekmk4ky--
