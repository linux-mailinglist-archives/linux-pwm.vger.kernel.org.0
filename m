Return-Path: <linux-pwm+bounces-4870-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD580A329B3
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7788E164C5B
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD4213241;
	Wed, 12 Feb 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPkye97P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808A20E038;
	Wed, 12 Feb 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373320; cv=none; b=fTTTdwcpUhKFNLzh/nseyxDIrkZK5q6qUJN41921RvWtMM8YpvZl1n5wQ3huaM6hHuE9EZD9zaKLTPRZMmxGYb+Dq9kHLMpzRnubVRzLAWShNRUf4JU0tT3znmfcjzcAiiEyOd/GRwW9FKn86w3iF5HKOYEkmcgTcgnTqdzqoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373320; c=relaxed/simple;
	bh=36xnraS+6CjRXGXyxx9IPLW3xTJ9QTHCIwLdimGlQi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpjOxHfCFq5hqT8jbMKhkEJ5HDRXLoRGz2BeLn4vRb7sI2RwbSvqYqd7h56ofSA41jdJcsocOmH4TbXZ2Nien/fWHdeHJYfaSzSkkawy39sIffmiLMgD/KLoEfcbOWTxvycLXK8DDwSN/aYuxC5kHI4RuIXcrsvVQP7KAbsM9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPkye97P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739373319; x=1770909319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=36xnraS+6CjRXGXyxx9IPLW3xTJ9QTHCIwLdimGlQi0=;
  b=MPkye97PwPbC3QXTuif17NJuoVr4Vyw7ScO/3X2sh/YBvmltSmymMEtD
   hCyHjF3/Yk5sSGTb2BAM3au0/TqDwfJvf+w6dbTyyQbC+xsWMfMLuvG3j
   QlupUwRJyQpMTNbF1z06OSHtcpcMFmzrZll4qV63wtkkByc4gZlJoMIJt
   5djCmUHQYfP8zaWoJ/C9JEHnmapI4wfc8Ddet02Kzz8zo8swZLkHixptk
   BdWh5n6/mvPh8R1GF5DlnfPLtlHW8SjLL+ZptOgiwnoHqFufwCV1r4fxc
   YExmobPsXaZHTp6cDC0O5imwyt9Nq/AxsjamKWlyLYWYOFzwBugDAWf/x
   g==;
X-CSE-ConnectionGUID: COuVtPhUT7yfw/4vq/uVIg==
X-CSE-MsgGUID: CSsubyjKQ4SDfUiTTTFAsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40183840"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="40183840"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 07:14:54 -0800
X-CSE-ConnectionGUID: NvtxVxtuSYmAOoy7n70nOA==
X-CSE-MsgGUID: ZyAwoJg4Qj+b8TMPaP18dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112621912"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 07:14:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiERq-0000000As7i-0VFM;
	Wed, 12 Feb 2025 17:14:46 +0200
Date: Wed, 12 Feb 2025 17:14:45 +0200
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
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z6y65SnrprvnpKEa@smile.fi.intel.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <Z5eFGJspoGOINcG6@smile.fi.intel.com>
 <D7QHGB7D0VSG.X255SDU7DFOF@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7QHGB7D0VSG.X255SDU7DFOF@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 01:57:34PM +0100, Mathieu Dubois-Briand wrote:
> On Mon Jan 27, 2025 at 2:07 PM CET, Andy Shevchenko wrote:
> > On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Briand wrote:

...

> > > +	parent = to_platform_device(pdev->dev.parent);
> >
> > Why do you need this? Can't the fwnode be propagated to the children and then
> > the respective APIs to be used?
> 
> I'm not sure to understand this correctly, what do you mean by
> propagating the fwnode to the children?
> 
> Just a quick summary of the situation and what I try to do. The device
> tree looks like this, only keeping the interesting properties:
> 
> io-expander@38 {
>   ...
>   interrupts = <23 IRQ_TYPE_LEVEL_LOW>,
>                <24 IRQ_TYPE_LEVEL_LOW>;
>   interrupt-names = "inti", "intk";
> 
>   max7360_gpio: gpio {
>     ...
>   };
> 
>   max7360_gpo: gpo {
>     ...
>   };
> };
> 
> Our pdev fwnode points either to the "gpio" or "gpo" nodes, the one from
> our parent device points to "io-expander@38". Here we need to get the
> "inti" interrupt from the parent node. What would be the correct way to
> do it?

Ah, I see now. This is being used only for IRQs, but don't you want to call
actually fwnode_irq_get_byname()? It will makes the intention clearer.

...

> > > +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> > > +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> > > +		return -ENODEV;
> > > +	}
> >
> > This is not needed, it is already done in GPIOLIB core.
> 
> I believe this is still needed:
> - For gpos, we need the gpio count to correctly set the partition
>   between gpo and keypad columns in max7360_set_gpos_count().

Shouldn't be that done somewhere in the GPIO valid mask initialisation?

> - For gpios, we need the gpio count to setup the IRQs.

Doesn't GPIOLIB parse the property before initializing the IRQ valid mask
and other init callbacks?

-- 
With Best Regards,
Andy Shevchenko



