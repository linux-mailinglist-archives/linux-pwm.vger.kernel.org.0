Return-Path: <linux-pwm+bounces-6444-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF3AE0879
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782873AC18B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2B2116F4;
	Thu, 19 Jun 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fud0b7Fs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968F1D6187;
	Thu, 19 Jun 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342802; cv=none; b=n1rUv8nh1s6dJCWbZDwItNNKvPelAwPbHZ8edxH9QDGWtJTWqwChprsY7wfMUcoj5+7kfzKUzQKIsGjAhaSxcyvgJGRCkRz/pjZ0jb+GB84RgTJIt/7x3AY2Ye11BMzVeaNv4c+XZuxIhkj2mFuKqCKMslvaxhZhfJ73L9qyUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342802; c=relaxed/simple;
	bh=H5+BZQf88SoLlAxFu9jt0X4tMdMAcn56sYbqSqbZaCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEwauu104hybgqwN1vJAuVugQhmlW0zBVRgI1HemJZIYfh2PCLB6bRJL3WxF0zvSIAIfxgmZqPIpT9pn6t5U6TdtMGNtPiorLjoojsQ5miePISqtcC/MQgDwotOZobx/q1VrWrOLz4WuEFwD1JtIrl947/t/G+4qWl2OS/lwljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fud0b7Fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D62C4CEEA;
	Thu, 19 Jun 2025 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750342801;
	bh=H5+BZQf88SoLlAxFu9jt0X4tMdMAcn56sYbqSqbZaCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fud0b7FsejVgRV5gn3u0v8TMuGq/HV7KrGNFhluWv0XSifzDg1WObMJW8Xgoo7hAS
	 shcSetDWqX8wQCgkplJbETkhzn33AipF8X1+nmn4fPAIGE+cYpsZD3fB3OokafC8m8
	 wLpL2NHuU1nhS4019Krctw8b4xzAUjAyAEivZ4RPpw/aLCV3ih16I5GC9syraHeSjJ
	 3xJ2iyyBrTsYxPBtpobyq6ojN5z0cKdhJwI78WutHSAIXJp17jbRvILwI4skJZl/gt
	 aCdBs7l+hh2S5l3on6nhqz0RYa/NBMSsnM0wbMQarUwYt+bCxwAEJAhkvwheRzB166
	 xls8wd2iv0x9w==
Date: Thu, 19 Jun 2025 15:19:56 +0100
From: Lee Jones <lee@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v5 06/20] mfd: adp5585: refactor how regmap defaults are
 handled
Message-ID: <20250619141956.GD795775@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250614-dev-adp5589-fw-v5-6-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250614-dev-adp5589-fw-v5-6-7e9d84906268@analog.com>

On Sat, 14 Jun 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> The only thing changing between variants is the regmap default
> registers. Hence, instead of having a regmap configuration for every
> variant (duplicating lots of fields), add a chip info type of structure
> with a regmap ID to identify which defaults to use and populate
> regmap_config at runtime given a template plus the id. Also note that
> between variants, the defaults can be the same which means the chip info
> structure can be used in more than one compatible.
> 
> This will also make it simpler adding new chips with more variants.
> 
> Also note that the chip info structures are deliberately not const as
> they will also contain lots of members that are the same between the
> different devices variants and so we will fill those at runtime.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c       | 81 +++++++++++++++++++++++----------------------
>  include/linux/mfd/adp5585.h | 11 ++++++
>  2 files changed, 53 insertions(+), 39 deletions(-)

Very close.  Couple of nits.

NB: When you next submit, could you please ensure all subject match the
style expected by the subsystem.  In the case of MFD, it's:

mfd: <driver>: Succinct subject line starting with an uppercase char

> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index c764f481875831ff55bccb8cdc59421719afbedd..ec88adbace92791f10953fc2bbb463fc59557bd6 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -81,42 +81,37 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
>  	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
>  };
>  
> -enum adp5585_regmap_type {
> -	ADP5585_REGMAP_00,
> -	ADP5585_REGMAP_02,
> -	ADP5585_REGMAP_04,
> +/* -1 since the enum starts at 1 for error checking in i2c_get_match_data() */

This comment is no longer applicable.

> +static const u8 *adp5585_regmap_defaults[ADP5585_MAX] = {
> +	[ADP5585_00] = adp5585_regmap_defaults_00,
> +	[ADP5585_01] = adp5585_regmap_defaults_00,
> +	[ADP5585_02] = adp5585_regmap_defaults_02,
> +	[ADP5585_03] = adp5585_regmap_defaults_00,
> +	[ADP5585_04] = adp5585_regmap_defaults_04,
>  };
>  
> -static const struct regmap_config adp5585_regmap_configs[] = {
> -	[ADP5585_REGMAP_00] = {
> -		.reg_bits = 8,
> -		.val_bits = 8,
> -		.max_register = ADP5585_MAX_REG,
> -		.volatile_table = &adp5585_volatile_regs,
> -		.cache_type = REGCACHE_MAPLE,
> -		.reg_defaults_raw = adp5585_regmap_defaults_00,
> -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_00),
> -	},
> -	[ADP5585_REGMAP_02] = {
> -		.reg_bits = 8,
> -		.val_bits = 8,
> -		.max_register = ADP5585_MAX_REG,
> -		.volatile_table = &adp5585_volatile_regs,
> -		.cache_type = REGCACHE_MAPLE,
> -		.reg_defaults_raw = adp5585_regmap_defaults_02,
> -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_02),
> -	},
> -	[ADP5585_REGMAP_04] = {
> -		.reg_bits = 8,
> -		.val_bits = 8,
> -		.max_register = ADP5585_MAX_REG,
> -		.volatile_table = &adp5585_volatile_regs,
> -		.cache_type = REGCACHE_MAPLE,
> -		.reg_defaults_raw = adp5585_regmap_defaults_04,
> -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
> -	},
> +static const struct regmap_config adp5585_regmap_config_template = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ADP5585_MAX_REG,
> +	.volatile_table = &adp5585_volatile_regs,
> +	.cache_type = REGCACHE_MAPLE,
> +	.num_reg_defaults_raw = ADP5585_MAX_REG + 1,
>  };
>  
> +static struct regmap_config *adp5585_fill_regmap_config(const struct adp5585_dev *adp5585)
> +{
> +	struct regmap_config *regmap_config;
> +
> +	regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
> +				     sizeof(struct regmap_config), GFP_KERNEL);

sizeof(*regmap_config)

> +	if (!regmap_config)
> +		return ERR_PTR(-ENOMEM);
> +
> +	regmap_config->reg_defaults_raw = adp5585_regmap_defaults[adp5585->variant];
> +	return regmap_config;
> +}
> +
>  static int adp5585_add_devices(struct device *dev)
>  {
>  	int ret;
> @@ -147,7 +142,7 @@ static void adp5585_osc_disable(void *data)
>  
>  static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
> -	const struct regmap_config *regmap_config;
> +	struct regmap_config *regmap_config;
>  	struct adp5585_dev *adp5585;
>  	unsigned int id;
>  	int ret;
> @@ -157,8 +152,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  		return -ENOMEM;
>  
>  	i2c_set_clientdata(i2c, adp5585);
> +	adp5585->dev = &i2c->dev;
> +
> +	adp5585->variant = (enum adp5585_variant)(uintptr_t)i2c_get_match_data(i2c);
> +	if (!adp5585->variant)
> +		return -ENODEV;
> +
> +	regmap_config = adp5585_fill_regmap_config(adp5585);
> +	if (IS_ERR(regmap_config))
> +		return PTR_ERR(regmap_config);
>  
> -	regmap_config = i2c_get_match_data(i2c);
>  	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> @@ -212,19 +215,19 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
>  static const struct of_device_id adp5585_of_match[] = {
>  	{
>  		.compatible = "adi,adp5585-00",
> -		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> +		.data = (void *)ADP5585_00,
>  	}, {
>  		.compatible = "adi,adp5585-01",
> -		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> +		.data = (void *)ADP5585_01,
>  	}, {
>  		.compatible = "adi,adp5585-02",
> -		.data = &adp5585_regmap_configs[ADP5585_REGMAP_02],
> +		.data = (void *)ADP5585_02,
>  	}, {
>  		.compatible = "adi,adp5585-03",
> -		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> +		.data = (void *)ADP5585_03,
>  	}, {
>  		.compatible = "adi,adp5585-04",
> -		.data = &adp5585_regmap_configs[ADP5585_REGMAP_04],
> +		.data = (void *)ADP5585_04,
>  	},
>  	{ /* sentinel */ }
>  };
> diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> index 016033cd68e46757aca86d21dd37025fd354b801..c56af8d8d76c4ebc0ede1ee4769ca059de29f53c 100644
> --- a/include/linux/mfd/adp5585.h
> +++ b/include/linux/mfd/adp5585.h
> @@ -119,8 +119,19 @@
>  
>  struct regmap;
>  
> +enum adp5585_variant {
> +	ADP5585_00 = 1,
> +	ADP5585_01,
> +	ADP5585_02,
> +	ADP5585_03,
> +	ADP5585_04,
> +	ADP5585_MAX
> +};
> +
>  struct adp5585_dev {
> +	struct device *dev;
>  	struct regmap *regmap;
> +	enum adp5585_variant variant;
>  };
>  
>  #endif
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

