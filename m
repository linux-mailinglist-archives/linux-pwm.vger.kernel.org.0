Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532D22B93E3
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgKSNrW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 08:47:22 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:59596 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgKSNrW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Nov 2020 08:47:22 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 966C844064A;
        Thu, 19 Nov 2020 15:47:18 +0200 (IST)
References: <cover.1605694661.git.baruch@tkos.co.il>
 <db0d6d619a0686eef1b15ca7409d73813440856f.1605694661.git.baruch@tkos.co.il>
 <20201118231811.GH1853236@lunn.ch> <878sax6f43.fsf@tarshish>
 <20201119133429.GS1804098@lunn.ch>
User-agent: mu4e 1.4.13; emacs 27.1
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
In-reply-to: <20201119133429.GS1804098@lunn.ch>
Date:   Thu, 19 Nov 2020 15:47:18 +0200
Message-ID: <877dqhfogp.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andrew,

On Thu, Nov 19 2020, Andrew Lunn wrote:
>> >> @@ -1200,6 +1235,13 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>> >>  
>> >>  	devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
>> >>  
>> >> +	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
>> >> +	if (IS_ENABLED(CONFIG_PWM)) {
>> >> +		err = mvebu_pwm_probe(pdev, mvchip, id);
>> >> +		if (err)
>> >> +			return err;
>> >> +	}
>> >> +
>> >
>> > The existing error handling looks odd here. Why is there no goto
>> > err_domain when probing the PWMs fails? I wonder if this a bug from me
>> > from a long time again?
>> 
>> What would you release under the err_domain label? As far as I can see
>> all resources are allocated using devres, and released automatically on
>> failure exit.
>
> The IRQ domain is still registers. So once the memory is automatically
> freed, don't we have a potential use after free?

This patch moves PWM registration before IRQ domain registration for
another reason as mentioned in the commit log. So this might
incidentally fix the bug.

Would you prefer a separate patch for that with a 'Fixes:
757642f9a584e8' tag?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
