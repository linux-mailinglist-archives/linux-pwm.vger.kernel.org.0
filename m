Return-Path: <linux-pwm+bounces-6011-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E3CABBEE1
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6364F177A4F
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA9E1FF5E3;
	Mon, 19 May 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWZp2DNA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B094B1E5D;
	Mon, 19 May 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660577; cv=none; b=G4EAHdONhNFAi65hgihYmKA7MNca+v1q/BNizlgDnYkHZmfQcCq9eVNMGVNIWhDrc3eV+0D2zAsAAKc3J49EjH439Ex7e7cm6k9KaTUffgi7vOmgCxYoXttwPtgeE6ZAfGlvoCp55HiPA6CXnPsFL+cY07/gQefGuv9fuBWKJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660577; c=relaxed/simple;
	bh=ogWjSLxu7py9vXqhqvINLZdmJ6ZVmgjkrck9dp6QUmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgCtMP3BoGJHkwVTYlz6bVCAeTnS6Bv7DS5NsShgA1WSuqy4q8P4QBkEyBlCB+vWflMacwCVaQplckNvalL1WhJ8ujt48ozGjJkyH7jNYkJr8XXkwbs4Jl5eU5amXVJjG1dNRxGvx/iiGuVsr6uhMJlSg5bZCgHsexsKIsTQ6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWZp2DNA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747660576; x=1779196576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogWjSLxu7py9vXqhqvINLZdmJ6ZVmgjkrck9dp6QUmU=;
  b=lWZp2DNATHdO6ngLIRE1uz2GqX/lSe/fjKYrjbTYol328/tfIC9WWn6Z
   s6uZc8lTWWSKZ1s6xytCTxwkcobERJy8SHJwwUXcLf27jTyN5USTWnF76
   /PsLjbwXC6J53c9brqO15hkVExoPJ0BHz6lv7LMt6Eh+nsfJd5VTBcp3c
   Q7zEnHd5iCsVeSe4aYiBJws99eQQJcIAgQbUn3QkYESFQkVHxahrRU8YK
   6cdfa8FsdPjHtLZG3gNhEgGWCRZ/H3SM98rWwkA65lhAwvtjkpwWnZVVn
   8EFw6S6Mye9jFuF/YFZ1t7EME+S3N+J2KVhqsyhSgtdeSdYD+u+agHP6n
   Q==;
X-CSE-ConnectionGUID: rO0EXWvGQteZtAh3WGY/EA==
X-CSE-MsgGUID: bx6yzCXqSOCAUf8hNtm+GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49713617"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49713617"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:16:15 -0700
X-CSE-ConnectionGUID: IAZnWNKBRnGr5U+JbrJgXQ==
X-CSE-MsgGUID: 69qDaHfSSOih0Akug32VWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144619329"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:16:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uH0Lf-000000032yq-2XB5;
	Mon, 19 May 2025 16:16:07 +0300
Date: Mon, 19 May 2025 16:16:07 +0300
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
Subject: Re: [PATCH v8 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Message-ID: <aCsvF_fE-0wuDoiK@smile.fi.intel.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-6-bbe486f6bcb7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-mdb-max7360-support-v8-6-bbe486f6bcb7@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 09, 2025 at 11:14:40AM +0200, Mathieu Dubois-Briand wrote:
> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.

...

> -		memcpy(d->prev_status_buf, d->status_buf, array_size(d->prev_status_buf));
> +		memcpy(d->prev_status_buf, d->status_buf,
> +		       array_size(d->chip->num_regs, sizeof(d->prev_status_buf[0])));

Shouldn't this be fixed in the previous patch which mistakenly used
array_size(x) with one argument?

-- 
With Best Regards,
Andy Shevchenko



