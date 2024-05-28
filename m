Return-Path: <linux-pwm+bounces-2267-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4B8D25CD
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67DD28FB21
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94267178CEE;
	Tue, 28 May 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wo4VN2K2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98D2FB2;
	Tue, 28 May 2024 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928040; cv=none; b=Uzakc5A03nrdOotzIAF+FlSwmkPldddz4d1XdlSmFHUYi/IhabUD0xi1DqwgKKdCGNjWomxEJpy06B9+ceSLVDPC9zDo7Q8U+dR7yE/xf/F6i/al6g+QyycClJPKmskrycnNkjbFzJwRAJEJl9YPjylCT9UrACHduylYpktEsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928040; c=relaxed/simple;
	bh=ng1KK8hoGzKhY/CnJBpcIhxZFQBXuXASuJ/7iv83bdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSJ7sSGp8DuSUclXU5+gVxQW7oTjzsef1mMxjw+YweazWd5j7daqCePxmHe7M4ocP8AvK3JjYCbwb2ueVo/l6KMEVcpXCcLb/jEGel4e0wp8ezUluM38HQoPQ6A/fkogULgvyaNgCu0U3Ur1EZ10qyhNcCtk4M7fzAPhCHlp+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wo4VN2K2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 174223A2;
	Tue, 28 May 2024 22:27:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716928034;
	bh=ng1KK8hoGzKhY/CnJBpcIhxZFQBXuXASuJ/7iv83bdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wo4VN2K2/jfvRBmntOmRe1UmxJW5yWlu5QglFlHPGsbQYEwimLt/mD75x5urGtgPJ
	 0n9mXgUl4lNztYURUglFCn/MjYnZVTLRkMLz7G+eRLcJlJa+dR0X9JRYJqXbREtB/p
	 KEljYncwasPDNqM6mvGcOzmUFHnxi70SNdkvB8kc=
Date: Tue, 28 May 2024 23:27:05 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240528202705.GD8500@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-5-laurent.pinchart@ideasonboard.com>
 <ZlYzf6mW8RF9w_R7@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlYzf6mW8RF9w_R7@surfacebook.localdomain>

Hi Andy,

Thank you for the review.

On Tue, May 28, 2024 at 10:41:51PM +0300, Andy Shevchenko wrote:
> Tue, May 28, 2024 at 10:03:14PM +0300, Laurent Pinchart kirjoitti:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> > 
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the PWM function using the platform device
> > registered by the core MFD driver.
> > 
> > The driver is derived from an initial implementation from NXP, available
> > in commit 113113742208 ("MLK-25922-1 pwm: adp5585: add adp5585 PWM
> > support") in their BSP kernel tree. It has been extensively rewritten.
> 
> ...
> 
> > +#include <linux/device.h>
> 
> + err.h
> 
> > +#include <linux/math64.h>
> > +#include <linux/minmax.h>
> > +#include <linux/mfd/adp5585.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/time.h>

You forgot to mention types.h :-)

> 
> ...
> 
> > +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
> 
> (1 * HZ_PER_MHZ) ?

If we had an MHZ macro I would use 1 * MHZ, but I don't think HZ_PER_MHZ
improves readability here.

> > +#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> > +#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> 
> Wouldn't be better to use GENMASK() or (BIT(x) - 1) notation to show that
> the limit is due to HW register bits in use?

I think that would decrease readability to be honest.

> ...
> 
> > +	ret = regmap_write(regmap, ADP5585_PWM_OFFT_LOW,
> > +			   off & 0xff);
> > +	if (ret)
> > +		return ret;
> > +	ret = regmap_write(regmap, ADP5585_PWM_OFFT_HIGH,
> > +			   (off >> 8) & 0xff);
> > +	if (ret)
> > +		return ret;
> > +	ret = regmap_write(regmap, ADP5585_PWM_ONT_LOW,
> > +			   on & 0xff);
> > +	if (ret)
> > +		return ret;
> > +	ret = regmap_write(regmap, ADP5585_PWM_ONT_HIGH,
> > +			   (on >> 8) & 0xff);
> > +	if (ret)
> > +		return ret;
> 
> Can be proper __le16/__be16 be used in conjunction with regmap bulk API?

What I would really like is regmap growing an API similar to
include/media/v4l2-cci.h. Any volunteer ? :-)

> ...
> 
> > +	/* Enable PWM in continuous mode and no external AND'ing. */
> > +	ret = regmap_update_bits(regmap, ADP5585_PWM_CFG,
> > +				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
> > +				 ADP5585_PWM_EN, ADP5585_PWM_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> 	return regmap_update_bits(...);
> 
> ...
> 
> > +	regmap_read(regmap, ADP5585_PWM_OFFT_LOW, &off);
> > +	regmap_read(regmap, ADP5585_PWM_OFFT_HIGH, &val);
> > +	off |= val << 8;
> > +
> > +	regmap_read(regmap, ADP5585_PWM_ONT_LOW, &on);
> > +	regmap_read(regmap, ADP5585_PWM_ONT_HIGH, &val);
> > +	on |= val << 8;
> 
> As per above, can it be converted to use proper __le16/__be16 type and
> regmap bulk API?

As there are only 2 registers, I think that's a bit overkill really.

> ...
> 
> > +	device_set_of_node_from_dev(dev, dev->parent);
> 
> Why this one? What's wrong with device_set_node()?

See my reply to 3/4.

-- 
Regards,

Laurent Pinchart

