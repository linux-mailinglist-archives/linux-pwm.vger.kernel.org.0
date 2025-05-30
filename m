Return-Path: <linux-pwm+bounces-6198-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B00AC9561
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E64A1C0813E
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A0264628;
	Fri, 30 May 2025 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExCYCqwF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD1263F22;
	Fri, 30 May 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627996; cv=none; b=L+h2X+02ZHPuWHIUCsC96KU8TYuwvClIQkFIKbmibZi0z/3d/pamlOQ2bqVb8B/q1cEwMvXuqJaeA51m4Hy9enlRIEC/zfgKlFixxlctck7jkciRhnMppY+ydiS5Zs2cv7NuVPbnE0GEYVJHUEtaPQdULckPvqqOYw2d50W+kDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627996; c=relaxed/simple;
	bh=xCeJ5Vglsm6irF0mwmT43rFDodA/pQFWPdpsmdUFoRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9VQtZ6AfbWLvnRPmAmtJXpn+LwpmfAuhkZbFjMusw+9WqlPTZYkQQaEkouJ1NNoISaZu0RqPIfac7ZMZyunR4PApRuy7rwJtyGsA2iO2fY4ACJmr+NQdaEVfbgmobwxpAlQW3gr4YZ8kV9U6MzGFXeig/wwA/XCLvAFbbw4Oss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExCYCqwF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748627995; x=1780163995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xCeJ5Vglsm6irF0mwmT43rFDodA/pQFWPdpsmdUFoRc=;
  b=ExCYCqwFBEALLs1BVCDvnIOtHRU8iGuxRlT58LmZLElc0DGg/IvswPqy
   cKUmugGX1zgkyVs72ZSoAnmKmWyfNVzX/OyXkYzjN4t+JLemJlDtjzM6G
   FSn8XLte99uTiMmVcUotcbcoeyEprSxVcjKCCqtiTy1wKgDhIePHPToik
   plAv0uZl0KtHf4xm5PeWsSGk3wMJqoMj8W5JRvJC6xtncYyGmrxB7CrBJ
   C03sN3eUa3wzcHiO2zMFrUQl/smmWl5dRBiLCfs/lB+70ZAqRW0bBRRG8
   pyQY4dituH7nZQAORoruftUmE42eNzBXBoRycl/BRG+XJTLXYPyyVSwzq
   Q==;
X-CSE-ConnectionGUID: WSfeSjfxTOOvcnynT7vuCA==
X-CSE-MsgGUID: 8fk8xMW6RvaFeteoz0AHDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="76119620"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="76119620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:59:54 -0700
X-CSE-ConnectionGUID: BStgZrfJSV2s0h388ba6jg==
X-CSE-MsgGUID: mWxMyCHzTVeLT2n7zxELkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="174815925"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:59:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uL41D-000000024iG-1Vyn;
	Fri, 30 May 2025 20:59:47 +0300
Date: Fri, 30 May 2025 20:59:47 +0300
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
Subject: Re: [PATCH v10 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <aDnyE8p6jNIbxjbp@smile.fi.intel.com>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-6-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-6-ce3b9e60a588@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 30, 2025 at 12:00:14PM +0200, Mathieu Dubois-Briand wrote:
> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.

Looks okay to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



