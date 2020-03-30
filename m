Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C24197B29
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgC3Ls0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 07:48:26 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35107 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgC3Ls0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 07:48:26 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C5D9423D22;
        Mon, 30 Mar 2020 13:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585568902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WNHnqJr48B9UGKgZOiUmrkZCrV3XIE1znDFAU2j6Tg=;
        b=OwrdblbDl1rXIFYSbMyycWAJ/UOrU4LJoT06Nn1G+IM+/E1naMieKRwBijsqcFco+PCiRB
        Y9hqzgjb4FFo1rpJ109DNWxxkRidjc/7K4mc0+Jc+KapaponxbXASGImRVwIqw8PeZnq27
        cB865PGVvlh96zdgrv44Q1RrplOc2Tc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Mar 2020 13:48:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 12/18] gpio: add support for the sl28cpld GPIO controller
In-Reply-To: <CAMpxmJUj7wBvO=Y-u5CXazHhjsPHXcq=5iST4KuLrfakW_a9Mg@mail.gmail.com>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
 <9c310f2a11913d4d089ef1b07671be00@walle.cc>
 <CAMpxmJXmD-M+Wbj6=wgFgP2aDxbqDN=ceHi1XDun4iwdLm55Zg@mail.gmail.com>
 <22944c9b62aa69da418de7766b7741bd@walle.cc>
 <CACRpkdbJ3DBO+W4P0n-CfZ1T3L8d_L0Nizra8frkv92XPXR4WA@mail.gmail.com>
 <4d8d3bc26bdf73eb5c0e5851589fe085@walle.cc>
 <CAMpxmJUj7wBvO=Y-u5CXazHhjsPHXcq=5iST4KuLrfakW_a9Mg@mail.gmail.com>
Message-ID: <021f3add4b03b7a682832921a96ef85f@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: C5D9423D22
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[21];
         NEURAL_HAM(-0.00)[-0.772];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linaro.org,vger.kernel.org,lists.infradead.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,


Am 2020-03-30 13:21, schrieb Bartosz Golaszewski:
> pt., 27 mar 2020 o 16:28 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> Am 2020-03-27 11:20, schrieb Linus Walleij:
>> > On Thu, Mar 26, 2020 at 9:06 PM Michael Walle <michael@walle.cc> wrote:
>> >> Am 2020-03-25 12:50, schrieb Bartosz Golaszewski:
>> >
>> >> > In that case maybe you should use the disable_locking option in
>> >> > regmap_config and provide your own callbacks that you can use in the
>> >> > irqchip code too?
>> >>
>> >> But how would that solve problem (1). And keep in mind, that the
>> >> reqmap_irqchip is actually used for the interrupt controller, which
>> >> is not this gpio controller.
>> >>
>> >> Ie. the interrupt controller of the sl28cpld uses the regmap_irqchip
>> >> and all interrupt phandles pointing to the interrupt controller will
>> >> reference the toplevel node. Any phandles pointing to the gpio
>> >> controller will reference the GPIO subnode.
>> >
>> > Ideally we would create something generic that has been on my
>> > mind for some time, like a generic GPIO regmap irqchip now that
>> > there are a few controllers like that.
>> >
>> > I don't know how feasible it is or how much work it would be. But
>> > as with GPIO_GENERIC (for MMIO) it would be helpful since we
>> > can then implement things like .set_multiple() and .get_multiple()
>> > for everyone.
>> 
>> For starters, would that be a drivers/gpio/gpio-regmap.c or a
>> drivers/base/regmap/regmap-gpio.c? I would assume the first,
>> because the stuff in drivers/base/regmap operates on a given
>> regmap and we'd just be using one, correct? On the other hand
>> there is also the reqmap-irq.c. But as pointed out before, it
>> will add an interrupt controller to the regmap, not a device
>> so to speak.
>> 
>> -michael
> 
> This has been on my TODO list for so long, but I've never been able to
> find the time... I'd really appreciate any effort in that direction as
> I believe it would allow us to slowly port a big part of the GPIO
> expander drivers over to it and make large portions of our codebase
> generic.

I might have at least a first patch this week. So if you and Linus
Walleij might have some time to help review and comment on that, it
would be greatly appreciated.

-michael

> 
> Best regards,
> Bartosz Golaszewski
