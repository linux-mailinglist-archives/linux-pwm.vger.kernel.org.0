Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42D27E1E5
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgI3G5a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 02:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3G53 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Sep 2020 02:57:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242AC061755
        for <linux-pwm@vger.kernel.org>; Tue, 29 Sep 2020 23:57:29 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNW3L-0004zy-JM; Wed, 30 Sep 2020 08:57:27 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNW3K-000771-Mv; Wed, 30 Sep 2020 08:57:26 +0200
Date:   Wed, 30 Sep 2020 08:57:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     poeschel@lemonage.de
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yd7x7geskr4c23jo"
Content-Disposition: inline
In-Reply-To: <20200929121953.2817843-1-poeschel@lemonage.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yd7x7geskr4c23jo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lars,

On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
>=20
> This adds a class to exported pwm devices.
> Exporting a pwm through sysfs did not yield udev events. The

I wonder what is your use-case here. This for sure also has a place to
be mentioned in the commit log. I suspect there is a better way to
accomplish you way.

> dev_uevent_filter function does filter-out devices without a bus or
> class.
> This was already addressed in commit
> commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
> but this did cause problems and the commit got reverted with
> commit c289d6625237 ("Revert "pwm: Set class for exported channels in
> sysfs"")
>=20
> pwm's have to be local to its pwmchip, so we create an individual class
> for each pwmchip

This sounds conceptually wrong.=20

> and assign this class to the pwm belonging to the
> pwmchip. This does better map to structure that is also visible in
> sysfs.
>=20
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  drivers/pwm/sysfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 449dbc0f49ed..e2dfbc335366 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -259,7 +259,7 @@ static int pwm_export_child(struct device *parent, st=
ruct pwm_device *pwm)
>  	export->child.release =3D pwm_export_release;
>  	export->child.parent =3D parent;
>  	export->child.devt =3D MKDEV(0, 0);
> -	export->child.groups =3D pwm_groups;
> +	export->child.class =3D parent->class;
>  	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
> =20
>  	ret =3D device_register(&export->child);
> @@ -499,6 +499,9 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
>  		dev_warn(chip->dev,
>  			 "device_create failed for pwm_chip sysfs export\n");
>  	}
> +
> +	parent->class =3D class_create(THIS_MODULE, parent->kobj.name);

This needs error handling.

> +	parent->class->dev_groups =3D pwm_groups;
>  }
> =20
>  void pwmchip_sysfs_unexport(struct pwm_chip *chip)
> @@ -518,6 +521,7 @@ void pwmchip_sysfs_unexport(struct pwm_chip *chip)
>  			pwm_unexport_child(parent, pwm);
>  	}
> =20
> +	class_destroy(parent->class);
>  	put_device(parent);
>  	device_unregister(parent);
>  }

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yd7x7geskr4c23jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl90LFMACgkQwfwUeK3K
7AkqLgf9HNGFermHCvQAxPAEhrUdVsZTfc2YRwG+g9Xh0kqUvSiE4qXkK4bdKVbY
NJpWm6pkZDty7dWarbqLCDs/mBccqrakGhe8ksoXtstzISQwHJoVssWv/11nLX1c
1HfngchkgTIIV3Nkm9LYe7gETxjCgyhxFkv8DSqFxAH1EprvXZe1i1FUJvxq6DJX
LfrO+760NTI/Hm21j5rJQlllBa0KYfBOB13PfTO51KK/WoljjdAXUnG1g+L6ArmK
HKChAxHk9VRPZpy+8hHQ7sMEqto3obsCaCXv6resbR2JPQvaKIZSBoKDIky3xJyA
Iq4rywxLRTWn/qxQhJ8fgwFyouwlKw==
=Brmu
-----END PGP SIGNATURE-----

--yd7x7geskr4c23jo--
