Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB222CAAAA
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgLASW0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 13:22:26 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:48332 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgLASWZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 1 Dec 2020 13:22:25 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 0910B440069;
        Tue,  1 Dec 2020 20:21:36 +0200 (IST)
References: <cover.1605694661.git.baruch@tkos.co.il>
 <db0d6d619a0686eef1b15ca7409d73813440856f.1605694661.git.baruch@tkos.co.il>
 <20201118231811.GH1853236@lunn.ch> <878sax6f43.fsf@tarshish>
 <20201119133429.GS1804098@lunn.ch> <877dqhfogp.fsf@tarshish>
 <CAMpxmJXKDhB1fOGaY_+bmZ=4X6du0n6aoYVTMKnGXvTd8PdUNg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] gpio: mvebu: add pwm support for Armada 8K/7K
In-reply-to: <CAMpxmJXKDhB1fOGaY_+bmZ=4X6du0n6aoYVTMKnGXvTd8PdUNg@mail.gmail.com>
Date:   Tue, 01 Dec 2020 20:21:33 +0200
Message-ID: <87lfeho09e.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bartosz,

On Tue, Dec 01 2020, Bartosz Golaszewski wrote:
> On Thu, Nov 19, 2020 at 2:47 PM Baruch Siach <baruch@tkos.co.il> wrote:
>> On Thu, Nov 19 2020, Andrew Lunn wrote:
>> >> >> @@ -1200,6 +1235,13 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
>> >> >>
>> >> >>   devm_gpiochip_add_data(&pdev->dev, &mvchip->chip, mvchip);
>> >> >>
>> >> >> + /* Some MVEBU SoCs have simple PWM support for GPIO lines */
>> >> >> + if (IS_ENABLED(CONFIG_PWM)) {
>> >> >> +         err = mvebu_pwm_probe(pdev, mvchip, id);
>> >> >> +         if (err)
>> >> >> +                 return err;
>> >> >> + }
>> >> >> +
>> >> >
>> >> > The existing error handling looks odd here. Why is there no goto
>> >> > err_domain when probing the PWMs fails? I wonder if this a bug from me
>> >> > from a long time again?
>> >>
>> >> What would you release under the err_domain label? As far as I can see
>> >> all resources are allocated using devres, and released automatically on
>> >> failure exit.
>> >
>> > The IRQ domain is still registers. So once the memory is automatically
>> > freed, don't we have a potential use after free?
>>
>> This patch moves PWM registration before IRQ domain registration for
>> another reason as mentioned in the commit log. So this might
>> incidentally fix the bug.
>>
>> Would you prefer a separate patch for that with a 'Fixes:
>> 757642f9a584e8' tag?
>
> Baruch: does this series conflict with the fix you sent? I'm thinking
> about how to take it through the next and fixes trees.

Yes, It conflicts.

I can send in a single series v3 of the fix along with the other patches
rebased on top. Would that work for you?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
