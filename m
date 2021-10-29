Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975443FB43
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhJ2LP0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 07:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhJ2LP0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 07:15:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEEAC061714
        for <linux-pwm@vger.kernel.org>; Fri, 29 Oct 2021 04:12:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPoa-0002o5-O7; Fri, 29 Oct 2021 13:12:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPoZ-0005Qv-GR; Fri, 29 Oct 2021 13:12:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPoZ-0002Ve-FG; Fri, 29 Oct 2021 13:12:51 +0200
Date:   Fri, 29 Oct 2021 13:12:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] media: ir-rx51: Switch to atomic PWM API
Message-ID: <20211029111232.soknq7mu3r65laar@pengutronix.de>
References: <YXqv339PJTHcGxJg@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hinosvmzhgot2cey"
Content-Disposition: inline
In-Reply-To: <YXqv339PJTHcGxJg@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hinosvmzhgot2cey
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ma=EDra,

On Thu, Oct 28, 2021 at 11:12:47AM -0300, Ma=EDra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
> ---
>  drivers/media/rc/ir-rx51.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
> index a0d9c02a7588..7a643a94e181 100644
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
> @@ -154,6 +155,8 @@ static int ir_rx51_open(struct rc_dev *dev)
>  		return res;
>  	}
> =20
> +	pwm_init_state(ir_rx51->pwm, ir_rx51->state);
> +

Doing this here introduces a change in behaviour. Better do this after
pwm_get().

>  	return 0;
>  }
> =20
> @@ -232,13 +235,9 @@ static int ir_rx51_probe(struct platform_device *dev)
>  	struct rc_dev *rcdev;
> =20
>  	pwm =3D pwm_get(&dev->dev, NULL);
> -	if (IS_ERR(pwm)) {
> -		int err =3D PTR_ERR(pwm);
> -
> -		if (err !=3D -EPROBE_DEFER)
> -			dev_err(&dev->dev, "pwm_get failed: %d\n", err);
> -		return err;
> -	}
> +	if (IS_ERR(pwm))
> +		return dev_err_probe(&dev->dev, PTR_ERR(pwm), "pwm_get failed: %ld\n",
> +				PTR_ERR(pwm));
> =20
>  	/* Use default, in case userspace does not set the carrier */
>  	ir_rx51.freq =3D DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm), NSEC_PER_SE=
C);

Conceptually this last hunk belongs in a separate patch. And you don't
need to repeat PTR_ERR(pwm), as dev_err_probe already emits this
information. So

	return dev_err_probe(&dev->dev, PTR_ERR(pwm), "pwm_get failed\n");

should be fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hinosvmzhgot2cey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF71xgACgkQwfwUeK3K
7An77gf9EJHqGJxmsw7fxJwBRnMdlUaRbvbjtsNEPYIZTUVQS9hdoywed1U0To+P
Kx55vOKpVEMJQH1dhxEv8KzXtr8iAxIp1c0z93F0KuEeaOYMJvM/OEw1yz8ucg4l
HWYF6ZO/szCGDVp4ML/UG1djUAfqptEupN1Mdm7xxH6Boo8a6WiWu2alMxkJd8eB
tch8shtihSlX4ve6qKwghOKmyJ1ZfYrW4RPff2Tvv8Pw2aBQIUuh1vJER/k/mJQE
0tbBGkVvFZpr8GipH89tAazx0vpqCdhywUch4CzIGpnQ48GOK7JgAsu446I5oj4Q
FEST/sIcvHW1/VEyFQeUXM9bt94Rlw==
=IcFh
-----END PGP SIGNATURE-----

--hinosvmzhgot2cey--
