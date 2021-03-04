Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6E32CD2E
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 07:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhCDGsc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 01:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbhCDGsS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Mar 2021 01:48:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0713C061756
        for <linux-pwm@vger.kernel.org>; Wed,  3 Mar 2021 22:47:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lHhlm-0001qV-G1; Thu, 04 Mar 2021 07:47:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lHhll-0005lH-Iu; Thu, 04 Mar 2021 07:47:33 +0100
Date:   Thu, 4 Mar 2021 07:47:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: imx-tpm: Use a single line for error message
Message-ID: <20210304064733.cx4fpc7z2kvg5jrj@pengutronix.de>
References: <20210304024242.2363294-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwnvyy6huiplilck"
Content-Disposition: inline
In-Reply-To: <20210304024242.2363294-1-festevam@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zwnvyy6huiplilck
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabio,

[expanding Cc: a bit]

On Wed, Mar 03, 2021 at 11:42:42PM -0300, Fabio Estevam wrote:
> There is no need to split the dev_err() call in three lines.
>=20
> Use a single line to improve readability.

For me the reason to like this change is more to save vertical space
without making readability worse, but *shrug*.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index aaf629bd8c35..eec9ec4e1a2a 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -411,9 +411,7 @@ static int __maybe_unused pwm_imx_tpm_resume(struct d=
evice *dev)
> =20
>  	ret =3D clk_prepare_enable(tpm->clk);
>  	if (ret)
> -		dev_err(dev,
> -			"failed to prepare or enable clock: %d\n",
> -			ret);
> +		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
> =20
>  	return ret;
>  }

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zwnvyy6huiplilck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBAgoEACgkQwfwUeK3K
7AmYBgf+M7Xa135Put73AGRJUjp5XPpIaGdFvZP6dzvnCRZvIILSPB/MVtdVH70+
Awjat2sPqHPCaTVT3YnVx315mDVxvRf0PVnwnZSKcduYqbyRO+ikjGv4NRRhlkk8
R4agaVEfNNUxNvh0fNW6cmg/XB++pkQ+kmEPynCj4XmfxXwU2anvrGj8foBCZqc/
h2ZsGS5mv2WcdhHv/PTnP/sRWLNtEI45VV6grHZU6QErPgcRm013qrHWV5sepTSa
hqV8jaco2obnRbf1j1vn3f2aqjX7UQB4dajdAHZJIrID4Qt6cZBIQEFCRMCUZzmu
ogiv6E+c5jRKrbbwjSD2RgciZ9ST+w==
=ojMc
-----END PGP SIGNATURE-----

--zwnvyy6huiplilck--
