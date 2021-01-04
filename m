Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB772E9324
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Jan 2021 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhADKMs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Jan 2021 05:12:48 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:59298 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbhADKMs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 4 Jan 2021 05:12:48 -0500
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 52E89440AEE;
        Mon,  4 Jan 2021 12:12:05 +0200 (IST)
References: <cover.1607601615.git.baruch@tkos.co.il>
 <20210104092449.GA1551@shell.armlinux.org.uk>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-pwm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v4 0/3] gpio: mvebu: Armada 8K/7K PWM support
In-reply-to: <20210104092449.GA1551@shell.armlinux.org.uk>
Date:   Mon, 04 Jan 2021 12:12:04 +0200
Message-ID: <87mtxp9fkb.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Russell,

On Mon, Jan 04 2021, Russell King - ARM Linux admin wrote:
> On Thu, Dec 10, 2020 at 02:15:57PM +0200, Baruch Siach wrote:
>> This series makes two changes to v3:
>> 
>>   * Remove patches that are in LinusW linux-gpio for-next and fixes
>> 
>>   * Rename the 'pwm-offset' property to 'marvell,pwm-offset' as suggested by 
>>     Rob Herring
>> 
>> The original cover letter follows (with DT property name updated).
>> 
>> The gpio-mvebu driver supports the PWM functionality of the GPIO block for
>> earlier Armada variants like XP, 370 and 38x. This series extends support to
>> newer Armada variants that use CP11x and AP80x, like Armada 8K and 7K.
>> 
>> This series adds adds the 'marvell,pwm-offset' property to DT binding. 
>> 'marvell,pwm-offset' points to the base of A/B counter registers that 
>> determine the PWM period and duty cycle.
>> 
>> The existing PWM DT binding reflects an arbitrary decision to allocate the A
>> counter to the first GPIO block, and B counter to the other one. In attempt to
>> provide better future flexibility, the new 'marvell,pwm-offset' property 
>> always points to the base address of both A/B counters. The driver code still 
>> allocates the counters in the same way, but this might change in the future 
>> with no change to the DT.
>> 
>> Tested AP806 and CP110 (both) on Armada 8040 based system.
>
> Did you see the patches I sent during the last year doing this and
> adding support for the fan on the GT-8k?

You refer to the series linked below, right?

  https://lore.kernel.org/linux-pwm/20200329104549.GX25745@shell.armlinux.org.uk/

(For some reason the LAKM archive is missing two years, including this
time frame)

I now remember that series. I even archived it locally. But then I
forgot about it, so I ended up recreating Armada 8K PWM support from
scratch. Sorry about that.

Any comment on this series?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
