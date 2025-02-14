Return-Path: <linux-pwm+bounces-4918-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF8A365D9
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 19:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F329F3A95DC
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165DD18F2DF;
	Fri, 14 Feb 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbfhbpZq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9D23A9
	for <linux-pwm@vger.kernel.org>; Fri, 14 Feb 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558608; cv=none; b=i3I6/hQxMlg8i4FSHBk/aEWqcPTXGVAdB0ZlUH41rJlyQh46T1Ctjz3rX/LvdKzULeAHzrV9GRESFdgszHMMFuZL3dm7sAbQOlDQV3tFO5OAC+WhSG73WYrJIZhp61wlH38NqTzXi9snU+IVHOJ9a83T7DlNFab1DeJI/lqYF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558608; c=relaxed/simple;
	bh=YMbKzKvxqrzppSXk0xeQrHPuFGT1OocEkiDJIUdm2bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bafe9UxHG5oPfhuCGxwfDFoSY8lML5XzOPtbgF9I+Oc6gYeGAsGO94+WJrUti0gRfe0O9puVPUqexqQiScTkxmJHZn0zfkJxW63TZXzgCON5BVfL5Y3p3Cm7+chnK2r6xrappzrLLsgimkY7EWRHuMjMVgdjUpRBlrqMEdqym/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbfhbpZq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739558606; x=1771094606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YMbKzKvxqrzppSXk0xeQrHPuFGT1OocEkiDJIUdm2bc=;
  b=BbfhbpZqmepLy4KG5iqg8Q0xkZHA4iR3zvu1QU1XjZ+6SR5QduOsX+3q
   sgGI+FBhQ7p/oCElBI4mSryZ6A+OXDBFoWAECPn6Xmr/bu1vD3AqU+RgG
   VXQ8kSV88Pu04dHV0367fX3urU1ck+JLIpZeeoZjmO2VgzANamvW11+/d
   XclyGKjz9KGzCxL/r5wmnXk2RX76PxRs5019h/BkVSDcuGvp1Lxtd13LJ
   yvgahGc021ZlxxRS1LhHmAIDpGZ8YsbFxcRmL7EgT6+UHUTicFXpt9zun
   OD/ySj6K7/yIf65VfBymD02xr2/JnzzR4nPS8/2/KIZx066AHC5hCVpCw
   w==;
X-CSE-ConnectionGUID: zCNvqZXdR+WUPDld2FaG0A==
X-CSE-MsgGUID: HtQ0vnd3TSG2tKnGj26m8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57847914"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57847914"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 10:43:23 -0800
X-CSE-ConnectionGUID: poLhPUHISBKaCDjQMMoD3A==
X-CSE-MsgGUID: spc3cpV3TTSz0vmgbJzDCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118731444"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 10:43:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tj0ek-0000000BZgM-49en;
	Fri, 14 Feb 2025 20:43:18 +0200
Date: Fri, 14 Feb 2025 20:43:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: clps711x: Drop of_match_ptr() usage for
 .of_match_table
Message-ID: <Z6-OxrGAl44HrzVg@smile.fi.intel.com>
References: <20250214163442.192006-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214163442.192006-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 05:34:42PM +0100, Uwe Kleine-König wrote:
> The pwm-clps711x driver depends on ARCH_CLPS711X || COMPILE_TEST. With
> the former being an ARCH_MULTI_V4T platform, there is always OF=y when
> ARCH_CLPS711X=y, so in practise clps711x_pwm_dt_ids[] is always used.
> (And in the case COMPILE_TEST=y + OF=n this only increases the driver
> size a bit but still compiles.)
> 
> So drop the usage of of_match_ptr().

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Note, that those macros, of_match_ptr() and ACPI_PTR(), more harmful
then helpful. If you look at the history of the project, you may find
many patches that were fixing compilation warnings of unused variables
or so due to (mis)uses of those macros.

-- 
With Best Regards,
Andy Shevchenko



