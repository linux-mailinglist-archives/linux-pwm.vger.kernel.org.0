Return-Path: <linux-pwm+bounces-5801-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C670AA6EE9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966491BC2B3C
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE47238C35;
	Fri,  2 May 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SC1Nfr1l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CB22F75D;
	Fri,  2 May 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180649; cv=none; b=dNcSXqW+ZEGHmfbIUx6mkNvjlSrokWpADYLBFeYEoP4TMBuI/O+Yn76SiLFInq2UJWazupjvSXW/APm+2BbmqO7BeQGiXGirX1uzusTlDEA65aAHlWoB7t2zCtovUEVGAYdZKH8H91zCylACAPds7ZIhxObz3UCJEsPt2b4gJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180649; c=relaxed/simple;
	bh=qHAmWPQCH97BfabOz0qFatrzpcgkJenIfkkBV9GeOic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAQs0U1bOetFnF0eZ7JAg2CLzSMo2RTaFPHLaMqdS/H7aKXQp/MgWURyg06M9BVxO+vgxDKMCbpheeT+WJUvjneKt463UHjANb36DmdLvSW2LefsfzWLdEYD6wHChK5UBZpgFu72KqUpZjDPQBjZQw+qeQcQ740zVjQR9pusmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC1Nfr1l; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746180648; x=1777716648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qHAmWPQCH97BfabOz0qFatrzpcgkJenIfkkBV9GeOic=;
  b=SC1Nfr1lIk1fpKRrWJqZ4coZ/J0Xc+u8WLbWVk9O6bkBoXPpOw39q3PY
   eUrbSRjMh+SO028wLqk2razZwCVGcSnOWaEkpSlTZX9zWcbNVFfwqVxMY
   SW8jWNscak/QUrEWfNohBdYFg0Fh959ZZTCeL/Q2VU6qSkB9oXQ9s+6IF
   M0vGp3o8i0+U6vVR6jSx0sKITeAeD4OQZmrpU2ushhDp5jOv9CZ9AHQr+
   c3KHP9JKni2JzcJUiZk5w8D5NXAfvWtbrFSJPRkSDj3FUJpv6GKy2ncAZ
   r7pvH2d6Fi5YC4IVYJ/y5pQCE64eLO5WMHD0YQybhx5Gz1DFJ2mX8bY5H
   A==;
X-CSE-ConnectionGUID: kVhMJIF1QEyxsPGA7yKxBw==
X-CSE-MsgGUID: 26H3YNGBTB23FOJAQmvhpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="35479003"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="35479003"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:10:45 -0700
X-CSE-ConnectionGUID: EtrVkBRvSPmre3d4OtL1QA==
X-CSE-MsgGUID: QNAdMcJ2TmmGeiGGX74sdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165670463"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:10:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAnLp-000000029iN-09bO;
	Fri, 02 May 2025 13:10:37 +0300
Date: Fri, 2 May 2025 13:10:36 +0300
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
Subject: Re: [PATCH v7 02/11] mfd: Add max7360 support
Message-ID: <aBSaHL8sbLrGyEzw@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-2-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-2-4e0608d0a7ff@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 01:57:20PM +0200, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.

...

> +static int max7360_mask_irqs(struct regmap *regmap)

So, AFAICS this is used only at probe stage...

> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	unsigned int val;
> +	int ret;
> +
> +	/*
> +	 * GPIO/PWM interrupts are not masked on reset: as the MAX7360 "INTI"
> +	 * interrupt line is shared between GPIOs and rotary encoder, this could
> +	 * result in repeated spurious interrupts on the rotary encoder driver
> +	 * if the GPIO driver is not loaded. Mask them now to avoid this
> +	 * situation.
> +	 */
> +	for (unsigned int i = 0; i < MAX7360_PORT_PWM_COUNT; i++) {
> +		ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +					MAX7360_PORT_CFG_INTERRUPT_MASK,
> +					MAX7360_PORT_CFG_INTERRUPT_MASK);
> +		if (ret) {
> +			dev_err(dev, "Failed to write max7360 port configuration");
> +			return ret;

...if it's the case, use return dev_err_probe(...) here...

> +		}
> +	}
> +
> +	/* Read GPIO in register, to ACK any pending IRQ. */
> +	ret = regmap_read(regmap, MAX7360_REG_GPIOIN, &val);
> +	if (ret)
> +		dev_err(dev, "Failed to read gpio values: %d\n", ret);
> +
> +	return ret;

...and here.

> +}

-- 
With Best Regards,
Andy Shevchenko



