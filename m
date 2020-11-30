Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D42C8C5B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 19:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgK3SNi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 30 Nov 2020 13:13:38 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:46661 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387885AbgK3SNh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 13:13:37 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 5503E44013A;
        Mon, 30 Nov 2020 20:12:54 +0200 (IST)
References: <4db704460547d715a1d9cf86d51612b347e38a7b.1606748993.git.baruch@tkos.co.il>
 <20201130153036.p3gdsauxsmas3rbo@pengutronix.de>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] gpio: mvebu: fix potential user-after-free on probe
In-reply-to: <20201130153036.p3gdsauxsmas3rbo@pengutronix.de>
Date:   Mon, 30 Nov 2020 20:12:53 +0200
Message-ID: <878saipvbu.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

(+ tglx)

On Mon, Nov 30 2020, Uwe Kleine-König wrote:
> On Mon, Nov 30, 2020 at 05:09:53PM +0200, Baruch Siach wrote:
>> When mvebu_pwm_probe() fails IRQ domain is not released. Goto the
>> err_domain label on failure to release IRQ domain.
>> 
>> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
>> Reported-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> v2: Don't leak pwm resources (Uwe Kleine-König)
>> 
>> This is split out of the "gpio: mvebu: Armada 8K/7K PWM support" series.
>> I'll rebase the series v2 on top on this fix.
>> ---
>>  drivers/gpio/gpio-mvebu.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
>> index 433e2c3f3fd5..c53ed975a180 100644
>> --- a/drivers/gpio/gpio-mvebu.c
>> +++ b/drivers/gpio/gpio-mvebu.c
>> @@ -1255,8 +1255,11 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
>> -	if (IS_ENABLED(CONFIG_PWM))
>> -		return mvebu_pwm_probe(pdev, mvchip, id);
>> +	if (IS_ENABLED(CONFIG_PWM)) {
>> +		err = mvebu_pwm_probe(pdev, mvchip, id);
>> +		if (err)
>> +			goto err_domain;
>
> I only looked quickly, but I wonder if you need to undo
> irq_alloc_domain_generic_chips(), too?!

So it seems. __irq_alloc_domain_generic_chips() calls kzalloc() for the
gc field of irq_domain. But I could not find any code that releases this
allocation. These drivers call irq_alloc_domain_generic_chips(), but do
not release gc on failure:

drivers/irqchip/irq-ingenic-tcu.c
drivers/irqchip/irq-orion.c
drivers/irqchip/irq-renesas-irqc.c
drivers/irqchip/irq-sunxi-nmi.c
drivers/pinctrl/pinctrl-rockchip.c

Some of them apparently skip the cleanup because the system would be
unusable anyway. But most of them call irq_domain_remove() on failure.

Thomas, what is the right thing to do here? Should we just call

  kfree(mvchip->domain->gc);

directly to release the allocation?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
