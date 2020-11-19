Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF79B2B8B1C
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 06:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgKSFti (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 00:49:38 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:59014 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgKSFti (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Nov 2020 00:49:38 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 8193344064C;
        Thu, 19 Nov 2020 07:49:26 +0200 (IST)
References: <cover.1605694661.git.baruch@tkos.co.il> <20201118224632.GE1853236@lunn.ch>
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
Subject: Re: [PATCH 0/5] gpio: mvebu: Armada 8K/7K PWM support
In-reply-to: <20201118224632.GE1853236@lunn.ch>
Date:   Thu, 19 Nov 2020 07:49:24 +0200
Message-ID: <87blft6gm3.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andrew,

Thanks for your review comments.

On Thu, Nov 19 2020, Andrew Lunn wrote:
> On Wed, Nov 18, 2020 at 12:30:41PM +0200, Baruch Siach wrote:
>> The gpio-mvebu driver supports the PWM functionality of the GPIO block for 
>> earlier Armada variants like XP, 370 and 38x. This series extends support to 
>> newer Armada variants that use CP11x and AP80x, like Armada 8K and 7K.
>> 
>> This series adds adds the 'pwm-offset' property to DT binding. 'pwm-offset' 
>
> One adds is enough.
>
>> points to the base of A/B counter registers that determine the PWM period and 
>> duty cycle.
>> 
>> The existing PWM DT binding reflects an arbitrary decision to allocate the A 
>> counter to the first GPIO block, and B counter to the other one.
>
> It was not arbitrary. I decided on KISS. The few devices i've seen
> using this have been for a single GPIO/PWN controlled fan. KISS was
> sufficient for that, so why make it more complex?

In saying "arbitrary" I don't mean to say it's not a good choice in the
context of the Linux PWM and GPIO subsystems. But this choice is still
arbitrary from hardware point of view. DT is meant to describe the
hardware. I think that coding the A/B counters allocation choice in DT
is not optimal in terms for hardware description. Both counters are
usable for both GPIO blocks.

I also don't see how this makes anything more complex. The driver code
is already aware of this A/B allocation (GPIO_BLINK_CNT_SELECT_OFF). My
suggestion is to keep this decision in the driver, and leave DT to
describe the hardware. This costs us a single code line (patch #3):

  mvpwm->offset += PWM_BLINK_COUNTER_B_OFF;

Does that make sense?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
