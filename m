Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E619444F64
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 07:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhKDG6o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 02:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKDG6l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 02:58:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2ECC061203
        for <linux-pwm@vger.kernel.org>; Wed,  3 Nov 2021 23:56:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miWf9-00025B-Eb; Thu, 04 Nov 2021 07:55:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miWf7-0004jB-Mt; Thu, 04 Nov 2021 07:55:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miWf7-0005vm-Ln; Thu, 04 Nov 2021 07:55:49 +0100
Date:   Thu, 4 Nov 2021 07:55:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     daniel.thompson@linaro.org, lee.jones@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5] backlight: lp855x: Switch to atomic PWM API
Message-ID: <20211104065546.dou3gwyrvdby5zec@pengutronix.de>
References: <YYLI/b7KcqM8wcEB@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfleujravmqpoch7"
Content-Disposition: inline
In-Reply-To: <YYLI/b7KcqM8wcEB@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sfleujravmqpoch7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 03, 2021 at 02:38:05PM -0300, Ma=EDra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: Initialize variable and simplify conditional loop
> V2 -> V3: Fix assignment of NULL variable
> V3 -> V4: Replace division for pwm_set_relative_duty_cycle
> V4 -> V5: Fix overwrite of state.period
> ---
>  drivers/video/backlight/lp855x_bl.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backligh=
t/lp855x_bl.c
> index e94932c69f54..e70a7b72dcf3 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
> =20
>  static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
>  {
> -	unsigned int period =3D lp->pdata->period_ns;
> -	unsigned int duty =3D br * period / max_br;
>  	struct pwm_device *pwm;
> +	struct pwm_state state;
> =20
>  	/* request pwm device with the consumer name */
>  	if (!lp->pwm) {
> @@ -245,18 +244,16 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int =
br, int max_br)
> =20
>  		lp->pwm =3D pwm;
> =20
> -		/*
> -		 * FIXME: pwm_apply_args() should be removed when switching to
> -		 * the atomic PWM API.
> -		 */
> -		pwm_apply_args(pwm);
> +		pwm_init_state(lp->pwm, &state);
> +		state.period =3D lp->pdata->period_ns;
> +	} else {
> +		pwm_get_state(lp->pwm, &state);
>  	}
> =20
> -	pwm_config(lp->pwm, duty, period);
> -	if (duty)
> -		pwm_enable(lp->pwm);
> -	else
> -		pwm_disable(lp->pwm);
> +	pwm_set_relative_duty_cycle(&state, br, max_br);
> +	state.enabled =3D state.duty_cycle;
> +
> +	pwm_apply_state(lp->pwm, &state);

Looks mostly right, but only on a deeper look into the driver. The
reason is that in the unmodified code there is always explicitly
period=3Dlp->pdata->period_ns; while after your change the period is unset
(and so the previously set period is used).

So either mention in the change log that this driver doesn't modify the
pwm settings in other places or preferably pick an equivalent conversion
(plus maybe an optimisation in a separate patch).

If you go the "equivalent conversion" path, please note that
pwm_set_relative_duty_cycle() isn't equivalent to br * period / max_br,
as it implements a different rounding.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sfleujravmqpoch7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGDg+8ACgkQwfwUeK3K
7AlpqwgAhJ3hLGHBwYaDtwQGm/cqztts3RbonqNohI6IhObp5RVnitTQXd8PYkob
+IDHUt5Bm+Q+0onBaFnklhZXNsBQYsQo1cJUAtl1IRLLJDGPOzcD7Yp5wJyb6LXN
IBFxTR9CsnHweeTlVh09Fucn1ZMQc5TPFDWEE7iJc/9N5qm+IBBCSGiH/RFS34rD
DWIajVqwkFQ8fMkrhHLb+rMwX6oaicIRYtSRBwi3mGTZveudu1w/5ZOzN/KCpBbh
UkKEQ4oHVvcDyB9dobQqE9c/4GYbeTy6WFMgv6ROjWy88yoW8N3EtsQwHhg1Vocx
pj2xjlI7C3iHr4CABid+ptgNTJaTng==
=jfLr
-----END PGP SIGNATURE-----

--sfleujravmqpoch7--
