Return-Path: <linux-pwm+bounces-3887-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC859B0356
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CE61C21014
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84EB70805;
	Fri, 25 Oct 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZ97zT5r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973870809;
	Fri, 25 Oct 2024 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861465; cv=none; b=L7puKqkCft8IB8GO3pQWIqqlemZbmHDLrQ8FAxieezX7TJNlyhzglk4nu8BEkXLg03VoDGMfB3FpUgIL1HJO59eAvG5OXs8MllYt9Hyv/w9ypst0dvvoBN6CRoFfgyzYtmqvhph2fj3uyNcHDWdzb2im6U6pMYLQYyvyJI90JIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861465; c=relaxed/simple;
	bh=NWGohbueqG/j+JmWmHB+4eKfOxe9FBjYi4BTTZEPboo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSSH1UZYYNQuu1bWccMwaaIWf54bLdYZ2BJ/MMC7R/Wynw2miLF2Inw00N3tqgL5TqK+Uyj95qbhWBkZjTkHX1L8NkmVixXdAntHmaMghs58/wDEIdtbkhJOI1IkdVwlb5KmPwURGbXTFe9p3Ydz244vCJFbuXLMbvcYIhFvt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZ97zT5r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729861464; x=1761397464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NWGohbueqG/j+JmWmHB+4eKfOxe9FBjYi4BTTZEPboo=;
  b=gZ97zT5rMS++xnSMNRBElEQ4PWDdtxey3qAsQEu5yBXeYoLCtAacczlK
   Sf8mLbjhMTv2vBSANP1+YV5X6E66QDmpGNV5yH0dVXyQfLDejxGObar6g
   Gm92uFPbXyinJ8o4unYTcyqqDtppwamkBPOS0qkGLIMPxJNoT5nE2tFNi
   KKP85xaOsITfDLN5Xo4tWpxp8mXTfdT+7Sn2l1Qa87qPT4X2BHukBHOZb
   3hkRVoBm+iaIMl/gsLqHCP/8EJsMAp4qhoIMzK6CFUJ4sIizyX2ozWvmk
   XDZLQ8ggqkP79kpeHtn6NsQWEKY0h9szYG+YOGjvK7n+D+sl1SuWzh2bS
   Q==;
X-CSE-ConnectionGUID: 8j0I6qu8SzCtCBge5NjIWQ==
X-CSE-MsgGUID: YNF++SNEScSfF65ozTEUxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40082580"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40082580"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:04:23 -0700
X-CSE-ConnectionGUID: jN8yiODkSGO/vJ5TG0HtTA==
X-CSE-MsgGUID: DvDijyO4SRqyAsH4NdwIjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85488220"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:04:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4JzH-00000006v17-2UHo;
	Fri, 25 Oct 2024 16:04:19 +0300
Date: Fri, 25 Oct 2024 16:04:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
Message-ID: <ZxuXU3nTuEwoTFiH@smile.fi.intel.com>
References: <20241024151905.4038854-1-andriy.shevchenko@linux.intel.com>
 <2r7ey7fkt4k3s3kpi2vmesqrfntyd6jt7uf5jmwwbzglgxcohf@lr5gfy3ce2yu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2r7ey7fkt4k3s3kpi2vmesqrfntyd6jt7uf5jmwwbzglgxcohf@lr5gfy3ce2yu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 10:55:36PM +0200, Uwe Kleine-König wrote:
> On Thu, Oct 24, 2024 at 06:19:05PM +0300, Andy Shevchenko wrote:

...

> >  	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
> > -		const char *chip_name = dev_name(pwmchip_parent(chip));
> > -
> > -		if (chip_name && strcmp(chip_name, name) == 0)
> > +		if (device_match_name(pwmchip_parent(chip), name))
> 
> This theoretically changes behaviour in a few cases. For example if
> dev_name(pwmchip_parent(chip)) is NULL the new code would crash. Can
> this happen? 

Please, tell me how
(looking at the of device_add() and kobject_set_name_vargs() implementations)?

Btw, have you ever seen this check somewhere else? (I don't, but I haven't
covered full kernel sources, of course.)

-- 
With Best Regards,
Andy Shevchenko



