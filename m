Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE12960FCA5
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Oct 2022 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiJ0QJV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Oct 2022 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiJ0QJU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Oct 2022 12:09:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E31849AE
        for <linux-pwm@vger.kernel.org>; Thu, 27 Oct 2022 09:09:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oo5RU-0006Vd-H3; Thu, 27 Oct 2022 18:09:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oo5RT-000jfF-Cm; Thu, 27 Oct 2022 18:09:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oo5RR-00B9wF-QW; Thu, 27 Oct 2022 18:09:13 +0200
Date:   Thu, 27 Oct 2022 18:09:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: tegra: Fix required rate when clock is lower
 than needed
Message-ID: <20221027160913.3wkz4ewmmh2z3xuk@pengutronix.de>
References: <20221026101305.30670-1-jonathanh@nvidia.com>
 <20221026101305.30670-2-jonathanh@nvidia.com>
 <20221026142301.3cgwqozpafpuu34k@pengutronix.de>
 <5bb9e817-9e4d-dd02-9c04-443efcf58226@nvidia.com>
 <20221027064003.22hx7iftdpg7s5hi@pengutronix.de>
 <89260f9f-a54b-108c-6144-5bcb06d5dc83@nvidia.com>
 <04d2c7ea-cfb1-b8a3-c1ad-39449a6a1701@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="de3xodq7j52epw7e"
Content-Disposition: inline
In-Reply-To: <04d2c7ea-cfb1-b8a3-c1ad-39449a6a1701@nvidia.com>
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


--de3xodq7j52epw7e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 04:40:04PM +0100, Jon Hunter wrote:
>=20
> On 27/10/2022 15:17, Jon Hunter wrote:
>=20
> ...
>=20
> > However, I see that I have been focused on the current issue in
> > front of me and this works. The alternative that I see would be to
> > stick with the maximum rate permitted ...
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 8a33c500f93b..2099ecca4237 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -148,12 +148,14 @@ static int tegra_pwm_config(struct pwm_chip *chip,
> > struct pwm_device *pwm,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 required_clk_rate =3D DI=
V_ROUND_UP_ULL((NSEC_PER_SEC <<
> > PWM_DUTY_WIDTH),
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 period_ns);
> >=20
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D dev_pm_opp_set_rate=
(pc->dev, required_clk_rate);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (err < 0)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret=
urn -EINVAL;
> > -
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Store the new rate for f=
urther references */
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pc->clk_rate =3D clk_get_ra=
te(pc->clk);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (required_clk_rate <=3D =
clk_round_rate(pc->clk,
> > required_clk_rate)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err=
 =3D dev_pm_opp_set_rate(pc->dev,
> > required_clk_rate);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if =
(err < 0)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* =
Store the new rate for further references */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pc-=
>clk_rate =3D clk_get_rate(pc->clk);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >  =A0=A0=A0=A0=A0=A0=A0 }
>=20
>=20
> Thinking about it some more, it is probably simpler and better to ...
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 8a33c500f93b..16855f7686db 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -148,6 +148,17 @@ static int tegra_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>                 required_clk_rate =3D DIV_ROUND_UP_ULL((NSEC_PER_SEC << P=
WM_DUTY_WIDTH),
>                                                      period_ns);
> +               /*
> +                * If the 'required_clk_rate' is greater than the clock r=
ate
> +                * that can be provided then we will fail to configure th=
e PWM,

This is unclear. clk_round_rate(pc->clk, required_clk_rate) isn't the
(maximal) rate that can be provided. It's just the rate you get when
requesting required_clk_rate.

> +                * because the 'rate' calculation below will return 0 and=
 which
> +                * will cause this function to return -EINVAL. To avoid t=
his, if
> +                * the 'required_clk_rate' is greater than the rate retur=
ned by
> +                * clk_round_rate(), set the PWM clock to the max frequen=
cy.
> +                */
> +               if (required_clk_rate > clk_round_rate(pc->clk, required_=
clk_rate))
> +                       required_clk_rate =3D ULONG_MAX;
> +

That looks wrong. Assume the clk can implement either

	51 MHz, 102 MHz, 204 MHz or 408 MHz

Say you want at least 52 MHz and clk_round_rate(..., 52000000) =3D
51000000. Then you want to pick 102 MHz, not 408 MHz, don't you?

>                 err =3D dev_pm_opp_set_rate(pc->dev, required_clk_rate);
>                 if (err < 0)
>                         return -EINVAL;
>=20
> Setting the 'required_clk_rate' to ULONG_MAX will cause the PWM to run
> at the max clock. For Tegra234, this is 408MHz (assuming the PLLP is the
> parent).

It's another implicit assumption that using ULONG_MAX configures the
maximal possible rate ...

I'd write:

	if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
		/*
		 * required_clk_rate is a lower bound for the input
		 * rate; for lower rates there is no value for PWM_SCALE
		 * that yields a period less than or equal to the
		 * requested period. So increase required_clk_rate.
		 *
		 * Some more talk about the properties of clk that
		 * motivate that doubling (or whatever you pick) is a
		 * sane strategy.
		 */
		required_clk_rate *=3D 2;

I'd not explain the details about the calculation, someone interested in
that will/should look at the code anyhow.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--de3xodq7j52epw7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNarSYACgkQwfwUeK3K
7AlEpQgAh2g9isTOAlc1ShrSHhrK3Q46nvkn0XZARW8pFXm8FEEKitSBT1FtvEqz
FM2M2jwuuBFyAaq3/CTBH+QRJoqAEA6qUtBE9t3zeW2lpOdkpZw9kPWT26pBhk3D
8ZYNToHYG1x3kKqmBbaDxJmRO3nBCSAZ/5JOBFUeKxXZfn78BdYrZ/fn20Ul/ih8
RtoC2Q7cSzYh85Voehj4Vt9/jRxtgqHnJNzEXoHjibNNKT5d/FyHF34KNH5n5l7L
aneWm7RcUhZ0m4XWc44PdiiqPMceafrOGlYv5Pdn5trQDIrl5M7qf3GbPXaTVybX
dZo8Ij0NzgwgTDl3te3g90yJGkZz0Q==
=Gy7z
-----END PGP SIGNATURE-----

--de3xodq7j52epw7e--
