Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1322E1BAD6A
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD0TAh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgD0TAh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 15:00:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F1C0610D5;
        Mon, 27 Apr 2020 12:00:36 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT8z9-0004q5-0k; Mon, 27 Apr 2020 21:00:07 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E95AB100606; Mon, 27 Apr 2020 21:00:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Walle <michael@walle.cc>
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
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller support
In-Reply-To: <87f141bce0a4fda04b550647306be296@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-7-michael@walle.cc> <87pnbtqhr1.fsf@nanos.tec.linutronix.de> <87f141bce0a4fda04b550647306be296@walle.cc>
Date:   Mon, 27 Apr 2020 21:00:05 +0200
Message-ID: <87sggopxe2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Michael,

Michael Walle <michael@walle.cc> writes:
> Am 2020-04-27 13:40, schrieb Thomas Gleixner:
>>> +
>>> +	ret = devm_regmap_add_irq_chip(&pdev->dev, irqchip->regmap, irq,
>>> +				       IRQF_SHARED | IRQF_ONESHOT, 0,
>> 
>> What's the point of IRQF_SHARED | IRQF_ONESHOT here?
>
> IRQF_SHARED because this interrupt is shared with all the blocks
> which can generate interrupts, i.e. the GPIO contollers.

Why are people still designing hardware with shared interrupts? Shared
interrupts are broken by design and that's well known for decades.

> IRQF_ONESHOT, because its is a threaded interrupt with no primary
> handler. But I just noticed, that regmap-irq will also set the
> IRQF_ONESHOT. But that the commit 09cadf6e088b ("regmap-irq:
> set IRQF_ONESHOT flag to ensure IRQ request") reads like it is
> just there to be sure. So I don't know if it should also be set
> here.

Ok. Wasn't aware of that magic threaded interrupt connection.

Thanks,

        tglx
