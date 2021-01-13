Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4552F458B
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 08:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbhAMHuw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 02:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbhAMHuw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 02:50:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9005C061575
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 23:50:11 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaus-0000ll-V6; Wed, 13 Jan 2021 08:50:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaur-0003vV-S1; Wed, 13 Jan 2021 08:50:05 +0100
Date:   Wed, 13 Jan 2021 08:50:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 6/7] pwm: rockchip: Enable PWM clock of probed device
 only if running
Message-ID: <20210113075005.jftwu4ohrfyqwxyq@pengutronix.de>
References: <cover.1608735481.git.simon@simonsouth.net>
 <cb5a28d5fde04c09e9aace6ce619e445f895e0a8.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5gplgzhp6ryu6ma"
Content-Disposition: inline
In-Reply-To: <cb5a28d5fde04c09e9aace6ce619e445f895e0a8.1608735481.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--w5gplgzhp6ryu6ma
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 11:01:08AM -0500, Simon South wrote:
> Currently rockchip_pwm_probe() enables the PWM clock of every device it
> matches, then disables the clock unless the device itself appears to have
> been enabled (by a bootloader, presumably) before the kernel started.
>=20
> Simplify this by enabling (rather, keeping enabled) the PWM clock of only
> devices that are already running, as enabling the clock for any other
> device during probing is unnecessary.
>=20
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 80f5e69d9b8a..02da7370db70 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -327,12 +327,6 @@ static int rockchip_pwm_probe(struct platform_device=
 *pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
> -		return ret;
> -	}
> -

This undoes stuff that you introduced in patch 1. Don't you reintroduce
the problem that was fixed by this patch?

>  	ret =3D clk_prepare_enable(pc->pclk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
> @@ -357,8 +351,19 @@ static int rockchip_pwm_probe(struct platform_device=
 *pdev)
>  	enable_conf =3D pc->data->enable_conf;
>  	ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>  	enabled =3D ((ctrl & enable_conf) =3D=3D enable_conf);
> -	if (!enabled)
> -		clk_disable(pc->clk);
> +	if (enabled) {
> +		ret =3D clk_prepare_enable(pc->clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't enable PWM clk: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret =3D clk_prepare(pc->clk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't prepare PWM clk: %d\n", ret);
> +			return ret;
> +		}
> +	}

I don't see the advantage of this patch. In my eyes the code
complication doesn't justify the gain (i.e. prevent the PWM clock being
enabled for a few instructions).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w5gplgzhp6ryu6ma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+pisACgkQwfwUeK3K
7AlQaAf7BtwX2NHD5FfKxX+JWawz7fTZwrA29/G5ApFQoACZgw8cfKOx8ih2H1Nv
QldLTTalWLZkQYGjfxV4ssOy5rPVRqoq6olKZ42Mx+xJm6Mk9jWa9uMsxNR+p6k3
j2iFIoqcEgxoO9k4JVm7IiV0ZnjghSg9QfnnKC1sUNEXK7HUi6fFjBFBF/to33Mv
/G1ED4FyL8EK4cTTcB9ed/Wk3LRpmUbogeuGA0eCEdEH0cALI+eE3j4HOKwMWoZp
C7xhqyw+fO8irxJ6lMDjOLgqBsr7nI0jOAjEjyYf90tyCVtObkhUCwkHB4Vrtqv+
6UwDQax3DjpJl1jRuFw0OYc6tvyvMg==
=VKrV
-----END PGP SIGNATURE-----

--w5gplgzhp6ryu6ma--
