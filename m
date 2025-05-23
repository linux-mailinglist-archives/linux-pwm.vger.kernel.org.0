Return-Path: <linux-pwm+bounces-6101-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC859AC2573
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5907B6D46
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B71296723;
	Fri, 23 May 2025 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muZd4Ela"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F09D296165;
	Fri, 23 May 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011910; cv=none; b=M2oIML0MB1y4yiYuILWY2kJ7evFWTNFmyp4L7swj8XDxR/RSRtaC5G+0eXxibxsVXVIZMPefo9eZlAqm4PUqVp/HIX5Zbz8D65s2br+0wZYQDsAgsq8lNJSaWdIlLfo8zDYjVug7ZjIjTzfMPSVX+XIsBRjKIWugmqzXnvjisO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011910; c=relaxed/simple;
	bh=gxTm98Tb6BMqbwOCO22pyng7vfWT87F+/O0nJSdr3Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1UdkLSyQr/ySS9TDbKdcNgV18IECfwcifcYmAimmPq1f4VsCOPESYZTobmDOt/laz9SatKya1GF/R53QjTRJHQAiiQP39MMI5nMCm8/GGguFQDJufr4zazlgRzXuuypeDMHDlmgg6Jy2+AQfYaH2Cyk/sioTwJuYpRcEdPtrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muZd4Ela; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3663FC4CEED;
	Fri, 23 May 2025 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011909;
	bh=gxTm98Tb6BMqbwOCO22pyng7vfWT87F+/O0nJSdr3Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muZd4ElaMF6F1CzfM5vYL6A+OQg9oYSWkODkIlPuZaOawfmpUFFYuff0jo8cxoYYR
	 ZyHyicNs3GfT0REFxSvQ6Sn7JFbtArI5QEoQGrQWMXnIJ5nZ02H4cwIzJZNJkCDnWu
	 Bn/38ry+sT6pngmEDqqRCHOHhvVdbfBSlvYGCSnD4/I1ezAqhUFUmfdDc2sSQbkvjH
	 lLt36I0ldcuo4M2S2ZqUGoa9S6HKAB3vfpqPYoCu/IfmGxCRi6mKWK1yCWRDzWqd5C
	 8+ea5+z1cEywfCcqmPnoAxk5oK4z9bYyliolh7OevjKkasYv7XagBX+wtxNkZXfuF4
	 FmK5cwv+GV8Nw==
Date: Fri, 23 May 2025 15:51:44 +0100
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
Subject: Re: [PATCH v4 02/20] mfd: adp5585: only add devices given in FW
Message-ID: <20250523145144.GF1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-2-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-2-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Not all devices (features) of the adp5585 device are mandatory to be
> used in all platforms. Hence, check what's given in FW and dynamically
> create the mfd_cell array to be given to devm_mfd_add_devices().
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 160e0b38106a6d78f7d4b7c866cb603d96ea673e..806867c56d6fb4ef1f461af26a424a3a05f46575 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -17,7 +17,13 @@
>  #include <linux/regmap.h>
>  #include <linux/types.h>
>  
> -static const struct mfd_cell adp5585_devs[] = {
> +enum {
> +	ADP5585_DEV_GPIO,
> +	ADP5585_DEV_PWM,
> +	ADP5585_DEV_MAX
> +};
> +
> +static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
>  	{ .name = "adp5585-gpio", },
>  	{ .name = "adp5585-pwm", },
>  };
> @@ -110,6 +116,37 @@ static const struct regmap_config adp5585_regmap_configs[] = {
>  	},
>  };
>  
> +static void adp5585_remove_devices(void *dev)
> +{
> +	mfd_remove_devices(dev);
> +}
> +
> +static int adp5585_add_devices(struct device *dev)
> +{
> +	int ret;
> +
> +	if (device_property_present(dev, "#pwm-cells")) {
> +		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> +				      &adp5585_devs[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to add pwm device\n");

PWM is an acronym, it should be capitalised.

> +	}
> +
> +	if (device_property_present(dev, "#gpio-cells")) {
> +		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> +				      &adp5585_devs[ADP5585_DEV_GPIO], 1, NULL, 0, NULL);
> +		if (ret) {
> +			ret = dev_err_probe(dev, ret, "Failed to add gpio device\n");

Same with GPIO.

> +			goto out_error;
> +		}
> +	}
> +
> +	return devm_add_action_or_reset(dev, adp5585_remove_devices, dev);

We have 2 of these now.

Why do we need lots of unbinding functions?

What's wrong .remove() or devm_*()?

> +out_error:
> +	mfd_remove_devices(dev);
> +	return ret;
> +}
> +
>  static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct regmap_config *regmap_config;
> @@ -138,14 +175,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  		return dev_err_probe(&i2c->dev, -ENODEV,
>  				     "Invalid device ID 0x%02x\n", id);
>  
> -	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> -				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
> -				   NULL, 0, NULL);
> -	if (ret)
> -		return dev_err_probe(&i2c->dev, ret,
> -				     "Failed to add child devices\n");
> -
> -	return 0;
> +	return adp5585_add_devices(&i2c->dev);
>  }
>  
>  static int adp5585_suspend(struct device *dev)
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

