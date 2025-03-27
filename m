Return-Path: <linux-pwm+bounces-5293-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0CEA72BFA
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A921A188E63E
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Mar 2025 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142DB20B7E9;
	Thu, 27 Mar 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHCuv6uh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B81F4C92;
	Thu, 27 Mar 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743065952; cv=none; b=h0/2k784CZMk++tZkT3EG4btP6/gao7mZY149naYLHCRzJOpw40cOp4n9WNMAumWpYX1waejpB9cPc2YbgTjoQUVSg6Yy/ol93nG20HFwZSfIVfxnpyu9e+XQtKqnMBlowSzg4g9PcVJSmRSLYQv9DQZtHHWZEGI7yPd4vjBaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743065952; c=relaxed/simple;
	bh=/xH/gnIghZxBX7NPUF1PICGcFCgtMBy79qY+x43IMBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyPT4+DxhEnzFxrrCM8cd/dTQkbEKMh1EYpBzPvcscbEJ/4KgDhd4mYckzk3vYK/6tQlPOvrEcHzt67k2CC2EqLq4wrgOA4rHF2xEs7n1yVw6wDIYygZjuRJV/svWCqsivtQelkx+6o2LWnU7/7t4njhSLHjByCuDSnYL5w2l08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHCuv6uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE02BC4CEEB;
	Thu, 27 Mar 2025 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743065952;
	bh=/xH/gnIghZxBX7NPUF1PICGcFCgtMBy79qY+x43IMBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHCuv6uh+UNhNd6O+axTLu4VF0iLmSvIFr6/AwISGo+KpXMHJUErzdUlFEWJ3Q9co
	 9uhYPsbe+GVGy7vICyjpf7Evff1karflwZ1g9eMmKVSyu+gcfPNF/phU4pW3PhwKlm
	 vHB2eyi9pYBefduxjy3/cB5BtWOLD27tsEPUS+SUru/26so9ihZTFo+429uXhJ4Ubf
	 Vos7yS4vAWOwIqDkSYcHwFRo/hVrcLbSw+W31O8u0RY5bvTZWMtiemEhQc6MNU+cX9
	 X9uCsFxJSp6Z9j6wZLdvF3qx6p6PSPESSMkE0jRQrXEyvFV3r66Cu7GH/+xVxkN2mj
	 e0abyGgfxl9Mg==
Date: Thu, 27 Mar 2025 09:59:09 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Brandon Cheo Fusi <fusibrandon13@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <oxfx4xiwfahkosy6tguv4gti3b4xguupmbxilmmnewwhstjny6@2wbh445cp4wf>
References: <20250213094018.134081-1-privatesub2@gmail.com>
 <20250213094018.134081-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6wb7wz7z7rpb4nz2"
Content-Disposition: inline
In-Reply-To: <20250213094018.134081-3-privatesub2@gmail.com>


--6wb7wz7z7rpb4nz2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
MIME-Version: 1.0

On Thu, Feb 13, 2025 at 12:40:13PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
>=20
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.
>=20
> Co-developed-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  drivers/pwm/Kconfig      |  10 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun20i.c | 370 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 381 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun20i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..778151aa3860 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -652,6 +652,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN20I
> +	tristate "Allwinner D1/T113s/R329 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner D1/T113s/R329 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun20i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..85ad1fe0dde1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN20I)	+=3D pwm-sun20i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
> diff --git a/drivers/pwm/pwm-sun20i.c b/drivers/pwm/pwm-sun20i.c
> new file mode 100644
> index 000000000000..409fa8e9bc45
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun20i.c
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM Controller Driver for sunxi platforms (D1, T113-S3 and R329)
> + *
> + * Limitations:
> + * - When the parameters change, the current running period is not compl=
eted
> + *   and new settings are applied immediately.
> + * - The PWM output goes to a HIGH-Z state when the channel is disabled.
> + * - Changing the clock configuration (SUN20I_PWM_CLK_CFG)
> + * - may cause a brief output glitch.

s/ - may/   may/

> + * Copyright (c) 2023 Aleksandr Shubin <privatesub2@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#define SUN20I_PWM_CLK_CFG(pair)		(0x20 + ((pair) * 0x4))
> +#define SUN20I_PWM_CLK_CFG_SRC			GENMASK(8, 7)
> +#define SUN20I_PWM_CLK_CFG_DIV_M		GENMASK(3, 0)
> +#define SUN20I_PWM_CLK_DIV_M_MAX		8
> +
> +#define SUN20I_PWM_CLK_GATE			0x40
> +#define SUN20I_PWM_CLK_GATE_BYPASS(chan)	BIT((chan) + 16)
> +#define SUN20I_PWM_CLK_GATE_GATING(chan)	BIT(chan)
> +
> +#define SUN20I_PWM_ENABLE			0x80
> +#define SUN20I_PWM_ENABLE_EN(chan)		BIT(chan)
> +
> +#define SUN20I_PWM_CTL(chan)			(0x100 + (chan) * 0x20)
> +#define SUN20I_PWM_CTL_ACT_STA			BIT(8)
> +#define SUN20I_PWM_CTL_PRESCAL_K		GENMASK(7, 0)
> +#define SUN20I_PWM_CTL_PRESCAL_K_MAX		field_max(SUN20I_PWM_CTL_PRESCAL_K)
> +
> +#define SUN20I_PWM_PERIOD(chan)			(0x104 + (chan) * 0x20)
> +#define SUN20I_PWM_PERIOD_ENTIRE_CYCLE		GENMASK(31, 16)
> +#define SUN20I_PWM_PERIOD_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define SUN20I_PWM_PCNTR_SIZE			BIT(16)
> +
> +/*
> + * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock d=
ividers
> + * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL=
_K)
> + * without using a loop. These dividers limit the # of cycles in a period
> + * to SUN20I_PWM_PCNTR_SIZE (65536) by applying a scaling factor of
> + * 1/(div_m * (prescale_k + 1)) to the clock source.
> + *
> + * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
> + * such that for a given requested period,
> + *
> + * i) div_m is minimized for any prescale_k =E2=89=A4 SUN20I_PWM_CTL_PRE=
SCAL_K_MAX,
> + * ii) prescale_k is minimized.
> + *
> + * The derivation proceeds as follows, with val =3D # of cycles for requ=
ested
> + * period:
> + *
> + * for a given value of div_m we want the smallest prescale_k such that
> + *
> + * (val >> div_m) // (prescale_k + 1) =E2=89=A4 65536 (=3D SUN20I_PWM_PC=
NTR_SIZE)
> + *
> + * This is equivalent to:
> + *
> + * (val >> div_m) =E2=89=A4 65536 * (prescale_k + 1) + prescale_k
> + * =E2=9F=BA (val >> div_m) =E2=89=A4 65537 * prescale_k + 65536
> + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 65537 * prescale_k
> + * =E2=9F=BA ((val >> div_m) - 65536) / 65537 =E2=89=A4 prescale_k
> + *
> + * As prescale_k is integer, this becomes
> + *
> + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 prescale_k
> + *
> + * And is minimized at
> + *
> + * ((val >> div_m) - 65536) // 65537
> + *
> + * Now we pick the smallest div_m that satifies prescale_k =E2=89=A4 255
> + * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
> + *
> + * ((val >> div_m) - 65536) // 65537 =E2=89=A4 255
> + * =E2=9F=BA (val >> div_m) - 65536 =E2=89=A4 255 * 65537 + 65536
> + * =E2=9F=BA val >> div_m =E2=89=A4 255 * 65537 + 2 * 65536
> + * =E2=9F=BA val >> div_m < (255 * 65537 + 2 * 65536 + 1)
> + * =E2=9F=BA div_m =3D fls((val) / (255 * 65537 + 2 * 65536 + 1))
> + *
> + * Suggested by Uwe Kleine-K=C3=B6nig
> + */
> +#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
> +#define SUN20I_PWM_DIV_CONST			65537
> +
> +struct sun20i_pwm_chip {
> +	struct clk *clk_hosc, *clk_apb;
> +	void __iomem *base;
> +};
> +
> +static inline struct sun20i_pwm_chip *to_sun20i_pwm_chip(struct pwm_chip=
 *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static inline u32 sun20i_pwm_readl(struct sun20i_pwm_chip *chip,
> +				   unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun20i_pwm_writel(struct sun20i_pwm_chip *chip,
> +				     u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun20i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u16 ent_cycle, act_cycle, prescale_k;
> +	u64 clk_rate, tmp;
> +	u8 div_m;
> +	u32 val;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm / 2=
));
> +	div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, val);
> +	if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> +		div_m =3D SUN20I_PWM_CLK_DIV_M_MAX;
> +
> +	/*
> +	 * If CLK_CFG_SRC is 0, use the hosc clock;
> +	 * otherwise (any nonzero value) use the APB clock.
> +	 */
> +	if (FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, val) =3D=3D 0)
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	else
> +		clk_rate =3D clk_get_rate(sun20i_chip->clk_apb);
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +	state->polarity =3D (SUN20I_PWM_CTL_ACT_STA & val) ?
> +			   PWM_POLARITY_NORMAL : PWM_POLARITY_INVERSED;
> +
> +	prescale_k =3D FIELD_GET(SUN20I_PWM_CTL_PRESCAL_K, val) + 1;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> +	state->enabled =3D (SUN20I_PWM_ENABLE_EN(pwm->hwpwm) & val) ? true : fa=
lse;
> +
> +	val =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_PERIOD(pwm->hwpwm));
> +
> +	act_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ACT_CYCLE, val);
> +	ent_cycle =3D FIELD_GET(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, val);

It would be consistent to drop the empty line above the assignment of
act_cycle.

> +
> +	/*
> +	 * The duration of the active phase should not be longer
> +	 * than the duration of the period
> +	 */
> +	if (act_cycle > ent_cycle)
> +		act_cycle =3D ent_cycle;
> +
> +	/*
> +	 * We have act_cycle <=3D ent_cycle <=3D 0xffff, prescale_k <=3D 0x100,
> +	 * div_m <=3D 8. So the multiplication fits into an u64 without
> +	 * overflow.
> +	 */
> +	tmp =3D ((u64)(act_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +	tmp =3D ((u64)(ent_cycle) * prescale_k << div_m) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_UP_ULL(tmp, clk_rate);
> +
> +	return 0;
> +}
> +
> +static int sun20i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct sun20i_pwm_chip *sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +	u64 bus_rate, hosc_rate, val, ent_cycle, act_cycle;
> +	u32 clk_gate, clk_cfg, pwm_en, ctl, reg_period;
> +	u32 prescale_k, div_m;
> +	bool use_bus_clk;
> +
> +	pwm_en =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_ENABLE);
> +
> +	if (state->enabled !=3D pwm->state.enabled) {
> +		clk_gate =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_GATE);
> +
> +		if (!state->enabled) {
> +			clk_gate &=3D ~SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +			pwm_en &=3D ~SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> +			sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
> +			sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
> +
> +			return 0;
> +		}
> +	}

So if I go from a disabled state to another disabled state there is no
early exit? That's strange.

> +	ctl =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CTL(pwm->hwpwm));
> +	clk_cfg =3D sun20i_pwm_readl(sun20i_chip, SUN20I_PWM_CLK_CFG(pwm->hwpwm=
 / 2));
> +	hosc_rate =3D clk_get_rate(sun20i_chip->clk_hosc);
> +	bus_rate =3D clk_get_rate(sun20i_chip->clk_apb);
> +	if (pwm_en & SUN20I_PWM_ENABLE_EN(pwm->hwpwm ^ 1)) {
> +		/* If the neighbor channel is enabled, use the current clock settings =
*/
> +		use_bus_clk =3D FIELD_GET(SUN20I_PWM_CLK_CFG_SRC, clk_cfg) !=3D 0;
> +		val =3D mul_u64_u64_div_u64(state->period,
> +					  (use_bus_clk ? bus_rate : hosc_rate),
> +					  NSEC_PER_SEC);
> +
> +		div_m =3D FIELD_GET(SUN20I_PWM_CLK_CFG_DIV_M, clk_cfg);
> +	} else {
> +		/*
> +		 * Select the clock source based on the period.
> +		 * Since bus_rate > hosc_rate, which means bus_rate
> +		 * can provide a higher frequency than hosc_rate.
> +		 */
> +		use_bus_clk =3D false;
> +		val =3D mul_u64_u64_div_u64(state->period, hosc_rate, NSEC_PER_SEC);
> +		/*
> +		 * If the calculated value is =E2=89=A4 1, the period is too short
> +		 * for proper PWM operation
> +		 */
> +		if (val <=3D 1) {
> +			use_bus_clk =3D true;
> +			val =3D mul_u64_u64_div_u64(state->period, bus_rate, NSEC_PER_SEC);
> +			if (val <=3D 1)
> +				return -EINVAL;
> +		}
> +		div_m =3D fls(DIV_ROUND_DOWN_ULL(val, SUN20I_PWM_MAGIC));
> +		if (div_m > SUN20I_PWM_CLK_DIV_M_MAX)
> +			return -EINVAL;
> +
> +		/* Set up the CLK_DIV_M and clock CLK_SRC */
> +		clk_cfg =3D FIELD_PREP(SUN20I_PWM_CLK_CFG_DIV_M, div_m);
> +		clk_cfg |=3D FIELD_PREP(SUN20I_PWM_CLK_CFG_SRC, use_bus_clk);
> +
> +		sun20i_pwm_writel(sun20i_chip, clk_cfg, SUN20I_PWM_CLK_CFG(pwm->hwpwm =
/ 2));
> +	}
> +
> +	/* Calculate prescale_k and determine the number of cycles for a full P=
WM period */
> +	ent_cycle =3D val >> div_m;
> +	prescale_k =3D DIV_ROUND_DOWN_ULL(ent_cycle, SUN20I_PWM_DIV_CONST);
> +	if (prescale_k > SUN20I_PWM_CTL_PRESCAL_K_MAX)
> +		prescale_k =3D SUN20I_PWM_CTL_PRESCAL_K_MAX;
> +
> +	/* ent_cycle must not be zero */
> +	if (ent_cycle =3D=3D 0)
> +		return -EINVAL;
> +	do_div(ent_cycle, prescale_k + 1);

Without having dived into the involved math completely I wonder if
checking for ent_cycle =3D=3D 0 only after the division would be more
sensible?

> +	/* For N cycles, PPRx.PWM_ENTIRE_CYCLE =3D (N-1) */
> +	reg_period =3D FIELD_PREP(SUN20I_PWM_PERIOD_ENTIRE_CYCLE, ent_cycle - 1=
);
> +
> +	/* Calculate the active cycles (duty cycle) */
> +	val =3D mul_u64_u64_div_u64(state->duty_cycle,
> +				  (use_bus_clk ? bus_rate : hosc_rate),
> +				  NSEC_PER_SEC);
> +	act_cycle =3D val >> div_m;
> +	do_div(act_cycle, prescale_k + 1);
> +
> +	/*
> +	 * The formula of the output period and the duty-cycle for PWM are as f=
ollows.
> +	 * T period =3D PWM0_PRESCALE_K / PWM01_CLK * (PPR0.PWM_ENTIRE_CYCLE + =
1)
> +	 * T high-level =3D PWM0_PRESCALE_K / PWM01_CLK * PPR0.PWM_ACT_CYCLE
> +	 * Duty-cycle =3D T high-level / T period
> +	 */
> +	reg_period |=3D FIELD_PREP(SUN20I_PWM_PERIOD_ACT_CYCLE, act_cycle);
> +	sun20i_pwm_writel(sun20i_chip, reg_period, SUN20I_PWM_PERIOD(pwm->hwpwm=
));
> +
> +	ctl =3D FIELD_PREP(SUN20I_PWM_CTL_PRESCAL_K, prescale_k);
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		ctl |=3D SUN20I_PWM_CTL_ACT_STA;
> +
> +	sun20i_pwm_writel(sun20i_chip, ctl, SUN20I_PWM_CTL(pwm->hwpwm));
> +
> +	if (state->enabled !=3D pwm->state.enabled) {
> +		clk_gate &=3D ~SUN20I_PWM_CLK_GATE_BYPASS(pwm->hwpwm);
> +		clk_gate |=3D SUN20I_PWM_CLK_GATE_GATING(pwm->hwpwm);
> +		pwm_en |=3D SUN20I_PWM_ENABLE_EN(pwm->hwpwm);
> +		sun20i_pwm_writel(sun20i_chip, pwm_en, SUN20I_PWM_ENABLE);
> +		sun20i_pwm_writel(sun20i_chip, clk_gate, SUN20I_PWM_CLK_GATE);
> +	}

If you take the early exit above you can assume that state->enabled =3D=3D
true here and simplify the if condition to

	if (!pwm->state.enabled)

> +	return 0;
> +}
> +
> +static const struct pwm_ops sun20i_pwm_ops =3D {
> +	.apply =3D sun20i_pwm_apply,
> +	.get_state =3D sun20i_pwm_get_state,
> +};
> +
> +static const struct of_device_id sun20i_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun20i-d1-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sun20i_pwm_dt_ids);
> +
> +static int sun20i_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip;
> +	struct sun20i_pwm_chip *sun20i_chip;
> +	struct clk *clk_bus;
> +	struct reset_control *rst;
> +	u32 npwm;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,npwms", &npw=
m);
> +	if (ret < 0)
> +		npwm =3D 8; /* Default value */
> +
> +	if (npwm > 16) {
> +		dev_info(&pdev->dev, "Limiting number of PWM lines from %u to 16", npw=
m);
> +		npwm =3D 16;
> +	}
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*sun20i_chip));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	sun20i_chip =3D to_sun20i_pwm_chip(chip);
> +
> +	sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun20i_chip->base))
> +		return PTR_ERR(sun20i_chip->base);
> +
> +	clk_bus =3D devm_clk_get_enabled(&pdev->dev, "bus");
> +	if (IS_ERR(clk_bus))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk_bus),
> +				     "Failed to get bus clock\n");
> +
> +	sun20i_chip->clk_hosc =3D devm_clk_get_enabled(&pdev->dev, "hosc");
> +	if (IS_ERR(sun20i_chip->clk_hosc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_hosc),
> +				     "Failed to get hosc clock\n");
> +
> +	sun20i_chip->clk_apb =3D devm_clk_get_enabled(&pdev->dev, "apb");
> +	if (IS_ERR(sun20i_chip->clk_apb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->clk_apb),
> +				     "Failed to get apb clock\n");
> +
> +	if (clk_get_rate(sun20i_chip->clk_apb) <=3D clk_get_rate(sun20i_chip->c=
lk_hosc))
> +		dev_info(&pdev->dev, "APB clock must be greater than hosc clock");

When the PWM is configured we don't want the clock rates to change. I
suggest to call devm_clk_rate_exclusive_get() on the two relevant
clocks. This is lax because this locks more than needed, but if that
turns out to be a problem this can be addressed later and locking to
much is better than locking to little.

Best regards
Uwe


--6wb7wz7z7rpb4nz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmflE1sACgkQj4D7WH0S
/k435QgAp17GG08q79p4WAj+vVaOTX5T++KAPz6xc2wAkBSh2ynitrLx6OnekJWL
UEaKCZ3OG1YxCf1wPA31rcxYxVhythhUS1FVy6eUAmI1pcDscYm2aXptCEdFEX4A
kF2t8OxzeeXGMbeTszTE6DUukyGUO3A2J2jrEAL5jXUtttTpi3gWZYVP5LSGNlR+
I0poHYjFSTLUGCeiqM542ZLrbR8zB+1AC5yk6licjNp7gsJ7EAcJUpnbxg8UB9a4
BipYMz9CQG9dhzdro3Dl/Bm+y7eqQXIHRhP0VmhERyWpKh4oUWEfme2135gvXeEB
oxNJS5Gs4+byzfHHh7KSBT/aOffcaA==
=pD4A
-----END PGP SIGNATURE-----

--6wb7wz7z7rpb4nz2--

