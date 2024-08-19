Return-Path: <linux-pwm+bounces-3042-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D0956571
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 10:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58261C21804
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 08:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908215820F;
	Mon, 19 Aug 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OE/dkwGu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5042A8F;
	Mon, 19 Aug 2024 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055717; cv=none; b=WeGQvsgc7lBjSN//SI0qLBsrzx07JMKZpu8idNw/vdlRk80kltxT2RGy6dmDVy2/6G/EJn+RZ1PQdcsMtPH3siR6K1pri2NJsSM491K4gNxygtSffijLUOKKE1P3icUsSChWqOb0V8SbN0iEGi1AWZJ9pt/Vgtc8BoCgKFaNWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055717; c=relaxed/simple;
	bh=AdJE+GiK9l1UAd1pHCCn+qVf7sr3y/O4qipoHDjEQ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+Q8ZUdXI9cyL5/WZG1gWmm3KJLb4LesxDwcAgNtbTCKKaBDhcmJZn3uD56a0qnJYigw0p4Dyh4s6btQ21WGLCJcDCIQwcq3g0/ws1H/tv7yyViI5N5qfuuno+vlav54amzZ++dAVrkIyEuT4Q6kxeHZLykmYuyC1JoR6l205Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OE/dkwGu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724055716; x=1755591716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AdJE+GiK9l1UAd1pHCCn+qVf7sr3y/O4qipoHDjEQ18=;
  b=OE/dkwGuJ03P3wPQ02CbJu3Kf6sYS0Ds7MsZYGM0x12+OEI7SMTJCTKx
   hbJZ7zsbMItfmZ1ivKGSrpQ3qz07XCZzn3ZODcg9B+yiIJ09io+I3nSoi
   Zk5e1WzHhSitvP/9wvFOYqN6NYG77bl+LZWO0ze6mSRNK82auqeU9IZJU
   jFwNOSFFz6LtETVxApQNfUw0uJP4LIoOWb1RKxlUHlyZ6hpfMqXtfOnEm
   7T6hmVFDxqwJRsyP4j0xG11FIyD34KKoAEqu0/cfBZ0d7nSfQA5ib35NW
   gXNdXirYsBTubYDB/00WIGBbb0vrdPOBXAw6wBV+c80n56m7baoicPJoZ
   Q==;
X-CSE-ConnectionGUID: HRjD4B4zQXumOAciSGmjQQ==
X-CSE-MsgGUID: 1lnukO14SmiYhgwxEfBRCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="25195535"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="25195535"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:21:56 -0700
X-CSE-ConnectionGUID: NK/AVTDgRQKDSc1viHFvGQ==
X-CSE-MsgGUID: UPmxxrDkSsmSwK2Tt6IZhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="64965055"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:21:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sfxeB-0000000Goyx-22oM;
	Mon, 19 Aug 2024 11:21:51 +0300
Date: Mon, 19 Aug 2024 11:21:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: ukleinek@kernel.org, mika.westerberg@linux.intel.com,
	jarkko.nikula@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: lpss: wait_for_update() before configuring pwm
Message-ID: <ZsMAn3hQ4yDq-Gg6@smile.fi.intel.com>
References: <20240819080412.15115-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819080412.15115-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 01:34:12PM +0530, Raag Jadav wrote:
> Wait for SW_UPDATE bit to clear before configuring pwm channel instead of

PWM

> failing right away, which will reduce failure rates on early access.

So, what is the problem this patch solves (or is trying to solve)?
Second, there are two important behavioural changes:
- error code change (it's visible to user space);
- an additional, quite a long by the way, timeout.

Second one does worry me a lot as it might add these 0.5s to the boot time
or so per PWM in question.

-- 
With Best Regards,
Andy Shevchenko



