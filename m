Return-Path: <linux-pwm+bounces-3891-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB319B05AE
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D149C2845A8
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BBD76036;
	Fri, 25 Oct 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UC0QOnYR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A270828;
	Fri, 25 Oct 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866226; cv=none; b=ecYhE8M6I30zV7IP4g8+jasHTcPF27LdNqD0rPhC3pHAXo7pp80JP0TsIQHlh2ZUzCeMsc+E+soeLM331f2zBbzSK+OEg6hiX1PRSzM1mQAKEEW9ocCvyR4gGNrIyLlqH7NAviCDqT6t8Yj2eJrhPZ91FTW72hDgeCv5tRdl8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866226; c=relaxed/simple;
	bh=0W8DQ9KX/hU9D5Ho5Mls6otKE2aIUH3ZFgyulNGYdv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUgw7Uj4VwZN0IJt5BgrWTE7cBr82QAD6wcENCOZInNmz3I5/SRiilCgYZfBPM7SVM6HTokjBpIflEGWf3eB3Si2xW+Qwy607QxO/Z86j8KZ43OpA8s3PL3870fHuh6dmSxf+7HYkvX3elu+guhu3Kz9Ys6+9q3r5KMpHMWeUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UC0QOnYR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729866224; x=1761402224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0W8DQ9KX/hU9D5Ho5Mls6otKE2aIUH3ZFgyulNGYdv8=;
  b=UC0QOnYRfO30uLQQNfGiXl67wFHYVHxNnYKNBfDUmxmd+/ZUDA1nJLI2
   RWScYvNGBu+SMNbu7xo8iZfcPn0FGbsFn3Akdr976isN4m7oq3QcK20vv
   4JrJbHDdehF+UhUuy1s5LsXFTpH5JpYQ+M7uqv85aGx3qb5+xDueq1CvP
   7XxoR0IH4LoJVkSQpXQp+duqj3GgQPVZOWj5ghpeBthDCng+McjiZbFWk
   YWfABKnCmMT52VGheyf2GDo2GgR8kqJFVvu1RG/qF2jM/5JzH2jyqVhhE
   qN01oUpgBkwV7tFiljqaLDvv8P2HxblI90VE5ljKQfmnUItqeySc/D2th
   Q==;
X-CSE-ConnectionGUID: CIKZe05oRs6BeIJqHKzsEA==
X-CSE-MsgGUID: sQSOocorSlutkAcJrgTWcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="33340663"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="33340663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:23:44 -0700
X-CSE-ConnectionGUID: rgh3hIowQridmmguvXv7RQ==
X-CSE-MsgGUID: +FA9YOYrTEuXpwl0a7jaSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="118384393"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:23:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4LE4-00000006wIj-1QFe;
	Fri, 25 Oct 2024 17:23:40 +0300
Date: Fri, 25 Oct 2024 17:23:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
Message-ID: <Zxup7PnsWFTABBqN@smile.fi.intel.com>
References: <20241024151905.4038854-1-andriy.shevchenko@linux.intel.com>
 <2r7ey7fkt4k3s3kpi2vmesqrfntyd6jt7uf5jmwwbzglgxcohf@lr5gfy3ce2yu>
 <ZxuXU3nTuEwoTFiH@smile.fi.intel.com>
 <d7ytkx4ncytkup7pxu4kjxhbh75szwoeafyxg2prem7vfjausj@5ea2nebshemg>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7ytkx4ncytkup7pxu4kjxhbh75szwoeafyxg2prem7vfjausj@5ea2nebshemg>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 04:17:04PM +0200, Uwe Kleine-König wrote:
> On Fri, Oct 25, 2024 at 04:04:19PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 24, 2024 at 10:55:36PM +0200, Uwe Kleine-König wrote:
> > > On Thu, Oct 24, 2024 at 06:19:05PM +0300, Andy Shevchenko wrote:

...

> > > >  	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
> > > > -		const char *chip_name = dev_name(pwmchip_parent(chip));
> > > > -
> > > > -		if (chip_name && strcmp(chip_name, name) == 0)
> > > > +		if (device_match_name(pwmchip_parent(chip), name))
> > > 
> > > This theoretically changes behaviour in a few cases. For example if
> > > dev_name(pwmchip_parent(chip)) is NULL the new code would crash. Can
> > > this happen? 
> > 
> > Please, tell me how
> > (looking at the of device_add() and kobject_set_name_vargs() implementations)?
> 
> This is unfair, I intended to let you do the work and you just give it
> back to me :-)

Unfair to ask me about this code as you should know better as the maintainer
than me why this code is there, no? :-)

> ... a bit later ...
> 
> ok, willing to merge if you update the commit log to mention that the
> theoretical changes (no check for NULL, more lax check (trailing \n))
> don't matter.

Okay.

-- 
With Best Regards,
Andy Shevchenko



