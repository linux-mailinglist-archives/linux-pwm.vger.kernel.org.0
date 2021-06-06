Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C48C39D1BA
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jun 2021 23:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFFVrW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Jun 2021 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFFVrW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Jun 2021 17:47:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562BC061766
        for <linux-pwm@vger.kernel.org>; Sun,  6 Jun 2021 14:45:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0aF-0005Yf-3o; Sun, 06 Jun 2021 23:45:27 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0aD-0005oY-Jc; Sun, 06 Jun 2021 23:45:25 +0200
Date:   Sun, 6 Jun 2021 23:45:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Flavio Suligoi <f.suligoi@asem.it>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 7/7] pwm: core: Simplify some devm_*pwm*() functions
Message-ID: <20210606214512.36ntagggat7wbhvh@pengutronix.de>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
 <20210531194947.10770-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p3seyr7qu6fpltut"
Content-Disposition: inline
In-Reply-To: <20210531194947.10770-7-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--p3seyr7qu6fpltut
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, May 31, 2021 at 10:49:47PM +0300, Andy Shevchenko wrote:
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch
>  drivers/pwm/core.c | 60 +++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6d4410bd9793..9f643414676b 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1059,9 +1059,9 @@ void pwm_put(struct pwm_device *pwm)
>  }
>  EXPORT_SYMBOL_GPL(pwm_put);
> =20
> -static void devm_pwm_release(struct device *dev, void *res)
> +static void devm_pwm_release(void *pwm)
>  {
> -	pwm_put(*(struct pwm_device **)res);
> +	pwm_put(pwm);
>  }
> =20
>  /**
> @@ -1077,19 +1077,16 @@ static void devm_pwm_release(struct device *dev, =
void *res)
>   */
>  struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id)
>  {
> -	struct pwm_device **ptr, *pwm;
> -
> -	ptr =3D devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct pwm_device *pwm;
> +	int ret;
> =20
>  	pwm =3D pwm_get(dev, con_id);
> -	if (!IS_ERR(pwm)) {
> -		*ptr =3D pwm;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	ret =3D devm_add_action_or_reset(dev, devm_pwm_release, pwm);
> +	if (ret)
> +		return ERR_PTR(ret);
> =20
>  	return pwm;
>  }
> @@ -1110,19 +1107,16 @@ EXPORT_SYMBOL_GPL(devm_pwm_get);
>  struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_nod=
e *np,
>  				   const char *con_id)
>  {
> -	struct pwm_device **ptr, *pwm;
> -
> -	ptr =3D devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct pwm_device *pwm;
> +	int ret;
> =20
>  	pwm =3D of_pwm_get(dev, np, con_id);
> -	if (!IS_ERR(pwm)) {
> -		*ptr =3D pwm;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	ret =3D devm_add_action_or_reset(dev, devm_pwm_release, pwm);
> +	if (ret)
> +		return ERR_PTR(ret);
> =20
>  	return pwm;
>  }
> @@ -1144,23 +1138,19 @@ struct pwm_device *devm_fwnode_pwm_get(struct dev=
ice *dev,
>  				       struct fwnode_handle *fwnode,
>  				       const char *con_id)
>  {
> -	struct pwm_device **ptr, *pwm =3D ERR_PTR(-ENODEV);
> -
> -	ptr =3D devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct pwm_device *pwm =3D ERR_PTR(-ENODEV);
> +	int ret;
> =20
>  	if (is_of_node(fwnode))
>  		pwm =3D of_pwm_get(dev, to_of_node(fwnode), con_id);
>  	else if (is_acpi_node(fwnode))
>  		pwm =3D acpi_pwm_get(fwnode);
> +	if (IS_ERR(pwm))
> +		return pwm;
> =20
> -	if (!IS_ERR(pwm)) {
> -		*ptr =3D pwm;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	ret =3D devm_add_action_or_reset(dev, devm_pwm_release, pwm);
> +	if (ret)
> +		return ERR_PTR(ret);
> =20

Another nice one:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p3seyr7qu6fpltut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC9QeMACgkQwfwUeK3K
7AnunwgAj+fZK1hM1Jp8n2rLPPJU3E/yhcn7MkQT3xzlqXC1Wygu6WtAcuPB3Tjs
yi0fhP6DWsmzN4ndnmLIolx8lESkoVZbxyJtPbn+5XfwjHLTZfHcxMNiJEx3w1jD
xW6lT1bR343OwzDvWDvVIpn5myF8jiQLoNtdPxUxMRu9KzPOnkb8Pj2WYXIfPCMK
R3iwd48RBicjUMN26eqB2Mvm8j8GJlDM4Jg1NFGVfC4h+EsMibf7qby0S4turi0b
m5Oe2KQeo4oJKIAPJMWqHqDyzTAfqRC2hrDHNwj/H8QAQvDIBYsF6Irmuia54ZLv
cUbVR34IIOBkRSZlgiLo35I0So5DKg==
=w/dp
-----END PGP SIGNATURE-----

--p3seyr7qu6fpltut--
