Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05783602C8
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 08:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhDOG4O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 02:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDOG4N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 02:56:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8DC06175F
        for <linux-pwm@vger.kernel.org>; Wed, 14 Apr 2021 23:55:51 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWvub-000396-V3; Thu, 15 Apr 2021 08:55:37 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWvuZ-0006W1-P5; Thu, 15 Apr 2021 08:55:35 +0200
Date:   Thu, 15 Apr 2021 08:55:35 +0200
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
Subject: Re: [PATCH 55/57] staging: comedi: drivers: ni_mio_common: Move
 'range_ni_E_ao_ext' to where it is used
Message-ID: <20210415065535.eff56u7nhfhrcnl3@pengutronix.de>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-56-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4boi5bpfqf5gex7"
Content-Disposition: inline
In-Reply-To: <20210414181129.1628598-56-lee.jones@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f4boi5bpfqf5gex7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

nitpick: You move range_ni_E_ao_ext to the header. However that header
doesn't use range_ni_E_ao_ext, so the subject is technically wrong.

On Wed, Apr 14, 2021 at 07:11:27PM +0100, Lee Jones wrote:
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
>  drivers/staging/comedi/drivers/ni_mio_common.c | 9 ---------
>  drivers/staging/comedi/drivers/ni_stc.h        | 9 ++++++++-
>  2 files changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/sta=
ging/comedi/drivers/ni_mio_common.c
> index 4f80a4991f953..37615b4e2c10d 100644
> --- a/drivers/staging/comedi/drivers/ni_mio_common.c
> +++ b/drivers/staging/comedi/drivers/ni_mio_common.c
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
> diff --git a/drivers/staging/comedi/drivers/ni_stc.h b/drivers/staging/co=
medi/drivers/ni_stc.h
> index fbc0b753a0f59..0822e65f709dd 100644
> --- a/drivers/staging/comedi/drivers/ni_stc.h
> +++ b/drivers/staging/comedi/drivers/ni_stc.h
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

I think a downside of this solution is that range_ni_E_ao_ext might be
duplicated in the object files. (Ditto for the status quo BTW.)

I think the right approach to fix the compiler warning and the
duplication is to declare range_ni_E_ao_ext external in the header and
keep the definition in ni_mio_common.c.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f4boi5bpfqf5gex7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB342QACgkQwfwUeK3K
7AmX5gf/dIlnwiXhI52/OOiPEZTsrfSg1t8iPwITw1Kexfp+BiH0njLzCaDtiQSB
GrD7qoOw2/YCKCrJTErs+OJ+8dRmXWV7ynsFAf9vvDuNsnF+Mef9++t92If64pIu
DNf/VSorofSmfYgMrizczIi6qBufr3Of1s3ebBmrQbDiM8KHNwZTC60Fy6knnE95
3Pln3knZecUShJgGgilFyXLuPEl+lmgDD+X0tWNdRXkxY1HmeC07SlgRXYO+fPAk
TzqO62RJG6dM/nawDHT1VjucYmUknbr6bta8rbDJauKtDn2Hshb04dIyaDJNXCuB
cyhjtvS8nFxTR/rba97wd7Df8Wkmaw==
=lG+K
-----END PGP SIGNATURE-----

--f4boi5bpfqf5gex7--
