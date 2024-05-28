Return-Path: <linux-pwm+bounces-2262-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DCC8D2589
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B811C246B8
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08597178CC5;
	Tue, 28 May 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nMofiA1b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21510A3E;
	Tue, 28 May 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927224; cv=none; b=SepqxMxP82uoOdcFsOeJv0i67HV30I6occExiR85ZdNRQ3bOYVmRlLYfIAKtagU6hBzdBy0+ALWoad7jePJAUuOnjas7zYZmyeJYahXKzcUCbZJ6YbK95Q1Ckc53qDuQrRSsWIJyfnuuT2/O6ZDWSsQWariso46LIHhI7wCU9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927224; c=relaxed/simple;
	bh=5L3qsjsXrrwCrw7oASW9JBM1c2YSWZy3HEB/uxPOve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUdFQ9S2SEXEjpDoRuMXAGwEBFi2rLoPufWx0osy3tyrq9X0lRGGVX6z9VmClxYUf7Yd9O3j+JYWK3wh68t39HEK9Y4Xe6Fx4uUYnz7Lh5AX0FY/Aer1r7CfhTte+CNqH0Npsos2KfIjP3p/wqThW/G8FsOzkGiiABUTF29ouGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nMofiA1b; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 117D43A2;
	Tue, 28 May 2024 22:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716927217;
	bh=5L3qsjsXrrwCrw7oASW9JBM1c2YSWZy3HEB/uxPOve8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMofiA1bIHN2lh+NOTVMAvyYjG6razaHPOVM4c165dmxqPvkwsbm1NMr6Rt+y26bO
	 7Mh9JhFSniCHo2SuQFoGTVPUAmhSSRSOS0JGBBarh8fFFC4+UCXN5RmyUTab5Qgczh
	 dHdHaobzg8RqTrLm1nd/N+L47gk8qMjc5KHdZxEE=
Date: Tue, 28 May 2024 23:13:26 +0300
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
Subject: Re: [PATCH v2 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <20240528201326.GA8500@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-3-laurent.pinchart@ideasonboard.com>
 <ZlYwJryxeZ2LAKYG@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlYwJryxeZ2LAKYG@surfacebook.localdomain>

On Tue, May 28, 2024 at 10:27:34PM +0300, Andy Shevchenko wrote:
> Tue, May 28, 2024 at 10:03:12PM +0300, Laurent Pinchart kirjoitti:
> > From: Haibo Chen <haibo.chen@nxp.com>
> > 
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the chip by modelling it as an MFD device, with two
> > child devices for the GPIO and PWM functions.
> > 
> > The driver is derived from an initial implementation from NXP, available
> > in commit 8059835bee19 ("MLK-25917-1 mfd: adp5585: add ADI adp5585 core
> > support") in their BSP kernel tree. It has been extensively rewritten.
> 
> ...
> 
> > +	tristate "Analog Devices ADP5585 MFD driver"
> > +	select MFD_CORE
> > +	select REGMAP_I2C
> > +	depends on I2C && OF
> 
> Why OF?

Because the driver works on OF systems only.

> No COMPILE_TEST?

The driver won't compile without CONFIG_I2C, so I can use

	depends on I2C
	depends on OF || COMPILE_TEST

Do you think that's better ?

> 
> ...
> 
> + array_size.h
> + device.h // e.g., devm_kzalloc()
> 
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>

I'll drop those 3 headers, there's not needed anymore.

> > +#include <linux/i2c.h>
> 
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> 
> You don't need them, instead of proxying...

of.h for of_device_get_match_data() and of_match_ptr(). I'll drop the
former, but I need the latter, so I'll keep of.h

of_device.h for historical reasons probably, I'll drop it.

> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/adp5585.h>
> 
> m is earlier than 'o', but with above drop no more issue :-)
> 
> ...just include mod_devicetable.h.
> 
> > +#include <linux/regmap.h>
> 
> + types.h // e.g., u8
> 
> ...
> 
> > +	regmap_config = of_device_get_match_data(&i2c->dev);
> 
> We have i2c_get_match_data().

Sounds good.

> ...
> 
> > +#ifndef __LINUX_MFD_ADP5585_H_
> > +#define __LINUX_MFD_ADP5585_H_
> > +
> > +#include <linux/bits.h>
> 
> ...
> 
> > +#define		ADP5585_MAN_ID(v)		(((v) & 0xf0) >> 4)
> 
> GENMASK()

This is not a mask. Or do you mean

	(((v) & GENMASK(7, 4)) >> 4)

? I think that's overkill.

> ...
> 
> > +#define		ADP5585_Rx_PULL_CFG_MASK	(3)
> 
> GENMASK()

Not here, as this value is meant to be passed to ADP5585_Rx_PULL_CFG().

> Why parentheses in all of them, btw?

Probably for consistency, but I don't mind dropping them.

> ...
> 
> > +#define		ADP5585_C4_EXTEND_CFG_MASK	(1U << 6)
> 
> > +#define		ADP5585_R4_EXTEND_CFG_MASK	(1U << 5)
> 
> > +#define		ADP5585_R3_EXTEND_CFG_MASK	(3U << 2)
> 
> > +#define		ADP5585_R0_EXTEND_CFG_MASK	(1U << 0)
> 
> > +#define		ADP5585_OSC_FREQ_MASK		(3U << 5)
> 
> BIT() / GENMASK()

I'll use GENMASK for the masks.

> > +#endif

-- 
Regards,

Laurent Pinchart

