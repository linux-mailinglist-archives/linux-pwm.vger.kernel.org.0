Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343A322E694
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgG0Had (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgG0Hab (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:30:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B83C0619D2;
        Mon, 27 Jul 2020 00:30:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so8135311edv.13;
        Mon, 27 Jul 2020 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZogJSbFZGKS4456SNdiwdnmFxJXIJiCVuG2HTKrcxT8=;
        b=t3SG7ItEf8Ly8393lx/82hBZyrr3oVpuAY0Km9gXsURsqAI64J9bQ6sTnCl/yOVD7C
         pt2RBSBm+AmhHmG6f/0AHrt3ZsnclMWohBUrXsiIU5665vgIovwtyOVCyuoCJhmC/mEY
         FCx9Ry00IDV8FqeJLcNLQZkwQHmNqnlk8wG6z0RKHBXnNfPtYfg9QHtTppazNQ8mtMOa
         RHkh+GnTQhSsS5tni3M2RbkSHSCuSCO/0ow/t8gnZ//Yi5O4SjEHGS6ZubeyyA++Lasw
         RObPWn3Rrd9aEvrm6/5en0q9nWO82UsL1bE34lFT74LZ0AdEh9IResZcnUgb+mC7othX
         tv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZogJSbFZGKS4456SNdiwdnmFxJXIJiCVuG2HTKrcxT8=;
        b=BzsS0dlfkZv8mCSm0tNqQBDYcD+XSSyLAMchTst42VDqGNRQ+yoqppmCKrY+QDLw+S
         5LePYXY9I8POZojktz/KZlAaKNdZOYfAen50OacWqKLiKZomQhLHueV4dHruFj8MAmZR
         54D2sk7VIYrq65ycbBfjHmEDYCAxemZUqqFH2CBk8Si4+07EXPDnedSB5Z3wAtHBVLDu
         Zf6HjIFbmUG7HXb+MRsIokkmBV8ruRqoEETyiHG1JLqug6FW3iEjTEudv69fDR0vK5Ip
         AjJ7g8kwILO1/Iz5SFmAz8U8JiUkMAWddbx0U6HoCQ2t2PJ9zyTw/eWlnrO6gFN5Cvwy
         y0NA==
X-Gm-Message-State: AOAM530+YZqRDP9RJmQ86T2FU8MqfFpLKUccCmTVDmuoHJloQefT3A7w
        gDklpheLByLyGVZQ7DmxttQ=
X-Google-Smtp-Source: ABdhPJwqPHK3EGpOyshHl4BMFcurwOw5DDd3u4V9R11/0h1kYq2ZoqPeSJbQ90hDDn1EVei8kS9fIw==
X-Received: by 2002:a05:6402:8d6:: with SMTP id d22mr13344909edz.285.1595835029549;
        Mon, 27 Jul 2020 00:30:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id sd8sm4692467ejb.58.2020.07.27.00.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:30:28 -0700 (PDT)
Date:   Mon, 27 Jul 2020 09:30:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200727073027.GA2781612@ulmo>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-7-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20200725231834.25642-7-michael@walle.cc>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2020 at 01:18:27AM +0200, Michael Walle wrote:
> Add support for the PWM controller of the sl28cpld board management
> controller. This is part of a multi-function device driver.
>=20
> The controller has one PWM channel and can just generate four distinct
> frequencies.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v5:
>  - added brief description of the PWM hardware implementation
>  - added hardware limitations
>  - dropped the frequency mode table, instead calculate the prescaler
>    value on the fly.
>  - round the requested parameters instead of support just distinct
>    periods.
>  - prefix the macros by SL28CPLD_ to make them less generic
>  - set polarity to PWM_POLARITY_NORMAL and reject inverted polarity
>    requests.
>  - apply the workaround just for prescaler value of 0.
>  - make errors during probing more verbose
>=20
> Changes since v4:
>  - update copyright year
>  - remove #include <linux/of_device.h>, suggested by Andy.
>  - make the pwm mode table look nicer, suggested by Lee.
>  - use dev_get_drvdata(chip->dev) instead of container_of(), suggested by
>    Lee.
>  - use whole sentence in comments, suggested by Lee.
>  - renamed the local "struct sl28cpld_pwm" variable to "priv" everywhere,
>    suggested by Lee.
>  - use pwm_{get,set}_relative_duty_cycle(), suggested by Andy.
>  - make the comment about the 250Hz hardware limitation clearer
>  - don't use "if (ret < 0)", but only "if (ret)", suggested by Andy.
>  - don't use KBUID_MODNAME
>  - remove comma in terminator line of the compatible strings list
>  - remove the platform device table
>=20
> Changes since v3:
>  - see cover letter
>=20
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-sl28cpld.c | 223 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sl28cpld.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf6973d33..a0d50d70c3b9 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -428,6 +428,16 @@ config PWM_SIFIVE
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sifive.
> =20
> +config PWM_SL28CPLD
> +	tristate "Kontron sl28cpld PWM support"
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	  Generic PWM framework driver for board management controller
> +	  found on the Kontron sl28 CPLD.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sl28cpld.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a03557..cbdcd55d69ee 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> +obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+=3D pwm-sprd.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> new file mode 100644
> index 000000000000..956fa09f3aba
> --- /dev/null
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld PWM driver
> + *
> + * Copyright (c) 2020 Michael Walle <michael@walle.cc>
> + *
> + * There is no public datasheet available for this PWM core. But it is e=
asy
> + * enough to be briefly explained. It consists of one 8-bit counter. The=
 PWM
> + * supports four distinct frequencies by selecting when to reset the cou=
nter.
> + * With the prescaler setting you can select which bit of the counter is=
 used
> + * to reset it. This implies that the higher the frequency the less rema=
ining
> + * bits are available for the actual counter.
> + *
> + * Let cnt[7:0] be the counter, clocked at 32kHz:
> + * +-----------+--------+--------------+-----------+
> + * | prescaler |  reset | counter bits | frequency |
> + * +-----------+--------+--------------+-----------+
> + * |         0 | cnt[7] |     cnt[6:0] |     250Hz |
> + * |         1 | cnt[6] |     cnt[5:0] |     500Hz |
> + * |         2 | cnt[5] |     cnt[4:0] |      1kHz |
> + * |         3 | cnt[4] |     cnt[3:0] |      2kHz |
> + * +-----------+--------+--------------+-----------+
> + *
> + * Limitations:
> + * - The hardware cannot generate a 100% duty cycle if the prescaler is =
0.
> + * - The hardware cannot atomically set the prescaler and the counter va=
lue,
> + *   which might lead to glitches and inconsistent states if a write fai=
ls.
> + * - The counter is not reset if you switch the prescaler which leads
> + *   to glitches, too.
> + * - The duty cycle will switch immediately and not after a complete cyc=
le.
> + * - Depending on the actual implementation, disabling the PWM might have
> + *   side effects. For example, if the output pin is shared with a GPIO =
pin
> + *   it will automatically switch back to GPIO mode.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * PWM timer block registers.
> + */
> +#define SL28CPLD_PWM_CTRL			0x00
> +#define   SL28CPLD_PWM_CTRL_ENABLE		BIT(7)
> +#define   SL28CPLD_PWM_CTRL_PRESCALER_MASK	GENMASK(1, 0)
> +#define SL28CPLD_PWM_CYCLE			0x01
> +#define   SL28CPLD_PWM_CYCLE_MAX		GENMASK(6, 0)
> +
> +#define SL28CPLD_PWM_CLK			32000 /* 32 kHz */
> +#define SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler)	(1 << (7 - (prescaler)))
> +#define SL28CPLD_PWM_PERIOD(prescaler) \
> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * SL28CPLD_PWM_MAX_DUTY_CYCLE(prescale=
r))
> +
> +/*
> + * We calculate the duty cycle like this:
> + *   duty_cycle_ns =3D pwm_cycle_reg * max_period_ns / max_duty_cycle
> + *
> + * With
> + *   max_period_ns =3D (1 << 7 - prescaler) / pwm_clk * NSEC_PER_SEC
> + *   max_duty_cycle =3D 1 << (7 - prescaler)
> + * this then simplifies to:
> + *   duty_cycle_ns =3D pwm_cycle_reg / pwm_clk * NSEC_PER_SEC
> + */
> +#define SL28CPLD_PWM_TO_DUTY_CYCLE(reg) \
> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg))
> +#define SL28CPLD_PWM_FROM_DUTY_CYCLE(duty_cycle) \
> +	(DIV_ROUND_DOWN_ULL((duty_cycle), NSEC_PER_SEC / SL28CPLD_PWM_CLK))
> +
> +struct sl28cpld_pwm {
> +	struct pwm_chip pwm_chip;
> +	struct regmap *regmap;
> +	u32 offset;
> +};
> +
> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> +	unsigned int reg;
> +	int prescaler;
> +
> +	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, &reg);
> +
> +	state->enabled =3D reg & SL28CPLD_PWM_CTRL_ENABLE;
> +
> +	prescaler =3D FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
> +	state->period =3D SL28CPLD_PWM_PERIOD(prescaler);
> +
> +	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, &reg);
> +	state->duty_cycle =3D SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> +	unsigned int cycle, prescaler;
> +	int ret;
> +	u8 ctrl;
> +
> +	/* Polarity inversion is not supported */
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;

Just a note to myself since this just occurred to me: in the legacy API
we used to have a ->set_polarity() callback that indicated whether or
not a controller supports inversion. Since that criterion can no longer
be used with the atomic API we may want to consider adding some sort of
capability flags so that these checks can be performed in the core.

> +
> +	/*
> +	 * Calculate the prescaler. Pick the the biggest period that isn't
> +	 * bigger than the requested period.
> +	 */
> +	prescaler =3D DIV_ROUND_UP_ULL(SL28CPLD_PWM_PERIOD(0), state->period);
> +	prescaler =3D order_base_2(prescaler);
> +
> +	if (prescaler > field_max(SL28CPLD_PWM_CTRL_PRESCALER_MASK))
> +		return -ERANGE;
> +
> +	ctrl =3D FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, prescaler);
> +	if (state->enabled)
> +		ctrl |=3D SL28CPLD_PWM_CTRL_ENABLE;
> +
> +	cycle =3D SL28CPLD_PWM_FROM_DUTY_CYCLE(state->duty_cycle);
> +	cycle =3D min_t(unsigned int, cycle, SL28CPLD_PWM_MAX_DUTY_CYCLE(presca=
ler));
> +
> +	/*
> +	 * Work around the hardware limitation. See also above. Trap 100% duty
> +	 * cycle if the prescaler is 0. Set prescaler to 1 instead. We don't
> +	 * care about the frequency because its "all-one" in either case.
> +	 *
> +	 * We don't need to check the actual prescaler setting, because only
> +	 * if the prescaler is 0 we can have this particular value.
> +	 */
> +	if (cycle =3D=3D SL28CPLD_PWM_MAX_DUTY_CYCLE(0)) {
> +		ctrl &=3D ~SL28CPLD_PWM_CTRL_PRESCALER_MASK;
> +		ctrl |=3D FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, 1);
> +		cycle =3D SL28CPLD_PWM_MAX_DUTY_CYCLE(1);
> +	}
> +
> +	ret =3D regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, ct=
rl);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, (u=
8)cycle);
> +}
> +
> +static const struct pwm_ops sl28cpld_pwm_ops =3D {
> +	.apply =3D sl28cpld_pwm_apply,
> +	.get_state =3D sl28cpld_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int sl28cpld_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_pwm *priv;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!priv->regmap)
> +		return -ENODEV;
> +
> +	ret =3D device_property_read_u32(&pdev->dev, "reg", &priv->offset);
> +	if (ret) {
> +		dev_err(&pdev->dev, "no 'reg' property found (%pe)\n",
> +			ERR_PTR(ret));
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize the pwm_chip structure */
> +	chip =3D &priv->pwm_chip;
> +	chip->dev =3D &pdev->dev;
> +	chip->ops =3D &sl28cpld_pwm_ops;
> +	chip->base =3D -1;
> +	chip->npwm =3D 1;
> +
> +	ret =3D pwmchip_add(&priv->pwm_chip);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add PWM chip (%pe)",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int sl28cpld_pwm_remove(struct platform_device *pdev)
> +{
> +	struct sl28cpld_pwm *priv =3D platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&priv->pwm_chip);
> +}
> +
> +static const struct of_device_id sl28cpld_pwm_of_match[] =3D {
> +	{ .compatible =3D "kontron,sl28cpld-pwm" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
> +
> +static struct platform_driver sl28cpld_pwm_driver =3D {
> +	.probe =3D sl28cpld_pwm_probe,
> +	.remove	=3D sl28cpld_pwm_remove,
> +	.driver =3D {
> +		.name =3D "sl28cpld-pwm",
> +		.of_match_table =3D sl28cpld_pwm_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_pwm_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld PWM Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");

Looks good to me. I assume Lee will want to merge this along with the
other changes through the MFD tree? If so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8egpEACgkQ3SOs138+
s6Ez9BAAhZLjThBmeOg8f81WOvTomRmiPyxu7gP1ASKSrT0Ry0avKrmLr9PZy5cn
YoZCN5cw0qzG90nt9KvA3FWIR5t4FbFVodw2gTt7ccYKnCpvfddPUpyU9KMxcP2t
sv3TSkDfgKj4ca8c92Ig9Ezyq5w9/JxQQrzPqiqSxZLvJ1iS8FILV65bgZJ3yPmY
3GwOuK4QaiQUbgSxnmxJcyuhUfwwAlOIeEVg10u0BrgesB5ChNiLy9Bpbn/+ySXV
aGJnmRVfaEjuTsCtgNBCSXNvabsDGHK++RsL8B0noCfMQbt1Map2cnHXVnNj+mQ0
kpTC5rGnUIr+Gqo/X7E7CEHfrSY6dPyJOhkzREI6LNgLu/5yCSUKmndsiCDkwEGM
WkEaUlsHRuZtkh7NcrM5laa/ypXNtQ5DqHzK8cO1t56JbJ47TVZLhSz38uUUjQLg
vTGTjeybp56y+d8jj2vyxjup51FrZ2mqAMRxPPAywaMSDDLf/t9dltzXOhhJUWPP
wDTbaBBZmZlRUmBqeRR98yWLG8wLkjZyPwsQAtoy+zv62QStA4pAHkc7golDM4tq
exyniXweObjENYToRwIjvQFYSuBoKlmylzoJS+46WjMs57ktFckYg1xfy6SGWC/u
6nX/tYFLZVzM9H7Z8ADntQBiwtoplEVu5Jyife4rxMN13d5qkfg=
=ghor
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
