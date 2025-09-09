Return-Path: <linux-pwm+bounces-7275-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11AEB4FC32
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61FD1BC18FB
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5782F2857DE;
	Tue,  9 Sep 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msWbR3ZB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B2E221269;
	Tue,  9 Sep 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423822; cv=none; b=kTTga7n8KVadIdVlIjjXv2+fzIudbWfi87IYHEkn2KGKkRZ6qfDGNi2GHf74J04wuzocaA7J2OOKUOe0+uuxCiCsOA/Pt1/Z0zJ33i4pV34SN9u1Znu4CPp69EVN+f8BNxZhrfJDf4zarYHXRrtFp1NLGxk2/s+55th76sCa+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423822; c=relaxed/simple;
	bh=3ZJFnHXZcIVMtVs6RNmDeWVt7jxFEYHMJYJemwgLC1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9BUs1DSvOETnYJevCMW6r317uwVvcmaJS+i3Yel2VYRhpJHbWt6+ibebwZPJYPbU7R79b6kTL73OoxmIjT9MR5regzqwD0E1UAJbhaBocsGpQEJAvJs7+gw2nYY3tnkeAgmgwTaRjfPJyOeSCFfVsbSLp2NLTeH2jMXpgZj7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msWbR3ZB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757423820; x=1788959820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3ZJFnHXZcIVMtVs6RNmDeWVt7jxFEYHMJYJemwgLC1g=;
  b=msWbR3ZBgPA1YD5M1TP/vdMIJ7uThftXaVIIDY4cs3zF68IRp7kC1cDu
   N8dcpGYVfkkKmhDP+1+OTQd6HGHzWD18fGtHA2Sw0FVEgk4JE96aBCcAJ
   grQBsSxj/+jwBo8MvT4DxAjD2QEwCKYawsskNkrVY4Hd81Zxtxnqnv7DQ
   QMqLmnciT7qVKKG2HTipj9jLivBxq8JiwyRPc4Rzjvs4rzEj3x4ivmi9z
   ovGPyNhdX2O97pd5s9DShAMLJpt7h29AAUS2nrKNyrQvz4gmHQIICvq9k
   mnx6juJCO6V/L1A4UgA0nxONlU79jHKsBWgPuAPiHYDrh2iOae8dB3qMF
   w==;
X-CSE-ConnectionGUID: otFSjtjxRDGGmD6KU8PAtg==
X-CSE-MsgGUID: ZuaFE647QEuDHsbHP/92Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58922404"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="58922404"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:17:00 -0700
X-CSE-ConnectionGUID: 7bCaey0GSeGG6SYUQ59UiQ==
X-CSE-MsgGUID: wkAd4Ci2Tom13opdMAHmfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="173547347"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:16:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uvyDP-00000001Ro4-2kZy;
	Tue, 09 Sep 2025 16:16:55 +0300
Date: Tue, 9 Sep 2025 16:16:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aMAoxyG__5HoEcyv@smile.fi.intel.com>
References: <20250708145053.798-1-ansuelsmth@gmail.com>
 <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>
 <68bf2509.050a0220.702b3.c003@mx.google.com>
 <aMANiyqxneM1QxQ-@smile.fi.intel.com>
 <68c014b1.050a0220.1de3c.3050@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68c014b1.050a0220.1de3c.3050@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 09, 2025 at 01:51:11PM +0200, Christian Marangi wrote:
> On Tue, Sep 09, 2025 at 02:20:43PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 08, 2025 at 08:48:38PM +0200, Christian Marangi wrote:
> > > On Fri, Aug 01, 2025 at 11:15:41AM +0200, Uwe Kleine-König wrote:
> > > > On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:

> > > > > +	 * Period goes at 4ns step, normalize it to check if we can
> > > > 
> > > > 4 ms or 4 ns?
> > > 
> > > 4ms you are right
> > 
> > One small but important side note (to Uwe as well, however he seems
> > follows what I am about to say). Recently I discovered a nice wrap-up [1]
> > on the writing values with units. And I think we should try to follow it
> > (at bare minimum to be consistent with chosen — Journalism vs. Scientific —
> >  style).
> > 
> > [1]: https://poynton.ca/notes/units/
> 
> Just to be more precise, on comments we should use NUMBER SPACE UNIT? I
> think for variables it's problematic.

Of course the note only about documentation and comments, not about the code :-)
And yes, $NUMBER space $UNIT (personally I prefer the Scientific way).

-- 
With Best Regards,
Andy Shevchenko



