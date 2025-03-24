Return-Path: <linux-pwm+bounces-5267-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0E2A6D924
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9780A16CBC6
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685B25D916;
	Mon, 24 Mar 2025 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0PGIVrm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2275200CB;
	Mon, 24 Mar 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815784; cv=none; b=RcTVFX8eT0Rvnw63GGjQyOputeRgil3Da+t4xeu9Ic8/7IzBJDOi+SlPFhSSvNNVAfbbyV7d9dpvA944jYoO43CIJOFKtWqop933ESNwW+oV06ioXDP0Fts9798EVq451fCvfUU6fLPnH3yN63Hlj16xkPizRvSrgBtym0Gbpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815784; c=relaxed/simple;
	bh=pXSvmnsfZeH4qdTVDB5E1EkPKoYDMFI/4KEb9PoMPyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0vn3WX/wuEocE6YkSUmfTvfewanwP4mPBHysljLbxXfWqpsK1YwUW//qnD+QLmYXQq50XilB/iGJWnEwMKZJH+9e1KuCO6CNZrZeeqid1bzk0m9yTWuP0LUYy5tUJ3bx53BJw2LIT1jzV5HWOPXK922VVuJiv5z+EAzBpazYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0PGIVrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E013DC4CEDD;
	Mon, 24 Mar 2025 11:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742815784;
	bh=pXSvmnsfZeH4qdTVDB5E1EkPKoYDMFI/4KEb9PoMPyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0PGIVrmXfb7lXBQKALfoGDmI27aOH8kOr1n42IujOWPMYIW3ToMzL/T2lyAC7sMJ
	 7wuaqNJNtkai/kx/bv48MIxyGfaqCxsHGqUXz0Lt5TkW5cgrshCHlKGEgrSE0M+odQ
	 tZamLUcVVySwdFoISg2SHuuIJnu/IxQejEYhoFuIxrxqb8NAnKX3jGXCCdk9UO3rIT
	 e2coU/MvDTF1Akn6gTFhFvB88MVPZ+3KEU2MjZiLf0A7eZPSISasivNz7SAVOk72a9
	 JDqoIq0bvVc0rGa+al4JBhd62RRw7yejG2noGxtCBfGbT/XdS5SaOmrg9M3N8tfnx8
	 oj2OBQffZlfgA==
Date: Mon, 24 Mar 2025 12:29:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mubin Sayyed <mubin.sayyed@amd.com>
Cc: krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org, 
	tglx@linutronix.de, michal.simek@amd.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v4 3/3] pwm: pwm-cadence: Add support for TTC PWM
Message-ID: <nwdxbyynffy7kkxdznxrogzqg2r5bje45ywgxa6jj7mcix65ze@dtabj46eut5i>
References: <20250115113556.2832282-1-mubin.sayyed@amd.com>
 <20250115113556.2832282-4-mubin.sayyed@amd.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qalzlpcxz2i65esg"
Content-Disposition: inline
In-Reply-To: <20250115113556.2832282-4-mubin.sayyed@amd.com>


--qalzlpcxz2i65esg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] pwm: pwm-cadence: Add support for TTC PWM
MIME-Version: 1.0

Hello,

On Wed, Jan 15, 2025 at 05:05:56PM +0530, Mubin Sayyed wrote:
> Cadence TTC timer can be configured as clocksource/clockevent or PWM
> device.Specific TTC device would be configured as PWM device, if
> pwm-cells property is present in the device tree node.
>=20
> In case of Zynq, ZynqMP and Versal SoC's, each TTC device has 3
> timers/counters, so maximum 3 PWM channels can be configured for each TTC
> IP instance. Also, output of 0th PWM channel of each TTC device can be
> routed to MIO or EMIO, and output of 2nd and 3rd PWM channel can be
> routed only to EMIO.
>=20
> Period for given PWM channel is configured through interval timer and
> duty cycle through match counter.
>=20
> Details for cadence TTC IP can be found in Zynq UltraScale+ TRM.
>=20
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> ---
> Refer link given below for Zynq UltraScale+ TRM
> https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm

I would prefer to have a link to the TRM in the source file. When I
follow that link today however I only get "The document you are looking
for has been moved or deleted" :-\

> Changes for v4:
>  Configure it as part of TTC clocksource/clockevent driver
>  drivers/clocksource/timer-cadence-ttc.c.
>  Move probe/remove function to timer-cadence-ttc.c.
> Changes for v3:
>  None
> Changes for v2:
>  Use maybe_unused attribute for ttc_pwm_of_match_driver structure
>  Add new function ttc_pwm_set_polarity
>  Removed calls to pwm_get_state
>  Replace DIV_ROUNF_CLOSEST with mul_u64_u64_div_u64
>  Modify ttc_pwm_apply to remove while loop in prescalar logic
>  and avoid glitch
>  Calculate rate in probe and add it to private structure for further
>  Drop ttc_pwm_of_xlate
>  Replace of_clk_get with devm_clk_get_enabled
>  Drop _OFFSET and _MASK from definitions
>  Keep Kconfig and Makefile changes alphabetically sorted
>  Use remove_new instead of remove
>  Document limitations in driver file
> ---
>  drivers/pwm/Kconfig               |  10 +
>  drivers/pwm/Makefile              |   1 +
>  drivers/pwm/pwm-cadence.c         | 323 ++++++++++++++++++++++++++++++
>  include/linux/timer-cadence-ttc.h |  22 +-
>  4 files changed, 355 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-cadence.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..b418e5d8fa42 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -202,6 +202,16 @@ config PWM_CROS_EC
>  	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>  	  Controller.
> =20
> +config PWM_CADENCE
> +	bool "Cadence TTC PWM driver"

tristate please

> +	depends on CADENCE_TTC_TIMER
> +	help
> +	  Generic PWM framework driver for cadence TTC IP found on
> +          Xilinx Zynq/ZynqMP/Versal SOCs. Each TTC device has 3 PWM
> +          channels. Output of 0th PWM channel of each TTC device can
> +          be routed to MIO or EMIO, and output of 1st and 2nd PWM
> +          channels can be routed only to EMIO.
> +
>  config PWM_DWC_CORE
>  	tristate
>  	depends on HAS_IOMEM
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..246380391a63 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
>  obj-$(CONFIG_PWM_BRCMSTB)	+=3D pwm-brcmstb.o
> +obj-$(CONFIG_PWM_CADENCE)	+=3D pwm-cadence.o
>  obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
> diff --git a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c
> new file mode 100644
> index 000000000000..e7c337fe956b
> --- /dev/null
> +++ b/drivers/pwm/pwm-cadence.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver to configure cadence TTC timer as PWM
> + * generator
> + *
> + * Limitations:
> + * - When PWM is stopped, timer counter gets stopped immediately. This
> + *   doesn't allow the current PWM period to complete and stops abruptly.
> + * - Disabled PWM emits inactive level.
> + * - When user requests a change in  any parameter of PWM (period/duty c=
ycle/polarity)

s/  / /

> + *   while PWM is in enabled state:
> + *	- PWM is stopped abruptly.
> + *	- Requested parameter is changed.
> + *	- Fresh PWM cycle is started.
> + *
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>

I didn't check, but <linux/device.h> is unusual. Do you really need it?

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/of_address.h>

Also I think this can be dropped.

> +#include <linux/timer-cadence-ttc.h>
> +
> +/**
> + * struct ttc_pwm_priv - Private data for TTC PWM drivers
> + * @chip:	PWM chip structure representing PWM controller
> + * @clk:	TTC input clock
> + * @rate:	TTC input clock rate
> + * @max:	Maximum value of the counters
> + * @base:	Base address of TTC instance
> + */
> +struct ttc_pwm_priv {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	unsigned long rate;
> +	u32 max;
> +	void __iomem *base;
> +};
> +
> +static inline u32 ttc_pwm_readl(struct ttc_pwm_priv *priv,
> +				unsigned long offset)
> +{
> +	return readl_relaxed(priv->base + offset);
> +}
> +
> +static inline void ttc_pwm_writel(struct ttc_pwm_priv *priv,
> +				  unsigned long offset,
> +				  unsigned long val)
> +{
> +	writel_relaxed(val, priv->base + offset);
> +}
> +
> +static inline u32 ttc_pwm_ch_readl(struct ttc_pwm_priv *priv,
> +				   unsigned int chnum,
> +				   unsigned long offset)
> +{
> +	unsigned long pwm_ch_offset =3D offset +
> +				       (TTC_PWM_CHANNEL * chnum);
> +
> +	return ttc_pwm_readl(priv, pwm_ch_offset);
> +}
> +
> +static inline void ttc_pwm_ch_writel(struct ttc_pwm_priv *priv,
> +				     unsigned int chnum,
> +				     unsigned long offset,
> +				     unsigned long val)
> +{
> +	unsigned long pwm_ch_offset =3D offset +
> +				       (TTC_PWM_CHANNEL * chnum);
> +
> +	ttc_pwm_writel(priv, pwm_ch_offset, val);
> +}
> +
> +static inline struct ttc_pwm_priv *xilinx_pwm_chip_to_priv(struct pwm_ch=
ip *chip)

Can you please stick to a single unique function prefix? The involved
prefixes here are ttc_pwm, xilinx_pwm and the driver is called
"cadence". Unifying them all to a single name would be good.

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static void ttc_pwm_enable(struct ttc_pwm_priv *priv, struct pwm_device =
*pwm)
> +{
> +	u32 ctrl_reg;
> +
> +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
> +	ctrl_reg |=3D (TTC_CNTR_CTRL_INTR_MODE_EN
> +				 | TTC_CNTR_CTRL_MATCH_MODE_EN | TTC_CNTR_CTRL_RST);
> +	ctrl_reg &=3D ~(TTC_CNTR_CTRL_DIS | TTC_CNTR_CTRL_WAVE_EN);
> +	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
> +}
> +
> +static void ttc_pwm_disable(struct ttc_pwm_priv *priv, struct pwm_device=
 *pwm)

This function only needs .hwpwm from *pwm. Maybe pass hwpwm as parameter
instead of pwm?

> +{
> +	u32 ctrl_reg;
> +
> +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
> +	ctrl_reg |=3D TTC_CNTR_CTRL_DIS;
> +
> +	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
> +}
> +
> +static void ttc_pwm_set_polarity(struct ttc_pwm_priv *priv, struct pwm_d=
evice *pwm,
> +				 enum pwm_polarity polarity)
> +{
> +	u32 ctrl_reg;
> +
> +	ctrl_reg =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
> +
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		ctrl_reg |=3D TTC_CNTR_CTRL_WAVE_POL;
> +	else
> +		ctrl_reg &=3D (~TTC_CNTR_CTRL_WAVE_POL);

The parenthesis can be dropped.

> +
> +	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
> +}
> +
> +static void ttc_pwm_set_counters(struct ttc_pwm_priv *priv,
> +				 struct pwm_device *pwm,
> +				 u32 period_cycles,
> +				 u32 duty_cycles)
> +{
> +	/* Set up period */
> +	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_INTR_VAL_OFFSET, period_cycles);
> +
> +	/* Set up duty cycle */
> +	ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_MATCH_CNT_VAL_OFFSET, duty_cycl=
es);
> +}
> +
> +static void ttc_pwm_set_prescalar(struct ttc_pwm_priv *priv,
> +				  struct pwm_device *pwm,
> +				  u32 div, bool is_enable)
> +{
> +	u32 clk_reg;
> +
> +	if (is_enable) {
> +		/* Set up prescalar */
> +		clk_reg =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET);
> +		clk_reg &=3D ~TTC_CLK_CNTRL_PSV_MASK;
> +		clk_reg |=3D (div << TTC_CNTR_CTRL_PRESCALE_SHIFT);
> +		clk_reg |=3D TTC_CLK_CNTRL_PS_EN;
> +		ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET, clk_reg);
> +	} else {
> +		/* Disable prescalar */
> +		clk_reg =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET);
> +		clk_reg &=3D ~TTC_CLK_CNTRL_PS_EN;
> +		ttc_pwm_ch_writel(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET, clk_reg);
> +	}
> +}
> +
> +static int ttc_pwm_apply(struct pwm_chip *chip,
> +			 struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u64 duty_cycles, period_cycles;
> +	struct pwm_state cstate;
> +	unsigned long rate;
> +	bool flag =3D false;
> +	u32 div =3D 0;
> +
> +	cstate =3D pwm->state;

A pointer would be enough here. No need to copy the whole struct.

> +	if (state->polarity !=3D cstate.polarity) {
> +		if (cstate.enabled)
> +			ttc_pwm_disable(priv, pwm);
> +
> +		ttc_pwm_set_polarity(priv, pwm, state->polarity);
> +	}
> +
> +	rate =3D priv->rate;
> +
> +	/* Prevent overflow by limiting to the maximum possible period */
> +	period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);

ULONG_MAX * NSEC_PER_SEC overflows before it's casted to u64.

> +	period_cycles =3D mul_u64_u64_div_u64(period_cycles, rate, NSEC_PER_SEC=
);

mul_u64_u64_div_u64() doesn't overflow if rate <=3D NSEC_PER_SEC.

> +	if (period_cycles > priv->max) {
> +		/*
> +		 * Prescale frequency to fit requested period cycles within limit.
> +		 * Prescalar divides input clock by 2^(prescale_value + 1). Maximum
> +		 * supported prescalar value is 15.
> +		 */
> +		div =3D mul_u64_u64_div_u64(state->period, rate, (NSEC_PER_SEC * priv-=
>max));

No parenthesis needed around the 3rd parameter. Can NSEC_PER_SEC *
priv->max overflow? Is it intended that you use state->period here and
don't cap the value first as you did above?

> +		div =3D order_base_2(div);
> +		if (div)
> +			div -=3D 1;
> +
> +		if (div > 15)
> +			return -ERANGE;
> +
> +		rate =3D DIV_ROUND_CLOSEST(rate, BIT(div + 1));
> +		period_cycles =3D mul_u64_u64_div_u64(state->period, rate,
> +						    NSEC_PER_SEC);

Dividing twice decreases precision. Also rounding to closest looks
wrong. I think this should just be:

	period_cycles =3D mul_u64_u64_div_u64(state->period, rate, NSEC_PER_SEC * =
BIT(div + 1));

Wouldn't it be simpler to just use:

	dif =3D order_base_2(period_cycles / priv->max);

(modulo correctness)?

> +		flag =3D true;
> +	}
> +
> +	if (cstate.enabled)
> +		ttc_pwm_disable(priv, pwm);
> +
> +	duty_cycles =3D mul_u64_u64_div_u64(state->duty_cycle, rate,
> +					  NSEC_PER_SEC);
> +	ttc_pwm_set_counters(priv, pwm, period_cycles, duty_cycles);
> +
> +	ttc_pwm_set_prescalar(priv, pwm, div, flag);
> +
> +	if (state->enabled)
> +		ttc_pwm_enable(priv, pwm);
> +	else
> +		ttc_pwm_disable(priv, pwm);

The hardware is already disabled, so I'd expect that this
ttc_pwm_disable() can be dropped?

> +	return 0;
> +}
> +
> +static int ttc_pwm_get_state(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     struct pwm_state *state)
> +{
> +	struct ttc_pwm_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> +	u32 value, pres_en, pres =3D 1;
> +	unsigned long rate;
> +	u64 tmp;
> +
> +	value =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CNT_CNTRL_OFFSET);
> +
> +	if (value & TTC_CNTR_CTRL_WAVE_POL)
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +	else
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +
> +	if (value & TTC_CNTR_CTRL_DIS)
> +		state->enabled =3D false;

You can exit early here.

> +	else
> +		state->enabled =3D true;
> +
> +	rate =3D priv->rate;
> +
> +	pres_en =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET);
> +	pres_en	&=3D TTC_CLK_CNTRL_PS_EN;
> +
> +	if (pres_en) {
> +		pres =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_CLK_CNTRL_OFFSET)
> +					& TTC_CLK_CNTRL_PSV_MASK;
> +		pres >>=3D TTC_CNTR_CTRL_PRESCALE_SHIFT;

		pres =3D FIELD_GET(...)

> +		/* If prescale is enabled, the count rate is divided by 2^(pres + 1) */
> +		pres =3D BIT(pres + 1);
> +	}
> +
> +	tmp =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_INTR_VAL_OFFSET);
> +	tmp *=3D pres;

you can drop `pres =3D BIT(pres + 1);` above if you use

	tmp <<=3D pres + 1

here.

> +	state->period =3D DIV64_U64_ROUND_UP(tmp * NSEC_PER_SEC, rate);

Can this overflow?

> +	tmp =3D ttc_pwm_ch_readl(priv, pwm->hwpwm, TTC_MATCH_CNT_VAL_OFFSET);
> +	tmp *=3D pres;
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP(tmp * NSEC_PER_SEC, rate);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ttc_pwm_ops =3D {
> +	.apply =3D ttc_pwm_apply,
> +	.get_state =3D ttc_pwm_get_state,
> +};
> +
> +int ttc_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct ttc_pwm_priv *priv;
> +	struct pwm_chip *chip;
> +	u32 timer_width;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(np, "timer-width", &timer_width);
> +	if (ret)
> +		timer_width =3D 16;
> +
> +	chip =3D devm_pwmchip_alloc(dev, TTC_PWM_MAX_CH, sizeof(*priv));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	priv =3D xilinx_pwm_chip_to_priv(chip);
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->max =3D BIT(timer_width) - 1;
> +
> +	priv->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "ERROR: timer input clock not found\n");
> +	}
> +
> +	priv->rate =3D clk_get_rate(priv->clk);
> +
> +	clk_rate_exclusive_get(priv->clk);

Only call clk_get_rate() after clk_rate_exclusive_get(). Also note there
is a devm variant of clk_rate_exclusive_get().

> +	chip->ops =3D &ttc_pwm_ops;
> +	chip->npwm =3D TTC_PWM_MAX_CH;
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ttc_pwm_probe);

Putting these functions in a name space would be great.

> +void ttc_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ttc_pwm_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&priv->chip);
> +	clk_rate_exclusive_put(priv->clk);
> +}

Did you test the remove path? Hint: Don't call pwmchip_remove() if you
registered the chip using devm_pwmchip_add() and priv->chip is
uninitialized.

> +EXPORT_SYMBOL_GPL(ttc_pwm_remove);
> +
> +MODULE_AUTHOR("Mubin Sayyed <mubin.sayyed@amd.com>");
> +MODULE_DESCRIPTION("Cadence TTC PWM driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/timer-cadence-ttc.h b/include/linux/timer-cade=
nce-ttc.h
> index d938991371e5..6b6135d0ba0c 100644
> --- a/include/linux/timer-cadence-ttc.h
> +++ b/include/linux/timer-cadence-ttc.h
> @@ -12,13 +12,14 @@
>  #define TTC_CNT_CNTRL_OFFSET            0x0C /* Counter Control Reg, RW =
*/
>  #define TTC_COUNT_VAL_OFFSET            0x18 /* Counter Value Reg, RO */
>  #define TTC_INTR_VAL_OFFSET             0x24 /* Interval Count Reg, RW */
> +#define TTC_MATCH_CNT_VAL_OFFSET        0x30 /* Match Count Reg, RW */

I assume all these constants are register addresses. I'd drop _OFFSET
here. If you want a designator for these, I'd suggest REG or ADDR, but
IMHO plain TTC_MATCH_CNT_VAL is fine.

>  #define TTC_ISR_OFFSET          0x54 /* Interrupt Status Reg, RO */
>  #define TTC_IER_OFFSET          0x60 /* Interrupt Enable Reg, RW */
> =20
>  #define TTC_CNT_CNTRL_DISABLE_MASK      0x1
> =20
>  #define TTC_CLK_CNTRL_CSRC_MASK         (1 << 5)        /* clock source =
*/
> -#define TTC_CLK_CNTRL_PSV_MASK          0x1e
> +#define TTC_CLK_CNTRL_PSV_MASK		0x1e
>  #define TTC_CLK_CNTRL_PSV_SHIFT         1
> =20
>  /*
> @@ -33,3 +34,22 @@
> =20
>  #define MAX_F_ERR 50
> =20
> +#define TTC_PWM_CHANNEL         0x4

That define is misnamed IMHO. That's the offset between register ranges
for different channels. *Here* _OFFSET is fine.

> +
> +#define TTC_CLK_CNTRL_CSRC              BIT(5)
> +#define TTC_CLK_CNTRL_PS_EN             BIT(0)
> +#define TTC_CNTR_CTRL_DIS               BIT(0)
> +#define TTC_CNTR_CTRL_INTR_MODE_EN      BIT(1)
> +#define TTC_CNTR_CTRL_MATCH_MODE_EN     BIT(3)
> +#define TTC_CNTR_CTRL_RST               BIT(4)
> +#define TTC_CNTR_CTRL_WAVE_EN   BIT(5)
> +#define TTC_CNTR_CTRL_WAVE_POL  BIT(6)
> +#define TTC_CNTR_CTRL_WAVE_POL_SHIFT    6
> +#define TTC_CNTR_CTRL_PRESCALE_SHIFT    1
> +#define TTC_PWM_MAX_CH	3
> +
> +#if defined(CONFIG_PWM_CADENCE)
> +int ttc_pwm_probe(struct platform_device *pdev);
> +void ttc_pwm_remove(struct platform_device *pdev);
> +#endif

No need for the ifdef.

Best regards
Uwe

--qalzlpcxz2i65esg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfhQiMACgkQj4D7WH0S
/k4Z/ggAoa7oTUS1+r9sZyGVLuPO3maZ+Xr1MkBXOWdq1spUdApZr3FG0W8XCtm4
cy8icKVYTMx9fbJV/6uMJrukF44CfoCPv9kg4X7DyI/xDjot65Kr5b7OD4tq/jib
BnKqIS++JiWSoDc687J5rCLlfX8gFRNuIEh9yIT1VvXFECnJy3TCScaru326aErm
iwB2DXezk4ekQhfnEbO++AQ3y2f11qaa0w9z4oOedJuaSvXYKkRq6u9m/oq9bOxY
SvgSN2/GYj0TnGzvE62yi8dCC2wllcKRzUMdY7jbVHRa55iLrRbmKXINPDFAZ+f6
BQovM/yYdbuIzjEmSvCvR2bxYXlVlQ==
=UNuV
-----END PGP SIGNATURE-----

--qalzlpcxz2i65esg--

