Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9B9235102
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Aug 2020 09:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHAHVm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Aug 2020 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgHAHVl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Aug 2020 03:21:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C1CC06174A
        for <linux-pwm@vger.kernel.org>; Sat,  1 Aug 2020 00:21:41 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k1lpj-0005h2-W5; Sat, 01 Aug 2020 09:21:32 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k1lpi-0001it-Gr; Sat, 01 Aug 2020 09:21:30 +0200
Date:   Sat, 1 Aug 2020 09:21:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 4/6] pwm: cros-ec: Accept more error codes from
 cros_ec_cmd_xfer_status
Message-ID: <20200801072130.tmm7b4vtizshmmyo@pengutronix.de>
References: <20200726220101.29059-1-linux@roeck-us.net>
 <20200726220101.29059-5-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3weddawyjtsgyw2o"
Content-Disposition: inline
In-Reply-To: <20200726220101.29059-5-linux@roeck-us.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3weddawyjtsgyw2o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2020 at 03:00:59PM -0700, Guenter Roeck wrote:
> Since commit c5cd2b47b203 ("platform/chrome: cros_ec_proto: Report command
> not supported") we can no longer assume that cros_ec_cmd_xfer_status()
> reports -EPROTO for all errors returned by the EC itself. A follow-up
> patch will change cros_ec_cmd_xfer_status() to report additional errors
> reported by the EC as distinguished Linux error codes.
>=20
> Handle this change by no longer assuming that only -EPROTO is used
> to report all errors returned by the EC itself. Instead, support both
> the old and the new error codes.
>=20
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Added patch
>=20
>  drivers/pwm/pwm-cros-ec.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 09c08dee099e..ef05fba1bd37 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -213,20 +213,27 @@ static int cros_ec_num_pwms(struct cros_ec_device *=
ec)
>  		u32 result =3D 0;
> =20
>  		ret =3D __cros_ec_pwm_get_duty(ec, i, &result);
> -		/* We want to parse EC protocol errors */
> -		if (ret < 0 && !(ret =3D=3D -EPROTO && result))
> -			return ret;
> -
>  		/*
>  		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
>  		 * responses; everything else is treated as an error.
>  		 */

This comment is at least misleading now.

> -		if (result =3D=3D EC_RES_INVALID_COMMAND)
> +		switch (ret) {
> +		case -EOPNOTSUPP:	/* invalid command */
>  			return -ENODEV;

My first reaction here was to wonder why -EOPNOTSUPP isn't passed to the
upper layer. OK, this is a loop to test the number of available devices.

> -		else if (result =3D=3D EC_RES_INVALID_PARAM)
> +		case -EINVAL:		/* invalid parameter */
>  			return i;
> -		else if (result)
> +		case -EPROTO:
> +			/* Old or new error return code: Handle both */
> +			if (result =3D=3D EC_RES_INVALID_COMMAND)
> +				return -ENODEV;
> +			else if (result =3D=3D EC_RES_INVALID_PARAM)
> +				return i;

If I understand correctly this surprising calling convention (output
parameter is filled even though the function returned an error) is the
old one that is to be fixed.

>  			return -EPROTO;
> +		default:
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		}
>  	}
> =20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3weddawyjtsgyw2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8lF/cACgkQwfwUeK3K
7Aljxwf8CdiR6S9sD/CztU399KIbaE0uKqUCKCvY1/0R0KU7g8DOkHY3cQiONyZa
FxSU5PoBJygDvyyIxIH/IMJ1EM1LIQICzLEg+M+13vlIo8uJFLqZo2CmjjDGhRfw
svh2w9hQvw/g2nXiNm5AlAvmWfKdmd5Z0ltOpefhPmJxGFe8wqgpkN4bYmbA4VcD
MEQz4A6+67fqrbEpIXlGSN7wflWFqkYFyG1dfPnBuP0CLxt8jrwCO2w79ljqEggE
b0Y7FEXtgp9vVOodHFrmq4+MWvdhneoBk3xz2FTjON3UzZs2UfmGI5QwIIipkcvs
1TZNyp5DFlpOciTzPyZCccXgP70jMg==
=226A
-----END PGP SIGNATURE-----

--3weddawyjtsgyw2o--
