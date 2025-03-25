Return-Path: <linux-pwm+bounces-5281-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD61A705C5
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA94162D7D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A825332D;
	Tue, 25 Mar 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJJl+ED1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD920E30F;
	Tue, 25 Mar 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918320; cv=none; b=Iw3uuFP/e1S0uwDsqmX8Le8WmnQ27Sy12ncPP3AXyrBTQarOVnecWpW9erorzKbACaCl0SvFTLVfvTNU+Sjb0tRejBzqr/WNVnAIt+L/ZVEKatuiEXZqyByqx2/vq1mgGEKvLB5zgRo7gjT8xu5LvEdNxoBoB+tORIM3ys5gDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918320; c=relaxed/simple;
	bh=B5U+FnoyiD8ehcQwNrX3Bjp4on7HLO0Q7pE59+Vx5is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5wybZRBnlwsZ2N0q+On8kkqWjfXMvOC8FjALm08OOSZHD01NFf5a0M36HH2Fpd7lBgkhFmM7GY9iJX0mxrsBZ3o+D3jHAc0kkvwoJ5gvtnza+G0PdADIcUZOmIKNBIt/ORDcofZJjtBn/5I4yKSb6qAI4q2apq0LzMR2YDkD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJJl+ED1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742918319; x=1774454319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B5U+FnoyiD8ehcQwNrX3Bjp4on7HLO0Q7pE59+Vx5is=;
  b=WJJl+ED13g661dH+4Zso1nlB/UgQwA0JjhcDSCaU+/YOYvzhwrciKd+V
   a1Re4bWH2MfObE1qAVwSvEcTMqKFhmcRHzjaEiz24/wxqMlaNE8bW6Mx7
   A8XzCByoQsNDYn3cWgym8hZn8amcxAis9OL+/H12+ksWSH8YPD5ZII2h8
   mWgihlOm2k+SO+SQnPjqh/0IIph2xiO07/zRLXHlE67lKWdz1MWhP7i5I
   R3njqVKAhuVslDBgp2Gd0WhhcvAifUa3aiRSz291zCnFskWFoR9TJpr6M
   GRdopDY6fl7YBQcSDN28+fE1W519hpd/rUDtc1KtC4Ydp/9jjeWrj1KP3
   w==;
X-CSE-ConnectionGUID: VAITzi+CR2SHtF1HeBeQ3g==
X-CSE-MsgGUID: Uq+T3maRRte9eC6IMCGOgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55554972"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="55554972"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:58:38 -0700
X-CSE-ConnectionGUID: zM8aJLmCQ1uFZw0B+5Ks7w==
X-CSE-MsgGUID: P+HCHL29QAGv6ulPZo1Uag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124370501"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 08:58:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tx6fd-00000005nK4-12Ba;
	Tue, 25 Mar 2025 17:58:29 +0200
Date: Tue, 25 Mar 2025 17:58:29 +0200
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
Subject: Re: [PATCH v5 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <Z-LSpRq3M3YYGOsW@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-9-fb20baf97da0@bootlin.com>
 <Z9qybcY7VyQBvZMv@smile.fi.intel.com>
 <D8PFO3LSGWQD.38SX4PSHQ84W2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8PFO3LSGWQD.38SX4PSHQ84W2@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 25, 2025 at 03:57:01PM +0100, Mathieu Dubois-Briand wrote:
> On Wed Mar 19, 2025 at 1:02 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:25PM +0100, Mathieu Dubois-Briand wrote:

...

> > > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, max7360_keypad_irq,
> > > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >
> > What's wrong with the interrupt flags provided by firmware description?
> 
> So same question as for the GPIO driver: IRQF_TRIGGER_LOW from the
> firmware, but IRQF_ONESHOT from the driver? Or should everything come
> from the firmware?

The same answer, yes, the Linux stuff (e.g., ONESHOT) should be given
explicitly here.

-- 
With Best Regards,
Andy Shevchenko



