Return-Path: <linux-pwm+bounces-4939-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573BEA38D09
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 21:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C154F1887E6B
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D320723716F;
	Mon, 17 Feb 2025 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMLrfFky"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD713AA5D;
	Mon, 17 Feb 2025 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822925; cv=none; b=I651ztCk0P3wqKmxEtNeO4xwlxMs5Axn1tiJElOeZa33buyoVpZyrHBP2KtWoumBxqTpMeXVhv7XbtzPnGsqwfprWLsDM+Wmwq4ev2KAxMe0dosazGVBryaMdgo4MLbGQFm/D6QbaRJxy7+oCC50MeomJjpRv53umQkVx8j/l3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822925; c=relaxed/simple;
	bh=VFMG6NziVLhzXatJ1ZtCN9l/hVuOYcrvdIJmUyyZjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJhm8sr9W4M/Whhum6xjEkzKJqvFlnTCRiWwD0baSwgGjGYNH++Xhp9kgcAkivFVXher6JwENrLGy3RUrVoR9xbBwBYWGScOYJctnc+q/8rHgwB6CFx6bZNsQrYGJ+TCmBOk7n0uGU79RjnYch88O4dDyGVDdKCIpvT2wViYHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMLrfFky; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739822924; x=1771358924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFMG6NziVLhzXatJ1ZtCN9l/hVuOYcrvdIJmUyyZjYA=;
  b=SMLrfFkyYkGAejn/bv90RRNqruinOo6GhY+SEY8DJBZ+WAqddB1XjF6i
   Sw1L/6+n4biRvp/c+RNFveZnwQbC60ZHDqOhejScZqDrp17+yhFqeoeW3
   h0HJXWxJoxzbqZgy+xHGUiA7NGUGF/YKkI/rQxzHAujzFLvEYqWgVcNbU
   MnKUVFHC2es9N+zg3vu/h5grTZYEDXW+Ko+eZxlusaYF1uaJecUf0+jYQ
   ql855g+t2csdO8c6Q8BYnQrfIkMDLEpLy61FkNXlKv26nGdcL2XqanTmi
   bbeCdB2IvlsGJ3ONFL7xO3JVsIAR0q2FR2KOss3XIeAcrub+MG+VUHnR1
   Q==;
X-CSE-ConnectionGUID: FMendW1UQ3qI+n55Nyoomw==
X-CSE-MsgGUID: DflpHOgaTI+PsjHPa+gIiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40369269"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="40369269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 12:08:43 -0800
X-CSE-ConnectionGUID: LDsaFI0DSXeqLi85M8zeBA==
X-CSE-MsgGUID: NotF7x3HSBWH36vhwpW31g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114076131"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 12:08:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tk7Pv-0000000CVST-09Tt;
	Mon, 17 Feb 2025 22:08:35 +0200
Date: Mon, 17 Feb 2025 22:08:34 +0200
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
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z7OXQqyPjtGgTySf@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
 <D7UOIHL2WOZP.LLGRKMILNJFU@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7UOIHL2WOZP.LLGRKMILNJFU@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 17, 2025 at 12:20:13PM +0100, Mathieu Dubois-Briand wrote:
> On Fri Feb 14, 2025 at 4:59 PM CET, Andy Shevchenko wrote:
> > On Fri, Feb 14, 2025 at 12:49:57PM +0100, Mathieu Dubois-Briand wrote:
> > > Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.

...

> > > +static int max7360_gpo_reg_mask_xlate(struct gpio_regmap *gpio,
> > > +				      unsigned int base, unsigned int offset,
> > > +				      unsigned int *reg, unsigned int *mask)
> > > +{
> > > +	u16 ngpios = gpio_regmap_get_ngpio(gpio);
> > > +
> > > +	*reg = base;
> > > +	*mask = BIT(MAX7360_MAX_KEY_COLS - (ngpios - offset));
> > > +
> > > +	return 0;
> >
> > Does this GPIO controller only capable of servicing keypads?
> > I think no, hence I'm not sure why this split is needed to be
> > here and not in the input driver.
> 
> I would say it's more a keypad controller able to support some GPIOs.
> Some of the keypad columns, if unused, can be used as output-only gpios.
> So I believe the split has its place here, because in the default
> configuration, the split is set to have 8 keypad columns and no gpio. As
> a consequence, the keypad driver can work without having to worry about
> the split; the gpio driver needs to know about it.
> 
> To provide a bit more details, there is basically two set of pins usable
> as GPIOs.
> 
> On one side we have what I refer to as GPIOs:
>   - PORT0 to PORT7 pins of the chip.
>   - Shared with PWM and rotary encoder functionalities. Functionality
>     selection can be made independently for each pin. We have to ensure
>     the same pin is not used by two drivers at the same time. E.g. we
>     cannot have at the same time GPIO4 and PWM4.
>   - Supports input and interrupts.
>   - Outputs may be configured as constant current.
>   - 8 GPIOS supported, so ngpios is fixed to MAX7360_MAX_GPIO.
>   - maxim,max7360-gpio compatible, gpio_function == MAX7360_GPIO_PORT.
> 
> On the other side, we have what I refer to as GPOs:
>   - COL2 to COL7 pins of the chip.
>   - Shared with the keypad functionality. Selections is made by
>     partitioning the pins: first pins for keypad columns, last pins for
>     GPOs. Partition is described by the ngpios property.
>   - Only support outputs.
>   - maxim,max7360-gpo compatible, gpio_function == MAX7360_GPIO_COL.
> 
> > Or you mean that there output only GPIO lines in HW after all?
> > Is there a link to the datasheet?
> 
> A datasheet is available on https://www.analog.com/en/products/max7360.html

Thank you for this good elaboration!
I will check on the datasheet later on, having one week off.

But what I have read above sounds to me like the following:

1) the PORT0-PORT7 should be just a regular pin control with the respective
function being provided (see pinctrl-cy8c95x0.c as an example);

2) the COL2 COL7 case can be modeled as a simplest GPIO (GPO) driver with
reserved lines property (this will set valid mask and let GPIOLIB to refuse any
use of the keypad connected pins.

So, with this approach the entire handling becomes less hackish and quite
straightforward!


-- 
With Best Regards,
Andy Shevchenko



