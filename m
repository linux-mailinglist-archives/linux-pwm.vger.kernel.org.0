Return-Path: <linux-pwm+bounces-5894-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B102AB3309
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 11:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8F917BA21
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2225D8F9;
	Mon, 12 May 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQiymcGQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537A25C80B;
	Mon, 12 May 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041698; cv=none; b=mQxgbBUk6vdilLWiT9K5RdiyelNtzy6AMj0fXywXZqK7IYwhTBRXg5gREFQaVgDJrfkvNRQM0QmiuVYUtyOk/K8BOgkxj4aCnbB6eM5XJigLl8J8UDP8/VxBclMgDslpBCWKhK94MCMSJDGQCpTUHwJkRh3vd0HfS9lXP+P2nsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041698; c=relaxed/simple;
	bh=YmCAbwyOKKCOtWmhkRLBy829s5QkGxOr0MC+PNYO3U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tpp5hBHsT7OGtxjiOC8EBQ3545hOX1RclxL3JIuL+EtgdJBcD8UUOLBcJ8Aff1enzq9JuBD3IRQyARvSD51r+BxjJbhgPNOdKUtf+LOR4WM2eyt+v6Db1M9siSBtxc7HajpwwBAQjeJR6j6617wnKNPeJbWnM9bt9xGZfXG7jIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQiymcGQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747041696; x=1778577696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YmCAbwyOKKCOtWmhkRLBy829s5QkGxOr0MC+PNYO3U0=;
  b=DQiymcGQWCa0IxCvHPvu1YVBjlbUVS6Bc/iNPq2bk+XjZvv+1bHdNTta
   ACdTR+po0A4BwTUyHeriWWnjDCedPRdEjExvttpWWd024nQ17BcV6AQRn
   zdcVRMJQmcBCZPjRm9/oFI4FRcGTqBMnpe2hdJMQbP/agsetyIPjm//sZ
   V0UvUchwCNhm6eQ29t+yIGPmD1hvyBF8cfIPbvOMrZG++DiFAZ0gIVkGC
   NHy2RbhwWt1hGudbMz35glFZxgQZKugSp1tPp67qp1lKwU6Jg3uk5DEj8
   53K8YbSgc356v2uMuJdKA8OP8gdySMCYjrnDUzprPosXjvJiIkuTxZZjK
   Q==;
X-CSE-ConnectionGUID: mNm96ilSQQqwEyzPGSjWeA==
X-CSE-MsgGUID: 8LvY2hPyTAeF9dPHAqONwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48947672"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="48947672"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:21:35 -0700
X-CSE-ConnectionGUID: /YbdnLXlRBeGXuDj1xlBgQ==
X-CSE-MsgGUID: DwVgNY1YSkOB3zIE/HlX0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142076489"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:21:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uEPLj-00000000sE1-1BwI;
	Mon, 12 May 2025 12:21:27 +0300
Date: Mon, 12 May 2025 12:21:27 +0300
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
Subject: Re: [PATCH v8 02/11] mfd: Add max7360 support
Message-ID: <aCG9lyaCGchBsqLE@smile.fi.intel.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 09, 2025 at 11:14:36AM +0200, mathieu.dubois-briand@bootlin.com wrote:
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.

...

> + * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

 * Authors:
	 Person A <...>
	 Person B <...>

?

...

> +	for (unsigned int i = 0; i < MAX7360_PORT_PWM_COUNT; i++) {
> +		ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +					MAX7360_PORT_CFG_INTERRUPT_MASK,
> +					MAX7360_PORT_CFG_INTERRUPT_MASK);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to write MAX7360 port configuration");

I think I already pointed out the missing '\n'.

> +	}

...

> +	/* Read GPIO in register, to ACK any pending IRQ. */
> +	ret = regmap_read(regmap, MAX7360_REG_GPIOIN, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read GPIO values: %d\n", ret);

Double ret in the message. Check all of the usages of dev_err_probe() in your code.

> +	return 0;

...

> +#define MAX7360_REG_GPIO_LAST		0x5F

> +#define MAX7360_FIFO_EMPTY		0x3f
> +#define MAX7360_FIFO_OVERFLOW		0x7f

Please, be consistent in style of the values.

-- 
With Best Regards,
Andy Shevchenko



