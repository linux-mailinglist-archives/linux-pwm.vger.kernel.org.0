Return-Path: <linux-pwm+bounces-4746-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE0A1D65E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 14:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD0316132E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB31FF1B6;
	Mon, 27 Jan 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8FteGDS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4DC14D28C;
	Mon, 27 Jan 2025 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983316; cv=none; b=d24kf4Nh+gcIxeoEx0ocueV7jyZBgoB9n+y4gAkgCIABhJlsSvx7eUUnzGf4rwkJJeCu+0kOdjhdYGyyN2nuTvSco9CAszVd4gYL8oYVln3psdNY+M9Jybu3cuW2xWboaCpu5ln2dtiKXtJySosyXrxJS0bKkCEJU7LOPPA8K2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983316; c=relaxed/simple;
	bh=ruKDBB/ak6pmW1LPzVm+BDwT1TyOif+0XXcN45ZksX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh5+bYc1OD+kYuwoSjgAB+tM5h0/G3lmxTDLfU+vOpPEB7bapuOR/BDQ4odlBbPRCPDYACYSeiB5m8R8mYrk7zqp4RHimIJ3zV6GMa31/0N/Opwu39xt7izkT/aYlLvxvQb24RXy3gcG6QY/Kh/sz1DUdgJMzd85EzCtyXCLegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8FteGDS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737983315; x=1769519315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruKDBB/ak6pmW1LPzVm+BDwT1TyOif+0XXcN45ZksX0=;
  b=E8FteGDSI7WOJGzKp+kSJrI/0UnNKUdRXTl8rY6MxciRLm8GJ9l3Y1zn
   1MZMrHGuf8Q8jfBcyfHlBMgUd/7albcbyHxKbB71cIIxxPkQBzwNiRuxk
   QtyU+sUL5ZvHeysru5iK+6lUNlxMpWa6JCl7OR6dr6UGu2WDGAJ6IOZ4b
   pI43CpkiWbm7T+FAJ3LjTjX6G85JxszTcQvPakaJBR9yaH1tat1vQIsOw
   jv9Xx3AwqOivF6/g1MTJumuGSFS4A87vCB9cCC8HzRuhj5II+m6z8Bkkd
   9k1YCpEvCOCjgJZaS3VMklrt99hKUFmVb8wlyOSVRUweRz7NLVhF/nrOM
   A==;
X-CSE-ConnectionGUID: e0nh4hYaS8+MvVMX2ReEuw==
X-CSE-MsgGUID: rVqf3iyUSdSZaZeI6Qxn5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38471281"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="38471281"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 05:08:34 -0800
X-CSE-ConnectionGUID: XwGk5npeRv6lDxQJux3tyg==
X-CSE-MsgGUID: KhkPbjKkTT+qmgWuW1Ja2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108242414"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 05:08:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tcOqp-00000005jSs-1Zkn;
	Mon, 27 Jan 2025 15:08:27 +0200
Date: Mon, 27 Jan 2025 15:08:27 +0200
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 4/7] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z5eFS9R7IeOMFSRr@smile.fi.intel.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-4-37a8d22c36ed@bootlin.com>
 <Z4-7KAUhfXUSmD9I@black.fi.intel.com>
 <D78MG8EQMSBU.2U6T5DXG2YJXI@bootlin.com>
 <Z5EdThjjifY7LkCC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5EdThjjifY7LkCC@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 22, 2025 at 06:31:10PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 22, 2025 at 02:04:35PM +0100, Mathieu Dubois-Briand wrote:
> > On Tue Jan 21, 2025 at 4:20 PM CET, Andy Shevchenko wrote:

...

> > Thanks for your review. I'm not sure you have seen it, but there is a v3
> > of this series. V3 of this patch can be seen here:
> > https://lore.kernel.org/all/20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com/
> 
> Thanks for sharing, I will look at it later this on next week.

Just answered to the GPIO patch in it. Waiting for v4...

-- 
With Best Regards,
Andy Shevchenko



