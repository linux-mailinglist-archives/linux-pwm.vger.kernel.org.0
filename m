Return-Path: <linux-pwm+bounces-4838-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4CA2F6F9
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 19:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0740818849C2
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D152255E56;
	Mon, 10 Feb 2025 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyGdi/SU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C424FC1E;
	Mon, 10 Feb 2025 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211982; cv=none; b=d/3fNONHklfLOUP6hT0IcoebRW3dU64YaZmY97tWj3kUVo8LiP1qeOQodJbjY+tlmfd9GT8SqDmsY0bjCbmscJ0n072y6/J1BpJPMpBAm9eyz8z6DV6c3CUP5TQnwghhLQRLtCSWdtOOMZnkL5fF3edVwlSSWrTLp6dH8C09b2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211982; c=relaxed/simple;
	bh=KYA157cXuPg/uZsD/Ib5SyS/u9UnH0ICnODpj1K3Gig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDyO73XUu+/CKFYTY+DCXKo8vTvaTRKfQS31wAMbboVSBl0q0V8H55OlyLhvzoMjAY63hO6r9o+kZsj5ZiDum+aqYsEemaCeIgZt+8S/LT9YC4Sl2pUs/7vFipeyvlkA7r8J7dCiUa1tKSQvbrd8vvUkL8Diour1FaUDkQaMcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyGdi/SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76503C4CED1;
	Mon, 10 Feb 2025 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739211981;
	bh=KYA157cXuPg/uZsD/Ib5SyS/u9UnH0ICnODpj1K3Gig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyGdi/SUdTXUEHLznoDzl2JFJWlQzVvFWLI6MgKYHNZsvIy3tQO4lV66WABpnzQ6q
	 PAvFX0xzvmkEVL7uIuTUNJ6Y9VFIvrLdgR/wmaCHe7g9Yj/aCOIy8AJSxUuHlUgS8i
	 LByB6vWVth1ee6J8OzBkUBQejnFVFukvoTOu/vGC46GUAzTMxJvRmt1LysGobg/ohC
	 LVSTjhJZ5Cvcncmy+1flicb0OGt5RRSeIbNNvAc+97HmMQTN8NL1XBgiGFX5G6QD0L
	 QnOSNs+y/5KifZdQ7yKyGErlqHzQZvHcmzDLWbDo+tW+DT5cUIsGklCacl0B8Pz9p7
	 vVA4T2gxEgouQ==
Date: Mon, 10 Feb 2025 19:26:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v8 2/2] pwm: Add Loongson PWM controller support
Message-ID: <obegtfup7f6w6erh4arubk2fkk2wrcum5frs5kbqa4uniexmr5@6uti3d3hv7np>
References: <cover.1733823417.git.zhoubinbin@loongson.cn>
 <be76165d1ab09ec41cdfd4e5fbdae1b415f516b9.1733823417.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y3cmthzzyib5n4wh"
Content-Disposition: inline
In-Reply-To: <be76165d1ab09ec41cdfd4e5fbdae1b415f516b9.1733823417.git.zhoubinbin@loongson.cn>


--y3cmthzzyib5n4wh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v8 2/2] pwm: Add Loongson PWM controller support
MIME-Version: 1.0

Hello Binbin,

On Tue, Dec 10, 2024 at 08:37:06PM +0800, Binbin Zhou wrote:
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
> +	ddata->clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(ddata->clk))
> +		return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +				     "failed to get pwm clock\n");
> +	if (ddata->clk) {
> +		ret = devm_clk_rate_exclusive_get(dev, ddata->clk);
> +		if (ret)
> +			return ret;

Error message please. Also please make all errors start with a capital
letter.

> +		ddata->clk_rate = clk_get_rate(ddata->clk);
> +	} else {
> +		ddata->clk_rate = LOONGSON_PWM_FREQ_DEFAULT;
> +	}
> +
> +	/* Explicitly initialize the CTRL register */
> +	pwm_loongson_writel(ddata, 0, LOONGSON_PWM_REG_CTRL);

This disables all outputs, right? Ideally the driver takes over running
channels. Consider the bootloader initialized a display with a splash
screen. Disabling the PWM might disable the backlight of the display
which hurts the visual experience.

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
> +
> +static int pwm_loongson_suspend(struct device *dev)
> +{
> +	struct pwm_chip *chip = dev_get_drvdata(dev);
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	ddata->lss.ctrl = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +	ddata->lss.duty = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> +	ddata->lss.period = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> +
> +	clk_disable_unprepare(ddata->clk);
> +
> +	return 0;

Is this needed assuming that before suspend the consumer stopped the
PWM?

Best regards
Uwe


--y3cmthzzyib5n4wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeqRMgACgkQj4D7WH0S
/k5x6wf+OuES4/l5RbIfHcNQ684TqDXxIdsHM+HZKcA4pf7ti4aRWHLgtm4fSo8s
hfbiJO07oXAJ4ZzObO6NW99tK9ixfPTfGSTTsWNfm4eogI04gHSwvj9muvcKFFqH
QlrM324KhBuXTY0WnTTEUBxfEtYY+uN1csy8kFb5OjLbfE8l70Ow/6B7BvemWphp
HN0mn3tCD4PEIZtOAW8ic54WDk9x0CxQicZ8YdYFO/VlcxwEM+ohTMLWdoITjkZX
Pf92e5Q+cNhKGJ8zUErMEgl78Ul+HKQWv/qqCiX7j2k8OGavMed0ww1ExHm87V5o
qEr5uvKwqsDZ75UjpdRaCSbnE0OJQg==
=7aZk
-----END PGP SIGNATURE-----

--y3cmthzzyib5n4wh--

