Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5F60E339
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiJZOXJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Oct 2022 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiJZOXI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 10:23:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FEFB721
        for <linux-pwm@vger.kernel.org>; Wed, 26 Oct 2022 07:23:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhJB-0006aD-HD; Wed, 26 Oct 2022 16:23:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhJB-000WaZ-EX; Wed, 26 Oct 2022 16:23:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhJ9-00ApUi-Pu; Wed, 26 Oct 2022 16:23:03 +0200
Date:   Wed, 26 Oct 2022 16:23:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: tegra: Fix required rate when clock is lower
 than needed
Message-ID: <20221026142301.3cgwqozpafpuu34k@pengutronix.de>
References: <20221026101305.30670-1-jonathanh@nvidia.com>
 <20221026101305.30670-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c6gzlqg6segkf7gx"
Content-Disposition: inline
In-Reply-To: <20221026101305.30670-2-jonathanh@nvidia.com>
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


--c6gzlqg6segkf7gx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2022 at 11:13:05AM +0100, Jon Hunter wrote:
> If the 'required_clk_rate' is greater than the clock rate that can be
> provided, then when mul_u64_u64_div_u64() is called to determine the
> 'rate' for the PWM divider, 0 will be returned. If 'rate' is 0, then we
> will return -EINVAL and fail to configure the PWM. Fix this by adding 1
> to the PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to ensure
> that 'rate' is greater or equal to 1. This fixes an issue on Tegra234
> where configuring the PWM fan fails.
>=20
> Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 8a33c500f93b..973e2c1533ab 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -148,6 +148,19 @@ static int tegra_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		required_clk_rate =3D DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH=
),
>  						     period_ns);
> =20
> +		/*
> +		 * If the 'required_clk_rate' is greater than the clock rate
> +		 * that can be provided, then when mul_u64_u64_div_u64() is
> +		 * called to determine the 'rate' for the PWM divider, 0 will
> +		 * be returned. If 'rate' is 0, then we will return -EINVAL and
> +		 * fail to configure the PWM. If this case, add 1 to the
> +		 * PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to
> +		 * ensure that 'rate' is greater or equal to 1.
> +		 */
> +		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
> +			required_clk_rate =3D DIV_ROUND_UP_ULL((NSEC_PER_SEC << (PWM_DUTY_WID=
TH + 1)),
> +							     period_ns);
> +

It's implicit knowledge that (roughly) doubling the clk rate is the
right value (i.e the minimal value to get a=20
clk_rate >=3D (NSEC_PER_SEC << PWM_DUTY_WIDTH) / period_ns?

>  		err =3D dev_pm_opp_set_rate(pc->dev, required_clk_rate);
>  		if (err < 0)
>  			return -EINVAL;

Is it obvious that dev_pm_opp_set_rate(pc->dev, ...) and
clk_round_rate() correlate enough that the latter tells anything about
the former? Would it make sense to use clk_set_rate instead of
dev_pm_opp_set_rate?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c6gzlqg6segkf7gx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNZQsAACgkQwfwUeK3K
7AlYwgf9FNJEDhC7KvgC06qpdr+DV+7HCJuurwgcWv/kWhrg7vBbDWKW6SHk0g+S
opD7q8k25VFlB6HjMkTwOID1vypgK7f4VZu2jl/SVVf59PRWIRKSeN1lVnVkpl/1
OQ2rqbvuYZPcRVija7uzGqkck8S40x9iUd+wmG4WRDms0HAwRyDz4lX3z5b/ivqW
XtSP3C3AJB7CMSQTCEyQ+GVsPR8GvpuBvet7haxufWSqHLVU3mInLugfqtrcn+y0
BM/5pwT7A1gBD/Q2WKuNrMDaM9YBc5txEdNDB0gKCyYHNUNy2NeoaD0mgfx04pLh
W//JQl1jmLxdkPWu72Qo6EZ1pESNsQ==
=pVkm
-----END PGP SIGNATURE-----

--c6gzlqg6segkf7gx--
