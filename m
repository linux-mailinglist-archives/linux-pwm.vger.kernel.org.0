Return-Path: <linux-pwm+bounces-3046-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6A958356
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 11:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307E128639E
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6295F18C934;
	Tue, 20 Aug 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVwsR23G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33A18C018;
	Tue, 20 Aug 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147772; cv=none; b=LklSFgn64axQsodIowfLE95/axqdWIiSqHMOwKwRBTxrIOYfuOGhZ9z7ICblL7+jZeenWPzOErWHEaLj+9+SjXZRSbKdUfsfYNRD0+86CkIkJk9ZYp/wJWdRViZ/q7pj50Qjj4pQPAoFaWaRjDIkGM0PaDr5dF98K43ADOhk9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147772; c=relaxed/simple;
	bh=pVrjcFsxgaTdd3PRo0Imnqd9L8GKquaiKB74IKdl3Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj+6LFkRBGr/B8ejeOBAhgr/C6W1iYbgSw4wikhex6im+GnXiUKY5Gb/m1hOWc7YXghBsHARabKXaqNbgCHCW7mdQLrnUrrsdJErq60lxdxn3VWW+TmJjQk3jiufNPaz/DTmwJXrzbhg9OhzCrJw28MiV3/91zbXRTtN8j0K3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVwsR23G; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724147769; x=1755683769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pVrjcFsxgaTdd3PRo0Imnqd9L8GKquaiKB74IKdl3Bs=;
  b=PVwsR23G8S9PrMUqLiH7m+T5ADlTon/LBV8J95H0Rns54V8RKzmFjTeq
   IXMhxIP0cYTMflVybLtgDJ2YXaL/Y+Q9i2wf3BG3aGIkGdd46ft84c/xd
   Xh6969eYGniXdSBTTHOvHQ1j18H0If/gBSqNPtIgS4ULphR/N2r32QYwh
   0BLWUrlLXjj4l9pplVgHGg4VRxBFFkIwiC9owIPDuj4FIt2NDLfNJrCDn
   93nO0kvGCsmqIi7dNo4ZzXZxDgmOSofUphpxr13IkQvlA+O5LCZ41bNiE
   cvAWPRyKDTR4EL8VACOp7MkDGNKNcGF0trgfTP46Ig0MYXkh/oqrre2Hp
   A==;
X-CSE-ConnectionGUID: NogL9RMVQZexYQ8Wfb7aog==
X-CSE-MsgGUID: Ag1jOoyaS0qH1W77rFrIHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22565428"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22565428"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:56:09 -0700
X-CSE-ConnectionGUID: saL7/3JhQM2Lf7qyjvSq3w==
X-CSE-MsgGUID: MJZbJpKLTfeorvo+YeKFSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="65367956"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 02:56:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgLau-0000000HFqk-1uXG;
	Tue, 20 Aug 2024 12:56:04 +0300
Date: Tue, 20 Aug 2024 12:56:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: ukleinek@kernel.org, mika.westerberg@linux.intel.com,
	jarkko.nikula@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: lpss: wait_for_update() before configuring pwm
Message-ID: <ZsRoNHff5oDcMTcz@smile.fi.intel.com>
References: <20240819080412.15115-1-raag.jadav@intel.com>
 <ZsMAn3hQ4yDq-Gg6@smile.fi.intel.com>
 <ZsQunMKglYdUwzqo@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsQunMKglYdUwzqo@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 08:50:20AM +0300, Raag Jadav wrote:
> On Mon, Aug 19, 2024 at 11:21:51AM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 19, 2024 at 01:34:12PM +0530, Raag Jadav wrote:
> > > Wait for SW_UPDATE bit to clear before configuring pwm channel instead of
> > 
> > PWM
> > 
> > > failing right away, which will reduce failure rates on early access.
> > 
> > So, what is the problem this patch solves (or is trying to solve)?
> 
> Less failures with less code, so just a minor improvement.

It's not an equivalent code as I mentioned below.
So, if it's just a "cleanup", I do not think we want it as code works now and
have no penalties.

> > Second, there are two important behavioural changes:
> > - error code change (it's visible to user space);
> 
> This function is already used in this path just a few lines below.

Yes, I know, but it is used in a slightly different context.

> > - an additional, quite a long by the way, timeout.
> > 
> > Second one does worry me a lot as it might add these 0.5s to the boot time
> > or so per PWM in question.
> 
> On the contrary, having a working set of PWMs would be a relatively
> rewarding experience IMHO.

I'm not sure what this patch tries to fix. Was something not working before?
Was something become different on real hardware that makes this patch worth to
apply? None of these questions has been answered in the commit message.

So, as long as this is considered a pure cleanup, here is formal NAK from me as
this IP block is not stateless and may lead to freezes. Hence the rule of thumb
"do not touch the working things".

Otherwise, please make the commit message crystal clear about the improvements
besides the code lines and answer the questions, e.g., why waiting for half
a second is not an issue.

-- 
With Best Regards,
Andy Shevchenko



