Return-Path: <linux-pwm+bounces-4412-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FC9F8677
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 22:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2127C18963D2
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7C01B041E;
	Thu, 19 Dec 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzSC+wU9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307FE111A8;
	Thu, 19 Dec 2024 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734642000; cv=none; b=RmsY3CEwKkK9Z2h48L4C1E562b5KGx0vOFYH66G/Z+WzqGfUsmRODPXDLNg/7lWzTvQ6Wg/vC6p4NE5dN333gW3gD9B7W5tLump1uU3U2emW2f3LYLcHkfScqsdskrX0jBZHzjpCqGVrlLAx5/tkWBJv3NjyxmLeKWtGk/dwjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734642000; c=relaxed/simple;
	bh=OmYs9jX06WsV4zZE6lahFsCHxRz5ozlRYRz3Ugo0oZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsz16n7LJbmAi0qjaL0xctdUE552GnH0Gu9NW7H0HrQOHkuPDBeodgbadqkU5P5e2UTCPadGiaDU/IRXS7mdbMa8uxZPpJF+ZlSwH3Ery2WtwyDnQWh4GYU9lgjbumTTmrOXa5TPLQJP29tCwJRG83crW1wJSTsphadFJ42fm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzSC+wU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E2FC4CECE;
	Thu, 19 Dec 2024 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734641999;
	bh=OmYs9jX06WsV4zZE6lahFsCHxRz5ozlRYRz3Ugo0oZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzSC+wU93MUfuUqvOQ3W28UaLPa4OKd4fQROVgQ04oXHIrVWu8UEIJUgMEyevjIz2
	 mULrA+DBQVYAWdFHFBdpQHRCQJJulq48dhRcec8RGvZnskJn0RDGcF9OaqEN989KB1
	 uacDzZ3hrSXyyWxstgnSVqHrcf382kWn0rbKbEl1Qg1nWCuDF6NfjtzcybGhWNRQ8c
	 XuD6apZkOj0+wiXemfkBvEtqb5xWNhBVkbVzc5jNErUijvrdaAk/D3yiUDvoYCCXeb
	 9QzA0cjKiNgLgHcovl7GaFUY7NhFUKTa0rmDoslmQAG/KggmYvfejXGHQ4jmidLDcw
	 nYfP6bzdcggvQ==
Date: Thu, 19 Dec 2024 21:59:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
Message-ID: <bfwpcffdrxqjes4atio6deltu5tgmd4ing7j4yewwp6jprqmmc@rv2x3qudlzo3>
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjjnrn5zxgcw2p23"
Content-Disposition: inline
In-Reply-To: <20241028014609.153997-1-william.qiu@starfivetech.com>


--zjjnrn5zxgcw2p23
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
MIME-Version: 1.0

Hello,

On Mon, Oct 28, 2024 at 09:46:09AM +0800, William Qiu wrote:
> +static int ocores_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct ocores_pwm_device *ddata = chip_to_ocores(chip);
> +	u32 ctrl_data = 0;
> +	u64 period_data, duty_data;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	period_data = mul_u64_u32_div(state->period, ddata->clk_rate, NSEC_PER_SEC);
> +	if (!period_data)
> +		return -EINVAL;
> +
> +	if (period_data > U32_MAX)
> +		period_data = U32_MAX;
> +
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_LRC, period_data);
> +
> +	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
> +	if (!duty_data)
> +		return -EINVAL;

I can understand that period_data == 0 is an error, but duty_data == 0
could/should just work?!

> +
> +	if (duty_data > U32_MAX)
> +		duty_data = U32_MAX;
> +
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, duty_data);
> +
> +	ctrl_data = ocores_pwm_readl(ddata, pwm->hwpwm, REG_OCPWM_CTRL);
> +	if (state->enabled)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data | REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE);
> +	else
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_CTRL,
> +				  ctrl_data & ~(REG_OCPWM_CNTR_EN | REG_OCPWM_CNTR_OE));
> +
> +	return 0;
> +}
> [...]
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct device *dev = &pdev->dev;
> +	struct ocores_pwm_device *ddata;
> +	struct pwm_chip *chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	int ret;
> +
> +	id = of_device_get_match_data(&pdev->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return -ENOMEM;
> +
> +	ddata = chip_to_ocores(chip);
> +	ddata->data = id->data;
> +	chip->ops = &ocores_pwm_ops;
> +
> +	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->regs))
> +		return dev_err_probe(dev, PTR_ERR(ddata->regs),
> +				     "Unable to map IO resources\n");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	ret = devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return ret;
> +
> +	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				     "Unable to get pwm's reset\n");
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, ocores_pwm_reset_control_assert, rst);
> +	if (ret)
> +		return ret;
> +
> +	ddata->clk_rate = clk_get_rate(clk);
> +	if (ddata->clk_rate > NSEC_PER_SEC)
> +		return -EINVAL;

Missing error messages for the three checks above.

> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--zjjnrn5zxgcw2p23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdkiUoACgkQj4D7WH0S
/k7yJQgAuqmDZcXHA1TAKDXVxfpXGEbDlQ4qz/h9YCd5wU4LB6/DZffVJQyjoB+A
96E6+jGceIxhG7kOZDSjhzdRZbAB03SGHNl7YJ/HEjWmosehbgDj0mQIBdt34XT2
Si5D+EAHU3cG0BBYMjhaABNS7BUkh5fCneEe/AUQKATswoXTcW396K1PECwLNFCL
C+xpajzh8kfthI9fHciBXcxA54LOqGBdRQcG64VmzbpCWJ50tUFyU4erM8cOG5sd
YeRW2+0SujCBABqIICuJug/EU6Wo549a8IaBS3uDQN7mQ3+PJ5/Cy6yH8Tk7vcQr
VraqXpgZI+fV0VnC2gUIvJe7v/30Rg==
=BOKs
-----END PGP SIGNATURE-----

--zjjnrn5zxgcw2p23--

