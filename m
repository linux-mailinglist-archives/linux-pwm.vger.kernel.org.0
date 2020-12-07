Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE12D1249
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLGNjm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 08:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgLGNjm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 08:39:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED18C0613D1
        for <linux-pwm@vger.kernel.org>; Mon,  7 Dec 2020 05:39:01 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmGjD-0007jn-NV; Mon, 07 Dec 2020 14:38:59 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmGjC-0004LY-UH; Mon, 07 Dec 2020 14:38:58 +0100
Date:   Mon, 7 Dec 2020 14:38:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: Drop function pwmchip_add_with_polarity()
Message-ID: <20201207133858.zokltzzafbwx7cil@pengutronix.de>
References: <20201205165146.3866846-1-uwe@kleine-koenig.org>
 <20201205165146.3866846-3-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cq4qtviw54r5rknb"
Content-Disposition: inline
In-Reply-To: <20201205165146.3866846-3-uwe@kleine-koenig.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cq4qtviw54r5rknb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 05, 2020 at 05:51:46PM +0100, Uwe Kleine-K=F6nig wrote:
> pwmchip_add() only calls pwmchip_add_with_polarity() and nothing else. All
> other users of pwmchip_add_with_polarity() are gone. So drop
> pwmchip_add_with_polarity() and move the code instead to pwmchip_add().
>=20
> The initial assignment to pwm->state.polarity is dropped. In every correct
> usage of the PWM API this value is overwritten later anyhow.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  include/linux/pwm.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index e4d84d4db293..8f4eefd129aa 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -392,8 +392,6 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_ca=
pture *result,
>  int pwm_set_chip_data(struct pwm_device *pwm, void *data);
>  void *pwm_get_chip_data(struct pwm_device *pwm);
> =20
> -int pwmchip_add_with_polarity(struct pwm_chip *chip,
> -			      enum pwm_polarity polarity);

I forgot the relevant change in drivers/pwm/core.c. I will resend.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cq4qtviw54r5rknb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/OMG8ACgkQwfwUeK3K
7Ak73wf+L8AM5mkvG4rmlM4HoNULGBj6Ikue0W9LP/pSNdcqcaLXQ1jZYEFT+i3X
NdSOJjI3DejJ4YNi+79Vcty4VN9NOpW6HpUtP04zGi+Z3c7l8UumrAtz63MXZR6G
0NyORw0d/H41d24H7LvrP4wtF65nf2YD3SLc34hkDcrpKlZYuATwZgxdV5yY8eWk
s+ucIzX4Za2Jl4MdSVE7+Wj8hfwDP4sSbUyA2OA2PrKQKflgjK1q85JXuD/K21ot
hzuXV9wMu6tOjZlCuPcY7iAMyQvyGS7w7+Eb9txH32paJh/nEZgzQ3xyTsLkX4r1
jfsUnurcrQ62MFwh0UnbPXl1u5AJBg==
=fmrx
-----END PGP SIGNATURE-----

--cq4qtviw54r5rknb--
