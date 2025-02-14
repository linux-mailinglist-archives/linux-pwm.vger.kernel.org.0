Return-Path: <linux-pwm+bounces-4916-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5676A362D6
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 17:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C15B3A6BCC
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464B2676CE;
	Fri, 14 Feb 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izeoMr9Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF32222AC;
	Fri, 14 Feb 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549916; cv=none; b=eMmKsSQ5usmH/MaDBT5i5nBKZMTzxbgqo12kq50gt0IIQIoclQoxz5/JUeSFNfiWpomO8oyStGKowZpwH49uvQH36YG+QBMLZVymOi7LCCf1JtOarjynyzq16FN6iXK1Pjo42qzF1ef5WpoI0JuQ1d9/G2mCkdzVmqfwDpk0nBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549916; c=relaxed/simple;
	bh=jvX3AyNlRNgADfVAUMashsnujrcJkMKHBJO128C+MeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwNkme3fj5PyurM3dpkmXg0p3D3joGxDc8pPQCfANs0DBbdy5TzQccB/rEZb+qemOuoUT+Wbr6y8MksfqGySfZAsfRi7Rn2g7Afv5O8aPbJzy1BX2d+20LK+niGKQkBGqaGhiQw8sgQpzGMlKR8knJmwDKaI0Mwy9a1kUEEWJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izeoMr9Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739549915; x=1771085915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jvX3AyNlRNgADfVAUMashsnujrcJkMKHBJO128C+MeI=;
  b=izeoMr9YvBkAwDU7bvy/YMA6Q4zAERaQtY2NEEtKH5AjvieGBxEtHnVC
   KQzD/PQdbB/v2K7PT2k6LWHBkxdrBIWB0fkqYugGmTKVxJg4rbXirI6hm
   gqGC3gIClYix5JBgUYFDZD/+A4U1l2VRv/wJ41hcdVRlVDRWlPxES6h0X
   R0AT6xqvIatpocR4YKWA9JmM9sBnIG3ZoLSdGxd+EhFeV7PrLQI3nEuxA
   SJY559W6O4h/eyI41MQ7krggjAB6PYQl3PNdAoOsqINg/STm3Z77dORVo
   Os9Wi/YrCejLpeyMyxN6B/5EQg1baG7QpKJlZmWrLv5znNjNnH8CtIaml
   w==;
X-CSE-ConnectionGUID: cZgYPiWPT8CuZQh2gWsLew==
X-CSE-MsgGUID: 94NYd8cVSRyjnbJZVM5E1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40175505"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40175505"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:18:34 -0800
X-CSE-ConnectionGUID: GB9KDTvDSdqi3rzcnQjwvg==
X-CSE-MsgGUID: oZnxCibiTL6IPuQay9hT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117622684"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:18:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiyOY-0000000BXg6-3MBG;
	Fri, 14 Feb 2025 18:18:26 +0200
Date: Fri, 14 Feb 2025 18:18:26 +0200
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
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z69s0vu_T_77q9X8@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z69oa8_LKFxUacbj@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 05:59:40PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 14, 2025 at 12:49:57PM +0100, Mathieu Dubois-Briand wrote:

...

> > +		ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
> > +		if (ret && (ret != -EINVAL))
> > +			return dev_err_probe(dev, -ENODEV,
> 
> Why shadowing the real error code?
> 
> > +					     "Failed to read maxim,constant-current-disable OF property\n");
> 
> It may be not only OF :-)

Btw, can you compare this approach and the below in terms of bloat-o-meter
against the object file size?

	// can be done without this as well, just the same string as a parameter
	const char *propname;

	propname = "maxim,constant-current-disable";
	ret = device_property_read_u32(dev, propname, &outconf);
	if (ret && (ret != -EINVAL))
		return dev_err_probe(dev, ret, "Failed to read %s device property\n", propname);

While the above is strong hint to the compiler, the below should give similar
result but by the duplicates elimination:

	ret = device_property_read_u32(dev, "maxim,constant-current-disable", &outconf);
	if (ret && (ret != -EINVAL))
		return dev_err_probe(dev, ret, "Failed to read %s device property\n",
				     "maxim,constant-current-disable");

-- 
With Best Regards,
Andy Shevchenko



