Return-Path: <linux-pwm+bounces-5598-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEFFA94E58
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 10:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE1B7A263B
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC2213E91;
	Mon, 21 Apr 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="M9L9yFUQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2F213E76;
	Mon, 21 Apr 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745225883; cv=none; b=bOAPjpj/eObkj++vev0d0wW1bIalxiL4BUzq+ascXNsS7V4iPJX9i3Cvhtb9cYCM7ShzkuR22EifHeI4O58t0pU+OfqpVvzfOExZsWe9TvDnuvoQuvNd2w8vUpfsyKmqfMqyHs//jQsDTLrT4PWsxMqmQnht+2Zuvvlgrhgld+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745225883; c=relaxed/simple;
	bh=ygmT0Sf9GDX0U2wfYZWPkoxotvaF2Ip6k93c0ynToVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCp0Ex4p14ZFejxDobW2wPBBV3g3TIyeJ6Bhc8/m2jMUmf3Dqg4SZcBIDwoY4OG6uFwMyPKfXbEHFhXIvxhD0ANST3+TyHiyMa9T+wT9iQTsu5av1g079CsHwJoP8UnzCw/gNdz8bn7rmv6jMlNUVgTS5xJfL397CjRWtv0hQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=M9L9yFUQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7230C56D;
	Mon, 21 Apr 2025 10:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745225753;
	bh=ygmT0Sf9GDX0U2wfYZWPkoxotvaF2Ip6k93c0ynToVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9L9yFUQ0Ols/UiXPmFX2+DZoHYy1+CKYqqyz+NjEaZIhIeF2Ou6zL35ioBjvd3+n
	 VawJrLQju8+QrZQLHft/VC+J4H8tarcixuerq2wwlpUSMqmoCnE5HUsYmOkg04GIK6
	 rb1Ky0iWkvd8K68E34kMWUEoJHK2bOMGUbSN4sLk=
Date: Mon, 21 Apr 2025 11:57:58 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 02/17] mfd: adp5585: enable oscilator during probe
Message-ID: <20250421085758.GB29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-2-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-2-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:18PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure to enable the oscillator in the top device. This will allow to
> not control this in the child PWM device as that would not work with
> future support for keyboard matrix where the oscillator needs to be
> always enabled (and so cannot be disabled by disabling PWM).

Setting this bit unconditionally increases power consumption. It should
only be set when needed.

> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 160e0b38106a6d78f7d4b7c866cb603d96ea673e..f17b5f2474cac6a403556694066f438288264a49 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -110,6 +110,13 @@ static const struct regmap_config adp5585_regmap_configs[] = {
>  	},
>  };
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
> @@ -138,6 +145,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  		return dev_err_probe(&i2c->dev, -ENODEV,
>  				     "Invalid device ID 0x%02x\n", id);
>  
> +	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
> +			      ADP5585_OSC_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
>  				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
>  				   NULL, 0, NULL);

-- 
Regards,

Laurent Pinchart

