Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE02B7DAF
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 13:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKRMhO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 07:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKRMhN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 07:37:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E7C0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 04:37:13 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfMhy-0004pu-Bl; Wed, 18 Nov 2020 13:37:10 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfMhx-0005wL-GQ; Wed, 18 Nov 2020 13:37:09 +0100
Date:   Wed, 18 Nov 2020 13:37:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawn.guo@linaro.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: add missed clk_disable_unprepare() in zx_pwm_probe()
Message-ID: <20201118123707.ab5euxfvljsoi6md@pengutronix.de>
References: <1605702384-20911-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="delqm5cvyhuzjmks"
Content-Disposition: inline
In-Reply-To: <1605702384-20911-1-git-send-email-zhangchangzhong@huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--delqm5cvyhuzjmks
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 18, 2020 at 08:26:24PM +0800, Zhang Changzhong wrote:
> Add the missing clk_disable_unprepare() before return from
> zx_pwm_probe() in the error handling case.
>=20
> Fixes: 4836193c435c ("pwm: Add ZTE ZX PWM device driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> ---
>  drivers/pwm/pwm-zx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
> index e2c21cc..3763ce5 100644
> --- a/drivers/pwm/pwm-zx.c
> +++ b/drivers/pwm/pwm-zx.c
> @@ -238,6 +238,7 @@ static int zx_pwm_probe(struct platform_device *pdev)
>  	ret =3D pwmchip_add(&zpc->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> +		clk_disable_unprepare(zpc->pclk);
>  		return ret;

This is already fixed in next with:

	a278e8771f42 ("pwm: zx: Add missing cleanup in error path")

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--delqm5cvyhuzjmks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+1FXAACgkQwfwUeK3K
7AkFvwgAlqZbqWCqu66Zzd0zktnZwglQMr8xPa1M4sxqMciVKxnPjDeeXhs7MZYX
yEx6EwVBDpm5xg/Pa/NnR0g3uUYvI62vTt/UK6ucOnG/i+U6LUxMccx7Yb/9meyU
O/05IL+1db6XO5csP0Nd3zWPdj7y9VlWc3PZYMFWlQVzomFKwK1QkEICTmAozsuo
f37cw6QSKXk/45WmifmC1MnejnSriyZy16BC2FK/URNuYDWsrkDnojr4CaxRc/ai
JihRIQk/xn6ASbV23ijwwft4VX3jar2K/SXgvnUqkumOYo4uIDr5PUcm+XG8Z1hL
l6Zyl6BhRFpnXrgFZO3CdW9JaR2bDA==
=N8uy
-----END PGP SIGNATURE-----

--delqm5cvyhuzjmks--
