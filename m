Return-Path: <linux-pwm+bounces-1647-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5B869CA5
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 17:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EFCB34514
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CBC3C06B;
	Tue, 27 Feb 2024 16:41:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCA208AD;
	Tue, 27 Feb 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052077; cv=none; b=UWw+9UQ26ntNPlQIt/WYXejYFisfus+XMssXp/wYksauvC5RO9FovSxM8TntqJRGhPNTxJ/0hodtT3wSwL7hMPMHLGl/ktA1MlPzWf1kraZ2Ywc92dzheBimKMst6OpDlBQVgacJEGuF+Gs52H8LuS40MSp3fjZq99wfCee2w30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052077; c=relaxed/simple;
	bh=Auiob5o1YiESgmh2qGEQ64V8+hNAmx59W2PnXQ/O2q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNYiQT+E006w1O3+71BTq2IyNmTvJeopZrkPT6+xB5OFTb5oNahJL/ZFPTKLGmlhBp/9E0Nv53SayZwAcCGr8XgKNEPDD8v/BXoCX129qLiLqYhtDqsj8prqDlCK/EZBXS1hFNCELwPyBk/lOn/mhUYA+nsxIni/vPEbAsZv9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3245944"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3245944"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:41:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913916735"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="913916735"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:41:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rf0Vw-00000007zsC-1bg5;
	Tue, 27 Feb 2024 18:41:08 +0200
Date: Tue, 27 Feb 2024 18:41:08 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Message-ID: <Zd4QpBsyTnuM8hwt@smile.fi.intel.com>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204220851.4783-3-wahrenst@gmx.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 04, 2024 at 11:08:51PM +0100, Stefan Wahren wrote:
> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> Add a software PWM which toggles a GPIO from a high-resolution timer.
> 
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
> 
> Since high-resolution timers are used, sleeping gpio chips are not

GPIO

> supported and are rejected in the probe function.

Overall LGTM, but I have a few comments below.

...

+ container_of.h

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/hrtimer.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/spinlock.h>

+ time.h
+ types.h

...

> +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *gpio_timer)
> +{
> +	struct pwm_gpio *gpwm = container_of(gpio_timer, struct pwm_gpio,
> +					     gpio_timer);
> +	unsigned long next_toggle;
> +	unsigned long flags;
> +	bool new_level;

> +	spin_lock_irqsave(&gpwm->lock, flags);

Can we use cleanup.h from day 1?

> +	/* Apply new state at end of current period */
> +	if (!gpwm->level && gpwm->changing) {
> +		gpwm->changing = false;
> +		gpwm->state = gpwm->next_state;
> +		new_level = !!gpwm->state.duty_cycle;
> +	} else {
> +		new_level = !gpwm->level;
> +	}
> +
> +	next_toggle = pwm_gpio_toggle(gpwm, new_level);
> +	if (next_toggle) {
> +		hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_timer),
> +				ns_to_ktime(next_toggle));
> +	}
> +
> +	spin_unlock_irqrestore(&gpwm->lock, flags);
> +
> +	return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
> +}

...

> +		/*
> +		 * This just enables the output, but pwm_gpio_toggle()
> +		 * really starts the duty cycle.
> +		 */
> +		int ret = gpiod_direction_output(gpwm->gpio, invert);
> +
> +		if (ret)
> +			return ret;

Better to have it written as

		int ret;

		/*
		 * This just enables the output, but pwm_gpio_toggle()
		 * really starts the duty cycle.
		 */
		ret = gpiod_direction_output(gpwm->gpio, invert);
		if (ret)
			return ret;

...

> +	gpwm->gpio = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
> +	if (IS_ERR(gpwm->gpio)) {
> +		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
> +				     "could not get gpio\n");
> +	}

{} are not needed.

...

> +	if (gpiod_cansleep(gpwm->gpio)) {
> +		return dev_err_probe(dev, -EINVAL,
> +				     "sleeping GPIO %d not supported\n",

> +				     desc_to_gpio(gpwm->gpio));

Do not use plain GPIO numbers.

> +	}

{} are not needed.

-- 
With Best Regards,
Andy Shevchenko



