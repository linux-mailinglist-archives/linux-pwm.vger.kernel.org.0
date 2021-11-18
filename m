Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679DB4557FC
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbhKRJb0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 04:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbhKRJbV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Nov 2021 04:31:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5447C061764
        for <linux-pwm@vger.kernel.org>; Thu, 18 Nov 2021 01:28:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mndiM-0001O8-9G; Thu, 18 Nov 2021 10:28:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mndiL-000ORy-HR; Thu, 18 Nov 2021 10:28:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mndiK-0008Lu-57; Thu, 18 Nov 2021 10:28:16 +0100
Date:   Thu, 18 Nov 2021 10:28:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com
Subject: Re: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20211118092813.xhulsyy5l36ukngw@pengutronix.de>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <20211112185504.1921780-3-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrpl5d2o6c2j6cbf"
Content-Disposition: inline
In-Reply-To: <20211112185504.1921780-3-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nrpl5d2o6c2j6cbf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 12, 2021 at 01:55:04PM -0500, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
>=20
> Some common code has been specially demarcated. While currently only
> used by the PWM driver, it is anticipated that it may be split off in
> the future to be used by the timer driver as well.
>=20
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>=20
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_tim=
er/v1_03_a/axi_timer_ds764.pdf
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>=20
> Changes in v10:
> - Fix compilation error in timer driver
>=20
> Changes in v9:
> - Refactor "if { return } else if { }" to "if { return } if { }"
> - Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
> - Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe
>=20
> Changes in v8:
> - Drop new timer driver; it has been deferred for future series
>=20
> Changes in v7:
> - Add dependency on OF_ADDRESS
> - Fix period_cycles calculation
> - Fix typo in limitations
>=20
> Changes in v6:
> - Capitalize error messages
> - Don't disable regmap locking to allow inspection of registers via
>   debugfs
> - Prevent overflow when calculating period_cycles
> - Remove enabled variable from xilinx_pwm_apply
> - Swap order of period_cycle range comparisons
>=20
> Changes in v5:
> - Allow non-zero #pwm-cells
> - Correctly set duty_cycle in get_state when TLR0=3DTLR1
> - Elaborate on limitation section
> - Perform some additional checks/rounding in apply_state
> - Remove xlnx,axi-timer-2.0 compatible string
> - Rework duty-cycle and period calculations with feedback from Uwe
> - Switch to regmap to abstract endianness issues
> - Use more verbose error messages
>=20
> Changes in v4:
> - Don't use volatile in read/write replacements. Some arches have it and
>   some don't.
> - Put common timer properties into their own struct to better reuse
>   code.
> - Remove references to properties which are not good enough for Linux.
>=20
> Changes in v3:
> - Add clockevent and clocksource support
> - Remove old microblaze driver
> - Rewrite probe to only use a device_node, since timers may need to be
>   initialized before we have proper devices. This does bloat the code a b=
it
>   since we can no longer rely on helpers such as dev_err_probe. We also
>   cannot rely on device resources being free'd on failure, so we must free
>   them manually.
> - We now access registers through xilinx_timer_(read|write). This allows =
us
>   to deal with endianness issues, as originally seen in the microblaze
>   driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>=20
> Changes in v2:
> - Add comment describing device
> - Add comment explaining why we depend on !MICROBLAZE
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Check range of xlnx,count-width
> - Don't compile this module by default for arm64
> - Don't set pwmchip.base to -1
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Report errors with dev_error_probe
> - Set xilinx_pwm_ops.owner
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>=20
>  MAINTAINERS                        |   6 +
>  arch/microblaze/kernel/timer.c     |   3 +
>  drivers/pwm/Kconfig                |  14 ++
>  drivers/pwm/Makefile               |   1 +
>  drivers/pwm/pwm-xilinx.c           | 311 +++++++++++++++++++++++++++++
>  include/clocksource/timer-xilinx.h |  91 +++++++++
>  6 files changed, 426 insertions(+)
>  create mode 100644 drivers/pwm/pwm-xilinx.c
>  create mode 100644 include/clocksource/timer-xilinx.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd441dde..6f0f57c041c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20614,6 +20614,12 @@ F:	drivers/misc/Makefile
>  F:	drivers/misc/xilinx_sdfec.c
>  F:	include/uapi/misc/xilinx_sdfec.h
> =20
> +XILINX PWM DRIVER
> +M:	Sean Anderson <sean.anderson@seco.com>
> +S:	Maintained
> +F:	drivers/pwm/pwm-xilinx.c
> +F:	include/clocksource/timer-xilinx.h
> +
>  XILINX UARTLITE SERIAL DRIVER
>  M:	Peter Korsgaard <jacmet@sunsite.dk>
>  L:	linux-serial@vger.kernel.org
> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/time=
r.c
> index f8832cf49384..dea34a3d4aa4 100644
> --- a/arch/microblaze/kernel/timer.c
> +++ b/arch/microblaze/kernel/timer.c
> @@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_nod=
e *timer)
>  	u32 timer_num =3D 1;
>  	int ret;
> =20
> +	if (of_property_read_bool(timer, "#pwm-cells"))
> +		return 0;
> +
>  	if (initialized)
>  		return -EINVAL;
> =20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index aa29841bbb79..47f25237754f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -638,4 +638,18 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
> =20
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
> +	depends on OF_ADDRESS
> +	depends on COMMON_CLK
> +	select REGMAP_MMIO
> +	help
> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
> +	  typically a soft core which may be present in Xilinx FPGAs.
> +	  This device may also be present in Microblaze soft processors.
> +	  If you don't have this IP in your design, choose N.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-xilinx.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..ea785480359b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..d79ef202d62f
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we may end up with one cy=
cle
> + *   with the old duty cycle and the new period. This is because the cou=
nters
> + *   may only be reloaded by first stopping them, or by letting them be
> + *   automatically reloaded at the end of a cycle. If this automatic rel=
oad
> + *   happens after we set TLR0 but before we set TLR1 then we will have a
> + *   bad cycle. This could probably be fixed by reading TCR0 just before
> + *   reprogramming, but I think it would add complexity for little gain.
> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might =
be
> + *   possible by stopping the counters at an appropriate point in the cy=
cle,
> + *   but this is not (yet) implemented.
> + * - Only produces "normal" output.
> + * - Always produces low output if disabled.
> + */
> +
> +#include <clocksource/timer-xilinx.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * The following functions are "common" to drivers for this device, and =
may be
> + * exported at a future date.
> + */
> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
> +			    u64 cycles)
> +{
> +	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
> +
> +	if (tcsr & TCSR_UDT)
> +		return cycles - 2;
> +	return priv->max - cycles + 2;
> +}
> +
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr)
> +{
> +	u64 cycles;
> +
> +	if (tcsr & TCSR_UDT)
> +		cycles =3D tlr + 2;
> +	else
> +		cycles =3D (u64)priv->max - tlr + 2;
> +
> +	/* cycles has a max of 2^32 + 2 */
> +	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
> +				       clk_get_rate(priv->clk));

Please round up here.

> +}
> +
> +/*
> + * The idea here is to capture whether the PWM is actually running (e.g.
> + * because we or the bootloader set it up) and we need to be careful to =
ensure
> + * we don't cause a glitch. According to the data sheet, to enable the P=
WM we
> + * need to
> + *
> + * - Set both timers to generate mode (MDT=3D1)
> + * - Set both timers to PWM mode (PWMA=3D1)
> + * - Enable the generate out signals (GENT=3D1)
> + *
> + * In addition,
> + *
> + * - The timer must be running (ENT=3D1)
> + * - The timer must auto-reload TLR into TCR (ARHT=3D1)
> + * - We must not be in the process of loading TLR into TCR (LOAD=3D0)
> + * - Cascade mode must be disabled (CASC=3D0)
> + *
> + * If any of these differ from usual, then the PWM is either disabled, o=
r is
> + * running in a mode that this driver does not support.
> + */
> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
> +
> +struct xilinx_pwm_device {
> +	struct pwm_chip chip;
> +	struct xilinx_timer_priv priv;
> +};
> +
> +static inline struct xilinx_timer_priv
> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
> +{
> +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
> +}
> +
> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
> +{
> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) =3D=3D TCSR_PWM_SET &&
> +		(TCSR_PWM_MASK & tcsr1) =3D=3D TCSR_PWM_SET;
> +}
> +
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *un=
used,
> +			    const struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +	u64 period_cycles, duty_cycles;
> +	unsigned long rate;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/*
> +	 * To be representable by TLR, cycles must be between 2 and
> +	 * priv->max + 2. To enforce this we can reduce the duty
> +	 * cycle, but we may not increase it.
> +	 */
> +	rate =3D clk_get_rate(priv->clk);
> +	/* Prevent overflow by clamping to the worst case of rate */

I wouldn't have called this "worst case of rate", maybe better use
"maximal rate"?

> +	period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
> +	period_cycles =3D mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
> +	if (period_cycles < 2 || period_cycles - 2 > priv->max)
> +		return -ERANGE;

if period_cycles - 2 > priv->max the right reaction is to do

	period_cycles =3D priv->max + 2

=2E

> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);

duty_cycle needs sanitation in case period was reduced and duty_cycle is
bigger now than period.

> +	/*
> +	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
> +	 * the duty cycle count by one.
> +	 */
> +	if (period_cycles =3D=3D duty_cycles)
> +		duty_cycles--;
> +
> +	/* Round down to 0% duty cycle for unrepresentable duty cycles */
> +	if (duty_cycles < 2)
> +		duty_cycles =3D period_cycles;
> +
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	tlr0 =3D xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
> +	tlr1 =3D xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
> +	regmap_write(priv->map, TLR0, tlr0);
> +	regmap_write(priv->map, TLR1, tlr1);
> +
> +	if (state->enabled) {
> +		/*
> +		 * If the PWM is already running, then the counters will be
> +		 * reloaded at the end of the current cycle.
> +		 */
> +		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
> +			/* Load TLR into TCR */
> +			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
> +			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 =3D (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 =3D TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			regmap_write(priv->map, TCSR0, tcsr0);
> +			regmap_write(priv->map, TCSR1, tcsr1);
> +		}
> +	} else {
> +		regmap_write(priv->map, TCSR0, 0);
> +		regmap_write(priv->map, TCSR1, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *unused,
> +				 struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> +	regmap_read(priv->map, TLR0, &tlr0);
> +	regmap_read(priv->map, TLR1, &tlr1);
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	state->period =3D xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle =3D xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	/* 100% duty cycle results in constant low output */
> +	if (state->period =3D=3D state->duty_cycle)
> +		state->duty_cycle =3D 0;
> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops =3D {
> +	.apply =3D xilinx_pwm_apply,
> +	.get_state =3D xilinx_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct regmap_config xilinx_pwm_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.max_register =3D TCR1,
> +};
> +
> +static int xilinx_timer_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct xilinx_timer_priv *priv;
> +	struct xilinx_pwm_device *pwm;

The name "pwm" is usually reserved for struct pwm_device pointers. A
typical name for this would be xlnxpwm or ddata.

> +	u32 pwm_cells, one_timer, width;
> +	void __iomem *regs;
> +
> +	ret =3D of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> +	if (ret =3D=3D -EINVAL)
> +		return -ENODEV;

A comment about why this is done would be great.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, pwm);
> +	priv =3D &pwm->priv;
> +
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	priv->map =3D devm_regmap_init_mmio(dev, regs,
> +					  &xilinx_pwm_regmap_config);
> +	if (IS_ERR(priv->map))
> +		return dev_err_probe(dev, PTR_ERR(priv->map),
> +				     "Could not create regmap\n");
> +
> +	ret =3D of_property_read_u32(np, "xlnx,one-timer-only", &one_timer);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not read xlnx,one-timer-only\n");
> +
> +	if (one_timer)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Two timers required for PWM mode\n");
> +
> +
> +	ret =3D of_property_read_u32(np, "xlnx,count-width", &width);
> +	if (ret =3D=3D -EINVAL)
> +		width =3D 32;
> +	else if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not read xlnx,count-width\n");
> +
> +	if (width !=3D 8 && width !=3D 16 && width !=3D 32)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid counter width %d\n", width);
> +	priv->max =3D BIT_ULL(width) - 1;
> +
> +	/*
> +	 * The polarity of the generate outputs must be active high for PWM

s/generate/generated/

> +	 * mode to work. We could determine this from the device tree, but
> +	 * alas, such properties are not allowed to be used.
> +	 */
> +
> +	priv->clk =3D devm_clk_get(dev, "s_axi_aclk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Could not get clock\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	pwm->chip.dev =3D dev;
> +	pwm->chip.ops =3D &xilinx_pwm_ops;
> +	pwm->chip.npwm =3D 1;
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int xilinx_timer_remove(struct platform_device *pdev)
> +{
> +	struct xilinx_pwm_device *pwm =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&pwm->chip);
> +	clk_rate_exclusive_put(pwm->priv.clk);
> +	clk_disable_unprepare(pwm->priv.clk);
> +	return 0;
> +}
> +
> +static const struct of_device_id xilinx_timer_of_match[] =3D {
> +	{ .compatible =3D "xlnx,xps-timer-1.00.a", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
> +
> +static struct platform_driver xilinx_timer_driver =3D {
> +	.probe =3D xilinx_timer_probe,
> +	.remove =3D xilinx_timer_remove,
> +	.driver =3D {
> +		.name =3D "xilinx-timer",

Doesn't this give a wrong impression as this is a PWM driver, not a
timer driver?

> +		.of_match_table =3D of_match_ptr(xilinx_timer_of_match),
> +	},
> +};
> +module_platform_driver(xilinx_timer_driver);
> +
> +MODULE_ALIAS("platform:xilinx-timer");
> +MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/tim=
er-xilinx.h
> new file mode 100644
> index 000000000000..1f7757b84a5e
> --- /dev/null
> +++ b/include/clocksource/timer-xilinx.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + */
> +
> +#ifndef XILINX_TIMER_H
> +#define XILINX_TIMER_H
> +
> +#include <linux/compiler.h>
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
> +
> +struct clk;
> +struct device_node;
> +struct regmap;
> +
> +/**
> + * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
> + * @map: Regmap of the device, possibly with an offset
> + * @clk: Parent clock
> + * @max: Maximum value of the counters
> + */
> +struct xilinx_timer_priv {
> +	struct regmap *map;
> +	struct clk *clk;
> +	u32 max;
> +};
> +
> +/**
> + * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
> + *                             in clock cycles
> + * @priv: The timer's private data
> + * @tcsr: The value of the TCSR register for this counter
> + * @cycles: The number of cycles in this period
> + *
> + * Callers of this function MUST ensure that @cycles is representable as
> + * a TLR.
> + *
> + * Return: The calculated value for TLR
> + */
> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
> +			    u64 cycles);
> +
> +/**
> + * xilinx_timer_get_period() - Get the current period of a counter
> + * @priv: The timer's private data
> + * @tlr: The value of TLR for this counter
> + * @tcsr: The value of TCSR for this counter
> + *
> + * Return: The period, in ns
> + */
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr);
> +
> +/**
> + * xilinx_timer_common_init() - Perform common initialization for Xilinx
> + *                              AXI timer drivers.
> + * @priv: The timer's private data
> + * @np: The devicetree node for the timer
> + * @one_timer: Set to %1 if there is only one timer
> + *
> + * This performs common initialization, such as detecting endianness,
> + * and parsing devicetree properties. @priv->regs must be initialized
> + * before calling this function. This function initializes @priv->read,
> + * @priv->write, and @priv->width.
> + *
> + * Return: 0, or negative errno
> + */
> +int xilinx_timer_common_init(struct device_node *np,
> +			     struct xilinx_timer_priv *priv,
> +			     u32 *one_timer);
> +
> +#endif /* XILINX_TIMER_H */
> --=20
> 2.25.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nrpl5d2o6c2j6cbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGWHKoACgkQwfwUeK3K
7AkdxQf5AUlhnETYhwqub7paQyrhTm01WU4L/7qv91GF1H8cbMYH5z9dOhM7OI8t
lIKpJWhnGYjuYjiYjEo4AlvKDRPXrrdG+MhckpmjDrRRw9tgc/MXX3urbRy+8doI
1m79OqYANLGyiNM0Fx5uHCnPat6Q3ochuynK7oAV7OWXGtAs3ylt72AE1G/cBMzV
BLY6utQnmZ2b5TjP9rfG5pVAC1zC6e3Ndzclrqx0HR2N8OERw4PWsHLNeElqRhrL
OgXZ5RxcT7fgPQP36ZldO+dyXmxRvgz5zCN2Sd/vKPN/Rwt934jihaSa87HDzcoy
GzEUWxqN+xHfR2LqsdGCExumgH3U4A==
=aPLb
-----END PGP SIGNATURE-----

--nrpl5d2o6c2j6cbf--
