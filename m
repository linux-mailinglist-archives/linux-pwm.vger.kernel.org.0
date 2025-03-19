Return-Path: <linux-pwm+bounces-5238-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F175A68B4B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D911889627
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3DE259C93;
	Wed, 19 Mar 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNmgAyPS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979A259C87;
	Wed, 19 Mar 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382621; cv=none; b=aoFcjwW9H9L1nhbG1zM/VgWKY9lVgbdLL5BJgaVBhWMTGUoVgotXJZ+KH0KjAMl7wes0lkKTk9au8n4i1mCaOFkT0CCGhxCtsrZ1CymXw+TUlvAI5noI3Pbhrjk2cqNiUnENvURBnnltSVbTELBxNG8Osru6csMM4NwwgYizUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382621; c=relaxed/simple;
	bh=D2Cq8iIAp6HweR2nbmA1TB76dT/fH6luqINPIIVMPNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stD+POL0do2IYbMGf17k/79zFjI2JX3U2zeJ5gm+T1NYBxDtbsAL7g3b0+Aorc71nCBF56MgAkGPuvNZAj3vtbXZRNvYroLUSy25YVAGarPkwWAadRHGXNEg1ITS12UNMFCEARr772P6dhJ0hz2aV364p7MrzAq6tQZ+HpbYwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNmgAyPS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742382619; x=1773918619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D2Cq8iIAp6HweR2nbmA1TB76dT/fH6luqINPIIVMPNw=;
  b=iNmgAyPSl10PBHkXLvNhfsUZKOwDuGPS6ojpV5gzZ0FlQUbWnPDKn7/a
   k6qw66U/yrRqqXhgWRpd3k+bWDpha0j3TGIVXTX1u9IiE4YRWnpajzvk0
   osIaK0QF2jBslCwNWbKj70VHY/ls3pw/72x5D+rQ+KwfJJdznkOiR+IVe
   S+quwEzE7fREuM5/Sw+FILpbPZ58cIvGVGp4gYELyhoJNVUCAALRTEMJN
   5Ztf/wZwTD0d5V4EqbeEEVSK/TjoGhXNBaZmELTdXn+pnB3VCqm3bo1HP
   QerMNxKsdfvZfFRiGNaUzNa1OskQetUX5svUq6TIXpqZUVgArdCrf5GpX
   g==;
X-CSE-ConnectionGUID: KZh6o8Q5S9uEL2NxBejdPg==
X-CSE-MsgGUID: Lc2jgSF6SeanxSYND6WriA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43752257"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43752257"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:10:14 -0700
X-CSE-ConnectionGUID: F/1SQWZbROuCtQPRNY9oCw==
X-CSE-MsgGUID: foZQBo2fSGugTKGChOHigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122306576"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:10:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1turJG-00000003tmp-3xN5;
	Wed, 19 Mar 2025 13:10:06 +0200
Date: Wed, 19 Mar 2025 13:10:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mathieu.dubois-briand@bootlin.com
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
Subject: Re: [PATCH v5 02/11] mfd: Add max7360 support
Message-ID: <Z9qmDkwSpZHxwuQj@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-2-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-2-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:18PM +0100, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.

...

+ array_size.h

> +#include <linux/bits.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

Since it won;t make v6.15-rc1 anyway the above can be better specified as

device/devres.h
dev_printk.h

as device.h is monstrous.

+ err.h

> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max7360.h>

+ mod_devicetable.h

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...

> +	ret = regmap_write(regmap, MAX7360_REG_GPIOCFG,
> +			   MAX7360_GPIO_CFG_GPIO_RST);

I would suggest to leave it as a single line. In this and similar cases
when it is ~83 characters, it's still fine (and even for strict 80 there is
a documented exception)

...

> +		return ret;
> +	}
> +
> +	return 0;

Just

	return ret;

?

> +	ret = max7360_mask_irqs(regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not mask interrupts\n");

Hmm... As far as I can read this masks GPIO interrups. Does it do anything
else? If it's covered by the GPIO/pin control drivers, one want probably to
see that to be done there in the respective callback (init_hw_irq or alike,
I don't remember the name by heart).

...

> +#ifndef __LINUX_MFD_MAX7360_H
> +#define __LINUX_MFD_MAX7360_H
> +
> +#include <linux/bits.h>

> +#include <linux/types.h>

Do you need types.h here? I don't see for what...

> +struct device;

Neither this. Perhaps it's for the following changes? Then add when required,
not now.

> +#endif

-- 
With Best Regards,
Andy Shevchenko



