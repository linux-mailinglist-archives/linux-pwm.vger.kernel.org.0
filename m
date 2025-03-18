Return-Path: <linux-pwm+bounces-5234-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297F3A67A16
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C129188ADD4
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3063D211485;
	Tue, 18 Mar 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7xr3ENp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C322094;
	Tue, 18 Mar 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316796; cv=none; b=OElsgXijTf9OZjeP8BSEJQ+18G5L3e6zy8ErOOqlW8VJRPnU0Xx7zBeYNmm9uw8t+ztJH4YYGL+1UCgNBx9JDIT0EuaPdd360ea3BSHGYhfsJWVvG4vuOfn01JUL66W8VyTwaFh4G8RgmAqtbnNlThZ9joifMu40JAO46EO1+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316796; c=relaxed/simple;
	bh=UAdvdiXRk7aJ4MCdqjJcwzQqrDsjBUYPsdfY4A5mgDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbP1bCbu6jwEOTOo10pos4QUa5kgvrQpIr838Ks7vvHFatTnw2hYsxjwPcxZM6I7Ns0piWCJVowDCmJoPN8mNBezE9fePuOTLVkUtlBZtL7TkQrN9uaruiWLKmhUl1sAbLF8wbKQ2D6fSEGp9cLKA0dCvsnNMpSeDhj3AX17Qbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7xr3ENp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742316795; x=1773852795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAdvdiXRk7aJ4MCdqjJcwzQqrDsjBUYPsdfY4A5mgDk=;
  b=g7xr3ENpSDxhwMHBNYCbvtM/bXikbcFcsfzN5jDWMwByFv2Gsmwgm1bv
   0YI7Ep51zTgAv6WFHiEWfhLhh3bkbNSHCyk9VLS4T0fTKImelHL7MkOiR
   d7xY4q007P2lWLDvZeRa384ILWPb9RYLhZS5ChEQ3ZidMsiVza//sax8E
   SqAdHwjEqW2dDpjTLpjMOJSu/9ef5mQJzB5TtkXDEcyZuZ3lf4VJTh2fO
   m79WopFwZGZG4PbwEmaGO3Vnt0gftvHQtn10EdBiB9ZH+AJH4kRJcLHra
   Ea4MYaY3izX51Cl/q9Wl8tabFZ+DsmNah+4sv9YrrtyX1gD9/irTDDAcn
   A==;
X-CSE-ConnectionGUID: mcJSwuToRtieiXVR084UNA==
X-CSE-MsgGUID: XgkDT94tRf+2F9+MxZ97gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43661065"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43661065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:53:14 -0700
X-CSE-ConnectionGUID: vxUpWW+XRv+vsEJNofToFg==
X-CSE-MsgGUID: /XUiNi0ySAS2HUoDuLwDYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="123254321"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:53:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tuaBd-00000003gV5-3qpB;
	Tue, 18 Mar 2025 18:53:05 +0200
Date: Tue, 18 Mar 2025 18:53:05 +0200
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
Subject: Re: [PATCH v5 07/11] gpio: regmap: Allow to provide init_valid_mask
 callback
Message-ID: <Z9mk8ZE1Z5_Zdyer@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-7-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-7-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:23PM +0100, Mathieu Dubois-Briand wrote:
> Allows to populate the gpio_regmap_config structure with
> init_valid_mask() callback to set on the final gpio_chip structure.

...

> -	chip->request = gpiochip_generic_request;
> -	chip->free = gpiochip_generic_free;

Stray change.

-- 
With Best Regards,
Andy Shevchenko



