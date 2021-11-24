Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72C45B5A3
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Nov 2021 08:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKXHkl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Nov 2021 02:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhKXHkl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Nov 2021 02:40:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBEC061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 23:37:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpmqM-0007SF-BC; Wed, 24 Nov 2021 08:37:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpmqK-000jR6-Sy; Wed, 24 Nov 2021 08:37:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpmqJ-0001K0-DI; Wed, 24 Nov 2021 08:37:23 +0100
Date:   Wed, 24 Nov 2021 08:37:20 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <20211124073720.3yf2lgylu4jrg7bh@pengutronix.de>
References: <20211123232536.3909773-1-sean.anderson@seco.com>
 <20211123232536.3909773-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="odxxjlskes4xlvb2"
Content-Disposition: inline
In-Reply-To: <20211123232536.3909773-2-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--odxxjlskes4xlvb2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Tue, Nov 23, 2021 at 06:25:36PM -0500, Sean Anderson wrote:
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
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
> Changes in v11:
> - Add comment about why we test for #pwm-cells
> - Clarify comment on generate out signal
> - Rename pwm variables to xilinx_pwm
> - Round like Uwe wants...
> - s/xilinx_timer/xilinx_pwm/ for non-common functions

I'm mostly happy with this driver now. Just a few minor comments below.

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

The pwm driver has a comment at the location where #pwm-cells is
checked. I suggest to add a matching comment here.

>  	if (initialized)
>  		return -EINVAL;
> =20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..cefbf00b4c7e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -640,4 +640,18 @@ config PWM_VT8500
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
> index 000000000000..b64735880c4c
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,318 @@
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
> +	return DIV64_U64_ROUND_UP(cycles * NSEC_PER_SEC,
> +				  clk_get_rate(priv->clk));
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

s/duty cycle/period/

> +	 */
> +	rate =3D clk_get_rate(priv->clk);
> +	/* Avoid overflow */
> +	period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
> +	period_cycles =3D mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
> +	/* Clamp it for Uwe */

Hmm, not sure this comment is understandable in the long term.

> +	period_cycles =3D min_t(u64, period_cycles, priv->max + 2);
> +	if (period_cycles < 2)
> +		return -ERANGE;
> +
> +	/* Same thing for duty cycles */

s/duty cycles/duty cycle/, also for the variable name.

> +	duty_cycles =3D min_t(u64, state->duty_cycle, ULONG_MAX * NSEC_PER_SEC);
> +	duty_cycles =3D mul_u64_u32_div(duty_cycles, rate, NSEC_PER_SEC);
> +	duty_cycles =3D min_t(u64, duty_cycles, priv->max + 2);

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--odxxjlskes4xlvb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGd660ACgkQwfwUeK3K
7Akl7wf/Th1MUFQUv2GSuV8xTsg0uEwRdKNegQzZA1sI8BRbOM4kW/JUd75VmyuY
/eKl7iGkIGXWnzu2pPEo/Utt5jQlDpiykTp9dVZ0t0TyvULTzU16x2G++1JsvyA7
EzkszRSQ/ZXhhxuG6Mk73uCpuOpnLfimPu/MIDUJh1EeF08mzCcT8ES9AFm/iFIj
5yWCFT7wggKMGQRHEtE37PKQ2PI4saQ2njWv2xIGAk8AxYMN/3vfRWSzpMO3Mu1B
vStxABnYFOiBu6bJiJD5DQMRip1f/vqnyGMigpmg/GgxLVqt7ixtrY5rFF75lubR
XtPMkQEdLRcBYt0jICe9JpgFa7lsQQ==
=Trt1
-----END PGP SIGNATURE-----

--odxxjlskes4xlvb2--
