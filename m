Return-Path: <linux-pwm+bounces-6326-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF2AD75DC
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 17:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731BC1887920
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88D298990;
	Thu, 12 Jun 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B//CU/O9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA929827D;
	Thu, 12 Jun 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741511; cv=none; b=Pg01YinOepyPY70J2DIdarUEhzjEybpKz0JXn0GQK8MmBT9Z0wAEx+1cMhYwk64TXwQ32188X0b9yIG00LIMw5671Q4xvJ7fSDa/5Xr3adNasdqVm9Ee0TJkHGrrNWZIADO8cTpHuFApr8CnzQ9HQTNSZ98mqBCONZh52H0Mo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741511; c=relaxed/simple;
	bh=FbhY2QR9Ge9sT7AznVigo8OUCoOekLoMdfaIP/6SVpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqQ2sAyQYmeZES26Mv8GbrItlDJKM6h8jXqs5pnhnVs2NlsXzBgl1/3pRWBdKRGG8pTWlXbI1XuEoLSaEjAWU+S3/xm+bfwnIk7MKRGYK24yvYpe+H8Y7JA4YeJ7+231flxyIpvwL349bZP7vguc9gUG6ZjA+bCNCGW9+VLjW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B//CU/O9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA32EC4CEEA;
	Thu, 12 Jun 2025 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741511;
	bh=FbhY2QR9Ge9sT7AznVigo8OUCoOekLoMdfaIP/6SVpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B//CU/O9L3vAXNK8cYOr6ndIN2zcAgPDpKj7ic24nC7yc2d+ecHMZ/0cMZJq841DA
	 s7CQZ+WUXYw4cBYlXbqqRJ4eKVzCyVW3JrU6woGRiaVzs6r6bsnRAnCZv20wNkVzK4
	 JZEgHh+wzweujH4ydWow9NSbiZuU9tZcfdwLIfp6RAZ0qz4Zt/b5n9mr1dicgisym5
	 wHMORlIPfm7ei5KeIKSRkfmp1PKelSzZDPg2x1xs5Q8wLbYbXSAU5B1s2d95yqtO4L
	 S43sEmNVa08iXo4mHmsbVj7kjtQaqWPTw3vHJJ1kIkN3MlItyfTsbbjPgmLUvxNr6X
	 OssD1FqAuB01Q==
Date: Thu, 12 Jun 2025 16:18:26 +0100
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
Subject: Re: [PATCH v4 20/20] mfd: adp5585: add support for a reset pin
Message-ID: <20250612151826.GN381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-20-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-20-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure to perform an Hardware reset during probe  if the pin is given
> in FW.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index e8b9a0ef4ee654ac1abc4042152fe0933f1d9f0d..164da0b804c4fce4e3af1ac0c2813020a77f4938 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mfd/adp5585.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mod_devicetable.h>
> @@ -697,6 +698,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct regmap_config regmap_config;
>  	struct adp5585_dev *adp5585;
> +	struct gpio_desc *gpio;
>  	unsigned int id;
>  	int ret;
>  
> @@ -718,6 +720,20 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return ret;
>  
> +	gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +
> +	/*
> +	 * Note the timings are not documented anywhere in the DS. They are just

"datasheet"

> +	 * reasonable values that work.
> +	 */
> +	if (gpio) {
> +		fsleep(30);
> +		gpiod_set_value_cansleep(gpio, 0);
> +		fsleep(60);
> +	}
> +
>  	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

