Return-Path: <linux-pwm+bounces-4759-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4103A25E60
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5CD7A11A6
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4922080FD;
	Mon,  3 Feb 2025 15:19:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4C201270;
	Mon,  3 Feb 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595986; cv=none; b=BmLXm6Osnnwn5t8FvTfXF4xf6AwxktEPc43PIWln1MpxtJe1/VNaW9YbI7Twbbwfr+t1EzGpgzejuIbzYtVP9MsYDYbo1jXTZOx1Vonk8DjC5bs0UyW7AyFXTMf/7KWrOBes73CLOlmeTeLShN8+wJ/Zx0yxyJkaFoc19Ika0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595986; c=relaxed/simple;
	bh=zPxnIStNSWd8T8InfzBNuvDDeu4qTWFOb1t/3vkT8FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyIEjDGAGLkltj4C84gU93Oo5yarx+MSjVBuarnKLzviMpX864iTqAehMKe+coHRK1XFrHaqp5riWpyuzAeVwDlc6pBAN+W8eF9G5KUovKibpprwUAdC/sDYNCMCboTmqc6MWn2Gmj3UwJyXsG7VKHg1kHPuXiXfo3RMGPkmfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: ookRIJUVRWyBnMH+lRouiQ==
X-CSE-MsgGUID: fy1UWUXdRE+0nfOA8BWjrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49348844"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="49348844"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:19:44 -0800
X-CSE-ConnectionGUID: Rf/UqqPvRICbJnG52bMqbg==
X-CSE-MsgGUID: kRPIYVSMSfq5PbY1+vZRFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114937934"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:19:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1teyEe-00000007s1o-2uHW;
	Mon, 03 Feb 2025 17:19:40 +0200
Date: Mon, 3 Feb 2025 17:19:40 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pinctrl: intel: Import namespace for pwm_lpss
 function
Message-ID: <Z6DejKRkxa1XCc5E@smile.fi.intel.com>
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
 <20250123101110.339337-5-u.kleine-koenig@baylibre.com>
 <CAHp75VekFNu8Jzfit5euj2pKeesGHs3DQS4hJdT==RM7MONb4g@mail.gmail.com>
 <gw223bv34jyszlssyegvz2znb7q4zzh3lax2qgmvcx6m5lvy6l@gpuvyyhvsgf7>
 <Z5JkwTAO5NKeHnmK@smile.fi.intel.com>
 <yynjwr57jf4ytixfo2c6bojo5ib5plue7krlwzb64rxrfuqghy@u4pkkktbe7b3>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yynjwr57jf4ytixfo2c6bojo5ib5plue7krlwzb64rxrfuqghy@u4pkkktbe7b3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 23, 2025 at 05:30:07PM +0100, Uwe Kleine-König wrote:
> On Thu, Jan 23, 2025 at 05:48:17PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 23, 2025 at 03:52:06PM +0100, Uwe Kleine-König wrote:
> > > On Thu, Jan 23, 2025 at 01:45:17PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Jan 23, 2025 at 12:11 PM Uwe Kleine-König
> > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > >
> > > > > The intel pinctrl driver can provide a PWM device and for that needs to
> > > > > call the function devm_pwm_lpss_probe(). That function is provided by
> > > > > the pwm-lpss driver which intends to export it in the "PWM_LPSS"
> > > > > namespace. To prepare fixing the pwm-lpss driver to indeed use the
> > > > > "PWM_LPSS" namespace, import that namespace when used.

...

> > > > > +#if IS_REACHABLE(CONFIG_PWM_LPSS)
> > > > 
> > > > > +#endif
> > > > 
> > > > Why?
> > > 
> > > Because devm_pwm_lpss_probe() is only used #if
> > > IS_REACHABLE(CONFIG_PWM_LPSS). Without the #if but with
> > > https://lore.kernel.org/all/20250123110951.370759-2-u.kleine-koenig@baylibre.com/
> > > this results in a warning (with W=1) :-)
> > 
> > There is no such commit in the current Linux Next, so let's solve the issues
> > when they come up.
> > 
> > I'm okay to take your series via Intel pin control without that ifdeffery.
> > If you don't agree on the change, we need to find the way how to avoid ugly
> > ifdeffery from day 1.
> 
> I'm ok with dropping the #if. Should I resend or do you want to edit the
> patch? Would you take both patches then?

I can take both. No need to resend.

-- 
With Best Regards,
Andy Shevchenko



