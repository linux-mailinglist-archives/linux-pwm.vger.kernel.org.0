Return-Path: <linux-pwm+bounces-5245-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31539A68C87
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 13:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FD87A3590
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138C25525C;
	Wed, 19 Mar 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxsaXVpc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED06253F3B;
	Wed, 19 Mar 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386375; cv=none; b=S4S/o8X+xGgN0erolsXefHAgN3GTdJGO6qRhm5f2DFQlYBgtGcDIbtexopQT2j519SG3kEWdZRyao3F2xtaQ4U4jrGTX2tH7hb3Ov8X00X4T4q0gLOjaROdkwfQ2e5U93FEstUDHzBmc1nfKTIEhDsdUqSmj4iT4UXHZVVKuNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386375; c=relaxed/simple;
	bh=XyggPwCijDiNFJm7OAqhl+qBwzpvs68k8l8uPxOuhZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ/0l6swl6Syxj5DLv4zv29YrmdcTmkoCFKPdkub3GaGqUrEs8hIKTB1ds07SMrcNnyXLvnUshGR5SJxwPHwHzScUYf16eCLuyNXtMRgEsc5CcwXWjKYe6vGEMTfefGe9AmVAXPhk4tqeLzJAnozhJebBCjDpmDZpTPFisFnBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxsaXVpc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742386374; x=1773922374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XyggPwCijDiNFJm7OAqhl+qBwzpvs68k8l8uPxOuhZA=;
  b=cxsaXVpcELxqdw9YoDP1ISsAWdI1JqKch/jkGk8pRuvHZTA6PgMFRdaD
   FT2TYLyQZOyZNHuNT2aX8Skj1bJ8OUpnAv/rnTP1mFEKgj5vgoENCJGUL
   nG/V2c7OzyKXAoSmhl7vJZwEC0mN3JM8tHoLmE5xCOpEqOYnYloJIQ3BW
   99UmjRCHO9Je1i6wi51h35vgV7LKWF9LWf1l3rawS6UQCtsvsHVPJQn9/
   GN7p7tnjkjUXFdaT3dI1F0L/Ewsn4sYPj6z55PV+4/vbdUSwKy9hI0I6G
   /L3AETPHcVirQ9mL1VhmAaeSOgjpfcovLSOc6NpDbTCwhZY+XBx6zlgYd
   Q==;
X-CSE-ConnectionGUID: bPxeHOKPT52iu/eMEKQ7HQ==
X-CSE-MsgGUID: 62y5wa8PQ7G94qRNdRl8mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="60962551"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="60962551"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:12:53 -0700
X-CSE-ConnectionGUID: LOvpcHDPTA2CgjjkOFZOxg==
X-CSE-MsgGUID: FPwA3/CDTQiJbAOLI5hrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="153612625"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:12:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tusHu-00000003uYX-0HZf;
	Wed, 19 Mar 2025 14:12:46 +0200
Date: Wed, 19 Mar 2025 14:12:45 +0200
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
Subject: Re: [PATCH v5 00/11] Add support for MAX7360
Message-ID: <Z9q0vZ07X2TfZQMv@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:16PM +0100, Mathieu Dubois-Briand wrote:
> This series implements a set of drivers allowing to support the Maxim
> Integrated MAX7360 device.
> 
> The MAX7360 is an I2C key-switch and led controller, with following
> functionalities:
> - Keypad controller for a key matrix of up to 8 rows and 8 columns.
> - Rotary encoder support, for a single rotary encoder.
> - Up to 8 PWM outputs.
> - Up to 8 GPIOs with support for interrupts and 6 GPOs.
> 
> Chipset pins are shared between all functionalities, so all cannot be
> used at the same time.

Thanks!

Skeleton more or less looks at it's stable phase, there are tons of the style
and small amendments that may be made. I would expect one or two at most new
versions of this series.

-- 
With Best Regards,
Andy Shevchenko



