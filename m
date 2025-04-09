Return-Path: <linux-pwm+bounces-5425-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70FA82CB6
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EB13AE464
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59D26B2C6;
	Wed,  9 Apr 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ladNj8dJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5544155389;
	Wed,  9 Apr 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216772; cv=none; b=K+nFdeY7Y8ttWkIu9FXY+FLhN5o9e0+1fsZ4vk1Ty3VUi66tOPJXfJ4SZLTL70tfP78YAWzE9bpMLVwvQK6KLwXApKaeVWCuRBfvSFwjtwfOCbQzl0h6Cd0q8V46mzJ8pkF7N/Tx5oZt2ejf9veRBzrXOXKAOn0iwwGS3bXXXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216772; c=relaxed/simple;
	bh=JQWGaUGSOXk7m4AGrKeFSoUILg6o1trhdcespk5qxuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3BMIyf7j3UKLRJ5ZLSqFsmtUeaFI8LcQpIFsdMcFPK3VDgSgAMVmUrtnYyXEiISkB7XjeeG7A+FL4ITbf/0NpuxCbUsipHHyAV9awMezQidc//Er5ZURLYSBjwQlZ+lKe1EZv3+kUipcrdtDQjy985fzzF/S64jnL4Y7Ml+8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ladNj8dJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744216771; x=1775752771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JQWGaUGSOXk7m4AGrKeFSoUILg6o1trhdcespk5qxuI=;
  b=ladNj8dJVzD6wUMeA76ujQiOReid/CNTwZMwlFm5FiFzmuVQQmWd366H
   nh0yi4BmkiOLztGKtqFFyAD3HtOB6SAOQa9Dnq1R7rqJG2XiwQyJilcQ9
   xJhHRRFTMLGBWN1joC5cC/oqVihWT7F/Nh9QF/m9Q1CQSqwz+yU0VIHS9
   Y/Jx9b+LTk2nA0qGd3s88T191rV0ID4l+3l8BqfE+zkweEiWz98qlx6N7
   ig53jzT5NG+x9nb56dJxZtFp8tE+b8I6dyJoYawImjA4dcnYbeS2VsmG/
   58M2Yl+JbM5BvQdb5rndEMYdWgBvmArB6xp5JPTRh6/yx7ZdCzoPaEDFs
   w==;
X-CSE-ConnectionGUID: tXTvIyfARniZVi+iNfltww==
X-CSE-MsgGUID: rhNls1J6TG6ZhBNi79n1pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56338681"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56338681"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:39:29 -0700
X-CSE-ConnectionGUID: /7KtAMngRzalALCHu/4KQQ==
X-CSE-MsgGUID: WVy7fnV1Q1mCWzQ6+xKoDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128488422"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 09:39:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u2YSQ-0000000AnSb-0Oax;
	Wed, 09 Apr 2025 19:39:22 +0300
Date: Wed, 9 Apr 2025 19:39:21 +0300
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
Subject: Re: [PATCH v6 07/12] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <Z_aiubEgXLaDpsoq@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-7-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-7-7a2535876e39@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:55:54PM +0200, Mathieu Dubois-Briand wrote:
> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.

>  
> -		memcpy(d->prev_status_buf, d->status_buf, array_size(d->prev_status_buf));
> +		memcpy(d->prev_status_buf, d->status_buf,
> +		       array_size(d->chip->num_regs, sizeof(d->prev_status_buf[0])));

...

> +#ifdef CONFIG_REGMAP_IRQ
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
> +	} else
> +#endif
> +	irq_domain = config->irq_domain;

> +

This is blank line is not needed, but I not mind either way.

> +	if (irq_domain) {
> +		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
>  		if (ret)
>  			goto err_remove_gpiochip;
>  	}

...

> + * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure. If
> + *			set, a regmap-irq device will be created and the IRQ
> + *			domain will be set accordingly.

> + * @regmap_irq_chip_data: (Optional) Pointer on an regmap_irq_chip_data
> + *                      structure pointer. If set, it will be populated with a
> + *                      pointer on allocated regmap_irq data.

Leftover?

> + * @regmap_irq_irqno	(Optional) The IRQ the device uses to signal interrupts.
> + * @regmap_irq_flags	(Optional) The IRQF_ flags to use for the interrupt.

...

> +#ifdef CONFIG_REGMAP_IRQ
> +	struct regmap_irq_chip *regmap_irq_chip;
> +	int regmap_irq_irqno;

Perhaps call it line?

	int regmap_irq_line;

> +	unsigned long regmap_irq_flags;
> +#endif

-- 
With Best Regards,
Andy Shevchenko



