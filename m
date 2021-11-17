Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5864545A2
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 12:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhKQL3T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 06:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhKQL3T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 06:29:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B1C061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 03:26:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnJ50-0007EA-T3; Wed, 17 Nov 2021 12:26:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnJ50-000M5o-Su; Wed, 17 Nov 2021 12:26:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnJ4z-0003bf-SZ; Wed, 17 Nov 2021 12:26:17 +0100
Date:   Wed, 17 Nov 2021 12:25:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     cgel.zte@gmail.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] pwm: rcar: Use div64_ul instead of do_div
Message-ID: <20211117112559.jix3hmx7uwqmuryg@pengutronix.de>
References: <20211117020854.159472-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7mlziwyl3sao2bhf"
Content-Disposition: inline
In-Reply-To: <20211117020854.159472-1-deng.changcheng@zte.com.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7mlziwyl3sao2bhf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 02:08:54AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> do_div() does a 64-by-32 division. If the divisor is unsigned long, using
> div64_ul can avoid truncation to 32-bit.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> index b437192380e2..fb475c188e1e 100644
> --- a/drivers/pwm/pwm-rcar.c
> +++ b/drivers/pwm/pwm-rcar.c
> @@ -111,7 +111,7 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip =
*rp, int div, int duty_ns,
>  	u32 cyc, ph;
> =20
>  	one_cycle =3D (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
> -	do_div(one_cycle, clk_rate);
> +	div64_ul(one_cycle, clk_rate);

Same problem as with the atmel-hlcdc patch: The calling convention of
do_div and div64_ul are different and with the proposed patch the result
of the division is unused.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7mlziwyl3sao2bhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGU5r4ACgkQwfwUeK3K
7AnpOwgAgZBJwBNd2hi1/+g8aMd6Tejszwkt7eRarKAEASq90mKAJQlv5J2SLSfI
5yucZib6hstiVNUMwehIlwZL1u9/gxXpk5pG7s3W7M76CcjHFi2yr2iO3qmFRYoC
I7TKGwcVRsrmLFHpjFxkcFoE9PlMETvCRrPzji8lskywoJtLmDg5ia9NvJdx7f04
FfmU/YIial8gB7ZocrpO8514OCOVAKKiF51mnMzclfGiTLCTzRMFkx8ZrXXyjLQ2
9WA25EvE/YCcQY5yFeFobcdATVBkWBIfZZnQQkNTbKh3u84mThjxeQVSm8YOXwqX
LgOGrRbaofHcyQgfMb8qsvrNsiDKVw==
=QIiz
-----END PGP SIGNATURE-----

--7mlziwyl3sao2bhf--
