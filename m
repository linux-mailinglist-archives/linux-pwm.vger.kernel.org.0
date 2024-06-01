Return-Path: <linux-pwm+bounces-2312-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B118D6F69
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2024 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188071C20EF4
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2024 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F614EC46;
	Sat,  1 Jun 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR+osAes"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDD208A4;
	Sat,  1 Jun 2024 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717239476; cv=none; b=Sc+rwSQJa9o9WC16H0ZJUHXqYf5hab1PMx988nN1RPuF5bRD2PR4MdzB4u1H3oqMOzfGji5OfXzivYLkJtjp5Ga/dOCtUzqWC1RwFWIsXP6pncuxDRndOG7BIlvXLWOdyvGWmusWYzUbf20sfnEvmI2Uh1Apazwxx9dvA9qjJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717239476; c=relaxed/simple;
	bh=hjI6zlGmk0XqJ+6m5c0T6h3I3gacZziDQWPru7DqbYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEC277X5vy0JuRD1jjMR7hhb0RGc80uxX3oiqxS8g2w5FttznM6EM7kEPYFoFgTsnWHxs8lckjh+008r/uCJk6l0LQgEhJOxujgaqdbSzYh3hpFido9we0LJuEt/Ib+mn5qIEHCmXJc9uBdP5whrBpW15kQP7OYEHjFH3hPla8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR+osAes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F3FC116B1;
	Sat,  1 Jun 2024 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717239475;
	bh=hjI6zlGmk0XqJ+6m5c0T6h3I3gacZziDQWPru7DqbYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR+osAesOUjdoXTTA0qTuMAr/2oy2KdpBDQgwFJoxN/XgIbvP/ljF8wah+ZfQMZCh
	 7uD+sO49jt+3tXid+1jbmovedox3WD9FVA5ZvTDWcfwFCzhBmsRFiSIApqjr/0U+P/
	 KbBhT+foqhUFl31iS/NeX2uzTvEWr18JGsJ518I1xPo+ODUBPVeRt4JL5H6XGFuFs9
	 ems+gtnk6f2XSiABMHFe3/4gIUiBRbadXG+NR4xKAgf0ErdsYLpk8hWVN90STYsmAl
	 xBpWjCD3s5nE61GhQ2Quf2mANrs3UKpIKddhLk6tjTsZ77A4Q/ngI0bBMtbF9EUZbK
	 G/ZHioj/1wBQw==
Date: Sat, 1 Jun 2024 12:57:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com, 
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2 v5] pwm: Add driver for AXI PWM generator
Message-ID: <de2trti4ilp3zw47u6qddg64ghiosvnrmknu3lkce635qushvq@qcoz3nfjuyrx>
References: <20240424125850.4189116-1-tgamblin@baylibre.com>
 <20240424125850.4189116-3-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wyvehzs256ug4w5r"
Content-Disposition: inline
In-Reply-To: <20240424125850.4189116-3-tgamblin@baylibre.com>


--wyvehzs256ug4w5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Trevor,

thanks for your patience waiting for me to come around looking at your
patch. I only found some trivial stuff to fix this time around.

On Wed, Apr 24, 2024 at 08:58:48AM -0400, Trevor Gamblin wrote:
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> new file mode 100644
> index 000000000000..e0bf90cc2ba3
> --- /dev/null
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AXI PWM generator
> + *
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 Baylibre SAS

If there is public documentation available for the device, extra points
for a link to it here.

> [...]
> +static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_MAGIC, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != AXI_PWMGEN_REG_CORE_MAGIC_VAL)
> +		return dev_err_probe(dev, -ENODEV,
> +			"failed to read expected value from register: got %08x, expected %08x\n",
> +			val,
> +			AXI_PWMGEN_REG_CORE_MAGIC_VAL);

Join these two lines, please.

> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (ADI_AXI_PCORE_VER_MAJOR(val) != 2) {
> +		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
> +			ADI_AXI_PCORE_VER_MAJOR(val),
> +			ADI_AXI_PCORE_VER_MINOR(val),
> +			ADI_AXI_PCORE_VER_PATCH(val));
> +	}
> +
> +	/* Enable the core */
> +	ret = regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Return the number of PWMs */
> +	return val;

If the AXI_PWMGEN_REG_NPWM register contains a value >= 0x80000000, the
return value is considered a negative error code. Not sure how necessary
it is to check for this case. I'll leave that to you.

> +}
> [...]
> +static int axi_pwmgen_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	struct pwm_chip *chip;
> +	struct axi_pwmgen_ddata *ddata;
> +	struct clk *clk;
> +	void __iomem *io_base;
> +	int ret;
> +
> +	io_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	regmap = devm_regmap_init_mmio(dev, io_base, &axi_pwmgen_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "failed to init register map\n");
> +
> +	ret = axi_pwmgen_setup(regmap, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip = devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata = pwmchip_get_drvdata(chip);
> +	ddata->regmap = regmap;
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +
> +	ret = devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
> +
> +	ret = devm_add_action_or_reset(dev, axi_pwmgen_clk_rate_exclusive_put, clk);
> +	if (ret)
> +		return ret;

this should be dropped as devm_clk_rate_exclusive_get() already takes
care for calling clk_rate_exclusive_put().

> +	ddata->clk_rate_hz = clk_get_rate(clk);
> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
> +
> +	chip->ops = &axi_pwmgen_pwm_ops;
> +	chip->atomic = true;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not add PWM chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--wyvehzs256ug4w5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZa/poACgkQj4D7WH0S
/k7Ccwf/XbVPD01QvCpVWIitYjlnQFA3OeXZOb78SAPUiKsNRvo4iQ+meWKOoUf8
PGXMMBuVKNkndiKXn0AIIp4XIsmXv+8J8/p2TnTrTLE1OpB6gc3TTtdp0Y8LTRDJ
mFsk+0jrGHwc5GG8OGehTKabJzUdCwJh5K3fYwsbinFob9ud52oiLDf6OPPQg8Wi
m2DE3HLo2tGCzJvaioTEipN/M0vqJpmAkg+B10cNAIBqVEPn+tQxA4/HrD5GF29c
l0YDjYj9se/IsyymwyREnm5/yEzIm6sGed+FVCowawq7P74SPBlIKtfMYEuhKJ+/
tI16LwfQxQtdQKMqIbpdyEOJu8/A/A==
=EJQa
-----END PGP SIGNATURE-----

--wyvehzs256ug4w5r--

