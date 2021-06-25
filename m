Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A8E3B488E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYSBi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYSBh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 14:01:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBBEC061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 10:59:16 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwq6h-0006lC-9g; Fri, 25 Jun 2021 19:59:11 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwq6d-0006nj-Gw; Fri, 25 Jun 2021 19:59:07 +0200
Date:   Fri, 25 Jun 2021 19:59:07 +0200
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
Subject: Re: [PATCH v5 3/3] pwm: mtk_disp: implement atomic API .get_state()
Message-ID: <20210625175907.mkm5hef3rqyn2xu2@pengutronix.de>
References: <20210616085224.157318-1-jitao.shi@mediatek.com>
 <20210616085224.157318-4-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eyrw3wkkuwhoc7r"
Content-Disposition: inline
In-Reply-To: <20210616085224.157318-4-jitao.shi@mediatek.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4eyrw3wkkuwhoc7r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 04:52:24PM +0800, Jitao Shi wrote:
> Switch the driver to support the .get_state() method.
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index a4766e931b68..d60a6b379683 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -159,8 +159,47 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	return 0;
>  }
> =20
> +static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
> +	u32 clk_div, con0, con1;
> +	u64 rate, period, high_width;
> +	int err;
> +
> +	if (!mdp->enabled) {
> +		err =3D clk_prepare_enable(mdp->clk_main);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
> +			return;
> +		}
> +		err =3D clk_prepare_enable(mdp->clk_mm);
> +		if (err < 0) {
> +			dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
> +			clk_disable_unprepare(mdp->clk_main);
> +			return;
> +		}
> +	}

As already written in reply to one of the previous patches: The
clk_prepare_enable() can be done unconditionally.

> +	rate =3D clk_get_rate(mdp->clk_main);
> +	con0 =3D readl(mdp->base + mdp->data->con0);
> +	con1 =3D readl(mdp->base + mdp->data->con1);
> +	state->enabled =3D !!(con0 & BIT(0));

Maybe introduce a name for that.

> +	clk_div =3D FIELD_GET(PWM_CLKDIV_MASK, con0);
> +	period =3D con1 & PWM_PERIOD_MASK;

FIELD_GET(PWM_PERIOD_MASK, con1) for consistency.

> +	state->period =3D DIV64_U64_ROUND_UP(period * (clk_div + 1) * NSEC_PER_=
SEC, rate);

period has 12 bits, clk_div 11 and NSEC_PER_SEC has 30, so this cannot
overflow. Maybe mention this in a comment.

> +	high_width =3D FIELD_GET(PWM_HIGH_WIDTH_MASK, con1);
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP(high_width * (clk_div + 1) * N=
SEC_PER_SEC,
> +					       rate);

state->polarity =3D PWM_POLARITY_NORMAL;

> +	if (!mdp->enabled) {
> +		clk_disable_unprepare(mdp->clk_mm);
> +		clk_disable_unprepare(mdp->clk_main);
> +	}
> +}
> +
>  static const struct pwm_ops mtk_disp_pwm_ops =3D {
>  	.apply =3D mtk_disp_pwm_apply,
> +	.get_state =3D mtk_disp_pwm_get_state,
>  	.owner =3D THIS_MODULE,
>  };

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4eyrw3wkkuwhoc7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDWGWcACgkQwfwUeK3K
7An5VAf/XzQc5BYvnCWcAGDztYjD7zSrqzJA9BTkTJx2LxFBw6zOJhQG/uPat3yV
YzdnVTj/rPJSjd6hiZjqDZC/FZqqYYgNeMv37SLFHOdktWbuoxPFIwo6er4CxALw
udW/gSSKbGp/eU4IqS9Ascb02Xmgt9mhxLpRcQXzjltcwozVDR3JratnI56INgvb
stfA+IsREM6qYuPpOk7fe9GTLlHgb8+PTAdshULxIvJD+ZCFQX0C0yJnkWNiWqSe
tqAfrdqzt7p10IrQJ4h3uQ/8j5VVCXXdy3vayI10OjkLB4TlUg4wH8CBJVZgRsun
c3bu4WFtUC1XR7saUcst6Rm584Lkrg==
=BMGU
-----END PGP SIGNATURE-----

--4eyrw3wkkuwhoc7r--
