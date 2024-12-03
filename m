Return-Path: <linux-pwm+bounces-4214-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FD99E2F10
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 23:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57732283422
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 22:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CB20898A;
	Tue,  3 Dec 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwtvERtc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33337207A3E;
	Tue,  3 Dec 2024 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264917; cv=none; b=plo/c77HWF+wSvHr0ZFdPupAwrpnQGxdttt8n7efgSJMzFUvFGmdTJL4NmmoaE4HFIYrWETVD/8WgEP1ByKTtpXRLyqxkufTHjXp+Y8CCVI638ZEKDe31jhEfDD1ejyfT6B2glZv8XpMOjdU+EFrnbLwSjWCAJmXChRwDDQxMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264917; c=relaxed/simple;
	bh=50midJw+AdJl8bvRnnHQCxHyHv67X4fji8qbOpfdy5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toMhH3Cgy+8koyEDXV+YeIzpLMjofAQaIHuSmTz4DNL5S/vi4zomuoLsdoYI3ADnDEgdzz7qdmCijlBJLC23xmKxH1RTu3UZ33yDWYrmQN6xrz8AaIDGAeF7Y0q4VnCA81PpGKmkM1J+Vs5ba9wfmRunpF/9opIBGmLPhPAo6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwtvERtc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733264916; x=1764800916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=50midJw+AdJl8bvRnnHQCxHyHv67X4fji8qbOpfdy5s=;
  b=CwtvERtcj1MxvMC6FsSymxbXB//CnnYfGAooP7cn9OHn0yZYTBjyeZmB
   n0FyDZOY5zk9KmMVuhaNK6arPHEc4c2BAcEIEUA2zhJ6SphqUwji2RBW0
   5jGarp1RzKjzAcUdXHOHdENcLMj1gAGL1z+YwYeShhKmodzumbzQ8h9d2
   iYRx1p1Xw60pcdkz2W51nuIV4fVVzHqD3PrTA/ehy51sjAlEpwycSrLhh
   J8cru8FzwwzU46IXL0srJzknkaXx8zcyERWSOb6ii0hhThNPQfF6beDYO
   OAc+uGdGb96K8B6IAQ0PUvmFdarplMpxf9KmWKPFgLXRCtDfcJDNwx3ny
   A==;
X-CSE-ConnectionGUID: M1eOuXVKS2mta5x746IKwQ==
X-CSE-MsgGUID: 3mLMs1zOQXGSPzTCpq0tEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33430489"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33430489"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 14:28:30 -0800
X-CSE-ConnectionGUID: cpLLV88vRzueMyocks00kg==
X-CSE-MsgGUID: Xdj3xfvsSh2QRpdodKvDMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98653512"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 14:28:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIbNY-00000003ZIa-0HO5;
	Wed, 04 Dec 2024 00:28:24 +0200
Date: Wed, 4 Dec 2024 00:28:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: lpss: Move namespace import into a header
Message-ID: <Z0-GB4tQAz2gfmUN@smile.fi.intel.com>
References: <cover.1733245406.git.ukleinek@kernel.org>
 <3a99048a52aeee356d01dbf7f2f06e6e0826ed78.1733245406.git.ukleinek@kernel.org>
 <Z09YJGifvpENYNPy@smile.fi.intel.com>
 <6fjduueg7r3nctg4ivevvk7kopax4ynm32prxacrieq5gpbcgx@zhrgpx2loulp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fjduueg7r3nctg4ivevvk7kopax4ynm32prxacrieq5gpbcgx@zhrgpx2loulp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 10:32:17PM +0100, Uwe Kleine-König wrote:
> On Tue, Dec 03, 2024 at 09:12:36PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 03, 2024 at 06:16:14PM +0100, Uwe Kleine-König wrote:
> > > Each user of the exported symbols related to the pwm-lpss driver needs
> > > to import the matching namespace. So this can just be done in the header
> > > together with the prototypes.
> > > 
> > > This fixes drivers/pinctrl/intel/pinctrl-intel.c which failed to import
> > > that namespace before. (However this didn't hurt because the pwm-lpss
> > > module namespace isn't used; see the next commit.)
> > 
> > I disagree on this change, I think it had been discussed already.
> 
> Who discussed this? If I was involved, I don't remember. So if you have
> a link, that would be great.

Sure, https://lore.kernel.org/linux-pwm/20220908135658.64463-1-andriy.shevchenko@linux.intel.com/
you were a participant there.

> > The header must not provide any module importing features as it effectively
> > diminishes the point of namespace. Any (ab)user can include just a header and
> > be okay with that.
> 
> Huh? Any abuser can also just do the IMPORT_NS statement? Module
> namespaces are not a safeguard against bad code? So I don't see why
> making it simple for the regular users should be the wrong choice.
> 
> Actually I think this is very elegant because this way all needs to use
> these symbols (i.e. prototype and namespace) are in a single place and
> users just do the #include and get all the preconditions.

Recent LWN https://lwn.net/Articles/998221/ article describes in more details
what I implied under abuser here.

> > Besides that, you should have based this on recent changes in the NS area of
> > the module symbols, i.e. module namespaces needs to be provided as string
> > literals.
> 
> I coordinated my patch set with the pwm maintainer and he is ok with it
> :-) That's why I wrote "This conflicts with
> ceb8bf2ceaa77fe222fe8fe32cb7789c9099ddf1 that is currently in Linus'
> tree. I'll take care about that." in the cover letter.

Other subsystems simply backmerged those changes. Note, at any time one may
consider origin/master as an immutable (at the point of a given change).
It might be better (if no urgent need) to wait for rc2 and merge it before
doing other changes.

-- 
With Best Regards,
Andy Shevchenko



