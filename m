Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EAF63A27F
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 09:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK1ILB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 03:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiK1ILA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 03:11:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B925167E6
        for <linux-pwm@vger.kernel.org>; Mon, 28 Nov 2022 00:11:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZEA-0003af-2n; Mon, 28 Nov 2022 09:10:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZE8-000mMW-DY; Mon, 28 Nov 2022 09:10:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozZE8-000sKM-5l; Mon, 28 Nov 2022 09:10:56 +0100
Date:   Mon, 28 Nov 2022 09:10:56 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/6] pwm: pxa: Set duty cycle to 0 when disabling PWM
Message-ID: <20221128081056.klews27j6ngwtgi4@pengutronix.de>
References: <20221113233639.24244-1-doug@schmorgal.com>
 <20221113233639.24244-3-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wmab3e3ta4s4ndtj"
Content-Disposition: inline
In-Reply-To: <20221113233639.24244-3-doug@schmorgal.com>
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


--wmab3e3ta4s4ndtj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 13, 2022 at 03:36:35PM -0800, Doug Brown wrote:
> When disabling PWM, the duty cycle needs to be set to 0. This prevents
> the previous duty cycle from showing up momentarily when the clock is
> re-enabled next time.
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
> =20
>  	return 0;
>  }

This has the side effect that when going from

	.duty_cycle =3D A, .period =3D B, .enabled =3D false

to

	.duty_cycle =3D C, .period =3D D, .enabled =3D false

the register values for C and D are calculated and written into the
hardware without any win, but the net gain is still positive I think.
So:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wmab3e3ta4s4ndtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEbQwACgkQwfwUeK3K
7Ane1ggAml3aeJS+phBaSu4MiQoSo/Qti9s+NKR1SvibDSTabhLpgFyVHslyeSW8
pZErrItmMko88wY48Y+j9txYyDrkVfgE6g1Leybq4bRpNI2Zp2vIRDCBrMaYNvKD
Jf1dlL1nwbLdy4L5IY7z2FKi94Zi+7zdp2ofPxAL+e9ZcQ2tAkT7Un/gj+qJC9J/
L6QCrYTvvojyOEfeBaNbpfb6Ypsr2qWqqSvhbSCs2NOE/tnvCxPpMOXmJqqAnfQ/
jfBXsD2vkZr9LXo3spctwz6SbyAbBEK2m9toT390EUAzPUGhH4WVNe0JJE04F+yY
N2ifpXI28t5umzEh4hxehLqY0Bh19w==
=blcp
-----END PGP SIGNATURE-----

--wmab3e3ta4s4ndtj--
