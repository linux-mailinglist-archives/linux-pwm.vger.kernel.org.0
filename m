Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E39592A1E
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Aug 2022 09:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiHOHJr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Aug 2022 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiHOHJq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Aug 2022 03:09:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F2713F3C
        for <linux-pwm@vger.kernel.org>; Mon, 15 Aug 2022 00:09:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oNUEG-0003BJ-FY; Mon, 15 Aug 2022 09:09:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oNUED-003sIM-3k; Mon, 15 Aug 2022 09:09:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oNUEE-00BnuS-OR; Mon, 15 Aug 2022 09:09:38 +0200
Date:   Mon, 15 Aug 2022 09:09:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpawvqiqe4n6jsay"
Content-Disposition: inline
In-Reply-To: <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cpawvqiqe4n6jsay
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 03:28:25AM +0300, Dmitry Osipenko wrote:
> Hi,
>=20
> 25.04.2022 16:22, Uwe Kleine-K=C3=B6nig =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
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
> > With this optimizations also switch from round-closest to round-down for
> > the period calculation. Given that the calculations were non-optimal for
> > quite some time now with variations in both directions which nobody
> > reported as a problem, this is the opportunity to align the driver's
> > behavior to the requirements of new drivers. This has several upsides:
> >=20
> >  - Implementation is easier as there are no round-nearest variants of
> >    mul_u64_u64_div_u64().
> >  - Requests for too small periods are now consistently refused. This was
> >    kind of arbitrary before, where period_ns < min_period_ns was
> >    refused, but in some cases min_period_ns isn't actually implementable
> >    and then values between min_period_ns and the actual minimum were
> >    rounded up to the actual minimum.
> >=20
> > Note that the duty_cycle calculation isn't using the usual round-down
> > approach yet.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > changes since (implicit) v1: Updated changelog to explain why rate =3D 0
> > is refused now.
> >=20
> > Best regards
> > Uwe
> >=20
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
> This patch broke backlight on Asus Transformer tablets, they are now
> getting this -EINVAL. The root of the problem is under investigation.

This means that you requested a period that is smaller than the minimal
period the hardware can implement.

What is the clk rate of the PWM clk (i.e. pc->clk_rate?). Looking at
arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi I guess period is
4000000. That in turn would mean that

	mul_u64_u64_div_u64(pc->clk_rate, period_ns, (u64)NSEC_PER_SEC << PWM_DUTY=
_WIDTH)

returned 0 which (with the assumption period_ns =3D 4000000) would imply
the clk rate is less than 64000.

I don't know the machine, but some more information would be good: What
is the actual clock rate? Can you please enable PWM_DEBUG (at compile
time) and tracing (at runtime) (i.e.

	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable

), reproduce the problem and provide the trace (i.e.

	cat /sys/kernel/debug/tracing/trace

)?

> Should we revert this patch meantime or maybe you (Uwe/Thierry) have an
> idea about what actually has gone wrong here? Thanks in advance.

I'd like to understand if the problem is indeed that the backlight
driver requests a too small period. In this case I'd prefer to adapt the
backlight device to use better pwm settings. If there is a problem in
my change, this needs to be fixed. If you provide the above data, I can
check the details.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cpawvqiqe4n6jsay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL58SwACgkQwfwUeK3K
7Am//wf/UIChFqLh4y3O7KpgTKmelh1+pUQ+su/UqctBq9Rr+DYMqhmnMqXVohvz
eNMPBW215BUrWMiX3JgRzOM8Rq4y4twtzi7Jzwk31/xK4Gv5pEUz7y2dKOAr804v
RH1Xo/Tbz9Y8jcZpoK2cNxvZqm55KKN9dbo6IGEdCHopOFXaEtqM33OKQxe4oDCE
AZoV2U/BlR9/G9NLPehtyoJpH7H+3QVfDFsAEk8fIjszUkS357wdwlfSyWTDzAqs
Nm1d2KgbBPinxCe8dHv5yHc8m0rFkdns9Eb8RUFczw1iPrvv6JcwlZkFWyCRcDcg
DIrxl33sgYFnOckaVuCNXkmAoDafFw==
=Kumz
-----END PGP SIGNATURE-----

--cpawvqiqe4n6jsay--
