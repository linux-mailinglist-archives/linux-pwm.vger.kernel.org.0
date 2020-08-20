Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406EB24BE97
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Aug 2020 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgHTNW5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 09:22:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42693 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgHTNWD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2020 09:22:03 -0400
X-Greylist: delayed 1132 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Aug 2020 09:22:02 EDT
Received: from [2001:67c:670:100:1d::c5] (helo=pty.hi.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k8kDU-00034P-23; Thu, 20 Aug 2020 15:02:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k8kDR-0007mv-8B; Thu, 20 Aug 2020 15:02:49 +0200
Date:   Thu, 20 Aug 2020 15:02:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        ed.blake@sondrel.com, linux-pwm@vger.kernel.org, wigyori@uid0.hu
Subject: Re: [PATCH] pwm: img: Fix null pointer access in probe
Message-ID: <20200820130239.2rawmesibu535ohl@pengutronix.de>
References: <20200815163115.11376-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vv7sdvy2pwae2ss5"
Content-Disposition: inline
In-Reply-To: <20200815163115.11376-1-hauke@hauke-m.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vv7sdvy2pwae2ss5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2020 at 06:31:15PM +0200, Hauke Mehrtens wrote:
> dev_get_drvdata() is called in img_pwm_runtime_resume() before the
> driver data is set.
> When pm_runtime_enabled() returns false in img_pwm_probe() it calls
> img_pwm_runtime_resume() which results in a null pointer access.

Is this a theoretical issue, or did you see this crash on a machine?
=20
> This patch fixes the problem by setting the driver data earlier in the
> img_pwm_probe() function.
>=20
> Fixes: e690ae526216 ("pwm: img: Add runtime PM")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/pwm/pwm-img.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 599a0f66a384..11831e885e1b 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -277,6 +277,8 @@ static int img_pwm_probe(struct platform_device *pdev)
>  		return PTR_ERR(pwm->pwm_clk);
>  	}
> =20
> +	platform_set_drvdata(pdev, pwm);
> +
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_PWM_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> @@ -313,7 +315,6 @@ static int img_pwm_probe(struct platform_device *pdev)
>  		goto err_suspend;
>  	}
> =20
> -	platform_set_drvdata(pdev, pwm);
>  	return 0;
> =20
>  err_suspend:
> @@ -322,6 +323,7 @@ static int img_pwm_probe(struct platform_device *pdev)
>  err_pm_disable:
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);

The driver core takes care about removing drvdata, so this hunk isn't
necessary.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vv7sdvy2pwae2ss5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8+dGIACgkQwfwUeK3K
7AkT/ggAl3dGZaPaXMaXz7qfAPLmCdYpMxwNuyLpH/3WoQ5oH3lBH/FHqWw95qyW
NG6qlxybWWmsxqKRKu9kVxWafeNPq0io63uKNKMODTc9F4K5prqqeHwhuW+RyERH
3Ej5o3LUMDvj9oSj8gsdF8WWSaEtCgtnSXKZQSZ57mxOMCjUHwIJTya1u9r4xpVK
ZNjkcsVpYcPpOwX+Iwfs0hdffOOO5PcKgLvlqdGXKH1KkQ5QXTTIc88dmhKllnou
TKY4z1l4heX2E2ygOiIaXim4NLDDiGReJk4mh82uNRRnBaAGjV5FKPfBzDK1hzmc
YcJ2uykwxvmMZx/dPp/e+KaIZPbMOQ==
=BtYK
-----END PGP SIGNATURE-----

--vv7sdvy2pwae2ss5--
