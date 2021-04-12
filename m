Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5011E35C4C6
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhDLLOf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbhDLLOf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 07:14:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2F4C061574
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 04:14:17 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVuW5-0004Sw-Oz; Mon, 12 Apr 2021 13:14:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVuW0-0005mo-SS; Mon, 12 Apr 2021 13:14:00 +0200
Date:   Mon, 12 Apr 2021 13:14:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        billy_tasi@aspeedtech.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 4/4] pwm: Add support for aspeed pwm controller
Message-ID: <20210412111400.w4yafy2r2lcy3qqv@pengutronix.de>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-5-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pd5zmkimjbjbd2ka"
Content-Disposition: inline
In-Reply-To: <20210412095457.15095-5-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pd5zmkimjbjbd2ka
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Apr 12, 2021 at 05:54:57PM +0800, Billy Tsai wrote:
> Add support for the pwm controller which can be found at aspeed ast2600
> soc. This driver is part function of multi-funciton of device "pwm-tach
> controller".

please squash this into patch 3.

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig  | 6 ++++++
>  drivers/pwm/Makefile | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..947ed642debe 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -42,6 +42,12 @@ config PWM_DEBUG
>  	  It is expected to introduce some runtime overhead and diagnostic
>  	  output to the kernel log, so only enable while working on a driver.
> =20
> +config PWM_ASPEED_G6
> +	tristate "ASPEEDG6 PWM support"

No depends?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pd5zmkimjbjbd2ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB0K3UACgkQwfwUeK3K
7Alyiwf+N6SdROgVHun0SCHrHCq38m5hqQn38hc8QCylRi+5HR5BhxtwzPttnTSy
J1GYamjnQlXcnQZ6HBNBxliPG/GC3BAaH1CuD3Vk2SNLR1tGfwe6YJER26VbUCjA
1FsFgp2d9Cd4xp81NXN/XLpcqKP49hYrkrKRRC6Q+xG8XK6ZgtaY5Bj+RBh1LM9A
WuEbfXBKgMfEonEc5frH2YEi/DFsevUjX2OKxjmT00vFjdozHYfin+hLJkjxc+f5
GFNaDYXFiaAZ5b1neOfzpalFrYUCcFQisH49bpSXQf73VBfYdHUWFBPgvpNydnw2
oZi9GeO285lWrTQ9Fd1kAPmFCkOmbA==
=SB2c
-----END PGP SIGNATURE-----

--pd5zmkimjbjbd2ka--
