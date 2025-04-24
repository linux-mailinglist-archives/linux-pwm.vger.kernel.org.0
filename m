Return-Path: <linux-pwm+bounces-5694-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571AA9B33F
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 18:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9C21886621
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C7221283;
	Thu, 24 Apr 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nka/HCwh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847481624C5;
	Thu, 24 Apr 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510496; cv=none; b=NwgDCXO4KOeOdwQdSXm55MWPRIAAh9xGlWgzBdcZG3G1o/ZAGffEtqwhLLFAluuogPWIw/ApS48afMgggYNgnnOPUc3L1kiAyUB4rU1vBFKFQViZuE7v0GNstBWOSULp5NP9hyhBNdGO9GjFSRKhgxlclHg8q/vtv7Jg+4racxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510496; c=relaxed/simple;
	bh=LCs/cu5ifxpaInj/AgC+3qC1kAItRVTNAr4hL5vL2Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOu+IuKF08tdOH4S8nqkcWzmjDNc27GWVmCsQ6exKGaIxqeur/m2I3QRgG204c7zdguN3tmvUZEFi+R5/ijKVJMk8M/u9k0bSIROiZVW87NQ1R2g9BWQJCA37g5y/zyIu4JkLcmrK1zNW6SjffmB3O4BQnyZmvnFtaU1lkXOTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nka/HCwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D989C4CEE3;
	Thu, 24 Apr 2025 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745510496;
	bh=LCs/cu5ifxpaInj/AgC+3qC1kAItRVTNAr4hL5vL2Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nka/HCwh4U7iguJ66yd+yZWoVphNrZaLAns4G/w7zLBIJIPpYG3yU0lfOPXOSWhGX
	 pNvhHNH1kC7alfMf0jIk/wvZwHRHAQd0PP5mEbQ1dVl34Tmi5yCJuoS7LOZLZXmNYT
	 S3TtyNB1TX+NwOuoETm9vsewUx6iP/ZP9L3nCFYGGgFbX0zTS+Az1y4ERKcXJ1ukIo
	 e+yKVHTMJubi10AH194VccClHp06H2k+8EdbklCAqQuNnjL9ayUXQnHMGJ0Q2T6aEf
	 4XQPUaPm1WfLbJCGFHyJUCXZ5is0AcV70nCEsJhHcoS5efrHeHYrPsytM859PJAafh
	 H6e8s6ynIVfUw==
Date: Thu, 24 Apr 2025 17:01:30 +0100
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
Subject: Re: [PATCH v2 06/17] mfd: adp5585: add support for adp5589
Message-ID: <20250424160130.GK8734@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
 <20250421091559.GE29968@pendragon.ideasonboard.com>
 <36b161e08547dc2d5abd36340c596e2147d82ce7.camel@gmail.com>
 <20250421220617.GV17813@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421220617.GV17813@pendragon.ideasonboard.com>

On Tue, 22 Apr 2025, Laurent Pinchart wrote:

> Hi Nuno,
> 
> On Mon, Apr 21, 2025 at 01:21:08PM +0100, Nuno Sá wrote:
> > On Mon, 2025-04-21 at 12:15 +0300, Laurent Pinchart wrote:
> > > On Tue, Apr 15, 2025 at 03:49:22PM +0100, Nuno Sá via B4 Relay wrote:
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > 
> > > > The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> > > > programmable logic, reset generator, and PWM generator.
> > > > 
> > > > This patch adds the foundation to add support for the adp5589 gpio and pwm
> > > > drivers. Most importantly, we need to differentiate between some
> > > > registers addresses. It also hints to future keymap support.
> > > 
> > > Please split this in two patches, one that reworks the driver to support
> > > different register addresses, and one that adds adp5589 support.
> > > 
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---
> > > >  drivers/mfd/adp5585.c       | 223 +++++++++++++++++++++++++++++++++++++++++---
> > > >  include/linux/mfd/adp5585.h |  57 ++++++++++-
> > > >  2 files changed, 268 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > > > index fafe3ad93ea196e1eb8e79fecba58f36f12167eb..c3586c0d6aa2e7e7d94667993410610be7fc3672 100644
> > > > --- a/drivers/mfd/adp5585.c
> > > > +++ b/drivers/mfd/adp5585.c
> > > > @@ -25,6 +25,13 @@ static const struct mfd_cell adp5585_devs[] = {
> > > >  
> > > >  };
> > > >  
> > > > +static const struct mfd_cell adp5589_devs[] = {
> > > > +	MFD_CELL_NAME("adp5589-keys"),
> > > > +	MFD_CELL_NAME("adp5589-gpio"),
> > > > +	MFD_CELL_NAME("adp5589-pwm"),
> > > > +
> > > > +};
> > > > +
> > > >  static const struct regmap_range adp5585_volatile_ranges[] = {
> > > >  	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
> > > >  };
> > > > @@ -34,6 +41,15 @@ static const struct regmap_access_table adp5585_volatile_regs = {
> > > >  	.n_yes_ranges = ARRAY_SIZE(adp5585_volatile_ranges),
> > > >  };
> > > >  
> > > > +static const struct regmap_range adp5589_volatile_ranges[] = {
> > > > +	regmap_reg_range(ADP5585_ID, ADP5589_GPI_STATUS_C),
> > > > +};
> > > > +
> > > > +static const struct regmap_access_table adp5589_volatile_regs = {
> > > > +	.yes_ranges = adp5589_volatile_ranges,
> > > > +	.n_yes_ranges = ARRAY_SIZE(adp5589_volatile_ranges),
> > > > +};
> > > > +
> > > >  /*
> > > >   * Chip variants differ in the default configuration of pull-up and pull-down
> > > >   * resistors, and therefore have different default register values:
> > > > @@ -77,10 +93,52 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
> > > >  	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > > >  };
> > > >  
> > > > +static const u8 adp5589_regmap_defaults_00[ADP5589_MAX_REG + 1] = {
> > > > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +};
> > > > +
> > > > +static const u8 adp5589_regmap_defaults_01[ADP5589_MAX_REG + 1] = {
> > > > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> > > > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> > > > +};
> > > > +
> > > > +static const u8 adp5589_regmap_defaults_02[ADP5589_MAX_REG + 1] = {
> > > > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x18 */ 0x00, 0x41, 0x01, 0x00, 0x11, 0x04, 0x00, 0x00,
> > > > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > > > +};
> > > > +
> > > >  enum adp5585_regmap_type {
> > > >  	ADP5585_REGMAP_00,
> > > >  	ADP5585_REGMAP_02,
> > > >  	ADP5585_REGMAP_04,
> > > > +	ADP5589_REGMAP_00,
> > > > +	ADP5589_REGMAP_01,
> > > > +	ADP5589_REGMAP_02,
> > > >  };
> > > >  
> > > >  static const struct regmap_config adp5585_regmap_configs[] = {
> > > > @@ -111,6 +169,131 @@ static const struct regmap_config adp5585_regmap_configs[] = {
> > > >  		.reg_defaults_raw = adp5585_regmap_defaults_04,
> > > >  		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
> > > >  	},
> > > > +	[ADP5589_REGMAP_00] = {
> > > > +		.reg_bits = 8,
> > > > +		.val_bits = 8,
> > > > +		.max_register = ADP5589_MAX_REG,
> > > > +		.volatile_table = &adp5589_volatile_regs,
> > > > +		.cache_type = REGCACHE_MAPLE,
> > > > +		.reg_defaults_raw = adp5589_regmap_defaults_00,
> > > > +		.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_00),
> > > > +	},
> > > > +	[ADP5589_REGMAP_01] = {
> > > > +		.reg_bits = 8,
> > > > +		.val_bits = 8,
> > > > +		.max_register = ADP5589_MAX_REG,
> > > > +		.volatile_table = &adp5589_volatile_regs,
> > > > +		.cache_type = REGCACHE_MAPLE,
> > > > +		.reg_defaults_raw = adp5589_regmap_defaults_01,
> > > > +		.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_01),
> > > > +	},
> > > > +	[ADP5589_REGMAP_02] = {
> > > > +		.reg_bits = 8,
> > > > +		.val_bits = 8,
> > > > +		.max_register = ADP5589_MAX_REG,
> > > > +		.volatile_table = &adp5589_volatile_regs,
> > > > +		.cache_type = REGCACHE_MAPLE,
> > > > +		.reg_defaults_raw = adp5589_regmap_defaults_02,
> > > > +		.num_reg_defaults_raw = sizeof(adp5589_regmap_defaults_02),
> > > > +	},
> > > > +};
> > > > +
> > > > +static const struct adp5585_regs adp5585_regs = {
> > > > +	.debounce_dis_a = ADP5585_DEBOUNCE_DIS_A,
> > > > +	.rpull_cfg_a = ADP5585_RPULL_CONFIG_A,
> > > > +	.gpo_data_a = ADP5585_GPO_DATA_OUT_A,
> > > > +	.gpo_out_a = ADP5585_GPO_OUT_MODE_A,
> > > > +	.gpio_dir_a = ADP5585_GPIO_DIRECTION_A,
> > > > +	.gpi_stat_a = ADP5585_GPI_STATUS_A,
> > > > +	.pwm_cfg = ADP5585_PWM_CFG,
> > > > +	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
> > > > +	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
> > > > +	.gen_cfg = ADP5585_GENERAL_CFG,
> > > > +	.ext_cfg = ADP5585_PIN_CONFIG_C,
> > > > +};
> > > 
> > > Why does this need to be stored in this driver, and not in the drivers
> > > for the gpio and pwm cells ? If the kernel is compiled without e.g. the
> > > adp5585-pwm driver, we shouldn't waste memory here by adding data that
> > > only the adp5585-pwm driver needs.
> > 
> > I don't really think the memory we would save to be that relevant but I can
> > better separate things. I guess i went like this because there's some shared
> > variables that will have to be in the top level structs and I did not wanted to
> > have a "global" and "local" regs thingy...

Memory and power savings are very important.

Please prioritise them over effort.

> I understand, and I think it's at least partly a coding style
> preference. Personally, I find that having child-specific data in child
> drivers makes the code easier to read, as it increases locality.
> Otherwise, I have to look through multiple child drivers to see if and
> where each field is used.

Right.  If resources are only used in specific sub-devices, please move
it there.  Only shared resources should be handed in the parent.

-- 
Lee Jones [李琼斯]

