Return-Path: <linux-pwm+bounces-4811-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38186A2BF44
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 10:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D30188CD49
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B81D5CE3;
	Fri,  7 Feb 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVNE5J+e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41E481B6;
	Fri,  7 Feb 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920528; cv=none; b=e2ejy0Q7pB4XMi5uGgjWjdaBZExUOZvmLVlVpDuw/KZ8U+nkyJ4MbMtDHt0yWQVrPlxsfeFnS4Vo3b7ja0jQ8s6lAVX/XngDMOFD0Eril3rPRK3Bj5rHfCINweVumhLOYjcyVKcbqMzdB0vY3kpV+qCpIGPwf2rmahJfH3ZxZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920528; c=relaxed/simple;
	bh=+EPF5mznJmrC7tQ1+mB5YDqe5A7S+z/bQ3hMNMfSfkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8Cxwd4iNoSVmbf/XvfdJG0aUMGgo+VmKDv6hBLuNrSggV8t2uZ2NVdG/2tLHyMaKa3eAKiDY8qrGEN0SSjN6khlIruv6Jfo+A8oeM2ujL+9FmdLdksHON6OwzSz2ePCpZjo83AhsLpK4Zr8BZOd0WnGxvgsE2otgY7TLXitpDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVNE5J+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7939EC4CED1;
	Fri,  7 Feb 2025 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738920528;
	bh=+EPF5mznJmrC7tQ1+mB5YDqe5A7S+z/bQ3hMNMfSfkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVNE5J+efqZnqXRx0F6IS3jYzidEto/Q1Rhob1iibFiu0QHipsrA5LFJYvZnJ6nwp
	 oXmIsfBKfJiq00/CBlUHNGmj9gWBnn3qyOhGT3UyWijOaaeeiQ4Lf/VKFlt1OblFal
	 qpo7g2vmzHBg4vmnmUOvAMcYXwt+sy5/O4TgC3DPMPkX4BPMQX/nnusJQed5qn1IJh
	 Z5gc9BEz16y7Fzxdsnf1ZfZA77UE5HfWad7kZ0E9bFpYQI7RvV2dpiog/ZFEMozz/r
	 4zEZU+LloNAJ/D9offiMDzE3635vqWJml5msUinKsTOLPXAXuvhJ45ENDYRvCaYpE2
	 adbPBfwXjA5dw==
Date: Fri, 7 Feb 2025 10:28:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	ychuang3@nuvoton.com, schung@nuvoton.com, cwweng@nuvoton.com, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
Message-ID: <c4x3spvvlxmrfypfbl57pki2akwf4rmooufw26w5ku7rwurjw4@gwtae2pqrutk>
References: <20241206085501.2623772-1-cwweng.linux@gmail.com>
 <20241206085501.2623772-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mgcvn6assk5gfnns"
Content-Disposition: inline
In-Reply-To: <20241206085501.2623772-3-cwweng.linux@gmail.com>


--mgcvn6assk5gfnns
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
MIME-Version: 1.0

Hello,

On Fri, Dec 06, 2024 at 04:55:01PM +0800, Chi-Wen Weng wrote:
> [...]
> diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
> new file mode 100644
> index 000000000000..380f17b20a3d
> --- /dev/null
> +++ b/drivers/pwm/pwm-ma35d1.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the Nuvoton MA35D1 PWM controller
> + *
> + * Copyright (C) 2024 Nuvoton Corporation
> + *               Chi-Wen Weng <cwweng@nuvoton.com>

Please add some information here about the hardware. The idea is to get
some info about the device's capabilities. Please stick to the format
that many other drivers are using such that

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/pwm-ma35d1.c

emits the info for your driver. Things to mention are: possible glitches
during .apply(); behaviour of the pin when the PWM is disabled (constant
signal? High-Z?)

Also a link to a reference manual would be awesome.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +/* The following are registers address offset for MA35D1 PWM controller =
*/
> +#define MA35D1_REG_PWM_CTL0            (0x00)
> +#define MA35D1_REG_PWM_CNTEN           (0x20)
> +#define MA35D1_REG_PWM_PERIOD0         (0x30)
> +#define MA35D1_REG_PWM_CMPDAT0         (0x50)
> +#define MA35D1_REG_PWM_WGCTL0          (0xB0)
> +#define MA35D1_REG_PWM_POLCTL          (0xD4)
> +#define MA35D1_REG_PWM_POEN            (0xD8)
> +
> +/* The following are register address of MA35D1 PWM controller */
> +#define MA35D1_PWM_CH_REG_SIZE         4
> +#define MA35D1_PWM_CMPDAT0_ADDR(base, ch)     ((base) + MA35D1_REG_PWM_C=
MPDAT0 + \
> +					       ((ch) * MA35D1_PWM_CH_REG_SIZE))
> +#define MA35D1_PWM_CNTEN_ADDR(base)           ((base) + MA35D1_REG_PWM_C=
NTEN)
> +#define MA35D1_PWM_PERIOD0_ADDR(base, ch)     ((base) + MA35D1_REG_PWM_P=
ERIOD0 + \
> +					       ((ch) * MA35D1_PWM_CH_REG_SIZE))
> +#define MA35D1_PWM_POEN_ADDR(base)            ((base) + MA35D1_REG_PWM_P=
OEN)
> +#define MA35D1_PWM_POLCTL_ADDR(base)          ((base) + MA35D1_REG_PWM_P=
OLCTL)

I would drop the base part in these defines and add them to the above
list sorted by address.

So something like:

#define MA35D1_REG_PWM_CTL0		0x00
#define MA35D1_REG_PWM_CNTEN		0x20
#define MA35D1_REG_PWM_PERIOD(ch)	(0x30 + 4 * (ch))
#define MA35D1_REG_PWM_CMPDAT(ch)	(0x50 + 4 * (ch))
#define MA35D1_REG_PWM_WGCTL0		0xB0
#define MA35D1_REG_PWM_POLCTL		0xD4
#define MA35D1_REG_PWM_POEN		0xD8

To make up for the missing base, I'd create wrappers for readl and
writel =E0 la:

	static u32 nuvoton_pwm_readl(struct nuvoton_pwm *nvtpwm, unsigned int offs=
et);
	static void nuvoton_pwm_writel(struct nuvoton_pwm *nvtpwm, unsigned int of=
fset, u32 value);

As you see I wouldn't use a define for 4, because IMHO that hurts
readability. But I don't feel strong here.


> +#define MA35D1_PWM_MAX_COUNT           0xFFFF
> +#define MA35D1_PWM_TOTAL_CHANNELS      6

s/TOTAL/NUM/

> +
> +struct nuvoton_pwm {
> +	void __iomem *base;
> +	u64 clkrate;

clk_get_rate() returns an unsigned long value. Please stick to that for
=2Eclkrate as there is no use to double the size of this struct on 32-bit
platforms just to store zeros and padding.

> +};
> +
> +static inline struct nuvoton_pwm *to_nuvoton_pwm(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}

I slightly prefer nuvoton_pwm_from_chip() for this function's name to
have the same function prefix for all functions here.

> +
> +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct nuvoton_pwm *nvtpwm;
> +	u32 ch =3D pwm->hwpwm;
> +
> +	nvtpwm =3D to_nuvoton_pwm(chip);
> +	if (state->enabled) {
> +		u64 duty_cycles, period_cycles;
> +
> +		/* Calculate the duty and period cycles */
> +		duty_cycles =3D mul_u64_u64_div_u64(nvtpwm->clkrate,
> +						  state->duty_cycle, NSEC_PER_SEC);
> +		if (duty_cycles > MA35D1_PWM_MAX_COUNT)
> +			duty_cycles =3D MA35D1_PWM_MAX_COUNT;
> +
> +		period_cycles =3D mul_u64_u64_div_u64(nvtpwm->clkrate,
> +						    state->period, NSEC_PER_SEC);
> +		if (period_cycles > MA35D1_PWM_MAX_COUNT)
> +			period_cycles =3D MA35D1_PWM_MAX_COUNT;
> +
> +		/* Write the duty and period cycles to registers */
> +		writel(duty_cycles, MA35D1_PWM_CMPDAT0_ADDR(nvtpwm->base, ch));
> +		writel(period_cycles, MA35D1_PWM_PERIOD0_ADDR(nvtpwm->base, ch));
> +		/* Enable counter */
> +		writel(readl(MA35D1_PWM_CNTEN_ADDR(nvtpwm->base)) | BIT(ch),
> +		       MA35D1_PWM_CNTEN_ADDR(nvtpwm->base));
> +		/* Enable output */
> +		writel(readl(MA35D1_PWM_POEN_ADDR(nvtpwm->base)) | BIT(ch),
> +		       MA35D1_PWM_POEN_ADDR(nvtpwm->base));

Can this result in glitches? E.g. is it possible to see a waveform with
the old period_cycles but the new duty_cycles output? If you switch
polarity, do you see the new settings with the wrong polarity for some
time? Setup polarity before enabling the counter and output? Maybe only
enable the counter when the output is enabled to be sure to emit the
first edge with the correct timing?

> +	} else {
> +		/* Disable counter */
> +		writel(readl(MA35D1_PWM_CNTEN_ADDR(nvtpwm->base)) & ~BIT(ch),
> +		       MA35D1_PWM_CNTEN_ADDR(nvtpwm->base));
> +		/* Disable output */
> +		writel(readl(MA35D1_PWM_POEN_ADDR(nvtpwm->base)) & ~BIT(ch),
> +		       MA35D1_PWM_POEN_ADDR(nvtpwm->base));

Maybe add another wrapper for this kind of rmw operation. Also I suggest
to introduce a name for BIT(ch) here such that this can become:

	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POEN, MA35D1_REG_PWM_POEN_EN(ch), 0=
);

(Assuming "EN0" is the name of the bit for channel 0 in
MA35D1_REG_PWM_POEN.)

> +	}
> +
> +	/* Set polarity state to register */
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		writel(readl(MA35D1_PWM_POLCTL_ADDR(nvtpwm->base)) & ~BIT(ch),
> +		       MA35D1_PWM_POLCTL_ADDR(nvtpwm->base));
> +	else
> +		writel(readl(MA35D1_PWM_POLCTL_ADDR(nvtpwm->base)) | BIT(ch),
> +		       MA35D1_PWM_POLCTL_ADDR(nvtpwm->base));

You can skip setting up period if !state->enabled.

> +	return 0;
> +}
> +
> [...]
> +
> +static int nuvoton_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip;
> +	struct nuvoton_pwm *nvtpwm;
> +	struct clk *clk;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, MA35D1_PWM_TOTAL_CHANNELS, size=
of(*nvtpwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	nvtpwm =3D to_nuvoton_pwm(chip);
> +
> +	nvtpwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(nvtpwm->base))
> +		return PTR_ERR(nvtpwm->base);
> +
> +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the cloc=
k");

Please start all error messages with a capital letter and end them with
\n.

devm_clk_rate_exclusive_get(&pdev->dev, clk) here please.

> +
> +	nvtpwm->clkrate =3D clk_get_rate(clk);
> +	if (nvtpwm->clkrate > NSEC_PER_SEC)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");

	return dev_err_probe(&pdev->dev, -EINVAL, "PWM clock out of range (%lu)\n"=
, nvtpwm->clkrate);

> +
> +	chip->ops =3D &nuvoton_pwm_ops;
> +	chip->atomic =3D true;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
> +
> +	return 0;
> +}

Best regards
Uwe

--mgcvn6assk5gfnns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmel0koACgkQj4D7WH0S
/k6B5QgAkmPrpVBwtHRJq4G/GPLPBrDSVyo5xEcvkJ34aTw/6pfgW0tguGSbmD+5
jjDrETkuUGwdZP0IPgNGbJJkxc+/Mit8/i5hX6+iTU/b1+63F+SUh74LEg5Ddrl+
YTVNye+pDGmyJ+cMM26NwmLSkpLarvkZlj0XTgKZRDCnjm/dR4n8JMrFrklfv0HB
v6aLFR2dP57ofb09zndyEHLYdqnDNt1+KaMUuZNn0gnTxhLGAvdde6ZmqrQnQYlO
LRPfTGVp7i9i9hKpxm6d1v+RIPh455t0EO9D/Z85c5TZeA4cm1OrPkllM61femRu
LBTcRK6jkZ7CJJFACoxQKCWAh8Kc+g==
=KmnS
-----END PGP SIGNATURE-----

--mgcvn6assk5gfnns--

