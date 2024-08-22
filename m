Return-Path: <linux-pwm+bounces-3052-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F2195B0F7
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Aug 2024 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2B1F2143D
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Aug 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0116DEDF;
	Thu, 22 Aug 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4dMOlLH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD016DEAC;
	Thu, 22 Aug 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316944; cv=none; b=Vvzzhep3qiD7I6VV4IjuI9SCuskKaM/iYkQ7O7vh3Rst98O4IMfKYgbHQn0ItxgqgGsE5nuXtOhdpXZbpThJv9ONdTPzkjlaskAmGTp1CL2ehXgejS414lHkYaibDVaroBoN4JbdbRLB+zgSZUB+u2ydcmpFvuGiLTu/RP59cGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316944; c=relaxed/simple;
	bh=GpnXwj7uWMEE0X6ztaqoi91+86UCwSdJEehp27U+N9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZH+zEmGTpm1tCNrwoSCUxKcagc0x9xGUDKgh3yu0p0ofcSwifo1mhRuSFHEIZOJd7M0cXq/10qaWjd2ZBh4MHvl1nyaLF9sAHbL4STaCF4OPdRWVcwvk8MLLJbchnuwppttbajReSsXi0E6j2e0CSdKwzkdSkVeNHNPoqzwD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4dMOlLH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724316943; x=1755852943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GpnXwj7uWMEE0X6ztaqoi91+86UCwSdJEehp27U+N9I=;
  b=C4dMOlLH1p1wBfhKbOwuSD6ncwLVP2udDi6eNzxvL68QDJ00byYtXFux
   C80pAycBnWRP3h9wG++5rem9pzcajAW/7LmDuKziHmqIgmD4KFC6vi3Xj
   TAsmFNfCv5rnljVunKXMyHDyli8mMpHSP4Wb/edxx6/QLEuwk5smg9LCk
   WMeik9LkROZyFh53iqJa7ZI3mNxhKXK+UqzclPcmanZse8ql/mlWM7ay3
   UIB3+LalBOTHQuBdTcRkSiOFI8N2gi1K2qbp22VTgOaVB+D1tJOPOsVQD
   pQZQ721SB3vdK3OQ1nMCWyisqxqjoF62FhHYjrlqTwakr9aJBZxY9ny8y
   Q==;
X-CSE-ConnectionGUID: 2PllYszQTDaBZaburOJPHQ==
X-CSE-MsgGUID: vfs3lreuSxupHPnnXQqI9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33286211"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33286211"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:55:42 -0700
X-CSE-ConnectionGUID: YxqbJHqDTH+I11PH5ChIcQ==
X-CSE-MsgGUID: qhSnl4UHQBuKwGnTpbcQRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61366392"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:55:40 -0700
Date: Thu, 22 Aug 2024 11:55:37 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ukleinek@kernel.org, mika.westerberg@linux.intel.com,
	jarkko.nikula@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: lpss: wait_for_update() before configuring pwm
Message-ID: <Zsb9CRoQUHEQKT_V@black.fi.intel.com>
References: <20240819080412.15115-1-raag.jadav@intel.com>
 <ZsMAn3hQ4yDq-Gg6@smile.fi.intel.com>
 <ZsQunMKglYdUwzqo@black.fi.intel.com>
 <ZsRoNHff5oDcMTcz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsRoNHff5oDcMTcz@smile.fi.intel.com>

On Tue, Aug 20, 2024 at 12:56:04PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 20, 2024 at 08:50:20AM +0300, Raag Jadav wrote:
> > On Mon, Aug 19, 2024 at 11:21:51AM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 19, 2024 at 01:34:12PM +0530, Raag Jadav wrote:
> > > > Wait for SW_UPDATE bit to clear before configuring pwm channel instead of
> > > 
> > > PWM
> > > 
> > > > failing right away, which will reduce failure rates on early access.
> > > 
> > > So, what is the problem this patch solves (or is trying to solve)?
> > 
> > Less failures with less code, so just a minor improvement.
> 
> It's not an equivalent code as I mentioned below.
> So, if it's just a "cleanup", I do not think we want it as code works now and
> have no penalties.
> 
> > > Second, there are two important behavioural changes:
> > > - error code change (it's visible to user space);
> > 
> > This function is already used in this path just a few lines below.
> 
> Yes, I know, but it is used in a slightly different context.
> 
> > > - an additional, quite a long by the way, timeout.
> > > 
> > > Second one does worry me a lot as it might add these 0.5s to the boot time
> > > or so per PWM in question.
> > 
> > On the contrary, having a working set of PWMs would be a relatively
> > rewarding experience IMHO.
> 
> I'm not sure what this patch tries to fix. Was something not working before?
> Was something become different on real hardware that makes this patch worth to
> apply? None of these questions has been answered in the commit message.
> 
> So, as long as this is considered a pure cleanup, here is formal NAK from me as
> this IP block is not stateless and may lead to freezes. Hence the rule of thumb
> "do not touch the working things".

Fair enough. However, I was able to test it on Merrifield, Bay Trail and Broxton
(both PCI and platform counterparts) without such problems, if it is helpful in
any way.

Raag

