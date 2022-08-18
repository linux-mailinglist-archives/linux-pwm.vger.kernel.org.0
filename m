Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B19597FA1
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Aug 2022 09:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243923AbiHRHyO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Aug 2022 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbiHRHyL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Aug 2022 03:54:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997346DB7
        for <linux-pwm@vger.kernel.org>; Thu, 18 Aug 2022 00:54:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOaLt-0001N8-Qr; Thu, 18 Aug 2022 09:54:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOaLs-000T6y-HP; Thu, 18 Aug 2022 09:54:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOaLr-00CU1m-UD; Thu, 18 Aug 2022 09:54:03 +0200
Date:   Thu, 18 Aug 2022 09:54:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-tegra@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <20220818075401.wguqvcbhzj5ttnio@pengutronix.de>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vrb75h43zlwa7b25"
Content-Disposition: inline
In-Reply-To: <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vrb75h43zlwa7b25
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Aug 15, 2022 at 09:09:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Aug 15, 2022 at 03:28:25AM +0300, Dmitry Osipenko wrote:
> > 25.04.2022 16:22, Uwe Kleine-K=C3=B6nig =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > Dividing by the result of a division looses precision because the res=
ult is
> > > rounded twice. E.g. with clk_rate =3D 48000000 and period =3D 3276003=
3 the
> > > following numbers result:
> > >=20
> > > 	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH =3D 187500
> > > 	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) =3D 3=
052
> > > 	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) =3D 6144
> > >=20
> > > The exact result would be 6142.5061875 and (apart from rounding) this=
 is
> > > found by using a single division. As a side effect is also a tad
> > > cheaper to calculate.
> > >=20
> > > Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
> > > example clk_rate =3D 47999999 and period =3D 106667:
> > >=20
> > > 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
> > > 			    NSEC_PER_SEC) =3D 19
> > >=20
> > > 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> > > 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) =3D 20
> > >=20
> > > (The exact result is 20.000062083332033.)
> > >=20
> > > With this optimizations also switch from round-closest to round-down =
for
> > > the period calculation. Given that the calculations were non-optimal =
for
> > > quite some time now with variations in both directions which nobody
> > > reported as a problem, this is the opportunity to align the driver's
> > > behavior to the requirements of new drivers. This has several upsides:
> > >=20
> > >  - Implementation is easier as there are no round-nearest variants of
> > >    mul_u64_u64_div_u64().
> > >  - Requests for too small periods are now consistently refused. This =
was
> > >    kind of arbitrary before, where period_ns < min_period_ns was
> > >    refused, but in some cases min_period_ns isn't actually implementa=
ble
> > >    and then values between min_period_ns and the actual minimum were
> > >    rounded up to the actual minimum.
> > >=20
> > > Note that the duty_cycle calculation isn't using the usual round-down
> > > approach yet.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > >=20
> > > changes since (implicit) v1: Updated changelog to explain why rate =
=3D 0
> > > is refused now.
> > >=20
> > > Best regards
> > > Uwe
> > >=20
> > >  drivers/pwm/pwm-tegra.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index e5a9ffef4a71..7fc03a9ec154 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> > >  			    int duty_ns, int period_ns)
> > >  {
> > >  	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> > > -	unsigned long long c =3D duty_ns, hz;
> > > +	unsigned long long c =3D duty_ns;
> > >  	unsigned long rate, required_clk_rate;
> > >  	u32 val =3D 0;
> > >  	int err;
> > > @@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > >  		pc->clk_rate =3D clk_get_rate(pc->clk);
> > >  	}
> > > =20
> > > -	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> > > -
> > >  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> > > -	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> > > -	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> > > +	rate =3D mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> > > +				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
> > > =20
> > >  	/*
> > >  	 * Since the actual PWM divider is the register's frequency divider
> > > @@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >  	 */
> > >  	if (rate > 0)
> > >  		rate--;
> > > +	else
> > > +		return -EINVAL;
> >=20
> > This patch broke backlight on Asus Transformer tablets, they are now
> > getting this -EINVAL. The root of the problem is under investigation.
>=20
> This means that you requested a period that is smaller than the minimal
> period the hardware can implement.
>=20
> What is the clk rate of the PWM clk (i.e. pc->clk_rate?). Looking at
> arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi I guess period is
> 4000000. That in turn would mean that
>=20
> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns, (u64)NSEC_PER_SEC << PWM_DU=
TY_WIDTH)
>=20
> returned 0 which (with the assumption period_ns =3D 4000000) would imply
> the clk rate is less than 64000.
>=20
> I don't know the machine, but some more information would be good: What
> is the actual clock rate? Can you please enable PWM_DEBUG (at compile
> time) and tracing (at runtime) (i.e.
>=20
> 	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
>=20
> ), reproduce the problem and provide the trace (i.e.
>=20
> 	cat /sys/kernel/debug/tracing/trace
>=20
> )?
>=20
> > Should we revert this patch meantime or maybe you (Uwe/Thierry) have an
> > idea about what actually has gone wrong here? Thanks in advance.
>=20
> I'd like to understand if the problem is indeed that the backlight
> driver requests a too small period. In this case I'd prefer to adapt the
> backlight device to use better pwm settings. If there is a problem in
> my change, this needs to be fixed. If you provide the above data, I can
> check the details.

I'd like to get this regression fixed and so a feedback from your side
would be highly appreciated. Without further input I'm unable to debug
this and a revert would be a sad outcome. Can you at least work out the
clk rate, which might be possible by looking into
/sys/kernel/debug/clk/clk_summary.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vrb75h43zlwa7b25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL98BYACgkQwfwUeK3K
7AlOdgf9G1XjCN2oz0aUHLpZuA2QSX8myEWYMyjrJf3K8x977HkKWLMNwQYb7JPO
CrMwFccCceqvjFLJucR/xABuAjWcHsOKKi9IIXcTj/JJN6ecMQxv3+bsrEOF0bjc
vvg51qnoUPKvyyoUPqVq3dVaJGETB1PrwCnffGqWPQXpL9uE0smi/MH/mHDqG0VB
wxq2DvF4AF5HZqwJ3ueM98btyusRfKcJKSisTPna16dMxarLriU+Lsh9pESR7fxY
dj6hK3uZbKWdogeycXx5k0cqsMGujKTGQZxWiCimiNTXFCsR5w535Y/ZDGOgY30w
fhmbSLI16qtE8mBskhZECfUQM8D9XA==
=wKKn
-----END PGP SIGNATURE-----

--vrb75h43zlwa7b25--
