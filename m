Return-Path: <linux-pwm+bounces-5304-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48895A74E2B
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC1F1890C01
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661911D6DA9;
	Fri, 28 Mar 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEQxsreR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392451B4257;
	Fri, 28 Mar 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177371; cv=none; b=US907SRDwf3cYZnOiWHGARZRd/I/kTfCKfIC0+rXVqifhOciP83+8IST1deAUNMYeFpjf6L0oh9Kn50H/ZahfUqeIPli4ucYMoXMppt3eZvkaOSiazgHdp/Nbn+89k/te4dLovYx+aNzsHuwgejRFtXZbiEFTiE1MiodkLVXiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177371; c=relaxed/simple;
	bh=uPBY5mtiiUGVSgn35z27L0z9pDPMwFjJGtg+FgFgDf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEWR6cS5J2i+juheMfSqLSGP39tCG5J0kAapwHBIkL/vSYzl7ArAAIWe01sJu8ko1rhpyVWFX84VEAtJRpV022TLZgLPnjbs+zNTktrWcHbplNPMhoy7JPBH0rtrdqk21k4z32nF/Neepzqjezb15CJTRSUCNJ2WEbgQcaRLh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEQxsreR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A05DC4CEE4;
	Fri, 28 Mar 2025 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743177371;
	bh=uPBY5mtiiUGVSgn35z27L0z9pDPMwFjJGtg+FgFgDf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEQxsreR8BjRZbTDqOMxolNCUeFglnjKq1Xq9xgs6OTaCLjvDYs2patG0BOtyJkh/
	 5GzfxS/wMUvFmM01SeOt+l+UYav3caV8xuMj9qbzB/K83BDsHiUAL49L38PjtxObw8
	 cuJc4mm4qDoi2Ux7w89jKp61GuyxOwI/PqnhzyWBTaCrm0MvDN0x3GRCuZdAQXyzz4
	 1+TwDHjCziEwHhzKe6pWSwlIaPHzEVht/fyMspt7Y6nFQ7iPK26TIHhIsIsjCkEfuz
	 WOzRBLgUD+JrrayI5KQR60M4QYkUP6ulerPpAHCrlssLRLqxst4E3r3YEi97xe+P6D
	 G1DeAfgzE+NLQ==
Date: Fri, 28 Mar 2025 16:56:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 2/2] pwm: Add Loongson PWM controller support
Message-ID: <pepegljg5ua2ytozj7wamrzncsrb44i3gtcyk4bouh4rrnla34@4keshxpy5dqo>
References: <cover.1739784071.git.zhoubinbin@loongson.cn>
 <60d549be4dc099fbbd18d2539969c0329c794f2e.1739784071.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jo3irdqiccjlkr46"
Content-Disposition: inline
In-Reply-To: <60d549be4dc099fbbd18d2539969c0329c794f2e.1739784071.git.zhoubinbin@loongson.cn>


--jo3irdqiccjlkr46
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v9 2/2] pwm: Add Loongson PWM controller support
MIME-Version: 1.0

Hello,

I found a few minor things and hope we're done in the next iteration.

On Mon, Feb 17, 2025 at 05:30:25PM +0800, Binbin Zhou wrote:
> + * Limitations:
> + * - If both DUTY and PERIOD are set to 0, the output is a constant low signal.
> + * - When disabled the output is driven to 0 independent of the configured
> + *   polarity.

Does the hardware complete the currently running period when changing
settings or disabling? (No need to answer here, put the answer into the
comment.)

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

I really like it when the register name is a prefix of the register
field definitions. So maybe add _REG to the latter?

> +/* default input clk frequency for the ACPI case */
> +#define LOONGSON_PWM_FREQ_DEFAULT	50000 /* Hz */
> +
> +struct pwm_loongson_ddata {
> +	struct clk *clk;
> +	void __iomem *base;
> +	u64 clk_rate;
> +};
> +
> +static inline struct pwm_loongson_ddata *to_pwm_loongson_ddata(struct pwm_chip *chip)

I didn't try to compile the driver, but given that you call
to_pwm_loongson_ddata() several times in .apply() it might be worth to
mark this function as __pure.

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
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
> +
> +	period = min(state->period, NSEC_PER_SEC);
> +	duty_cycle = min(state->duty_cycle, NSEC_PER_SEC);

Why is this done? My guess is this is to guarantee that

	mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC)

results in a value that fits into an u32, but that only works if
ddata->clk_rate <= U32_MAX.

The approach that other drivers handle that is asserting in probe that
ddata->clk_rate <= NSEC_PER_SEC and then in .apply() do:

	period = mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
	if (period > U32_MAX)
		period = U32_MAX;

> +	ret = pwm_loongson_config(chip, pwm, duty_cycle, period);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled && state->enabled)
> +		ret = pwm_loongson_enable(chip, pwm);
> +
> +	return ret;
> +}

Best regards
Uwe

--jo3irdqiccjlkr46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfmxpUACgkQj4D7WH0S
/k79tgf/QyIr23cSUBMyrpKxGsaTQHFflpsg+AdEwz2ZcGI3Y8y28kGksMSociWM
dz8ztMr8rHYpuVs6OPco18AZvKwemuf4QJSBThv44/gKGyQrj31oOhMVnMU6QNQq
Y4TX9CwAjd3j/kt+M+rAoyJjsXwUI2qpSG1G2m40E6KCTb9QsGGFHJWeUwmyBk8q
dRmS1FP94XHEm5fNjhNpQwK3OOtBsrSfmd8hgXOu5gDVNHGySirPj8/p6kO93D1h
eiiTRlNqZb12rSsCRxySnY385U6KC8bHQngG6TiqCiBGuI/ZU/pd8oEb8Jt8B3gb
JNZwTfAEL0braGn8fnyncgc3/yb0iA==
=tVd6
-----END PGP SIGNATURE-----

--jo3irdqiccjlkr46--

