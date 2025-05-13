Return-Path: <linux-pwm+bounces-5966-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B9AB5947
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 18:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C984645C1
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07742BE104;
	Tue, 13 May 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7+5Xosm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA422338;
	Tue, 13 May 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152217; cv=none; b=H/Vr7HF+DxqVUUDb1efGi9z/Y57GRTL6r6wF0n87Uj2uBnHTg2gEALDyjHvCdvEzRIoLuZ3lWpwJdolrfHjb/rf08P3mU8RystIsnyIjuUhhOB4hQnxRmsVKVzTeCDsjIyywK/8tNzy3ZcwHNzbbU9F0wsl0DcuFQntru6mxugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152217; c=relaxed/simple;
	bh=WNcj1it742ElEqyjaYrff5xcdVt/92EDcg0/aIi+WPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5RQJOtRKxgFu6isrmGDxOp3jOXcJERSNKYkTZ/C2tDjGyZDvSMxAw/LML/CExghJiCWUOHTaap41+5S/gINMs6xAkGVzVK6YBkPceX4ThgshaeXgxNecCFXyB8YsgowuafCaCpeNZseGBkRCNzz+NvzoJdCK2yK0j7CPM9Zf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7+5Xosm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D36C4CEE4;
	Tue, 13 May 2025 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152217;
	bh=WNcj1it742ElEqyjaYrff5xcdVt/92EDcg0/aIi+WPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7+5XosmCpQeVYdivnx2272Er4X1BCSW4ypEabNfE6HVYjGay5wXHTyv5vmLEID1l
	 3k5aHnK8pFlQZRHDZnrfXnxjRCqMjfd/CnWiAh45asCuGypSvxosCSnYvyLwYCj7Jz
	 JWLJu6Z57M3xMzoH8IruAneKcKGTN9XNLJfp70EQdyxcbCUkHz2jMacQLc9Bjmw0Q6
	 6mQ9HBEatfXUthhCeIvMV0eEk/b20CPypbwuOh+slVHaNHrm7ogozLc6/KnqLS0oKE
	 ReUywp0w/pB8y3ZD02Ok3rks7giAm0OQUFBIMdaIXiFvUFsXMw68EDH9pTDlKZsgYh
	 un7ds3k6ONGfg==
Date: Tue, 13 May 2025 17:03:31 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 07/22] mfd: adp5585: refactor how regmap defaults are
 handled
Message-ID: <20250513160331.GR2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-7-092b14b79a88@analog.com>
 <20250513150029.GO2936510@google.com>
 <c2c32541c31376d90b938f6c3532e195243dadf2.camel@gmail.com>
 <20250513153646.GE23592@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513153646.GE23592@pendragon.ideasonboard.com>

On Tue, 13 May 2025, Laurent Pinchart wrote:

> On Tue, May 13, 2025 at 04:32:39PM +0100, Nuno Sá wrote:
> > On Tue, 2025-05-13 at 16:00 +0100, Lee Jones wrote:
> > > On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:
> > > 
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > 
> > > > The only thing changing between variants is the regmap default
> > > > registers. Hence, instead of having a regmap condig for every variant
> > > > (duplicating lots of fields), add a chip info type of structure with a
> > > > regmap id to identify which defaults to use and populate regmap_config
> > > > at runtime given a template plus the id. Also note that between
> > > > variants, the defaults can be the same which means the chip info
> > > > structure can be used in more than one compatible.
> > > > 
> > > > This will also make it simpler adding new chips with more variants.
> > > > 
> > > > Also note that the chip info structures are deliberately not const as
> > > > they will also contain lots of members that are the same between the
> > > > different devices variants and so we will fill those at runtime.
> > > > 
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/mfd/adp5585.c       | 94 +++++++++++++++++++++++++-----------------
> > > > ---
> > > >  include/linux/mfd/adp5585.h | 11 ++++++
> > > >  2 files changed, 64 insertions(+), 41 deletions(-)
> > > > 
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index
> > > > 19d4a0ab1bb4c261e82559630624059529765fbd..874aed7d7cfe052587720d899096c995c1
> > > > 9667af 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -81,41 +81,34 @@ static const u8
> > > > adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
> > > >  	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > > >  };
> > > >  
> > > > -enum adp5585_regmap_type {
> > > > -	ADP5585_REGMAP_00,
> > > > -	ADP5585_REGMAP_02,
> > > > -	ADP5585_REGMAP_04,
> > > > +static const struct regmap_config adp5585_regmap_config_template = {
> > > > +	.reg_bits = 8,
> > > > +	.val_bits = 8,
> > > > +	.max_register = ADP5585_MAX_REG,
> > > > +	.volatile_table = &adp5585_volatile_regs,
> > > > +	.cache_type = REGCACHE_MAPLE,
> > > > +	.num_reg_defaults_raw = ADP5585_MAX_REG + 1,
> > > >  };
> > > >  
> > > > -static const struct regmap_config adp5585_regmap_configs[] = {
> > > > -	[ADP5585_REGMAP_00] = {
> > > > -		.reg_bits = 8,
> > > > -		.val_bits = 8,
> > > > -		.max_register = ADP5585_MAX_REG,
> > > > -		.volatile_table = &adp5585_volatile_regs,
> > > > -		.cache_type = REGCACHE_MAPLE,
> > > > -		.reg_defaults_raw = adp5585_regmap_defaults_00,
> > > > -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_00),
> > > > -	},
> > > > -	[ADP5585_REGMAP_02] = {
> > > > -		.reg_bits = 8,
> > > > -		.val_bits = 8,
> > > > -		.max_register = ADP5585_MAX_REG,
> > > > -		.volatile_table = &adp5585_volatile_regs,
> > > > -		.cache_type = REGCACHE_MAPLE,
> > > > -		.reg_defaults_raw = adp5585_regmap_defaults_02,
> > > > -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_02),
> > > > -	},
> > > > -	[ADP5585_REGMAP_04] = {
> > > > -		.reg_bits = 8,
> > > > -		.val_bits = 8,
> > > > -		.max_register = ADP5585_MAX_REG,
> > > > -		.volatile_table = &adp5585_volatile_regs,
> > > > -		.cache_type = REGCACHE_MAPLE,
> > > > -		.reg_defaults_raw = adp5585_regmap_defaults_04,
> > > > -		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
> > > > -	},
> > > > -};
> > > > +static int adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
> > > > +				      struct regmap_config *regmap_config)
> > > 
> > > I like the general idea.  This is much more scaleable than before.
> > > 
> > > > +{
> > > > +	*regmap_config = adp5585_regmap_config_template;
> > > > +
> > > > +	switch (adp5585->info->regmap_type) {
> > > > +	case ADP5585_REGMAP_00:
> > > > +		regmap_config->reg_defaults_raw =
> > > > adp5585_regmap_defaults_00;
> > > > +		return 0;
> > > > +	case ADP5585_REGMAP_02:
> > > > +		regmap_config->reg_defaults_raw =
> > > > adp5585_regmap_defaults_02;
> > > > +		return 0;
> > > > +	case ADP5585_REGMAP_04:
> > > > +		regmap_config->reg_defaults_raw =
> > > > adp5585_regmap_defaults_04;
> > > 
> > > You could make this read a tiny bit nicer (as you do with the adp5585->info
> > > in a later patch) and make reg_defaults_raw a local variable.
> > 
> > I'm probably missing your point but what would be the benefit? The info is done
> > like that because I wanted the pointer to be 'const'. Here I do not think the
> > same applies...
> > 
> > > 
> > > > +		return 0;
> > > > +	default:
> > > > +		return -ENODEV;
> > > > +	}
> > > > +}
> > > >  
> > > >  static int adp5585_parse_fw(struct device *dev, struct adp5585_dev
> > > > *adp5585,
> > > >  			    struct mfd_cell **devs)
> > > > @@ -153,7 +146,7 @@ static void adp5585_osc_disable(void *data)
> > > >  
> > > >  static int adp5585_i2c_probe(struct i2c_client *i2c)
> > > >  {
> > > > -	const struct regmap_config *regmap_config;
> > > > +	struct regmap_config regmap_config;
> > > >  	struct adp5585_dev *adp5585;
> > > >  	struct mfd_cell *devs;
> > > >  	unsigned int id;
> > > > @@ -165,8 +158,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
> > > >  
> > > >  	i2c_set_clientdata(i2c, adp5585);
> > > >  
> > > > -	regmap_config = i2c_get_match_data(i2c);
> > > > -	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
> > > > +	adp5585->info = i2c_get_match_data(i2c);
> > > > +	if (!adp5585->info)
> > > > +		return -ENODEV;
> > > > +
> > > > +	ret = adp5585_fill_regmap_config(adp5585, &regmap_config);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
> > > >  	if (IS_ERR(adp5585->regmap))
> > > >  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> > > >  				     "Failed to initialize register
> > > > map\n");
> > > > @@ -223,22 +223,34 @@ static int adp5585_resume(struct device *dev)
> > > >  
> > > >  static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend,
> > > > adp5585_resume);
> > > >  
> > > > +static struct adp5585_info adp5585_info = {
> > > > +	.regmap_type = ADP5585_REGMAP_00,
> > > 
> > > Instead of providing this enum, then later another one (id) which is a
> > > subset of the same thing, why not pass just ADP5585_REGMAP_00, etc
> > > through the DT .data attribute then match on those?  It will add a
> > > couple of lines to the switch(info->id) statement, but will save on a
> > > boat load of static structs and other complexity.
> > > 
> > > For instance:
> > > 
> > > switch (info->id) {
> > > 	case ADP5585_MAN_ID_VALUE:
> > > 
> > > Would simply become:
> > > 
> > > switch (info->id) {
> > > 	case ADP5585_REGMAP_00:
> > > 	case ADP5585_REGMAP_02:
> > > 	case ADP5585_REGMAP_04:
> > > 
> > > And that's it.
> > 
> > I get the general idea... We will also have to pack the regmap defaults into an
> > array so that we can easily reference it with 'info->id' which I don't like too
> > much tbh (but I do see that adp5585_fill_chip_configs() will become simpler) . I
> > guess I can also just move everything into the "main" struct as we will fill
> > everything during probe (no real reason for struct adp5585_info) 
> > 
> > Anyways, If you prefer the above I'm not going to argue against it...
> > 
> > > 
> > > > +};
> > > > +
> > > > +static struct adp5585_info adp5585_02_info = {
> > > > +	.regmap_type = ADP5585_REGMAP_02,
> > > > +};
> > > > +
> > > > +static struct adp5585_info adp5585_04_info = {
> > > > +	.regmap_type = ADP5585_REGMAP_04,
> > > > +};
> > > > +
> > > >  static const struct of_device_id adp5585_of_match[] = {
> > > >  	{
> > > >  		.compatible = "adi,adp5585-00",
> > > > -		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > > > +		.data = &adp5585_info,
> > > 
> > > 		.data = ADP5585_REGMAP_00,
> > 
> > I see, needs a cast but should work. I personally prefer valid pointers than
> > "encoding" integers in here. I know we can start the enum at 1 so that we can
> > still look for 0 for any possible issue but...
> 
> I also prefer pointers to structures, but won't fight for it.

They can be nice to avoid any switch() matching, but here we have both
anyway so it improves very little.

-- 
Lee Jones [李琼斯]

