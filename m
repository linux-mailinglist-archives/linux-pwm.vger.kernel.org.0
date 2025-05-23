Return-Path: <linux-pwm+bounces-6104-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1408AC25D7
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7847A444D6
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733672957A8;
	Fri, 23 May 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBCi/yQa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21324676D;
	Fri, 23 May 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012625; cv=none; b=cmh7iHODEyDn1ObH7f5xyv9QWkGLLt+sppfFbKbPjwLNggRxepYfXoi/EMoKtCz120H+YmAqQGbsm6IrnGEZVL3GYZ1wEW5YAGNBoYmkbIw0NlFSg1Z/bXWL122cnSM4SD2ep+KAu3MQfXqt2ZEcSJPGaCkvvSQwWtR2NsYclwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012625; c=relaxed/simple;
	bh=MJw+KKgK2pxJgECMpjog2FK6z1mMHZQ5Mt7f2ORl5lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h++pTaMPDyYuB/EwbVY1tjhYT+tVYgKV5y3n5Qc4puq1otAhf9YF4Cm1VkHjmumFexpXb1obrl1KqWFXkqshMtrJOyLhZebo4AGmoTLFrs1vstjdHDoErFMiTIfi2R/QnBKtavhRmDIN6YP5LeFo8xWSOKBDEZuaNlNX9WfNH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBCi/yQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B97C4CEE9;
	Fri, 23 May 2025 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012623;
	bh=MJw+KKgK2pxJgECMpjog2FK6z1mMHZQ5Mt7f2ORl5lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBCi/yQaJFOyvRTwhdox7UOolU+OfVf0zS0Gt70Dy/aadivHhsqkLqX5jQHs+Kj/k
	 fe9cQPOsxfBOWtWIXyXMbbm4taMF+EHKAznXxLcNqePj0ThTHUJDuzZcD60oaW0FRl
	 3EoGNM5c9jBpwwvWRfarbOIDXuwtbUUARwE1CPGELFXgL6UulyTQ7HQ0lN+e2cfVVq
	 5CPg6P4F2cEl+bG50bAUHocxIubNcnRNztxEjsJeJHx9Xj4Us9rA7XB4LR8fBhea5Q
	 tD847a8yf+Q6yDvNCgEpgyvG2EWWTAZQS38mKGMIY5XBDii4k8GRfUxE1J6Ixahs0b
	 FIkH5xwCcz8Sw==
Date: Fri, 23 May 2025 16:03:38 +0100
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
Subject: Re: [PATCH v4 06/20] mfd: adp5585: refactor how regmap defaults are
 handled
Message-ID: <20250523150338.GH1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-6-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-6-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> The only thing changing between variants is the regmap default
> registers. Hence, instead of having a regmap condig for every variant

Spellcheck.

> (duplicating lots of fields), add a chip info type of structure with a
> regmap id to identify which defaults to use and populate regmap_config

"ID"

> at runtime given a template plus the id. Also note that between
> variants, the defaults can be the same which means the chip info
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
>  drivers/mfd/adp5585.c       | 74 +++++++++++++++++++++------------------------
>  include/linux/mfd/adp5585.h | 10 ++++++
>  2 files changed, 44 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 179dc284833ae8f39eefc6787dd2c7158dfd3ad7..672f3468bda5be6af85a5982c3626053b4cb59bf 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -81,42 +81,31 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
>  	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
>  };
>  
> -enum adp5585_regmap_type {
> -	ADP5585_REGMAP_00,
> -	ADP5585_REGMAP_02,
> -	ADP5585_REGMAP_04,
> +/* -1 since the enum starts at 1 for error checking in i2c_get_match_data()*/

Space before the '*'.

> +static const u8 *adp5585_regmap_defaults[ADP5585_MAX - 1] = {
> +	[ADP5585_00 - 1] = adp5585_regmap_defaults_00,
> +	[ADP5585_01 - 1] = adp5585_regmap_defaults_00,
> +	[ADP5585_02 - 1] = adp5585_regmap_defaults_02,
> +	[ADP5585_03 - 1] = adp5585_regmap_defaults_00,
> +	[ADP5585_04 - 1] = adp5585_regmap_defaults_04,

Just leave the first entry blank.  No need for all he gymnastics.

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
> +static void adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
> +				       struct regmap_config *regmap_config)
> +{
> +	*regmap_config = adp5585_regmap_config_template;

Return struct regmap_config * instead.

> +	regmap_config->reg_defaults_raw = adp5585_regmap_defaults[adp5585->variant - 1];

Does this really warrant a separate function?

> +}
> +
>  static void adp5585_remove_devices(void *dev)
>  {
>  	mfd_remove_devices(dev);
> @@ -157,7 +146,7 @@ static void adp5585_osc_disable(void *data)
>  
>  static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
> -	const struct regmap_config *regmap_config;
> +	struct regmap_config regmap_config;
>  	struct adp5585_dev *adp5585;
>  	unsigned int id;
>  	int ret;
> @@ -168,8 +157,13 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  
>  	i2c_set_clientdata(i2c, adp5585);
>  
> -	regmap_config = i2c_get_match_data(i2c);
> -	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
> +	adp5585->variant = (enum adp5585_variant)(uintptr_t)i2c_get_match_data(i2c);
> +	if (!adp5585->variant)
> +		return -ENODEV;
> +
> +	adp5585_fill_regmap_config(adp5585, &regmap_config);
> +
> +	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
>  				     "Failed to initialize register map\n");
> @@ -226,19 +220,19 @@ static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
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
> index 016033cd68e46757aca86d21dd37025fd354b801..2813b20e638b6e73ef198e43af07ef29ff25f273 100644
> --- a/include/linux/mfd/adp5585.h
> +++ b/include/linux/mfd/adp5585.h
> @@ -119,8 +119,18 @@
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

