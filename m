Return-Path: <linux-pwm+bounces-5233-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A57A67A13
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10C0188BCA4
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04D3211486;
	Tue, 18 Mar 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXNoSoNX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381E2101B7;
	Tue, 18 Mar 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316732; cv=none; b=mZjTx/s0AKIwBff3hjCym35BzlocYhj1hzPCPqKVUT2DerUf2NaiKGo4JxEsLjAhIGlCxAY68UbLezTtAzc22en4/U/kIvOZ2uJKtaj5qCeuv7Np2/GOcZ4RGcJ6U1rG5J867xdBJ3/cIySNuLapxzX80WhmW3wQi0MjLeMQRgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316732; c=relaxed/simple;
	bh=sJxGmsCzlQbtaK5p9maZTf45l3oFUBs5lM9b8tkt10k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLEGFq5SJJ9jF8B0OziawuqquCMWg4MjhTcqGhpqbF+Y7FedtIp0PYwypNSBjhDo1W5IF6URgZksWfoeVn9SaIWXDqiBpnz60p78psSbiDPVkBspzSsLzp+JQifD/TavdImNTjT4ZqhZd/iC3io2kSVmywM4MQ982nDQM8N3ASo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXNoSoNX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742316731; x=1773852731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJxGmsCzlQbtaK5p9maZTf45l3oFUBs5lM9b8tkt10k=;
  b=KXNoSoNXI/wRLEHPJUPKpFDWKuhXO+kD9kcp4f5dMh/5pCjHV7B+DH4H
   5yU02DsRhm6Sakv7cU+vbEWerbb795FWtOOOavRe0RxcVLw2hJW590d/S
   7OL6PnsIDB67zqQKcPJotRr5XBrFMCHOa2+8aRvV6KRoijEpGgRnAUQbZ
   XWNnb75KjqabRMPBiB5LHClHALIcXqyU5VrWe4sbxFOY2g9aTMPnseLyZ
   nhY7AZv8GA4FWFdGDTMuvAtxX04dj0E100Dsy8tUi5Ic0dboVydcdzcx2
   4JIhNbo1k/FgSZKr2DueYd+H6pGR6mZEZIswppezq/LWD4rBAhjtGMy/D
   A==;
X-CSE-ConnectionGUID: Fl9pkLhYT1G79Mdm4deHqw==
X-CSE-MsgGUID: p1VumzalSvKEFf/6Q2DOLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43356932"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43356932"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:52:10 -0700
X-CSE-ConnectionGUID: ssnJLS0kQq6W8j8hsfyLyA==
X-CSE-MsgGUID: tKdDZtiLSIOJXazlovvhFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="123073064"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:52:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tuaAc-00000003gTk-2rOS;
	Tue, 18 Mar 2025 18:52:02 +0200
Date: Tue, 18 Mar 2025 18:52:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <Z9mksuMAlNCa447h@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:22PM +0100, Mathieu Dubois-Briand wrote:
> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.

...

> -	if (config->irq_domain) {
> -		ret = gpiochip_irqchip_add_domain(chip, config->irq_domain);

> +	irq_domain = config->irq_domain;

Better to move it into #else, so we avoid double assignment (see below).

> +#ifdef CONFIG_GPIOLIB_IRQCHIP
> +	if (config->regmap_irq_chip) {
> +		struct regmap_irq_chip_data *irq_chip_data;
> +
> +		ret = devm_regmap_add_irq_chip_fwnode(config->parent, dev_fwnode(config->parent),
> +						      config->regmap, config->regmap_irq_irqno,
> +						      config->regmap_irq_flags, 0,
> +						      config->regmap_irq_chip, &irq_chip_data);
> +		if (ret)
> +			goto err_free_gpio;
> +
> +		irq_domain = regmap_irq_get_domain(irq_chip_data);
> +		if (config->regmap_irq_chip_data)
> +			*config->regmap_irq_chip_data = irq_chip_data;

Hmm... I was under impression that we don't need this to be returned.
Do we have any user of it right now? If not, no need to export until
it is needed.

> +	}

	} else

> +#endif

	irq_domain = config->irq_domain;

> +
> +	if (irq_domain) {
> +		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
>  		if (ret)
>  			goto err_remove_gpiochip;
>  	}

...

> +#ifdef CONFIG_GPIOLIB_IRQCHIP
> +	struct regmap_irq_chip *regmap_irq_chip;
> +	struct regmap_irq_chip_data **regmap_irq_chip_data;

But why double pointer?

> +	int regmap_irq_irqno;
> +	unsigned long regmap_irq_flags;
> +#endif

-- 
With Best Regards,
Andy Shevchenko



