Return-Path: <linux-pwm+bounces-5954-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA0AB57F5
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3C686653F
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1701ADFFB;
	Tue, 13 May 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMmXhb8t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76A14B07A;
	Tue, 13 May 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148555; cv=none; b=F9VGymYXk/JRmxZhpdXIep8jGF2ChtCZK7jjBR0EVJ3xi3rvtRGcvm4WAzMzvraePaOACcNZQLv0KkBLNVrAZNZgbcO1Vhv1nwFUqE9op2/GFLBSaY5hwsyiV1uXdrYYYUMCCb+0sqKUx9DdV7Up7cyJzovsW+kqLUmyAmp+cpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148555; c=relaxed/simple;
	bh=B6maNZsDXYpgi8hdTJ1yNHPcZvQHZ0yC8G1V7BxTUcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHtkP6xiHFwhAasacbeRb6NdLBloibiHiKCOY4CcCZ7WcXT0erbFhMI3M7ZnvOhJtqSbp5BAAXvGTnQNW5SwOa6RyllHYelYr2i5gEM3msMX84QI6W3sP0Xcc7VW3s0hahxmIyWv8d/oKyrVBp4ksCdM9O9/OIc4pB+G4NYT91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMmXhb8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A7C4CEE4;
	Tue, 13 May 2025 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747148555;
	bh=B6maNZsDXYpgi8hdTJ1yNHPcZvQHZ0yC8G1V7BxTUcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMmXhb8tfXjR6fC+HXBHvpJPeomnetyyeRM/uI86YyL1z+pUwAAsAtSWck5ER/xwu
	 FGwEZ4hXxCZB/nWC83Wt4jtyhAm53A8KakGT0A7EkeOQT93gjf8QzhNynwYf6Yg8q9
	 OKn+bMxJ5lO2aoF3P+JWABjewQCTfTTGImFlr66VDv1eSf0L2JjTCTbZGkXb/uH0Ln
	 hcYgfzyqPnSK7Mo/2EbA4hzOsOqBXjF+lVSqW12IFneH1sjzK8wBxEJ0RyWf9Bswyi
	 QhE+57Svm766pPu+WYghVYVQt8swYhVubsTDD0ctqSB3zBXXku1p7wnmCb8XCd7c5y
	 nfmALqJJUenuA==
Date: Tue, 13 May 2025 16:02:29 +0100
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
Subject: Re: [PATCH v3 07/22] mfd: adp5585: refactor how regmap defaults are
 handled
Message-ID: <20250513150229.GP2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-7-092b14b79a88@analog.com>
 <20250513150029.GO2936510@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513150029.GO2936510@google.com>

On Tue, 13 May 2025, Lee Jones wrote:

> On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:
> 
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > The only thing changing between variants is the regmap default
> > registers. Hence, instead of having a regmap condig for every variant
> > (duplicating lots of fields), add a chip info type of structure with a
> > regmap id to identify which defaults to use and populate regmap_config
> > at runtime given a template plus the id. Also note that between
> > variants, the defaults can be the same which means the chip info
> > structure can be used in more than one compatible.
> > 
> > This will also make it simpler adding new chips with more variants.
> > 
> > Also note that the chip info structures are deliberately not const as
> > they will also contain lots of members that are the same between the
> > different devices variants and so we will fill those at runtime.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/mfd/adp5585.c       | 94 +++++++++++++++++++++++++--------------------
> >  include/linux/mfd/adp5585.h | 11 ++++++
> >  2 files changed, 64 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > index 19d4a0ab1bb4c261e82559630624059529765fbd..874aed7d7cfe052587720d899096c995c19667af 100644
> > --- a/drivers/mfd/adp5585.c
> > +++ b/drivers/mfd/adp5585.c
> > @@ -81,41 +81,34 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
> >  	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> >  };
> >  
> > -enum adp5585_regmap_type {
> > -	ADP5585_REGMAP_00,
> > -	ADP5585_REGMAP_02,
> > -	ADP5585_REGMAP_04,
> > +static const struct regmap_config adp5585_regmap_config_template = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = ADP5585_MAX_REG,
> > +	.volatile_table = &adp5585_volatile_regs,
> > +	.cache_type = REGCACHE_MAPLE,
> > +	.num_reg_defaults_raw = ADP5585_MAX_REG + 1,
> >  };
> >  
> > -static const struct regmap_config adp5585_regmap_configs[] = {
> > -	[ADP5585_REGMAP_00] = {
> > -		.reg_bits = 8,
> > -		.val_bits = 8,
> > -		.max_register = ADP5585_MAX_REG,
> > -		.volatile_table = &adp5585_volatile_regs,
> > -		.cache_type = REGCACHE_MAPLE,
> > -		.reg_defaults_raw = adp5585_regmap_defaults_00,
> > -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_00),
> > -	},
> > -	[ADP5585_REGMAP_02] = {
> > -		.reg_bits = 8,
> > -		.val_bits = 8,
> > -		.max_register = ADP5585_MAX_REG,
> > -		.volatile_table = &adp5585_volatile_regs,
> > -		.cache_type = REGCACHE_MAPLE,
> > -		.reg_defaults_raw = adp5585_regmap_defaults_02,
> > -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_02),
> > -	},
> > -	[ADP5585_REGMAP_04] = {
> > -		.reg_bits = 8,
> > -		.val_bits = 8,
> > -		.max_register = ADP5585_MAX_REG,
> > -		.volatile_table = &adp5585_volatile_regs,
> > -		.cache_type = REGCACHE_MAPLE,
> > -		.reg_defaults_raw = adp5585_regmap_defaults_04,
> > -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
> > -	},
> > -};
> > +static int adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
> > +				      struct regmap_config *regmap_config)
> 
> I like the general idea.  This is much more scaleable than before.
> 
> > +{
> > +	*regmap_config = adp5585_regmap_config_template;
> > +
> > +	switch (adp5585->info->regmap_type) {
> > +	case ADP5585_REGMAP_00:
> > +		regmap_config->reg_defaults_raw = adp5585_regmap_defaults_00;
> > +		return 0;
> > +	case ADP5585_REGMAP_02:
> > +		regmap_config->reg_defaults_raw = adp5585_regmap_defaults_02;
> > +		return 0;
> > +	case ADP5585_REGMAP_04:
> > +		regmap_config->reg_defaults_raw = adp5585_regmap_defaults_04;
> 
> You could make this read a tiny bit nicer (as you do with the adp5585->info
> in a later patch) and make reg_defaults_raw a local variable.
> 
> > +		return 0;
> > +	default:
> > +		return -ENODEV;
> > +	}
> > +}
> >  
> >  static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
> >  			    struct mfd_cell **devs)
> > @@ -153,7 +146,7 @@ static void adp5585_osc_disable(void *data)
> >  
> >  static int adp5585_i2c_probe(struct i2c_client *i2c)
> >  {
> > -	const struct regmap_config *regmap_config;
> > +	struct regmap_config regmap_config;
> >  	struct adp5585_dev *adp5585;
> >  	struct mfd_cell *devs;
> >  	unsigned int id;
> > @@ -165,8 +158,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> >  
> >  	i2c_set_clientdata(i2c, adp5585);
> >  
> > -	regmap_config = i2c_get_match_data(i2c);
> > -	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
> > +	adp5585->info = i2c_get_match_data(i2c);
> > +	if (!adp5585->info)
> > +		return -ENODEV;
> > +
> > +	ret = adp5585_fill_regmap_config(adp5585, &regmap_config);
> > +	if (ret)
> > +		return ret;
> > +
> > +	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
> >  	if (IS_ERR(adp5585->regmap))
> >  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> >  				     "Failed to initialize register map\n");
> > @@ -223,22 +223,34 @@ static int adp5585_resume(struct device *dev)
> >  
> >  static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
> >  
> > +static struct adp5585_info adp5585_info = {
> > +	.regmap_type = ADP5585_REGMAP_00,
> 
> Instead of providing this enum, then later another one (id) which is a
> subset of the same thing, why not pass just ADP5585_REGMAP_00, etc
> through the DT .data attribute then match on those?  It will add a
> couple of lines to the switch(info->id) statement, but will save on a
> boat load of static structs and other complexity.
> 
> For instance:
> 
> switch (info->id) {
> 	case ADP5585_MAN_ID_VALUE:
> 
> Would simply become:
> 
> switch (info->id) {
> 	case ADP5585_REGMAP_00:
> 	case ADP5585_REGMAP_02:
> 	case ADP5585_REGMAP_04:
> 
> And that's it.
> 
> > +};
> > +
> > +static struct adp5585_info adp5585_02_info = {
> > +	.regmap_type = ADP5585_REGMAP_02,
> > +};
> > +
> > +static struct adp5585_info adp5585_04_info = {
> > +	.regmap_type = ADP5585_REGMAP_04,
> > +};
> > +
> >  static const struct of_device_id adp5585_of_match[] = {
> >  	{
> >  		.compatible = "adi,adp5585-00",
> > -		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +		.data = &adp5585_info,
> 
> 		.data = ADP5585_REGMAP_00,

It goes without saying that the defines would have to become more
generic as well, since they will be expanded to describe more than just
'REGMAP'.

-- 
Lee Jones [李琼斯]

