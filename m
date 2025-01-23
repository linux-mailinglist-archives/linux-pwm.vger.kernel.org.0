Return-Path: <linux-pwm+bounces-4720-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D655DA1A748
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD70F1887B20
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6F20F998;
	Thu, 23 Jan 2025 15:48:23 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8EC288A2;
	Thu, 23 Jan 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647303; cv=none; b=dP+Mw/FLztkXKmYbMRltMMk8J4hIaSrPSSAJPQXQvuJksUNkZKlEo4yZMv5VOEid0QYZAuhKB0bJ5cf19xWtgNml/w+U5yjiBF7QTYaWylmgNX8EZoY+mMf+TSRQ0ykHh0d2uAvdfdDNwm7QO4BfDoXx/U7qozBSOQX+Eu1Hs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647303; c=relaxed/simple;
	bh=+ji13CHM+bL+HrFmPHAAFqi+YSsPmv1iDrR7LwxSwXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAbSYxamRoS+IjVA6tCcnfWjubGr1mtkIVvWTK0K98tEXvXODErUfuhJpTMJMH1TPumdfiiXu731/a/iclBkq0RZfr2jiTHFanbPYTqADsycEYKkGDsMNON6aPsbL3GGafSnKnvn6OW/as6Ttpk3df8MN2n8IHAOTjLnXVnMdv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: 9alscQlJTfOtBPuj0a9Rfw==
X-CSE-MsgGUID: wVEoy4+zTVy+dyC1JqPtBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="42079902"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="42079902"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:48:21 -0800
X-CSE-ConnectionGUID: m3ehGXuVROezCrJ8OysQ2A==
X-CSE-MsgGUID: QKBQxZqqQ8uU2M12N57ZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107615840"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:48:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1tazRJ-00000004S0m-41oQ;
	Thu, 23 Jan 2025 17:48:17 +0200
Date: Thu, 23 Jan 2025 17:48:17 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pinctrl: intel: Import namespace for pwm_lpss
 function
Message-ID: <Z5JkwTAO5NKeHnmK@smile.fi.intel.com>
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
 <20250123101110.339337-5-u.kleine-koenig@baylibre.com>
 <CAHp75VekFNu8Jzfit5euj2pKeesGHs3DQS4hJdT==RM7MONb4g@mail.gmail.com>
 <gw223bv34jyszlssyegvz2znb7q4zzh3lax2qgmvcx6m5lvy6l@gpuvyyhvsgf7>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gw223bv34jyszlssyegvz2znb7q4zzh3lax2qgmvcx6m5lvy6l@gpuvyyhvsgf7>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 23, 2025 at 03:52:06PM +0100, Uwe Kleine-König wrote:
> On Thu, Jan 23, 2025 at 01:45:17PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 23, 2025 at 12:11 PM Uwe Kleine-König
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > The intel pinctrl driver can provide a PWM device and for that needs to
> > > call the function devm_pwm_lpss_probe(). That function is provided by
> > > the pwm-lpss driver which intends to export it in the "PWM_LPSS"
> > > namespace. To prepare fixing the pwm-lpss driver to indeed use the
> > > "PWM_LPSS" namespace, import that namespace when used.

...

> > > +#if IS_REACHABLE(CONFIG_PWM_LPSS)
> > 
> > > +#endif
> > 
> > Why?
> 
> Because devm_pwm_lpss_probe() is only used #if
> IS_REACHABLE(CONFIG_PWM_LPSS). Without the #if but with
> https://lore.kernel.org/all/20250123110951.370759-2-u.kleine-koenig@baylibre.com/
> this results in a warning (with W=1) :-)

There is no such commit in the current Linux Next, so let's solve the issues
when they come up.

I'm okay to take your series via Intel pin control without that ifdeffery.
If you don't agree on the change, we need to find the way how to avoid ugly
ifdeffery from day 1.

-- 
With Best Regards,
Andy Shevchenko



