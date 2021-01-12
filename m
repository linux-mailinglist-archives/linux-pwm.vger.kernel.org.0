Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE42F2B22
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jan 2021 10:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392563AbhALJTe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jan 2021 04:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392560AbhALJTa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jan 2021 04:19:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C3C061794
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 01:18:50 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzFp7-0000pF-8e; Tue, 12 Jan 2021 10:18:45 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzFp4-0006Im-L6; Tue, 12 Jan 2021 10:18:42 +0100
Date:   Tue, 12 Jan 2021 10:18:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, f.fainelli@gmail.com,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v6 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
Message-ID: <20210112091842.3th64ardbqjafvuq@pengutronix.de>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de>
 <20201211164801.7838-12-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r23z722cpflr6wgz"
Content-Disposition: inline
In-Reply-To: <20201211164801.7838-12-nsaenzjulienne@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--r23z722cpflr6wgz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Fri, Dec 11, 2020 at 05:48:00PM +0100, Nicolas Saenz Julienne wrote:
> diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberr=
ypi-poe.c
> new file mode 100644
> index 000000000000..24b498839fcc
> --- /dev/null
> +++ b/drivers/pwm/pwm-raspberrypi-poe.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + * For more information on Raspberry Pi's PoE hat see:
> + * https://www.raspberrypi.org/products/poe-hat/
> + *
> + * Limitations:
> + *  - No disable bit, so a disabled PWM is simulated by duty_cycle 0
> + *  - Only normal polarity
> + *  - Fixed 12.5 kHz period
> + *
> + * The current period is completed when HW is reconfigured.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +#include <dt-bindings/pwm/raspberrypi,firmware-poe-pwm.h>
> +
> +#define RPI_PWM_MAX_DUTY		255
> +#define RPI_PWM_PERIOD_NS		80000 /* 12.5 kHz */
> +
> +#define RPI_PWM_CUR_DUTY_REG		0x0
> +#define RPI_PWM_DEF_DUTY_REG		0x1
> +
> +struct raspberrypi_pwm {
> +	struct rpi_firmware *firmware;
> +	struct pwm_chip chip;
> +	unsigned int duty_cycle;
> +};
> +
> +struct raspberrypi_pwm_prop {
> +	__le32 reg;
> +	__le32 val;
> +	__le32 ret;
> +} __packed;
> +
> +static inline struct raspberrypi_pwm *to_raspberrypi_pwm(struct pwm_chip=
 *chip)

I'd like to see this function use the same prefix as the other
functions. I suggest "raspberrypi_pwm_from_chip".

> +{
> +	return container_of(chip, struct raspberrypi_pwm, chip);
> +}
> +
> +static int raspberrypi_pwm_set_property(struct rpi_firmware *firmware,
> +					u32 reg, u32 val)
> +{
> +	struct raspberrypi_pwm_prop msg =3D {
> +		.reg =3D cpu_to_le32(reg),
> +		.val =3D cpu_to_le32(val),
> +	};
> +	int ret;
> +
> +	ret =3D rpi_firmware_property(firmware, RPI_FIRMWARE_SET_POE_HAT_VAL,
> +				    &msg, sizeof(msg));
> +	if (ret)
> +		return ret;
> +	if (msg.ret)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int raspberrypi_pwm_get_property(struct rpi_firmware *firmware,
> +					u32 reg, u32 *val)
> +{
> +	struct raspberrypi_pwm_prop msg =3D {
> +		.reg =3D reg
> +	};
> +	int ret;
> +
> +	ret =3D rpi_firmware_property(firmware, RPI_FIRMWARE_GET_POE_HAT_VAL,
> +				    &msg, sizeof(msg));
> +	if (ret)
> +		return ret;
> +	if (msg.ret)
> +		return -EIO;
> +
> +	*val =3D le32_to_cpu(msg.val);
> +
> +	return 0;
> +}
> +
> +static void raspberrypi_pwm_get_state(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      struct pwm_state *state)
> +{
> +	struct raspberrypi_pwm *rpipwm =3D to_raspberrypi_pwm(chip);
> +
> +	state->period =3D RPI_PWM_PERIOD_NS;
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST(rpipwm->duty_cycle * RPI_PWM_PE=
RIOD_NS,
> +					      RPI_PWM_MAX_DUTY);

Please round up here ...

> +	state->enabled =3D !!(rpipwm->duty_cycle);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +			         const struct pwm_state *state)
> +{
> +	struct raspberrypi_pwm *rpipwm =3D to_raspberrypi_pwm(chip);
> +	unsigned int duty_cycle;
> +	int ret;
> +
> +        if (state->period < RPI_PWM_PERIOD_NS ||
> +            state->polarity !=3D PWM_POLARITY_NORMAL)
> +                return -EINVAL;
> +
> +        if (!state->enabled)
> +                duty_cycle =3D 0;
> +        else if (state->duty_cycle < RPI_PWM_PERIOD_NS)
> +                duty_cycle =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle *=
 RPI_PWM_MAX_DUTY,
> +					           RPI_PWM_PERIOD_NS);

=2E.. and round down here.

Just to be sure: writing RPI_PWM_MAX_DUTY (i.e. 255) yields 100% duty
cycle, right?

> +        else
> +                duty_cycle =3D RPI_PWM_MAX_DUTY;
> +
> +	if (duty_cycle =3D=3D rpipwm->duty_cycle)
> +		return 0;
> +
> +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DUTY=
_REG,
> +					   duty_cycle);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to set duty cycle: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * This sets the default duty cycle after resetting the board, we
> +	 * updated it every time to mimic Raspberry Pi's downstream's driver
> +	 * behaviour.
> +	 */
> +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_DEF_DUTY=
_REG,
> +					   duty_cycle);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to set default duty cycle: %d\n", ret);
> +		return ret;
> +	}
> +
> +        rpipwm->duty_cycle =3D duty_cycle;

Please use tabs for indention. (The general hint is to use checkpatch
which (I hope) tells you about problems like this.)

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops raspberrypi_pwm_ops =3D {
> +	.get_state =3D raspberrypi_pwm_get_state,
> +	.apply =3D raspberrypi_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int raspberrypi_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *firmware_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct rpi_firmware *firmware;
> +	struct raspberrypi_pwm *rpipwm;
> +	int ret;
> +
> +	firmware_node =3D of_get_parent(dev->of_node);
> +	if (!firmware_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	firmware =3D devm_rpi_firmware_get(&pdev->dev, firmware_node);
> +	of_node_put(firmware_node);
> +	if (!firmware)
> +		return -EPROBE_DEFER;

Please use dev_err_probe to benefit from recording an error message in
this case.

> +	rpipwm =3D devm_kzalloc(&pdev->dev, sizeof(*rpipwm), GFP_KERNEL);
> +	if (!rpipwm)
> +		return -ENOMEM;
> +
> +	rpipwm->firmware =3D firmware;
> +	rpipwm->chip.dev =3D dev;
> +	rpipwm->chip.ops =3D &raspberrypi_pwm_ops;
> +	rpipwm->chip.base =3D -1;
> +	rpipwm->chip.npwm =3D RASPBERRYPI_FIRMWARE_PWM_NUM;
> +
> +	platform_set_drvdata(pdev, rpipwm);
> +
> +	ret =3D raspberrypi_pwm_get_property(rpipwm->firmware, RPI_PWM_CUR_DUTY=
_REG,
> +					   &rpipwm->duty_cycle);
> +	if (ret) {
> +		dev_err(dev, "Failed to get duty cycle: %d\n", ret);

Please use %pe for the error codes (directly or still better by using
dev_err_probe here, too).

> +		return ret;
> +	}
> +
> +	return pwmchip_add(&rpipwm->chip);
> +}
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r23z722cpflr6wgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/9aW8ACgkQwfwUeK3K
7AkKmAf/X43HuzDS2E9bHa7KzzW9+7rOPBmL3wmZt/Ab01mgp1yRp2gC+qtv7BPT
0n138wPi5O+rOAxm/iC9Uc4Y1s0bpvndj05noMRAK2X+XLXxwWhLARqf63uCvxIr
sa6Dl6PDQsOj9ucrNUJPWFNYkjm4YGLmKJQrqjr8lEyydl7j8S4e2IGryiMs+sSV
nL9CkhaIA0cFiritdv3THxRfhxnzMLkcG2E3ePHA2eq91FuV1DHqfZpgYwSd0eDf
w1egR/8M6Lup6AxF7B5IzSzaBf+XFZi5k5Wj0LuRXNSpUBcL7nv81l0e+A8+fCF5
ZmpW6QOoovobVNxANzKLcZ4hfKwybw==
=J/5G
-----END PGP SIGNATURE-----

--r23z722cpflr6wgz--
