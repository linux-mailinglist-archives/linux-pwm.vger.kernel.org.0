Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A567E1ABCE2
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 11:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503730AbgDPJek (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 05:34:40 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55287 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503587AbgDPJee (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 05:34:34 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 135AA22F53;
        Thu, 16 Apr 2020 11:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587029666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wl0AyceV1HH2Bd5JaxMdDxBcxIXT6A+UuSLy9IcpOs4=;
        b=fdSgq9LvNOGqIy0gUfMq93deaPw6BZqZHdv+a38XnNPqqltZFNASH8ql6fitG2O9ld7Fhd
        89CCvLeW9VQPPWsn6QhIAbe2kDBbC8GjtJta3+KazM2VUze0Fpwb1G7AZsv7C/L7/DB79C
        HBuO5V1WWdBRNC5k1tGvQI1iyeMkQhA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Apr 2020 11:34:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
In-Reply-To: <CACRpkdZPZ4nFQ6B3tGG9wvceoTWqAkfY0r1UKs2pf_c=ZNBG=w@mail.gmail.com>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
 <62d157198a75a59ada15c496deeab49b@walle.cc>
 <eab972adf53bbac20b5a9e613fcfb5b0@walle.cc>
 <CACRpkdZPZ4nFQ6B3tGG9wvceoTWqAkfY0r1UKs2pf_c=ZNBG=w@mail.gmail.com>
Message-ID: <576a6244fa3b996327c49023fe953215@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 135AA22F53
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-0.404];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[baylibre.com,vger.kernel.org,lists.infradead.org,kernel.org,suse.com,roeck-us.net,linaro.org,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-04-16 11:20, schrieb Linus Walleij:
> On Tue, Apr 14, 2020 at 9:57 PM Michael Walle <michael@walle.cc> wrote:
> 
>> So what about the following:
>> 
>> #define GPIO_REGMAP_ADDR_ZERO (unsigned int)(-1)
> 
> Yeah with regmap explicitly using int I guess we can't use
> S32_MAX, so that is fair.
> 
>> So this way the user might assign the base addresses the normal way
>> except when he wants to use zero, in that case he has to use
>> 
>>    ->base_adr = GPIO_REGMAP_ADDR_ZERO;
>> 
>> gpio-regmap.c could use then:
>> 
>> if (base_addr)
>>    something_useful(gpio_regmap_addr(base_addr));
>> 
>> unsigned int gpio_regmap_addr(unsigned int addr)
>> {
>>    return (addr == GPIO_REGMAP_ADDR_ZERO) ? 0 : addr;
>> }
> 
> That's reasonably clean.

Ok, at least on that side. For my sl28 gpio driver I then have
the problem that depending on 'base' I might have to use
GPIO_REGMAP_ADDR_ZERO:

   #define GPIO_REG_DIR 0
   config.reg_dir_out_base = base + GPIO_REG_DIR;

So there is still a convenience macro:
   #define GPIO_REGMAP_ADDR(addr) ((addr) ? addr : GPIO_REGMAP_ADDR_ZERO)

which you can use if you can't be sure that the address is not non-zero.
So the code in my sl28 gpio driver looks like:

  config.reg_dir_out_base = GPIO_REGMAP_ADDR(base + GPIO_REG_DIR);

I'll respin the patch with the current remarks.

-michael
