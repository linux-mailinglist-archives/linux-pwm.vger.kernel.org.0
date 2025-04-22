Return-Path: <linux-pwm+bounces-5657-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414BEA9719C
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ED717FF40
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CD2900A9;
	Tue, 22 Apr 2025 15:50:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF4290086;
	Tue, 22 Apr 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337032; cv=none; b=b/hoQma2r28pJfbxBdYBtFv5nJx7GR24AYtl5dap5kROvt7G3WNlh5Q5eIrAKAQh10N0BQlPprfZoVCaDn0DyrEHJuPD8b3t7Ma6Y8ogdlL0hbXF0TlsZhjYVhATLnGWx5fiPruElwvu/MJEufRdZXpYaHZ++I38GioNx9PxhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337032; c=relaxed/simple;
	bh=X/Jm8EpGyPPW/TPBD8j9CgUl3gKs8re5bMeAjVZN3NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7MjQjZg5ICV9FMPU9S3vADcZF7WQCnOCpHe9ijDIpVqwziksG9jXyhYcUMioxfFuMQjI4fQJMWjzFryObDAtnOrlj/3Qa63x6cIPCXU3+btISR35jzDq7tBT+Ynsb4h3G2FhskgjUg/KCHNRtlxHlG99YygvFRZG7Vjb4viMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: nS2QrUHeQR6B1ayodn4d1Q==
X-CSE-MsgGUID: 2AyZxiO7SkquyZ5YFhZK1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="58267022"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="58267022"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:50:31 -0700
X-CSE-ConnectionGUID: jNzoMomCR2iiPXpLQhUytw==
X-CSE-MsgGUID: qt0fV3ONStmkyAJZsMGD8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="132594964"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:50:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7Ft6-0000000EloN-0apC;
	Tue, 22 Apr 2025 18:50:20 +0300
Date: Tue, 22 Apr 2025 18:50:19 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <aAe6u6NhAsgjaL5_@smile.fi.intel.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 01:34:46PM +0200, Jorge Marques wrote:
> Some devices have an internal clock used to space out the conversion
> trigger for the oversampling filter,
> Consider an ADC with conversion and data ready pins topology:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   ++++    ++++    ++++    ++++    ++++
>   ADC data ready      *       *       *       *       *
> 
> With the oversampling frequency, conversions are spaced:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
>   ADC data ready         *       *       *       *       *
> 
> In some devices and ranges, this internal clock can be used to evenly
> space the conversions between the sampling edge.
> In other devices the oversampling frequency is fixed or is computed
> based on the sampling frequency parameter, and the parameter is
> read only.
> 
> Devices with this feature are max1363, ad7606, ad799x, and ad4052.
> The max1363 driver included the events/sampling_frequency in
> commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
> and ad799x in
> commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
> hysteresis")
> but went undocumented so far.

So, it was no documentation for the nodes this change describes, right?

...

> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> +KernelVersion:	6.15

Then why don't you put the real version of the first release that has it?

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Some devices have internal clocks for oversampling.
> +		Sets the resulting frequency in Hz to trigger a conversion used by
> +		the oversampling filter.
> +		If the device has a fixed internal clock or is computed based on
> +		the sampling frequency parameter, the parameter is read only.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> +KernelVersion:	6.15

Ditto.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Hardware dependent values supported by the oversampling
> +		frequency.

-- 
With Best Regards,
Andy Shevchenko



