Return-Path: <linux-pwm+bounces-8524-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL9ELKde1mkhEwgAu9opvQ
	(envelope-from <linux-pwm+bounces-8524-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 15:56:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6693BD433
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E38B83028827
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2026 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63753BC691;
	Wed,  8 Apr 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="gaVcCYgY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EE2F3C3E;
	Wed,  8 Apr 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656420; cv=none; b=N63ezgLjDTg88e7e8vEM2cemfbgSbD3xyG+CfysGRlmepuzSEguQ1uDoZfoV7tYSyZ4H2WWs7R4PvLBJB1GDSIQwzzCZgbc/atTifxIhQlaI6OsBY1dMqyvUyYIPUTlWkg0SyZjXr/pw+13IIoP/Ds5XmE8rzk5bzTfTaS8yy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656420; c=relaxed/simple;
	bh=s872tDRo2JQyY0cBLCjimL+w/HTgFFhiUZgRAxQGINo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cQYdzW5WJJ0r9XQo0vtvjO88iJzJ3Vi3+pWfJtTU4JlCsuUpPgdg856LlKQGPAqZqCSl05d5BZ40yml8naWMtVID5vZSPx0anNCH5fJ9nr5b9s7b3jEWeNUBfXdMlgXpWS5e1lMOFlZ3B01zNPBSMeLz+sIY0nyFdOivh/nmA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=gaVcCYgY; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1775656416; bh=s872tDRo2JQyY0cBLCjimL+w/HTgFFhiUZgRAxQGINo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gaVcCYgYTW4n0IDuBGz7Mj9hKld8hAnfvyHnogVzvN3G+l9CmjpGXU2U5DhUTV3EW
	 eWtWBZw5O8rYVHrevpi6RZHMH3oFOl/5y/jkf0CMouqV+SjknuRTSCwGZIxe5MTlIC
	 lFOHzKDMyPRjpOYC9Jm5qvgo7MNSThYXtW+EltfSL4MU2cmBuFETqFWuniCn101GU3
	 okr0qsvTicwrQn61NL4pBq+IVP79mDhaQnEGtAOImqDf903bdlB4ow4K/FtbbJZI87
	 vAW2MD4B7+pWu1gwPVt6EfMJD1n1TT5VMNxRwWzd4B9gdJ/jMhwNeRxqZUr/DnwTU8
	 nu/+NR9iHUqSA==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id E8FF06E992;
	Wed,  8 Apr 2026 18:53:35 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Apr 2026 18:53:35 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Xilin Wu <sophon@radxa.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
In-Reply-To: <7BA26FC036D1C9AF+64204287-21b5-4664-ae75-be3dd54ec092@radxa.com>
References: <20260408-clk-pwm-gpio-v2-0-d22f1f3498a0@radxa.com>
 <20260408-clk-pwm-gpio-v2-2-d22f1f3498a0@radxa.com>
 <8030cac3703f9aa1b7a8b476ad92aeae@trvn.ru>
 <7BA26FC036D1C9AF+64204287-21b5-4664-ae75-be3dd54ec092@radxa.com>
Message-ID: <f7f1b27731c54e65f52d6fb8e347c878@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[trvn.ru,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[trvn.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trvn.ru:+];
	TAGGED_FROM(0.00)[bounces-8524-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita@trvn.ru,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trvn.ru:dkim,trvn.ru:mid,radxa.com:email]
X-Rspamd-Queue-Id: 0A6693BD433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Xilin Wu писал(а) 08.04.2026 18:19:
> On 4/8/2026 6:42 PM, Nikita Travkin wrote:
>> Xilin Wu писал(а) 08.04.2026 15:07:
>>> The clk-pwm driver cannot guarantee a defined output level when the
>>> PWM is disabled or when 0%/100% duty cycle is requested, because the
>>> pin state when the clock is stopped is hardware-dependent.
>>>
>>> Add optional GPIO and pinctrl support: when a GPIO descriptor and
>>> pinctrl states ("default" for clock mux, "gpio" for GPIO mode) are
>>> provided in the device tree, the driver switches the pin to GPIO mode
>>> and drives the appropriate level for disabled/0%/100% states. For
>>> normal PWM output, the pin is switched back to its clock function mux.
>>>
>>> If no GPIO is provided, the driver falls back to the original
>>> clock-only behavior.
>>>
>>> Signed-off-by: Xilin Wu <sophon@radxa.com>
>>> ---
>>>   drivers/pwm/pwm-clk.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 80 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
>>> index f8f5af57acba..d7d8d2c2dd0f 100644
>>> --- a/drivers/pwm/pwm-clk.c
>>> +++ b/drivers/pwm/pwm-clk.c
>>> @@ -11,11 +11,20 @@
>>>    * - Due to the fact that exact behavior depends on the underlying
>>>    *   clock driver, various limitations are possible.
>>>    * - Underlying clock may not be able to give 0% or 100% duty cycle
>>> - *   (constant off or on), exact behavior will depend on the clock.
>>> + *   (constant off or on), exact behavior will depend on the clock,
>>> + *   unless a gpio pinctrl state is supplied.
>>>    * - When the PWM is disabled, the clock will be disabled as well,
>>> - *   line state will depend on the clock.
>>> + *   line state will depend on the clock, unless a gpio pinctrl
>>> + *   state is supplied.
>>>    * - The clk API doesn't expose the necessary calls to implement
>>>    *   .get_state().
>>> + *
>>> + * Optionally, a GPIO descriptor and pinctrl states ("default" and
>>> + * "gpio") can be provided. When a constant output level is needed
>>> + * (0% duty, 100% duty, or disabled), the driver switches the pin to
>>> + * GPIO mode and drives the appropriate level. For normal PWM output
>>> + * the pin is switched back to its clock function mux. If no GPIO is
>>> + * provided, the driver falls back to the original clock-only behavior.
>>>    */
>>>     #include <linux/kernel.h>
>>> @@ -25,11 +34,17 @@
>>>   #include <linux/of.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/clk.h>
>>> +#include <linux/gpio/consumer.h>
>>> +#include <linux/pinctrl/consumer.h>
>>>   #include <linux/pwm.h>
>>>     struct pwm_clk_chip {
>>>   	struct clk *clk;
>>>   	bool clk_enabled;
>>> +	struct pinctrl *pinctrl;
>>> +	struct pinctrl_state *pins_default;  /* clock function mux */
>>> +	struct pinctrl_state *pins_gpio;     /* GPIO mode */
>>> +	struct gpio_desc *gpiod;
>>>   };
>>>     static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
>>> @@ -45,14 +60,36 @@ static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>   	u32 rate;
>>>   	u64 period = state->period;
>>>   	u64 duty_cycle = state->duty_cycle;
>>> +	bool constant_level = false;
>>> +	int gpio_value = 0;
>>>     	if (!state->enabled) {
>>> -		if (pwm->state.enabled) {
>>> +		constant_level = true;
>>> +		gpio_value = 0;
>>> +	} else if (state->duty_cycle == 0) {
>>> +		constant_level = true;
>>> +		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 1 : 0;
>>> +	} else if (state->duty_cycle >= state->period) {
>>> +		constant_level = true;
>>> +		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 0 : 1;
>>> +	}
>>> +
>> 
>> So I'm looking at it again, and I'm a bit confused.
>> 
>> Old behavior was:
>>   - pwm was enabled and being disabled -> stop the clock and hope state is 0;
>>   - pwm is still enabled but
>>                              - duty=0%   -> set clk duty to 0%
>>                              - duty=100% -> set clk duty to 100%
>> 
>> New behavior if we have gpio:
>>   - pwm was enabled and being disabled -> constant 0
>>   - pwm is still enabled but
>>                              - duty=0%   -> constant 0
>>                              - duty=100% -> constant 1
>> 
>> New behavior if we don't have gpio:
>> Same as above but
>>    - if we need constant 0 -> clock is halted and we pray it's 0
>>    - if we need constant 1 -> clock is halted and we pray it's 1 (??)
>> 
>> Per my recollection, when I wrote this driver 5 years ago, I've manually
>> verified that at least on qcom setting duty cycle to 0% and 100% worked
>> properly, so this feels like it would regress it if left as-is...
>> 
>> (Btw I wonder what's the platform you need this for?)
>> 
> 
> I took a careful look at clk_rcg2_set_duty_cycle() in drivers/clk/qcom/clk-rcg2.c, and I believe the Qualcomm RCG2 MND counter cannot produce a true 0% or 100% duty cycle. For a 0% duty request, the actual duty cycle can become very small, but never exactly zero. Likewise, for a 100% duty request, it can get very close to 100%, but not exactly 100%.
> 

Are you aware of the hardware quick of the clock [1] where you can't get
full range if your dividers aren't configured properly? I don't know if
new hardware is different in that regard comapred to the old sd410 I was
working with, but I recall spending a while with oscilloscope until I've
figured out why I wasn't getting full range from 0 to 100%.

I'm pretty convinced I saw full coverage (i.e. flat 0 when clock is at
0% and flat 1 when clock is at 100%) but perhaps I was measuring it wrong
or I misremember as it was long ago... I still think your solution here
is clever though, as long as you don't accidentally mask bugged gcc config.

[1] https://elixir.bootlin.com/linux/v6.19/source/drivers/clk/qcom/gcc-msm8916.c#L958-L973

> I agree that the current change may cause a regression. Do you think it would make more sense to keep the old behavior when no GPIO is available, and still set the clock duty cycle to 0% or 100% in that case?
> 

Yes please, keep the old behavior when there is no gpio. There are
certainly a few existing users for this and it would be sad to have
someone's backlight go out when they set it to 100% xD

> We need this for many of our future Qualcomm-based products, because the PMIC that comes with the SoC usually provides only one PWM output.
> 
>>> +	if (constant_level) {
>>> +		if (pcchip->gpiod) {
>>> +			gpiod_direction_output(pcchip->gpiod, gpio_value);
>>> +			pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
>>> +		}
>>> +		if (pcchip->clk_enabled) {
>>>   			clk_disable(pcchip->clk);
>>>   			pcchip->clk_enabled = false;
>>>   		}
>>>   		return 0;
>>> -	} else if (!pwm->state.enabled) {
>>> +	}
>>> +
>>> +	if (pcchip->gpiod)
>>> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
>>> +
>>> +	if (!pcchip->clk_enabled) {
>>>   		ret = clk_enable(pcchip->clk);
>>>   		if (ret)
>>>   			return ret;
>>> @@ -97,6 +134,45 @@ static int pwm_clk_probe(struct platform_device *pdev)
>>>   		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
>>>   				     "Failed to get clock\n");
>>>   +	pcchip->pinctrl = devm_pinctrl_get(&pdev->dev);
>>> +	if (IS_ERR(pcchip->pinctrl)) {
>>> +		ret = PTR_ERR(pcchip->pinctrl);
>>> +		pcchip->pinctrl = NULL;
>>> +		if (ret == -EPROBE_DEFER)
>>> +			return ret;
>>> +	} else {
>>> +		pcchip->pins_default = pinctrl_lookup_state(pcchip->pinctrl,
>>> +							    PINCTRL_STATE_DEFAULT);
>>> +		pcchip->pins_gpio = pinctrl_lookup_state(pcchip->pinctrl,
>>> +							 "gpio");
>>> +		if (IS_ERR(pcchip->pins_default) || IS_ERR(pcchip->pins_gpio))
>>> +			pcchip->pinctrl = NULL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Switch to GPIO pinctrl state before requesting the GPIO.
>>> +	 * The driver core has already applied the "default" state, which
>>> +	 * muxes the pin to the clock function and claims it.  We must
>>> +	 * release that claim first so that gpiolib can request the pin.
>>> +	 */
>>> +	if (pcchip->pinctrl)
>>> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
>>> +
>>> +	pcchip->gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_ASIS);
>>> +	if (IS_ERR(pcchip->gpiod))
>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->gpiod),
>>> +				     "Failed to get gpio\n");
>>> +
>>> +	/*
>>> +	 * If pinctrl states were found but no GPIO was provided, the pin is
>>> +	 * stuck in GPIO mode from the switch above.  Restore the default
>>> +	 * (clock-function) mux and fall back to clock-only operation.
>>> +	 */
>> 
>> Feels slightly weird to silently allow "broken" DT, it would make no sense
>> for it to have "gpio" pinctrl and not have a gpio defined, would it?
>> 
>> Perhaps it makes more sense to put getting a gpio under having pins_gpio
>> and make it strict, so two allowed states for the driver would be either
>> no pinctrl-1 and no gpio, or having both at the same time?
>> 
>> (maybe then also worth adding cross dependency of pinctrl-1 and gpio in
>> the binding, it's one way only currently, not sure what's the correct
>> way to describe it tho)
>> 
>> Nikita
>> 
> 
> Yeah, good point. Having a gpio pinctrl state without an actual gpio property is indeed a broken DT and there's no reason to silently work around it. Do you think the following change would work?
> 
> 	if (pcchip->pinctrl) {
> 		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
> 
> 		pcchip->gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_ASIS);
> 		if (IS_ERR(pcchip->gpiod))
> 			return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->gpiod),
> 					     "GPIO required when 'gpio' pinctrl state is present\n");
> 	}
> 

This makes sense to me, yes.

Nikita

>>> +	if (pcchip->pinctrl && !pcchip->gpiod) {
>>> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
>>> +		pcchip->pinctrl = NULL;
>>> +	}
>>> +
>>>   	chip->ops = &pwm_clk_ops;
>>>     	ret = pwmchip_add(chip);
>>

