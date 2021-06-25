Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD73B487D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhFYRyt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 13:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhFYRyr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 13:54:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F014C061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 10:52:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwq05-0006El-0N; Fri, 25 Jun 2021 19:52:21 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwq03-0006cY-Ow; Fri, 25 Jun 2021 19:52:19 +0200
Date:   Fri, 25 Jun 2021 19:52:19 +0200
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
Subject: Re: [PATCH v5 2/3] pwm: mtk_disp: implement atomic API .apply()
Message-ID: <20210625175219.ppeq4yloi76ud4jj@pengutronix.de>
References: <20210616085224.157318-1-jitao.shi@mediatek.com>
 <20210616085224.157318-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agipn6zma3xjneoo"
Content-Disposition: inline
In-Reply-To: <20210616085224.157318-3-jitao.shi@mediatek.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--agipn6zma3xjneoo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 04:52:23PM +0800, Jitao Shi wrote:
> Switch the driver to support the .apply() method.
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 69 ++++++++++----------------------------
>  1 file changed, 17 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 204d76beeb26..a4766e931b68 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -67,14 +67,25 @@ static void mtk_disp_pwm_update_bits(struct mtk_disp_=
pwm *mdp, u32 offset,
>  	writel(value, address);
>  }
> =20
> -static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> -			       int duty_ns, int period_ns)
> +static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
>  {
>  	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
>  	u32 clk_div, period, high_width, value;
>  	u64 div, rate;
>  	int err;
> =20

Here something like:

	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -EINVAL;

is missing.

> +	if (!state->enabled) {
> +		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
> +					 0x0);
> +		if (mdp->enabled) {
> +			clk_disable_unprepare(mdp->clk_mm);
> +			clk_disable_unprepare(mdp->clk_main);
> +		}
> +		mdp->enabled =3D false;
> +		return 0;
> +	}
> +
>  	if (!mdp->enabled) {
>  		err =3D clk_prepare_enable(mdp->clk_main);
>  		if (err < 0) {
> @@ -102,7 +113,7 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	 * high_width =3D (PWM_CLK_RATE * duty_ns) / (10^9 * (clk_div + 1))
>  	 */
>  	rate =3D clk_get_rate(mdp->clk_main);
> -	clk_div =3D div_u64(rate * period_ns, NSEC_PER_SEC) >>
> +	clk_div =3D div_u64(rate * state->period, NSEC_PER_SEC) >>

This multiplication might overflow. But maybe it's sensible to address
this in a separate commit to keep things simple.

>  			  PWM_PERIOD_BIT_WIDTH;
>  	if (clk_div > PWM_CLKDIV_MAX) {
>  		if (!mdp->enabled) {
> @@ -112,11 +123,11 @@ static int mtk_disp_pwm_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
>  		return -EINVAL;
>  	}
>  	div =3D NSEC_PER_SEC * (clk_div + 1);
> -	period =3D div64_u64(rate * period_ns, div);
> +	period =3D div64_u64(rate * state->period, div);

ditto.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--agipn6zma3xjneoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDWF9AACgkQwfwUeK3K
7AkLdgf+It9rCnCg7lTfWTAMvXBrn6TdovPnzwlboNULBtNOkiBWAPZ/0K1as1nY
hAesg/ARX8rRR9okaFU8Pv9BQ6rQ7idmLE8x4NE5oLrkAuCfg+4Azpol3t3DA7q/
rOdSMIUsyIeZjI4TlJcA70lmTwf97hFeQtj23XzZ9S4U966uCdyp+9b+g8QD+B/4
GYqbJWcbWHr0+Wwra9tYluuvYB3XwXDFN6fCWgEm1rcqZ3SwDlJiKQoWaYUdWnhA
XXGUJ662Q/B5BzTSo6lj1vRYLYWRFL4KcelxiVWVnXLDesEXdCKnx4XUe8cuZuEn
PIrbO9/7N863rcPZn+qYpl8+QDlcXg==
=JXek
-----END PGP SIGNATURE-----

--agipn6zma3xjneoo--
