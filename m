Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB12F455A
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 08:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbhAMHiR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 02:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbhAMHiQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 02:38:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A8C061575
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 23:37:36 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaii-0007zQ-8C; Wed, 13 Jan 2021 08:37:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzaig-0003aq-KN; Wed, 13 Jan 2021 08:37:30 +0100
Date:   Wed, 13 Jan 2021 08:37:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 4/7] pwm: rockchip: Eliminate potential race condition
 when probing
Message-ID: <20210113073730.q2dwcsqqlfg7b7et@pengutronix.de>
References: <cover.1608735481.git.simon@simonsouth.net>
 <88a446b3e7f6a9bd1d2c079926fcaa408622e480.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n43h467o55di3jtv"
Content-Disposition: inline
In-Reply-To: <88a446b3e7f6a9bd1d2c079926fcaa408622e480.1608735481.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n43h467o55di3jtv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Dec 23, 2020 at 11:01:06AM -0500, Simon South wrote:
> Commit 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running
> PWMs") introduced a potential race condition in rockchip_pwm_probe(): A
> consumer could enable an inactive PWM, or disable a running one, between
> rockchip_pwm_probe() registering the device via pwmchip_add() and checking
> whether it is enabled (to determine whether it was started by a
> bootloader). This could result in a device's PWM clock being either enabl=
ed
> once more than necessary, potentially causing it to continue running when
> no longer needed, or disabled once more than necessary, producing a warni=
ng
> from the kernel.
>=20
> Eliminate these possibilities by modifying rockchip_pwm_probe() so it
> checks whether a device is enabled before registering it rather than afte=
r.
>=20
> Also update the code that handles errors from pwmchip_add() to account for
> the fact a device's PWM clock may now be disabled and that its APB clock
> certainly is, and eliminate the "err_pclk" goto target as it is no longer
> of use.
>=20
> Fixes: 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running PW=
Ms")
> Reported-by: Trent Piepho <tpiepho@gmail.com>
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 3b1aa5daafff..d904a5d24885 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -289,6 +289,7 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)
>  	struct rockchip_pwm_chip *pc;
>  	struct resource *r;
>  	u32 enable_conf, ctrl;
> +	bool enabled;
>  	int ret, count;
> =20
>  	id =3D of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
> @@ -351,24 +352,27 @@ static int rockchip_pwm_probe(struct platform_devic=
e *pdev)
>  		pc->chip.of_pwm_n_cells =3D 3;
>  	}
> =20
> -	ret =3D pwmchip_add(&pc->chip);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> -		goto err_pclk;
> -	}
> -
>  	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
>  	enable_conf =3D pc->data->enable_conf;
>  	ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
> -	if ((ctrl & enable_conf) !=3D enable_conf)
> +	enabled =3D ((ctrl & enable_conf) =3D=3D enable_conf);

The outer parenthesis pair isn't necessary, please drop it.

> +	if (!enabled)
>  		clk_disable(pc->clk);
> =20
>  	clk_disable(pc->pclk);
> =20
> +	ret =3D pwmchip_add(&pc->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		if (enabled)
> +			clk_disable(pc->clk);
> +		clk_unprepare(pc->clk);
> +		clk_unprepare(pc->pclk);
> +		return ret;
> +	}
> +

If you do the pwmchip_add before the clock disable, you can continue to
only have a single and simpler error path. The critical part is to check
for the enabled hardware before.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n43h467o55di3jtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+ozgACgkQwfwUeK3K
7AkY7Af/cM6A/HXBxbuQW0Ha6evjCiL3JB5qptqhE31NJAIifFpkThIWfyKIsJrV
W5+seUZgqYTNocx5BajUnClq7r1Q0YVCJEcRmlqUg4dObg9yqzNyix281Es0FftC
3cmlGvLg6XbskeE1cnI1UO6HFGau+83e97LzArxBsr+i7PtwxrlaswU4uOMQTN61
m0ioGp+3Mf5HFUew7AgpZF2rCJRsqhMpPy4/GwDmhN98gKv5zTD4BWZHsFREX6rM
O27JcBmyd2/KbXFPfQhfiRzJGaylyw+MxGDL4lZY96FUpoGY9V3giU1dZuIlw4/x
ug7lq3FM1AOmSUabazWPfmslWt+d2A==
=jqso
-----END PGP SIGNATURE-----

--n43h467o55di3jtv--
