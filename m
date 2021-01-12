Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC84F2F3D1F
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 01:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437004AbhALVh0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jan 2021 16:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437029AbhALUpq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jan 2021 15:45:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7919AC061786
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 12:45:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzQXI-0007eu-3C; Tue, 12 Jan 2021 21:45:04 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzQXH-00074f-7e; Tue, 12 Jan 2021 21:45:03 +0100
Date:   Tue, 12 Jan 2021 21:45:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     linux-pwm@vger.kernel.org
Subject: Re: [PATCH] misc: servo-pwm: driver for controlling servo motors via
 PWM
Message-ID: <20210112204502.5tbige2mdrjgttst@pengutronix.de>
References: <20201222213342.2657026-1-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="74lwahphb3cujflz"
Content-Disposition: inline
In-Reply-To: <20201222213342.2657026-1-angelo.compagnucci@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--74lwahphb3cujflz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

you should add Rob Herring and devicetree@vger.kernel.org to the list of
recipents to get an Ack for your device tree documentation. This should
also probably split out in a separate patch.

On Tue, Dec 22, 2020 at 10:33:42PM +0100, Angelo Compagnucci wrote:
> Ts patch adds a simple driver to control servo motor position via PWM
> signal.
> Driver allows to set the angle, the duty cycle at 0 and 180 degrees and
> to set the initial position when the driver loads.
>=20
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>  .../devicetree/bindings/misc/servo-pwm.txt    |  30 +++
>  drivers/misc/Kconfig                          |   9 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/servo-pwm.c                      | 177 ++++++++++++++++++
>  4 files changed, 217 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.txt
>  create mode 100644 drivers/misc/servo-pwm.c
>=20
> diff --git a/Documentation/devicetree/bindings/misc/servo-pwm.txt b/Docum=
entation/devicetree/bindings/misc/servo-pwm.txt
> new file mode 100644
> index 000000000000..dd3df38bbd7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/servo-pwm.txt

I guess Rob will ask you to specify the binding in a yaml file instead.

> @@ -0,0 +1,30 @@
> +Servo motor connected to PWM
> +
> +Required properties:
> +- compatible : should be "servo-pwm".

I think you should use the actual chip names here.

> +Each servo is represented as a servo-pwm device.
> +
> +Servo properties:
> +- pwms : PWM property to point to the PWM device (phandle)/port (id) and=
 to
> +  specify the period time to be used: <&phandle id period_ns>;

Better refer to the pwm binding instead. Some PWMs need 3 arguments.

> +- duty-0 : (optional) [default 500000] duty cycle to set the servo motor=
 at
> +  0 degrees, useful to compensate for devices drift.
> +- duty-180 : (optional) [default 2500000] duty cycle to set the servo mo=
tor at
> +  180 degrees, useful to compensate for devices drift.
> +- angle : (optional) [defaul 0] set the starting angle at driver loading.

It might just be me not knowing this type of motor, but I don't
understand these parameters.

s/defaul/default/

> +Example:
> +
> +pwm: pwm@0 {
> +	compatible =3D "pwm-gpio";
> +	pwm-gpio =3D <&pio 6 3 GPIO_ACTIVE_LOW>;
> +};
> +
> +servo: servo@0 {
> +	compatible =3D "servo-pwm";
> +	pwms =3D <&pwm 0 2000000>;
> +	duty-0 =3D <60000>;
> +	duty-180 =3D <260000>;
> +	angle =3D <90>;
> +};
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fafa8b0d8099..921f179b0fc4 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -466,6 +466,15 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
> =20
> +config SERVO_PWM
> +	tristate "Servo motor positioning"
> +	depends on PWM
> +	help
> +	  Driver to change servo motor angle.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called servo-pwm.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index d23231e73330..47796b56d7d7 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_HABANA_AI)		+=3D habanalabs/
>  obj-$(CONFIG_UACCE)		+=3D uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+=3D xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+=3D hisi_hikey_usb.o
> +obj-$(CONFIG_SERVO_PWM)	+=3D servo-pwm.o
> diff --git a/drivers/misc/servo-pwm.c b/drivers/misc/servo-pwm.c
> new file mode 100644
> index 000000000000..781ef5d79c10
> --- /dev/null
> +++ b/drivers/misc/servo-pwm.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Angelo Compagnucci <angelo.compagnucci@gmail.com>
> + *
> + * servo-pwm.c - driver for controlling servo motors via pwm.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Please drop the license boilerplate here. The purpose of the SPDX stuff
is to not need this.

> + *

While at it also drop this "empty" line.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/err.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define DEFAULT_PERIOD		2000000
> +#define DEFAULT_DUTY_0		50000
> +#define DEFAULT_DUTY_180	250000
> +#define DEFAULT_ANGLE		0
> +
> +struct servo_pwm_data {
> +	u32 duty_0;
> +	u32 duty_180;
> +	u32 period;
> +	u32 angle;
> +	struct mutex lock;
> +	struct pwm_device *pwm;
> +};
> +
> +static int servo_pwm_set(struct servo_pwm_data *servo_data)
> +{
> +	u32 new_duty =3D (servo_data->duty_180 - servo_data->duty_0) /
> +			180 * servo_data->angle + servo_data->duty_0;
> +	int ret;
> +
> +	ret =3D pwm_config(servo_data->pwm, new_duty, servo_data->period);

please use pwm_apply instead of the legacy pwm functions.

> +	return ret;
> +}
> +
> +static ssize_t angle_show(struct device *dev, struct device_attribute *a=
ttr,
> +			  char *buf)
> +{
> +	struct servo_pwm_data *servo_data =3D dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", servo_data->angle);
> +}
> +
> +static ssize_t angle_store(struct device *dev, struct device_attribute *=
attr,
> +			   const char *buf, size_t count)
> +{
> +	struct servo_pwm_data *servo_data =3D dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 10, &val);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	if (val > 180)
> +		return -EINVAL;
> +
> +	mutex_lock(&servo_data->lock);
> +
> +	servo_data->angle =3D val;
> +
> +	ret =3D servo_pwm_set(servo_data);
> +	if (ret) {
> +		mutex_unlock(&servo_data->lock);
> +		return ret;
> +	}
> +
> +	mutex_unlock(&servo_data->lock);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(angle);
> +
> +static struct attribute *servo_pwm_attrs[] =3D {
> +	&dev_attr_angle.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(servo_pwm);
> +
> +static int servo_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct servo_pwm_data *servo_data;
> +	struct pwm_args pargs;
> +	int ret =3D 0;
> +
> +	servo_data =3D devm_kzalloc(&pdev->dev, sizeof(*servo_data), GFP_KERNEL=
);
> +	if (!servo_data)
> +		return -ENOMEM;
> +
> +	if (!of_property_read_u32(node, "duty-0", &servo_data->duty_0) =3D=3D 0)
> +		servo_data->duty_0 =3D DEFAULT_DUTY_0;
> +
> +	if (!of_property_read_u32(node, "duty-180", &servo_data->duty_180) =3D=
=3D 0)
> +		servo_data->duty_180 =3D DEFAULT_DUTY_180;
> +
> +	if (!of_property_read_u32(node, "angle", &servo_data->angle) =3D=3D 0)
> +		servo_data->angle =3D DEFAULT_ANGLE;
> +
> +	servo_data->pwm =3D devm_of_pwm_get(&pdev->dev, node, NULL);
> +	if (IS_ERR(servo_data->pwm)) {
> +		ret =3D PTR_ERR(servo_data->pwm);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "unable to request pwm\n");

Please use dev_err_probe here to reduce boilerplate.

> +		return ret;
> +	}
> +
> +	pwm_apply_args(servo_data->pwm);
> +
> +	pwm_get_args(servo_data->pwm, &pargs);
> +
> +	servo_data->period =3D pargs.period;
> +
> +	if (!servo_data->period)
> +		servo_data->period =3D DEFAULT_PERIOD;
> +
> +	ret =3D servo_pwm_set(servo_data);

I wonder if you really should reconfigure the PWM in probe. I'd keep the
hardware configured as is and only act when a user requests a state
change.

> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot configure servo: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pwm_enable(servo_data->pwm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot enable servo: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, servo_data);

This is unused. (But I think it should be used in a .remove function.)

> +	ret =3D devm_device_add_groups(&pdev->dev, servo_pwm_groups);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error creating sysfs groups: %d\n", ret);
> +		return ret;

Assuming the PWM configuration stays in this function, you probably
should disable the PWM in this error path.

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_servo_pwm_match[] =3D {
> +	{ .compatible =3D "servo-pwm", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_servo_pwm_match);
> +
> +static struct platform_driver servo_pwm_driver =3D {
> +	.probe		=3D servo_pwm_probe,
> +	.driver		=3D {
> +		.name	=3D "servo-pwm",
> +		.of_match_table =3D of_servo_pwm_match,
> +	},
> +};
> +
> +module_platform_driver(servo_pwm_driver);
> +
> +MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
> +MODULE_DESCRIPTION("generic PWM servo motor driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.25.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--74lwahphb3cujflz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+CksACgkQwfwUeK3K
7AkvSAf/WO3HnyT8VIPgYaZlslsDC8SQVFunVYAC1gKnEHNEBGw4pxleYPO+mB2k
cKjAHe7Wp+Ptf47DdiyrBHJlIcOhGJFqqlSROUQjZXSqesnI75tizeXDmagh32/Q
sRIV93VxCJ/W2GBo4EBzNIjrWI9RuCP1qZ+iiHEuK7a2rQx0SaYqemP7wlfgDVja
ypABvGulOsRqPPYPyDTT7XH/NtVOAdy+QlwGDZHuPYvpUxbiYJujTWBrIx6LWhUm
1LBK50G3iR7cyend57Hpu/+Zjf2fX/geHCqch2FxxrhrmWiAdahhrIUsHVGL/Ayf
+Mp0s5JRPOUdK2NBs817yJmO4DSSyw==
=/VaH
-----END PGP SIGNATURE-----

--74lwahphb3cujflz--
