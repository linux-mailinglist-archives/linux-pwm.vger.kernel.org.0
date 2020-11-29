Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58452C7906
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Nov 2020 13:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgK2MEH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Nov 2020 07:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgK2MEH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Nov 2020 07:04:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36EC0613CF
        for <linux-pwm@vger.kernel.org>; Sun, 29 Nov 2020 04:03:27 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjLQH-0005Bh-Sg; Sun, 29 Nov 2020 13:03:21 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjLQG-0000Oq-6V; Sun, 29 Nov 2020 13:03:20 +0100
Date:   Sun, 29 Nov 2020 13:03:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: iqs620a: Fix overflow and optimize calculations
Message-ID: <20201129120318.gh2vv2x44amk3di2@pengutronix.de>
References: <20201127201051.GA32257@labundy.com>
 <20201127203244.3439478-1-uwe@kleine-koenig.org>
 <20201128010040.GA9235@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u6tsexjosjofhvql"
Content-Disposition: inline
In-Reply-To: <20201128010040.GA9235@labundy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--u6tsexjosjofhvql
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2020 at 07:00:40PM -0600, Jeff LaBundy wrote:
> Hi Uwe,
>=20
> Thank you for your work on this; a few comments below.
>=20
> On Fri, Nov 27, 2020 at 09:32:44PM +0100, Uwe Kleine-K=F6nig wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > If state->duty_cycle is 0x100000000000000, the previous calculation of
> > duty_scale overflows and yields a duty cycle ratio of 0% instead of
> > 100%. Fix this by comparing the requested duty cycle against the maximal
> > possible duty cycle first. This way it is possible to use a native
> > integer division instead of a (depending on the architecture) more
> > expensive 64bit division. Also duty_val cannot be bigger than 0xff which
> > allows to simplify the code a bit further down.
> >=20
> > Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator=
")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello Jeff,
> >=20
> > On Fri, Nov 27, 2020 at 02:10:51PM -0600, Jeff LaBundy wrote:
> > > I tested this patch on actual hardware but the newly calculated regis=
ter
> > > values are incorrect. We used to get:
> > >
> > > [...]
> > > >                     goto err_mutex;
> > > >     }
> > > > =20
> > > > -   if (duty_scale) {
> > > > -           u8 duty_val =3D min_t(u64, duty_scale - 1, 0xff);
> > > > -
> > > > +   if (duty_val) {
> > >=20
> > > This is part of the problem; the device's formula for duty cycle has a
> > > plus one that is getting dropped now (see comments in iqs620_pwm_appl=
y).
> >=20
> > Good catch, I indeed missed that - 1.
> >=20
> > This patch should be better in this regard.
> >=20
> > Thanks for particular attention and testing,
> > Uwe
> >=20
> >  drivers/pwm/pwm-iqs620a.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > index 7d33e3646436..6789e117f123 100644
> > --- a/drivers/pwm/pwm-iqs620a.c
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -46,7 +46,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >  {
> >  	struct iqs620_pwm_private *iqs620_pwm;
> >  	struct iqs62x_core *iqs62x;
> > -	u64 duty_scale;
> > +	u8 duty_val;
> >  	int ret;
> > =20
> >  	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > @@ -70,29 +70,31 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled =
to
> >  	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
> >  	 */
> > -	duty_scale =3D div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
> > +
> > +	if (state->duty_cycle < IQS620_PWM_PERIOD_NS)
> > +		duty_val =3D ((unsigned int)state->duty_cycle * 256) / IQS620_PWM_PE=
RIOD_NS;
> > +	else
> > +		duty_val =3D 256;
>=20
> The build gives a warning here since duty_val is a u8. Actually, I'm not
> a fan of calling this 'duty_val' since it has a different meaning than
> iqs620_pwm->duty_val (the cached version restored if the watchdog bites).

Argh, that's what you get if you want to just quickly get out a patch
:-\ Thanks again for your attention.

> >  	mutex_lock(&iqs620_pwm->lock);
> > =20
> > -	if (!state->enabled || !duty_scale) {
> > +	if (!state->enabled || !duty_val) {
> >  		ret =3D regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> >  		if (ret)
> >  			goto err_mutex;
> >  	}
> > =20
> > -	if (duty_scale) {
> > -		u8 duty_val =3D min_t(u64, duty_scale - 1, 0xff);
> > -
> > +	if (duty_val) {
> >  		ret =3D regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
> > -				   duty_val);
> > +				   duty_val - 1);
> >  		if (ret)
> >  			goto err_mutex;
> > =20
> >  		iqs620_pwm->duty_val =3D duty_val;
> >  	}
>=20
> This would need to change to iqs620_pwm->duty_val =3D duty_val - 1, other=
wise
> the wrong duty cycle will get restored in iqs620_pwm_notifier. However th=
is
> starts to look confusing.
>=20
> > =20
> > -	if (state->enabled && duty_scale) {
> > +	if (state->enabled && duty_val) {
> >  		ret =3D regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
> >  		if (ret)
> > --=20
> > 2.29.2
> >=20
>=20
> How about the patch below instead? It solves the overflow problem you fou=
nd,
> is minimally invasive and preserves the original intent. We still avoid t=
he
> 64-bit division which is unnecessary anyway given this device's fixed per=
iod
> of only 1 ms.
>=20
> Kind regards,
> Jeff LaBundy
>=20
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> index 7d33e36..a15a2aa 100644
> --- a/drivers/pwm/pwm-iqs620a.c
> +++ b/drivers/pwm/pwm-iqs620a.c
> @@ -46,7 +46,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  {
>  	struct iqs620_pwm_private *iqs620_pwm;
>  	struct iqs62x_core *iqs62x;
> -	u64 duty_scale;
> +	unsigned int duty_scale;
>  	int ret;
> =20
>  	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> @@ -70,7 +70,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
>  	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
>  	 */
> -	duty_scale =3D div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
> +	duty_scale =3D (unsigned int)min_t(u64, state->duty_cycle,
> +					 IQS620_PWM_PERIOD_NS) * 256 /
> +					 IQS620_PWM_PERIOD_NS;

I had problems parsing this. I'd prefer:

	if (state->duty_cycle < IQS620_PWM_PERIOD_NS) {
		unsigned int duty_cycle =3D state->duty_cycle;
		duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
	} else {
		duty_scale =3D 256;
	}

or maybe:

	unsigned int duty_cycle =3D min_t(u64, state->duty_cycle, IQS620_PWM_PERIO=
D_NS);
	duty_scale =3D state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;

(which depending on how clever the compiler is might be less effective
than the first suggestion).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u6tsexjosjofhvql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/DjgMACgkQwfwUeK3K
7An4SQf/V/yCY5U3mK2jJWf43VaeG/koaGj9wyA1OhFkK/yM6Upq+4LiYeplDR1C
SjGN+7Ep7i3SFluvmouIt5TlUXvhWHjtsD5LDG5DNUPo6SoytyIn9VbpVHHZ1afe
n7ORnK8k/alPSzUVT9wG1dMcwh+dDuCF7vySR21PvYZiFGgBStnE8OQsny28XHwj
fz5Z3eVUoX3ksNSog9cMTZLzRLn02++YmQThMfuYvZMXXo/gYvDPExSUWRuINL1d
DSnLz1Yya50EFh/NP/g5buUORnRppoPouy6gFsxh6j0x1V1OtwDdCObHQ67ks4yy
2uuklv7/3fyuyeB7ytdEF+QP8/mlAA==
=QToN
-----END PGP SIGNATURE-----

--u6tsexjosjofhvql--
