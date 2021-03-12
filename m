Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A833980C
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 21:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhCLUMo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 15:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbhCLUMe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 15:12:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8FC061574
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 12:12:34 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKo8y-0004RE-Cj; Fri, 12 Mar 2021 21:12:20 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKo8w-00089j-Gb; Fri, 12 Mar 2021 21:12:18 +0100
Date:   Fri, 12 Mar 2021 21:12:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v8 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
Message-ID: <20210312201217.n2sav23swy7ii4uo@pengutronix.de>
References: <20210312122454.24480-1-nsaenzjulienne@suse.de>
 <20210312122454.24480-12-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6h2cu7dk3om4cg7"
Content-Disposition: inline
In-Reply-To: <20210312122454.24480-12-nsaenzjulienne@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--e6h2cu7dk3om4cg7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Fri, Mar 12, 2021 at 01:24:54PM +0100, Nicolas Saenz Julienne wrote:
> Adds support to control the PWM bus available in official Raspberry Pi
> PoE HAT. Only RPi's co-processor has access to it, so commands have to
> be sent through RPi's firmware mailbox interface.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> ---
>=20
> Changes since v7:
>  - Remove unwarranted RPI_PWM_DEF_DUTY_REG usage
>=20
>  Changes since v6:
> - Use %pe
> - Round divisions properly
> - Use dev_err_probe()
> - Pass check_patch
>=20
> Changes since v3:
>  - Rename compatible string to be more explicit WRT to bus's limitations
>=20
> Changes since v2:
>  - Use devm_rpi_firmware_get()
>  - Rename driver
>  - Small cleanups
>=20
> Changes since v1:
>  - Use default pwm bindings and get rid of xlate() function
>  - Correct spelling errors
>  - Correct apply() function
>  - Round values
>  - Fix divisions in arm32 mode
>  - Small cleanups
>=20
>  drivers/pwm/Kconfig               |   9 ++
>  drivers/pwm/Makefile              |   1 +
>  drivers/pwm/pwm-raspberrypi-poe.c | 206 ++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/pwm/pwm-raspberrypi-poe.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a7a7a9f26aef..d3371ac7b871 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -431,6 +431,15 @@ config PWM_PXA
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-pxa.
> =20
> +config PWM_RASPBERRYPI_POE
> +	tristate "Raspberry Pi Firwmware PoE Hat PWM support"
> +	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
> +	# happen when COMPILE_TEST=3Dy, hence the added !RASPBERRYPI_FIRMWARE.
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWA=
RE)
> +	help
> +	  Enable Raspberry Pi firmware controller PWM bus used to control the
> +	  official RPI PoE hat
> +
>  config PWM_RCAR
>  	tristate "Renesas R-Car PWM support"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 4e35a55fa7b6..d3879619bd76 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> +obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberr=
ypi-poe.c
> new file mode 100644
> index 000000000000..71ade5e55069
> --- /dev/null
> +++ b/drivers/pwm/pwm-raspberrypi-poe.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

2021?

> + * For more information on Raspberry Pi's PoE hat see:
> + * https://www.raspberrypi.org/products/poe-hat/

Out of personal interest: Is this hat also able to power a RPi CM4?

> + * Limitations:
> + *  - No disable bit, so a disabled PWM is simulated by duty_cycle 0
> + *  - Only normal polarity
> + *  - Fixed 12.5 kHz period
> + *
> + * The current period is completed when HW is reconfigured.
> + */

Other than that as mentioned in the previous round: This looks good,

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

What is your thought about how to get this series merged? At least
input, staging, armsoc, clk, reset anf firmware are touched. Do you
prepare a branch for merging in the relevant trees (once you have all
the necessary Acks)?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e6h2cu7dk3om4cg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBLyx0ACgkQwfwUeK3K
7Ak+VQf+I16Pur4J8v1VK5J08zAGFG+/Lgxk4CBXKIV1Hs8zZ+Xj6Y7sobqkPmiG
/75gKqcFB43BHDrOAwWVMNlE9OChTTrI9grjBHBTGl+46cJkuu5qus/xptp3mxQu
zdTcmzfkrLYPdw3AQaofaLHg5IL0RZkvovBmiUa+JaN89EtjvuLRIFL8wtipt/0J
rE8baVUKZd1ttRm+eotIk3iknzxFUe3xAVFJ8YRlNBwyGlEQQBsZFku3+rP2p47w
6K30Tnft0JKiK+4fuMFhQ5xw3ugSSWThr6/kDYQnTk/BagTPeUyftRmh4/JNkc8X
7OhSbf8srKbZC8859TEqJZ5M48RRxw==
=bnOj
-----END PGP SIGNATURE-----

--e6h2cu7dk3om4cg7--
