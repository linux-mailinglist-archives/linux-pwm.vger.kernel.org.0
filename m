Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF103550B2
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhDFKTy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbhDFKTv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 06:19:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A79FC06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 03:19:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTio6-0001jX-Hh; Tue, 06 Apr 2021 12:19:38 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTio4-0005iA-DU; Tue, 06 Apr 2021 12:19:36 +0200
Date:   Tue, 6 Apr 2021 12:19:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [v3,PATCH 2/3] pwm: mtk_disp: convert the driver to atomic API
Message-ID: <20210406101936.uscvtvrd6opm5pgf@pengutronix.de>
References: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
 <1617703062-4251-3-git-send-email-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qrbjywyivatj7v7m"
Content-Disposition: inline
In-Reply-To: <1617703062-4251-3-git-send-email-rex-bc.chen@mediatek.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qrbjywyivatj7v7m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 06, 2021 at 05:57:41PM +0800, Rex-BC Chen wrote:
> @@ -84,33 +86,47 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	 * period =3D (PWM_CLK_RATE * period_ns) / (10^9 * (clk_div + 1)) - 1
>  	 * high_width =3D (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1))
>  	 */
> +	if (!mdp->enabled) {
> +		err =3D clk_prepare_enable(mdp->clk_main);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_main: %d\n",
> +				err);

Please use %pe, as this yields better readable error messages.

Also it might be sensible to first use the fact that (without patch 1
=66rom this series) the clocks are always on and then rework the clk usage
in a separate patch.

> +			return err;
> +		}
> +		err =3D clk_prepare_enable(mdp->clk_mm);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_mm: %d\n",
> +				err);
> +			clk_disable_unprepare(mdp->clk_main);
> +			return err;
> +		}
> +	}
>  	rate =3D clk_get_rate(mdp->clk_main);
> -	clk_div =3D div_u64(rate * period_ns, NSEC_PER_SEC) >>
> +	clk_div =3D div_u64(rate * state->period, NSEC_PER_SEC) >>
>  			  PWM_PERIOD_BIT_WIDTH;

rate * state->period might overflow, it would be great if this could be
catched. (But I don't consider this a stopper for this series.)

> -	if (clk_div > PWM_CLKDIV_MAX)
> +	if (clk_div > PWM_CLKDIV_MAX) {
> +		dev_err(chip->dev, "clock rate is too high: rate =3D %d Hz\n",
> +			rate);

rate is an u64, %d isn't the right format for it. Doesn't this result in
a compiler warning?

> +		clk_disable_unprepare(mdp->clk_mm);
> +		clk_disable_unprepare(mdp->clk_main);
>  		return -EINVAL;
> -
> +	}
>  	div =3D NSEC_PER_SEC * (clk_div + 1);
> -	period =3D div64_u64(rate * period_ns, div);
> +	period =3D div64_u64(rate * state->period, div);
>  	if (period > 0)
>  		period--;
> =20
> -	high_width =3D div64_u64(rate * duty_ns, div);
> +	high_width =3D div64_u64(rate * state->duty_cycle, div);
>  	value =3D period | (high_width << PWM_HIGH_WIDTH_SHIFT);
> -
> -	err =3D clk_enable(mdp->clk_main);
> -	if (err < 0)
> -		return err;
> -
> -	err =3D clk_enable(mdp->clk_mm);
> -	if (err < 0) {
> -		clk_disable(mdp->clk_main);
> -		return err;
> -	}
> +	polarity =3D 0;
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		polarity =3D PWM_POLARITY;

I'm unsure if support for polarity should be added en passant in this
patch. Maybe it would be clearer to add is separately.

>  	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
>  				 PWM_CLKDIV_MASK,
>  				 clk_div << PWM_CLKDIV_SHIFT);
> +	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> +				 PWM_POLARITY, polarity);
>  	mtk_disp_pwm_update_bits(mdp, mdp->data->con1,
>  				 PWM_PERIOD_MASK | PWM_HIGH_WIDTH_MASK,
>  				 value);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qrbjywyivatj7v7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBsNbUACgkQwfwUeK3K
7Ak7fQf/XD3gpjbGn1v9+zAGRP2jQEV4pv4oZAXPh3XfOHQWHauvAoPO81WdA0le
NrkVkX3fWnhpWRWTs360jrPenNfhc95Svv8ARekaI7WKBo2o6e4wEXIPnv94hk5l
usjD5WN7JFRcF9AMSfaOZyeKHf1hJ5KNWZvUfDxfljLgarAQNVCDsmnQ+HDQXMiy
osb93UYzmq6X5sKVKkP6kKja9qkkjQVQ1ydfBZU1LL7sZSCsCNEU9BE/lCEP/Cug
uIRF7rzxgYCgDYQmB9g1N5MBwg75Ur9ZeZC2YU3h1L26im6avqmf+v8xpfcT9WVF
hqrXsXRAZZodkucekqCFb1LCLMBLXw==
=ROQI
-----END PGP SIGNATURE-----

--qrbjywyivatj7v7m--
