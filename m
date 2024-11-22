Return-Path: <linux-pwm+bounces-4120-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0599D62D6
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 18:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDC4B212BB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7B14C588;
	Fri, 22 Nov 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnn2Fsuj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108981CD3F;
	Fri, 22 Nov 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295991; cv=none; b=Zuv7Gsu6MGrpA4m12phr2qoVIKsH0Q9q9w5dIFyGOI/KYtAbREAw94u6E7LQALgPNu4f3ruvKD7GojW/l09WuCxt+TkCPLT5Tv9v1WQ03nhnX+xavQir8FiY0BzKvbPrO5WDGhIugFfEE7GSmDVDaMTTzvKadKBR3XOYrh5LRYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295991; c=relaxed/simple;
	bh=waV7+AAb5Y8M9iMdxGMu/fQy+kgyki67VfwPunud9NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1SGRO0c/HO4hyYoCHxp5zu5V15WEl8C5Eg4oSkGuOCCOhxIAlEOxELWS+jthUFl9SFWzsEuhnjKJflJnN9zC3q+/AZHaYBaXdp67urHrR/3Bc5o+CuZ/kc6odzkETaV2O0d0CNzj6TZ0TRg5+YErNA/e+5a3T7SbbT+xbMRIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnn2Fsuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16569C4CECE;
	Fri, 22 Nov 2024 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732295990;
	bh=waV7+AAb5Y8M9iMdxGMu/fQy+kgyki67VfwPunud9NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnn2FsujabL4JDddq3Wo2K6JOzWq2Dm46woRjGDzm/93AOJvQheqzkR2WnAnm/tgp
	 AUcueINnU9gfCjIxoqwuj4JEaNeByRZnRJU9qBXRfkoBvMXH7joZV08B5Z08tggI+3
	 bN/g1BTB6BbaSYZpax1gs+al8kRJWTwaDJYY+kJ1MxXa7gpxVe84rUynYCsDue8jim
	 55nfU/tEBAuMGABCbr6oXXwYHbFRjg+tArOOLQ5wZAym0g/Y+JwIK2Wfp+8He8HMU/
	 T7Y/C/vXI30E/CTabFzJjyDTbyZ4iyZhNRiQTSDcWuIBQ/v19VFCVu2a8Iv8K3C7u4
	 Game0E6FnTTHw==
Date: Fri, 22 Nov 2024 18:19:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Sean Young <sean@mess.org>
Subject: Re: [PATCH v7 2/2] pwm: Add Loongson PWM controller support
Message-ID: <6hqpifyfbr5ignvtvsz6p7hkje44xlvbdqwgq5t3ef64kufy3p@2tmp4ftiv42c>
References: <cover.1729583747.git.zhoubinbin@loongson.cn>
 <66bcb210478df5215e4e31e4f25c25194d6163ca.1729583747.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b6hccmbwih6ueur4"
Content-Disposition: inline
In-Reply-To: <66bcb210478df5215e4e31e4f25c25194d6163ca.1729583747.git.zhoubinbin@loongson.cn>


--b6hccmbwih6ueur4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 2/2] pwm: Add Loongson PWM controller support
MIME-Version: 1.0

Hello,

I now finally comne around to review your patch. Thanks for your
patience.

On Tue, Oct 22, 2024 at 05:04:15PM +0800, Binbin Zhou wrote:
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> new file mode 100644
> index 000000000000..4c9b14efadc3
> --- /dev/null
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
> + *
> + * Loongson PWM driver
> + *
> + * For Loongson's PWM IP block documentation please refer Chapter 11 of
> + * Reference Manual: https://loongson.github.io/LoongArch-Documentation/Loongson-7A1000-usermanual-EN.pdf
> + *
> + * Author: Juxin Gao <gaojuxin@loongson.cn>
> + * Further cleanup and restructuring by:
> + *         Binbin Zhou <zhoubinbin@loongson.cn>
> + *
> + * Limitations:
> + * - The buffer register value should be written before the CTRL register.

This isn't an interesting point for the high level description. I'd hope
the driver cares for this implementation detail.

> + * - When disabled the output is driven to 0 independent of the configured
> + *   polarity.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/units.h>
> +
> +/* Loongson PWM registers */
> +#define LOONGSON_PWM_REG_DUTY		0x4 /* Low Pulse Buffer Register */
> +#define LOONGSON_PWM_REG_PERIOD		0x8 /* Pulse Period Buffer Register */
> +#define LOONGSON_PWM_REG_CTRL		0xc /* Control Register */
> +
> +/* Control register bits */
> +#define LOONGSON_PWM_CTRL_EN		BIT(0)  /* Counter Enable Bit */
> +#define LOONGSON_PWM_CTRL_OE		BIT(3)  /* Pulse Output Enable Control Bit, Valid Low */
> +#define LOONGSON_PWM_CTRL_SINGLE	BIT(4)  /* Single Pulse Control Bit */
> +#define LOONGSON_PWM_CTRL_INTE		BIT(5)  /* Interrupt Enable Bit */
> +#define LOONGSON_PWM_CTRL_INT		BIT(6)  /* Interrupt Bit */
> +#define LOONGSON_PWM_CTRL_RST		BIT(7)  /* Counter Reset Bit */
> +#define LOONGSON_PWM_CTRL_CAPTE		BIT(8)  /* Measurement Pulse Enable Bit */
> +#define LOONGSON_PWM_CTRL_INVERT	BIT(9)  /* Output flip-flop Enable Bit */
> +#define LOONGSON_PWM_CTRL_DZONE		BIT(10) /* Anti-dead Zone Enable Bit */

Most of these are unused. And you only ever access the CTRL register
using read-modify-write. So I guess the behaviour of the hardware
depends on how the bootloader (or boot rom) initialized these bits. I
would prefer if you could this more deterministic.

> +#define LOONGSON_PWM_FREQ_STD		(50 * HZ_PER_KHZ)

Maybe it's just me, but I think the HZ_PER_KHZ doesn't add readability
and I would have just done:

	/* default input clk frequency for the ACPI case */
	#define LOONGSON_PWM_FREQ_DEFAULT	50000 /* Hz */

> [...]
> +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const struct pwm_state *state)
> +{
> +	int ret;
> +	u64 period, duty_cycle;
> +	bool enabled = pwm->state.enabled;
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			pwm_loongson_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	ret = pwm_loongson_set_polarity(chip, pwm, state->polarity);
> +	if (ret)
> +		return ret;

Is setting the polarity shadowed in hardware or does it take effect
immediately? If the latter please mention that the output might glitch
on reconfiguration in the Limitations section above.. Another
"opportunity" to glitch is in pwm_loongson_config() above when
LOONGSON_PWM_REG_DUTY is written but LOONGSON_PWM_REG_PERIOD isn't yet.

> +	period = min(state->period, NANOHZ_PER_HZ);
> +	duty_cycle = min(state->duty_cycle, NANOHZ_PER_HZ);

period and duty_cycle are measured in nanoseconds. So NSEC_PER_SEC is
more natural to them than NANOHZ_PER_HZ.

> +	ret = pwm_loongson_config(chip, pwm, duty_cycle, period);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled && state->enabled)
> +		ret = pwm_loongson_enable(chip, pwm);
> +
> +	return ret;
> +}
> [...]
> +static int pwm_loongson_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct pwm_chip *chip;
> +	struct pwm_loongson_ddata *ddata;
> +	struct device *dev = &pdev->dev;
> +
> +	chip = devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata = to_pwm_loongson_ddata(chip);
> +
> +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
> +
> +	if (!has_acpi_companion(dev)) {
> +		ddata->clk = devm_clk_get_enabled(dev, NULL);
> +		if (IS_ERR(ddata->clk))
> +			return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +					     "failed to get pwm clock\n");
> +		ddata->clk_rate = clk_get_rate(ddata->clk);

I guess you rely on the clockrate to not change. So please add a call to
devm_clk_rate_exclusive_get().

> +	} else {
> +		ddata->clk_rate = LOONGSON_PWM_FREQ_STD;

I thought that clk_get() also works for devices described by ACPI?

Maybe something like this gives more flexibility:

	ddata->clk = devm_clk_get_optional_enabled(dev, NULL);
	if (IS_ERR(ddata->clk))
		return dev_err_probe(...);

	if (ddata->clk) {
		ret = devm_clk_rate_exclusive_get(...);
		if (ret)
			return ret;

		ddata->clk_rate = clk_get_rate(ddata->clk);
	} else {
		ddata->clk_rate = LOONGSON_PWM_FREQ_STD;
	}

and it's conceptually easier given that it doesn't have to care about
the device being described in ACPI or dt.

Just a suggestion.

> +	}
> +
> +	chip->ops = &pwm_loongson_ops;
> +	chip->atomic = true;
> +	dev_set_drvdata(dev, chip);
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}

--b6hccmbwih6ueur4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdAvS8ACgkQj4D7WH0S
/k4Zagf+NKVWJp2/FdYvO+2gSLIpZplN7HRGHvMTNL4jYXyDA8ssDmfdIhCUbV49
YqCQCNqA2Dsd+7cRhni8/DStvoUhDbUGus/xq46Ks6rv6yvVATzLYrZUxMNofK9Z
NqilGnCVeKI4UOB0QHVlGDSioB6Pa4MdGsQtr5WIOZnQtd+OMDmymAqP7BL8SBqp
7GKCIktuIGXm9AyM4oT2FWBVH2aFnp2l7XMK5JtaVzFyyfOCidbim+QNuUblvO1Q
8zM5cTA32zksTuNz37hO8kYmnjYcqGamQyCP8SmwFSPfC1bKPAWwVFlbX57LEEgW
IZddwUrQnikQfN3uVsGM+la0jnOZrQ==
=qUi3
-----END PGP SIGNATURE-----

--b6hccmbwih6ueur4--

