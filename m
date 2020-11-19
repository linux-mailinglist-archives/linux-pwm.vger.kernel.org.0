Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3042B8B94
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 07:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgKSGVv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 01:21:51 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:59091 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgKSGVv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Nov 2020 01:21:51 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 9466B44064A;
        Thu, 19 Nov 2020 08:21:48 +0200 (IST)
References: <cover.1605694661.git.baruch@tkos.co.il> <db0d6d619a0686eef1b15ca7409d73813440856f.1605694661.git.baruch@tkos.co.il> <20201118231811.GH1853236@lunn.ch>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] gpio: mvebu: add pwm support for Armada 8K/7K
In-reply-to: <20201118231811.GH1853236@lunn.ch>
Date:   Thu, 19 Nov 2020 08:21:48 +0200
Message-ID: <878sax6f43.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andrew,

On Thu, Nov 19 2020, Andrew Lunn wrote:
> On Wed, Nov 18, 2020 at 12:30:44PM +0200, Baruch Siach wrote:
>> Use the pwm-offset DT property to store the location of PWM signal
>> duration registers.
>> 
>> Since we have more than two GPIO chips per system, we can't use the
>> alias id to differentiate between them. Use the offset value for that.
>> 
>> Move mvebu_pwm_probe() call before irq support code. The AP80x does not
>> provide irq support, but does provide PWM. Don't skip PWM probe because
>> of that.
>> 
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

[snip]

>> @@ -781,51 +787,80 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>>  	struct device *dev = &pdev->dev;
>>  	struct mvebu_pwm *mvpwm;
>>  	void __iomem *base;
>> +	u32 offset;
>>  	u32 set;
>>  
>> -	if (!of_device_is_compatible(mvchip->chip.of_node,
>> -				     "marvell,armada-370-gpio"))
>> -		return 0;
>> -
>> -	/*
>> -	 * There are only two sets of PWM configuration registers for
>> -	 * all the GPIO lines on those SoCs which this driver reserves
>> -	 * for the first two GPIO chips. So if the resource is missing
>> -	 * we can't treat it as an error.
>> -	 */
>> -	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
>> +	if (of_device_is_compatible(mvchip->chip.of_node,
>> +				    "marvell,armada-370-gpio")) {
>> +		/*
>> +		 * There are only two sets of PWM configuration registers for
>> +		 * all the GPIO lines on those SoCs which this driver reserves
>> +		 * for the first two GPIO chips. So if the resource is missing
>> +		 * we can't treat it as an error.
>> +		 */
>> +		if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
>> +			return 0;
>> +		offset = 0;
>> +	} else if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
>> +		int ret = of_property_read_u32(dev->of_node, "pwm-offset",
>> +					       &offset);
>> +		if (ret < 0)
>> +			return 0;
>
> It would look more uniform if this was
>
> 	if (of_device_is_compatible(mvchip->chip.of_node,
> 				    "marvell,armada-8k-gpio")) {

Right. However I use soc_variant again below. I think that
of_device_is_compatible is too verbose for that.

In fact, I'd rather use soc_variant for marvell,armada-370-gpio as
well. The trouble is that marvell,armada-370-gpio is not equivalent to
MVEBU_GPIO_SOC_VARIANT_ORION. Changing that is more intrusive.

>> +	} else {
>>  		return 0;
>> +	}

[snip]

>> @@ -1200,6 +1235,13 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>>  
>>  	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
>>  
>> +	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
>> +	if (IS_ENABLED(CONFIG_PWM)) {
>> +		err = mvebu_pwm_probe(pdev, mvchip, id);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>
> The existing error handling looks odd here. Why is there no goto
> err_domain when probing the PWMs fails? I wonder if this a bug from me
> from a long time again?

What would you release under the err_domain label? As far as I can see
all resources are allocated using devres, and released automatically on
failure exit.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
