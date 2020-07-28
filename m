Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B1F23058F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 10:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgG1IiN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgG1IiM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 04:38:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125AC061794;
        Tue, 28 Jul 2020 01:38:11 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 57FFD22F00;
        Tue, 28 Jul 2020 10:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595925488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeGX2CeZPQ2jTjYJwriGXoWv4Xxv+ZHe+OXyj9uS1EI=;
        b=ET/wyIoSCwH1qDZuc5g3ByJZKYXpVMpHKMv+CaktCC7I2C6ReAEtjmtWeETGrhH15FDi+T
        9wunTehr0h4i5sDuG0VbUwxiFKKhTglu10R8mWkPIvyEjifQs62zYuCnuPnpRU+I6xB+/6
        PV90+P6U7owpDj4+m/4sg8MwCbpTm34=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 10:38:08 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 02/13] dt-bindings: mfd: Add bindings for sl28cpld
In-Reply-To: <20200728082707.GB2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-3-michael@walle.cc> <20200728072422.GF1850026@dell>
 <1065b0107ce6fd88b2bdd704bf45346b@walle.cc> <20200728082707.GB2419169@dell>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <a47993ca4c77ab1ee92f6693debb3c87@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-07-28 10:27, schrieb Lee Jones:
> On Tue, 28 Jul 2020, Michael Walle wrote:
> 
>> Am 2020-07-28 09:24, schrieb Lee Jones:
>> > On Sun, 26 Jul 2020, Michael Walle wrote:
>> >
>> > > Add a device tree bindings for the board management controller found
>> > > on
>> > > the Kontron SMARC-sAL28 board.
>> > >
>> > > Signed-off-by: Michael Walle <michael@walle.cc>
>> > > Reviewed-by: Rob Herring <robh@kernel.org>
>> > > ---
>> > > Changes since v5:
>> > >  - none
>> > >
>> > > Changes since v4:
>> > >  - fix the regex of the unit-address
>> > >
>> > > Changes since v3:
>> > >  - see cover letter
>> > >
>> > >  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  54 +++++++
>> > >  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++++
>> > >  .../kontron,sl28cpld-intc.yaml                |  54 +++++++
>> > >  .../bindings/mfd/kontron,sl28cpld.yaml        | 153
>> > > ++++++++++++++++++
>> > >  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
>> > >  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
>> > >  6 files changed, 358 insertions(+)
>> > >  create mode 100644
>> > > Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>> > >  create mode 100644
>> > > Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
>> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
>> > >  create mode 100644
>> > > Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
>> > >  create mode 100644
>> > > Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
>> > >  create mode 100644
>> > > Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
>> > >
>> > > diff --git
>> > > a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>> > > b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>> > > new file mode 100644
>> > > index 000000000000..9a63a158a796
>> > > --- /dev/null
>> > > +++
>> > > b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>> > > @@ -0,0 +1,54 @@
>> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > > +%YAML 1.2
>> > > +---
>> > > +$id: http://devicetree.org/schemas/gpio/kontron,sl28cpld-gpio.yaml#
>> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > > +
>> > > +title: GPIO driver for the sl28cpld board management controller
>> > > +
>> > > +maintainers:
>> > > +  - Michael Walle <michael@walle.cc>
>> > > +
>> > > +description: |
>> > > +  This module is part of the sl28cpld multi-function device. For more
>> > > +  details see
>> > > Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
>> >
>> > Paths are normally relative.
>> 
>> grep Documentation/ Documentation
>> 
>> I know there are a lot false positives (esp in the first one)..
>> 
>> $ grep -r "\.\./" Documentation | wc -l
>> 1826
>> $ grep -r "Documentation/" Documentation|wc -l
>> 2862
> 
> I actually meant just for Device Tree bindings, but it does appear
> that 'Documentation' is used a bunch there too.
> 
> My reasons for not liking full paths is that the intention was always
> to move 'Documentation/devicetree' to a new location outside of the
> kernel source tree.

I see. I'll change that.

>> > > +%YAML 1.2
>> > > +---
>> > > +$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
>> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > > +
>> > > +title: Kontron's sl28cpld board management controller
>> >
>> > "S128CPLD" ?
>> 
>> still not, its sl28cpld, think of a project/code name, not the product
>> appended with CPLD.
>> 
>> > "Board Management Controller (BMC)" ?
>> 
>> sounds like IPMI, which I wanted to avoid.
> 
> Is there a datasheet?

No there isn't.

>> > > +maintainers:
>> > > +  - Michael Walle <michael@walle.cc>
>> > > +
>> > > +description: |
>> > > +  The board management controller may contain different IP blocks
>> > > like
>> > > +  watchdog, fan monitoring, PWM controller, interrupt controller
>> > > and a
>> > > +  GPIO controller.
>> > > +
>> > > +properties:
>> > > +  compatible:
>> > > +    const: kontron,sl28cpld-r1
>> >
>> > We don't usually code revision numbers in compatible strings.
>> >
>> > Is there any way to pull this from the H/W?
>> 
>> No, unfortunately you can't. And I really want to keep that, in case
>> in the future there are some backwards incompatible changes.
> 
> Rob,
> 
> I know you reviewed this already, but you can give your opinion on
> this specifically please?  I know that we have pushed back on this in
> the past.

Oh, come one. That is an arbitrary string. "sl28cpld-r1" is the first
implementation of this. A future "sl28cpld-r2" might look completely
different and might not suite the simple MFD at all. "sl28cpld" is
a made up name - as "sl28cpld-r1" is, too.

-michael
