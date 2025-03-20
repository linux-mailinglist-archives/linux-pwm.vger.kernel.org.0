Return-Path: <linux-pwm+bounces-5263-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E24A6A44A
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857D519C3984
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA578224AF6;
	Thu, 20 Mar 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx7P3NC6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8AC223719;
	Thu, 20 Mar 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468157; cv=none; b=QGqKDbYRW9NgDb2QyEr335dLY7nzh1O+5CHPoOkgwSC7bmZQYKIVMjcyuh5c+GsCobc28Jl3F/itjgU6IvwM5nJV8z28pdTAgNh0F3JERAZIT9BcV30ikjEHqaB9Xcy8MipBzo9J3MaI0LoqlrWSFlsGQoPGiaEYkHl+A/IDqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468157; c=relaxed/simple;
	bh=ykoVgDYABDMVf/SIURuWh0/t3A52YR9TLAY2jzT42IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3BnDOpsILfdSqyxDvV+aWwFi0asETo8rEYHfpMD/CXWb4Ux1UBR8W8PpZ46kXHAbDOTGWPUpGk+yNelwjikfmJ04sz6Xh4xJ7SG9N3pI7HIzSV6OL4igss4cHZCkhh5BNk9yl7s/p7MefiA7Nio7RJg5HSEoP+UgzXCPmjClB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx7P3NC6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742468156; x=1774004156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykoVgDYABDMVf/SIURuWh0/t3A52YR9TLAY2jzT42IM=;
  b=jx7P3NC6KtxE2Gq2jdn6GtBtY7+Pnf/YAR9iA2HMuFnSYZWSzV9afNkA
   4n4bAyjgr4gnWxgqFlRKA2NnEnNqWtuRkEIoqY8QLRjg+0tgqQo88Jy3N
   6jVlRT4awgXEi1aeWpEM/vs1QiG9cpTiRLuxPc0WftF9DVgU4OO4UWQ6N
   rUTcEPOPtSwJi+m6cXq2cwT4n9ZMwg9LJgX/1l4x62pNWOQmxSpGpWQk+
   MukFOFeH+jo83ZpfAWCEdDIGzzLwzPi89tuv0fU1wsIq2V0NRE9plHJQ7
   +yiI8PZg1AwhXit271BQVT0nqbj4ZoSmnsRPfcJCvmVncAf0HiC53xaMs
   A==;
X-CSE-ConnectionGUID: 5bxIVbbKQXaIxYgK/kvxBg==
X-CSE-MsgGUID: V85bPgqzSAKEuKF6MnvJEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="55068172"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="55068172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:55:54 -0700
X-CSE-ConnectionGUID: vnYLPlG8Rx2+wpea+c4QCw==
X-CSE-MsgGUID: mMcbmQb4TJG2lYawul/ePg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="122780192"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:55:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tvDYw-00000004CRh-2cFn;
	Thu, 20 Mar 2025 12:55:46 +0200
Date: Thu, 20 Mar 2025 12:55:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <Z9v0Mv6hYna3Znq8@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
 <D8K23TCWC5TO.3T1YPKL3G0OY5@kernel.org>
 <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 09:35:15AM +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 19, 2025 at 8:15 AM CET, Michael Walle wrote:

...

> > Also, what is the advantage of this? Your caller doesn't have to
> > call devm_regmap_add_irq_chip_fwnode(), but on the flip side you
> > have to cram all its parameters in the gpio_regmap config. I'd like
> > to keep that small and simple (but still extensible!). IMHO just
> > setting the irq_domain is enough to achieve that.
> 
> This was a request from Andy on my previous series.

The benefit is deduplication of a lot of code. You may consider it the same as
GPIO library does with IRQ chip. This is just the same on a different level.

Besides the driver in this series, I would think of other GPIO drivers that
are not (yet) converted to regmap (partially because of this is being absent)
or existing drivers, if any, that may utilise it.

-- 
With Best Regards,
Andy Shevchenko



