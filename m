Return-Path: <linux-pwm+bounces-5264-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95DA6A460
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4241D3AF3CF
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF521ABDC;
	Thu, 20 Mar 2025 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ7imm+i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67A189F36;
	Thu, 20 Mar 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468435; cv=none; b=uj2ztI0WvnyXsCHvvibXP0ydXfjF03fXh6SxUNw8iiJEzz8nufczoGvvUQMwZhGRXqBmUGSn+YAQ2c1GvrioMNbwOnjT3yHTvBu/4in/trqWQZMxStu0FXr/dFwOQQaD+UZ+vImsnohs6Sm/rUyPdMZWonKnxqoUYtULnOqCxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468435; c=relaxed/simple;
	bh=pytbhIXjEFHAnDiwulusN7h7v73l0xTTWwiGzlNUBd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmDo/sMVGYbGKEEwdZdhNnu3zJRfkjBW84U5dUCbUBG3qCH1ioVaNwPxSSNzP96dR88E5uLHKk/DzJfNWOtjzs7IoHNLIIHlrxlo9rVCpQ56pCJc3rIhfazbk/iIa9gCbRVeljvqh6+VYwRFpWgHPABODOtAHGDv+wu7DJLUZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQ7imm+i; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742468434; x=1774004434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pytbhIXjEFHAnDiwulusN7h7v73l0xTTWwiGzlNUBd8=;
  b=eQ7imm+io70Ff92wMrpdKXnEWG4/ZllLcacoHd7l2lPIqFMiziOPeQMH
   mg0BGG+CMj/cBkiSwwbwsVLJNgS6AzCnKPzIf5529iT/FCP+Zo3fmKWSJ
   hig2z5tmR/e687N6BRqCuneWZZd9SVrTv81O+zgWDoOVrCl0dJc3GgWrW
   ERbyF/ys/US6mxim9W+/FpfHLHEgr0Yhf7Zeba+gIFtFiBoec+lES5RZg
   omGEbnSkSXH6PwSszOXBovHRd5a7pS+sz3NLoCmGrEBYzm6xuYQ7vlP8Q
   WcxlKhOdiZrEBDdM8A3tJsECI/rRjUDDByDgSqG3v7ncwHC8JtLU7EeyJ
   w==;
X-CSE-ConnectionGUID: ftmqGHLyReKSL2J6HbZ2HQ==
X-CSE-MsgGUID: HsoabV1PSAOdayVE9I9zpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43880447"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43880447"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 04:00:33 -0700
X-CSE-ConnectionGUID: LDhWGPEFQz+2B5q+bGisIw==
X-CSE-MsgGUID: sXOUIabQTCmzAwDbh6otPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123817586"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 04:00:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvDdR-00000004CWA-3noH;
	Thu, 20 Mar 2025 13:00:25 +0200
Date: Thu, 20 Mar 2025 13:00:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <Z9v1Sd0nrUobA9Mc@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-5-fb20baf97da0@bootlin.com>
 <Z9mh0ENc1kDFrJlQ@smile.fi.intel.com>
 <D8KYMWA0B1AD.3J83HQJAXF929@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8KYMWA0B1AD.3J83HQJAXF929@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 09:45:28AM +0100, Mathieu Dubois-Briand wrote:
> On Tue Mar 18, 2025 at 5:39 PM CET, Andy Shevchenko wrote:
> > On Tue, Mar 18, 2025 at 05:26:21PM +0100, Mathieu Dubois-Briand wrote:

...

> > >  			default:
> > >  				BUG();
> > > -				goto exit;
> > > +				return ret;
> >
> > Hmm... BUG() implies unreachable, perhaps just a precursor patch to drop this
> > goto completely?
> 
> Ok, I will add a separate patch to remove the goto.

I just browsed the code for the similar and there are handful that do this.
At least one commit (from 2011) refers to GCC 4.3.3 that complains, but our
minimum requirement AFAIR is 5.1 nowadays. In any case it's up to you. I am
totally fine if you leave this as is.

-- 
With Best Regards,
Andy Shevchenko



