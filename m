Return-Path: <linux-pwm+bounces-2403-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48727902512
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56D81F24CCC
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CB113A25F;
	Mon, 10 Jun 2024 15:12:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10606137747
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032322; cv=none; b=chnOhf4mK296jx7vAdgo2H88HwhEM8QpelZn9izJrtcFUrwF+dQ3nRNArI+Q1WW8SwTfGhdr5RE3krG8B2XeoYwwl6GbOaDZWLPG1oIitLzA+fH4QxtmMSxhucIJoqi2D5lWcLgF6gAsls6tjLZm/uHtSvT5PKg6PCUFnpwBDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032322; c=relaxed/simple;
	bh=pmr3IaJucK5vtXikM3GHEO/xGVGpp9EtqrqVvOdNDDk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGd1TU3lrbzNr50lXePJj/cXF66PewyiNqxPOupgLy3peI3rMhyw6GGAA00gorgo5TBYsOVyjF0nseu6JPMmRcQmswcKrwTc1HgivxW65YLYEu+QXlFulQderPmrnEpj38xs7+KhL3OrDvRBplRFISDkKYEX0iSjyDkWlctVbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id c7fddaa1-273b-11ef-ab0e-005056bdd08f;
	Mon, 10 Jun 2024 18:11:58 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Jun 2024 18:11:58 +0300
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v4 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <ZmcXvnVH6g2k8zam@surfacebook.localdomain>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-3-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608141633.2562-3-laurent.pinchart@ideasonboard.com>

Sat, Jun 08, 2024 at 05:16:31PM +0300, Laurent Pinchart kirjoitti:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the chip by modelling it as an MFD device, with two
> child devices for the GPIO and PWM functions.
> 
> The driver is derived from an initial implementation from NXP, available
> in commit 8059835bee19 ("MLK-25917-1 mfd: adp5585: add ADI adp5585 core
> support") in their BSP kernel tree. It has been extensively rewritten.

...

> +#include <linux/array_size.h>
> +#include <linux/device.h>

+ err.h

> +#include <linux/i2c.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...

> +static const struct mfd_cell adp5585_devs[] = {
> +	{ .name = "adp5585-gpio", },
> +	{ .name = "adp5585-pwm", },

Inner commas are not needed.

> +};

...

> +#define		ADP5585_Rx_PULL_CFG_PU_300K	0
> +#define		ADP5585_Rx_PULL_CFG_PD_300K	1
> +#define		ADP5585_Rx_PULL_CFG_PU_100K	2
> +#define		ADP5585_Rx_PULL_CFG_DISABLE	3
> +#define		ADP5585_Rx_PULL_CFG_MASK	3

Still supplying MASK is strange, why not supplying DISABLE?

...

> +#define		ADP5585_OSC_EN			BIT(7)
> +#define		ADP5585_OSC_FREQ_50KHZ		(0U << 5)
> +#define		ADP5585_OSC_FREQ_100KHZ		(1U << 5)
> +#define		ADP5585_OSC_FREQ_200KHZ		(2U << 5)
> +#define		ADP5585_OSC_FREQ_500KHZ		(3U << 5)
> +#define		ADP5585_OSC_FREQ_MASK		(3U << 5)

GENMASK() ? And possible the similar question as per above.

-- 
With Best Regards,
Andy Shevchenko



