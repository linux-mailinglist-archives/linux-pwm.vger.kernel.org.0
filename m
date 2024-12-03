Return-Path: <linux-pwm+bounces-4212-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AEC9E2BE2
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 20:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFECF2845D5
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD71FC7F0;
	Tue,  3 Dec 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiONsnBM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD813B2B8;
	Tue,  3 Dec 2024 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253605; cv=none; b=MFrwgyEokFBT7r3CK4yPXTCw71CSZt5HN0ia4sd14wyh0OMKv2gduPkpRmqVstInt724zQNSgWHXtAEI75ge6bTKElt98jia/FJJ0MYrmCdDMqnMmxIb5e+ppuEGjXCBcCY3prBabCJphzRVCRHYelizrlYNv2i2dH5XTOSteR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253605; c=relaxed/simple;
	bh=g2RirV7tOmdqFmzJcQReCKzHkmNUHNqTVQIz3LmX0+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJX5BKp2oRMS2u0DrbXPk7sls2XIJbWnLuIfgcEBXCV5N7loyy03p5asHUUV7oH5B1I2om6I2LUucxFUtjFxJeSTZ1xCGxTu+rDYiyIDgRaHZ0zoYNWOo1cw+xBo5vyOEycvghaV1ejfKaYSVWOzoFwLzjssNXn598jzWB9XFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiONsnBM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733253604; x=1764789604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=g2RirV7tOmdqFmzJcQReCKzHkmNUHNqTVQIz3LmX0+c=;
  b=BiONsnBM2DSyILSaX6h6qhVwAl7fcpAvXlUk1hLNH5qxsD9M8IKZ2PeJ
   RGtgaVY4U4lPkFvjl7KWJxGW45yOaX6odJfTfAgmfzGitdE843lGK+DL2
   Lh/5S/mB/2oz1zh7Q/b+Fc9lZUzv5xFn5IW72WFtL+UnsRNAP/ZKbkYDV
   uzEnn9gxjq0E2sPUITgHYY+5jxiqvW65EFEE9tA5cccY/knbvvaSnHrVW
   P5lN9OwgUL488AoNY/KedwSElU8CEydZ92mtZ63Nd59C50xQYptbPtIxR
   nIwEUzvNqHX27SdAZw/f7k+/7YSolU7HbKPeBztyCr7eEw7l1gI6Z9nDa
   w==;
X-CSE-ConnectionGUID: 4AoZu0tKQ0CBkTAfpRnnJg==
X-CSE-MsgGUID: 0S0kF3KsQ4a/5YVF4f6pOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58890344"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="58890344"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:20:03 -0800
X-CSE-ConnectionGUID: px8vfNTYToO3gDM+NxoxIw==
X-CSE-MsgGUID: Xco39EDuSjGjePpKbzZPlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98613808"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:20:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIYRC-00000003WpL-159m;
	Tue, 03 Dec 2024 21:19:58 +0200
Date: Tue, 3 Dec 2024 21:19:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: lpss: Define DEFAULT_SYMBOL_NAMESPACE earlier
Message-ID: <Z09Z3oVCrtv-IZUz@smile.fi.intel.com>
References: <cover.1733245406.git.ukleinek@kernel.org>
 <9f0e30c514a846aec72655a52deaed276467a07e.1733245406.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f0e30c514a846aec72655a52deaed276467a07e.1733245406.git.ukleinek@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 06:16:15PM +0100, Uwe Kleine-König wrote:
> DEFAULT_SYMBOL_NAMESPACE must be already defined when <linux/export.h>
> is included. So move the define above the include block.
> 
> With the DEFAULT_SYMBOL_NAMESPACE being defined too late, the exported
> symbols end up in the default namespace. So the modules making use of
> the symbols defined in pwm-lpss.c can import these just fine and just
> import the the PWM_LPSS namespace without any gain.

Documentation disagrees with you. But, you are right, a lurking bug is here as
we need to undef existing define.

> -#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS

-- 
With Best Regards,
Andy Shevchenko



