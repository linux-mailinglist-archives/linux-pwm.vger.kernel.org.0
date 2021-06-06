Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C939D18E
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Jun 2021 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFFVQ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Jun 2021 17:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFFVQ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Jun 2021 17:16:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34245C061766
        for <linux-pwm@vger.kernel.org>; Sun,  6 Jun 2021 14:15:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq06n-0002yI-LA; Sun, 06 Jun 2021 23:15:01 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq06m-0004j3-NR; Sun, 06 Jun 2021 23:15:00 +0200
Date:   Sun, 6 Jun 2021 23:14:57 +0200
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
Subject: Re: [PATCH v4 2/3] pwm: mtk-disp: move the commit to clock enabled
Message-ID: <20210606211457.ya5nbp6fqevuhzwa@pengutronix.de>
References: <20210603100531.161901-1-jitao.shi@mediatek.com>
 <20210603100531.161901-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jvjznihrdfdbgbae"
Content-Disposition: inline
In-Reply-To: <20210603100531.161901-3-jitao.shi@mediatek.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jvjznihrdfdbgbae
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 06:05:30PM +0800, Jitao Shi wrote:
> Due to the clock sequence changing, so move the reg commit to

Which change do you refer to, here? The previous patch? If so, I assume
this means the series is not bisectable because the driver is broken
when only the first patch is applied?

> config().
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index b5771e2c54b8..b87b3c00a685 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -135,6 +135,13 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
>  					 mdp->data->commit_mask,
>  					 0x0);
> +	} else {

You dropped the code comment? Is it wrong? Or is it too obvious to be
mentioned?

> +		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
> +					 mdp->data->bls_debug_mask,
> +					 mdp->data->bls_debug_mask);
> +		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
> +					 mdp->data->con0_sel,
> +					 mdp->data->con0_sel);
>  	}
> =20
>  	return 0;
> @@ -208,19 +215,6 @@ static int mtk_disp_pwm_probe(struct platform_device=
 *pdev)
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
>  	return 0;
>  }

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jvjznihrdfdbgbae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC9Os0ACgkQwfwUeK3K
7AknMQf/dO4dXSwiikRqYQNqvIbdInbSpYBnrau2T9MOiN5AH/QMduQ+nantgN2k
A1gLIo3VUq0ZaNJXHD6U87VNc35H+95g9u+GJBnDej1Lp1EbLxnUHKJVT4b5XLni
/CuVEtZ6bJJeIn26hTgVDUlBpbxRQ8MUPYFtRprds+yFlGD6Nc3Ilm9WcjoOg9iK
WWHH3XVs4i87mdsCj6E0bQKN5VjZv8xOkchs5FUS05L4/gCuAZ6gDJ+LeiFb8bIB
OtL5QYI8NtHWJGdnM+uuQcbCVVv9g+KNEV4lFLJi45Ev8SNDU60zWJRcyXJ5+brO
5lzwP8YivZt8H14qmTg/ojo/FhZoOw==
=6tuB
-----END PGP SIGNATURE-----

--jvjznihrdfdbgbae--
