Return-Path: <linux-pwm+bounces-2219-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287588CBF16
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 12:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E211F21083
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3C81AC3;
	Wed, 22 May 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LMGMBDev"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11E81AA7;
	Wed, 22 May 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372827; cv=none; b=gpkUWP4WLxxkc/i0t7QI//LBKu9/3k0MMhsS07l8GLK05u4EowhHWxy7I5DO6h3nuCy+1GYoPyCmf2kEmJOVkOdFPRqnLIv3y8zdA04U1C4ivUA6qDhymdjwXZcZE+3T87ctvoZfIgMkmHBn8WL0H+PDpkQWQuFn+iSU+d4ED+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372827; c=relaxed/simple;
	bh=1mP4oCCZIocHPEfXo/hwjMohvwOhWaSus8BGK7ZMHLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3SFXNbHHKCwyBWGyyUJDkLy0w7tkYPsTyu63rPb+clQzFzCciegRP2aU+V1v3sKG1sxE3PPihKOluZubBmlbRpIRJXLpUY9w7IwnAz+ttPW1S0Up1O2pc7CrEhtxF0bk8pHA4FMSBNVskpashn8mxwk98bIidY8Rtb0E5FuPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LMGMBDev; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 70FBAFD6;
	Wed, 22 May 2024 12:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716372811;
	bh=1mP4oCCZIocHPEfXo/hwjMohvwOhWaSus8BGK7ZMHLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMGMBDev4PAjWhtqVUMjdqFbaSJpAqgilatWhqlbIIY/WUBls4LzhOAnmggVXpziL
	 8UROPQlZp2DW/GLFYwUAexLeOH/DpKJIpDOFG9wljMtXYZ6ZCAsKZF9e6ybbodcRE2
	 L5OS7yQRtXmrygLrnKrPZYGUxubH0r6jBtyTlaUc=
Date: Wed, 22 May 2024 13:13:35 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 5/5] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240522101335.GE1935@pendragon.ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-6-laurent.pinchart@ideasonboard.com>
 <dl7a6puox5lc36fpto2fgyfgmpd3uboqc4lcfdtuaxzzsboqld@alw7vyi7pqjz>
 <20240521100922.GF16345@pendragon.ideasonboard.com>
 <xobmekjwqanow765yr42tsgknc5gc7szjublq6ywgbmoxovlr5@v3sofz5bmkol>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xobmekjwqanow765yr42tsgknc5gc7szjublq6ywgbmoxovlr5@v3sofz5bmkol>

On Tue, May 21, 2024 at 03:05:53PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> [dropping Alexandru Ardelean from Cc as their address bounces]
> 
> On Tue, May 21, 2024 at 01:09:22PM +0300, Laurent Pinchart wrote:
> > On Tue, May 21, 2024 at 10:51:26AM +0200, Uwe Kleine-König wrote:
> > > On Mon, May 20, 2024 at 10:59:41PM +0300, Laurent Pinchart wrote:
> > > > +	ret = regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> > > > +				 ADP5585_OSC_EN, ADP5585_OSC_EN);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return 0;
> > > 
> > > The last four lines are equivalent to
> > > 
> > > 	return ret;
> > 
> > I prefer the existing code but can also change it.
> 
> Well, I see the upside of your approach. If this was my only concern I
> wouldn't refuse to apply the patch.

While I have my preferences, I also favour consistency, so I'm happy to
comply with the preferred coding style for the subsystem :-) I'll
update this in the next version.

> > > > +	regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> > > > +			   ADP5585_OSC_EN, 0);
> > > > +}
> > > > +
> > > > +static int pwm_adp5585_apply(struct pwm_chip *chip,
> > > > +			     struct pwm_device *pwm,
> > > > +			     const struct pwm_state *state)
> > > > +{
> > > > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > > > +	u32 on, off;
> > > > +	int ret;
> > > > +
> > > > +	if (!state->enabled) {
> > > > +		guard(mutex)(&adp5585_pwm->lock);
> > > > +
> > > > +		return regmap_update_bits(adp5585_pwm->regmap, ADP5585_PWM_CFG,
> > > > +					  ADP5585_PWM_EN, 0);
> > > > +	}
> > > > +
> > > > +	if (state->period < ADP5585_PWM_MIN_PERIOD_NS ||
> > > > +	    state->period > ADP5585_PWM_MAX_PERIOD_NS)
> > > > +		return -EINVAL;
> > > 
> > > Make this:
> > > 
> > > 	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
> > > 		return -EINVAL;
> > > 
> > > 	period = min(ADP5585_PWM_MAX_PERIOD_NS, state->period)
> > > 	duty_cycle = min(period, state->period);
> > 
> > I haven't been able to find documentation about the expected behaviour.
> > What's the rationale for returning an error if the period is too low,
> > but silently clamping it if it's too high ?
> 
> Well, it's only implicitly documented in the implementation of
> PWM_DEBUG. The reasoning is a combination of the following thoughts:
> 
>  - Requiring exact matches is hard to work with, so some deviation
>    between request and configured value should be allowed.
>  - Rounding in both directions has strange and surprising effects. The
>    corner cases (for all affected parties (=consumer, lowlevel driver
>    and pwm core)) are easier if you only round in one direction.
>    One ugly corner case in your suggested patch is:
>    ADP5585_PWM_MAX_PERIOD_NS corresponds to 0xffff clock ticks.
>    If the consumer requests period=64000.2 clock ticks, you configure
>    for 64000. If the consumer requests period=65535.2 clock ticks you
>    return -EINVAL.
>    Another strange corner case is: Consider a hardware that can
>    implement the following periods 499.7 ns, 500.2 ns, 500.3 ns and then
>    only values >502 ns.
>    If you configure for 501 ns, you'd get 500.3 ns. get_state() would
>    tell you it's running at 500 ns. If you then configure 500 ns you
>    won't get 500.3 ns any more.
>  - If you want to allow 66535.2 clock ticks (and return 65535), what
>    should be the maximal value that should yield 65535? Each cut-off
>    value is arbitrary, so using \infty looks reasonable (to me at
>    least).
>  - Rounding down is easier than rounding up, because that's what C's /
>    does. (Well, this is admittedly a bit arbitrary, because if you round
>    down in .apply() you have to round up in .get_state().)

Thank you for the detailed explanation.

> > > round-closest is wrong. Testing with PWM_DEBUG should point that out.
> > > The right algorithm is:
> > > 
> > > 	on = duty_cycle / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> > > 	off = period / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on
> > > 
> > > 
> > > > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > > > +		swap(on, off);
> > > 
> > > Uhh, no. Either you can do inverted polarity or you cannot. Don't claim
> > > you can.
> > 
> > OK, but what's the rationale ? This is also an area where I couldn't
> > find documentation.
> 
> I don't have a good rationale here. IMHO this inverted polarity stuff is
> only a convenience for consumers because the start of the period isn't
> visible from the output wave form (apart from (maybe) the moment where
> you change the configuration) and so
> 
> 	.period = 5000, duty_cycle = 1000, polarity = PWM_POLARITY_NORMAL
> 
> isn't distinguishable from
> 
> 	.period = 5000, duty_cycle = 4000, polarity = PWM_POLARITY_INVERSED
> 
> . But it's a historic assumption of the pwm core that there is a
> relevant difference between the two polarities and I want at least a
> consistent behaviour among the lowlevel drivers. BTW, this convenience
> is the reason I'm not yet clear how I want to implemement a duty_offset.

Consistency is certainly good. Inverting the duty cycle to implement
inverted polarity would belong in the PWM core if we wanted to implement
it in software I suppose. I'll drop it from the driver.

> > > > +	ret = devm_pwmchip_add(&pdev->dev, &adp5585_pwm->chip);
> > > > +	if (ret) {
> > > > +		mutex_destroy(&adp5585_pwm->lock);
> > > > +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void adp5585_pwm_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct adp5585_pwm_chip *adp5585_pwm = platform_get_drvdata(pdev);
> > > > +
> > > > +	mutex_destroy(&adp5585_pwm->lock);
> > > 
> > > Huh, this is a bad idea. The mutex is gone while the pwmchip is still
> > > registered. AFAIK calling mutex_destroy() is optional, and
> > > adp5585_pwm_remove() can just be dropped. Ditto in the error paths of
> > > .probe().
> > 
> > mutex_destroy() is a no-op when !CONFIG_DEBUG_MUTEXES. When the config
> > option is selected, it gets more useful. I would prefer moving away from
> > the devm_* registration, and unregister the pwm_chip in .remove()
> > manually, before destroying the mutex.
> 
> In that case I'd prefer a devm_mutex_init()?!

Maybe that would be useful :-) Let's see if I can drop the mutex though.

-- 
Regards,

Laurent Pinchart

