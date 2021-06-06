Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAC39D18A
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jun 2021 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFFVNx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Jun 2021 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhFFVNx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Jun 2021 17:13:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AC9C061767
        for <linux-pwm@vger.kernel.org>; Sun,  6 Jun 2021 14:12:03 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq03k-0002XY-Lb; Sun, 06 Jun 2021 23:11:52 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq03h-0004gr-7k; Sun, 06 Jun 2021 23:11:49 +0200
Date:   Sun, 6 Jun 2021 23:11:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, cawa.cheng@mediatek.com,
        bibby.hsieh@mediatek.com, ck.hu@mediatek.com, stonea168@163.com,
        huijuan.xie@mediatek.com
Subject: Re: [PATCH v4 1/3] pwm: mtk-disp: adjust the clocks to avoid them
 mismatch
Message-ID: <20210606211146.eczg3skaor2jqtxi@pengutronix.de>
References: <20210603100531.161901-1-jitao.shi@mediatek.com>
 <20210603100531.161901-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucpydi7gu53srvvk"
Content-Disposition: inline
In-Reply-To: <20210603100531.161901-2-jitao.shi@mediatek.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ucpydi7gu53srvvk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

you missed to address Lee and me for your patch series. I just happend
to stumble over this series by a fluke.

On Thu, Jun 03, 2021 at 06:05:29PM +0800, Jitao Shi wrote:
> The clk_main and clk_mm clocks are still on when system enter
> suspend. That will casue the power consumption.
>=20
> The clocks call the clk_prepare() in probe(), but the clk_unprepare()
> is called in remove(), it isn't called when system suspend.

The English could be improved here. Something like:

	The clks "main" and "mm" are prepared in .probe() (and
	unprepared in .remove()). This results in the clocks being on
	during suspend which results in unnecessarily increased power
	consumption.

> Remove the clcok opterations from probe() and remove.

s/clcok/clock/, s/e\./e()/

> Add the clk_prepare_enable() in config().
> Add the clk_disable_unprepare() in disable().
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 81 ++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 9b3ba401a3db..b5771e2c54b8 100644
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
> +			dev_err(chip->dev, "Can't enable mdp->clk_main: %d\n",
> +				err);
> +			return err;

Please use %pe to get symbolic error names which are better
understandable.

> +		}
> +		err =3D clk_prepare_enable(mdp->clk_mm);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_mm: %d\n",
> +				err);
> +			clk_disable_unprepare(mdp->clk_main);
> +			return err;
> +		}
> +	}
> +
>  	/*
>  	 * Find period, high_width and clk_div to suit duty_ns and period_ns.
>  	 * Calculate proper div value to keep period value in the bound.
> @@ -87,9 +104,15 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	rate =3D clk_get_rate(mdp->clk_main);
>  	clk_div =3D div_u64(rate * period_ns, NSEC_PER_SEC) >>
>  			  PWM_PERIOD_BIT_WIDTH;
> -	if (clk_div > PWM_CLKDIV_MAX)
> +	if (clk_div > PWM_CLKDIV_MAX) {
> +		dev_err(chip->dev, "clock rate is too high: rate =3D %d Hz\n",
> +			rate);

Adding an error message here is orthogonal to this patch. Either drop it
or mention it in the commit log please.

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
> [...]
> @@ -135,18 +145,9 @@ static int mtk_disp_pwm_enable(struct pwm_chip *chip=
, struct pwm_device *pwm)
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
> -	}
> -
>  	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
>  				 mdp->data->enable_mask);
> +	mdp->enabled =3D true;

The modification to .enable() looks wrong. After the PWM was disabled
the clocks are off, so .enable() must reenable them, doesn't it?

>  	return 0;
>  }

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ucpydi7gu53srvvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC9Og4ACgkQwfwUeK3K
7Amlagf+MJ0eg+ZMcAzYu5YhQ1ORBVUiD4aLK5W0KMw6iUinpP1YWVMAjMWqE30H
bc67svFSf+4Xa24kg0cvAzL3C64LZ2KgQ2Jp4622abWaHc09MzElN/ai17QczLme
qbNPSe7o6zZ48xQtosYTwwgKoHPmdQ5m5KSGqvEQC8Uijm7p1NcB7bvWgWVmkxRI
VtXgoGF4UGxoPwFFmkgnG76jTR26MKRdfOsAKwrLFMeU8jiyqqpCxZDwvh4WfWnh
1MSPcrTs6RkG65lobaYc2VBl0+EGS7DSPGH0yxVUHlob7ZZ1JpiSVM8BqZINHel9
teL8wAxscKQnOjxRSDgomEsTGYb4UQ==
=uabQ
-----END PGP SIGNATURE-----

--ucpydi7gu53srvvk--
