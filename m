Return-Path: <linux-pwm+bounces-5261-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0089BA6A40E
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 11:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E958887617
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B7222580;
	Thu, 20 Mar 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7iLOW5O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497C2080D9;
	Thu, 20 Mar 2025 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467712; cv=none; b=B8CBwvW54leWMUGgqH5SzY9UNAx1kEE5EDJFFW4lLSf7BGD8VyQVhRZJnu84Z0TTZcq3LuIZ1Yvw9yJA8PMsWPqLwBQCE8tbm6jMJNd7RVOQMeHB7Uj9kxLuYByUTzZhOuS7yHU0C+i1qqi4ZZJHs66wU4iByQ/reyBjhtpCvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467712; c=relaxed/simple;
	bh=YXf76glTiVLhkyc7lbXE2+pKrx3GYsR3bIlNF0cGzTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4VYU6MZKypxLHA0B4KCYvjTyVPSA6VAKet97azpA5hdGszKZ5iPCKmrydulq8neByUrpEwwbCYOThMem9l212fI7cnLdao1tlbIAYq+4uELQl96f1kf/7qSUhgK3gZshj6GQebDjDAV1Q3+HyTZAs2ijpEjoA3jn7g2eKtYxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7iLOW5O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742467711; x=1774003711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YXf76glTiVLhkyc7lbXE2+pKrx3GYsR3bIlNF0cGzTo=;
  b=O7iLOW5OmmxTKKl8e8BrTlqBfLv9X0YUzA4jKDEjWzrLXxlpUlBaPcQQ
   7c7tTihnIlYYhmL2jqYjmv/pJHNkqi/ZdRF2e5DtpvVkXXy12xjgoC4Eo
   zNPf6X81jB4Kw/fsT0aDpbeEXwQGIj32mvg5RKMCj5hAh6SLmnjtt9HXW
   7cGspFC0gsJmJgbBIVHEGuFMr1bILWl8thHBGea3lixjJCmCrvZbW4xv8
   +hhQhtR1aJUkHNsbKIMs5tWne0bHynRY0o3AR9wD2qNF3ZgWReqeNjqc5
   6Rd4eH6a7SixRGwfVnSarSwiFLwHmSXFlFgqBWxMbV6shIbGdLrsDeZXX
   A==;
X-CSE-ConnectionGUID: WvGSGFJdS/iEeGU9B2QbDw==
X-CSE-MsgGUID: 7my3w65pSfGe7m3hchTrXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="55067736"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="55067736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:48:30 -0700
X-CSE-ConnectionGUID: 8e2ihiKmRAKcZ+OnwvAfXQ==
X-CSE-MsgGUID: Pl152daVTTKnuQ8fxUuEhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="122778298"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:48:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tvDRl-00000004CLa-2QSo;
	Thu, 20 Mar 2025 12:48:21 +0200
Date: Thu, 20 Mar 2025 12:48:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: mathieu.dubois-briand@bootlin.com, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <Z9vydaUguJiVaHtU@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 08:50:00AM +0100, Uwe Kleine-König wrote:
> On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.com wrote:

...

> > > +	chip = devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
> > 
> > This is quite worrying. The devm_ to parent makes a lot of assumptions that may
> > not be realised. If you really need this, it has to have a very good comment
> > explaining why and object lifetimes.
> 
> Pretty sure this is broken. This results for example in the device link
> being created on the parent. So if the pwm devices goes away a consumer
> might not notice (at least in the usual way). I guess this was done to
> ensure that #pwm-cells is parsed from the right dt node? If so, that
> needs a different adaption. That will probably involve calling
> device_set_of_node_from_dev().

It's an MFD based driver, and MFD core cares about propagating fwnode by
default. I believe it should just work if we drop that '->parent' part.

-- 
With Best Regards,
Andy Shevchenko



