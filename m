Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7935E454954
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhKQO53 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhKQO53 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 09:57:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B28C061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 06:54:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnMKQ-00016X-SK; Wed, 17 Nov 2021 15:54:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnMKN-000MiE-Mf; Wed, 17 Nov 2021 15:54:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnMKM-0004NQ-FT; Wed, 17 Nov 2021 15:54:22 +0100
Date:   Wed, 17 Nov 2021 15:54:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     cgel.zte@gmail.com
Cc:     alexandre.belloni@bootlin.com, deng.changcheng@zte.com.cn,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        thierry.reding@gmail.com, zealci@zte.com.cn
Subject: Re: [PATCH V2] pwm: Use div64_ul instead of do_div
Message-ID: <20211117145419.b4wb6zp42rjdpgn5@pengutronix.de>
References: <20211117112400.bkscb2pyavonpfsn@pengutronix.de>
 <20211117124653.161699-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bnfcbwayrcwki5lr"
Content-Disposition: inline
In-Reply-To: <20211117124653.161699-1-deng.changcheng@zte.com.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bnfcbwayrcwki5lr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 12:46:53PM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> do_div() does a 64-by-32 division. If the divisor is unsigned long, using
> div64_ul can avoid truncation to 32-bit.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index a43b2babc809..1ae3d73b9832 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -60,7 +60,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, st=
ruct pwm_device *pwm,
>  				return -EINVAL;
> =20
>  			clk_period_ns =3D (u64)NSEC_PER_SEC * 256;
> -			do_div(clk_period_ns, clk_freq);
> +			clk_period_ns =3D div64_ul(clk_period_ns, clk_freq);
>  		}
> =20
>  		/* Errata: cannot use slow clk on some IP revisions */
> @@ -72,7 +72,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, st=
ruct pwm_device *pwm,
>  				return -EINVAL;
> =20
>  			clk_period_ns =3D (u64)NSEC_PER_SEC * 256;
> -			do_div(clk_period_ns, clk_freq);
> +			clk_period_ns =3D div64_ul(clk_period_ns, clk_freq);

The code change is good now, the commit log is as confusing as in v1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bnfcbwayrcwki5lr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGVF5gACgkQwfwUeK3K
7AnjUggAhXaPzpoPxrVPzZgvAUNVH3kKTY6crrPcmxxN/YCnf/+fOb+dQzKUwe+G
rt9eIvjGKgWqphuhVYfMImD9+QLzLLeiSOOjddPPE4W30QuKYegeB/8nG/IJHXgg
vlRwZ3FOKJBPelEJ1W3QFl4gvuuM2U+ucjkx840f1jln0A0Oz+Vhn3yvqZ7Ct1x8
GgzUpS9x3BcB2XBIyPjpDWEUeAp0gZazAsfLi5UEE40RQ8l6OimhLsTghA8Z0hQF
ldgzW7bvNr5LHEqYhCXcfBWSwIhMkkhUO/CSqt1GH1qXYx89VV5FawQvzW+Fk9iI
ilWpkClvveRUCuUxAqc4iCcKhEeFJg==
=i0MT
-----END PGP SIGNATURE-----

--bnfcbwayrcwki5lr--
