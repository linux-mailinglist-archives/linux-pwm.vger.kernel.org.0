Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA5830DE9E
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Feb 2021 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhBCPsY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Feb 2021 10:48:24 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36655 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234606AbhBCPrq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Feb 2021 10:47:46 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 65A6D5C01CC;
        Wed,  3 Feb 2021 10:46:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Feb 2021 10:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=96Ecvhc/pjHBeZw4weIlWXVyrP/
        5g67z/J1POqTyq4U=; b=ko7CP+t5HsJn5tZux9svMu86IFpUpTO8Zjnf6NLpOi6
        xDEE3NYRvTHB9n+AqFBcsCtECl2UmD02QPHLEDxnwpg238v72v/TMdhj3Q24b/CN
        qtVT3PbEQP3TxfPRvfd6EiI1uX16j6l40XCghIG4lSCCvManqxZBW9Xz7MUmTKpZ
        wgcwS0uOgfTbObFkeYN1NtBQGgRQk6rnlMIzZVdgKrMWxBxWOzqtVvRZbvU+NwB9
        XBT/1VmZjzVsP6RyEhxNOup/HFW4lwPEj4W5xhrhGct3olPs0PgQu09TWOaqPsxd
        D47N1vpSDgLh05IAx2L5dkmVFe2V+XxcKmlN1MWtvnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=96Ecvh
        c/pjHBeZw4weIlWXVyrP/5g67z/J1POqTyq4U=; b=ZrHWCUdxVT/wlTqG0LvEwV
        KORUlrIzFriTKHtGwXSsgJb4C38eonk9UgxEnze879Wd5FoZLObcT0TrIGN23uAD
        70nW1/iz5M+/sOhANGnxt3B6WSLJ9UJU8p9xBLXRp0LkSmgTeVwxvFFRd5Psb3OL
        BVvUTZAG/JjzkL9cvOmAm1tx8u3CDECNtmqf5kiWZKrffvWQHgY56L1UhHxhR3Ui
        yiIX1O5QX+q4HLM/IAk0Ep7Y/IuEIuCbhb9Jlzkh4iM+XK9jTlHRCCGXLmgtOuy7
        4bkhcH/Y6l7XfiVZwoO+X75gQYHAclm8FIZ4xbEZpcGAom0GKxzAGjBKAzsFJi+g
        ==
X-ME-Sender: <xms:V8UaYHz4g_5DKWrCD3eIVn8r_cKENnrxVb_4b-3w058ICRyqcwkM9A>
    <xme:V8UaYPO1NfInnxCaffyTmS-lAZsZhGU05VKa0xpNAkA1ivRYOSizDAzsXz8xTfoMB
    r3M0alAT8qQP_oJQqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedvgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:V8UaYOO_f3lJLAyN-0CRWMfc5lrUczROYSWL5FAeecdQPrlG1bPSGw>
    <xmx:V8UaYJSSuQLs-HTQ5M7ukMSTSBIpPgnrab0nyKUFGZC7ITSa_Piwhg>
    <xmx:V8UaYIBqI2qcj8FBNXsPT9gMd_GQ46caAgXhZuxIuiPSIBmZiZ-zWQ>
    <xmx:WMUaYLf3VYAHiep-ZpfLW5rfNi7M2w7TNraECOqjurrIdLT46wNeyQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 31D771080059;
        Wed,  3 Feb 2021 10:46:31 -0500 (EST)
Date:   Wed, 3 Feb 2021 16:46:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        wens@csie.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <20210203154628.infi5jnlofdrysvs@gilmour>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qbm7zw7fomypmndn"
Content-Disposition: inline
In-Reply-To: <20210203125317.1975-1-fengzheng923@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qbm7zw7fomypmndn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> From: Ban Tao <fengzheng923@gmail.com>
>=20
> The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
> IP compared to the older Allwinner SoCs.
>=20
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>

Thanks for your patch. There's a bunch of warnings reported by
checkpatch --strict, they should be addressed.

> ---
> v1->v2:
> 1.delete unnecessary code.
> 2.using a named define for some constants.
> 3.Add comment in sun50i_pwm_config function.
> 4.using dev_err_probe() for error handling.
> 5.disable the clock after pwmchip_remove().
> ---
>  MAINTAINERS              |   6 +
>  drivers/pwm/Kconfig      |  11 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sun50i.c | 348 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 366 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun50i.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..d33cf1b69b43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -737,6 +737,12 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/staging/media/sunxi/cedrus/
> =20
> +ALLWINNER PWM DRIVER
> +M:	Ban Tao <fengzheng923@gmail.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pwm/pwm-sun50i.c
> +
>  ALPHA PORT
>  M:	Richard Henderson <rth@twiddle.net>
>  M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 9a4f66ae8070..17635a8f2ed3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -552,6 +552,17 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN50I
> +	tristate "Allwinner enhanced PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Enhanced PWM framework driver for Allwinner R818, A133, R329,
> +	  V536 and V833 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun50i.
> +

Even though it's unfortunate, there's a bunch of other SoCs part of the
sun50i family that are supported by the sun4i driver.

Which SoC introduced that new design? It's usually the name we pick up
then.

>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 6374d3b1d6f3..b4754927fd8f 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN50I)	+=3D pwm-sun50i.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sun50i.c b/drivers/pwm/pwm-sun50i.c
> new file mode 100644
> index 000000000000..37285d771924
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Allwinner sun50i Pulse Width Modulation Controller
> + *
> + * Copyright (C) 2020 Ban Tao <fengzheng923@gmail.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +
> +#define PWM_GET_CLK_OFFSET(chan)	(0x20 + ((chan >> 1) * 0x4))
> +#define PWM_CLK_APB_SCR			BIT(7)
> +#define PWM_DIV_M			0
> +#define PWM_DIV_M_WIDTH			0x4
> +
> +#define PWM_CLK_REG			0x40
> +#define PWM_CLK_GATING			BIT(0)
> +
> +#define PWM_ENABLE_REG			0x80
> +#define PWM_EN				BIT(0)
> +
> +#define PWM_CTL_REG(chan)		(0x100 + 0x20 * chan)
> +#define PWM_ACT_STA			BIT(8)
> +#define PWM_PRESCAL_K			0
> +#define PWM_PRESCAL_K_WIDTH		0x8
> +
> +#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
> +#define PWM_ENTIRE_CYCLE		16
> +#define PWM_ENTIRE_CYCLE_WIDTH		0x10
> +#define PWM_ACT_CYCLE			0
> +#define PWM_ACT_CYCLE_WIDTH		0x10
> +
> +#define BIT_CH(bit, chan)		((bit) << (chan))
> +
> +#define SETMASK(width, shift)		((width?((-1U) >> (32-width)):0)  << (shi=
ft))
> +#define CLRMASK(width, shift)		(~(SETMASK(width, shift)))
> +#define GET_BITS(shift, width, reg)     \
> +	    (((reg) & SETMASK(width, shift)) >> (shift))
> +#define SET_BITS(shift, width, reg, val) \
> +	    (((reg) & CLRMASK(width, shift)) | (val << (shift)))
> +
> +#define PWM_OSC_CLK			24000000
> +#define PWM_PRESCALER_MAX		256
> +#define PWM_CLK_DIV_M__MAX		9
> +#define PWM_ENTIRE_CYCLE_MAX		65536
> +
> +struct sun50i_pwm_data {
> +	unsigned int npwm;
> +};
> +
> +struct sun50i_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst_clk;
> +	void __iomem *base;
> +	const struct sun50i_pwm_data *data;
> +};
> +
> +static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct pwm_ch=
ip *chip)
> +{
> +	return container_of(chip, struct sun50i_pwm_chip, chip);
> +}
> +
> +static inline u32 sun50i_pwm_readl(struct sun50i_pwm_chip *chip,
> +				  unsigned long offset)
> +{
> +	return readl(chip->base + offset);
> +}
> +
> +static inline void sun50i_pwm_writel(struct sun50i_pwm_chip *chip,
> +				    u32 val, unsigned long offset)
> +{
> +	writel(val, chip->base + offset);
> +}
> +
> +static int sun50i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	u32 temp;
> +
> +	temp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
> +
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		temp |=3D PWM_ACT_STA;
> +	else
> +		temp &=3D ~PWM_ACT_STA;
> +
> +	sun50i_pwm_writel(sun50i_pwm, temp, PWM_CTL_REG(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static int sun50i_pwm_config(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +		int duty_ns, int period_ns)
> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	unsigned long long c;
> +	unsigned long entire_cycles, active_cycles;
> +	unsigned int div_m, prescaler;
> +	u32 tmp;
> +
> +	if (period_ns > 334) {
> +		/* if freq < 3M, then select 24M clock */
> +		c =3D PWM_OSC_CLK;
> +		tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +		tmp &=3D ~PWM_CLK_APB_SCR;
> +		sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	} else {
> +		/* if freq > 3M, then select APB as clock */
> +		c =3D clk_get_rate(sun50i_pwm->clk);
> +		tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +		tmp |=3D PWM_CLK_APB_SCR;
> +		sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	}
> +
> +	dev_dbg(chip->dev, "duty_ns=3D%d period_ns=3D%d c =3D%llu.\n",
> +			duty_ns, period_ns, c);
> +
> +	/*
> +	 * (clk / div_m / prescaler) / entire_cycles =3D NSEC_PER_SEC / period_=
ns.
> +	 * So, entire_cycles =3D clk * period_ns / NSEC_PER_SEC / div_m / presc=
aler.
> +	 */
> +	c =3D c * period_ns;
> +	do_div(c, NSEC_PER_SEC);
> +	for (div_m =3D 0; div_m < PWM_CLK_DIV_M__MAX; div_m++) {
> +		for (prescaler =3D 0; prescaler < PWM_PRESCALER_MAX; prescaler++) {
> +			/*
> +			 * actual prescaler =3D prescaler + 1.
> +			 * actual div_m =3D 0x1 << div_m.
> +			*/
> +			entire_cycles =3D ((unsigned long)c/(0x1 << div_m))/(prescaler + 1);
> +			if (entire_cycles <=3D PWM_ENTIRE_CYCLE_MAX) {
> +				goto calc_end;
> +			}
> +		}
> +	}
> +
> +calc_end:
> +	/*
> +	 * duty_ns / period_ns =3D active_cycles / entire_cycles.
> +	 * So, active_cycles =3D entire_cycles * duty_ns / period_ns.
> +	 */
> +	c =3D (unsigned long long)entire_cycles * duty_ns;
> +	do_div(c, period_ns);
> +	active_cycles =3D c;
> +	if (entire_cycles =3D=3D 0)
> +		entire_cycles++;
> +
> +	/* enable clk gating */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> +	tmp |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> +
> +	/* config  clk div_m*/
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +	tmp =3D SET_BITS(PWM_DIV_M, PWM_DIV_M_WIDTH, tmp, div_m);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
> +
> +	/* config prescal */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
> +	tmp =3D SET_BITS(PWM_PRESCAL_K, PWM_PRESCAL_K_WIDTH, tmp, prescaler);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CTL_REG(pwm->hwpwm));
> +
> +	/* config active and period cycles */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_PERIOD_REG(pwm->hwpwm));
> +	tmp =3D SET_BITS(PWM_ACT_CYCLE, PWM_ACT_CYCLE_WIDTH, tmp, active_cycles=
);
> +	tmp =3D SET_BITS(PWM_ENTIRE_CYCLE, PWM_ENTIRE_CYCLE_WIDTH, tmp, (entire=
_cycles - 1));
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_PERIOD_REG(pwm->hwpwm));
> +
> +	dev_dbg(chip->dev, "active_cycles=3D%lu entire_cycles=3D%lu prescaler=
=3D%u div_m=3D%u\n",
> +			active_cycles, entire_cycles, prescaler, div_m);
> +
> +	return 0;
> +}
> +
> +static int sun50i_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	u32 tmp;
> +
> +	/* enable pwm controller */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
> +	tmp |=3D BIT_CH(PWM_EN, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
> +
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> +	tmp |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> +
> +	return 0;
> +}
> +
> +static void sun50i_pwm_disable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct sun50i_pwm_chip *sun50i_pwm =3D sun50i_pwm_from_chip(chip);
> +	u32 tmp;
> +
> +	/* disable pwm controller */
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
> +	tmp &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
> +
> +	tmp =3D sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
> +	tmp &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
> +}
> +
> +static const struct pwm_ops sun50i_pwm_ops =3D {
> +	.config =3D sun50i_pwm_config,
> +	.enable =3D sun50i_pwm_enable,
> +	.disable =3D sun50i_pwm_disable,
> +	.set_polarity =3D sun50i_pwm_set_polarity,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {
> +	.npwm =3D 9,
> +};
> +
> +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D {
> +	.npwm =3D 16,
> +};
> +
> +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
> +	{
> +		.compatible =3D "allwinner,sun8i-v833-pwm",
> +		.data =3D &sun8i_pwm_data_c9,
> +	}, {
> +		.compatible =3D "allwinner,sun8i-v536-pwm",
> +		.data =3D &sun8i_pwm_data_c9,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-r818-pwm",
> +		.data =3D &sun50i_pwm_data_c16,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-a133-pwm",
> +		.data =3D &sun50i_pwm_data_c16,
> +	}, {
> +		.compatible =3D "allwinner,sun50i-r329-pwm",
> +		.data =3D &sun8i_pwm_data_c9,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);

What are the differences between all these SoCs? If there's none between
the v833, v536 and R329, and between the r818 and the A133, you should
use the same compatible.

The device tree binding must be documented too

Maxime

--qbm7zw7fomypmndn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBrFVAAKCRDj7w1vZxhR
xfTZAP0SItG49wLJS6zaFskVkcdtDbDXvmRpMvuijPxvoSHXaQEAnARYWHjiXzl1
0x4vf8zBs+YG5d3IkBH6yaa1RKYz9wY=
=Bvzx
-----END PGP SIGNATURE-----

--qbm7zw7fomypmndn--
