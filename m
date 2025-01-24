Return-Path: <linux-pwm+bounces-4728-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE69A1B0F4
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jan 2025 08:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70711667A0
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jan 2025 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4655156991;
	Fri, 24 Jan 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzvJ1o6h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDC13AC1;
	Fri, 24 Jan 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737703853; cv=none; b=ROmKldbedcyUOnWzfH6fMn8cPdQ+1FimuwtymYxD3rbN5ur9j5JsmOwPBnb4psXiUp4AfgKbmz6ZD7IMBZ6KJItJKJ2jd5mclvKup6MKJaszfJZnov8qhBqWisjD1+Wnjz9n+A+ssLN0yqu+oLIyI6zHVBugemyBBurtfL1lvrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737703853; c=relaxed/simple;
	bh=bxadwpVVlhkiGjDnvKB0m6GNfulai9d3PWXrRu9nZUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+WU0RozzriFqQXQ+0f9SEukUeqlYN+2bEnIykuFYu7k5twh2PrUNaUcQztUd5LvoUrRbXI3KEoBemqHdveJf08vneXaWwoGkvG7vmTVY3hWfR8eirKk58KrLNaB/vgwKAD8mVIT4DtI3GnSBplPIJtGoEqJg0zCyyEDrTIdEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzvJ1o6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78543C4CEE4;
	Fri, 24 Jan 2025 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737703853;
	bh=bxadwpVVlhkiGjDnvKB0m6GNfulai9d3PWXrRu9nZUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FzvJ1o6hhT5zZIhmrUQlpFw71sdiJna7r6mWwABPG19uBr9MEE49tKPEvm6vmN6OS
	 Sjv+mrsIwEP0qfeCLI9KYa56ycnQpaNSjJUWUesfVfkTpocs56WddOXZ+f2ZPLqhQ+
	 GH1Rpig2bXttM/UtkBqFETl5pz0uIzbDgzL8ET87MhtqhhQFCqreVXVc2Y4C3VwL2h
	 B3Zr23dMGCbABiauLEI+S3OAuiV4lCZM9o3Rm3EHlSmK68uUcI3Z6EOHaTKIFo4+E+
	 ESLYThwBLD6ORea7OLSn7H+8NFYldnHP6a7z8zp749noP6rOjMGUa8gzPhuu/vs+yr
	 DLf0wSEmQcxBw==
Message-ID: <5514fa03-139e-456e-b522-6a774b52eac1@kernel.org>
Date: Fri, 24 Jan 2025 08:30:48 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/2] pwm: atcpit100: add Andes PWM driver support
To: Ben Zong-You Xie <ben717@andestech.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
References: <20250123193534.874256-1-ben717@andestech.com>
 <20250123193534.874256-3-ben717@andestech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250123193534.874256-3-ben717@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2025 20:35, Ben Zong-You Xie wrote:
>  
> +config PWM_ATCPIT100
> +	tristate "Andes ATCPIT100 PWM support"
> +	depends on OF && HAS_IOMEM
> +	depends on RISCV || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	  Generic PWM framework driver for ATCPIT100 on Andes AE350 platform


Is AE350 a type of a SoC? Looks like. "depends on RISCV" is wrong -
there is nothing RISC-V specific here. You must depend on given
SoC/platform.

> +
> +	  The ATCPIT100 Programmable Interval Timer (PIT) is a set of compact
> +	  multi-function timers, which can be used as pulse width
> +	  modulators (PWM) as well as simple timers. ATCPIT100 supports up to 4
> +	  PIT channels. Each PIT channel can be a simple timer or PWM, or a
> +	  combination of timer and PWM.
> +
> +	  To compile this driver as a module, choose M here: the module


...

> +static int atcpit100_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	int clk;
> +	int ret;
> +	unsigned int ctrl_val;
> +	unsigned int reload_val;
> +	u16 pwm_high;
> +	u16 pwm_low;
> +	unsigned int channel = pwm->hwpwm;
> +	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
> +
> +	ret = regmap_read(ap->regmap, ATCPIT100_CHANNEL_CTRL(channel),
> +			  &ctrl_val);
> +	if (ret)
> +		return ret;
> +
> +	clk = (ctrl_val & ATCPIT100_CHANNEL_CTRL_CLK) ? ATCPIT100_CLK_APB
> +						      : ATCPIT100_CLK_EXT;
> +	state->enabled =

Don't wrap here...
> +		regmap_test_bits(ap->regmap, ATCPIT100_CHANNEL_ENABLE,

but wrap at arguments.

> +				 ATCPIT100_CHANNEL_ENABLE_PWM(channel));
> +	state->polarity = PWM_POLARITY_NORMAL;
> +	ret = regmap_read(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
> +			  &reload_val);
> +	if (ret)
> +		return ret;
> +
> +	pwm_high = FIELD_GET(ATCPIT100_CHANNEL_RELOAD_HIGH, reload_val);
> +	pwm_low = FIELD_GET(ATCPIT100_CHANNEL_RELOAD_LOW, reload_val);
> +	state->duty_cycle =
> +		DIV64_U64_ROUND_UP((pwm_high + 1) * NSEC_PER_SEC,
> +				   ap->clk_rate[clk]);
> +	state->period =
> +		state->duty_cycle +
> +		DIV64_U64_ROUND_UP((pwm_low + 1) * NSEC_PER_SEC,
> +				   ap->clk_rate[clk]);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops atcpit_pwm_ops = {
> +	.apply = atcpit100_pwm_apply,
> +	.get_state = atcpit100_pwm_get_state,
> +};
> +
> +static int atcpit100_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct atcpit100_pwm *ap;
> +	struct pwm_chip *chip;
> +	void __iomem *base;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, ATCPIT100_CHANNEL_MAX, sizeof(*ap));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	ap = to_atcpit100_pwm(chip);
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ap->ext_clk = devm_clk_get_enabled(dev, "ext");
> +	ap->clk_rate[ATCPIT100_CLK_EXT] = ap->ext_clk ?
> +					  clk_get_rate(ap->ext_clk) : 0;
> +	ap->apb_clk = devm_clk_get_enabled(dev, "apb");
> +	ap->clk_rate[ATCPIT100_CLK_APB] = ap->apb_clk ?
> +					  clk_get_rate(ap->apb_clk) : 0;
> +	if (IS_ERR(ap->ext_clk) && IS_ERR(ap->apb_clk)) {

Drop {}. See Linux coding style.

> +		return dev_err_probe(dev, PTR_ERR(ap->ext_clk),
> +				     "failed to obtain any clock\n");
> +	}
> +
> +	if (ap->clk_rate[ATCPIT100_CLK_EXT] > NSEC_PER_SEC ||
> +	    ap->clk_rate[ATCPIT100_CLK_APB] > NSEC_PER_SEC)
> +		return dev_err_probe(dev, -EINVAL, "pwm clock out of range\n");
> +
> +	ap->regmap = devm_regmap_init_mmio(dev, base,
> +					   &atcpit100_pwm_regmap_config);
> +	if (IS_ERR(ap->regmap)) {

Drop {}. See Linux coding style.


> +		return dev_err_probe(dev, PTR_ERR(ap->regmap),
> +				     "failed to init register map\n");
> +	}
> +
> +	chip->ops = &atcpit_pwm_ops;
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add pwm chip\n");
> +
> +	dev_info(dev, "pwm driver probed\n");


Drop all such "success" messages.


Best regards,
Krzysztof

