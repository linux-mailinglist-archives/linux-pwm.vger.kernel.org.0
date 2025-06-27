Return-Path: <linux-pwm+bounces-6546-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CDAAEB58F
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 12:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E045816DE9E
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCD298CA6;
	Fri, 27 Jun 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEmBjAL4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BD224893;
	Fri, 27 Jun 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021801; cv=none; b=sFHyipDbGyr0Ev1dH+T34L7zqyoJ6oXobRmbp2RpU9qa/cgVpFnIOC4L7UDCf3TLz6zLk9ZfoJo4Xhw0j8iDm9Bfjpgc6NhxJj3gsfBBLijpq09oMscjh2UVXRJjWPtgTBuc0hZXkV8T5KMue9ekyk5Tz0FL8mo6tBsmFY7NiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021801; c=relaxed/simple;
	bh=T3uWh/QcvqROPfZzHSbKKajGRp9ht/LT12j2WdEkiwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr67W3yJkwY3dG9WSBxsfTGRyXHpVbNe2kICm27d92xY9h8QLoerfMtVimnl96kbdM+uKClaxITD+SuUWqKtpKkUYB1TJN/4PBpSDPeeEOVdzpAHEWkr8BJCHjt7C16kLUN2yaQjfeSKxoIeWLuSxVbeX3lwVChvjA98thyQ5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEmBjAL4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751021800; x=1782557800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3uWh/QcvqROPfZzHSbKKajGRp9ht/LT12j2WdEkiwk=;
  b=QEmBjAL4/NCCc7Jz9vgo2OWurfDoZ3YVWgVGUzXvrXlNxzfb/g5gzQiw
   WLCAW2WCDenqZCdrOrBUL32OlCNDIJGRwBi8Q4vfzI+HaXhzqaz7hGO1m
   fVtrE6g5NzOQScnhtll1djR4Vx1v3TA9g2ygaIafOOaH+S1nXK1IFjHCu
   1Y1GucPTJiG9VaijlFEMS0ZPOKiR6hd/xoBhB5dQbuGiS3/wlFooyrE5u
   2C2bf4F0RUT4ChW041njZa/P+VP4xL0Q27e0wasMi5JA5fX0gd2q4tWgT
   /cJPNGS7FgPEmgiLa6b+dY47KGt2MBFdKoFs/CSHIp+6neWpH/RiNBjTf
   g==;
X-CSE-ConnectionGUID: 1pPkIyPVT/qjbOw8lbJ/2g==
X-CSE-MsgGUID: 2exypl5EQ7Oluwarat4aSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="75878678"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="75878678"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:56:39 -0700
X-CSE-ConnectionGUID: rn9VVUwTSM+F408M91+awQ==
X-CSE-MsgGUID: snRNiK3sSTWzsuJHRF4Ivg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152519354"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:56:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uV6l0-0000000ASQB-3aSH;
	Fri, 27 Jun 2025 13:56:34 +0300
Date: Fri, 27 Jun 2025 13:56:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v18] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aF544lt-9YJq8r0y@smile.fi.intel.com>
References: <20250626224805.9034-1-ansuelsmth@gmail.com>
 <aF5dHDr8yDSKlp5j@smile.fi.intel.com>
 <685e6544.5d0a0220.20cf55.9440@mx.google.com>
 <aF5xrHkTr8Tb71ZH@smile.fi.intel.com>
 <685e73cf.df0a0220.214b10.9998@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685e73cf.df0a0220.214b10.9998@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 12:34:49PM +0200, Christian Marangi wrote:
> On Fri, Jun 27, 2025 at 01:25:48PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 27, 2025 at 11:32:46AM +0200, Christian Marangi wrote:
> > > On Fri, Jun 27, 2025 at 11:58:04AM +0300, Andy Shevchenko wrote:
> > > > On Fri, Jun 27, 2025 at 12:47:53AM +0200, Christian Marangi wrote:

...

> > > > > +	/* Global mutex to protect bucket used refcount_t */
> > > > > +	struct mutex mutex;
> > > > 
> > > > This makes a little sense. Either you use refcount_t (which is atomic) or
> > > > use mutex + regular variable.
> > > 
> > > Using a regular variable I lose all the benefits of refcount_t with
> > > underflow and other checks.
> > 
> > Then drop the mutex, atomic operations do not need an additional
> > synchronisation. Btw, have you looked at kref APIs? Maybe that
> > would make the intention clearer?
> 
> It's needed for
> 
> +       mutex_lock(&pc->mutex);
> +       if (refcount_read(&pc->buckets[bucket].used) == 0) {
> +               config_bucket = true;
> +               refcount_set(&pc->buckets[bucket].used, 1);
> +       } else {
> +               refcount_inc(&pc->buckets[bucket].used);
> +       }
> +       mutex_unlock(&pc->mutex);
> 
> the refcount_read + refcount_set.

Which is simply wrong. Nobody should use atomics in such a way.
Imagine if somebody wants to copy something like this in their
code (in case of no mutex is there), they most likely won't notice
this subtle bug.

> As you explained there might be case where refcount_read is zero but nother
> PWM channel is setting the value so one refcount gets lost.

Right, because you should use refcount_inc_and_test() and initialise it
to -MAX instead of 0. Or something like this.

> kref I checked but not useful for the task.

Okay.

> The logic here is
> 
> - refcount init as 0 (bucket unused)
> - refcount set to 1 on first bucket use (bucket get configured)
> - refcount increased if already used
> - refcount decreased when PWM channel released
> - bucket gets flagged as unused when refcount goes to 0 again

-- 
With Best Regards,
Andy Shevchenko



