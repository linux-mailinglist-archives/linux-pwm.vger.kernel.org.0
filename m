Return-Path: <linux-pwm+bounces-6318-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EDAAD739D
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076DB2C0E06
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E014E2288C6;
	Thu, 12 Jun 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzQrE+et"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62017C220;
	Thu, 12 Jun 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738007; cv=none; b=TECaD3c9W9kVscjEr1T2ZUbCFuqh9TVe5BCGmJXvKI7KXGqT/2qm1Bxq/zHRRhDCzwbR5HlrhT1SP7la61EQvoOG+wQJuz9B7qe+Z5ZbbAHDXmn3drxBN2uhYaD5Bc6rGFixJQmtCMVGpwaZyKumJ86QI1C5PRXlwL3juvYZ6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738007; c=relaxed/simple;
	bh=59yekDnWSbCNO6eJH7hNM8CwReZNLQHkYy9GNGTRxkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyxloqeLDLIEyeJFnbwysZgAdQiOojXd2JOU5/Eg9g3z/KKNSdOwsR4/mW9bdkHNGxK7AckaKjNZQ3cw7wi3CoWi6fZXc27FuTPAPB12EvgXlSeRI2ZtIEE/YDGZTO0DyjtgTuHuQKlx4S/RMGeBqxm/3uU4cGcrO6JMtbZQ4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzQrE+et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D833C4CEEA;
	Thu, 12 Jun 2025 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738007;
	bh=59yekDnWSbCNO6eJH7hNM8CwReZNLQHkYy9GNGTRxkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzQrE+eto8w+qa3TjZWDN/EWc1m+wyU8M1m4tSYXT3CnODwWvLnGgXHa92EAlr17Q
	 pdQRJTjx/YjT3FIhb10E7ZG4AY01ZQ/7Kr+tRyK2x752fI/ldNj8JzwWuwBwFxtPef
	 Jkb+WPHjQ1SmDDnouWd4exTuie5Z0FbBlKGVNwuR94CKdc8V3fwHUx6ABed8P4UvZG
	 8wOVZ3fVVndzvRnRyP4ek1VWIs2zW2upZZjoUuN92UO6XiUskBlz6WYV+ULWwsENNP
	 PA7/CFNnMlY1TzHtGyXh9oqvHlPS6jtwfng79f/QyCTHnAEWgmS1RjY5r2pGLyim5q
	 FU2WsInSY+ByQ==
Date: Thu, 12 Jun 2025 15:20:01 +0100
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
Subject: Re: [PATCH v4 03/20] mfd: adp5585: enable oscilator during probe
Message-ID: <20250612142001.GH381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-3-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-3-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure to enable the oscillator in the top device. This will allow to
> not control this in the child PWM device as that would not work with
> future support for keyboard matrix where the oscillator needs to be
> always enabled (and so cannot be disabled by disabling PWM).
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c     | 23 +++++++++++++++++++++++
>  drivers/pwm/pwm-adp5585.c |  5 -----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 806867c56d6fb4ef1f461af26a424a3a05f46575..f3b74f7d6040413d066eb6dbaecfa3d5e6ee06bd 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -147,6 +147,13 @@ static int adp5585_add_devices(struct device *dev)
>  	return ret;
>  }
>  
> +static void adp5585_osc_disable(void *data)
> +{
> +	const struct adp5585_dev *adp5585 = data;
> +
> +	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
> +}
> +
>  static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct regmap_config *regmap_config;
> @@ -175,6 +182,22 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  		return dev_err_probe(&i2c->dev, -ENODEV,
>  				     "Invalid device ID 0x%02x\n", id);
>  
> +	/*
> +	 * Enable the internal oscillator, as it's shared between multiple
> +	 * functions.
> +	 *
> +	 * As a future improvement, power consumption could possibly be
> +	 * decreased in some use cases by enabling and disabling the oscillator
> +	 * dynamically based on the needs of the child drivers.

This is normal.  What's stopping us from doing this from the offset?

> +	 */
> +	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
> +	if (ret)
> +		return ret;
> +
>  	return adp5585_add_devices(&i2c->dev);
>  }
>  
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index 40472ac5db6410a33e4f790fe8e6c23b517502be..c8821035b7c1412a55a642e6e8a46b66e693a5af 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -62,7 +62,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
>  	int ret;
>  
>  	if (!state->enabled) {
> -		regmap_clear_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
>  		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
>  		return 0;
>  	}
> @@ -100,10 +99,6 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_set_bits(regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
> -	if (ret)
> -		return ret;
> -
>  	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
>  }
>  
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

