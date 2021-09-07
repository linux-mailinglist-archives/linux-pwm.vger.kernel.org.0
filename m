Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A709402613
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Sep 2021 11:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbhIGJSq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Sep 2021 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbhIGJSp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Sep 2021 05:18:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81FBC061575
        for <linux-pwm@vger.kernel.org>; Tue,  7 Sep 2021 02:17:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNXEW-0006lE-UY; Tue, 07 Sep 2021 11:17:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNXEV-0000Jc-Nq; Tue, 07 Sep 2021 11:17:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNXEV-0007Nv-MV; Tue, 07 Sep 2021 11:17:35 +0200
Date:   Tue, 7 Sep 2021 11:17:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <long870912@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pwm: mediatek: Simplify using devm_pwmchip_add()
Message-ID: <20210907091735.wfuevpu5a6k4pmlj@pengutronix.de>
References: <20210906093030.459-1-long870912@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cicayrwrycvrz3k2"
Content-Disposition: inline
In-Reply-To: <20210906093030.459-1-long870912@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cicayrwrycvrz3k2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 06, 2021 at 05:30:30PM +0800, zhaoxiao wrote:
> With devm_pwmchip_add() we can drop pwmchip_remove() from the device
> remove callback. The latter can then go away, too and as this is the
> only user of platform_get_drvdata(), the respective call to
> platform_set_drvdata() can go, too.
>=20
> Signed-off-by: zhaoxiao <long870912@gmail.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index b4a31060bcd7..0d4dd80e9f07 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -253,13 +253,11 @@ static int pwm_mediatek_probe(struct platform_devic=
e *pdev)
>  		}
>  	}
> =20
> -	platform_set_drvdata(pdev, pc);
> -
>  	pc->chip.dev =3D &pdev->dev;
>  	pc->chip.ops =3D &pwm_mediatek_ops;
>  	pc->chip.npwm =3D pc->soc->num_pwms;
> =20
> -	ret =3D pwmchip_add(&pc->chip);
> +	ret =3D devm_pwmchip_add(&pdev->dev, &pc->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>  		return ret;
> @@ -268,13 +266,6 @@ static int pwm_mediatek_probe(struct platform_device=
 *pdev)
>  	return 0;
>  }
> =20
> -static int pwm_mediatek_remove(struct platform_device *pdev)
> -{
> -	struct pwm_mediatek_chip *pc =3D platform_get_drvdata(pdev);
> -
> -	return pwmchip_remove(&pc->chip);
> -}
> -
>  static const struct pwm_mediatek_of_data mt2712_pwm_data =3D {
>  	.num_pwms =3D 8,
>  	.pwm45_fixup =3D false,
> @@ -335,7 +326,6 @@ static struct platform_driver pwm_mediatek_driver =3D=
 {
>  		.of_match_table =3D pwm_mediatek_of_match,
>  	},
>  	.probe =3D pwm_mediatek_probe,
> -	.remove =3D pwm_mediatek_remove,
>  };
>  module_platform_driver(pwm_mediatek_driver);

A patch like this is already in next, see e0150252a6437d12de3db84bb3af12bd5=
aa5cc70

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cicayrwrycvrz3k2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE3LikACgkQwfwUeK3K
7AlE7Qf/Tlhd8lMXs//42d4oe2KisvZ+Hczlcm2gPRICv/V2NfQ2B8PHnsG/I74z
AZg8qckIiVoO+WfmYbJWT/W3vVFoZVfXsWIUwaLh8K4N5nNGId2rpAjuN+igSUQW
9PGBVKv69EAZKfjLkZj+IF5ZQWK/bmlIWk7U8btau8/C0c/VAZTRQAbTybLx5ocr
iYsnzyIKbBlujEq6pJgGIQXvD0WAeKW2uTf4LH1Ua+GUJkbfMnuDgdZ+/Q/BAy6g
q377k+Z0pLC8hC+lSn4LZA+VnuYTV0TyNIOz5Fo1WeYRhR2zvbCvVsDn4Ki8EIGR
IEUObIQ5ov52yHmVc8qbpHCY/2nmvQ==
=lWLd
-----END PGP SIGNATURE-----

--cicayrwrycvrz3k2--
