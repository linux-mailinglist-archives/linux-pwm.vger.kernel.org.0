Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E51965F5
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Mar 2020 13:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgC1MEz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 28 Mar 2020 08:04:55 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:34069 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgC1MEz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 28 Mar 2020 08:04:55 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 06D1423058;
        Sat, 28 Mar 2020 13:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585397092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n5jtDDhzPSvYKIS+PmQfH6uIuXE3eV4q3g/zF9Fsvio=;
        b=XLgcUGYRO9K8MDB5bv0eN6E/rPVGT7+8hpRkYKa0oYK7kqG+J82GWy9Z9UrVXXM2d3TY/l
        44dxqw9vOcjFA43tDjkZeTHYvo/ZL/wck9Z06bEN5KblEyL2ihn4+V5olaW8sgt5tfgn5X
        sAEssrEkn0SCRxZcAsyH0d9PcQckI6U=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 28 Mar 2020 13:04:50 +0100
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
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 12/18] gpio: add support for the sl28cpld GPIO controller
In-Reply-To: <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
Message-ID: <ef10a6f07f093c282df7fe94057cc7c7@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 06D1423058
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[21];
         NEURAL_HAM(-0.00)[-0.578];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bartosz,

Am 2020-03-18 10:14, schrieb Bartosz Golaszewski:
> wt., 17 mar 2020 o 21:50 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> This adds support for the GPIO controller of the sl28 board management
>> controller. This driver is part of a multi-function device.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Hi Michael,
> 
> thanks for the driver. Please take a look at some comments below.
> 
>> ---

[..]

>> +#define GPIO_REG_DIR   0
>> +#define GPIO_REG_OUT   1
>> +#define GPIO_REG_IN    2
>> +#define GPIO_REG_IE    3
>> +#define GPIO_REG_IP    4
> 
> These values would be more clear if they were defined as hex.
> 
>> +
>> +#define GPI_REG_IN     0
>> +
>> +#define GPO_REG_OUT    0
> 
> Please also use a common prefix even for defines.

The GPIO_, GPI_ and GPO_ prefixes corresponds to the different
flavours. Do they still need a common prefix? Ie. the GPI_REG_IN
has nothing to do with GPO_REG_OUT, nor has both something
to do with the GPIO_REG_IN and GPIO_REG_OUT. I could prefix them
with SL28CPLD_ though. But I don't know if that is what you had
in mind because then they would be SL28CPLD_GPIO_REG_IN and
SL28CPLD_GPI_REG_IN for example.

-michael
