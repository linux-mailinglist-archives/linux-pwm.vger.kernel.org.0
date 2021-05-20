Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB65438AF9C
	for <lists+linux-pwm@lfdr.de>; Thu, 20 May 2021 15:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbhETNHV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 May 2021 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243371AbhETNHO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 May 2021 09:07:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1BC0610E3
        for <linux-pwm@vger.kernel.org>; Thu, 20 May 2021 05:47:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lji4v-0001Dk-Qz; Thu, 20 May 2021 14:47:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lji4u-0004FW-43; Thu, 20 May 2021 14:47:04 +0200
Date:   Thu, 20 May 2021 14:47:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "David A. Schleef" <ds@schleef.org>,
        Mori Hess <fmhess@users.sourceforge.net>,
        Truxton Fulton <trux@truxton.com>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 5/6] comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210520124703.37w3r2fnw3pjsjot@pengutronix.de>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
 <20210520122538.3470259-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="drt6bspysws4e3wb"
Content-Disposition: inline
In-Reply-To: <20210520122538.3470259-6-lee.jones@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--drt6bspysws4e3wb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Thu, May 20, 2021 at 01:25:37PM +0100, Lee Jones wrote:
> ... and mark it as __maybe_unused since not all users of the
> header file reference it.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/staging/comedi/drivers/ni_mio_common.c:163:35: warning: =E2=80=
=98range_ni_E_ao_ext=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>=20
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: "David A. Schleef" <ds@schleef.org>
> Cc: Mori Hess <fmhess@users.sourceforge.net>
> Cc: Truxton Fulton <trux@truxton.com>
> Cc: linux-staging@lists.linux.dev
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/comedi/drivers/ni_mio_common.c | 9 ---------
>  drivers/comedi/drivers/ni_stc.h        | 9 ++++++++-
>  2 files changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/comedi/drivers/ni_mio_common.c b/drivers/comedi/driv=
ers/ni_mio_common.c
> index 4f80a4991f953..37615b4e2c10d 100644
> --- a/drivers/comedi/drivers/ni_mio_common.c
> +++ b/drivers/comedi/drivers/ni_mio_common.c
> @@ -160,15 +160,6 @@ static const struct comedi_lrange range_ni_M_ai_628x=
 =3D {
>  	}
>  };
> =20
> -static const struct comedi_lrange range_ni_E_ao_ext =3D {
> -	4, {
> -		BIP_RANGE(10),
> -		UNI_RANGE(10),
> -		RANGE_ext(-1, 1),
> -		RANGE_ext(0, 1)
> -	}
> -};
> -
>  static const struct comedi_lrange *const ni_range_lkup[] =3D {
>  	[ai_gain_16] =3D &range_ni_E_ai,
>  	[ai_gain_8] =3D &range_ni_E_ai_limited,
> diff --git a/drivers/comedi/drivers/ni_stc.h b/drivers/comedi/drivers/ni_=
stc.h
> index fbc0b753a0f59..0822e65f709dd 100644
> --- a/drivers/comedi/drivers/ni_stc.h
> +++ b/drivers/comedi/drivers/ni_stc.h
> @@ -1137,6 +1137,13 @@ struct ni_private {
>  	u8 rgout0_usage;
>  };
> =20
> -static const struct comedi_lrange range_ni_E_ao_ext;
> +static const struct comedi_lrange __maybe_unused range_ni_E_ao_ext =3D {
> +	4, {
> +		BIP_RANGE(10),
> +		UNI_RANGE(10),
> +		RANGE_ext(-1, 1),
> +		RANGE_ext(0, 1)
> +	}
> +};

When you send this patch some time ago I wrote:

| I think a downside of this solution is that range_ni_E_ao_ext might be
| duplicated in the object files. (Ditto for the status quo BTW.)
|=20
| I think the right approach to fix the compiler warning and the
| duplication is to declare range_ni_E_ao_ext external in the header and
| keep the definition in ni_mio_common.c.

You didn't reply to that, so maybe you missed it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--drt6bspysws4e3wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCmWkQACgkQwfwUeK3K
7Am3yQf/QDEk6FnlXWz2XZJUtFPOfRT6SFJwexcP/05uMpdcRQ6k0ibtZpQDDEYF
+9VJBQs4ESJT8sZbj38q+wyLWxhQ+mbeLVz+N4wUwNti/qb0Uc71CV+MRPXLJZer
eauuRTSCxwwfUnM7IVXOdOLGzN7SfGK6wDE/0cv2xr/r65/8EfcFcPKKkCEBHV7V
+MJMq+y+efY9q/Q8CxCQ7TVe3SaWDbzMj529kzezj2rEtk9NOklTn4VRqATc4RV5
vRZ0E1EEy8tyROWZDSw6h+7mOtox9M22jgUAhukA28gOZauqArTsgtGWcjCI75GF
qc3qPQopf5IfFWYUsmbmNn47SJqikw==
=Yd+/
-----END PGP SIGNATURE-----

--drt6bspysws4e3wb--
