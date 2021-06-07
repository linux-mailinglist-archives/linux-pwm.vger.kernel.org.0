Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CEE39D6A2
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 10:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFGICv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFGICv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 04:02:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF50C061766
        for <linux-pwm@vger.kernel.org>; Mon,  7 Jun 2021 01:01:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqABr-0000dm-Bv; Mon, 07 Jun 2021 10:00:55 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqABn-00033K-TW; Mon, 07 Jun 2021 10:00:51 +0200
Date:   Mon, 7 Jun 2021 10:00:51 +0200
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
Subject: Re: [PATCH 1/6] pwm: sun4i: enable clk prior to getting its rate
Message-ID: <20210607080051.anzdfywvbpu52e2f@pengutronix.de>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
 <20210531044608.1006024-2-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fgvzcr2xl7qwtzjm"
Content-Disposition: inline
In-Reply-To: <20210531044608.1006024-2-roman.beranek@prusa3d.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fgvzcr2xl7qwtzjm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 31, 2021 at 06:46:03AM +0200, Roman Beranek wrote:
> Ensure the PWM clock is enabled prior to retrieving its rate, as is
> already being done in sun4i_pwm_apply.
>=20
> Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index e01becd102c0..3721b9894cf6 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -117,8 +117,15 @@ static void sun4i_pwm_get_state(struct pwm_chip *chi=
p,
>  	u64 clk_rate, tmp;
>  	u32 val;
>  	unsigned int prescaler;
> +	int ret;
> =20
> +	ret =3D clk_prepare_enable(sun4i_pwm->clk);
> +	if (ret) {
> +		dev_err(chip->dev, "failed to enable PWM clock\n");
> +		return;
> +	}
>  	clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> +	clk_disable_unprepare(sun4i_pwm->clk);
> =20
>  	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);

If the clock is off, does the PWM actually run? Assuming it doesn't the
right thing to do is to ensure the clock is enabled in .probe iff the
PWM is enabled.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fgvzcr2xl7qwtzjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC90jAACgkQwfwUeK3K
7AkTwQf/QHr6m8fTM/0AQ1Q9o6vzNcycIEHwD35swSOiuUM/FJD3zDMwbuaN5P8m
5+Huh5ZopP6VYTl4oRqlb41J2UUzGXVhGRu8XL07fHpps6TYZzxcuPk/oc2nnEfW
J+uEedwhAx/OrvWmZXxGx+0on1HpgBqY7SeGFkr/rB4Dm1uF1Wn+QDgM1J4QOiXt
OmjuMKQItgz7FirKHYyUFqjZ/8v1rseUfl5GjAQlgBQUjAlnxJbL1ZP7EnfGdmdG
5uaggsyAxgmwmEM/tigKDZjTswTKdXYjPthx6zk3MirPSb/EWxfyBGIG1Rd5pym4
faMhKKyIIwRhVAiq80W2occrz6IGGA==
=tXV6
-----END PGP SIGNATURE-----

--fgvzcr2xl7qwtzjm--
