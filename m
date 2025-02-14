Return-Path: <linux-pwm+bounces-4912-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F1CA362B0
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 17:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EB13A60AE
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26599267396;
	Fri, 14 Feb 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYi7ThzX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7F264F9F;
	Fri, 14 Feb 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548978; cv=none; b=OxyHYE8V2dS1Wuz/M60CznHfv20tcj6GSLtPln/NhM3ck/2sS4e0jXcgu9XuBlB3PBXiQFu8iMsM6AhglojaHqULFIWn3IlhpBZO8/4R/0B556vJ5vm7A0ANTcXp90zAfHv3mM4cekyj5PSICtuWX1wzMpx15W+dgh5N5s+gAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548978; c=relaxed/simple;
	bh=MAjpCZOZoyGfd6fah3oQUUOvsbLcuxHpsSWESwVYX38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEi6hxDcDV0T8anDNFRqa4d7qa3AFfSz6bbRchTqD6apnjMwuBdhnuxz2BMrbQkmgGrXcvZ6wNRNYr02CL0kg1+YdRaZlkkN/3HI5qnsZBHM11fgpo55ynejDb6jSpvjDkSB+DRysaVl3zidCvXMjfjrtiQa1ONWrEeFwSy4n7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYi7ThzX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739548976; x=1771084976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MAjpCZOZoyGfd6fah3oQUUOvsbLcuxHpsSWESwVYX38=;
  b=eYi7ThzXNvIiz7agQuNgTwmuNdl8YjN0h934I8I12XZWwGYGswwUGN06
   01FtvTUGdjul7ZVh8rc7ZcTEWbuJkBRhKM2j3/jjskAKQpwX7fjil8PKh
   sulmZMAyedvrAiQNxeWFhVb2EXpoQOC80j7lce9+2je3tkzlvOs4P3EWJ
   uRsdp2rdiKnUDCNWyxmlk5hORykvVFPOAzmkmuhTF2gkXbxpaah+i2e9Q
   1kql2Rc1li/5cJMWhz+JkBAHuWnHoYR64lZjwxIOqLJ0kZYu+jKK/KSgd
   BFKBCM6Dc8BcfLw7pSY6pVptWWgZq+MYz69gaL0/0Kp8uJh3ZuM+ufXYU
   A==;
X-CSE-ConnectionGUID: t6yUfC0WQ/yjGXAd0R3OLA==
X-CSE-MsgGUID: /kGJqZqPQXmNdcOYWzuEPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="65658042"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="65658042"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:02:55 -0800
X-CSE-ConnectionGUID: 1tvWR5XLTECSx6EZF0ypJA==
X-CSE-MsgGUID: 9fGnYwAnSjysFeiFWxbcvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113349387"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:02:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiy9P-0000000BXSZ-3hUD;
	Fri, 14 Feb 2025 18:02:47 +0200
Date: Fri, 14 Feb 2025 18:02:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH v4 06/10] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <Z69pJ3BWp_cGV1yq@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-6-8a35c6dbb966@bootlin.com>
 <Z69eue2dV37vw61v@smile.fi.intel.com>
 <D7SADDQZUERA.PT8QLVZ9ZN1N@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7SADDQZUERA.PT8QLVZ9ZN1N@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 04:49:57PM +0100, Mathieu Dubois-Briand wrote:
> On Fri Feb 14, 2025 at 4:18 PM CET, Andy Shevchenko wrote:
> > On Fri, Feb 14, 2025 at 12:49:56PM +0100, Mathieu Dubois-Briand wrote:

...

> > > +static irqreturn_t regmap_irq_thread(int irq, void *d)
> > > +{
> > > +	struct regmap_irq_chip_data *data = d;
> > > +	const struct regmap_irq_chip *chip = data->chip;
> > > +	struct regmap *map = data->map;
> > > +	int ret, i;
> >
> > 	unsigned int i;
> > ?
> 
> I agree, but signed int index variables are used in all functions of
> this file. What would be the best approach here? Only fix it on code
> parts I modified? On the whole file?

I would change in the code you touched,

> > > +	bool handled = false;
> > > +	u32 reg;
> > > +
> > > +	if (chip->handle_pre_irq)
> > > +		chip->handle_pre_irq(chip->irq_drv_data);
> > > +
> > > +	if (chip->runtime_pm) {
> > > +		ret = pm_runtime_get_sync(map->dev);
> > > +		if (ret < 0) {
> >
> > > +			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
> > > +				ret);
> >
> > Can be one line.
> 
> Yes. Kind of the same question here: should I fix only the code close to
> the parts I modified or the whole file?

Same, it falls under the "common sense" category.

-- 
With Best Regards,
Andy Shevchenko



