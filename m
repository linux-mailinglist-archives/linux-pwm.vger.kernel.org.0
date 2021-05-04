Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC1372794
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhEDIwL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 04:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEDIwL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 04:52:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5CC061574
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 01:51:16 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldqlu-0005ZA-Pe; Tue, 04 May 2021 10:51:14 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldqls-00045e-WB; Tue, 04 May 2021 10:51:13 +0200
Date:   Tue, 4 May 2021 10:51:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210504085112.edyy6loprfzejrjl@pengutronix.de>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2tukfphry7cqh47h"
Content-Disposition: inline
In-Reply-To: <20210503214413.3145015-2-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2tukfphry7cqh47h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. There is another driver for this device located
> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>=20
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_tim=
er/v1_03_a/axi_timer_ds764.pdf
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>=20
>  arch/arm64/configs/defconfig |   1 +
>  drivers/pwm/Kconfig          |  11 ++
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
>  4 files changed, 335 insertions(+)
>  create mode 100644 drivers/pwm/pwm-xilinx.c
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 08c6f769df9a..81794209f287 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=3Dy
>  CONFIG_PWM_SL28CPLD=3Dm
>  CONFIG_PWM_SUN4I=3Dm
>  CONFIG_PWM_TEGRA=3Dm
> +CONFIG_PWM_XILINX=3Dm
>  CONFIG_SL28CPLD_INTC=3Dy
>  CONFIG_QCOM_PDC=3Dy
>  CONFIG_RESET_IMX7=3Dy

I think this should go into a separate patch once this driver is
accepted. This can then go via the ARM people.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index d3371ac7b871..01e62928f4bf 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -628,4 +628,15 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
> =20
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
> +	depends on !MICROBLAZE

I don't understand this dependency.

> +	help
> +	  PWM framework driver for Xilinx LogiCORE IP AXI Timers. This
> +	  timer is typically a soft core which may be present in Xilinx
> +	  FPGAs. If you don't have this IP in your design, choose N.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-xilinx.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index d3879619bd76..fc1bd6ccc9ed 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..240bd2993f97
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + */

Please add a link to a reference manual here (if available) and add a
paragraph about hardware properties: Does the hardware complete cycles
on reconfiguration or disable? Are there limitiation like "Cannot run
with 100% duty cycle"? Please look into e.g. pwm-sifive how this is done
and stick to the same format for easy grepping.

> +#include <asm/io.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define TCSR0	0x00
> +#define TLR0	0x04
> +#define TCR0	0x08
> +#define TCSR1	0x10
> +#define TLR1	0x14
> +#define TCR1	0x18
> +
> +#define TCSR_MDT	BIT(0)
> +#define TCSR_UDT	BIT(1)
> +#define TCSR_GENT	BIT(2)
> +#define TCSR_CAPT	BIT(3)
> +#define TCSR_ARHT	BIT(4)
> +#define TCSR_LOAD	BIT(5)
> +#define TCSR_ENIT	BIT(6)
> +#define TCSR_ENT	BIT(7)
> +#define TCSR_TINT	BIT(8)
> +#define TCSR_PWMA	BIT(9)
> +#define TCSR_ENALL	BIT(10)
> +#define TCSR_CASC	BIT(11)

I'd like to see a prefix for these defines, something like XILINX_PWM_
maybe?

> +/* Bits we need to set/clear to enable PWM mode, not including CASC */
> +#define TCSR_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
> +#define TCSR_CLEAR (TCSR_MDT | TCSR_LOAD)

Maybe call this XILINX_PWM_TCSR_DEFAULT?

> +#define NSEC_PER_SEC_ULL 1000000000ULL
> +
> +/**
> + * struct xilinx_pwm_device - Driver data for Xilinx AXI timer PWM driver
> + * @chip: PWM controller chip
> + * @clk: Parent clock
> + * @regs: Base address of this device
> + * @width: Width of the counters, in bits
> + */
> +struct xilinx_pwm_device {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *regs;
> +	unsigned int width;
> +};
> +
> +static inline struct xilinx_pwm_device *xilinx_pwm_chip_to_device(struct=
 pwm_chip *chip)
> +{
> +	return container_of(chip, struct xilinx_pwm_device, chip);
> +}
> +
> +static bool xilinx_pwm_is_enabled(u32 tcsr0, u32 tcsr1)
> +{
> +	return !(~tcsr0 & TCSR_SET || tcsr0 & (TCSR_CLEAR | TCSR_CASC) ||
> +		 ~tcsr1 & TCSR_SET || tcsr1 & TCSR_CLEAR);
> +}
> +
> +static u32 xilinx_pwm_calc_tlr(struct xilinx_pwm_device *pwm, u32 tcsr,
> +			       unsigned int period)
> +{
> +	u64 cycles =3D DIV_ROUND_DOWN_ULL(period * clk_get_rate(pwm->clk),
> +					NSEC_PER_SEC_ULL);

NSEC_PER_SEC should work just fine here.

> +
> +	if (tcsr & TCSR_UDT)
> +		return cycles - 2;

What happens if cycles <=3D 1?

> +	else
> +		return (BIT_ULL(pwm->width) - 1) - cycles + 2;

What happens if cycles > BIT_ULL(pwm->width)?

> +}
> +
> +static unsigned int xilinx_pwm_get_period(struct xilinx_pwm_device *pwm,
> +					  u32 tlr, u32 tcsr)
> +{
> +	u64 cycles;
> +
> +	if (tcsr & TCSR_UDT)
> +		cycles =3D tlr + 2;
> +	else
> +		cycles =3D (BIT_ULL(pwm->width) - 1) - tlr + 2;
> +
> +	return DIV_ROUND_DOWN_ULL(cycles * NSEC_PER_SEC_ULL,
> +				  clk_get_rate(pwm->clk));

Please round up here. The idea is that applying the result from
=2Eget_state() should not modify the configuration. You might want to
enable PWM_DEBUG to test your driver.

> +}
> +
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *un=
used,
> +			    const struct pwm_state *state)
> +{
> +	struct xilinx_pwm_device *pwm =3D xilinx_pwm_chip_to_device(chip);
> +	u32 tlr0, tlr1;
> +	u32 tcsr0 =3D readl(pwm->regs + TCSR0);
> +	u32 tcsr1 =3D readl(pwm->regs + TCSR1);
> +	bool enabled =3D xilinx_pwm_is_enabled(tcsr0, tcsr1);
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!enabled && state->enabled)
> +		clk_rate_exclusive_get(pwm->clk);

Missing error checking.

> +
> +	tlr0 =3D xilinx_pwm_calc_tlr(pwm, tcsr0, state->period);

Please care for overflowing. If state->period >=3D U64_MAX /
clk_get_rate(pwm->clk) the multiplication in xilinx_pwm_calc_tlr is
susceptible. Please do something like:

	... calculate maximal period ...

	if (state->period > max_period)
		period =3D max_period
	else
		period =3D state->period;

	...

The algorithm to implement is: Configure the biggest possible period not
bigger than state->period. With that period configure the biggest
duty_cycle not bigger than state->duty_cycle.

> +	tlr1 =3D xilinx_pwm_calc_tlr(pwm, tcsr1, state->duty_cycle);
> +	writel(tlr0, pwm->regs + TLR0);
> +	writel(tlr1, pwm->regs + TLR1);

How does the hardware behave here? E.g. can it happen that after writing
TLR0 we can see a cycle with the new period but the old duty_cycle? Does
it complete the currently running period?

If state->enabled =3D=3D 0 you want to disable first to prevent that the
(maybe) new values for period and duty_cycle are emitted by the
hardware.

> +	if (state->enabled) {
> +		/* Only touch the TCSRs if we aren't already running */
> +		if (!enabled) {
> +			/* Load TLR into TCR */
> +			writel(tcsr0 | TCSR_LOAD, pwm->regs + TCSR0);
> +			writel(tcsr1 | TCSR_LOAD, pwm->regs + TCSR1);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 =3D (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 =3D TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			writel(tcsr0, pwm->regs + TCSR0);
> +			writel(tcsr1, pwm->regs + TCSR1);
> +		}
> +	} else {
> +		writel(tcsr0 & ~TCSR_ENT, pwm->regs + TCSR0);
> +		writel(tcsr1 & ~TCSR_ENT, pwm->regs + TCSR1);

How does the hardware behave on disable? Does it always emit a low
level? Does it complete the currently running period?

> +	}
> +
> +	if (enabled && !state->enabled)
> +		clk_rate_exclusive_put(pwm->clk);
> +
> +	return 0;
> +}
> +
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *unused,
> +				 struct pwm_state *state)
> +{
> +	struct xilinx_pwm_device *pwm =3D xilinx_pwm_chip_to_device(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> +	tlr0 =3D readl(pwm->regs + TLR0);
> +	tlr1 =3D readl(pwm->regs + TLR1);
> +	tcsr0 =3D readl(pwm->regs + TCSR0);
> +	tcsr1 =3D readl(pwm->regs + TCSR1);
> +
> +	state->period =3D xilinx_pwm_get_period(pwm, tlr0, tcsr0);
> +	state->duty_cycle =3D xilinx_pwm_get_period(pwm, tlr1, tcsr1);
> +	state->enabled =3D xilinx_pwm_is_enabled(tcsr0, tcsr1);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops =3D {
> +	.apply =3D xilinx_pwm_apply,
> +	.get_state =3D xilinx_pwm_get_state,

=2Eowner is missing

> +};
> +
> +static struct dentry *debug_dir;
> +
> +#define DEBUG_REG(reg) { .name =3D #reg, .offset =3D (reg), }
> +static struct debugfs_reg32 xilinx_pwm_reg32[] =3D {
> +	DEBUG_REG(TCSR0),
> +	DEBUG_REG(TLR0),
> +	DEBUG_REG(TCR0),
> +	DEBUG_REG(TCSR1),
> +	DEBUG_REG(TLR1),
> +	DEBUG_REG(TCR1),
> +};
> +
> +static int xilinx_pwm_debug_create(struct xilinx_pwm_device *pwm)
> +{
> +	struct debugfs_regset32 *regset;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return 0;
> +
> +	regset =3D devm_kzalloc(pwm->chip.dev, sizeof(*regset), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	regset->regs =3D xilinx_pwm_reg32;
> +	regset->nregs =3D ARRAY_SIZE(xilinx_pwm_reg32);
> +	regset->base =3D pwm->regs;
> +
> +	debugfs_create_regset32(dev_name(pwm->chip.dev), 0400, debug_dir,
> +				regset);

debug_dir might not yet be initialized here.

> +	return 0;
> +}

This is unusual to have in a driver. Something like memtool[1] should
work just fine, then you don't need this debugfs file. Together with pwm
tracing this should be good enough.

[1] https://github.com/pengutronix/memtool

> +static int xilinx_pwm_probe(struct platform_device *pdev)
> +{
> +	bool enabled;
> +	int i, ret;
> +	struct device *dev =3D &pdev->dev;
> +	struct xilinx_pwm_device *pwm;
> +	u32 one_timer;
> +
> +	ret =3D of_property_read_u32(dev->of_node, "xlnx,one-timer-only",
> +				   &one_timer);
> +	if (ret || one_timer) {
> +		dev_err(dev, "two timers are needed for PWM mode\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < 2; i++) {
> +		char fmt[] =3D "xlnx,gen%u-assert";
> +		char buf[sizeof(fmt)];
> +		u32 gen;
> +
> +		snprintf(buf, sizeof(buf), fmt, i);
> +		ret =3D of_property_read_u32(dev->of_node, buf, &gen);
> +		if (ret || !gen) {
> +			dev_err(dev, "generateout%u must be active high\n", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, pwm);
> +
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.ops =3D &xilinx_pwm_ops;
> +	pwm->chip.base =3D -1;

Please drop the assignment to .base. See commit
f9a8ee8c8bcd118e800d88772c6457381db45224 in next.

> +	pwm->chip.npwm =3D 1;
> +
> +	pwm->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->regs))
> +		return PTR_ERR(pwm->regs);
> +
> +	ret =3D of_property_read_u32(dev->of_node, "xlnx,count-width", &pwm->wi=
dth);
> +	if (ret) {
> +		dev_err(dev, "missing counter width\n");
> +		return -EINVAL;
> +	}

Would it make sense to error out on some values of pwm->width? Values
bigger than 32 don't make sense?

> +	pwm->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk), "missing clock\n");
> +
> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(dev, "clock enable failed\n");
> +		return ret;

You can use dev_err_probe here, too, for consistency.

> +	}
> +
> +	ret =3D xilinx_pwm_debug_create(pwm);
> +	if (ret) {
> +		clk_disable_unprepare(pwm->clk);
> +		return ret;
> +	}
> +
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret) {
> +		clk_disable_unprepare(pwm->clk);

Error message please.

> +		return ret;
> +	}
> +
> +	enabled =3D xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
> +					readl(pwm->regs + TCSR1));
> +	if (enabled)
> +		clk_rate_exclusive_get(pwm->clk);

This needs to happen before calling pwmchip_add(), doesn't it?

> +
> +	return ret;
> +}
> +
> +static int xilinx_pwm_remove(struct platform_device *pdev)
> +{
> +	struct xilinx_pwm_device *pwm =3D platform_get_drvdata(pdev);
> +	bool enabled =3D xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
> +					     readl(pwm->regs + TCSR1));
> +
> +	if (enabled)
> +		clk_rate_exclusive_put(pwm->clk);

This looks wrong. You should rely on the consumer that they disable the
PWM.

> +	clk_disable_unprepare(pwm->clk);

I assume this stops the PWM, so this must happen after calling
pwmchip_remove.

> +	return pwmchip_remove(&pwm->chip);

Note, pwmchip_remove always returns 0 and I plan to change it to return
void instead. So please don't check the return value here.

> +}
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2tukfphry7cqh47h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCRCv0ACgkQwfwUeK3K
7An3VAf/Wzk3WmQc8NaR58OhYiWQUN8HcfHxgbjdhwF6z3h8qAItSNu6ttKJtu5n
w+NHxEntVPGOmL3/7Yvq4LzWjhuBkvaPbIz7/PR3jGIwJIAmf9JmmhOt1ha0ZbN4
Sul4U9n2p4MlpGHlSkz5EFkFqJKGTQQvFNs8BoXNp1l8Q7hfWZiUa1lIEDHLzWZc
Ek0fHwB0yKiZrz0FOWbcsUm/AbAduv/+MuyxLwmvMS7PpzuA7PVRQAbcV2za/4B4
GG2lKwbO1N8kTBaAHgphz4TOV77dlOaf1NHzo6uq17W0Oa+DbjSE0a729Hr13Zk/
at0K2F5ejCXTrPEULBeEO917aFofwQ==
=A4Cp
-----END PGP SIGNATURE-----

--2tukfphry7cqh47h--
