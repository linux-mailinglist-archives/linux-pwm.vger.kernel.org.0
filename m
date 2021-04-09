Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32694359FAD
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDINTz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhDINTy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 09:19:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60511C061760;
        Fri,  9 Apr 2021 06:19:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e14so8598602ejz.11;
        Fri, 09 Apr 2021 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSe8jnln8mTLWWxJDTug+XbSbUHG3lhy21AKfwHvGK8=;
        b=mNYwWBWlNfNUFERiD/1TPjlV6zaaCuiqdfx3RmHERa51SJEE+epo2/hWSM2hSufc1/
         kIJu5LVvmQkyIxM+R+xcht+a6brcd3m6ZSJMje+AZTfC+MQluSUwYrmCQmr1bzo8ohFV
         5gvKCRzi5vW9rLsXiVSoxi8Phh1E39k6AkNSeoQze0DfDLRZ1JgmruVL4o4XxQnwmHKk
         D4GXhGYLGNpqn/yLAPATUIpyOqzNmnlH4KgqdAvD+lBlquff5MyYhLuCSOfx+4ooZ+c/
         /0fckcTxFlQxzJSNej1mNOEKXOvaPspmsoI2zNdN/h16SApIQU/GGek7rzYF0sD1p/su
         ECbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSe8jnln8mTLWWxJDTug+XbSbUHG3lhy21AKfwHvGK8=;
        b=Wk0oKg6uY4U8EMYLd14Ktv5UVJRkP0bNBaa9Ss1y28cgV5n8kZsZ5AN2mTVIWJt/8/
         1jTfBmKnlGrO9jhdENdxVxDcKrypcqamTIvHMoZBK8cmHsEhaEid73N5zqr7MsuB+Y9Y
         TUBh+GJI9kjA8ahE9KkU1f6ejtSwYJisIBBWTJFBysAENMsjkF4auDh11mqq1awF2X4a
         wIJkHlpZKmj0J0MBuLI4fQqw1K5Prggmg5VEATmFAM4dq+euYT2lzOLXj0M4ScMhfWgl
         iqi54mgb2NLbvX8C6Kvs+tNNCgbFhFgI7/mia9YjL1HKg4XN/oXRQ0xiLk1LtyMN1ceU
         s93A==
X-Gm-Message-State: AOAM532ZzJf7NmVnUKLkVjfqX9x5S3BEB3mgEqWzvJwRDa+KuMQzQ+TN
        oRYifpc/54UaNZF+iPQpHLRS8iZDAPw=
X-Google-Smtp-Source: ABdhPJyfnhVtdgB2KltAcv0IWBwviI6YIfGKDCj64qnysZFfhmLpcPdmAtzCvPcu8fzo5XRYCfGiPQ==
X-Received: by 2002:a17:906:3c1b:: with SMTP id h27mr1310737ejg.182.1617974378960;
        Fri, 09 Apr 2021 06:19:38 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id cw11sm1261796ejc.67.2021.04.09.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:19:36 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:20:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <YHBUjPjEpLYF/915@orome.fritz.box>
References: <20210409090709.1918021-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409090709.1918021-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KrYF4NcIr8iqa3gb"
Content-Disposition: inline
In-Reply-To: <20210409090709.1918021-3-nobuhiro1.iwamatsu@toshiba.co.jp>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--KrYF4NcIr8iqa3gb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 06:07:09PM +0900, Nobuhiro Iwamatsu wrote:
> Add driver for the PWM controller on Toshiba Visconti ARM SoC.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/pwm/Kconfig        |   9 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-visconti.c | 193 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>  create mode 100644 drivers/pwm/pwm-visconti.c

Looks good, but I have a few minor comments, see below.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 9a4f66ae8070..8ae68d6203fb 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -601,6 +601,15 @@ config PWM_TWL_LED
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-twl-led.
> =20
> +config PWM_VISCONTI
> +	tristate "Toshiba Visconti PWM support"
> +	depends on ARCH_VISCONTI || COMPILE_TEST
> +	help
> +	  PWM Subsystem driver support for Toshiba Visconti SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-visconti.
> +
>  config PWM_VT8500
>  	tristate "vt8500 PWM support"
>  	depends on ARCH_VT8500 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 6374d3b1d6f3..d43b1e17e8e1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -56,4 +56,5 @@ obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
> +obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> new file mode 100644
> index 000000000000..ff4a5f5b0009
> --- /dev/null
> +++ b/drivers/pwm/pwm-visconti.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Toshiba Visconti pulse-width-modulation controller driver
> + *
> + * Copyright (c) 2020 TOSHIBA CORPORATION
> + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>

Should be sorted alphabetically.

> +
> +#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
> +#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
> +#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
> +
> +#define PIPGM_PWMC_PWMACT		BIT(5)
> +#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
> +#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
> +
> +struct visconti_pwm_chip {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +};
> +
> +#define to_visconti_chip(chip) \
> +	container_of(chip, struct visconti_pwm_chip, chip)

I prefer these to be static inline functions because that tends to give
better error messages than macros. Also, that's what's primarily used in
the PWM drivers, even if there are a couple of outliers.

I'll go fix those up.

> +
> +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct visconti_pwm_chip *priv =3D to_visconti_chip(chip);
> +	u32 period, duty_cycle, pwmc0;
> +
> +	dev_dbg(chip->dev, "%s: ch =3D %d en =3D %d p =3D 0x%llx d =3D 0x%llx\n=
", __func__,
> +		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);

Don't the trace points work for you?

> +
> +	/*
> +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> +	 * When the settings of the PWM are modified, the new values are shadow=
ed in hardware until
> +	 * the period register (PCSR) is written and the currently running peri=
od is completed. This
> +	 * way the hardware switches atomically from the old setting to the new.
> +	 * Also, disabling the hardware completes the currently running period =
and keeps the output
> +	 * at low level at all times.
> +	 */
> +	if (!state->enabled) {
> +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> +		return 0;
> +	}
> +
> +	/*
> +	 * The biggest period the hardware can provide is
> +	 *	(0xffff << 3) * 1000 ns
> +	 * This value fits easily in an u32, so simplify the maths by
> +	 * capping the values to 32 bit integers.
> +	 */
> +	if (state->period > (0xffff << 3) * 1000)
> +		period =3D (0xffff << 3) * 1000;
> +	else
> +		period =3D state->period;
> +
> +	if (state->duty_cycle > period)
> +		duty_cycle =3D period;
> +	else
> +		duty_cycle =3D state->duty_cycle;
> +
> +	/*
> +	 * The input clock runs fixed at 1 MHz, so we have only
> +	 * microsecond resolution and so can divide by
> +	 * NSEC_PER_SEC / CLKFREQ =3D 1000 without loosing precision.
> +	 */
> +	period /=3D 1000;
> +	duty_cycle /=3D 1000;
> +
> +	if (!period)
> +		/* period too small */
> +		return -ERANGE;

Maybe braces around this so the two-line "block" doesn't look wrong,
even if it actually isn't. Or perhaps put the comment above the check
for the same effect.

Quite frankly, I'd just drop the comment because the code itself is
clear and the comment doesn't add anything.

> +
> +	/*
> +	 * PWMC controls a divider that divides the input clk by a
> +	 * power of two between 1 and 8. As a smaller divider yields
> +	 * higher precision, pick the smallest possible one.
> +	 */
> +	if (period > 0xffff) {
> +		pwmc0 =3D ilog2(period >> 16);
> +		BUG_ON(pwmc0 > 3);
> +	} else
> +		pwmc0 =3D 0;
> +
> +	period >>=3D pwmc0;
> +	duty_cycle >>=3D pwmc0;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pwmc0 |=3D PIPGM_PWMC_PWMACT;
> +	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
> +	writel(duty_cycle, priv->base + PIPGM_PDUT(pwm->hwpwm));
> +	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));
> +
> +	return 0;
> +}
> +
> +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct visconti_pwm_chip *priv =3D to_visconti_chip(chip);
> +	u32 period, duty, pwmc0, pwmc0_clk;
> +
> +	period =3D readl(priv->base + PIPGM_PCSR(pwm->hwpwm));
> +	if (period)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	duty =3D readl(priv->base + PIPGM_PDUT(pwm->hwpwm));
> +	pwmc0 =3D readl(priv->base + PIPGM_PWMC(pwm->hwpwm));
> +	pwmc0_clk =3D pwmc0 & PIPGM_PWMC_CLK_MASK;
> +
> +	state->period =3D (period << pwmc0_clk) * NSEC_PER_USEC;
> +	state->duty_cycle =3D (duty << pwmc0_clk) * NSEC_PER_USEC;
> +	if (pwmc0 & PIPGM_PWMC_POLARITY_MASK)
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +	else
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> +static const struct pwm_ops visconti_pwm_ops =3D {
> +	.apply =3D visconti_pwm_apply,
> +	.get_state =3D visconti_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int visconti_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct visconti_pwm_chip *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &visconti_pwm_ops;
> +	priv->chip.base =3D -1;

There's no need for this anymore. The current PWM tree will always
assume base =3D -1.

> +	priv->chip.npwm =3D 4;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n"=
);
> +
> +	dev_dbg(&pdev->dev, "visconti PWM registered\n");

Maybe not the best use of a debug message. There are better ways to
check if a device has successfully bound to a driver than relying on
debug messages.

> +
> +	return 0;
> +}
> +
> +static int visconti_pwm_remove(struct platform_device *pdev)
> +{
> +	struct visconti_pwm_chip *priv =3D platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&priv->chip);

I think Uwe would prefer this to be done separately because he's working
towards removing the return value from pwmchip_remove() and if we start
ignoring it in new drivers that will make life easier going forward.

So this should just be:

	pwmchip_remove(&priv->chip);

	return 0;

Thierry

--KrYF4NcIr8iqa3gb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwVIoACgkQ3SOs138+
s6F7Hg//YS+ZDkfP0MITgmCsadm0za0B8BllzTszVvvVHJYPNKUL6F7/i9Abko2W
4YcJ8+mn3dPX+37t5nX91mw9VFqXFDcdOLdJGEMMBFXqcDbkZoetBEg2QIeVbs0F
3axNb5SEcWfWldejt0O0vP7446y2M7QFTFfurt7953+PwIIOSPNFw/kTAhFjV0v3
BblywM5PKaN2FNsPNHpa0x5fdCgRLyVnuXvsG5WtQZCoVlNZ4z8hcW7VWFxAjQvL
kxwevPx5IyEoW5bIueR9r7ESWqd6IDnv/0M+tlHDJn7V8Kx2eUhYgovAnvukVwrB
ZWg2bOPMbe7bffO+bnGdi5QpAIHCkVc+4bgpvngvalC/5C+DQJDldLkTBmpMHvE8
JUyIo42AS0S8ue4SWQu/vS+fO8xJGr4TcNvatmFrNiLhupEh5bpYjtwEnljrqHKg
wwZvGHEQe73FJ3CQB8sLzBVMf/A13VL1eJ736clVRe1u7kT5EYv9mu2ystQOIfoS
ONpbZWoBom4NI+uogcWT81I9Nk8OhU8UH0ombKP47/ARIDrKblp8iFv6OWawva4E
qOL6xHnzZhwK/tku9tH+qTyD0XUNtft+/W50WXKiyedOfGYwkZL1yQNQFwjtqMQR
sjQFom3B7TSVDw4Now+0JNCF10n6QVWdYrMFlVHS4szkIKePyQw=
=G+91
-----END PGP SIGNATURE-----

--KrYF4NcIr8iqa3gb--
