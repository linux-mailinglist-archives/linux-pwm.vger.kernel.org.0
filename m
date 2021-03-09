Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1129C332271
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Mar 2021 10:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCIJ7J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Mar 2021 04:59:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:59890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhCIJ7F (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Mar 2021 04:59:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D23F1AB8C;
        Tue,  9 Mar 2021 09:59:02 +0000 (UTC)
Message-ID: <957566acbdbe1155eeb561c324d2404bbbf7e7af.camel@suse.de>
Subject: Re: [PATCH v7 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de
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
Date:   Tue, 09 Mar 2021 10:59:00 +0100
In-Reply-To: <20210118123244.13669-12-nsaenzjulienne@suse.de>
References: <20210118123244.13669-1-nsaenzjulienne@suse.de>
         <20210118123244.13669-12-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XkvVwEIv7TyrTi24H2y+"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-XkvVwEIv7TyrTi24H2y+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-18 at 13:32 +0100, Nicolas Saenz Julienne wrote:
> Adds support to control the PWM bus available in official Raspberry Pi
> PoE HAT. Only RPi's co-processor has access to it, so commands have to
> be sent through RPi's firmware mailbox interface.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> ---

ping :)

> Changes since v6:
> - Use %pe
> - Round divisions properly
> - Use dev_err_probe()
> - Pass check_patch
>=20
> Changes since v3:
> =C2=A0- Rename compatible string to be more explicit WRT to bus's limitat=
ions
>=20
> Changes since v2:
> =C2=A0- Use devm_rpi_firmware_get()
> =C2=A0- Rename driver
> =C2=A0- Small cleanups
>=20
> Changes since v1:
> =C2=A0- Use default pwm bindings and get rid of xlate() function
> =C2=A0- Correct spelling errors
> =C2=A0- Correct apply() function
> =C2=A0- Round values
> =C2=A0- Fix divisions in arm32 mode
> =C2=A0- Small cleanups
>=20
> =C2=A0drivers/pwm/Kconfig               |   9 ++
> =C2=A0drivers/pwm/Makefile              |   1 +
> =C2=A0drivers/pwm/pwm-raspberrypi-poe.c | 220 +++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 230 insertions(+)
> =C2=A0create mode 100644 drivers/pwm/pwm-raspberrypi-poe.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0937e1c047ac..75e2344703b3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -423,6 +423,15 @@ config PWM_PXA
> =C2=A0	  To compile this driver as a module, choose M here: the module
> =C2=A0	  will be called pwm-pxa.
> =C2=A0
>=20
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
> =C2=A0config PWM_RCAR
> =C2=A0	tristate "Renesas R-Car PWM support"
> =C2=A0	depends on ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 18b89d7fd092..ed28d7bd4c64 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
> =C2=A0obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
> =C2=A0obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
> =C2=A0obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> +obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-poe.o
> =C2=A0obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> =C2=A0obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> =C2=A0obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberr=
ypi-poe.c
> new file mode 100644
> index 000000000000..ca845e8fabe6
> --- /dev/null
> +++ b/drivers/pwm/pwm-raspberrypi-poe.c
> @@ -0,0 +1,220 @@
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
> +static inline
> +struct raspberrypi_pwm *raspberrypi_pwm_from_chip(struct pwm_chip *chip)
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
> +	struct raspberrypi_pwm *rpipwm =3D raspberrypi_pwm_from_chip(chip);
> +
> +	state->period =3D RPI_PWM_PERIOD_NS;
> +	state->duty_cycle =3D DIV_ROUND_UP(rpipwm->duty_cycle * RPI_PWM_PERIOD_=
NS,
> +					 RPI_PWM_MAX_DUTY);
> +	state->enabled =3D !!(rpipwm->duty_cycle);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 const struct pwm_state *state)
> +{
> +	struct raspberrypi_pwm *rpipwm =3D raspberrypi_pwm_from_chip(chip);
> +	unsigned int duty_cycle;
> +	int ret;
> +
> +	if (state->period < RPI_PWM_PERIOD_NS ||
> +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled)
> +		duty_cycle =3D 0;
> +	else if (state->duty_cycle < RPI_PWM_PERIOD_NS)
> +		duty_cycle =3D DIV_ROUND_DOWN_ULL(state->duty_cycle * RPI_PWM_MAX_DUTY=
,
> +						RPI_PWM_PERIOD_NS);
> +	else
> +		duty_cycle =3D RPI_PWM_MAX_DUTY;
> +
> +	if (duty_cycle =3D=3D rpipwm->duty_cycle)
> +		return 0;
> +
> +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DUTY=
_REG,
> +					   duty_cycle);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to set duty cycle: %pe\n",
> +			ERR_PTR(ret));
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
> +		dev_err(chip->dev, "Failed to set default duty cycle: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	rpipwm->duty_cycle =3D duty_cycle;
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
> +		return dev_err_probe(dev, -EPROBE_DEFER,
> +				     "Failed to get firmware handle\n");
> +
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
> +		dev_err(dev, "Failed to get duty cycle: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	return pwmchip_add(&rpipwm->chip);
> +}
> +
> +static int raspberrypi_pwm_remove(struct platform_device *pdev)
> +{
> +	struct raspberrypi_pwm *rpipwm =3D platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&rpipwm->chip);
> +}
> +
> +static const struct of_device_id raspberrypi_pwm_of_match[] =3D {
> +	{ .compatible =3D "raspberrypi,firmware-poe-pwm", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, raspberrypi_pwm_of_match);
> +
> +static struct platform_driver raspberrypi_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "raspberrypi-poe-pwm",
> +		.of_match_table =3D raspberrypi_pwm_of_match,
> +	},
> +	.probe =3D raspberrypi_pwm_probe,
> +	.remove =3D raspberrypi_pwm_remove,
> +};
> +module_platform_driver(raspberrypi_pwm_driver);
> +
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
> +MODULE_DESCRIPTION("Raspberry Pi Firmware Based PWM Bus Driver");
> +MODULE_LICENSE("GPL v2");



--=-XkvVwEIv7TyrTi24H2y+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBHRuQACgkQlfZmHno8
x/6bhAgAjegsPioj3j6MWcBDKcu5q9aMkfekHwUUrVQTw97Ee7H4pzxnrprNHUSx
cBkz+ZkNh1wcjq3CBgicqP2au9oQVvadK59lOPd09lsuaYgOuS2umWQAmEm0ei1j
1l+3R93k1yBEGT61bkAA75n6ygFugkjgHyQ3kffUlrHCNH2A582pwYdFLbuGa/4P
j44MNokRo6uWKxVp9dQ5WgyQM6IN9Iwz6Kfyl9Bah7YcLiv+RMwHv+k6DW9Fnqm1
mzahMTf/vJ/7NQyXwl0XFsyaYnDGfTxExce8i83Yyke1eLY32HWBkzJA4r8k0TIt
DjouL9S4PLDtkSLmje4Caiapg1s+ng==
=3nSG
-----END PGP SIGNATURE-----

--=-XkvVwEIv7TyrTi24H2y+--

