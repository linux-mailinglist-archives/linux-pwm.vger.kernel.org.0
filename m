Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85012DFABF
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Dec 2020 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLUKHD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 05:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLUKHD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 05:07:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2BC061248
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 01:05:59 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krH8e-0006ZX-Bt; Mon, 21 Dec 2020 10:05:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krH8b-0005kS-Tr; Mon, 21 Dec 2020 10:05:53 +0100
Date:   Mon, 21 Dec 2020 10:05:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] pwm: rockchip: Do not start PWMs not already
 running
Message-ID: <20201221090553.bopd2aaoheapww3r@pengutronix.de>
References: <cover.1608407584.git.simon@simonsouth.net>
 <0acdf3a78f670a2678e03b0bbbb01aa58a11ce9a.1608407584.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6ewec6fjisqcohp"
Content-Disposition: inline
In-Reply-To: <0acdf3a78f670a2678e03b0bbbb01aa58a11ce9a.1608407584.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d6ewec6fjisqcohp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 19, 2020 at 03:44:10PM -0500, Simon South wrote:
> Currently the Rockchip PWM driver enables the signal ("bus") clock for
> every PWM device it finds during probing, then disables it for any device
> that was not already enabled (such as by a bootloader) when the kernel
> started.
>=20
> Instead of starting PWMs unnecessarily, check first to see whether a devi=
ce

"starting PWM" here means enabling their clocks, right? I wouldn't
expect that this has any effect on the output, am I right?

> has already been enabled and if not, do not enable its signal clock.
>=20
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index f286a498b82c..b9faef3e9954 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -327,19 +327,6 @@ static int rockchip_pwm_probe(struct platform_device=
 *pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret =3D clk_prepare_enable(pc->pclk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
> -		clk_disable_unprepare(pc->clk);
> -		return ret;
> -	}

Just for my understanding: That you moved clk_prepare_enable(pc->pclk)
further down is not strictly necessary for your change, right?

> -
>  	platform_set_drvdata(pdev, pc);
> =20
>  	pc->data =3D id->data;
> @@ -353,12 +340,23 @@ static int rockchip_pwm_probe(struct platform_devic=
e *pdev)
>  		pc->chip.of_pwm_n_cells =3D 3;
>  	}
> =20
> +	ret =3D clk_prepare_enable(pc->pclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
> +		return ret;
> +	}
> +
>  	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
>  	enable_conf =3D pc->data->enable_conf;
>  	ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>  	enabled =3D ((ctrl & enable_conf) =3D=3D enable_conf);
> -	if (!enabled)
> -		clk_disable(pc->clk);
> +
> +	ret =3D enabled ? clk_prepare_enable(pc->clk) : clk_prepare(pc->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
> +		clk_disable_unprepare(pc->pclk);
> +		return ret;
> +	}

I'm not a big fan of this ?: construct. I'd prefer

	ret =3D clk_prepare(pc->clk);
	if (ret)
		...

	/* Keep the PWM clk enabled ... */
	enabled =3D ...
	if (enabled) {
		ret =3D clk_enable(pc->clk);
		if (ret)
			...
	}

even though it is less compact. A small benefit is that the error
message can be more accurate. (You wrote "Can't prepare bus clk" while
the problem might well be in the enable part, but mentioning "enable"
might also be misleading for the enabled =3D false case.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d6ewec6fjisqcohp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/gZW4ACgkQwfwUeK3K
7An41Af7BicETX9BFl6PnW9W+h+GTgxqQfwljOJkzhrJEzqYIAa8Q0/zvxeRTkCW
ktFMO+PLyStVNFVx6K4BixhmCYwpuJ69xswxt9gwB8NT/U3rnOAYp5bYpqDFfud3
SPCJ1iZCO7l8ywc/1wAK3Wlk2Z2RIaqLasRu1Kp7hn+Ue1txP2TjZ7Qf38QVfSZ7
0zTW8ThDs8px7LwzGrntklwoAnvyfJ0aSfbL8pHMmc0SOS05Jq5MwTSjPwjJESPf
22iEvPAb/+qPR+haY1YhKsmJe6mqvW8TH0MsZjlbKQViuzyuoquoSDFQN0YgwwuK
WHsEOF+BtQHocat/YtbS73E2+GG4kQ==
=fIeu
-----END PGP SIGNATURE-----

--d6ewec6fjisqcohp--
