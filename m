Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2512239D6BF
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFGIJT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 04:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGIJT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 04:09:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928AEC061766
        for <linux-pwm@vger.kernel.org>; Mon,  7 Jun 2021 01:07:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqAI7-0001dM-B8; Mon, 07 Jun 2021 10:07:23 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqAI6-0004JI-2w; Mon, 07 Jun 2021 10:07:22 +0200
Date:   Mon, 7 Jun 2021 10:07:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roman Beranek <roman.beranek@prusa3d.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/6] pwm: sun4i: disable EN bit prior to the delay
Message-ID: <20210607080721.4o2dd4pmb4wwddgg@pengutronix.de>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
 <20210531044608.1006024-3-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="anudz3llin6kdgsz"
Content-Disposition: inline
In-Reply-To: <20210531044608.1006024-3-roman.beranek@prusa3d.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--anudz3llin6kdgsz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 31, 2021 at 06:46:04AM +0200, Roman Beranek wrote:
> The reason why we wait before gating the clock is to allow for the PWM
> to finish its cycle and stop. But it won't stop unless the EN bit is
> disabled.
>=20
> Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 3721b9894cf6..2777abe66f79 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -303,6 +303,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
> =20
>  	if (state->enabled)
>  		ctrl |=3D BIT_CH(PWM_EN, pwm->hwpwm);
> +	else
> +		ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);

Catching the case !state->enabled even earlier would make sense.
Otherwise you might see a needless glitch after

	pwm_apply_state(mypwm, { .period =3D A, .duty_cycle =3D B, .enabled =3D tr=
ue });
	pwm_apply_state(mypwm, { .period =3D C, .duty_cycle =3D D, .enabled =3D fa=
lse });

which might make C+D visible on the PWM before disabling.

> =20
>  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> =20
> @@ -325,7 +327,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  	ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> -	ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
>  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>  	spin_unlock(&sun4i_pwm->ctrl_lock);

So the comment

  /* We need a full period to elapse before disabling the channel. */

is wrong?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--anudz3llin6kdgsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC907cACgkQwfwUeK3K
7Ame3gf/Ur7YoIu9nMF20rXnA1ys1wDYe0y17G8qfQVWLhbb3wVzlQdCBxrx7zcH
vsBQL0rRoYu04Cgdz+YSWnfDnp/LdjwAwPQ6G5KN6rlXQNiuOqMgVdpdJAlZ0jyt
uTOTR6OfN8JKAcLTKxOWNORnZbD4cVQa58rRJYMiFJAhaGscDwdWYkwvy/QkOkiB
j4y0A+sJbHd7M7P8vL4DeTTHZU3TFcaEqiXJ75PTkJc0Z5nE6SFjN/xkwewhfK9H
iKHtSejdiGFvthOHNmVJ5R9obDkyGcBzNI/AO5qNrk3Ju+ckOf1lCW9TSVQYZO8a
V1OmOtMiWRSd8K1pDBXwZeEXMBbqjA==
=QwWJ
-----END PGP SIGNATURE-----

--anudz3llin6kdgsz--
