Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2B603AB4
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Oct 2022 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJSHe2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Oct 2022 03:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJSHeX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Oct 2022 03:34:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7047ABCD
        for <linux-pwm@vger.kernel.org>; Wed, 19 Oct 2022 00:34:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3al-00051k-FI; Wed, 19 Oct 2022 09:34:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3ak-0003y8-ON; Wed, 19 Oct 2022 09:34:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3aj-00917b-HH; Wed, 19 Oct 2022 09:34:17 +0200
Date:   Wed, 19 Oct 2022 09:34:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pwm: pxa: Set duty cycle to 0 when disabling PWM
Message-ID: <20221019073417.cck7lrfnzobj3hbk@pengutronix.de>
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-3-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzhqpqba36oqwk23"
Content-Disposition: inline
In-Reply-To: <20221003015546.202308-3-doug@schmorgal.com>
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


--wzhqpqba36oqwk23
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 06:55:43PM -0700, Doug Brown wrote:
> When disabling PWM, the duty cycle needs to be set to 0. This prevents
> the previous duty cycle from showing up momentarily when the clock is
> re-enabled next time, and also prevents the output pin from being stuck
> high when the clock is disabled.
>=20
> Because the clock has to be running in order to configure the duty
> cycle, unconditionally enable it early in pxa_pwm_apply and account for
> the correct enable count at the end.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/pwm/pwm-pxa.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 0ac052652c62..9ee9b41d62b8 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -105,24 +105,31 @@ static int pxa_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  			 const struct pwm_state *state)
>  {
>  	struct pxa_pwm_chip *pc =3D to_pxa_pwm_chip(chip);
> +	u64 duty_cycle;
>  	int err;
> =20
>  	if (state->polarity !=3D PWM_POLARITY_NORMAL)
>  		return -EINVAL;
> =20
> -	if (!state->enabled) {
> -		if (pwm->state.enabled)
> -			clk_disable_unprepare(pc->clk);
> +	err =3D clk_prepare_enable(pc->clk);
> +	if (err)
> +		return err;
> =20
> -		return 0;
> -	}
> +	duty_cycle =3D state->enabled ? state->duty_cycle : 0;
> =20
> -	err =3D pxa_pwm_config(chip, pwm, state->duty_cycle, state->period);
> -	if (err)
> +	err =3D pxa_pwm_config(chip, pwm, duty_cycle, state->period);
> +	if (err) {
> +		clk_disable_unprepare(pc->clk);
>  		return err;
> +	}
> +
> +	if (state->enabled && !pwm->state.enabled)
> +		return 0;
> +
> +	clk_disable_unprepare(pc->clk);
> =20
> -	if (!pwm->state.enabled)
> -		return clk_prepare_enable(pc->clk);
> +	if (!state->enabled && pwm->state.enabled)
> +		clk_disable_unprepare(pc->clk);

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wzhqpqba36oqwk23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNPqHYACgkQwfwUeK3K
7AmnKwgAhcLqrlZ2bQ4wx6e5fKEmBGDU5YPe46LOPoTouJF6WHPvxtVBur8mAVSt
bqomhXLLh0x2hGoVmYBzfFXKgw9lOFAxd/M768e0RGL824U7xWN2wKh0na8y+0cs
NNW+tfsuFwFxqmr3ac17D7mFgcRQFNrCgfs+qHUcQMAsIwGir3A0i0NqyuHEU312
h1aARHJZDdQR69Ft8HDLv2TCrc9XmweTxDUcyxNRFvna5rQ5Bjh63znzJHOOZ0l3
hjG0nKblZ3v7vkfwdg31G4dDEB6n3Ed7f117Tpunjalfw0SyWMYsfcSwr6dTnSLy
EAO7mFZFOey3Trzvdi+yxzIj7U9mnQ==
=NKXp
-----END PGP SIGNATURE-----

--wzhqpqba36oqwk23--
