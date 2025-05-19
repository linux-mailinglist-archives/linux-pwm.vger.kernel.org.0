Return-Path: <linux-pwm+bounces-6012-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87AABBEF4
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 15:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C2E3A3C51
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5093279331;
	Mon, 19 May 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCAkhZj1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041511A83E5;
	Mon, 19 May 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660775; cv=none; b=LLuzJmnxSOBVfW+hIe41KGRuFOrJ1VkvY3DCyQdgbRCNx6d4h++nv+JKsakpHBJyq5aF/k6WGc9CgXeERE+ZZRVdDTIk3/thrbsIsUVUZXUVCw7w5yrYvILSAP0EdNrcgUDthjnFcA04frDkMOp9lYRXZZtuae5V2Rqn2vEcgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660775; c=relaxed/simple;
	bh=lMgcrPUdSRcfHOD+aZWOG+tFela1rati+BKxiKrpcEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt5ooNdrzISkz75CLdaY7+rcbPJq8C9ttY19caZc2nHYENacn6UbB2ZIy6ldVuEyHaTYv0Ov56aoTe+4bll0nbbJYo3Y+Bw/rbCkvOh/RhSwYLqx6hpL0JyIojPEMSFmBz08R3zNiWjmaEJ0jOZxpBe3uG9zGpUW8Jc7fSGkdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCAkhZj1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747660774; x=1779196774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lMgcrPUdSRcfHOD+aZWOG+tFela1rati+BKxiKrpcEI=;
  b=YCAkhZj1CJFWs2jSENE/hzZnW2H3Ef59MYQzRZRTCiji4vMU8AQnAMoS
   0oyRBdUkJMzMG57HtjHqvIHpPBpiOmDTIdVR6MDis2xeqTd8q8cPU4JDm
   T72umeXodv9Xm5i0VtXrHv/RLByF+zOfRKUmtp1uklK+yU+RABiSsIZw/
   B1q/5P4AsRBrtNlLiOg5N2Bblv2acQ3HuXXPYZ+G6MmTlGyUhLFS3KbWC
   TzVn2qXYvmcx4OzaBJS0uiw/nsIyIQKz/SEdzQnkJZXHG4KiZwJd0YNr8
   HWIXKiFj643yUpJCfpePUOFwWaicUuA2RxXXe4hEo9cPNZSwq1JWHl4ri
   w==;
X-CSE-ConnectionGUID: dLlMuemyRD+smsrY6kjznA==
X-CSE-MsgGUID: vfxiiHzvTCSESJ9enfsoJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60589711"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="60589711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:19:33 -0700
X-CSE-ConnectionGUID: kCEb/0Q5SOuF/fe049fuKQ==
X-CSE-MsgGUID: oI6uzQMCSvKzD70cbw+yRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139885490"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:19:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uH0Or-0000000331J-0uhR;
	Mon, 19 May 2025 16:19:25 +0300
Date: Mon, 19 May 2025 16:19:24 +0300
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <aCsv3Me2J8cotW6s@smile.fi.intel.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-8-bbe486f6bcb7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-mdb-max7360-support-v8-8-bbe486f6bcb7@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 09, 2025 at 11:14:42AM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.

...

> +	for (unsigned int i = 0; i < MAX7360_MAX_GPIO; ++i) {

Is there any special reaso to use pre-increment?

> +		ret = regmap_assign_bits(regmap, MAX7360_REG_PWMCFG(i),
> +					 MAX7360_PORT_CFG_INTERRUPT_MASK, mask_buf & BIT(i));
> +		if (ret)
> +			return ret;
> +	}

...

> +			for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {

Here, for instance, post-increment works good.

> +				ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +							MAX7360_PORT_CFG_INTERRUPT_EDGES,
> +							MAX7360_PORT_CFG_INTERRUPT_EDGES);
> +				if (ret)
> +					return dev_err_probe(dev, ret,
> +							     "Failed to enable interrupts\n");
> +			}

-- 
With Best Regards,
Andy Shevchenko



