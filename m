Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABD36A0E6
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Apr 2021 13:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhDXLaj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Apr 2021 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhDXLai (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Apr 2021 07:30:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D766AC061574
        for <linux-pwm@vger.kernel.org>; Sat, 24 Apr 2021 04:30:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1laGU3-0002HK-8M; Sat, 24 Apr 2021 13:29:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1laGU2-0003qz-F0; Sat, 24 Apr 2021 13:29:58 +0200
Date:   Sat, 24 Apr 2021 13:29:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: Make of_pwm_xlate_with_flags() work with
 #pwm-cells = <2>
Message-ID: <20210424112957.oqblunomm64tjtm5@pengutronix.de>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
 <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
 <YHBYaCWUrEH6Lz27@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v47h2cxpipweehhb"
Content-Disposition: inline
In-Reply-To: <YHBYaCWUrEH6Lz27@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--v47h2cxpipweehhb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Apr 09, 2021 at 03:36:40PM +0200, Thierry Reding wrote:
> On Mon, Mar 15, 2021 at 12:11:21PM +0100, Uwe Kleine-K=F6nig wrote:
> > The two functions of_pwm_simple_xlate() and of_pwm_xlate_with_flags() a=
re
> > quite similar. of_pwm_simple_xlate() only supports two pwm-cells while
> > of_pwm_xlate_with_flags() only support >=3D 3 pwm-cells. The latter can
> > easily be modified to behave identically to of_pwm_simple_xlate for two
> > pwm-cells. This is implemented here and allows to drop
> > of_pwm_simple_xlate() in the next commit.
> >=20
> > There is a small detail that is different now between of_pwm_simple_xla=
te()
> > and of_pwm_xlate_with_flags() with pwm-cells =3D <2>: pwm->args.polarit=
y is
> > unconditionally initialized to PWM_POLARITY_NORMAL in the latter. I did=
n't
> > find a case where this matters and doing that explicitly is the more
> > robust approach.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index b1adf3bb8508..39b0ad506bdd 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -126,8 +126,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const =
struct of_phandle_args *args)
> >  {
> >  	struct pwm_device *pwm;
> > =20
> > -	/* check, whether the driver supports a third cell for flags */
> > -	if (pc->of_pwm_n_cells < 3)
> > +	if (pc->of_pwm_n_cells < 2)
> >  		return ERR_PTR(-EINVAL);
> > =20
> >  	/* flags in the third cell are optional */
> > @@ -144,7 +143,8 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const =
struct of_phandle_args *args)
> >  	pwm->args.period =3D args->args[1];
> >  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> > =20
> > -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> > +	if (pc->of_pwm_n_cells >=3D 3 && args->args_count > 2 &&
> > +	    args->args[2] & PWM_POLARITY_INVERTED)
>=20
> This might more clearly look like a superset of of_pwm_xlate_simple() if
> you split up the conditional this way:
>=20
> 	if (pc->of_pwm_n_cells >=3D 3) {
> 		if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> 			...
> 	}

I'm not convinced here. Being (more) obviously a superset of
of_pwm_xlate_simple has very limited impact, as of_pwm_xlate_simple is
going away. Also I expect that a construct like that will attract monkey
patchers that will change the construct back to what I initially
suggested. (I'm surprised that there isn't a coccinelle recipe to
simplify such a construct, but maybe I just failed to find it.)
=20
But if that's your condition to merge this function, I can rework it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--v47h2cxpipweehhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCEATIACgkQwfwUeK3K
7AmYHAf8DifvSYJPwlX11TP4V54phrWNGtt2xPPZGUu+nupDkRa5JQVvcLRMsip3
GD2jQZ7CErah71DQIcWACbe6Pg3uc8lXPyuQ/DRQUC2eQUb54ssGB+s6FiGJlwKN
GcpOYBrbTKaBtbz7MsdEu6b36YyjhJj4H+tWmL4Y9ng7B7CeGTfgnVIn7ZhvES7O
ldhlBhWoLijK4EJm3XTT3uCjw+JEgkiu2Uz/RWWWqtGsYZ14HCrqVr8Wwjko4idL
I3nCj8OIpg7r45xwKrXXwm9KD+s3SIijMLp9vvpGAqBNEKCbEpbWJ1m4VbTIp3aH
0NkxggxeeFNRVkZueD6nQYYReztHCQ==
=mzq8
-----END PGP SIGNATURE-----

--v47h2cxpipweehhb--
