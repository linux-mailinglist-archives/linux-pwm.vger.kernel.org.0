Return-Path: <linux-pwm+bounces-6197-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B859CAC955B
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BE89E1C3C
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD082263F3C;
	Fri, 30 May 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiCBF5PO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863225CC57;
	Fri, 30 May 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627889; cv=none; b=Zs3x+c3oV1Ix2mRLkHyCghV1FPVv5V9TtC6UlWuTS1yR9SrJsBo1LOh+c1/6CMf41XvuHcgE7vkos5i4WLFFRGjHyG3pozdgY39nGDohL8zlJxOy+uxr0hIdtQmWF5ZYJE/NeZYDuyn1WinvKHxbFkrpuHpWImfIMUHIOdkEvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627889; c=relaxed/simple;
	bh=3e/q5bHal7ziK2T31WoYJwIxhl30izAQYAHeNT4dv7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8eqiIQZPwIwnZUp6sfTz6h/zNkjqZx7X+mjGVOg6D8PSAXYlhZqXIZwcazPCBGWLEYJCkny3LK+W4dRUIVfz4oTaH2BO2BNvD1qWOLNyhJKWUQ1alS3GW7PlWsR4MIihVjdu06lzmnRFRB6ueMhdwD0ODFV4CSAar5dvv7dU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiCBF5PO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748627888; x=1780163888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3e/q5bHal7ziK2T31WoYJwIxhl30izAQYAHeNT4dv7w=;
  b=YiCBF5POkhwQmJHPDTKAIEns4OH02i5ECXsHCrwBVsi7I/UEA4qKE42B
   7e7zlvN+xgSL4z+9lbDVU5/kmHJCTAcqUGE4bGp17YnBo5kM3q7IFsH0N
   1gV1GsaeFkZjRxBUcYTOe0tQ/Pr/GkcJQcsp/oesGj15QVjaLP9ZAZOgs
   xEsod18dcqFdg6HjWuYrCRT8KBphGFyUL6Wxdkt5MDgK/2+7c1Q4JCKuj
   eRsymjVizB5RceQh0uDZaYWAPRo3+vvF4VWk9G2VCOj+s8fRA6aZdxX1O
   VKIQd3cOSKnD1WBxlSJgwknBrXUBQIpchu0u7ibtcVDdXDw3lX+d1FXy+
   Q==;
X-CSE-ConnectionGUID: 3669O4boQJ2Ly+CJ11nSCw==
X-CSE-MsgGUID: hxXv0lj6TS2lkUhLVbClGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="49849007"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="49849007"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:58:07 -0700
X-CSE-ConnectionGUID: eG7db9YHRQetSGIo/h+duQ==
X-CSE-MsgGUID: WoPmY/5QRRi9neB6cm1ebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143970644"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:58:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uL3zT-000000024h3-1tYn;
	Fri, 30 May 2025 20:57:59 +0300
Date: Fri, 30 May 2025 20:57:59 +0300
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
Subject: Re: [PATCH v10 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <aDnxp8czNi_1NsI7@smile.fi.intel.com>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-4-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-4-ce3b9e60a588@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 30, 2025 at 12:00:12PM +0200, mathieu.dubois-briand@bootlin.com wrote:
> 
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.

I don't like that OF node propagation, but I have no alternative to propose
right now.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



