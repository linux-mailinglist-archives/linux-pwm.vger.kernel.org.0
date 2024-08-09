Return-Path: <linux-pwm+bounces-2991-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4294D37F
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD57284758
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2024 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2C9190686;
	Fri,  9 Aug 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntjEetIO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56145168DC;
	Fri,  9 Aug 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217427; cv=none; b=fwhRbZ/jx5nZsz99xCI7UGCsKl/qQpQTk8U4kzvnjSiXt/C3WDHmGiy+b9wpUwRH0WTQNCbxTHHRIFJJZxbyFxcyOX5A4xVbtn0v6VA4y/1Gt4TjTmc5TuYagd2ORtAz2Fk1WCkGUyqs3d8gs7UYSwr2fK3edh5LRE/RrZ9Ivj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217427; c=relaxed/simple;
	bh=brmlbu97JZ/VhthJ9c1/pnOkJpPrJo/ghGpbEHPx2G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZCkjbs2H+n97UhDCgzrr8bDWZHdcPznrZ84l5sJADjq8NosnBrfVtYogJ2ynTzi6JMl7HY6ZiMhH6VXIC0xFdVx7DItTSizwJJR7e5azO8UBqQ3H4mm5BMQS7p1uprOpzq6mJgR48kB7P171xYFsvCCFf5tPYCRKL+bdoGLqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntjEetIO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723217426; x=1754753426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=brmlbu97JZ/VhthJ9c1/pnOkJpPrJo/ghGpbEHPx2G8=;
  b=ntjEetIOFzKTXk4u2tLE2xTjTvMK+4xFZ6Tq21wkCi2ChHrOi/X4yEqW
   GugX4XT1SViRceh8ngcRVxImGGQBiYycwtgm7eH9iTzmp1pAoF9oJpqpj
   hGM23b/d+a1UiY9gwjjqCHx/vQdaJsLTGIRD5nyDVYlj3gISK08AK45ao
   RMHjkBJXuL8zdZQEo53fEBPjX8ikfIrZdNwlb7CXD/GJdbW+C0Okww6qQ
   ojAoCDmwmdJ5YTYv9ZVd4iKgJ35diCnau96kLblbLdOQ5w8Ze/sieicFV
   i5Lrf24uFb2YOxN9kC5mDc3bHk8Do59B/BtZierslrQ6myCs4DlDGyCm0
   Q==;
X-CSE-ConnectionGUID: ztwAuLGtQHqQAjIWZQThhg==
X-CSE-MsgGUID: eqv7flRNS26ZLRgVfzeJag==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32020579"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="32020579"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:30:25 -0700
X-CSE-ConnectionGUID: eozMyWarQ4arVcw8xp332Q==
X-CSE-MsgGUID: OxKrmaGTSm22puMLsKVA8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="80832728"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:30:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scRZM-0000000DSMQ-3IaT;
	Fri, 09 Aug 2024 18:30:20 +0300
Date: Fri, 9 Aug 2024 18:30:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] LPSS PWM cleanups
Message-ID: <ZrY2DGa4zHQUc3SX@smile.fi.intel.com>
References: <20240605131533.20037-1-raag.jadav@intel.com>
 <ZodsUkFQ4BJDU1JY@black.fi.intel.com>
 <y5r5dtuvkvoigk5nidn3vywwh4tlvx3oij3crpt243jamvajok@imghdifonrwd>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <y5r5dtuvkvoigk5nidn3vywwh4tlvx3oij3crpt243jamvajok@imghdifonrwd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jul 05, 2024 at 10:28:55AM +0200, Uwe Kleine-König wrote:
> On Fri, Jul 05, 2024 at 06:45:22AM +0300, Raag Jadav wrote:
> > On Wed, Jun 05, 2024 at 06:45:31PM +0530, Raag Jadav wrote:

...

> just swapping your S-o-b and Andy's R-b in the commit log to have your tag
> last.

It's not required by the documentation as Rb != SoB.

-- 
With Best Regards,
Andy Shevchenko



