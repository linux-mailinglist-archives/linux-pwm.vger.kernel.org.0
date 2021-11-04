Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8244511F
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhKDJdB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhKDJdA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 05:33:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D2C06120A
        for <linux-pwm@vger.kernel.org>; Thu,  4 Nov 2021 02:30:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miZ4a-00026b-Af; Thu, 04 Nov 2021 10:30:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miZ4Z-0004wE-EV; Thu, 04 Nov 2021 10:30:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1miZ4Z-0006cE-Db; Thu, 04 Nov 2021 10:30:15 +0100
Date:   Thu, 4 Nov 2021 10:30:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: samsung: describe driver in KConfig
Message-ID: <20211104093015.url6pu2pj6yqqd4e@pengutronix.de>
References: <20210924133148.111845-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dia4e4xjw5wmpq6c"
Content-Disposition: inline
In-Reply-To: <20210924133148.111845-1-krzysztof.kozlowski@canonical.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dia4e4xjw5wmpq6c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2021 at 03:31:48PM +0200, Krzysztof Kozlowski wrote:
> Describe better which driver applies to which SoC, to make configuring
> kernel for Samsung SoC easier.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/pwm/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index aa29841bbb79..21e3b05a5153 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -476,7 +476,9 @@ config PWM_SAMSUNG
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	help
> -	  Generic PWM framework driver for Samsung.
> +	  Generic PWM framework driver for Samsung S3C24xx, S3C64xx, S5Pv210
> +	  and Exynos SoCs.
> +	  Choose Y here only if you build for such Samsung SoC.

Assuming this list is complete, I think this is a nice improvement.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dia4e4xjw5wmpq6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGDqCQACgkQwfwUeK3K
7AmbUQgAlMzCYfheBhJ9/DkHV0OReAztbiZh7PdQKsIyeqdzFZ795A857eAOEHGD
a8W5ZqlJ9/Tqy2j99BO1nKpExjl2Nb8pxGVhikPS0NuwZZ0V9pGRukCPBNOU+7XK
A+hPW0F78EK+Chxhk9WTraTORaH0lqbGIWwXGhfoHKEpb7Flu/g5wBroqsbc7wWA
nxBhRy73JIlGoT9aCx3XGstsbsgbbkb44wEj8by3A9UyTcTY8AAWomyPqbGWKaXM
20UG/QVQ7F1C/9OlmzxRRtnlPoIXiLZAimk60GAI/XyUeS3Oy1ziTV31jvgyITmm
pUvpeUR/oV0p2APnfWVS3pdtzLnB2A==
=GQCW
-----END PGP SIGNATURE-----

--dia4e4xjw5wmpq6c--
