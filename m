Return-Path: <linux-pwm+bounces-6199-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F08AC956F
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2E017CF3D
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697225E806;
	Fri, 30 May 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4tcP8Rm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BC194A65;
	Fri, 30 May 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628228; cv=none; b=iUM0wifWl5mazNjX04jJeIbTI5gMgRELiO4N0bJu517F6kjLwGlla9MDD14HfZQe3QSRYkNFzJTibwEOtYv9TkrMbTExsRVAk0dWKkPkAbsB6PuTBwDDDLqcWNdh7v1RixUL9q4v1TNoMnyYP5u6WZcNDLfUTZzU3Jm1Wva9BXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628228; c=relaxed/simple;
	bh=GsM+4Qr9aj4qagDnoyITSBIuLxhzdohf0nnOponVHEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvRsXG+IZ1bMVOMiNn7S4N2xAjQha0FTYTvQA6qlfkfdAN92KXwu8Nu8LRP5BeOgzfsAzJuiCZrdVTCQyaZ1eSFVIRKwCWrIH8yb3dm5VH0MLOMUGrfizkxFnab02IMryvs7eEPwOV+q2ev/VHh8fSBCBB2xE7clurQJFbJ7Y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4tcP8Rm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748628227; x=1780164227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GsM+4Qr9aj4qagDnoyITSBIuLxhzdohf0nnOponVHEo=;
  b=m4tcP8RmUAfrLzzW+O3jkGhOQTLiilpL2yBf08obkFN3O8yclOFc7Yae
   mOlqrkqIgcUlqVCdKJNBKU8hAwY8uEzvynEY7Ts2EkFCa1lazY0brZINs
   GQlk5Exo0rskTWRl3v/rTw1MZ+EQXsMi6azptaYUKL15seT5fw/jgmeNk
   /ziYcm6Wkhrwx5pSEhlJthO4UhL02pFCw7cNMt7NMjNLsxzr08UhzKMW8
   4wTSJEPGTyQC1CSQPhQWdwmEpq0mtspALwLCtkfs+Obht6GRW2lwsBf1M
   7aYQXVNZU3rabsXH70iWrGDwwfboB3OBDi/L6+egir/TyXXvHCtQdUjvC
   Q==;
X-CSE-ConnectionGUID: yaSt2uR1R0KHshN7Jy0N6Q==
X-CSE-MsgGUID: LzTh8hKAScqJGvA3p/b+Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="68278438"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="68278438"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 11:03:46 -0700
X-CSE-ConnectionGUID: CFxSeM/fTvK/Gb3vTQnePg==
X-CSE-MsgGUID: OJkQmo4dQGC92H0g53ilvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143922953"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 11:03:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uL44w-000000024lP-4BsB;
	Fri, 30 May 2025 21:03:39 +0300
Date: Fri, 30 May 2025 21:03:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v10 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <aDny-kJqiPq-Yyx9@smile.fi.intel.com>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-8-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-8-ce3b9e60a588@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 30, 2025 at 12:00:16PM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +#include <linux/gpio/driver.h>

Do we still need this header? I mean do we have anything used from it here?

> +#include <linux/gpio/regmap.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

-- 
With Best Regards,
Andy Shevchenko



