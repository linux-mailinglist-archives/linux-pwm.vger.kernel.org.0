Return-Path: <linux-pwm+bounces-6579-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A2AED9D7
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF503A85B9
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41A258CD7;
	Mon, 30 Jun 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvyzNDwT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA32248F42;
	Mon, 30 Jun 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279402; cv=none; b=BVKsHPuoqTWrTFoU36rPNXmNcQZap5jhbPv0lpFHoY3V0Pp/sE7DTECofYF22pUEh5ZrfDyZGILocI3i4CZgXgSFSyAtVKBIuzquW/rPWYjHjLuAERPB7jnBEOmBfbjaTprmrBiyNvvULp+fnd0mE2O22hRx1/BVbmlDOIfyzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279402; c=relaxed/simple;
	bh=jAN144/a/Vxcpv+1HYhL0sUxs0gT2akYTGdKswj8FMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QagoypkZlL8uzVA4JhaCIxT4XSC86+po1IinnZLl80pUO+pzDbClC8AU9nIjVKhz/3C6bsle0eNyzOA3NqY6wqWYa8B1Wbtjd+z3dHLxMwtPgqJOmG3zVXrpn+nltdY6NIf+/tdFLrV+xXkPSK3NNSrD5EIADUZWlOpa+W8cTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvyzNDwT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751279401; x=1782815401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jAN144/a/Vxcpv+1HYhL0sUxs0gT2akYTGdKswj8FMM=;
  b=dvyzNDwTxLwjVQY8WlDnuqSVz2FFWrAmYrIEkEQsLlTnZNfukBsTsAR0
   y1U6VPbgHmU9jvFQ4h1rvWG0Kr1+I1CgQ0QTnzCo8LgxzJ7IadFL57JBa
   p2HwcN1ActhBOi6ABhISwP09j7hP6Wg7Wfu/gK1NJvbWLxNI2VR6W9/Ji
   plHAvjbzIYJgT9DPCSBLKahJh5z7nDKiP5/9Fcy3so8tGnLVt5E4Fjtgv
   OHYM5tPXpZLT53QvPujwqiMFaLoyrdCb/5l2MzOOix472yVKqJMwc/wac
   DadOFT2pYO+ZIa5618BkGzAR4CzkFeWDoAOei3l2YbttHU07ehqX/B4JR
   w==;
X-CSE-ConnectionGUID: WOnwVUtERD+MC/XGUNySDg==
X-CSE-MsgGUID: gEx9KJO2SeCRZIG+F+yZrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="78940253"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="78940253"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:30:00 -0700
X-CSE-ConnectionGUID: QedmlS3nQyiLOtoXpr4K4g==
X-CSE-MsgGUID: SKryV/GeRbSGlARSMjG5AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153050524"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:29:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWBlr-0000000BHCn-0Ruu;
	Mon, 30 Jun 2025 13:29:55 +0300
Date: Mon, 30 Jun 2025 13:29:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v18] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aGJnItQ3hjQ80rlz@smile.fi.intel.com>
References: <20250626224805.9034-1-ansuelsmth@gmail.com>
 <aF5dHDr8yDSKlp5j@smile.fi.intel.com>
 <685e6544.5d0a0220.20cf55.9440@mx.google.com>
 <aF5xrHkTr8Tb71ZH@smile.fi.intel.com>
 <685e73cf.df0a0220.214b10.9998@mx.google.com>
 <aF544lt-9YJq8r0y@smile.fi.intel.com>
 <686264ac.df0a0220.feace.3044@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686264ac.df0a0220.feace.3044@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 30, 2025 at 12:19:22PM +0200, Christian Marangi wrote:
> On Fri, Jun 27, 2025 at 01:56:34PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 27, 2025 at 12:34:49PM +0200, Christian Marangi wrote:
> > > On Fri, Jun 27, 2025 at 01:25:48PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Jun 27, 2025 at 11:32:46AM +0200, Christian Marangi wrote:
> > > > > On Fri, Jun 27, 2025 at 11:58:04AM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, Jun 27, 2025 at 12:47:53AM +0200, Christian Marangi wrote:

...

> > > > > > > +	/* Global mutex to protect bucket used refcount_t */
> > > > > > > +	struct mutex mutex;
> > > > > > 
> > > > > > This makes a little sense. Either you use refcount_t (which is atomic) or
> > > > > > use mutex + regular variable.
> > > > > 
> > > > > Using a regular variable I lose all the benefits of refcount_t with
> > > > > underflow and other checks.
> > > > 
> > > > Then drop the mutex, atomic operations do not need an additional
> > > > synchronisation. Btw, have you looked at kref APIs? Maybe that
> > > > would make the intention clearer?
> > > 
> > > It's needed for
> > > 
> > > +       mutex_lock(&pc->mutex);
> > > +       if (refcount_read(&pc->buckets[bucket].used) == 0) {
> > > +               config_bucket = true;
> > > +               refcount_set(&pc->buckets[bucket].used, 1);
> > > +       } else {
> > > +               refcount_inc(&pc->buckets[bucket].used);
> > > +       }
> > > +       mutex_unlock(&pc->mutex);
> > > 
> > > the refcount_read + refcount_set.
> > 
> > Which is simply wrong. Nobody should use atomics in such a way.
> > Imagine if somebody wants to copy something like this in their
> > code (in case of no mutex is there), they most likely won't notice
> > this subtle bug.
> >
> 
> Yes I understand that someone might think the additional mutex can be
> ""optional""
> 
> > > As you explained there might be case where refcount_read is zero but nother
> > > PWM channel is setting the value so one refcount gets lost.
> > 
> > Right, because you should use refcount_inc_and_test() and initialise it
> > to -MAX instead of 0. Or something like this.
> 
> Mhhh I think API for _inc_and_test doesn't currently exist and I don't
> feel too confident implementing them currently.

Ther is refcount_inc_not_zero(), but the main point here that refcount_t seems
not fit the case. It doesn't work with negative values, and 0 is special.

> > > kref I checked but not useful for the task.
> > 
> > Okay.
> > 
> > > The logic here is
> > > 
> > > - refcount init as 0 (bucket unused)
> > > - refcount set to 1 on first bucket use (bucket get configured)
> > > - refcount increased if already used
> > > - refcount decreased when PWM channel released
> > > - bucket gets flagged as unused when refcount goes to 0 again
> 
> Do you think I should bite the bullet and just drop using refcount and
> implement a simple int variable protected by a mutex?

Yes.

-- 
With Best Regards,
Andy Shevchenko



