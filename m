Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A889D2F73D0
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 08:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbhAOHpx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 02:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbhAOHpx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Jan 2021 02:45:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD6BC061757
        for <linux-pwm@vger.kernel.org>; Thu, 14 Jan 2021 23:45:13 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0JnC-0007te-Kd; Fri, 15 Jan 2021 08:45:10 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0JnB-0001jX-OW; Fri, 15 Jan 2021 08:45:09 +0100
Date:   Fri, 15 Jan 2021 08:45:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: iqs620a: Correct a stale state variable
Message-ID: <20210115074509.h6ytqb3dflbcud5z@pengutronix.de>
References: <1610686834-6149-1-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubwkxm6k2n4vzmpt"
Content-Disposition: inline
In-Reply-To: <1610686834-6149-1-git-send-email-jeff@labundy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ubwkxm6k2n4vzmpt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 11:00:34PM -0600, Jeff LaBundy wrote:
> If duty cycle is first set to a value that is sufficiently high to
> enable the output (e.g. 10000 ns) but then lowered to a value that
> is quantized to zero (e.g. 1000 ns), the output is disabled as the
> device cannot drive a constant zero (as expected).
>=20
> However if the device is later re-initialized due to watchdog bite,
> the output is re-enabled at the next-to-last duty cycle (10000 ns).
> This is because the iqs620_pwm->out_en flag unconditionally tracks
> state->enabled instead of what was actually written to the device.
>=20
> To solve this problem, force the iqs620_pwm->out_en flag to follow
> the IQS620_PWR_SETTINGS_PWM_OUT field instead, as was the original
> design intent.
>=20
> Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/pwm/pwm-iqs620a.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> index 5ede825..5eb8fa4 100644
> --- a/drivers/pwm/pwm-iqs620a.c
> +++ b/drivers/pwm/pwm-iqs620a.c
> @@ -79,6 +79,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
>  		if (ret)
>  			goto err_mutex;
> +
> +		iqs620_pwm->out_en =3D false;
>  	}
> =20
>  	if (duty_scale) {
> @@ -97,9 +99,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
>  		if (ret)
>  			goto err_mutex;
> -	}
> =20
> -	iqs620_pwm->out_en =3D state->enabled;
> +		iqs620_pwm->out_en =3D true;
> +	}

I got the problem and I agree it needs fixing. Are you aware you change
the semantic of out_en here and so the behaviour of .get_state()? IMHO
the change is fine however, and unless I miss something this patch makes
the comment in iqs620_pwm_get_state true.

Other than that I wonder if it would make more sense to track duty_scale
in the driver struct instead of duty_val and out_en.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ubwkxm6k2n4vzmpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmABSAIACgkQwfwUeK3K
7AkRtwf8DPi010h9lJhUMN10x2BkyhvdTaETJAVhWDZ66kvvbS8i1r/WNemfNAOY
NLjuz5KpCifET1qWzj5V7rz6bCHaJAS9m6CkJyVImxjxhMhffQNYisJm9PbAgDVA
M2w5VsOFf7a/+Eyp3mLRdJ1yaT26n20lfpixXDkLE2zEO0lDUghRg7Wm6UqFgz7L
RaXHRJAyDJeH/J8M8+SnpIs/UBB5C3ZURcNwBOYvYUl/J2LpM5XJ4kFRnQwVSI6t
WGCmoPmGrF1fnFxPv5hLqC9bkzZU5ZVO1Tc/IkVRMZqv5Z4LA6YNFHRgvv+HGCOp
JMTmBOpKC6N8HPIy1r6m+5I9BtinsA==
=JRVa
-----END PGP SIGNATURE-----

--ubwkxm6k2n4vzmpt--
