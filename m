Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6438445653
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhKDPcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKDPcD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 11:32:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A4C06127A
        for <linux-pwm@vger.kernel.org>; Thu,  4 Nov 2021 08:29:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mieg0-0008S0-B4; Thu, 04 Nov 2021 16:29:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miefy-0005Su-19; Thu, 04 Nov 2021 16:29:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miefy-0007jS-07; Thu, 04 Nov 2021 16:29:14 +0100
Date:   Thu, 4 Nov 2021 16:29:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] media: ir-rx51: Switch to atomic PWM API
Message-ID: <20211104152913.uqmmk6z7vppu5pxk@pengutronix.de>
References: <YX8VkdCAe6coHC4w@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="anrsmkijiyfufaxw"
Content-Disposition: inline
In-Reply-To: <YX8VkdCAe6coHC4w@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--anrsmkijiyfufaxw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 31, 2021 at 07:15:45PM -0300, Ma=EDra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: remove conceptually wrong chunk of code and correct the position
> of pwm_init_state function
> ---
>  drivers/media/rc/ir-rx51.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
> index a0d9c02a7588..41d4a4338072 100644
> --- a/drivers/media/rc/ir-rx51.c
> +++ b/drivers/media/rc/ir-rx51.c
> @@ -19,6 +19,7 @@
>  struct ir_rx51 {
>  	struct rc_dev *rcdev;
>  	struct pwm_device *pwm;
> +	struct pwm_state *state;
>  	struct hrtimer timer;
>  	struct device	     *dev;
>  	wait_queue_head_t     wqueue;
> @@ -32,22 +33,22 @@ struct ir_rx51 {
> =20
>  static inline void ir_rx51_on(struct ir_rx51 *ir_rx51)
>  {
> -	pwm_enable(ir_rx51->pwm);
> +	ir_rx51->state->enabled =3D true;
> +	pwm_apply_state(ir_rx51->pwm, ir_rx51->state);
>  }
> =20
>  static inline void ir_rx51_off(struct ir_rx51 *ir_rx51)
>  {
> -	pwm_disable(ir_rx51->pwm);
> +	ir_rx51->state->enabled =3D false;
> +	pwm_apply_state(ir_rx51->pwm, ir_rx51->state);
>  }
> =20
>  static int init_timing_params(struct ir_rx51 *ir_rx51)
>  {
> -	struct pwm_device *pwm =3D ir_rx51->pwm;
> -	int duty, period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
> +	struct pwm_state *state =3D ir_rx51->state;
> =20
> -	duty =3D DIV_ROUND_CLOSEST(ir_rx51->duty_cycle * period, 100);
> -
> -	pwm_config(pwm, duty, period);
> +	state->period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, ir_rx51->freq);
> +	pwm_set_relative_duty_cycle(state, ir_rx51->duty_cycle, 100);
> =20
>  	return 0;
>  }
> @@ -242,6 +243,7 @@ static int ir_rx51_probe(struct platform_device *dev)
> =20
>  	/* Use default, in case userspace does not set the carrier */
>  	ir_rx51.freq =3D DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SE=
C);
> +	pwm_init_state(pwm, ir_rx51.state);
>  	pwm_put(pwm);
> =20

Orthogonal to this patch I wonder why probe calls pwm_get() and
pwm_put(), just to have another call to pwm_get() in the open callback.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>


>  	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> --=20
> 2.31.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--anrsmkijiyfufaxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGD/EYACgkQwfwUeK3K
7Ak1UQf+NfOJSUtl3mRA28YnYB6CjGMtAy59xFUzIY6X9xrzP1nNy36NCJUalITO
T7ZL+y9ZfgGsZ4gmbb8kG2EPvD+pd9KiwU1HCY0esAq8M/Ap5ZwRXu1SeaH1LQYb
9BN41gXZ0aphBKU+jwWIXU2TXehrdGHRKmZImVRfDnfGw6UTwJMdsGeUnDkK0Mvm
FCeVadBfc7TYX5Y0sISQcanMaB1Gmg9gKzK+nnqoqgJKQc4Yuar4e5XkF3KN91Hu
Np1abLWz1MNDbhZTVtTUcy0qblq81YoroMYjb0K+GmK4Ug9AVtDB0QPgcNQsburu
850DdXYxowxH+F2oZFTRS5AmFYlHZw==
=4w8D
-----END PGP SIGNATURE-----

--anrsmkijiyfufaxw--
