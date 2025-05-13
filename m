Return-Path: <linux-pwm+bounces-5948-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4E6AB573E
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA79189037A
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027E1A238E;
	Tue, 13 May 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSQ7KQ8z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE425634;
	Tue, 13 May 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146896; cv=none; b=spqlWr2pMsFh6W9fja0wG2RdGJEndfhPXc4yG11cWuH0xopjjG8vYrjx+n/f4c/T2YDlBESuK1f9wzMGJfJ8SC1d+pMInoixK6YahzDc6EktFYpM7bTWHgxziupOuU+pfSxRSGpj/rMRdRI2U2g0BTH+t0/+2Hn9iAerg7Pk/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146896; c=relaxed/simple;
	bh=IE5o0WcG/KQo9BSO7pVSURqXmZa0ZymYKX0O/Q8iJ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckhj3rqbvwKWVpyUoGw5vREXGampwTD7ZbdRTfm4rTPN6CpIdgavSkj4uba91uIAxUSlP4RmqKclNiRbKp9ICczSwamP+D0yV5oIaTZBU3YN1R61jO1yCJEqJ0bOnEgKAj63p+vQ2+IW5eI6DYsKF8wL1eMWGSaXoCzz2FwL02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSQ7KQ8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A301C4CEE4;
	Tue, 13 May 2025 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747146895;
	bh=IE5o0WcG/KQo9BSO7pVSURqXmZa0ZymYKX0O/Q8iJ+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSQ7KQ8zOx4hlCZOCrQobANyF9Z1ABF64uV1k4KRUQMMVvru21j6ziIa9281wExeU
	 segMZtXCRGhWzuK2MshwJAPZISPUTUkG91Nh1wChLxw0ib1B6ws17ERGxFE9h0hoxR
	 TOwKI1gfsu3A5PIQkSJHWhwH7i/F5SmGpOZcFCXWO/kd9HdIUlYY/B3NgOBDhnVkV9
	 5sTEiAob1Vn+8YcITHfy7Hdyw1ebTMg9C0gpxZgLm6zvvqPwIg7o+IH2jdz893NmV8
	 IOaY9VwS/hS6NmpTzfu4m+3MwB5foyePdDn6mXwVdLzlCEm9hYlXl9HsvwBkmWz4Zf
	 /HNaYMK7GHMOA==
Date: Tue, 13 May 2025 15:34:50 +0100
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
Subject: Re: [PATCH v3 02/22] mfd: adp5585: only add devices given in FW
Message-ID: <20250513143450.GM2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-2-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-dev-adp5589-fw-v3-2-092b14b79a88@analog.com>

On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Not all devices (features) of the adp5585 device are mandatory to be
> used in all platforms. Hence, check what's given in FW and dynamically
> create the mfd_cell array to be given to devm_mfd_add_devices().
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 45 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 160e0b38106a6d78f7d4b7c866cb603d96ea673e..02f9e8c1c6a1d8b9516c060e0024d69886e9fb7a 100644
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
> @@ -110,12 +116,40 @@ static const struct regmap_config adp5585_regmap_configs[] = {
>  	},
>  };
>  
> +static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
> +			    struct mfd_cell **devs)
> +{
> +	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
> +
> +	if (device_property_present(dev, "#pwm-cells"))
> +		has_pwm = 1;

This is a little sloppy.  Instead of using throwaway local variables, do
what you're going to do in the if statement.

> +	if (device_property_present(dev, "#gpio-cells"))
> +		has_gpio = 1;
> +
> +	if (!has_pwm && !has_gpio)
> +		return -ENODEV;

Are we really dictating which child devices to register based on random
DT properties?  Why not register them anyway and have them fail if the
information they need is not available?  Missing / incorrect properties
usually get a -EINVAL.

> +	*devs = devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct mfd_cell),
> +			     GFP_KERNEL);
> +	if (!*devs)
> +		return -ENOMEM;
> +
> +	if (has_pwm)
> +		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_PWM];
> +	if (has_gpio)
> +		(*devs)[rc++] = adp5585_devs[ADP5585_DEV_GPIO];

Passing around pointers to pointers for allocation (and later, pointer
to functions) is not the way we wish to operate.  See how all of the
other MFD drivers handle selective sub-drivers.

> +	return rc;
> +}
> +
>  static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct regmap_config *regmap_config;
>  	struct adp5585_dev *adp5585;
> +	struct mfd_cell *devs;
>  	unsigned int id;
> -	int ret;
> +	int ret, n_devs;
>  
>  	adp5585 = devm_kzalloc(&i2c->dev, sizeof(*adp5585), GFP_KERNEL);
>  	if (!adp5585)
> @@ -138,9 +172,12 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  		return dev_err_probe(&i2c->dev, -ENODEV,
>  				     "Invalid device ID 0x%02x\n", id);
>  
> +	n_devs = adp5585_parse_fw(&i2c->dev, adp5585, &devs);
> +	if (n_devs < 0)
> +		return n_devs;
> +
>  	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> -				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
> -				   NULL, 0, NULL);
> +				   devs, n_devs, NULL, 0, NULL);
>  	if (ret)
>  		return dev_err_probe(&i2c->dev, ret,
>  				     "Failed to add child devices\n");
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

