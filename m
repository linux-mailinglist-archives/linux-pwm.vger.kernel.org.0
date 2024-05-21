Return-Path: <linux-pwm+bounces-2203-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A11EC8CAB83
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9333B209AD
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080996BB50;
	Tue, 21 May 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BLWYKzAd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CA4F88A;
	Tue, 21 May 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286176; cv=none; b=IHPxKQO0XopMuTxn2Cv8JIxy2dOCe7g3ITWqkZJfEou7DkSrUR0jy+y6X1zAzSWUJhdAKJ629jm7HBJr1+2ByZQiLSAkvSEFec4mBVUEW+HV9HAeQ06/K+znupYOPAGAqv9GI67Hgb4DMLR+OrLtY/SYf36VLIDNAkG5rvGu5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286176; c=relaxed/simple;
	bh=z1eCyzrs0kaldb2RBdt3QhyvlygYoxrEnoe6oO53hus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W894ffbitP8mCj+VZp8rcLfHc5z/1zTXbTRIEbx2Df2STvtfeOzPR16YMMQDCAXYkaHrw9UR6Pxb6y1okI7C8flh/xKAYpbfqgxC4Ck+PUnT6LAOZej5AzAdcxy8QNFbmK6/9fBok1PCZfqdGh3O6TZ6AKapAFc2/RKFfhsXUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BLWYKzAd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7003BCE3;
	Tue, 21 May 2024 12:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716286159;
	bh=z1eCyzrs0kaldb2RBdt3QhyvlygYoxrEnoe6oO53hus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLWYKzAdAP+LSHQaQF7h3RE7g4o0YJ72wpqvprflzLTLU3plcMYvvXgJap3k8BPg3
	 NDaJ+72b6hIA3+wLqoevoKYC0cnf+2dhReO5gXglD5YcttO4xOdb59173wlv7UkZ2s
	 IPtfWePKgEhACWOWG9CCQ2YRlgfuR4BjI9LzBj88=
Date: Tue, 21 May 2024 13:09:22 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 5/5] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240521100922.GF16345@pendragon.ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-6-laurent.pinchart@ideasonboard.com>
 <dl7a6puox5lc36fpto2fgyfgmpd3uboqc4lcfdtuaxzzsboqld@alw7vyi7pqjz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dl7a6puox5lc36fpto2fgyfgmpd3uboqc4lcfdtuaxzzsboqld@alw7vyi7pqjz>

Hi Uwe,

Thank you for the quick review.

On Tue, May 21, 2024 at 10:51:26AM +0200, Uwe Kleine-König wrote:
> On Mon, May 20, 2024 at 10:59:41PM +0300, Laurent Pinchart wrote:
> > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > new file mode 100644
> > index 000000000000..709713d8f47a
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-adp5585.c
> > @@ -0,0 +1,230 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices ADP5585 PWM driver
> > + *
> > + * Copyright 2022 NXP
> > + * Copyright 2024 Ideas on Board Oy
> > + */
> 
> Please document some hardware properties here in the same format as many
> other PWM drivers. The things I'd like to read there are:
> 
>  - Only supports normal polarity
>  - How does the output pin behave when the hardware is disabled
>    (typically "low" or "high-Z" or "freeze")
>  - Does changing parameters or disabling complete the currently running
>    period?
>  - Are there glitches in .apply()? E.g. when the new duty_cycle is
>    already written but the new period is not.
> 
> > +#include <linux/container_of.h>
> > +#include <linux/device.h>
> > +#include <linux/math.h>
> > +#include <linux/minmax.h>
> > +#include <linux/mfd/adp5585.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/time.h>
> 
> Do you need these all? I wounder about time.h.

Yes I've checked them all :-) time.h is for NSEC_PER_SEC (defined in
vdso/time64.h, which I thought would be better replaced by time.h).

> > +#define ADP5585_PWM_CHAN_NUM		1
> > +
> > +#define ADP5585_PWM_OSC_FREQ_HZ		1000000U
> > +#define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> > +#define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> > +
> > +struct adp5585_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct regmap *regmap;
> > +	struct mutex lock;
> 
> What does this mutex protect against? You can safely assume that there
> are no concurrent calls of the callbacks. (This isn't ensured yet, but I
> consider a consumer who does this buggy and it will soon be ensured.)

That's good to know. I couldn't find that information. I'll revisit the
locking in v2, and add a comment to document the mutex in case it's
still needed.

> > +	u8 pin_config_val;
> > +};
> > +
> > +static inline struct adp5585_pwm_chip *
> > +to_adp5585_pwm_chip(struct pwm_chip *chip)
> > +{
> > +	return container_of(chip, struct adp5585_pwm_chip, chip);
> > +}
> > +
> > +static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	guard(mutex)(&adp5585_pwm->lock);
> > +
> > +	ret = regmap_read(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	adp5585_pwm->pin_config_val = val;
> > +
> > +	ret = regmap_update_bits(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C,
> > +				 ADP5585_R3_EXTEND_CFG_MASK,
> > +				 ADP5585_R3_EXTEND_CFG_PWM_OUT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> > +				 ADP5585_OSC_EN, ADP5585_OSC_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> The last four lines are equivalent to
> 
> 	return ret;

I prefer the existing code but can also change it.

> What is the purpose of this function? Setup some kind of pinmuxing? The
> answer to that question goes into a code comment. If it's pinmuxing, is
> this a hint to use the pinctrl subsystem? (Maybe it's overkill, but if
> it's considered a good idea later, it might be hard to extend the dt
> bindings, so thinking about that now might be a good idea.)

The ADP5585_R3_EXTEND_CFG_PWM_OUT bit is about pinmuxing, yes. I'll add
a comment. I considered pinctrl too, but I think it's overkill.

> > +}
> > +
> > +static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +
> > +	guard(mutex)(&adp5585_pwm->lock);
> > +
> > +	regmap_update_bits(adp5585_pwm->regmap, ADP5585_PIN_CONFIG_C,
> > +			   ADP5585_R3_EXTEND_CFG_MASK,
> > +			   adp5585_pwm->pin_config_val);
> 
> I wonder if writing a deterministic value instead of whatever was in
> that register before .request() would be more robust and less
> surprising.

I'll change that. It looks like the last remains of the original code
are going away :-)

> > +	regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> > +			   ADP5585_OSC_EN, 0);
> > +}
> > +
> > +static int pwm_adp5585_apply(struct pwm_chip *chip,
> > +			     struct pwm_device *pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
> > +	u32 on, off;
> > +	int ret;
> > +
> > +	if (!state->enabled) {
> > +		guard(mutex)(&adp5585_pwm->lock);
> > +
> > +		return regmap_update_bits(adp5585_pwm->regmap, ADP5585_PWM_CFG,
> > +					  ADP5585_PWM_EN, 0);
> > +	}
> > +
> > +	if (state->period < ADP5585_PWM_MIN_PERIOD_NS ||
> > +	    state->period > ADP5585_PWM_MAX_PERIOD_NS)
> > +		return -EINVAL;
> 
> Make this:
> 
> 	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
> 		return -EINVAL;
> 
> 	period = min(ADP5585_PWM_MAX_PERIOD_NS, state->period)
> 	duty_cycle = min(period, state->period);

I haven't been able to find documentation about the expected behaviour.
What's the rationale for returning an error if the period is too low,
but silently clamping it if it's too high ?

> > +
> > +	/*
> > +	 * Compute the on and off time. As the internal oscillator frequency is
> > +	 * 1MHz, the calculation can be simplified without loss of precision.
> > +	 */
> > +	on = DIV_ROUND_CLOSEST_ULL(state->duty_cycle,
> > +				   NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> > +	off = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
> > +				    NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ);
> 
> round-closest is wrong. Testing with PWM_DEBUG should point that out.
> The right algorithm is:
> 
> 	on = duty_cycle / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> 	off = period / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on
> 
> 
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		swap(on, off);
> 
> Uhh, no. Either you can do inverted polarity or you cannot. Don't claim
> you can.

OK, but what's the rationale ? This is also an area where I couldn't
find documentation.

> > [...]
> > +static int adp5585_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
> > +	struct adp5585_pwm_chip *adp5585_pwm;
> > +	int ret;
> > +
> > +	adp5585_pwm = devm_kzalloc(&pdev->dev, sizeof(*adp5585_pwm), GFP_KERNEL);
> > +	if (!adp5585_pwm)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, adp5585_pwm);
> > +
> > +	adp5585_pwm->regmap = adp5585->regmap;
> > +
> > +	mutex_init(&adp5585_pwm->lock);
> > +
> > +	adp5585_pwm->chip.dev = &pdev->dev;
> > +	adp5585_pwm->chip.ops = &adp5585_pwm_ops;
> > +	adp5585_pwm->chip.npwm = ADP5585_PWM_CHAN_NUM;
> 
> That is wrong since commit
> 05947224ff46 ("pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()")

I'll update the code.

> > +	ret = devm_pwmchip_add(&pdev->dev, &adp5585_pwm->chip);
> > +	if (ret) {
> > +		mutex_destroy(&adp5585_pwm->lock);
> > +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void adp5585_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct adp5585_pwm_chip *adp5585_pwm = platform_get_drvdata(pdev);
> > +
> > +	mutex_destroy(&adp5585_pwm->lock);
> 
> Huh, this is a bad idea. The mutex is gone while the pwmchip is still
> registered. AFAIK calling mutex_destroy() is optional, and
> adp5585_pwm_remove() can just be dropped. Ditto in the error paths of
> .probe().

mutex_destroy() is a no-op when !CONFIG_DEBUG_MUTEXES. When the config
option is selected, it gets more useful. I would prefer moving away from
the devm_* registration, and unregister the pwm_chip in .remove()
manually, before destroying the mutex.

> > +}
> > +
> > +static const struct of_device_id adp5585_pwm_of_match[] = {
> > +	{ .compatible = "adi,adp5585-pwm" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, adp5585_pwm_of_match);
> 
> Is it normal/usual for mfd drivers to use of stuff? I thought they use
> plain platform style binding, not sure though.

I'll test it.

> > +static struct platform_driver adp5585_pwm_driver = {
> > +	.driver	= {
> > +		.name = "adp5585-pwm",
> > +		.of_match_table = adp5585_pwm_of_match,
> > +	},
> > +	.probe = adp5585_pwm_probe,
> > +	.remove_new = adp5585_pwm_remove,
> > +};
> > +module_platform_driver(adp5585_pwm_driver);
> > +
> > +MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
> > +MODULE_DESCRIPTION("ADP5585 PWM Driver");
> > +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart

