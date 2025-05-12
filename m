Return-Path: <linux-pwm+bounces-5893-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C900AB32E2
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30311890259
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37E25B660;
	Mon, 12 May 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niTPjWWk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15825B1EB;
	Mon, 12 May 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041429; cv=none; b=AsahrPOlKgOezZACQkvt6Xhby+2YIBQeWiZwLZ4TRsx+F6LQsRL6PIag/zinJ1kYxwuYZHhUZlpCa4usa6EBGnyYS4c8THXnf6HdIhMYVzQdzNUtskIZRfDRGJEoTZXe2hrLkmuNuLQIqa0L5S/ML8nVaidZ5eUpuSu44Q7v8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041429; c=relaxed/simple;
	bh=cgUSxdmTkxSWldGPZVwO4SD35vXXBfCC9O7HiCH+Pro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAOCaFUGvE3bMrf1/haj7cVdQtFeUaYYK9ykXESzLBJRLyfwUzwAuWXD9O5UMGGGpK3MrUw41h+IQJnn5fNHeJJ4rxxa/wO5kK3IEg5D0VhHZHhXd3o7tPy7b128UAZZQyumKftp8+Q54HvrGmCdXh0oeaHaC8SPlKiDJQZBK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niTPjWWk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747041428; x=1778577428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cgUSxdmTkxSWldGPZVwO4SD35vXXBfCC9O7HiCH+Pro=;
  b=niTPjWWkeSxaMbIoxVMIRiSNok9wnOlMBbeZHNBWPPUW5yU2kj4+DS9u
   FJ0vvpqige0q0kc3gPfHwGRq37kUeksMly3g/hQBHMdH12Tzu28LeRBWS
   xU6widoUrtb/ZB5meCfHsvd2ga3Mu6PhnGBVVKHFhNrq9R3N0x63bl5/L
   HqxgndUcxbTcoJmjCPV5PldGVz3un0zpk4nwPfE9+tX/UlqRQC1ri8Nd+
   nVxFxvktUGOphFHq7LRxg718tAAYU6d4xKF2EV9DrbIt1twtcn6SUkHhP
   UPpPzREXaVguxRcC2gjJGko4PiBjfz+xjc+vpkASN+TcVK+vEcf8lJjIz
   g==;
X-CSE-ConnectionGUID: YVDTJUd3ReGpMXtDKOlPOg==
X-CSE-MsgGUID: wAWsuRVEQtWF0T1yGc8CxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="66234206"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="66234206"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:17:08 -0700
X-CSE-ConnectionGUID: f7BfdpYJTnudnygZhtCYJw==
X-CSE-MsgGUID: J6JM5ZZ0Tkuif9fYGYnj5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="137816683"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:17:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uEPHP-00000000sAu-2meb;
	Mon, 12 May 2025 12:16:59 +0300
Date: Mon, 12 May 2025 12:16:59 +0300
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 03/11] pinctrl: Add MAX7360 pinctrl driver
Message-ID: <aCG8i-wjZZk48vDH@smile.fi.intel.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-3-bbe486f6bcb7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-mdb-max7360-support-v8-3-bbe486f6bcb7@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 09, 2025 at 11:14:37AM +0200, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
> can be used either for GPIO, PWM or rotary encoder functionalities.

...

> +#include <linux/array_size.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/device/devres.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

+ stddef.h

(you use NULL and true at least)

...

With the above being addressed
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



