Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC412B09A8
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgKLQOb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 11:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgKLQOa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 11:14:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8643C0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 08:14:30 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdFEO-0004TX-DA; Thu, 12 Nov 2020 17:13:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdFEK-0003CG-Jf; Thu, 12 Nov 2020 17:13:48 +0100
Date:   Thu, 12 Nov 2020 17:13:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yangtao Li <tiny.windzz@gmail.com>, thierry.reding@gmail.com
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, nsaenzjulienne@suse.de, shc_work@mail.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, vz@mleia.com,
        slemieux.tyco@gmail.com, khilman@baylibre.com,
        matthias.bgg@gmail.com, heiko@sntech.de, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mripard@kernel.org, wens@csie.org,
        jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/32] pwm: sun4i: convert to
 devm_platform_ioremap_resource
Message-ID: <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rowms2wq4q6swhwc"
Content-Disposition: inline
In-Reply-To: <20191229080610.7597-1-tiny.windzz@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rowms2wq4q6swhwc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Sun, Dec 29, 2019 at 08:05:39AM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 581d23287333..f2afd312f77c 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -344,7 +344,6 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
>  static int sun4i_pwm_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_pwm_chip *pwm;
> -	struct resource *res;
>  	int ret;
> =20
>  	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> @@ -355,8 +354,7 @@ static int sun4i_pwm_probe(struct platform_device *pd=
ev)
>  	if (!pwm->data)
>  		return -ENODEV;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	pwm->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pwm->base))
>  		return PTR_ERR(pwm->base);

Can you please comment why you don't apply this series?

My point of view is:

devm_platform_ioremap_resource is the designated wrapper to replace
platform_get_resource() and devm_ioremap_resource(). So I don't see a
good reason to continue open coding it.

The patch series doesn't apply to 5.10-rc1 as is. (pwm-puv3 was removed
and a simple conflict in the pwm-rockchip driver.) The overall diffstat
(of the fixed series applied on top of 5.10-rc1) is

	31 files changed, 32 insertions(+), 96 deletions(-)

and it converts all of drivers/pwm but a single instance of
platform_get_resource() + devm_ioremap_resource() (for pwm-lpss where
platform_get_resource and devm_ioremap_resource are in different
functions (different files even)) which isn't trivial to fix.

So in my eyes applying this series is the right thing to do.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rowms2wq4q6swhwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+tXzcACgkQwfwUeK3K
7AnalAf/SZzHfPm53CAOPulFIMZojirosLfMqF/CurOTWDa4pXeZLIfqJ3XR0lAd
1A30iOU6Z6gsaXDu200KL3PWJ4aUlySBGynRmyn7mwEiHcoyNcuatCW2hIxQPptf
dIDBPh0Sz3nVjS3asUQnerG/hBoF4uOOMdH0zLLOgLIdX5sIYvN8A4UHIlcTrCXz
Am34c7Q2xtG+FheEtp4ytEFQ3TC4tZnOuam6jTUwRFRvHmXmhXQvWx6aRE/m+rz+
Sz9XQNgfwmLfEjdUiHzBzEXuhwC2bhndg5imcT3t6djVcxLqqqAL6zsd7n6myzan
2ry03AJ4yF68gU5nJbV8yuc9VDeqgg==
=2Q4E
-----END PGP SIGNATURE-----

--rowms2wq4q6swhwc--
