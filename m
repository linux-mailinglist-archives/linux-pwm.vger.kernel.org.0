Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1DA438F21
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJYGKp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 02:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJYGKo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 02:10:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3CC061767
        for <linux-pwm@vger.kernel.org>; Sun, 24 Oct 2021 23:08:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1met9d-0000sy-BV; Mon, 25 Oct 2021 08:08:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1met9a-0001tE-Og; Mon, 25 Oct 2021 08:08:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1met9a-0006St-Ng; Mon, 25 Oct 2021 08:08:14 +0200
Date:   Mon, 25 Oct 2021 08:08:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     sean@mess.org, mchehab@kernel.org, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211025060812.pqwapyqni4vx75tc@pengutronix.de>
References: <YXU2i0FtAGDRCMSu@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c5jbsx2ilnzxwhem"
Content-Disposition: inline
In-Reply-To: <YXU2i0FtAGDRCMSu@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--c5jbsx2ilnzxwhem
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Oct 24, 2021 at 07:33:47AM -0300, Ma=EDra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>=20
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: Assign variables directly and simplify conditional statement
> V2 -> V3: Fix declaration of undeclared variable
> ---
>  drivers/media/rc/pwm-ir-tx.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index 4bc28d2c9cc9..e1f348a962e8 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -53,22 +53,21 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int=
 *txbuf,
>  {
>  	struct pwm_ir *pwm_ir =3D dev->priv;
>  	struct pwm_device *pwm =3D pwm_ir->pwm;
> -	int i, duty, period;
> +	struct pwm_state state;
> +	int i;
>  	ktime_t edge;
>  	long delta;
> =20
> -	period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> -	duty =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
> +	pwm_init_state(pwm, &state);
> =20
> -	pwm_config(pwm, duty, period);
> +	state.period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> +	state.duty_cycle =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * state.perio=
d, 100);
> =20
>  	edge =3D ktime_get();
> =20
>  	for (i =3D 0; i < count; i++) {
> -		if (i % 2) // space
> -			pwm_disable(pwm);
> -		else
> -			pwm_enable(pwm);
> +		state.enabled =3D !(i % 2);
> +		pwm_apply_state(pwm, &state);
> =20
>  		edge =3D ktime_add_us(edge, txbuf[i]);
>  		delta =3D ktime_us_delta(edge, ktime_get());
> @@ -76,7 +75,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *=
txbuf,
>  			usleep_range(delta, delta + 10);
>  	}
> =20
> -	pwm_disable(pwm);
> +	state.enabled =3D false;
> +	pwm_apply_state(pwm, &state);

I would have added a struct pwm_state to struct pwm_ir and then would
call pwm_init_state() only once in .probe(). But that's subjective if
you like it better or not, so do what you prefer.

The other changes look fine, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c5jbsx2ilnzxwhem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF2ScgACgkQwfwUeK3K
7Anhawf/dhik4GZyFmS1CHn7YL/6mtOQfOCHwMhaLigyUAqmjtuC7ZM9WqWhzfE2
sdAvJxh8KkP+K8M9vx6CHWtwipMBytT6biJOXS9xi0w6fGzv0Ax+CNEL8FVL/eQ/
DbJI46T4EDgKWD5rkZ5Xd9wdOukQ0pQg5AJnpxiF8qhZagmc9OsYPU85o+WqW+d0
E3z81hFe5g93RoFzsb094+u0iS+1nnuI5nh1/F7LsHkLlD7kvVZLtPvHrslJV3dJ
b0DBL3B3ZLTIu/l1EfZYD645fzL5OySWG2wy63XhUVSHKDNXSSE368P2TJBLusp1
Nptf94WxSIubEYTG8+Ol+PiqTo7u+w==
=9aJw
-----END PGP SIGNATURE-----

--c5jbsx2ilnzxwhem--
