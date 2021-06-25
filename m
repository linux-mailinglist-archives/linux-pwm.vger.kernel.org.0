Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498943B3C97
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 08:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFYGWX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 02:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhFYGWX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 02:22:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEFAC061574
        for <linux-pwm@vger.kernel.org>; Thu, 24 Jun 2021 23:20:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwfC4-0003Rw-82; Fri, 25 Jun 2021 08:20:00 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwfC2-0006p8-G6; Fri, 25 Jun 2021 08:19:58 +0200
Date:   Fri, 25 Jun 2021 08:19:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rbhfpghprvkbfljx"
Content-Disposition: inline
In-Reply-To: <20210528214522.617435-3-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rbhfpghprvkbfljx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2021 at 05:45:22PM -0400, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs.  At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
>=20
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>=20
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_tim=
er/v1_03_a/axi_timer_ds764.pdf
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>=20
> Changes in v4:
> - Remove references to properties which are not good enough for Linux.
> - Don't use volatile in read/write replacements. Some arches have it and
>   some don't.
> - Put common timer properties into their own struct to better reuse
>   code.
>=20
> Changes in v3:
> - Add clockevent and clocksource support
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
> - Remove old microblaze driver
>=20
> Changes in v2:
> - Don't compile this module by default for arm64
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Add comment explaining why we depend on !MICROBLAZE
> - Add comment describing device
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Set xilinx_pwm_ops.owner
> - Don't set pwmchip.base to -1
> - Check range of xlnx,count-width
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Report errors with dev_error_probe
>=20
>  drivers/mfd/Makefile     |   2 +-
>  drivers/pwm/Kconfig      |  12 +++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-xilinx.c | 219 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 233 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-xilinx.c
>=20
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f0f9fbdde7dc..89769affe251 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -269,6 +269,6 @@ obj-$(CONFIG_SGI_MFD_IOC3)	+=3D ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+=3D simple-mfd-i2c.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> =20
> -ifneq ($(CONFIG_XILINX_TIMER),)
> +ifneq ($(CONFIG_PWM_XILINX)$(CONFIG_XILINX_TIMER),)
>  obj-y				+=3D xilinx-timer.o
>  endif
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8ae68d6203fb..ebf8d9014758 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -620,4 +620,16 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
> =20
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
> +	depends on HAS_IOMEM && COMMON_CLK
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
> index d43b1e17e8e1..655df169b895 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+=3D pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..f05321496717
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * Hardware limitations:
> + * - When changing both duty cycle and period, we may end up with one cy=
cle
> + *   with the old duty cycle and the new period.

That means it doesn't reset the counter when a new period is set, right?

> + * - Cannot produce 100% duty cycle.

Can it produce a 0% duty cycle? Below you're calling
xilinx_timer_tlr_period(..., ..., ..., 0) then which returns -ERANGE.

> + * - Only produces "normal" output.

Does the output emit a low level when it's disabled?

> + */
> +
> [...]
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *un=
used,
> +			    const struct pwm_state *state)
> +{
> +	int ret;
> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1;
> +	u32 tcsr0 =3D xilinx_timer_read(priv, TCSR0);
> +	u32 tcsr1 =3D xilinx_timer_read(priv, TCSR1);
> +	bool enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	ret =3D xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
> +	if (ret)
> +		return ret;

The implementation of xilinx_timer_tlr_period (in patch 2/3) returns
-ERANGE for big periods. The good behaviour to implement is to cap to
the biggest period possible in this case.

Also note that state->period is an u64 but it is casted to unsigned int
as this is the type of the forth parameter of xilinx_timer_tlr_period.

> +	ret =3D xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
> +	if (ret)
> +		return ret;
> +
> +	xilinx_timer_write(priv, tlr0, TLR0);
> +	xilinx_timer_write(priv, tlr1, TLR1);
> +
> +	if (state->enabled) {
> +		/* Only touch the TCSRs if we aren't already running */
> +		if (!enabled) {
> +			/* Load TLR into TCR */
> +			xilinx_timer_write(priv, tcsr0 | TCSR_LOAD, TCSR0);
> +			xilinx_timer_write(priv, tcsr1 | TCSR_LOAD, TCSR1);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 =3D (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 =3D TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			xilinx_timer_write(priv, tcsr0, TCSR0);
> +			xilinx_timer_write(priv, tcsr1, TCSR1);
> +		}
> +	} else {
> +		xilinx_timer_write(priv, 0, TCSR0);
> +		xilinx_timer_write(priv, 0, TCSR1);
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
> +	u32 tlr0 =3D xilinx_timer_read(priv, TLR0);
> +	u32 tlr1 =3D xilinx_timer_read(priv, TLR1);
> +	u32 tcsr0 =3D xilinx_timer_read(priv, TCSR0);
> +	u32 tcsr1 =3D xilinx_timer_read(priv, TCSR1);
> +
> +	state->period =3D xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle =3D xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity =3D PWM_POLARITY_NORMAL;

Are the values returned here sensible if the hardware isn't in PWM mode?

> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops =3D {
> +	.apply =3D xilinx_pwm_apply,
> +	.get_state =3D xilinx_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int xilinx_timer_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct xilinx_timer_priv *priv;
> +	struct xilinx_pwm_device *pwm;
> +	u32 pwm_cells, one_timer;
> +
> +	ret =3D of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> +	if (ret =3D=3D -EINVAL)
> +		return -ENODEV;
> +	else if (ret)
> +		return dev_err_probe(dev, ret, "#pwm-cells\n");

Very sparse error message.

> +	else if (pwm_cells)
> +		return dev_err_probe(dev, -EINVAL, "#pwm-cells must be 0\n");

What is the rationale here to not support #pwm-cells =3D <2>?

> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, pwm);
> +	priv =3D &pwm->priv;
> +
> +	priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->regs))
> +		return PTR_ERR(priv->regs);
> +
> +	ret =3D xilinx_timer_common_init(np, priv, &one_timer);
> +	if (ret)
> +		return ret;
> +
> +	if (one_timer)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "two timers required for PWM mode\n");
> +
> +	/*
> +	 * The polarity of the generate outputs must be active high for PWM
> +	 * mode to work. We could determine this from the device tree, but
> +	 * alas, such properties are not allowed to be used.
> +	 */
> +
> +	priv->clk =3D devm_clk_get(dev, "s_axi_aclk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "clock\n");

again a sparse error message.

> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "clock enable failed\n");
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	pwm->chip.dev =3D dev;
> +	pwm->chip.ops =3D &xilinx_pwm_ops;
> +	pwm->chip.npwm =3D 1;
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "could not register pwm chip\n");
> +	}
> +
> +	return 0;
> +}

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rbhfpghprvkbfljx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDVdYsACgkQwfwUeK3K
7AlWnQf3ZlYhJXorv5Nb4kpOg34gLmAxusT52V/nYhh5hTJlJU4NRw0MDHDnfSYR
K7fMFY0U9GqtJ8YWqtW1lg1DlUDEsAhBuMSrMuj5SLV6I6nqM3/h6GH5T5bspELy
q98lsHV76nTpiN1LN4Jglqr7W0PFehk6M7WYKDxmrgAPKgsDemfdyLJ4rinmoCaF
hH/QnRDpVhKK8tV9PLtQ5U4GgJ1B6Y7erfMVFiaWL8DWpkNrnnYtgxyKSWn9oUti
ZGGfjakJBYcaAMV7w1s7Ak2Q6ItInEOobbIvJ+UJsllSm59Pg0AZI679i1uzqcdl
lfrBE3XAPIIjKHkhcZL2vZS9qto2
=eqoZ
-----END PGP SIGNATURE-----

--rbhfpghprvkbfljx--
