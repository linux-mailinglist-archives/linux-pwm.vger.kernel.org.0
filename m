Return-Path: <linux-pwm+bounces-6504-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F4FAE5FA2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 10:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B43519213B4
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02226A1B9;
	Tue, 24 Jun 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RM3RFYz2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E726A1AF;
	Tue, 24 Jun 2025 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754467; cv=none; b=fDkkvK350wD98maJKVh4Tk3q/ZdbbbkZNhI5viqPlSQqwAXWBYHPxc213ygbZsfFIY/M9XkOHC/y6iTKtsgD4BVgHWaCY+5PIuS2E8jROFdhFw3kTo/tzr3YHlJJuA5pl6b6kNjiCzxLQCDeXoIx9NJfc7ercj5ZN1RaXnWSUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754467; c=relaxed/simple;
	bh=lk/Bjbk3+mv2kt1pFlaZGlKw+GtH7lYshtGhsBg9vOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWYv5lCrUsoRonE5OlEa1VaEoQ2+Q52Qxg2+jXPWZV4czMIzwA6sRQUsNDA8IJtn0H0NVAlY1ekzyED2+RjJodIkGBd42sIGFtt0rtEvkpCwomQKGjHgKGGEJY6ExCHAOI82P1GBti73B0cBx+orOLnmZf31N3hOQ8biAYj9un0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RM3RFYz2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750754466; x=1782290466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lk/Bjbk3+mv2kt1pFlaZGlKw+GtH7lYshtGhsBg9vOE=;
  b=RM3RFYz2MlOP5PuB+EoqdxPUZhfzl76uO25LhTe9JnxzJnLGFLOwweb+
   9UQYkvlVITse0hT4a2LcWqdj4RtnzCFIHhP20vPLkF26rIMHg0bIAvh6u
   nL8+cT77KF7+bVWh6umk5pOqr54Du4jj7oiUqrnxX0aqvdLCm6Iz49xC6
   nCyBEPEXE/lfeGDL28hzKU7H7IGE7Stc+xJUzXg+WaXVxcIgXETi/INQa
   2nBOluU0JzV9K2shDNqERRPC7AvDWU0hbBLBDTXF5zTjxzNFqESvLAVMK
   gx4y3TQPGomh2I1mL8Qf5onoWdqigjA59mfomf0PZwkgJq8Zvkb9rldmB
   w==;
X-CSE-ConnectionGUID: hspw5SaWS0myPvGf3UGmIg==
X-CSE-MsgGUID: dpDd350pRKmBr0h5fUdKMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56767603"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="56767603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:41:04 -0700
X-CSE-ConnectionGUID: Y1JWHM/TS56NQPtvgGoqkA==
X-CSE-MsgGUID: fkadjsdbTMmZ/LPRDfxMVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="182737850"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:41:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTzD9-00000009Q80-11EQ;
	Tue, 24 Jun 2025 11:40:59 +0300
Date: Tue, 24 Jun 2025 11:40:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v15 1/2] math.h: provide rounddown_ull variant for
 rounddown MACRO
Message-ID: <aFpkmjlc-14xxkn4@smile.fi.intel.com>
References: <20250623211116.1395-1-ansuelsmth@gmail.com>
 <CAHp75VcWW=RaHS9Yb8BcK2Jt7qtNOQzA3eDOZQ88RQG63981cQ@mail.gmail.com>
 <685a5787.050a0220.20ff0f.fd7a@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <685a5787.050a0220.20ff0f.fd7a@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 24, 2025 at 09:45:08AM +0200, Christian Marangi wrote:
> On Tue, Jun 24, 2025 at 09:08:32AM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 24, 2025 at 12:11 AM Christian Marangi <ansuelsmth@gmail.com> wrote:

...

> > rounddown(),
> 
> For this and the other... Is it correct to use () for MACRO?
> I assume () should be used only for functions.

When it takes argument, yes. When it doesn't then you don't put it.

...

> > rounddown_ull()

Btw, I don't like name for this, it's better to be in math64 with the u64 or similar suffixes like it's used for div/mul variants.

Also add a roundup to make the API symmetrical (yes, it's okay that it has no
users, it's a macro and doesn't consume memory at run-time).

...

> > > - Add this patch
> > 
> > Why are math64 APIs not usable here?
> 
> There isn't a rounddown API for math64.

Then implementing it there (in math64.h) looks to me natural thingy that will
implicitly suggest this.

-- 
With Best Regards,
Andy Shevchenko



