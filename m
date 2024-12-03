Return-Path: <linux-pwm+bounces-4211-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952E9E2BBF
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 20:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7401642F6
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91E1FAC5C;
	Tue,  3 Dec 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTcrGgVg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307221F76BE;
	Tue,  3 Dec 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253164; cv=none; b=lCEqjNjd2Q0AGyfGXCK/+N2ntKvEpgKW3tr4XVG1Udfi3BUdIzpmBX/G2YHtfv1ZdGmkIP5VzZ9Hvj2GCKh8ObjSi8kFjILsLNcX14ZRtvLpBTjq6dqnJ6rz5iN+WHnFLj9nXyj3bI5qIHvY1G0BYkPHrZINkooXiSQi8jkCZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253164; c=relaxed/simple;
	bh=BY8xJYqjKpl2WKJoKZoSIeGx13HNuWGORYzI2boaiP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWdDr8gUmGx/wNAa0Dlo+/r/UM8MI3r57yF7U3c8PCywfB00HGD3iPEF8fRwEZRnGnEDjHOtFlrRwQuqhUo4L2U2n1cJZAPHq++b4Fngg0MVwYMttHi+uvPUChGvgyisMoVyjZ6dEe6afihj6XjHZGB//T18KB3Ytxd7a4jc/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTcrGgVg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733253162; x=1764789162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BY8xJYqjKpl2WKJoKZoSIeGx13HNuWGORYzI2boaiP8=;
  b=bTcrGgVg+53LopDShsxdUKCW41gk00sv3QEKUl8W36wnT/2h6SJ1IPd8
   plkmC6/QBh6Nk6QgJZ2akF0R0RHsz7YOUgd33zfeMRZipA5A5PkKuJ8o1
   Sv3OCLPdsU6rkArOpIbLKXp84yIXI5fMsxDri5hsqqQQQ6fvtXFeZ52QL
   XvxET4e9WCdUNTQL/mSWeqsPyrUeJlkajNFwAFilGITGFKEJXgNZpj13G
   80uXvEmqz/p2oCaNIcEjy0WJnVSyWK/VtFyLvwiTxIHXedAsQr/rjOUD4
   rnblJRWLBPs1BZwtin15N6PoCjvFjzZ4GHi+GTAqcPtwDY8pAhojscgi5
   A==;
X-CSE-ConnectionGUID: jmUe8F9dStySw0Oi6koRJg==
X-CSE-MsgGUID: UoEHUFlnT6ibFhhXF88O1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33547206"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33547206"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:12:41 -0800
X-CSE-ConnectionGUID: HMMwx767SLWrOo1m3Plabw==
X-CSE-MsgGUID: 4J0sDVplTnONX3KjhIFotw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93947394"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:12:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tIYK5-00000003Wjk-02kw;
	Tue, 03 Dec 2024 21:12:37 +0200
Date: Tue, 3 Dec 2024 21:12:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: lpss: Move namespace import into a header
Message-ID: <Z09YJGifvpENYNPy@smile.fi.intel.com>
References: <cover.1733245406.git.ukleinek@kernel.org>
 <3a99048a52aeee356d01dbf7f2f06e6e0826ed78.1733245406.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a99048a52aeee356d01dbf7f2f06e6e0826ed78.1733245406.git.ukleinek@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 03, 2024 at 06:16:14PM +0100, Uwe Kleine-König wrote:
> Each user of the exported symbols related to the pwm-lpss driver needs
> to import the matching namespace. So this can just be done in the header
> together with the prototypes.
> 
> This fixes drivers/pinctrl/intel/pinctrl-intel.c which failed to import
> that namespace before. (However this didn't hurt because the pwm-lpss
> module namespace isn't used; see the next commit.)

I disagree on this change, I think it had been discussed already.

The header must not provide any module importing features as it effectively
diminishes the point of namespace. Any (ab)user can include just a header and
be okay with that.

Besides that, you should have based this on recent changes in the NS area of
the module symbols, i.e. module namespaces needs to be provided as string
literals.

See last few commits in Linus' tree as of today.

-- 
With Best Regards,
Andy Shevchenko



