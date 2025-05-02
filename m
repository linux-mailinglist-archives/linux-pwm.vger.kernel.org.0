Return-Path: <linux-pwm+bounces-5804-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EFAA6F71
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E442518909D9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43A23C8B3;
	Fri,  2 May 2025 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWBYPJSH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6D22D78B;
	Fri,  2 May 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181269; cv=none; b=NKvM4R+ZXX08S7jwBed8HUGWUZIFBnNIfFPcIZ6NfLdYkPkpO62o+V3d/iPaFrWNhvBBMQmUizs/sBO7LGDPS8zmGy+dwQmxRKoLltnjzPvLykn/KkAkAMYC53iGZ8MrBNxsRu2yda+rNsWaq/kohE+xY8+f/ce6S4SktXmgMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181269; c=relaxed/simple;
	bh=JftlqU+X1lkwtpcPees9ulcIeQsp44gXVHuV8u7PKL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8fg95xmeioFkMc1TV5dTWIMHlZlN22ye8WS2unSii8SuAqsmnDomPvzSIRtdy+MQBvr09FoUQwS0ILyL+ceR8CGW5+HKWjP/mO+WN1fo9+zwbpa2XbJn2GKfdDMBBsY5zWCYa/qCP4+qkqgDmcHLLc6YdYlxLgLUVNssbvUKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWBYPJSH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746181265; x=1777717265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JftlqU+X1lkwtpcPees9ulcIeQsp44gXVHuV8u7PKL0=;
  b=lWBYPJSHxueXg/OgeiwznW15rL0nhvYYH1YbeF60xLCWzgS51fx8LU6Z
   ThASKFXwRH9+ftgJtNVJvGVJSXIHyiNOeqTFFtSuy2k+nWfPBBvu+oStW
   mHNcSHurf4RPaEOF49D1QhEOByVBxtHMdlUNVkH7VX/wjaij8jJVslxac
   PvKlG6g25iLOJORlhu6cMOjRYZunqGyK7gGElSX0gYY/2/H0+Xbwsak0G
   jgs1ZPjS+AxGdbNNzfQKU36UlhAW3k21oPLme10aBXwbZBXLHwRyZjptl
   fqpb/N/Asj24r7XNfuvw2HSI9eUkkc8wpGQfmuQp0OJjl/0yDW/rJ4yO0
   w==;
X-CSE-ConnectionGUID: ReKdfsSiRReMWOW68hkimg==
X-CSE-MsgGUID: hhovnK/URFqA3IEvw5v9MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58070328"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58070328"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:21:04 -0700
X-CSE-ConnectionGUID: PpwB+9+XTYuiwk99hDx5xA==
X-CSE-MsgGUID: zrachVmQSCGLJGMNoFuVXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134526072"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:20:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uAnVn-000000029rV-2nXd;
	Fri, 02 May 2025 13:20:55 +0300
Date: Fri, 2 May 2025 13:20:55 +0300
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
Subject: Re: [PATCH v7 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <aBSch6c8xYN88lrH@smile.fi.intel.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-6-4e0608d0a7ff@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mdb-max7360-support-v7-6-4e0608d0a7ff@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 01:57:24PM +0200, Mathieu Dubois-Briand wrote:
> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.

...

> -#include <linux/array_size.h>

Stray change?

>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/overflow.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>

-- 
With Best Regards,
Andy Shevchenko



