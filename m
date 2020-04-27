Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE71BAB79
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 19:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD0RkS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgD0RkS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 13:40:18 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D2C0610D5;
        Mon, 27 Apr 2020 10:40:17 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A316B2305C;
        Mon, 27 Apr 2020 19:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1588009213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mb7wOIhi91zTa7OdCwnok2RD4/Y3FAeCxF/iMp7nN6o=;
        b=jZOn6q/jxrjwYNn4nj3d83zoUJgdzvpe11GNFG7mRNPqsDk605zmppuXrjG6DwI9lToeYu
        hv+XTWKczoGnq1p/Vnvk/7ctIF/9ikivCHAneUAnz7kw7CjEkx+6UB5FgdL5xAtJTg6voE
        R4T413P+f5UjxDP86b2VwSVDn779YB4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Apr 2020 19:40:11 +0200
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
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller
 support
In-Reply-To: <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-7-michael@walle.cc>
 <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
Message-ID: <87f141bce0a4fda04b550647306be296@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: A316B2305C
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         NEURAL_HAM(-0.00)[-0.766];
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

Hi Thomas,

thanks for the review.

Am 2020-04-27 13:40, schrieb Thomas Gleixner:
> Michael Walle <michael@walle.cc> writes:
> 
>> This patch adds support for the interrupt controller inside the sl28
> 
> git grep 'This patch' Documentation/process/

ok.

> 
>> CPLD management controller.
>> 
>> +static int sl28cpld_intc_probe(struct platform_device *pdev)
>> +{
>> +	struct sl28cpld_intc *irqchip;
>> +	struct resource *res;
>> +	unsigned int irq;
>> +	int ret;
>> +
>> +	if (!pdev->dev.parent)
>> +		return -ENODEV;
>> +
>> +	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
>> +	if (!irqchip)
>> +		return -ENOMEM;
>> +
>> +	irqchip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!irqchip->regmap)
>> +		return -ENODEV;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
>> +	if (!res)
>> +		return -EINVAL;
>> +
>> +	irqchip->chip.name = "sl28cpld-intc";
>> +	irqchip->chip.irqs = sl28cpld_irqs;
>> +	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
>> +	irqchip->chip.num_regs = 1;
>> +	irqchip->chip.status_base = res->start + INTC_IP;
>> +	irqchip->chip.mask_base = res->start + INTC_IE;
>> +	irqchip->chip.mask_invert = true,
>> +	irqchip->chip.ack_base = res->start + INTC_IP;
>> +
>> +	ret = devm_regmap_add_irq_chip(&pdev->dev, irqchip->regmap, irq,
>> +				       IRQF_SHARED | IRQF_ONESHOT, 0,
> 
> What's the point of IRQF_SHARED | IRQF_ONESHOT here?

IRQF_SHARED because this interrupt is shared with all the blocks
which can generate interrupts, i.e. the GPIO contollers.

IRQF_ONESHOT, because its is a threaded interrupt with no primary
handler. But I just noticed, that regmap-irq will also set the
IRQF_ONESHOT. But that the commit 09cadf6e088b ("regmap-irq:
set IRQF_ONESHOT flag to ensure IRQ request") reads like it is
just there to be sure. So I don't know if it should also be set
here.

-michael

> 
>> +				       &irqchip->chip, &irqchip->irq_data);
> 
> Thanks,
> 
>         tglx
