Return-Path: <linux-pwm+bounces-6010-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F2AABBEDA
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C1717243E
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D252797A6;
	Mon, 19 May 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekwYgfZF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26C26B2B1;
	Mon, 19 May 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660447; cv=none; b=Is7AtuOpfThLMuGcznZ7w93ZeetrAY1ttr9dr5mD/4SuKB9RjQ9NJ9AUPtet2U6BgpIzJdF8XjaNx5gYXjeNMCpYy8ENp5G1PDZmiMIrb+voGoxaH6LVA2y0b71qixFKWSRxm2vzXZgMD9aPV45rxZh3hSnlFDz79GpasB+BkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660447; c=relaxed/simple;
	bh=B0hjycd+gDz5gL/oJ0YCIM5Us6vyjtKU+s+88TvJKQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5Yo1QwfftS8Kxp75jrC229jZbGxNbp0381+OGy9WBsI4p/2nNJKxMCDL9BzoQJILrRIFESlsgnfUCuWpCATfTAzrWG+k+zRcB3Rlc6NgXmCeEhe7qbUjKije+JsifCTfRNfH2j9J4QBzHcKn1gvfmc7C6i6DZESgPRTtuy0/8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekwYgfZF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747660445; x=1779196445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0hjycd+gDz5gL/oJ0YCIM5Us6vyjtKU+s+88TvJKQI=;
  b=ekwYgfZFA+IZl5npUXMtw8GiD43MBxGWAuM61eN26plzw3h5CPkZ8p/9
   znacFTBnAXVgCjdw9YUPOtF6Xi1WH+S2I3uVnhHRSsHiOoMC49ahKxjQW
   KcxsnpXdpv0doOcQ/MQ0e/uoSdZGsGnros0dzZ8hS5VjXkm2aDBJTj2J9
   InP0aa6/M2lhnbxxtheN+F7eh8mqcTun/NMS89gvD45C9XR+sFLvvOigb
   +O5N3KtAMJfWvTy2b92XToQpMTtkjKQZhPUcpCbXzaQZjYMpBZwooL05l
   uNSwPv7NJ8vHMtZ+FDmtWg0eT+2MAk7vNikEjJtXQ2bsLwe8Dy7assnkX
   Q==;
X-CSE-ConnectionGUID: 5xbF35acThiAFkdmiXYp9g==
X-CSE-MsgGUID: Lvqicw5aT4Smh+NyVzPOSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72065859"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72065859"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:14:04 -0700
X-CSE-ConnectionGUID: X55CUgJzQe+GzemWGmcFlQ==
X-CSE-MsgGUID: 7TAguaogT4KubksEfkQg1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="170272549"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:14:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uH0JY-000000032xA-2NTp;
	Mon, 19 May 2025 16:13:56 +0300
Date: Mon, 19 May 2025 16:13:56 +0300
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
Subject: Re: [PATCH v8 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <aCsulL7SJZI0odv9@smile.fi.intel.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-4-bbe486f6bcb7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-mdb-max7360-support-v8-4-bbe486f6bcb7@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 09, 2025 at 11:14:38AM +0200, mathieu.dubois-briand@bootlin.com wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.

...

> +	return regmap_write_bits(regmap, MAX7360_REG_PORTS, BIT(pwm->hwpwm), BIT(pwm->hwpwm));

FWIW, it may be replaced with regmap_set_bits().

-- 
With Best Regards,
Andy Shevchenko



