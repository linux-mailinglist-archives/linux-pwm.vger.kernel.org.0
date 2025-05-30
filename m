Return-Path: <linux-pwm+bounces-6196-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B39AC9552
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 19:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D11897A32
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBB2620C4;
	Fri, 30 May 2025 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAoAB/yo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8623E35B;
	Fri, 30 May 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627727; cv=none; b=dTFFD5haLdpcFuCeLmskP8Tg9YL/hhd8L0y1YGzKlMRrpp2Rew2ubdgY1X+NGhpZXggQMguZh1qFkmToP3IgMJZ8Q6I2KfuAlhxsK+UeIUnzC7ZjLZGIPTSsIgddVy1AOAP8DcNjq33Lwr76m2ygG+qTcT1EiLyGEuXAzQSpgfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627727; c=relaxed/simple;
	bh=ZSmFHBwhFGzgKE51DBXBeP8jyHst6UlJH9/neaURwa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojv/uP5q/P1Llz6ZQJDpabjgaRi4q6glhOkYnfM1d+RryHi45P67BySmyGounfBiaN158OdNEXkDIvsIQOnHD17PeRsejgmRRXnKqsf83+MRFKIzMb/cUHG7FlPSX/tlL7sWah5fF00R5ot4Qedrzxl6O4AVX9iSEFq2ORnGRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAoAB/yo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748627726; x=1780163726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZSmFHBwhFGzgKE51DBXBeP8jyHst6UlJH9/neaURwa8=;
  b=IAoAB/yoP4Eiia0bS6/ZTyXirQvzL8nHiAvCkA2vByq1P4A6zEiAPFru
   InmFmokCGZ1iBiYcxZLqgyhGQtiyu/zxB/A6L/veIdPgjBAmZ9pYRH+ID
   xsilGfRdeKJaWoJ98AS4tOeZnpuZivOoiGO1qXnV5JiHLmR4S5TiipjKb
   fEO4iMAkIN7ZubOsuRV2aoTkBaG297YpXnxcqlKQ8aKoCTPYs5I0Uoh0n
   yue2dXA2PjkOshRLn8nNdZG3ZRpv4woa7LlIGDCgSHk+uORHcOT5EmEin
   OPvhrcdVs73ITtosOPMsmbOlXy2coamx4xeil4mFoJyVcqUJdo+nVdj4p
   g==;
X-CSE-ConnectionGUID: 7DDJOM5QQ5ijiB1nj3GfRg==
X-CSE-MsgGUID: tkidEDKWQve8OiO7luFxWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="73259211"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="73259211"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:55:25 -0700
X-CSE-ConnectionGUID: 5KdW+ZeYR3Kf/KTr2z0UcA==
X-CSE-MsgGUID: SrlmHzGNQOugwsmwJqrvAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="148726373"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:55:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uL3wr-000000024ej-1SEu;
	Fri, 30 May 2025 20:55:17 +0300
Date: Fri, 30 May 2025 20:55:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v10 02/11] mfd: Add max7360 support
Message-ID: <aDnxBUDOYLQYiVaP@smile.fi.intel.com>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-2-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-2-ce3b9e60a588@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 30, 2025 at 12:00:10PM +0200, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



