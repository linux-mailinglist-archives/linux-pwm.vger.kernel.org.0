Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8523061B
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 11:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgG1JGG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgG1JGF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 05:06:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E992C061794;
        Tue, 28 Jul 2020 02:06:05 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8BAFE22FEB;
        Tue, 28 Jul 2020 11:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595927163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qDlqdqnrq63mY3zRI+KJrgTKuzim4rp3TqdEiL1TrU=;
        b=uV1+pGhcvzIch3KaWSEO4peivbsttnPu6bAB5yDvHKD9/huxFx5wREsoGhVj3FQ1BZTi3f
        7eLiluHJKu5CBhGP4cA4MN+oohWSpB8t9yWLECZdrFFot0qB+92L6q1k9gj8Ltxmak3yKv
        OfFyMiseV14azylQP0wV94+3NmQi+dM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 11:06:02 +0200
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
In-Reply-To: <20200728085616.GD2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-3-michael@walle.cc> <20200728072422.GF1850026@dell>
 <1065b0107ce6fd88b2bdd704bf45346b@walle.cc> <20200728082707.GB2419169@dell>
 <a47993ca4c77ab1ee92f6693debb3c87@walle.cc> <20200728085616.GD2419169@dell>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <2fd3b880e36aa65e880b801092b51945@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-07-28 10:56, schrieb Lee Jones:
>> > > > > +$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
>> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > > > > +
>> > > > > +title: Kontron's sl28cpld board management controller
>> > > >
>> > > > "S128CPLD" ?
>> > >
>> > > still not, its sl28cpld, think of a project/code name, not the product
>> > > appended with CPLD.
>> > >
>> > > > "Board Management Controller (BMC)" ?
>> > >
>> > > sounds like IPMI, which I wanted to avoid.
>> >
>> > Is there a datasheet?
>> 
>> No there isn't.
> 
> Then what are you working from?

Ok, there is no public datasheet. If that wasn't clear before, I'm 
working
for that company that also implemented that CPLD.

>> > > > > +maintainers:
>> > > > > +  - Michael Walle <michael@walle.cc>
>> > > > > +
>> > > > > +description: |
>> > > > > +  The board management controller may contain different IP blocks
>> > > > > like
>> > > > > +  watchdog, fan monitoring, PWM controller, interrupt controller
>> > > > > and a
>> > > > > +  GPIO controller.
>> > > > > +
>> > > > > +properties:
>> > > > > +  compatible:
>> > > > > +    const: kontron,sl28cpld-r1
>> > > >
>> > > > We don't usually code revision numbers in compatible strings.
>> > > >
>> > > > Is there any way to pull this from the H/W?
>> > >
>> > > No, unfortunately you can't. And I really want to keep that, in case
>> > > in the future there are some backwards incompatible changes.
>> >
>> > Rob,
>> >
>> > I know you reviewed this already, but you can give your opinion on
>> > this specifically please?  I know that we have pushed back on this in
>> > the past.
>> 
>> Oh, come one. That is an arbitrary string. "sl28cpld-r1" is the first
>> implementation of this. A future "sl28cpld-r2" might look completely
>> different and might not suite the simple MFD at all. "sl28cpld" is
>> a made up name - as "sl28cpld-r1" is, too.
> 
> Well that sounds bogus for a start.  I guess that's one of the
> problems with trying to support programmable H/W in S/W.

What sounds bogus? That we name the implementation sl28cpld? How
is that different to like adt7411? Its just a name made up by the
vendor. So if there is a new version of the adt7411 the vendor
might name it adt7412. We name it sl28cpld-r2. So what is the
problem here?

-michael
