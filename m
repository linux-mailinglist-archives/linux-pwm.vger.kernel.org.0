Return-Path: <linux-pwm+bounces-4216-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BB9E30ED
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 02:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51AC167164
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3017548;
	Wed,  4 Dec 2024 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQTXy07o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AE38385;
	Wed,  4 Dec 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277058; cv=none; b=GjGra5X4NU2wsUy3nfBjfjRAaU7uMZjaUJIyU5DI8NQBDowUIpx3OLp+74cvP+5aIlTue+RRbdRW9NVWYbHPE1xARJgK3mbuKHoYgzEbUnJ25eWoJePf/Ah6SAjLvYaw8kvoKRku0LZ+E5rBA8Lh4ylZZD7Ak+giZPI8TMPfusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277058; c=relaxed/simple;
	bh=ogJf0wodXJmsWqSxlFu5GDjXZVmUCYVdeuYCGaoChZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2E97Abj3yNauxA6FQ+8aoV4HCZNwjRD1m25vVHapoxqHiows02QKGo35Kdda/PKheQLoHMQQ89BLjHvadFOhSrW4Nd60D+jR2EmZL6iFSQeEQ5FLoxUx8DIQQ51ObSRJssxvOKkKN/LXzRlgzAspaKtqq2Ue9RKN0KmBe1823E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQTXy07o; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733277057; x=1764813057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ogJf0wodXJmsWqSxlFu5GDjXZVmUCYVdeuYCGaoChZU=;
  b=EQTXy07o5t8t68m4agL13kRXNDnWJ/G3P/bTYoA33QV9AYrmotneDxL6
   M5kb+5GYIrXp3BiQyvLDr9HYNT8tEEYEpzSnIGFUAcgysbWSywwO3n3zc
   lBGKfKx3TCQwQ7QqSEz3KdAVHG/cPcWxF7Gfrc1DJCOA4K/Z+Y2WHkJHR
   8IsEIlGtBaBh0uE9G59K0IlCJil8kE5qjsmlYqJD03e0+dnr9VjgVJQZF
   B3KoqdN3aeGgUz5yYkggo0TAbccUue3RzpVBubta1F0UEAfedN/+6m0bS
   2g4PmJowbXup9m/lrTYylaX2Db5S2tNDpBtkUog2UicP//TBtXou6dsw7
   g==;
X-CSE-ConnectionGUID: MkNeaBa5RdqxCITygNaksg==
X-CSE-MsgGUID: urN4Va53TYu46lgrQRytWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33400692"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33400692"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:50:56 -0800
X-CSE-ConnectionGUID: XJnjf8/3Raavt53CruPmmw==
X-CSE-MsgGUID: 9WpvTPYHR2CRB+ecTL3Bwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="97684014"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 17:50:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIeXT-00000003bwZ-28F1;
	Wed, 04 Dec 2024 03:50:51 +0200
Date: Wed, 4 Dec 2024 03:50:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: lpss: Move namespace import into a header
Message-ID: <Z0-1e5Wr4q_Iuq6-@smile.fi.intel.com>
References: <cover.1733245406.git.ukleinek@kernel.org>
 <3a99048a52aeee356d01dbf7f2f06e6e0826ed78.1733245406.git.ukleinek@kernel.org>
 <Z09YJGifvpENYNPy@smile.fi.intel.com>
 <6fjduueg7r3nctg4ivevvk7kopax4ynm32prxacrieq5gpbcgx@zhrgpx2loulp>
 <Z0-GB4tQAz2gfmUN@smile.fi.intel.com>
 <6bjnfjell3jyr2f5v7wvvqg6lq2w2xuqhavdom4epjr6liluw5@p7cbkwwvpe43>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bjnfjell3jyr2f5v7wvvqg6lq2w2xuqhavdom4epjr6liluw5@p7cbkwwvpe43>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 04, 2024 at 12:38:49AM +0100, Uwe Kleine-König wrote:
> On Wed, Dec 04, 2024 at 12:28:23AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 03, 2024 at 10:32:17PM +0100, Uwe Kleine-König wrote:
> > > On Tue, Dec 03, 2024 at 09:12:36PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Dec 03, 2024 at 06:16:14PM +0100, Uwe Kleine-König wrote:

...

> > > > The header must not provide any module importing features as it effectively
> > > > diminishes the point of namespace. Any (ab)user can include just a header and
> > > > be okay with that.
> > > 
> > > Huh? Any abuser can also just do the IMPORT_NS statement? Module
> > > namespaces are not a safeguard against bad code? So I don't see why
> > > making it simple for the regular users should be the wrong choice.
> > > 
> > > Actually I think this is very elegant because this way all needs to use
> > > these symbols (i.e. prototype and namespace) are in a single place and
> > > users just do the #include and get all the preconditions.
> > 
> > Recent LWN https://lwn.net/Articles/998221/ article describes in more details
> > what I implied under abuser here.
> 
> Ok. But I don't see how this supports your case. Independent of where
> the import for a given namespace happens, you can see the used
> namespaces in modinfo and that is the only place where suspicious
> imports can be noted reliably. And MODULE_foo isn't relevant here as the
> namespace of the pwm-lpss driver combo is used in several modules.

The initial point that the (ab)users will be visible at review stage.
Yes, runtime restrictions are more difficult to enforce.

> I thought the point of namespaces is grouping of symbols and reduction
> of the set of globally available symbols to speed up module loading.
> I didn't have "duplicate IMPORT_NS statements to make it harder for bad
> out-of-tree code" on my radar and that shouldn't be a motivation if the
> price is that in-tree code faces the same constraints IMHO.
> 
> And I'm pretty sure, we won't prevent a bad actor from successfully
> using a symbol they should not, just because they need an include *and*
> an import.
> 
> Am I missing something?

They may not need the include actually, as they can just tell the compiler with
extern keyword to look for a prototype somewhere else. In any case let's
return to the main topic here. My proposal is to add the respective module
namespace import into pin control driver.

-- 
With Best Regards,
Andy Shevchenko



