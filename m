Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1057F60E31E
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiJZOSR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Oct 2022 10:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiJZOSC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 10:18:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9C110B1E
        for <linux-pwm@vger.kernel.org>; Wed, 26 Oct 2022 07:18:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhEE-000626-Ny; Wed, 26 Oct 2022 16:17:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhEE-000Wa8-9w; Wed, 26 Oct 2022 16:17:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhEC-00ApU3-Lz; Wed, 26 Oct 2022 16:17:56 +0200
Date:   Wed, 26 Oct 2022 16:17:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: tegra: Improve required rate calculation
Message-ID: <20221026141754.22ohncsbb3efhuqb@pengutronix.de>
References: <20221026101305.30670-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdapvty5ap5jwdgd"
Content-Disposition: inline
In-Reply-To: <20221026101305.30670-1-jonathanh@nvidia.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gdapvty5ap5jwdgd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 26, 2022 at 11:13:04AM +0100, Jon Hunter wrote:
> For the case where dev_pm_opp_set_rate() is called to set the PWM clock
> rate, the requested rate is calculated as ...
>=20
>  required_clk_rate =3D (NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
>=20
> The above calculation may lead to rounding errors because the
> NSEC_PER_SEC is divided by 'period_ns' before applying the
> PWM_DUTY_WIDTH multiplication factor. For example, if the period is
> 45334ns, the above calculation yields a rate of 5646848Hz instead of
> 5646976Hz. Fix this by applying the multiplication factor before
> dividing and using the DIV_ROUND_UP macro which yields the expected
> result of 5646976Hz.
>=20
> Fixes: 1d7796bdb63a ("pwm: tegra: Support dynamic clock frequency configu=
ration")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index dad9978c9186..8a33c500f93b 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -145,8 +145,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		 * source clock rate as required_clk_rate, PWM controller will
>  		 * be able to configure the requested period.
>  		 */
> -		required_clk_rate =3D
> -			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
> +		required_clk_rate =3D DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH=
),
> +						     period_ns);

This also has the nice side effect that required_clk_rate doesn't become
zero any more for big period_ns values.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gdapvty5ap5jwdgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNZQZAACgkQwfwUeK3K
7AmBdQf/RVvG7wDygbuqFE4ng4UBWiPnjQJvydSiN7ZtQ8FdrZ2ZULdOT92CvFPR
a6+iBToILM1aNWcURH8uhGLwy996SRUBTLe+PWt+5dbW5blSgDW5lSZIkqXGgrHU
sJsy5mpK9mJzaQUJ/gqsZlk+L1Zl6qYmfwXR86MsDhh9DQYcgdKolPgKh9nexWkq
BBjXhvRvB5xJt1ywShDv0/Eus/41v8FgFq0c1Coy/GoM6q/ew5wJW8XEylKz7teu
DkFJRWEgdBr501JhKJ7pk3TukCO1LlzXfdCgb+qpt95ADmtErqmaD5aOeotnE/bg
qp1dXbPwasXXFwopCU245NULol+AIg==
=3R3k
-----END PGP SIGNATURE-----

--gdapvty5ap5jwdgd--
