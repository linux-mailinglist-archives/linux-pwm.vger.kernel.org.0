Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF0750DA3D
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Apr 2022 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiDYHiH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Apr 2022 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiDYHiG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Apr 2022 03:38:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2E7DEDD
        for <linux-pwm@vger.kernel.org>; Mon, 25 Apr 2022 00:35:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nitFL-0007cR-18; Mon, 25 Apr 2022 09:34:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nitFL-0056VT-0k; Mon, 25 Apr 2022 09:34:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nitFI-005To7-RE; Mon, 25 Apr 2022 09:34:56 +0200
Date:   Mon, 25 Apr 2022 09:34:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] pwm: tegra: Optimize period calculation
Message-ID: <20220425073453.wdmryci6sli5riyu@pengutronix.de>
References: <20220303175012.358613-1-u.kleine-koenig@pengutronix.de>
 <YmLVd+krwW82N/ER@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g4ozgdtanqbjfq3i"
Content-Disposition: inline
In-Reply-To: <YmLVd+krwW82N/ER@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g4ozgdtanqbjfq3i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 06:19:03PM +0200, Thierry Reding wrote:
> On Thu, Mar 03, 2022 at 06:50:12PM +0100, Uwe Kleine-K=F6nig wrote:
> > Dividing by the result of a division looses precision because the resul=
t is
> > rounded twice. E.g. with clk_rate =3D 48000000 and period =3D 32760033 =
the
> > following numbers result:
> >=20
> > 	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH =3D 187500
> > 	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) =3D 3052
> > 	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) =3D 6144
> >=20
> > The exact result would be 6142.5061875 and (apart from rounding) this is
> > found by using a single division. As a side effect is also a tad
> > cheaper to calculate.
> >=20
> > Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
> > example clk_rate =3D 47999999 and period =3D 106667:
> >=20
> > 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
> > 			    NSEC_PER_SEC) =3D 19
> >=20
> > 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> > 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) =3D 20
> >=20
> > (The exact result is 20.000062083332033.)
> >=20
> > With this optimizations also switch from round-closest to round-down. G=
iven
> > that the calculations were non-optimal for quite some time now which
> > nobody reported as a problem, this is the opportunity to align the driv=
er's
> > behavior to the requirements of new drivers. (Note however that the
> > duty_cycle calculation isn't aligned yet.)
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-tegra.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index e5a9ffef4a71..7fc03a9ec154 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >  			    int duty_ns, int period_ns)
> >  {
> >  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> > -	unsigned long long c =3D duty_ns, hz;
> > +	unsigned long long c =3D duty_ns;
> >  	unsigned long rate, required_clk_rate;
> >  	u32 val =3D 0;
> >  	int err;
> > @@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >  		pc->clk_rate =3D clk_get_rate(pc->clk);
> >  	}
> > =20
> > -	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> > -
> >  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> > -	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> > -	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> > +	rate =3D mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> > +				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
> > =20
> >  	/*
> >  	 * Since the actual PWM divider is the register's frequency divider
> > @@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  	 */
> >  	if (rate > 0)
> >  		rate--;
> > +	else
> > +		return -EINVAL;
>=20
> Can you elaborate on why this is needed? Previously rate =3D=3D 0 was a
> valid case and this could still happen with the above calculations.

If the calculations before the if block result in rate =3D 0 this means
that the requested period is smaller than the minimal possible period.
So refusing this setting is part of the switch from
something-like-round-closest to round-down.

I will send a v2 explaining that in the commit log.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g4ozgdtanqbjfq3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJmTxoACgkQwfwUeK3K
7AmD5Qf+Pp++Ytd12r+32KstZJoMUdeYLZlWlUKWSh+1bXRpd2xI0XrVlZc+VKX9
QX7r/ojbKOlC8ZOyaVIAiMz8EcZ0pnSqETZD9AOiWdQuosIk+FYg3f3EYsSptDh7
GsRn4itDImfIAQX7POFEon40RtAsHW7Kw4gjLshCsiTY5fmZkzItk0eRflj5IqXa
H9DA8UMlQe/FPi8mKujlbYpHnnPiIwwFWrh0S2gUuosHqSL/RpMfnuXgWh64Q+7V
Z4mTbtE45E/b9zQEF+3m58VY1E+kSyqFgSGGW6SmussfVZHUVO5zj5pwg/VnMKzg
b6PMYemK4JmW3SYfmFcGxl9hEnOX3Q==
=pNNS
-----END PGP SIGNATURE-----

--g4ozgdtanqbjfq3i--
