Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC361A8BA7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2020 21:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505310AbgDNT5x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Apr 2020 15:57:53 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38619 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505301AbgDNT53 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 15:57:29 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6B92922FEC;
        Tue, 14 Apr 2020 21:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1586894236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1MxhBoeYs71xwy2H0AJkghL+7Y+1QwLOd9ofZWf8mY=;
        b=oYyi/K9Wgv1J8oUv562gbV/e/cxfMAv1K6H8unRKColnTKhwpm+o2zuVXXywnycQemE920
        49lVQd/oeC++cP1U8UAjd2wqxmRkE+CsXw4zAXo8aqoBXwRTVNIy+ObJKwMDB2s3LXJS0A
        SUYA2YwD+G6uEd0VIP7BN8x0gr1wjC0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 14 Apr 2020 21:57:15 +0200
From:   Michael Walle <michael@walle.cc>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
In-Reply-To: <62d157198a75a59ada15c496deeab49b@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
 <62d157198a75a59ada15c496deeab49b@walle.cc>
Message-ID: <eab972adf53bbac20b5a9e613fcfb5b0@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 6B92922FEC
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-0.400];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Mark, Hi Bartosz, Hi Linus,

Am 2020-04-14 20:41, schrieb Michael Walle:
> Am 2020-04-14 19:00, schrieb Bartosz Golaszewski:
>> wt., 14 kwi 2020 o 12:07 Michael Walle <michael@walle.cc> napisał(a):
>>> >>
>>> >> So the best from a user perspective I've could come up with was:
>>> >>
>>> >>    ->base_reg = GPIO_REGMAP_ADDR(addr);
>>> >>
>>> >> I'm open for suggestions.
>>> >>
>>> >
>>> > Maybe setting the pointer to ERR_PTR(-ENOENT) which will result in
>>> > IS_ERR() returning true?
>>> 
>>> Unfortunatly, its not a pointer, but only a regular unsigned int (ie
>>> the type the regmap API has for its "reg" property). It could be a
>>> pointer of course but then the user would have to allocate additional
>>> memory.
>>> 
>>> -michael
>>> 
>> 
>> Eek, of course it's not a pointer. If possible I'd like to avoid this
>> GPIO_REGMAP_ADDR() macro, so how about having some separate field for
>> invalid offsets making every offset 'valid' by default?
> 
> IMHO this has the same problems as mentioned in the response to Mark's
> idea. Normally, the user sets only some addresses, thus he has to mark
> all other as invalid. And if you add another address, you have to touch
> all the drivers to mark it as invalid.
> 
> We could add some force bits like the "use_ack" flag in the bgpio 
> driver,
> where you can force the use of the value 0. But I'd really like to find
> a better way..

So what about the following:

#define GPIO_REGMAP_ADDR_ZERO (unsigned int)(-1)

So this way the user might assign the base addresses the normal way
except when he wants to use zero, in that case he has to use

   ->base_adr = GPIO_REGMAP_ADDR_ZERO;

gpio-regmap.c could use then:

if (base_addr)
   something_useful(gpio_regmap_addr(base_addr));

unsigned int gpio_regmap_addr(unsigned int addr)
{
   return (addr == GPIO_REGMAP_ADDR_ZERO) ? 0 : addr;
}

-michael
