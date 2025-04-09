Return-Path: <linux-pwm+bounces-5428-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF8A82D16
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 19:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075873B9662
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79A270EB2;
	Wed,  9 Apr 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YorHfPsw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589421BF33F;
	Wed,  9 Apr 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218158; cv=none; b=Tq2xPNrdhwgf7v5uGnY+XwL5mUozNyY57HczmK1bGJNk4/6PCt2l9OyEZ/9d+SPoYGlg5ikxiOYGd8rNASF3IGFkS+txTNQhBu//nMGJq27gbOLY4powVEvwrxJhzqrfrv62XTcB+MLHxF+8qIIDuXEoff77sBQKQQwIPo7z1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218158; c=relaxed/simple;
	bh=2fgrXbl7XmK/1Sd1jXkY+WL8zQcGEPJy1lFAiX+4sZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdhM1p711p3RjbWYEEPqxO07RBgk/00bjucnJ+vafOG7c3mgCTz1nuyvmeIs9J/oA9rwDeYbAw6p6rQwOCJzbuspYqoJLV/2McaYHpfIANGOJMocm4SppjmwrIh1r1UZ/7YPT6kHRfIWjOSZWbcPxhPgo2dIWqdUucvkShN/CUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YorHfPsw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744218157; x=1775754157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2fgrXbl7XmK/1Sd1jXkY+WL8zQcGEPJy1lFAiX+4sZ8=;
  b=YorHfPswphdkLiFGma5xKFUegX859r1uhBAmLx8EoItV3byLy9iUgAlh
   lIOzn3F4msczkCbikjpsC+obLV1P8lsxnku0j37XCC1r6ANSZ8dPoTlPN
   nD8biAdVgUQgUATuW+kAxXyD8w5FkmreBMlkjHp5UK/Hxb1CydpvKHeUU
   spYFEhRjK9idFxOIMoA5g2YeQD95FWr2KArQA2/ObUod5Y5cA83t2rq1b
   yzqAjZPncysEDRfPzWskPNv7s4YqdHeM7ds6c6TX5CsFsiYE4BdpHAECl
   Q5Wob842ljx27ZGOViplno6/RDHPhv28QOyVGegiIuqDCEektn5c1pCBO
   Q==;
X-CSE-ConnectionGUID: TO0ssnPUToyKhYl5rsBlwA==
X-CSE-MsgGUID: SSCNnrpIQEWGcEHYZRWyEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56371745"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56371745"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:02:35 -0700
X-CSE-ConnectionGUID: paFj+VcoTGiDSdzXaUP6mA==
X-CSE-MsgGUID: CqqqKux0Sve0pXbYVxqIcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="151822353"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 10:02:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2Yol-0000000Anq8-2VfQ;
	Wed, 09 Apr 2025 20:02:27 +0300
Date: Wed, 9 Apr 2025 20:02:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v6 08/12] gpio: regmap: Allow to provide init_valid_mask
 callback
Message-ID: <Z_aoI2n5v0TyJhb3@smile.fi.intel.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-8-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-8-7a2535876e39@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:55:55PM +0200, Mathieu Dubois-Briand wrote:
> Allows to populate the gpio_regmap_config structure with
> init_valid_mask() callback to set on the final gpio_chip structure.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



