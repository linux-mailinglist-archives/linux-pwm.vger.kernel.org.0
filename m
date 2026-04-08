Return-Path: <linux-pwm+bounces-8517-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAIHNuUn1mnqBQgAu9opvQ
	(envelope-from <linux-pwm+bounces-8517-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:03:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16B3BA3AA
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC08305DBA3
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2026 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB03A7833;
	Wed,  8 Apr 2026 10:00:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386083B4EB3;
	Wed,  8 Apr 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642421; cv=none; b=GcxdyoN2iCwd0QMKfE8K19NavSfGFioUR2Ege+epOojrwXtaSXPySa7CB1rtDJPU7INdORVyoQi1QhDkSEZ79p7T3nxsU9auOptqaiTkV9WMy1cmjjt3pyqFS+SBAFrtnQ8K1BOHQJXVJABCt5izkwl51DxfqsT6/9q1LZ91ceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642421; c=relaxed/simple;
	bh=O6tqT047uEkRHcchqkphwHvSuKUEESadOwfwmvi4nMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZQIJTmBkWJn8wWJpViQs5MMdRz2VdJ2ft7MPp3TqL+61yRXkyEtaqNdUdU9h9w6444v4/jApCZOSDjOun95gIe2/Rctqkd/IrsvdzWEisfV8yFvBde3i13arLhlM4/TSECfMSlxj3EtR+i2/eljWX08qc7G8cQlbTB57e48Da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpgz13t1775642376t133723b2
X-QQ-Originating-IP: 3jwz2Kc1fQGLu6BWGJy+k/xYJ1bJ7wlj0yf+boI+YQ8=
Received: from [127.0.0.1] ( [116.234.85.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Apr 2026 17:59:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12738319765885836624
Message-ID: <958FE5A28853C158+ca4ca7b5-e250-47f7-85d0-15a9d4b775d0@radxa.com>
Date: Wed, 8 Apr 2026 17:59:33 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
To: Nikita Travkin <nikita@trvn.ru>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
 <20260406-clk-pwm-gpio-v1-2-40d2f3a20aff@radxa.com>
 <41d54477e46354664360931ffcbeda11@trvn.ru>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
In-Reply-To: <41d54477e46354664360931ffcbeda11@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvCrvhZnsxVrDWPn915rmUqWUd2T3naQ5gEcP+wtiyRunlRWxDEmilm2
	ls+dvGBFvtDER8O1HDwXMwIQrfceJUXwIoYbnU/iCXdK5fkJbAuBbLfrbx+/dN1FQpAif6Q
	s/kv6vz7kPb6CQUiT7II5Rbo7Cx27COobySi0MYdZyIZd4yxV5LQrgsYdXOLObz/x7akrXB
	sKWCQpgrkpJN5cPXich2O6psRssVi1Qdh+MzEE0Kph5hR6M7ZFnnDvdcnxdsMOjAL+zf0Yi
	ZeKNTM/Gru4Gq7H+z+YrmsvZuRwfTJqae9NFqEd9hx2E0/c+8rzTfQoPHMj85gDL8aQZiQD
	jF1My3m6n/ttw7kZ4lDLbnO+aqn5vcJXLi4r4Hj/PAyGQOiRiZXBgozaLxdCWsg451w7bkY
	XLBS4pj7lXJiR7ZfrfLPOU+x86vxC8xeYEZ2RPgOBSW7P7py3TdQHmwIj6PkvJm5g7Mrxyq
	P/6mz9uK7eP1Y0uHTXFsRQyaTmo5wHaljco5WYpTyvuDA1dJuIBzLa27/DRlEYEE7iw3TOj
	+jUt77tThZFGYhjTB9dKDb9fObw5LfKg39gojQ50qar6jkI9PUz116R/wco4/7Hae1O8Ur2
	URxphTRR6WRR1gTUTE/0Y71jx/YSpUkaXi4VQrXBjeCILBU6oVE1SQu1y9jNCqOmNPZV44S
	Nwyt7HZvStCuPeuHhz0JuoQwI2EKZJ6LMEr5421zT1lKNMqHIW/kqt95l7MDbieV6yQw4Ao
	iWrn5u6JBff+/SZBpESQQTwuZ0uT+axKdib4Ldo720U8bQ7DaSt7oYGpreXXF7Ncirl03lU
	Fy2pbWOtYUhU+yMeApM0jU9tPfKWM1QTA4uQpVwA8nQsaj+66ytaLh2nfV0aRT+kdEo9u+Q
	jZf1o+z7/3/ycZwVkyqYOB8CIn6qBkZqyz1IWmraSEck3/JhqixQFg9JUJzEWyuZKHOPYR8
	e7KD0/FBVr3/zDy+JkCcXcRXnhd9td9cApcxGHfz+eRjWtryb4cFwithhrNXXhx8GPSuf0k
	PDTfGg7LJu2G+AhPKP
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8517-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,radxa.com:email,radxa.com:mid]
X-Rspamd-Queue-Id: 5F16B3BA3AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/2026 12:20 AM, Nikita Travkin wrote:
> Xilin Wu писал(а) 06.04.2026 20:50:
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
>>   drivers/pwm/pwm-clk.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 66 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
>> index f8f5af57acba..99821fae54e7 100644
>> --- a/drivers/pwm/pwm-clk.c
>> +++ b/drivers/pwm/pwm-clk.c
>> @@ -10,12 +10,15 @@
>>    * Limitations:
>>    * - Due to the fact that exact behavior depends on the underlying
>>    *   clock driver, various limitations are possible.
>> - * - Underlying clock may not be able to give 0% or 100% duty cycle
>> - *   (constant off or on), exact behavior will depend on the clock.
>> - * - When the PWM is disabled, the clock will be disabled as well,
>> - *   line state will depend on the clock.
> 
> nit: I think those limitations would still stand for existing
> users, perhaps we could just add "... unless gpio pinctrl state
> is supplied" to these two?

Ack.

> 
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
>> @@ -25,11 +28,17 @@
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
>> @@ -45,14 +54,36 @@ static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
>> +	if (constant_level) {
>> +		if (pcchip->gpiod) {
>> +			pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
>> +			gpiod_direction_output(pcchip->gpiod, gpio_value);
> 
> Is this the same case as below where gpio state has to be set
> before we can control it, or can we swap those so we first
> put gpio into a known state and only then mux it to the pad?
> 

Yeah, I think it makes sense to set the gpio state first. Thanks for the 
suggestion.

> 
> Thanks for improving this driver,
> Nikita
> 
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
>> @@ -97,6 +128,35 @@ static int pwm_clk_probe(struct platform_device *pdev)
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
>>   	chip->ops = &pwm_clk_ops;
>>   
>>   	ret = pwmchip_add(chip);
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>


