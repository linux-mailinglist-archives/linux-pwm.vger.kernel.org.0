Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A19241690
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 08:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgHKG6o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 02:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgHKG6o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2020 02:58:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31792C06174A
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 23:58:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5OF5-0002vO-Lb; Tue, 11 Aug 2020 08:58:39 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5OF4-0007LF-CG; Tue, 11 Aug 2020 08:58:38 +0200
Date:   Tue, 11 Aug 2020 08:58:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/3] pwm: imx1: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200811065838.762prkrizjwelod6@pengutronix.de>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
 <1597127072-26365-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzal7gs3glejz35a"
Content-Disposition: inline
In-Reply-To: <1597127072-26365-3-git-send-email-Anson.Huang@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vzal7gs3glejz35a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 02:24:32PM +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record t=
he
> defer probe reason etc., use it to simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- remove redundant return value print.
> ---
>  drivers/pwm/pwm-imx1.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
> index f8b2c2e..4877734 100644
> --- a/drivers/pwm/pwm-imx1.c
> +++ b/drivers/pwm/pwm-imx1.c
> @@ -145,23 +145,14 @@ static int pwm_imx1_probe(struct platform_device *p=
dev)
>  	platform_set_drvdata(pdev, imx);
> =20
>  	imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(imx->clk_ipg)) {
> -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> -				PTR_ERR(imx->clk_ipg));
> -		return PTR_ERR(imx->clk_ipg);
> -	}
> +	if (IS_ERR(imx->clk_ipg))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_ipg),
> +				     "getting ipg clock failed\n");
> =20
>  	imx->clk_per =3D devm_clk_get(&pdev->dev, "per");
> -	if (IS_ERR(imx->clk_per)) {
> -		int ret =3D PTR_ERR(imx->clk_per);
> -
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev,
> -				"failed to get peripheral clock: %d\n",
> -				ret);
> -
> -		return ret;
> -	}
> +	if (IS_ERR(imx->clk_per))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
> +				     "failed to get peripheral clock\n");

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vzal7gs3glejz35a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8yQZsACgkQwfwUeK3K
7AkU/gf/RzD6QZWQLtf59YcqnBvDyQOp4YiSY/I5co86uL8WsI2dogTz0USL1Tfg
50u3g/2aprZis+/E+7bIU8dyFdAYATiEunEm4OHCiM+YdPQcBpQ+yA2mg7KL4Maa
fo22LS6uW1Y8JmYlU39tJ9huE1cMDV0pGoeysEw4ijbdRvYlC+TtyYMBa621Of7w
lOOVibmvGybOOSesZ+KK2E1pAozWzHlMaQXtiPSZfHRhSZ3W1w3MXDyFZP04bzsX
PADEJvTHW7b9sKgtZVjrsqtf+NRfznoDw/eR6n90WOb3p9FfOX08E5M7QcUcN9B/
wVcbJqDKQWmVkp6LupV/l/gYlNns3w==
=54ql
-----END PGP SIGNATURE-----

--vzal7gs3glejz35a--
