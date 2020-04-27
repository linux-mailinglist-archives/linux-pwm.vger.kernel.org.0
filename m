Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340291BABCE
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD0R6Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgD0R6Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 13:58:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED110C0610D5;
        Mon, 27 Apr 2020 10:58:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0E4E323060;
        Mon, 27 Apr 2020 19:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1588010302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuXxMU3XohLcLuj7G8DbEK61wsli0t56ftpqdXv6gHs=;
        b=BjqUDFiMiUoB5EOzeIikHKwr+tp8SxHEsoerjHtd9z1THx0O4KAwF9vKQGIZctvLq394Cg
        ZpkQkrazePtHUKwyrY7KH/9H83n+AlCdAMH/NkZoOBMnT6SQN0SX+Zl3tAux8l44NobQ7y
        mqZnPqIvvbmtL/bpsPNDTUrXK6rmzLQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Apr 2020 19:58:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 11/16] gpio: add support for the sl28cpld GPIO
 controller
In-Reply-To: <87k121qhj7.fsf@nanos.tec.linutronix.de>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-12-michael@walle.cc>
 <87k121qhj7.fsf@nanos.tec.linutronix.de>
Message-ID: <8acfbefeb9d7f59329f2899176059600@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 0E4E323060
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         NEURAL_HAM(-0.00)[-0.765];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,lists.infradead.org,linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-04-27 13:45, schrieb Thomas Gleixner:
> Michael Walle <michael@walle.cc> writes:
>> +struct sl28cpld_gpio {
>> +	struct regmap_irq_chip irq_chip;
>> +	struct regmap_irq_chip_data *irq_data;
>> +};
>> +
>> +static const struct regmap_irq sl28cpld_gpio_irqs[] = {
>> +	REGMAP_IRQ_REG_LINE(0, 8),
>> +	REGMAP_IRQ_REG_LINE(1, 8),
>> +	REGMAP_IRQ_REG_LINE(2, 8),
>> +	REGMAP_IRQ_REG_LINE(3, 8),
>> +	REGMAP_IRQ_REG_LINE(4, 8),
>> +	REGMAP_IRQ_REG_LINE(5, 8),
>> +	REGMAP_IRQ_REG_LINE(6, 8),
>> +	REGMAP_IRQ_REG_LINE(7, 8),
>> +};
> 
> This is exactly the same as the one in the irq chip patch.

To my knowledge this boilerplate is just to describe this
irqchip has 8 different IRQs.

>> +static int sl28cpld_gpio_irq_init(struct device *dev,
>> +				  struct sl28cpld_gpio *gpio,
>> +				  struct regmap *regmap, unsigned int base,
>> +				  int irq)
>> +{
>> +	struct regmap_irq_chip *irq_chip = &gpio->irq_chip;
>> +
>> +	irq_chip->name = "sl28cpld-gpio-irq",
>> +	irq_chip->irqs = sl28cpld_gpio_irqs;
>> +	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
>> +	irq_chip->num_regs = 1;
>> +	irq_chip->status_base = base + GPIO_REG_IP;
>> +	irq_chip->mask_base = base + GPIO_REG_IE;
>> +	irq_chip->mask_invert = true,
>> +	irq_chip->ack_base = base + GPIO_REG_IP;
>> +
>> +	return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), regmap,
>> +					   irq, IRQF_SHARED | IRQF_ONESHOT, 0,
>> +					   irq_chip, &gpio->irq_data);
>> +}
> 
> And this looks pretty familiar as well. What's the point of duplicating
> that code?

this is also just boilerplate to configure the irqchip. But there are 
two
distinct blocks inside the board management controller:
  - an interrupt controller (which has 8 interrupts)
  - and gpio controllers which also happen to have 8 interrupts and
    both have some shared semantics for now. But the GPIO building block
    might be extended to provide interrupt type settings, i.e. falling/
    rising/level triggered interrupts.

So yes both look similar, but they are two different blocks, they use
different registers and they might drift apart in the future.

-michael

> 
> Thanks,
> 
>         tglx
