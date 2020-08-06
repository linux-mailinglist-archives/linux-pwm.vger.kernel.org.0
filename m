Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5F823D814
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgHFIkN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 04:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgHFIkM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 04:40:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15CC061575
        for <linux-pwm@vger.kernel.org>; Thu,  6 Aug 2020 01:40:12 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3bRW-0002CC-GQ; Thu, 06 Aug 2020 10:40:06 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3bRQ-0007rq-G1; Thu, 06 Aug 2020 10:40:00 +0200
Date:   Thu, 6 Aug 2020 10:40:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
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
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
References: <20200803093559.12289-1-michael@walle.cc>
 <20200803093559.12289-7-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vgnlsgd3pefacvw3"
Content-Disposition: inline
In-Reply-To: <20200803093559.12289-7-michael@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vgnlsgd3pefacvw3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

I'm nearly happy now; see below.

On Mon, Aug 03, 2020 at 11:35:52AM +0200, Michael Walle wrote:
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

Is it sensible to present this option to everyone? Maybe

	depends on SOME_SYMBOL_ONLY_TRUE_ON_SL28CPLD || COMPILE_TEST

=2E

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
> index 000000000000..bb298af36f0b
> --- /dev/null
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -0,0 +1,235 @@
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
> + * +-----------+--------+--------------+-----------+---------------+
> + * | prescaler |  reset | counter bits | frequency | period length |
> + * +-----------+--------+--------------+-----------+---------------+
> + * |         0 | cnt[7] |     cnt[6:0] |    250 Hz |    4000000 ns |
> + * |         1 | cnt[6] |     cnt[5:0] |    500 Hz |    2000000 ns |
> + * |         2 | cnt[5] |     cnt[4:0] |     1 kHz |    1000000 ns |
> + * |         3 | cnt[4] |     cnt[3:0] |     2 kHz |     500000 ns |
> + * +-----------+--------+--------------+-----------+---------------+
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

Very nice.

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
> + *   max_period_ns =3D 1 << (7 - prescaler) / pwm_clk * NSEC_PER_SEC
> + *   max_duty_cycle =3D 1 << (7 - prescaler)
> + * this then simplifies to:
> + *   duty_cycle_ns =3D pwm_cycle_reg / pwm_clk * NSEC_PER_SEC
> + *
> + * NSEC_PER_SEC and SL28CPLD_PWM_CLK is integer here, so we're not losing
> + * precision by doing the divison first.

Apart from the grammatical issue (s/is/are/) this is not the relevant
fact. The relevant thing is that NSEC_PER_SEC / SL28CPLD_PWM_CLK is
integer.

(In case this is not clear, assume SL28CPLD_PWM_CLK to be 30000 and reg
0x12345.

Then we have:=20

	NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg) -> 0x94255749
	NSEC_PER_SEC * (reg) / SL28CPLD_PWM_CLK -> 0x9425b860

=2E)

> + */
> +#define SL28CPLD_PWM_TO_DUTY_CYCLE(reg) \
> +	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg))
> +#define SL28CPLD_PWM_FROM_DUTY_CYCLE(duty_cycle) \
> +	(DIV_ROUND_DOWN_ULL((duty_cycle), NSEC_PER_SEC / SL28CPLD_PWM_CLK))
> +
> +#define sl28cpld_pwm_read(priv, reg, val) \
> +	regmap_read((priv)->regmap, (priv)->offset + (reg), (val))
> +#define sl28cpld_pwm_write(priv, reg, val) \
> +	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
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
> +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CTRL, &reg);
> +
> +	state->enabled =3D reg & SL28CPLD_PWM_CTRL_ENABLE;
> +
> +	prescaler =3D FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
> +	state->period =3D SL28CPLD_PWM_PERIOD(prescaler);
> +
> +	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CYCLE, &reg);
> +	state->duty_cycle =3D SL28CPLD_PWM_TO_DUTY_CYCLE(reg);

Should reg be masked to SL28CPLD_PWM_CYCLE_MAX, or is it guaranteed that
the upper bits are zero?

> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vgnlsgd3pefacvw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8rwd0ACgkQwfwUeK3K
7AmfeAf9Gjs6d6RYl4cHjGm5WtyaW7dy/H/ZhBTXazWZi9T2vSKNCbP7eDdMWVqK
mGWH4KuK60xZp0FN7GcX1LLw98U3NVz6SQGyQJKe9YbvFCX8mHsUI3L2R/vPprgb
xLa89BSlnoaUd/KovXXGa++KHFfEqQ/9jTxBYqiLBnHhKK2TEL9QWVwLnzGo0b9T
N4xzqBfInTCN10AaDNURikxMx1EmP9DaOp2X2LSLlBIkB47mt9jfsQiUy8SHcoF1
xAx+Ryx0g3t3iXvbv6y9AbuUxaEteZQ8bn+2hP3PHaAo4NyvnaqPM/BFj/SL6RKj
7d0IxQE5ptk05VI2zx0zwpDFPjk3ow==
=OBgf
-----END PGP SIGNATURE-----

--vgnlsgd3pefacvw3--
