Return-Path: <linux-pwm+bounces-3044-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D7957CE2
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 07:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D78284637
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 05:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F23446A1;
	Tue, 20 Aug 2024 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTn5go0U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098623A9;
	Tue, 20 Aug 2024 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133037; cv=none; b=YLm54tkdwA815bolNLCL07Ic6F1+SCHyM5y/TVBkA9Ji2bz8vJ5Pl5epYFTkEdW3bGwbHUUd4fwHSDrdHpxrtd1XjtigkZNycFRZdZKxuzCoEVQWs4Xu04TA8oiGBBLmSdOAcjfRcBzyNfx+CVipR/5guQfx0p/cDllmLB9sew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133037; c=relaxed/simple;
	bh=65lYnY/nh/DhnHaW0ZYs7pWSXREzeM0x3lfD5X3xRlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuQE4s4KSpKvGRBZ3+0RxzinNNuOeVepJrJLMI5ieC4zhfrRiz09YsZ6HPgLyGB3+ZL2Uc61HA6+V/ODGmOjxatH+M7iK+XqvMQc4th3v0Pq6AlSlMOVJZ/l6IXzBqX1zNbpghH68qD2sTvVsWqgLYNXThanz570RG0dCkfgxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTn5go0U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724133036; x=1755669036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=65lYnY/nh/DhnHaW0ZYs7pWSXREzeM0x3lfD5X3xRlw=;
  b=bTn5go0UxBRJfd5pW4GC6yB5P+WT7Pb3I85Z6jzgd/0ZkgJ3eFap/f83
   2clCGj6EMuSjNBGnTebctXIdma1ETFCwyZINtatvf+bWlO1ZBIh7fTiAX
   gyFfak64/jvkzztdXbEgpFEnjcNHomlqUPzjCMUDW71AuycNWzG0oefsK
   HoEFFFlPfFTSvxIzGB/MJoybKfklNKQhvi0wgwHoQYAGAWI/2pmATzQq7
   oQOlHdaTCr7EZM40TrKOn/LhO47F8vH4prLV12zyznXgK1Eqs74LI8m1f
   UkrTzrUBxFTahuoX1FNFsQN9OtHzNDOQCpaVbaUKt6i4nL4YmUMOqqIvd
   g==;
X-CSE-ConnectionGUID: ATfzKlKOSI6YG5piRcl9KQ==
X-CSE-MsgGUID: otw3R+ARTxSVDp/xbp5UvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47804935"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="47804935"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 22:50:25 -0700
X-CSE-ConnectionGUID: i0Wiw6L3TV+rpYb7lFVuNg==
X-CSE-MsgGUID: TkEl+b70Q1ODsjHbwnqEPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="61163015"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 22:50:23 -0700
Date: Tue, 20 Aug 2024 08:50:20 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ukleinek@kernel.org, mika.westerberg@linux.intel.com,
	jarkko.nikula@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: lpss: wait_for_update() before configuring pwm
Message-ID: <ZsQunMKglYdUwzqo@black.fi.intel.com>
References: <20240819080412.15115-1-raag.jadav@intel.com>
 <ZsMAn3hQ4yDq-Gg6@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsMAn3hQ4yDq-Gg6@smile.fi.intel.com>

On Mon, Aug 19, 2024 at 11:21:51AM +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 01:34:12PM +0530, Raag Jadav wrote:
> > Wait for SW_UPDATE bit to clear before configuring pwm channel instead of
> 
> PWM
> 
> > failing right away, which will reduce failure rates on early access.
> 
> So, what is the problem this patch solves (or is trying to solve)?

Less failures with less code, so just a minor improvement.

> Second, there are two important behavioural changes:
> - error code change (it's visible to user space);

This function is already used in this path just a few lines below.

> - an additional, quite a long by the way, timeout.
> 
> Second one does worry me a lot as it might add these 0.5s to the boot time
> or so per PWM in question.

On the contrary, having a working set of PWMs would be a relatively
rewarding experience IMHO.

Raag

