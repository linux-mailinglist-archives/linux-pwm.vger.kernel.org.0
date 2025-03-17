Return-Path: <linux-pwm+bounces-5209-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7947A65748
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 17:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0791896102
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25030199FA4;
	Mon, 17 Mar 2025 15:56:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B50176FB0;
	Mon, 17 Mar 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226994; cv=none; b=eBkqdeNzdYKcxVKoPaxkXrFAB3xq7mPVhMuP4IKjBn4XZMRK+3JRXp+DFSKvY7AL2vvzUjwkipnBrj240/B1YPp4T2WDA/ZCQ73XS9CqC6hO6Jhtdf5aS7v562JSR82FZ7L/MtMv3X+cU4NNXyFOMUm9g31/Lu6+NEMOKc7hZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226994; c=relaxed/simple;
	bh=JTYbqx6bfQKuupaoVPJmTVygzfWnX4u/I/x3TxxTXO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkcpZJzqOLuyDOX+QOAYNkKu0/9QnTZoRpIyX2g1TqZ++PHMfjnGKqR6tCl2T65il8KDJrRFgN+sKtJg5BZkK/z+NHxETJT2c6PLyXxjHsCgnhesrIWxhXTXBS5eOhmheLdC4KhA5FbG0HJCMENFaPKEJcAsf7FT4yOCoDDh2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: CzZovjXbRCaiOiPHFuTf1w==
X-CSE-MsgGUID: xrWuP8IQTP2PF4Bar1Ld2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="47102973"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="47102973"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:56:32 -0700
X-CSE-ConnectionGUID: EA25EyGGQmuYBW7eHEHuYg==
X-CSE-MsgGUID: FN4NgrbwT2KvtC80qpTwdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122157561"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:56:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1tuCpE-00000003LsH-1IHs;
	Mon, 17 Mar 2025 17:56:24 +0200
Date: Mon, 17 Mar 2025 17:56:24 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z9hGKCdR7NHqfRmC@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
 <D8FAX4E29LZK.3VUK90WB04MV2@bootlin.com>
 <Z9PlYSZDviGOCV7X@surfacebook.localdomain>
 <D8ILQ4NT6977.50SD8DM8FIBF@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8ILQ4NT6977.50SD8DM8FIBF@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 03:13:07PM +0100, Mathieu Dubois-Briand wrote:
> On Fri Mar 14, 2025 at 9:14 AM CET, Andy Shevchenko wrote:
> > Thu, Mar 13, 2025 at 06:07:03PM +0100, Mathieu Dubois-Briand kirjoitti:
> > > On Fri Feb 14, 2025 at 4:59 PM CET, Andy Shevchenko wrote:
> > > > On Fri, Feb 14, 2025 at 12:49:57PM +0100, Mathieu Dubois-Briand wrote:

...

> > > > > +	/*
> > > > > +	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad debounce
> > > > > +	 * timings and gpos/keypad columns repartition. Only the later is
> > > > > +	 * modified here.
> > > > > +	 */
> > > > > +	val = FIELD_PREP(MAX7360_PORTS, ngpios);
> > > > > +	ret = regmap_write_bits(regmap, MAX7360_REG_DEBOUNCE, MAX7360_PORTS, val);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Failed to write max7360 columns/gpos configuration");
> > > > > +		return ret;
> > > > > +	}
> > > >
> > > > Shouldn't this be configured via ->set_config() callback?
> > > 
> > > I believe this comment has been a bit outdated by our discussion on
> > > using GPIO valid mask, but I believe we could not use the ->set_config()
> > > callback here: this callback is made to configure a single pin while the
> > > gpos/keypad columns repartition is global.
> >
> > Yeah, we have similar desing in Intel Bay Trail (see pinctrl-baytrail.c) and it
> > requires some software driven heuristics on how individual setting may affect
> > the global one. But the Q here is is the debounce affects only keypad? Then it
> > should be configured via keypad matrix driver. Btw, have you checked
> > drivers/input/keyboard/matrix_keypad.c? Is there anything that can be useful
> > here?
> >
> 
> Hum, maybe the comment is not clear enough? Not sure, but please tell
> me.

I see it now, yes, the comment seems point too much attention on the register
(and hence its name) then content.

I would start this comment with something like:
"Configure which GPIOs will be used for keypad."

> So yes, this register is named "debounce" but controls two different
> things:
> - The keypad debounce: we do not touch it here.
> - The partition between keypad columns and gpos. This is the value we do
>   modify here.

-- 
With Best Regards,
Andy Shevchenko



