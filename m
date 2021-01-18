Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B02F9AEE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Jan 2021 09:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbhARIDP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 03:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbhARIDH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jan 2021 03:03:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6CDC061573
        for <linux-pwm@vger.kernel.org>; Mon, 18 Jan 2021 00:02:26 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1PUV-0001J4-07; Mon, 18 Jan 2021 09:02:23 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1PUU-0005qe-C9; Mon, 18 Jan 2021 09:02:22 +0100
Date:   Mon, 18 Jan 2021 09:02:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: iqs620a: Correct a stale state variable
Message-ID: <20210118080219.ezxukoavyi5fklgr@pengutronix.de>
References: <1610686834-6149-1-git-send-email-jeff@labundy.com>
 <20210115074509.h6ytqb3dflbcud5z@pengutronix.de>
 <20210118043005.GB7479@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cv3losvwvqg2ka5i"
Content-Disposition: inline
In-Reply-To: <20210118043005.GB7479@labundy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cv3losvwvqg2ka5i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jeff,

On Sun, Jan 17, 2021 at 10:30:05PM -0600, Jeff LaBundy wrote:
> Thank you for taking a look; actually I came across this problem while
> testing your patch, so I owe you even more gratitude :)

:-)

> On Fri, Jan 15, 2021 at 08:45:09AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jan 14, 2021 at 11:00:34PM -0600, Jeff LaBundy wrote:
> > > If duty cycle is first set to a value that is sufficiently high to
> > > enable the output (e.g. 10000 ns) but then lowered to a value that
> > > is quantized to zero (e.g. 1000 ns), the output is disabled as the
> > > device cannot drive a constant zero (as expected).
> > >=20
> > > However if the device is later re-initialized due to watchdog bite,
> > > the output is re-enabled at the next-to-last duty cycle (10000 ns).
> > > This is because the iqs620_pwm->out_en flag unconditionally tracks
> > > state->enabled instead of what was actually written to the device.
> > >=20
> > > To solve this problem, force the iqs620_pwm->out_en flag to follow
> > > the IQS620_PWR_SETTINGS_PWM_OUT field instead, as was the original
> > > design intent.
> > >=20
> > > Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generat=
or")
> > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > ---
> > >  drivers/pwm/pwm-iqs620a.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > > index 5ede825..5eb8fa4 100644
> > > --- a/drivers/pwm/pwm-iqs620a.c
> > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > @@ -79,6 +79,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> > >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> > >  		if (ret)
> > >  			goto err_mutex;
> > > +
> > > +		iqs620_pwm->out_en =3D false;
> > >  	}
> > > =20
> > >  	if (duty_scale) {
> > > @@ -97,9 +99,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> > >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
> > >  		if (ret)
> > >  			goto err_mutex;
> > > -	}
> > > =20
> > > -	iqs620_pwm->out_en =3D state->enabled;
> > > +		iqs620_pwm->out_en =3D true;
> > > +	}
> >=20
> > I got the problem and I agree it needs fixing. Are you aware you change
> > the semantic of out_en here and so the behaviour of .get_state()? IMHO
> > the change is fine however, and unless I miss something this patch makes
> > the comment in iqs620_pwm_get_state true.
>=20
> Agreed on all counts; in fact I saw this as an improvement because the
> get_state callback now reflects the actual state of the hardware under
> all circumstances.
>=20
> As you mention, the comment in iqs620_pwm_get_state() is fully correct
> now too. Previously it was incorrect in this particular corner case.

ok, I wondered if I missed something.

> > Other than that I wonder if it would make more sense to track duty_scale
> > in the driver struct instead of duty_val and out_en.
>=20
> You would still have to cache state->enabled because it's required for
> decoding duty_scale at the time it was cached, so there is not much to
> gain. I prefer this solution because the get_state callback is correct
> across all cases now, and the change is small.

Can't we cope for this by just doing

	if (!state->enabled)
		duty_scale =3D 0;

?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cv3losvwvqg2ka5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAFQIgACgkQwfwUeK3K
7AkxJgf+O1wDh6kQOz11ri00jgnK6VMDBMcDeanVeYtgsD6i8CznP7El5QpZJ4Ov
A1JNsOj6rbAOJxqdLgnOT95yVXTHGTHcA7HX1u2MsBW1jmQ138oCro+vd7KrvNJT
ltq2fwKGsGE31njEzamQiVq2Gx+5VdiPBe0/eo80bnXRZ7i5QMOimG43JzizsQau
Z8sz+lau04Se1JPvzFV768a/d6P2W793xHLlY58GdRXMuvuyu0Ag63eLeWFzcaSb
uJ0WE+2KIMp0nmXpjZi8/OWjnPhk789si6DgxRychSJoEa72L95DKea9W8bxLHIV
xuMvZT7+MUm23ZgCjDkEIfe77DHj/w==
=W1UP
-----END PGP SIGNATURE-----

--cv3losvwvqg2ka5i--
