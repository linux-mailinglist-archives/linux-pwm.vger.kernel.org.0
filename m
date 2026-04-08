Return-Path: <linux-pwm+bounces-8522-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K8+LbNX1mlJEAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8522-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 15:27:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C63BCD70
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 15:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A638B30C7ADF
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2026 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163543264FA;
	Wed,  8 Apr 2026 13:20:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEB313E36;
	Wed,  8 Apr 2026 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654409; cv=none; b=X9PBi7f3ry6YDbKTn72mx78JbfqpmNPb4GStmWNvgICxbzKFW++L/mbGN+1e0H8qGQHPyHPCcp3iuaoRqGN4qt16j7dmzm1GTJCO0p0rvoFqb9t7OlUNwZAZpnfE3p1BQt9yvanHqvrdYbSx6OpyresBp6jycONYzoDyKOgp7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654409; c=relaxed/simple;
	bh=Qwpbhww7CrXXunhU8ku2p7hNzmTqVyIvdYsDejjvfsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfWSDabGaaAnljuFUu1QHjr/oT+UnKCXBngDw1klXEFf9YqhTsh2fxYloLyCtvihW8JcEHAhGnBD3OcdUmfnc7DvaRP5EaS7GRd35R0PTupU0HkwFv/ohygyB9Az0CHtNAz84bLFWYrKm0oeleQsMoh13bxkXfC+JpxXE3KYe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpsz18t1775654363t3cb4073c
X-QQ-Originating-IP: gZbJhug9qvNVdH4zYW+DyL7LZUKCNEJAVtc2edbWdQA=
Received: from [127.0.0.1] ( [116.234.85.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Apr 2026 21:19:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9970830700309624208
Message-ID: <7BA26FC036D1C9AF+64204287-21b5-4664-ae75-be3dd54ec092@radxa.com>
Date: Wed, 8 Apr 2026 21:19:19 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
To: Nikita Travkin <nikita@trvn.ru>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260408-clk-pwm-gpio-v2-0-d22f1f3498a0@radxa.com>
 <20260408-clk-pwm-gpio-v2-2-d22f1f3498a0@radxa.com>
 <8030cac3703f9aa1b7a8b476ad92aeae@trvn.ru>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <8030cac3703f9aa1b7a8b476ad92aeae@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvjhxCSDgXICj91atmTlnbUBY1+dVlCNR7IDUDdEfp3KvGNGjxPVNsDo
	urwzpIJKfXKahcDXxbOx/8S3xnUUsppvftsmv/qBRmvlvO8tNMZpR1qRcBV3zlDXvLnEPlx
	NPvAcb88zwvZgw+2BPMR01uIhdgmJ4HtK7eYmPKDezPl+UVVD2AOzN55SkgTQcShRxAt6zr
	iqzz0NqAAbEclWMhZm/FpYtHEFwA/X8Wlh/IIPNKhDXcgCCz290LyineUzbYQeKaekFoW7k
	G/c1LKxHHyWxigGfMRmB10XzS2irKPrjV9I+uxl4mGrPQ7IZ1GbsERGgR0EcUSXUuEc5xYT
	FbHG4aFmQ2AsaZ/uO95DXqnt9WXbNJl1y5+AkvvMamHWJhho0QQ9ZoB+Zun3qdasOUF/Yq0
	/85ghtMIPFJCZmfvY7KKtjyWDb9Vk8qoEDITwdRINBZ8yphiu2nmqqTbjLKIuvIr3MP9tyk
	8srS4B9pVrwAY9r8+DFKC5bzJ5sgDmq6geK5U2QVyiuTKQZRPLlp1SziQGNRcCZ7ZTFP5Z8
	DivwzSYeBtHKKJFVrtdDz7X9HHBpZfrQSXvKnTUO8PUDc+fCaI9QfC/kJCVyIK8felIzWU4
	55VyfbBp+3dZgd2ge0cXW5ltjmmoPoyIqIM1RGIwDBtiASEwcBtH3YIEeO0toqXZFqOdLZl
	0MzxvhyGXCkT9tvBjLCzT/QIsZaGwtMLV7ZROlboMwOW0SxZo7zvRxR38WnGnG0KljCbe+H
	OTCxVrlRN/mA7qBBqsxAwGBCXXvlBVjVDqYhTjDlOHMfoxQGJ45a+bGejdSe2tKuRAQY89X
	g7nDJinK67u6H7ao8PQEtXXBSl3vMR1AW+Wvmwa5vbRuDiyTLVrbFtOCWQ4K6CA77igfLiQ
	RndIcy/1+AP+oq46o/e9+os6lfoWQXpyy2j+gGuOJTxXFYZho1jiWyK4YUw59k94Nr9lw0N
	f2RLOzbqTmNmAqkWOxiK4s+9/KUHZmLB5/hlctNJcIMjavocMBPATLqmpvk71ZcpNN2Yfg1
	raq8Fs0Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8522-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,radxa.com:email,radxa.com:mid]
X-Rspamd-Queue-Id: 385C63BCD70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/2026 6:42 PM, Nikita Travkin wrote:
> Xilin Wu писал(а) 08.04.2026 15:07:
>> The clk-pwm driver cannot guarantee a defined output level when the
>> PWM is disabled or when 0%/100% duty cycle is requested, because the
>> pin state when the clock is stopped is hardware-dependent.
>>
>> Add optional GPIO and pinctrl support: when a GPIO descriptor and
>> pinctrl states ("default" for clock mux, "gpio" for GPIO mode) are
>> provided in the device tree, the driver switches the pin to GPIO mode
>> and drives the appropriate level for disabled/0%/100% states. For
>> normal PWM output, the pin is switched back to its clock function mux.
>>
>> If no GPIO is provided, the driver falls back to the original
>> clock-only behavior.
>>
>> Signed-off-by: Xilin Wu <sophon@radxa.com>
>> ---
>>   drivers/pwm/pwm-clk.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 80 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
>> index f8f5af57acba..d7d8d2c2dd0f 100644
>> --- a/drivers/pwm/pwm-clk.c
>> +++ b/drivers/pwm/pwm-clk.c
>> @@ -11,11 +11,20 @@
>>    * - Due to the fact that exact behavior depends on the underlying
>>    *   clock driver, various limitations are possible.
>>    * - Underlying clock may not be able to give 0% or 100% duty cycle
>> - *   (constant off or on), exact behavior will depend on the clock.
>> + *   (constant off or on), exact behavior will depend on the clock,
>> + *   unless a gpio pinctrl state is supplied.
>>    * - When the PWM is disabled, the clock will be disabled as well,
>> - *   line state will depend on the clock.
>> + *   line state will depend on the clock, unless a gpio pinctrl
>> + *   state is supplied.
>>    * - The clk API doesn't expose the necessary calls to implement
>>    *   .get_state().
>> + *
>> + * Optionally, a GPIO descriptor and pinctrl states ("default" and
>> + * "gpio") can be provided. When a constant output level is needed
>> + * (0% duty, 100% duty, or disabled), the driver switches the pin to
>> + * GPIO mode and drives the appropriate level. For normal PWM output
>> + * the pin is switched back to its clock function mux. If no GPIO is
>> + * provided, the driver falls back to the original clock-only behavior.
>>    */
>>   
>>   #include <linux/kernel.h>
>> @@ -25,11 +34,17 @@
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/clk.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/pinctrl/consumer.h>
>>   #include <linux/pwm.h>
>>   
>>   struct pwm_clk_chip {
>>   	struct clk *clk;
>>   	bool clk_enabled;
>> +	struct pinctrl *pinctrl;
>> +	struct pinctrl_state *pins_default;  /* clock function mux */
>> +	struct pinctrl_state *pins_gpio;     /* GPIO mode */
>> +	struct gpio_desc *gpiod;
>>   };
>>   
>>   static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
>> @@ -45,14 +60,36 @@ static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	u32 rate;
>>   	u64 period = state->period;
>>   	u64 duty_cycle = state->duty_cycle;
>> +	bool constant_level = false;
>> +	int gpio_value = 0;
>>   
>>   	if (!state->enabled) {
>> -		if (pwm->state.enabled) {
>> +		constant_level = true;
>> +		gpio_value = 0;
>> +	} else if (state->duty_cycle == 0) {
>> +		constant_level = true;
>> +		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 1 : 0;
>> +	} else if (state->duty_cycle >= state->period) {
>> +		constant_level = true;
>> +		gpio_value = (state->polarity == PWM_POLARITY_INVERSED) ? 0 : 1;
>> +	}
>> +
> 
> So I'm looking at it again, and I'm a bit confused.
> 
> Old behavior was:
>   - pwm was enabled and being disabled -> stop the clock and hope state is 0;
>   - pwm is still enabled but
>                              - duty=0%   -> set clk duty to 0%
>                              - duty=100% -> set clk duty to 100%
> 
> New behavior if we have gpio:
>   - pwm was enabled and being disabled -> constant 0
>   - pwm is still enabled but
>                              - duty=0%   -> constant 0
>                              - duty=100% -> constant 1
> 
> New behavior if we don't have gpio:
> Same as above but
>    - if we need constant 0 -> clock is halted and we pray it's 0
>    - if we need constant 1 -> clock is halted and we pray it's 1 (??)
> 
> Per my recollection, when I wrote this driver 5 years ago, I've manually
> verified that at least on qcom setting duty cycle to 0% and 100% worked
> properly, so this feels like it would regress it if left as-is...
> 
> (Btw I wonder what's the platform you need this for?)
> 

I took a careful look at clk_rcg2_set_duty_cycle() in 
drivers/clk/qcom/clk-rcg2.c, and I believe the Qualcomm RCG2 MND counter 
cannot produce a true 0% or 100% duty cycle. For a 0% duty request, the 
actual duty cycle can become very small, but never exactly zero. 
Likewise, for a 100% duty request, it can get very close to 100%, but 
not exactly 100%.

I agree that the current change may cause a regression. Do you think it 
would make more sense to keep the old behavior when no GPIO is 
available, and still set the clock duty cycle to 0% or 100% in that case?

We need this for many of our future Qualcomm-based products, because the 
PMIC that comes with the SoC usually provides only one PWM output.

>> +	if (constant_level) {
>> +		if (pcchip->gpiod) {
>> +			gpiod_direction_output(pcchip->gpiod, gpio_value);
>> +			pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
>> +		}
>> +		if (pcchip->clk_enabled) {
>>   			clk_disable(pcchip->clk);
>>   			pcchip->clk_enabled = false;
>>   		}
>>   		return 0;
>> -	} else if (!pwm->state.enabled) {
>> +	}
>> +
>> +	if (pcchip->gpiod)
>> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
>> +
>> +	if (!pcchip->clk_enabled) {
>>   		ret = clk_enable(pcchip->clk);
>>   		if (ret)
>>   			return ret;
>> @@ -97,6 +134,45 @@ static int pwm_clk_probe(struct platform_device *pdev)
>>   		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
>>   				     "Failed to get clock\n");
>>   
>> +	pcchip->pinctrl = devm_pinctrl_get(&pdev->dev);
>> +	if (IS_ERR(pcchip->pinctrl)) {
>> +		ret = PTR_ERR(pcchip->pinctrl);
>> +		pcchip->pinctrl = NULL;
>> +		if (ret == -EPROBE_DEFER)
>> +			return ret;
>> +	} else {
>> +		pcchip->pins_default = pinctrl_lookup_state(pcchip->pinctrl,
>> +							    PINCTRL_STATE_DEFAULT);
>> +		pcchip->pins_gpio = pinctrl_lookup_state(pcchip->pinctrl,
>> +							 "gpio");
>> +		if (IS_ERR(pcchip->pins_default) || IS_ERR(pcchip->pins_gpio))
>> +			pcchip->pinctrl = NULL;
>> +	}
>> +
>> +	/*
>> +	 * Switch to GPIO pinctrl state before requesting the GPIO.
>> +	 * The driver core has already applied the "default" state, which
>> +	 * muxes the pin to the clock function and claims it.  We must
>> +	 * release that claim first so that gpiolib can request the pin.
>> +	 */
>> +	if (pcchip->pinctrl)
>> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
>> +
>> +	pcchip->gpiod = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_ASIS);
>> +	if (IS_ERR(pcchip->gpiod))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->gpiod),
>> +				     "Failed to get gpio\n");
>> +
>> +	/*
>> +	 * If pinctrl states were found but no GPIO was provided, the pin is
>> +	 * stuck in GPIO mode from the switch above.  Restore the default
>> +	 * (clock-function) mux and fall back to clock-only operation.
>> +	 */
> 
> Feels slightly weird to silently allow "broken" DT, it would make no sense
> for it to have "gpio" pinctrl and not have a gpio defined, would it?
> 
> Perhaps it makes more sense to put getting a gpio under having pins_gpio
> and make it strict, so two allowed states for the driver would be either
> no pinctrl-1 and no gpio, or having both at the same time?
> 
> (maybe then also worth adding cross dependency of pinctrl-1 and gpio in
> the binding, it's one way only currently, not sure what's the correct
> way to describe it tho)
> 
> Nikita
> 

Yeah, good point. Having a gpio pinctrl state without an actual gpio 
property is indeed a broken DT and there's no reason to silently work 
around it. Do you think the following change would work?

	if (pcchip->pinctrl) {
		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);

		pcchip->gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_ASIS);
		if (IS_ERR(pcchip->gpiod))
			return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->gpiod),
					     "GPIO required when 'gpio' pinctrl state is present\n");
	}

>> +	if (pcchip->pinctrl && !pcchip->gpiod) {
>> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
>> +		pcchip->pinctrl = NULL;
>> +	}
>> +
>>   	chip->ops = &pwm_clk_ops;
>>   
>>   	ret = pwmchip_add(chip);
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>


