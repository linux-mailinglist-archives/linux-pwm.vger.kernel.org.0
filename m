Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2862301A27
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Jan 2021 07:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbhAXGRy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Jan 2021 01:17:54 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:57288 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAXGRx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Jan 2021 01:17:53 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 29867440205;
        Sun, 24 Jan 2021 08:17:07 +0200 (IST)
References: <cover.1610364681.git.baruch@tkos.co.il>
 <ba8d5d482a98690140e02c3a35506490e0c6ecb4.1610364681.git.baruch@tkos.co.il>
 <CAMpxmJUGHqJ0C9A84LBF_xzwjbqwFnUnYqFTGBg2CXhKUWd-zg@mail.gmail.com>
User-agent: mu4e 1.4.14; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] gpio: mvebu: add pwm support for Armada 8K/7K
In-reply-to: <CAMpxmJUGHqJ0C9A84LBF_xzwjbqwFnUnYqFTGBg2CXhKUWd-zg@mail.gmail.com>
Date:   Sun, 24 Jan 2021 08:17:06 +0200
Message-ID: <87a6syeu59.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bartosz,

Thanks for you review.

On Fri, Jan 22 2021, Bartosz Golaszewski wrote:
> On Mon, Jan 11, 2021 at 12:47 PM Baruch Siach <baruch@tkos.co.il> wrote:
>> Use the marvell,pwm-offset DT property to store the location of PWM
>> signal duration registers.
>>
>> Since we have more than two GPIO chips per system, we can't use the
>> alias id to differentiate between them. Use the offset value for that.
>>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

[...]

>> +       regmap_write(mvchip->regs,
>> +                    GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
>
> Can you confirm that this line is on purpose and that it should be
> executed even for chips that use a separate regmap for PWM?

Yes. The blink counter selection register is at the same offset is all
chips that support the GPIO blink feature. Only the on/off registers
offset is different.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
