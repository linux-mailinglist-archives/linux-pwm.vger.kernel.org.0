Return-Path: <linux-pwm+bounces-2261-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138DC8D250C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 21:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A5928F55C
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3017837E;
	Tue, 28 May 2024 19:41:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940F176FA5
	for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925316; cv=none; b=Kdd+e8CeWiMoG3+CYA4If/QkEyOJypgj8NWaD6/S4tJR+gHuQo+HpGX/gQ1f18HkkpBnQVWMd6LtBvJPRD8cEJ1iiAkXOoTmqEkA11VGEYJRfUNhJA8FqwYg9Q5iS1t+LQf0VKFPC9YefON+ubUCfh6H6WjgwtPosD2uZjL8BDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925316; c=relaxed/simple;
	bh=XL5XfZPSAColagJjESsQyLbsnaVT0FBnyZJo1Q2iBzs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k59fdhOnPNxguZdAtipj2EumXNviy1Fr59mL/fvriGLUvnsgN6ePRAHj6bE50cP5KKU9151kKYH76n5Zf3zmnMoA2/y/k/aPdCRxYtCjonQRphozuYIIAf9zL0RYXOcimAwjj+4GFb/vjt1PSosszHIP87RmUJycwan7mBTfadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 54d390ee-1d2a-11ef-aaf5-005056bdd08f;
	Tue, 28 May 2024 22:41:52 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 May 2024 22:41:51 +0300
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <ZlYzf6mW8RF9w_R7@surfacebook.localdomain>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-5-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528190315.3865-5-laurent.pinchart@ideasonboard.com>

Tue, May 28, 2024 at 10:03:14PM +0300, Laurent Pinchart kirjoitti:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the PWM function using the platform device
> registered by the core MFD driver.
> 
> The driver is derived from an initial implementation from NXP, available
> in commit 113113742208 ("MLK-25922-1 pwm: adp5585: add adp5585 PWM
> support") in their BSP kernel tree. It has been extensively rewritten.

...

> +#include <linux/device.h>

+ err.h

> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>

...

> +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U

(1 * HZ_PER_MHZ) ?

> +#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> +#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)

Wouldn't be better to use GENMASK() or (BIT(x) - 1) notation to show that
the limit is due to HW register bits in use?

...

> +	ret = regmap_write(regmap, ADP5585_PWM_OFFT_LOW,
> +			   off & 0xff);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(regmap, ADP5585_PWM_OFFT_HIGH,
> +			   (off >> 8) & 0xff);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(regmap, ADP5585_PWM_ONT_LOW,
> +			   on & 0xff);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(regmap, ADP5585_PWM_ONT_HIGH,
> +			   (on >> 8) & 0xff);
> +	if (ret)
> +		return ret;

Can be proper __le16/__be16 be used in conjunction with regmap bulk API?

...

> +	/* Enable PWM in continuous mode and no external AND'ing. */
> +	ret = regmap_update_bits(regmap, ADP5585_PWM_CFG,
> +				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
> +				 ADP5585_PWM_EN, ADP5585_PWM_EN);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return regmap_update_bits(...);

...

> +	regmap_read(regmap, ADP5585_PWM_OFFT_LOW, &off);
> +	regmap_read(regmap, ADP5585_PWM_OFFT_HIGH, &val);
> +	off |= val << 8;
> +
> +	regmap_read(regmap, ADP5585_PWM_ONT_LOW, &on);
> +	regmap_read(regmap, ADP5585_PWM_ONT_HIGH, &val);
> +	on |= val << 8;

As per above, can it be converted to use proper __le16/__be16 type and
regmap bulk API?

...

> +	device_set_of_node_from_dev(dev, dev->parent);

Why this one? What's wrong with device_set_node()?

-- 
With Best Regards,
Andy Shevchenko



