Return-Path: <linux-pwm+bounces-6445-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F588AE089B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6683189369D
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Jun 2025 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216521B8FE;
	Thu, 19 Jun 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGtml8lE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63321931C;
	Thu, 19 Jun 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342971; cv=none; b=YyiTUVBYTKlEMAoZahCPca/yX3uBS1SUzLz3pMG59VMaOjtDaYAU0+TrV3dentL+IxUsP2Cx6WVUKSy4uHyo/FGych3U+ave7qMbNRPhC7A1HEjrO5pebcnFG9M1SHOoRaXhuBJa/R/RI9XWqRieDvCYKV8g+WmpsrAHx4uIQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342971; c=relaxed/simple;
	bh=JHQSTVQIvPd7J9lWM32NxJ4KN01WUZjrX9QuXwtq1EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1iSdJY7efTB6CgUI93zu3ZibLWMMHP3VmNSDATBgzTlHTn0HNGoD6ZlTqJ42JIEGXdpPBOL3x/3KdAW7EGUo2MTXmYTVSV1F0PDCkggRlFpv5cdEuRXtHX3CpzZpQlkDcF5imXnNW7BVri99gn9bPA6vlZtbhOUuVDSGXeipLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGtml8lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B43C4CEEA;
	Thu, 19 Jun 2025 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750342970;
	bh=JHQSTVQIvPd7J9lWM32NxJ4KN01WUZjrX9QuXwtq1EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGtml8lEaw2d//Sytsj5ywWCcb3IuxX8gRN28C0y+AWWckuD1Ns6b46v8hAMxQlBG
	 dVuuYFnTsEBlAas+iEM8yXQjZcQhQC858HJlq+HcE+ws+t3xfk2buGWHXTpIg0T3Ff
	 wPfYivDUMrQ2bI3/TlN1LUdulNN+hf+GPriUEPApNhXREWpxf9Jj3Qyf5i2uLAn1PA
	 vJHsnvEEEAl1lutssHUNyrHJhvf5v3pPMUJSxXrIHPI5vjmxPfI0bsG0iv5fZ42FSi
	 2NbUO51ukwwKvvx5jrqBARsvS8qgVm/2b96Gju3vXUZm3jGowZTpqHYNrcdxpbh6nt
	 HFdddhIncRW3g==
Date: Thu, 19 Jun 2025 15:22:45 +0100
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
Subject: Re: [PATCH v5 18/20] mfd: adp5585: support getting vdd regulator
Message-ID: <20250619142245.GE795775@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250614-dev-adp5589-fw-v5-18-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250614-dev-adp5589-fw-v5-18-7e9d84906268@analog.com>

On Sat, 14 Jun 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure we get and enable the VDD supply (if available).
> 
> Reviewed-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 3a53bc895e60e6a10f797aebcc29b722906ff087..e4a725b9e1475be03cd26898faa7a7bb8de4319b 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -17,6 +17,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/types.h>
>  
>  enum {
> @@ -710,6 +711,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	if (IS_ERR(regmap_config))
>  		return PTR_ERR(regmap_config);
>  
> +	ret = devm_regulator_get_enable(&i2c->dev, "vdd");
> +	if (ret)
> +		return ret;
> +
>  	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> @@ -726,6 +731,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  				     "Invalid device ID 0x%02x\n", id);
>  
>  	adp5585->pin_usage = devm_bitmap_zalloc(&i2c->dev, adp5585->n_pins, GFP_KERNEL);
> +

This looks like a mistake.

>  	if (!adp5585->pin_usage)
>  		return -ENOMEM;
>  
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

