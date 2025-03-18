Return-Path: <linux-pwm+bounces-5218-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB40A671A8
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 11:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8365169EF0
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA00209677;
	Tue, 18 Mar 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyvWVTBM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF6208965;
	Tue, 18 Mar 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294514; cv=none; b=OcMoAZ+RsadJ9Xs91ZauC9I3Ed6KwcIuJwZOwsR+HgR/yFjmtdN5n2GsiVmQjCD55CunBhNMQMTntX4LvUT3Ekbz7CeRw8P+Hg0i73aOiCu6pWlUbgOfG18jCff68ItBFR1ekIdfIgMpyBzdR8KMTP9KJ5tLdNMrTrceYI42vWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294514; c=relaxed/simple;
	bh=F3U7JBvRhkVAMoGVEIf2ATNKSdaAzOsRkbvpAszIols=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko8iukbRI+2yH7Cy+WX0PsxK9rS68929b4sc9p028zGkNf9RHYwEnzUk3402IE4zpTWqilPPdw6i5SKnD26PILkqEpFzhLfZ0mTVJd/Adn6dfQUo9xBhmYFqlnQ65BX6q4lIu69CfQ7UgGd/NUM7ftqPRCYLza8nAyZtFEZOk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyvWVTBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABBBC4CEE3;
	Tue, 18 Mar 2025 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294514;
	bh=F3U7JBvRhkVAMoGVEIf2ATNKSdaAzOsRkbvpAszIols=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyvWVTBMkFi/5JqiRX1gM24IaO7Mhlnb5lISZ5JRXtLznhhDkvZQg5hb0HfQ1JGIu
	 iFHR6P+2/bWpw3iZCWav/avfcqk/9vUz/mQ8cIvLBF/J0D1iUhDu0pJ1qPpguKopWp
	 foFF468CjAUpcMnUm0hXHNE/5xHcgYrljH2wO0nVS6xWts5gWicbVqUfCbu1qzBpHw
	 XCvhkuMB0sh89kF9BlWQPEq8fqtNgGsi1zyJ/LXERmchB8W1pPrfJ59CpWhj9MsMsc
	 6Fd4iBwrZwT02wAK5zB5o9eDpKnY1670TkgGQBxV0a72rzc4UzXa2IdqRj/40WVds+
	 oDOgi6aFftTeQ==
Date: Tue, 18 Mar 2025 11:41:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
Message-ID: <mfn4db4kphb5p5e7uqjgm6wk3e63njq46sxcy5ithss5ssenhh@m7aixz6xlrwm>
References: <20250106103540.10079-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qfssaoquugbs4fig"
Content-Disposition: inline
In-Reply-To: <20250106103540.10079-1-william.qiu@starfivetech.com>


--qfssaoquugbs4fig
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
MIME-Version: 1.0

Hello,

On Mon, Jan 06, 2025 at 06:35:40PM +0800, William Qiu wrote:
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..bc957830017f
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OpenCores PWM Driver
> + *
> + * https://opencores.org/projects/ptc
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + *
> + * Limitations:
> + * - The hardware only supports inverted polarity.
> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock freq=
uency).
> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb cloc=
k frequency).
> + * - The output is set to a low level immediately when disabled.
> + * - When configuration changes are done, they get active immediately wi=
thout resetting
> + *   the counter. This might result in one period affected by both old a=
nd new settings.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +/* OpenCores Register offsets */
> +#define REG_OCPWM_CNTR    0x0
> +#define REG_OCPWM_HRC     0x4
> +#define REG_OCPWM_LRC     0x8
> +#define REG_OCPWM_CTRL    0xC
> +
> +/* OCPWM_CTRL register bits*/
> +#define REG_OCPWM_CNTR_EN      BIT(0)
> +#define REG_OCPWM_CNTR_ECLK    BIT(1)
> +#define REG_OCPWM_CNTR_NEC     BIT(2)
> +#define REG_OCPWM_CNTR_OE      BIT(3)
> +#define REG_OCPWM_CNTR_SIGNLE  BIT(4)
> +#define REG_OCPWM_CNTR_INTE    BIT(5)
> +#define REG_OCPWM_CNTR_INT     BIT(6)
> +#define REG_OCPWM_CNTR_RST     BIT(7)
> +#define REG_OCPWM_CNTR_CAPTE   BIT(8)

I'm confused here. These register bits are used for REG_OCPWM_CTRL in
the code below. So their name is wrong and they all should change
s/CNTR/CTRL/? What is REG_OCPWM_CNTR which isn't used at all?

> +struct ocores_pwm_data {
> +	void __iomem *(*get_ch_base)(void __iomem *base, unsigned int channel);
> +};
> +
> +struct ocores_pwm_device {
> +	const struct ocores_pwm_data *data;
> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +static inline u32 ocores_pwm_readl(struct ocores_pwm_device *ddata,
> +				   unsigned int channel,
> +				   unsigned int offset)
> +{
> +	void __iomem *base =3D ddata->data->get_ch_base ?
> +			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;

I suggest s/base/channel_base/

> +
> +	return readl(base + offset);
> +}
> +
> +static inline void ocores_pwm_writel(struct ocores_pwm_device *ddata,
> +				     unsigned int channel,
> +				     unsigned int offset, u32 val)
> +{
> +	void __iomem *base =3D ddata->data->get_ch_base ?
> +			     ddata->data->get_ch_base(ddata->regs, channel) : ddata->regs;
> +
> +	writel(val, base + offset);

So without a get_ch_base() function the register address is independent
=66rom the channel. That's wrong isn't it? (Or alternatively
opencores,pwm-v1 should only support a single channel.)

> +}
> +
> +static inline struct ocores_pwm_device *chip_to_ocores(struct pwm_chip *=
chip)

Please rename this to also share the ocores_pwm_ prefix all other
functions use. ocores_pwm_from_chip() would be the usual choice.

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static void __iomem *ocores_pwm_get_ch_base(void __iomem *base,
> +					    unsigned int channel)
> +{
> +	unsigned int offset =3D (channel & 4) << 13 | (channel & 3) << 4;
> +
> +	return base + offset;

I suggest s/offset/channel_offset/ in this function to differentiate it
=66rom offset in the sense ocores_pwm_writel() uses.

With that strange register layout I wonder if that are really two
different cores with 4 channels each?

> +}
> +
> +static int ocores_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata =3D chip_to_ocores(chip);
> +	u32 period_data, duty_data, ctrl_data;
> +
> +	period_data =3D ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_LRC);
> +	duty_data =3D ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_HRC);
> +	ctrl_data =3D ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
> +
> +	state->period =3D DIV_ROUND_UP_ULL((u64)period_data * NSEC_PER_SEC, dda=
ta->clk_rate);
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)duty_data * NSEC_PER_SEC, d=
data->clk_rate);
> +	state->polarity =3D PWM_POLARITY_INVERSED;

That looks strange. From the register names I would expect that LRC
holds the low time and HRC holds the high time?

> +	state->enabled =3D (ctrl_data & REG_OCPWM_CNTR_EN) ? true : false;
> +
> +	return 0;
> +}
> +
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata =3D chip_to_ocores(chip);
> +	u32 ctrl_data =3D 0;
> +	u64 period_data, duty_data;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	period_data =3D mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PE=
R_SEC);
> +	if (!period_data)
> +		return -EINVAL;
> +
> +	if (period_data > U32_MAX)
> +		period_data =3D U32_MAX;
> +
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_LRC, period_data);
> +
> +	duty_data =3D mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_=
PER_SEC);
> +	if (duty_data > U32_MAX)
> +		duty_data =3D U32_MAX;
> +
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, duty_data);
> +
> +	ctrl_data =3D ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
> +	if (state->enabled)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data | REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE);
> +	else
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data & ~(REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE));

With REG_OCPWM_CNTR_EN and REG_OCPWM_CNTR_OE unset the values in
REG_OCPWM_LRC and REG_OCPWM_HRC don't matter, right? If so, you can skip
the calculations and register writes in the !state->enabled case.

What is the semantic of REG_OCPWM_CNTR_OE? If it's "output enable" the
claim "The output is set to a low level immediately when disabled."
sounds wrong in general.

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ocores_pwm_ops =3D {
> +	.get_state =3D ocores_pwm_get_state,
> +	.apply =3D ocores_pwm_apply,
> +};
> +
> +static const struct ocores_pwm_data starfive_pwm_data =3D {
> +	.get_ch_base =3D ocores_pwm_get_ch_base,
> +};
> +
> +static const struct of_device_id ocores_pwm_of_match[] =3D {
> +	{ .compatible =3D "opencores,pwm-v1" },
> +	{ .compatible =3D "starfive,jh7100-pwm", .data =3D &starfive_pwm_data},
> +	{ .compatible =3D "starfive,jh7110-pwm", .data =3D &starfive_pwm_data},

Is there a difference between starfive,jh7100-pwm and
starfive,jh7110-pwm?

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ocores_pwm_of_match);
> +
> +static void ocores_pwm_reset_control_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return -ENOMEM;
> +
> +	ddata =3D chip_to_ocores(chip);
> +	ddata->data =3D device_get_match_data(&pdev->dev);
> +	chip->ops =3D &ocores_pwm_ops;
> +
> +	ddata->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Failed to map IO resources\n");
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to get pwm's clock\n");
> +
> +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to lock clock rate\n");
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				     "Failed to get pwm's reset\n");
> +
> +	ret =3D reset_control_deassert(rst);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert pwm's reset\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, =
rst);
> +	if (ret) {
> +		dev_err(dev, "Failed to register assert devm action\n");
> +		return ret;
> +	}

This can be simplified in the meantime. Just use
devm_reset_control_get_optional_exclusive_deasserted().

> +	ddata->clk_rate =3D clk_get_rate(clk);
> +	if (ddata->clk_rate > NSEC_PER_SEC) {

clk_get_rate() returns an unsigned long but ddata->clk_rate is only a
u32, so you might miss that the clockrate is bigger than NSEC_PER_SEC.

> +		dev_err(dev, "Failed to get clock frequency\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--qfssaoquugbs4fig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfZTe0ACgkQj4D7WH0S
/k60kggAoYMWfjCewPLMqE9I0CB5h8XrnZQFUCCjzHh9vf9Cp5rLpW3rpGbLHtVT
OAe+1lmr7Ai9u4n2Q6LC951ABiGCpY/978hMnbYq6Uq3tSFtBrA4vZ/E+n/ppAzp
64APBNPNJ72GxMmmFtODVSgOS5Lcfx5lF6qRSO5aJPRf2RFGKlCkMpToaC3vXiZ0
1nNO5F1gjsEGFlaTf7G6fwITIAvRS4g+G/C21kXIOsGN+9ytb8bBzmZzlkFVFrvI
Q/xNRgV83PNJjBRN6JPRhRFCSoWQzpXJPUVvVo7yPdI9MImTzpG3yW/1F+qrMGa2
toT0HjSbQQzZhS8OVB33/pmPnDtdIw==
=x+jw
-----END PGP SIGNATURE-----

--qfssaoquugbs4fig--

