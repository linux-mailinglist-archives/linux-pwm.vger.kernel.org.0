Return-Path: <linux-pwm+bounces-2266-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A528D25C8
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22F91F24020
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651C17837F;
	Tue, 28 May 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U01JkwXn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CA13A89E;
	Tue, 28 May 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927845; cv=none; b=X5YkU37gJWv+4u0PirmK+4ac5DQh0FvNL2MBDVSZt9Dd83r2z7/Qv1Fmj1vT2hNfQbi/MJpWKTmQGKsnWYt1YiMpumswhzaQW3P66tW1CyOMptxrcA6xUfwPKjNUYWHNqITcmSxdw3LB9Xtjvv5/s/a38ZWICCYsbklycofi3xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927845; c=relaxed/simple;
	bh=QEA3LdlsKTXB5zo/JeUVOYRKQ65PZUx0xbgATCF+K0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwbbF7Mh/23riy4NYTNM30DWbdyR/ZdhupQlH3msWpKObHJ8RoH7skNZ5YBCRY7ZhuWsNqbe3bCzLhlT7irjm/kM+0R6wOhSe3hMojAW0Gite9TEEj6r0va8webiMAqHB3ua4G8lZWmgsG6cEi7T7VyMWryZW5SS+Wk23UmZD2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U01JkwXn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1EBB63A2;
	Tue, 28 May 2024 22:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716927839;
	bh=QEA3LdlsKTXB5zo/JeUVOYRKQ65PZUx0xbgATCF+K0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U01JkwXnk1dRTvYfhtVQzGrg9dtxI3GSal2GcjNgoQVvMhnIcGE63L/rFlgEu9TI9
	 1iWw257HR0g041lF4355jgn0wTtY3Yf+UaCLqn36RbVEefWK5xnEjz+CapBIwVkfbT
	 ivdAc+nrtC+YvticzlVFd8ekJILRZNBMqWB+vzhQ=
Date: Tue, 28 May 2024 23:23:50 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240528202350.GA17310@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-4-laurent.pinchart@ideasonboard.com>
 <ZlYyJpLeDLD_T5V6@surfacebook.localdomain>
 <20240528202044.GB8500@pendragon.ideasonboard.com>
 <20240528202216.GC8500@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528202216.GC8500@pendragon.ideasonboard.com>

On Tue, May 28, 2024 at 11:22:18PM +0300, Laurent Pinchart wrote:
> On Tue, May 28, 2024 at 11:20:45PM +0300, Laurent Pinchart wrote:
> > Hi Andy,
> > 
> > Thank you for the patch.

I meant for the review. It's getting late.

> > On Tue, May 28, 2024 at 10:36:06PM +0300, Andy Shevchenko wrote:
> > > Tue, May 28, 2024 at 10:03:13PM +0300, Laurent Pinchart kirjoitti:
> > > > From: Haibo Chen <haibo.chen@nxp.com>
> > > > 
> > > > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > > > matrix decoder, programmable logic, reset generator, and PWM generator.
> > > > This driver supports the GPIO function using the platform device
> > > > registered by the core MFD driver.
> > > > 
> > > > The driver is derived from an initial implementation from NXP, available
> > > > in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> > > > adp5585-gpio support") in their BSP kernel tree. It has been extensively
> > > > rewritten.
> > > 
> > > Why is this not using gpio-regmap?
> 
> I forgot to answer this:
> 
> I don't think it's a good match for the hardware.
> 
> > > ...
> > > 
> > > > +#include <linux/device.h>
> > > > +#include <linux/gpio/driver.h>
> > > > +#include <linux/mfd/adp5585.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > 
> > > + types.h
> > > 
> > > ...
> > > 
> > > > +	bit = off * 2 + (off > 5 ? 4 : 0);
> > > 
> > > Right, but can you use >= 6 here which immediately follows to the next
> > > question, i.e. why not use bank in this conditional?
> > 
> > The ADP5585_BANK() macro is meant to be used with ADP5585_BIT(), for a
> > set of registers with the same layout. Here the layout is different, the
> > registers contain multi-bit fields. I can't use ADP5585_BIT(), so I'd
> > rather not use ADP5585_BANK() either. I have decided to use > 5 instead
> > of >= 6 to match the R5 field name in the comment above:
> > 
> >         /*
> >          * The bias configuration fields are 2 bits wide and laid down in
> >          * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4 bits
> >          * after R5.
> >          */
> > 
> > > ...
> > > 
> > > > +	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
> > > 
> > > (see below)
> > > 
> > > > +	struct adp5585_gpio_dev *adp5585_gpio;
> > > > +	struct device *dev = &pdev->dev;
> > > 
> > > 	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
> > 
> > I prefer keeping the current ordering, with long lines first, I think
> > that's more readable.
> > 
> > > > +	struct gpio_chip *gc;
> > > > +	int ret;
> > > 
> > > ...
> > > 
> > > > +	platform_set_drvdata(pdev, adp5585_gpio);
> > > 
> > > Any use of driver data?
> > 
> > In v1, not v2. I'll drop it.
> > 
> > > ...
> > > 
> > > > +	device_set_of_node_from_dev(dev, dev->parent);
> > > 
> > > Why not device_set_node()?
> > 
> > Because device_set_of_node_from_dev() is meant for this exact use case,
> > where the same node is used for multiple devices. It also puts any
> > previous dev->of_node, ensuring proper refcounting when devices are
> > unbound and rebound, without being deleted.
> > 
> > -- 
> > Regards,
> > 
> > Laurent Pinchart
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,

Laurent Pinchart

