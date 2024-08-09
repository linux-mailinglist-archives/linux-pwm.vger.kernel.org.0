Return-Path: <linux-pwm+bounces-2990-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B27694D01E
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCC3281ABF
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65A194085;
	Fri,  9 Aug 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hKw4ebfH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8D1DFF5;
	Fri,  9 Aug 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206475; cv=none; b=d3PprQa1vqocj8w+e4RNuaAgDLDNEXmfEYr9nQ+g2Bl4DZbNN0LkkmFpHszdcxzxP1SECxyf8ONJkWVR+h893Z1O60HSzOxdT5LMqrENXZX8fjHaMiB/o9zzqlv0BTRElHlVl3dKBXqYvIa1DlLPmy2fofHks7UgW1ZgL1N1pqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206475; c=relaxed/simple;
	bh=3RjmjMB/hmYRTU7/LPthqYuWriUANtI1u1K8Bw6+/gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWLJ/ACtiQqNZ/p1wOnt/Ax1EWS4mjztMIA6nWbMC/0kP/pu0QNHQLpfUM/pSZvUoZnNpW4YAp5Vq2lSGWx4D2R3TCFBSh4nJS1hHE0CddHFPHe+qawzOjQQlBwePGA0+k+6xCa6ohakRszE2bBc0WAuZWq3IfmTchQXCmIWe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hKw4ebfH; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id cOidsjbGZk1NHcOidsiS3j; Fri, 09 Aug 2024 14:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723206465;
	bh=pYz+m/UoyDrpjkgN1vIEkfUcQmAsdkfMxntU1Pv6358=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hKw4ebfHFA2RUuYKX23QkqdrWp/tblM61i8t9/9AIoB8yAvqDOi4M8TSNAVYYyQ4e
	 DWQduFsDXVeBx69KMfASYQ1xogjbjwU0uMjhJPcljfBu3HnQ+wpw1MfPPHTMiaKxZv
	 ZYbqxVvGWi/tLdeUhMzcNyKiC0P2c7GyRQrOR1jEEAboUe8MXiMihQW6aM2Sem84cT
	 NGu9kxwO7BYHbPmuxXB4fY1PxrR7OTfsqv/6v/kQvwDX9hAPP/gCvt/f70xhdwurPJ
	 unrzdNlOBlP6HtMe8KtYVPrGyL3m/yNNaOkGncH+c9Ym4qAYe1G+Hzf7vMXO+gdbH5
	 v+7F4oOlOeGIw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 09 Aug 2024 14:27:45 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8ea19aa8-1c01-45ce-81e1-5b34f6738ac3@wanadoo.fr>
Date: Fri, 9 Aug 2024 14:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] pwm: opencores: Add PWM driver support
To: William Qiu <william.qiu@starfivetech.com>, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Hal Feng <hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20240809103831.156436-1-william.qiu@starfivetech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240809103831.156436-1-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/08/2024 à 12:38, William Qiu a écrit :
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
> 
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---

Hi,

...

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
> +	ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_LRC, (u32)period_data);
> +
> +	duty_data = mul_u64_u32_div(state->duty_cycle, ddata->clk_rate, NSEC_PER_SEC);
> +	if (duty_data <= U32_MAX)
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);
> +	else if (duty_data > U32_MAX)
> +		duty_data = U32_MAX;
> +		ocores_pwm_writel(ddata, pwm->hwpwm, REG_OCPWM_HRC, (u32)duty_data);

I guess that some {} are missing.
BTW, does it even compile without it???

> +	else
> +		return -EINVAL;

What is the use of this else?
duty_data is either <= U32_MAX or > U32_MAX.
Or I missed something?

Maybe just simplify things and write something as done with period_data 
just a few lines above?

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

...

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
> +	id = of_match_device(ocores_pwm_of_match, dev);
> +	if (!id)
> +		return -EINVAL;
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
> +		return dev_err_probe(dev, ddata->clk_rate,

Does it work?
I would expect -EINVAL.

> +				     "Unable to get clock's rate\n");
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +
> +	return 0;
> +}

...

CJ


