Return-Path: <linux-pwm+bounces-6319-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F26AD73CD
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92B7188B3F1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E21AA1FF;
	Thu, 12 Jun 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV4Ty6W8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604111F16B;
	Thu, 12 Jun 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738163; cv=none; b=dVnBfO2oPjZUaqOUflHBYMvJFgn79iyOdMMjl9NpCSf679s31BMa/hohUx4BwN4QmUFqTI10SCKjV/2MXXfdKUK7yDnRsdZdPtYPXWZ45Nz2NbC5ZPbRk2CLes6G1OdzYXApSY8avHQU/UUq4tXHHULO+ymKVjrJppUP+5jtXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738163; c=relaxed/simple;
	bh=D1yrjS33aiD5WfpOhfNZnxUS2RqazOYrcKSMRQBRq9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwB/RE2RRfOIpHAtBMjhuEmu1bVLbEuxL1MnoXjmJsb57lxvxEAaZVlnzAQZj1NMddsqvw1CdW15r9JfLwZ3LugyTawePYJB5qUjcDpN3U9FWeQwiH3Z2cGdLb+p27mhry+lJpDniGZDk7tINYOfzEFA3X43kke25qAbSa/XAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV4Ty6W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EBDC4CEEA;
	Thu, 12 Jun 2025 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738161;
	bh=D1yrjS33aiD5WfpOhfNZnxUS2RqazOYrcKSMRQBRq9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IV4Ty6W8JH1QWbg8HydA+tb9EU94AEKoCPtwcohEttPiyvw9vdytZ9vD0LwqX3FaE
	 eCQuKJrb79+iyoXC95W59/0o1rlwXJEQN9WDBEYVJsVwq2mLe6FFAFNmt7r0a/22cu
	 VFwB+Cd+eyRFZPzBQLKxv3+7hwlhSROJtTBqOwCQ941u3phBm2ykfi4jmD+Fbc8QAr
	 TG1Rh8tPD65U1TcE9YGcRoh0fQhx4CqVeFV3cIYDR5fLHpzEXVxlwUhHchsESybFC6
	 g8zmgHACE2irHYkXpQ65u3k3VBn8MpNQ5+FCWwUpiZ7lVws0xE4QGn0aQkcT8/I8Kx
	 PHB1h89SOeX1w==
Date: Thu, 12 Jun 2025 15:22:36 +0100
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
Subject: Re: [PATCH v4 08/20] mfd: adp5585: add a per chip reg struture
Message-ID: <20250612142236.GI381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-8-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-8-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> There are some differences in the register map between the devices.
> Hence, add a register structure per device. This will be needed in
> following patches.
> 
> On top of that adp5585_fill_regmap_config() is renamed and reworked so
> that the current struct adp5585_info act as template (they indeed
> contain all the different data between variants) which can then be
> complemented depending on the device (as identified by the id register).
> This is done like this since a lot of the data is pretty much the same
> between variants of the same device.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Lee Jones <lee@kernel.org>

> ---
>  drivers/mfd/adp5585.c       | 10 ++++++++++
>  include/linux/mfd/adp5585.h |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 53ac46365e56874a05855f1df1843717148f181a..e90d16389732f3d8790eb910acd82be2033eaa7e 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -164,6 +164,14 @@ static const struct regmap_config adp5589_regmap_config_template = {
>  	.num_reg_defaults_raw = ADP5589_MAX_REG + 1,
>  };
>  
> +static const struct adp5585_regs adp5585_regs = {
> +	.ext_cfg = ADP5585_PIN_CONFIG_C,
> +};
> +
> +static const struct adp5585_regs adp5589_regs = {
> +	.ext_cfg = ADP5589_PIN_CONFIG_D,
> +};
> +
>  static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
>  				       struct regmap_config *regmap_config)
>  {
> @@ -175,12 +183,14 @@ static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
>  	case ADP5585_04:
>  		*regmap_config = adp5585_regmap_config_template;
>  		adp5585->id = ADP5585_MAN_ID_VALUE;
> +		adp5585->regs = &adp5585_regs;
>  		break;
>  	case ADP5589_00:
>  	case ADP5589_01:
>  	case ADP5589_02:
>  		*regmap_config = adp5589_regmap_config_template;
>  		adp5585->id = ADP5589_MAN_ID_VALUE;
> +		adp5585->regs = &adp5589_regs;
>  		break;
>  	default:
>  		return -ENODEV;
> diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> index 40c87981e5a24f8a175cc41e38b1495ed9f194e5..a20aa435100aaccb5ed22910933e1856409ba397 100644
> --- a/include/linux/mfd/adp5585.h
> +++ b/include/linux/mfd/adp5585.h
> @@ -120,6 +120,7 @@
>  /* ADP5589 */
>  #define		ADP5589_MAN_ID_VALUE		0x10
>  #define ADP5589_GPI_STATUS_C		0x18
> +#define ADP5589_PIN_CONFIG_D		0x4C
>  #define ADP5589_INT_EN			0x4e
>  #define ADP5589_MAX_REG			ADP5589_INT_EN
>  
> @@ -137,7 +138,12 @@ enum adp5585_variant {
>  	ADP5585_MAX
>  };
>  
> +struct adp5585_regs {
> +	unsigned int ext_cfg;
> +};
> +
>  struct adp5585_dev {
> +	const struct adp5585_regs *regs;
>  	struct regmap *regmap;
>  	struct device *dev;
>  	enum adp5585_variant variant;
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

