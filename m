Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740B03BDB3C
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jul 2021 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhGFQUR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Jul 2021 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhGFQUQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Jul 2021 12:20:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7BC06175F
        for <linux-pwm@vger.kernel.org>; Tue,  6 Jul 2021 09:17:36 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0nT5-0000oe-Jf; Tue, 06 Jul 2021 17:58:39 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0nT4-0006C4-UF; Tue, 06 Jul 2021 17:58:38 +0200
Date:   Tue, 6 Jul 2021 17:58:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH][next] pwm: core: remove redundant assignment to pointer
 pwm
Message-ID: <20210706155820.aiv3q6rxuer7kdco@pengutronix.de>
References: <20210706151133.33175-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="riyxwqzx72j4dx6f"
Content-Disposition: inline
In-Reply-To: <20210706151133.33175-1-colin.king@canonical.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--riyxwqzx72j4dx6f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[adding Andy and Rafael to Cc:]

On Tue, Jul 06, 2021 at 04:11:32PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The pointer pwm is being initialized with a value that is never read and
> it is being updated later with a new value. The initialization is
> redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a28c8639af5b..35e894f4a379 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -846,7 +846,7 @@ EXPORT_SYMBOL_GPL(of_pwm_get);
>   */
>  static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnod=
e)
>  {
> -	struct pwm_device *pwm =3D ERR_PTR(-ENODEV);
> +	struct pwm_device *pwm;
>  	struct fwnode_reference_args args;
>  	struct pwm_chip *chip;
>  	int ret;

LGTM:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

and if you want:

Fixes: e5c38ba9f281 ("pwm: core: Reuse fwnode_to_pwmchip() in ACPI case")

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--riyxwqzx72j4dx6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDkfZkACgkQwfwUeK3K
7AlLMwgAhQ9nLUAmov/R5/5jWOULsbdDQ/Hs+dazsSUFYvM5GtdyFJcELpSFBe9o
TXZ2Flb644fpel2B2V3/HcR936ECkKj1lPeFqnEtbrDQ5vVfPlW2O6hT2MX8WwCA
lA/a7bfIdBCcq57DdHDyEWik4cW6UqsaQ/y6ZXFQjY5tvQvf6nyRbYb4yNCdoU4Y
Z/dUb2ez4BqemcooWC4fUpz7pALadLYVGlHhtilNgMMkNaI1v7Rgxrlloy0567UN
wUnRsNbgB+O5bGZNAAP7jHe0PosYUy+SCFsIJrX5Pp8dxy49/TKVjMDTUfmMcqy8
00tbmPcFa+apHJsIqC9623hKI592iw==
=Z7Ye
-----END PGP SIGNATURE-----

--riyxwqzx72j4dx6f--
