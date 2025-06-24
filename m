Return-Path: <linux-pwm+bounces-6509-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A103AE65DE
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 15:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C31188B877
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47D28D8FA;
	Tue, 24 Jun 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtgBVdTI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A0182BC;
	Tue, 24 Jun 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770334; cv=none; b=bsv3e1j0T8aO0gRfD9V0pIy6vgXAKD7wId82i+byILxZSvWx5ileEP63kcjuTUn5PaR9xNd30RF/5hjFNmw9zfScfapy31chOX77uMk6vpCC2xZXC+VUVUnQJElzk8rXHCL0bKYCC/3xuqkOtSROwjhEist4V/2zMMJDfSgBqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770334; c=relaxed/simple;
	bh=kGyeSWwPfNqY8c6qb1h6FLEVc9UbMJzgCLbeazagA7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGpdCEDSxUbWh+I3VZF+32g84c95RWt+PyyoMLBzrDuEaRgfdst7DyO9RgccQN42upgVRLeqcTuj6Hn7Tit7+8eNdAPx3fUJE5B+/MBgzG30WK9XlK0gpr4UNRtRDkOrvrfC7C9vdP3Rbx86Nae/lDFeL95cnb5Y3xaXLXJ9iKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtgBVdTI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750770333; x=1782306333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kGyeSWwPfNqY8c6qb1h6FLEVc9UbMJzgCLbeazagA7s=;
  b=XtgBVdTIsC6FO0JhBOtUe5Rxbgg7/U5WO2mSHJUMceV/aUrE6artdMLc
   uezbx4bIRjfvwGNb/BSFs/XunyCEEOsmPvwCqXn+4W1ik+ltdgFocdtSL
   1DpCQGk19uIhReVjDePpa1jOzfef8wK6fk4+ZkmkHrpMr1HCfeOcjt4YI
   WIMRaLPFO/bnLgHB2YVq87csT7oI450hYGPeio7AEHV8AJDdJ6bfaXQLD
   A9ENBhui/LFZUkPW/DW4xVqzHUUBFbmkq9XYk3TcRA5SeGHH1+p6EKGdQ
   qH0oCL8yNv9zS77aLdmfBQ3xBsOQ1QvUlI6QhCkSBtiwU5ND0VtborHW+
   w==;
X-CSE-ConnectionGUID: b5r2D6evSwiwZTnyyiaLqQ==
X-CSE-MsgGUID: hXSDTVIiRhWB22ROi4TQCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64436179"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64436179"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 06:05:33 -0700
X-CSE-ConnectionGUID: yx5S08Y/Tj22QfpDWdefuQ==
X-CSE-MsgGUID: i9+uPxK2STCA4XdUDpP6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="182787385"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 06:05:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uU3L4-00000009TQw-0NDt;
	Tue, 24 Jun 2025 16:05:26 +0300
Date: Tue, 24 Jun 2025 16:05:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v15 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aFqilRNwsUafDtOm@smile.fi.intel.com>
References: <20250623211116.1395-1-ansuelsmth@gmail.com>
 <20250623211116.1395-2-ansuelsmth@gmail.com>
 <CAHp75VcEJ0w5rcyq_DSHHunYanU5S9OgnRz1t8XervXqGQCX4w@mail.gmail.com>
 <685a64d5.df0a0220.1f9a42.38b0@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <685a64d5.df0a0220.1f9a42.38b0@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 24, 2025 at 10:41:54AM +0200, Christian Marangi wrote:
> On Tue, Jun 24, 2025 at 09:37:26AM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 24, 2025 at 12:11 AM Christian Marangi <ansuelsmth@gmail.com> wrote:

...

> > > +config PWM_AIROHA
> > > +       tristate "Airoha PWM support"
> > > +       depends on ARCH_AIROHA || COMPILE_TEST
> > 
> > > +       depends on OF
> > 
> > There is nothing dependent on this. If you want to enable run-time,
> > why not using this in conjunction with the COMPILE_TEST?

Yes, I understand that. Maybe you should have dropped versioning of the series
:-)

> > > +       select REGMAP_MMIO

...

> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/err.h>
> > 
> > > +#include <linux/gpio.h>
> > 
> > Have you had a chance to read the top of that header file?
> > No, just no. This header must not be used in the new code.
> 
> As you can see by the changelog this is very old code so I wasn't
> aware.

Understood.

> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/math64.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > 
> > > +#include <linux/of.h>
> > 
> > Nothing is used from this header. You actually missed mod_devicetable.h.
> > 
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/regmap.h>
> > 
> > Missing headers, such as types.h.
> > Please, follow the IWYU principle.
> 
> Aside from types do you have hint of other missing header?

Just above :-)

> Do you have a tool to identify the missing header?

Unfortunately no tool available, this is just by experience of reviewing code
and doing some cleanups in include/ area.

The rule of thumb, for anythin you use, check which header provides that type
or API. But OTOH don't be too pedantic about it, types.h, for example, covers
a lot of basic kernel types and many compiler attributes and so on, no need
to take care of those separately.

TL;DR: you should go through your code and check it.

...

> > > +       u64 initialized;
> > 
> > Is it bitmap? This looks really weird, at least a comment is a must to
> > explain why 64-bit for the variable that suggests (by naming) only a
> > single bit.
> 
> There could be 33 PWM channel so it doesn't fit a u32. This is why u64.
> I feel bitmap might be overkill for the task but if requested, I will
> change it.

Why? It has a shortcuts for unsigned long, so it should give you no difference
on 64-bit compilation. 32-bit might suffer a bit, but if you curious you may
check it. The ask here is only based on the variable naming and unclearness of
how many bits are in use. Also bitmap will help to understand the code better.

For instance, here

	DEFINE_BITMAP(initialized, 33); // or rather a definition for 33

will give immediate understanding how this is used and what are the limits.
With u64 it;s unclear what you will do with a potential garbage in the upper
bits, for example.

So, let's say I prefer to see bitmap types and APIs here based on the above
examples.

...

> > This entire function reminds me of something from util_macros.h or
> > bsearch.h or similar. Can you double check that you really can't
> > utilise one of those?
> 
> I checked and bsearch can't be used and and for util_macros the closest
> can't be used. As explained in previous revision, it's not simply a
> matter of finding the closest value but it's about finding a value that
> is closest to the period_ns and only with that condition satisfied one
> closest to the duty. We can't mix them as search for the closest of
> both.

Perhaps adding a comment on top to summarize this, or did I miss it?

...

> > > +       pc->buckets[bucket].used &= ~BIT_ULL(hwpwm);
> > 
> > Oh, why do you need 'used' to be also 64-bit?

Right, but I mean why does each of the buckets require a 64-bit value? Can it
be handled in a single bitmap or so?

Or is it used like a cluster of the PWMs in one bucket?
It feels like bitmap APIs can also improve the implementation here.

> In the extreme case, a bucket can be used by all 33 PWM channel.

-- 
With Best Regards,
Andy Shevchenko



