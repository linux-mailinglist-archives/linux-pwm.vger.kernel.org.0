Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA939D1B6
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jun 2021 23:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFFVmr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Jun 2021 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhFFVmo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Jun 2021 17:42:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB0C061767
        for <linux-pwm@vger.kernel.org>; Sun,  6 Jun 2021 14:40:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0Vc-0005CC-Co; Sun, 06 Jun 2021 23:40:40 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq0Va-0005dm-Ku; Sun, 06 Jun 2021 23:40:38 +0200
Date:   Sun, 6 Jun 2021 23:40:20 +0200
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
Subject: Re: [PATCH v2 6/7] pwm: core: Remove unused devm_pwm_put()
Message-ID: <20210606214020.uqozakcf25enxwid@pengutronix.de>
References: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
 <20210531194947.10770-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x3gsu4ggk5mwxtl6"
Content-Disposition: inline
In-Reply-To: <20210531194947.10770-6-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--x3gsu4ggk5mwxtl6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 31, 2021 at 10:49:46PM +0300, Andy Shevchenko wrote:
> There are no users and seems no will come of the devm_pwm_put().
> Remove the function.
>=20
> While at it, slightly update documentation.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch
>  .../driver-api/driver-model/devres.rst        |  3 ++-
>  Documentation/driver-api/pwm.rst              |  3 ++-
>  drivers/pwm/core.c                            | 25 -------------------
>  include/linux/pwm.h                           |  5 ----
>  4 files changed, 4 insertions(+), 32 deletions(-)
>=20
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documenta=
tion/driver-api/driver-model/devres.rst
> index b2645870ef7e..cc1e0138ba9f 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -410,7 +410,8 @@ POWER
> =20
>  PWM
>    devm_pwm_get()
> -  devm_pwm_put()
> +  devm_of_pwm_get()
> +  devm_fwnode_pwm_get()
> =20
>  REGULATOR
>    devm_regulator_bulk_get()
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/=
pwm.rst
> index a7ca4f58305a..251e3f7be230 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -40,7 +40,8 @@ after usage with pwm_free().
> =20
>  New users should use the pwm_get() function and pass to it the consumer
>  device or a consumer name. pwm_put() is used to free the PWM device. Man=
aged
> -variants of these functions, devm_pwm_get() and devm_pwm_put(), also exi=
st.
> +variants of the getter, devm_pwm_get(), devm_of_pwm_get(),
> +devm_fwnode_pwm_get(), also exist.
> =20
>  After being requested, a PWM has to be configured using::
> =20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a27d7c2aa6fe..6d4410bd9793 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1166,31 +1166,6 @@ struct pwm_device *devm_fwnode_pwm_get(struct devi=
ce *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
> =20
> -static int devm_pwm_match(struct device *dev, void *res, void *data)
> -{
> -	struct pwm_device **p =3D res;
> -
> -	if (WARN_ON(!p || !*p))
> -		return 0;
> -
> -	return *p =3D=3D data;
> -}
> -
> -/**
> - * devm_pwm_put() - resource managed pwm_put()
> - * @dev: device for PWM consumer
> - * @pwm: PWM device
> - *
> - * Release a PWM previously allocated using devm_pwm_get(). Calling this
> - * function is usually not needed because devm-allocated resources are
> - * automatically released on driver detach.
> - */
> -void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
> -{
> -	WARN_ON(devres_release(dev, devm_pwm_release, devm_pwm_match, pwm));
> -}
> -EXPORT_SYMBOL_GPL(devm_pwm_put);
> -
>  #ifdef CONFIG_DEBUG_FS
>  static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
>  {
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 5bb90af4997e..1eaded57c666 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -417,7 +417,6 @@ struct pwm_device *devm_of_pwm_get(struct device *dev=
, struct device_node *np,
>  struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
>  				       struct fwnode_handle *fwnode,
>  				       const char *con_id);
> -void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
>  #else
>  static inline struct pwm_device *pwm_request(int pwm_id, const char *lab=
el)
>  {
> @@ -524,10 +523,6 @@ devm_fwnode_pwm_get(struct device *dev, struct fwnod=
e_handle *fwnode,
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> -
> -static inline void devm_pwm_put(struct device *dev, struct pwm_device *p=
wm)
> -{
> -}
>  #endif
> =20
>  static inline void pwm_apply_args(struct pwm_device *pwm)

Nice.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x3gsu4ggk5mwxtl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC9QMAACgkQwfwUeK3K
7AmwJQgAgOhofOmmOu9tnTQL41N9NDwethP6wxjCHxXYVZrGgOmBTBnG4+++kCdG
ukMa0HTHFbY9X24SvCp2g69vJQ3jHNR0dt+WmeEbrgrtHnvLamGbhUx1lB9oPFcO
EKCbHWpw3s9XoFUBc85X9LruMUGOqZpwG0qH6DstiRQSTR4WgruuG7CAAsoROYBT
jA9bMjEX9CGrfeBWbVFSG2zpU1/5zhzGL0BS0JpDrF/WwpY+nsSWstWPlU1cgcqN
OSq8skFc513otGySVdS9uPa/PzdTtNv/r5Z9oNNxLkBQcolELmql96l/lgLiyfKR
/jeaUVvmBq9cwoSCkyFQD8HUrDjeNw==
=hrpT
-----END PGP SIGNATURE-----

--x3gsu4ggk5mwxtl6--
