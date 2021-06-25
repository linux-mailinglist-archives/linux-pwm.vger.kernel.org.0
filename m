Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0083B4860
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFYRuT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRuT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 13:50:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C23C061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 10:47:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwpvk-0005hM-Jt; Fri, 25 Jun 2021 19:47:52 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwpvg-0006TE-Ep; Fri, 25 Jun 2021 19:47:48 +0200
Date:   Fri, 25 Jun 2021 19:47:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, cawa.cheng@mediatek.com,
        bibby.hsieh@mediatek.com, ck.hu@mediatek.com, stonea168@163.com,
        huijuan.xie@mediatek.com
Subject: Re: [PATCH v5 1/3] pwm: mtk-disp: adjust the clocks to avoid them
 mismatch
Message-ID: <20210625174748.ostcveo6bey4e7a7@pengutronix.de>
References: <20210616085224.157318-1-jitao.shi@mediatek.com>
 <20210616085224.157318-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xmk5ka4y4uxu4kd6"
Content-Disposition: inline
In-Reply-To: <20210616085224.157318-2-jitao.shi@mediatek.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xmk5ka4y4uxu4kd6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 04:52:22PM +0800, Jitao Shi wrote:
> The clks "main" and "mm" are prepared in .probe() (and
> unprepared in .remove()). This results in the clocks being on
> during suspend which results in unnecessarily increased power
> consumption.
>=20
> Remove the clock operations from .probe() and .remove().
> Add the clk_prepare_enable() in .config().
> Add the clk_disable_unprepare() in .disable().
> Remove the MT2701 double buffer comment.
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 116 ++++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 9b3ba401a3db..204d76beeb26 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -47,6 +47,7 @@ struct mtk_disp_pwm {
>  	struct clk *clk_main;
>  	struct clk *clk_mm;
>  	void __iomem *base;
> +	bool enabled;
>  };
> =20
>  static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
> @@ -74,6 +75,22 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	u64 div, rate;
>  	int err;
> =20
> +	if (!mdp->enabled) {
> +		err =3D clk_prepare_enable(mdp->clk_main);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n",
> +				ERR_PTR(err));
> +			return err;
> +		}
> +		err =3D clk_prepare_enable(mdp->clk_mm);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n",
> +				ERR_PTR(err));
> +			clk_disable_unprepare(mdp->clk_main);
> +			return err;
> +		}
> +	}
> +

The logic becomes a tad simpler if you prepare_enable unconditionally on
entry and disable_unprepare on exit. Given that in the mdp->enabled =3D=3D
true the clocks are already on they are a noop in this case and the
matching disable just decreases the usage count.

>  	/*
>  	 * Find period, high_width and clk_div to suit duty_ns and period_ns.
>  	 * Calculate proper div value to keep period value in the bound.
> @@ -87,9 +104,13 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	rate =3D clk_get_rate(mdp->clk_main);
>  	clk_div =3D div_u64(rate * period_ns, NSEC_PER_SEC) >>
>  			  PWM_PERIOD_BIT_WIDTH;
> -	if (clk_div > PWM_CLKDIV_MAX)
> +	if (clk_div > PWM_CLKDIV_MAX) {
> +		if (!mdp->enabled) {
> +			clk_disable_unprepare(mdp->clk_mm);
> +			clk_disable_unprepare(mdp->clk_main);
> +		}
>  		return -EINVAL;
> -
> +	}
>  	div =3D NSEC_PER_SEC * (clk_div + 1);
>  	period =3D div64_u64(rate * period_ns, div);
>  	if (period > 0)
> @@ -98,16 +119,6 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	high_width =3D div64_u64(rate * duty_ns, div);
>  	value =3D period | (high_width << PWM_HIGH_WIDTH_SHIFT);
> =20
> -	err =3D clk_enable(mdp->clk_main);
> -	if (err < 0)
> -		return err;
> -
> -	err =3D clk_enable(mdp->clk_mm);
> -	if (err < 0) {
> -		clk_disable(mdp->clk_main);
> -		return err;
> -	}
> -
>  	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
>  				 PWM_CLKDIV_MASK,
>  				 clk_div << PWM_CLKDIV_SHIFT);
> @@ -122,10 +133,19 @@ static int mtk_disp_pwm_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
>  					 mdp->data->commit_mask,
>  					 0x0);
> +	} else {
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> +					 mdp->data->bls_debug_mask,
> +					 mdp->data->bls_debug_mask);
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> +					 mdp->data->con0_sel,
> +					 mdp->data->con0_sel);

This is unrelated for this patch, isn't it?

>  	}
> =20
> -	clk_disable(mdp->clk_mm);
> -	clk_disable(mdp->clk_main);
> +	if (!mdp->enabled) {
> +		clk_disable_unprepare(mdp->clk_mm);
> +		clk_disable_unprepare(mdp->clk_main);
> +	}
> =20
>  	return 0;
>  }
> @@ -135,18 +155,25 @@ static int mtk_disp_pwm_enable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
>  	int err;
> =20
> -	err =3D clk_enable(mdp->clk_main);
> -	if (err < 0)
> -		return err;
> -
> -	err =3D clk_enable(mdp->clk_mm);
> -	if (err < 0) {
> -		clk_disable(mdp->clk_main);
> -		return err;
> +	if (!mdp->enabled) {
> +		err =3D clk_prepare_enable(mdp->clk_main);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n",
> +				ERR_PTR(err));
> +			return err;
> +		}
> +		err =3D clk_prepare_enable(mdp->clk_mm);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n",
> +				ERR_PTR(err));
> +			clk_disable_unprepare(mdp->clk_main);
> +			return err;
> +		}
>  	}
> =20
>  	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
>  				 mdp->data->enable_mask);
> +	mdp->enabled =3D true;
> =20
>  	return 0;
>  }
> @@ -158,8 +185,11 @@ static void mtk_disp_pwm_disable(struct pwm_chip *ch=
ip, struct pwm_device *pwm)
>  	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
>  				 0x0);
> =20
> -	clk_disable(mdp->clk_mm);
> -	clk_disable(mdp->clk_main);
> +	if (mdp->enabled) {
> +		clk_disable_unprepare(mdp->clk_mm);
> +		clk_disable_unprepare(mdp->clk_main);
> +	}
> +	mdp->enabled =3D false;
>  }
> =20
>  static const struct pwm_ops mtk_disp_pwm_ops =3D {
> @@ -192,58 +222,26 @@ static int mtk_disp_pwm_probe(struct platform_devic=
e *pdev)
>  	if (IS_ERR(mdp->clk_mm))
>  		return PTR_ERR(mdp->clk_mm);
> =20
> -	ret =3D clk_prepare(mdp->clk_main);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D clk_prepare(mdp->clk_mm);
> -	if (ret < 0)
> -		goto disable_clk_main;
> -
>  	mdp->chip.dev =3D &pdev->dev;
>  	mdp->chip.ops =3D &mtk_disp_pwm_ops;
>  	mdp->chip.npwm =3D 1;
> =20
>  	ret =3D pwmchip_add(&mdp->chip);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> -		goto disable_clk_mm;
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %pe\n", ERR_PTR(ret));
> +		return ret;
>  	}
> =20
>  	platform_set_drvdata(pdev, mdp);
> =20
> -	/*
> -	 * For MT2701, disable double buffer before writing register
> -	 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
> -	 */
> -	if (!mdp->data->has_commit) {
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> -					 mdp->data->bls_debug_mask,
> -					 mdp->data->bls_debug_mask);
> -		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> -					 mdp->data->con0_sel,
> -					 mdp->data->con0_sel);
> -	}
> -

Similar than above this is unrelated at least to what you described in
the commit log. Maybe this part is better split into a separate patch?


>  	return 0;
> -
> -disable_clk_mm:
> -	clk_unprepare(mdp->clk_mm);
> -disable_clk_main:
> -	clk_unprepare(mdp->clk_main);
> -	return ret;
>  }

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xmk5ka4y4uxu4kd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDWFsAACgkQwfwUeK3K
7AkY+wf+N4itZuXat6zuX1yRa1UFgJx53yB+LgP3yrpwdR7yBC9UJKpH4ZZ3SNy4
WJIwGpApElgbw7kK3JyYw7zNP2SoMUhomXP0hEym3GycgRAxMO7imPXJcoQVvAq+
tW9qMhRrhQik0icVC3mOUqDF57OlrXU/71Ar7TKFAYZU2hRg7Xd8aJjLN5/oIqZZ
1tImcbJChBNJBkmT5yDjDC8OwfGfF2gglQuNn8xk1e5Ouj5TAVY7ZVy0LTkdML+q
w2ake8TEejPe6oQY80IaM91ffqPVKxRkJjwjw3yYbvMrw6uO5DIkho1lm4oJcVTH
Q5M2cUhvHQGgVLP2B+11GxzGJgkpjg==
=/HRP
-----END PGP SIGNATURE-----

--xmk5ka4y4uxu4kd6--
