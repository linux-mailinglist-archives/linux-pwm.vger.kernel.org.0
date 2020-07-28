Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07487230550
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgG1I1M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 04:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgG1I1M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 04:27:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C91C0619D7
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 01:27:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so10363616wmi.1
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uGdSTLXzLPoQW4Vv8n7QiN3IXRkY2j1N9K5+wvpg67A=;
        b=Qhg6T58aAmKWjza2llHFtcN/M5ktqlCBTRyY1BmuOUBUdpKwrXhpz5iTJ+7+tiz7Z8
         V7n08jcrpM9bhjhsNch1R3b8038XgvDYN4L4lofGSiCZro7bCM2IEHqIlGck39tEouUZ
         A4r3xC4z/eB4g2zUV7A83vu3lTrDaA9wh5L6Z1W2fU8ATi/A5bBKcqTmWGXnlGh0Nf6y
         GQYntzxG6o4GCGfR+Ozuy99qbQ1co4mdt+HUnTWNGpXgu3F2G7sBHTHUUfYhG4gEfXtG
         vCSiH0h4kn4XTvDSo8UU0KwWmMz++xzcD+srqkyl4/3SY3U3JJRBkzLPQ5tjvgVw0sIS
         Dgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uGdSTLXzLPoQW4Vv8n7QiN3IXRkY2j1N9K5+wvpg67A=;
        b=pz1O06pYaAZP4e/rTMnwcghVqMnTuE0dtF+2eTYMVzhg6mgZURg7Js+CC+qvvn6uZF
         u4OJ7+Ka9a/ATIYcPitDTzNIBHRmqfySOG/APvkjGl+/lwezowUP/U5dNEKhFrU9c2kA
         8U6p69rQlJNQuPlkn8Zk2parr0vvtjIl+4bj3vMFEM2XAu3X+Z7zkgPxVVqsDc5Y87p5
         HtEOPm6ZRoWeLXmKhWFzPT1exl0/MyNer35gOTFPIlDQGanGXkRUUS65EHt2RWOt+2Gf
         4UKIlcza4SO9tvb13CIJdOvKsbO43KzJy74eOYaahKLhTqWqWnljYbHbaCVo1Ubq42Tz
         ybKw==
X-Gm-Message-State: AOAM53182cFaDRyPzdpqqhDKYESN7PIFBXAw8wnLAlPgpnQH4lFX7yV/
        xzcivIuBAN8NCDmn/XFOgLGsfQ==
X-Google-Smtp-Source: ABdhPJxOdhDnn+eNqujllDon1GsS0dEIq8GDpDLR1DsQSiCtVl87rdAMEtcC8WUAdFNx/vl1MVi7VA==
X-Received: by 2002:a1c:b007:: with SMTP id z7mr2792839wme.37.1595924829954;
        Tue, 28 Jul 2020 01:27:09 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id s205sm3405256wme.7.2020.07.28.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 01:27:09 -0700 (PDT)
Date:   Tue, 28 Jul 2020 09:27:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
Message-ID: <20200728082707.GB2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-3-michael@walle.cc>
 <20200728072422.GF1850026@dell>
 <1065b0107ce6fd88b2bdd704bf45346b@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1065b0107ce6fd88b2bdd704bf45346b@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 28 Jul 2020, Michael Walle wrote:

> Am 2020-07-28 09:24, schrieb Lee Jones:
> > On Sun, 26 Jul 2020, Michael Walle wrote:
> > 
> > > Add a device tree bindings for the board management controller found
> > > on
> > > the Kontron SMARC-sAL28 board.
> > > 
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changes since v5:
> > >  - none
> > > 
> > > Changes since v4:
> > >  - fix the regex of the unit-address
> > > 
> > > Changes since v3:
> > >  - see cover letter
> > > 
> > >  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  54 +++++++
> > >  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++++
> > >  .../kontron,sl28cpld-intc.yaml                |  54 +++++++
> > >  .../bindings/mfd/kontron,sl28cpld.yaml        | 153
> > > ++++++++++++++++++
> > >  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
> > >  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
> > >  6 files changed, 358 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> > > b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> > > new file mode 100644
> > > index 000000000000..9a63a158a796
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> > > @@ -0,0 +1,54 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/gpio/kontron,sl28cpld-gpio.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: GPIO driver for the sl28cpld board management controller
> > > +
> > > +maintainers:
> > > +  - Michael Walle <michael@walle.cc>
> > > +
> > > +description: |
> > > +  This module is part of the sl28cpld multi-function device. For more
> > > +  details see
> > > Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
> > 
> > Paths are normally relative.
> 
> grep Documentation/ Documentation
> 
> I know there are a lot false positives (esp in the first one)..
> 
> $ grep -r "\.\./" Documentation | wc -l
> 1826
> $ grep -r "Documentation/" Documentation|wc -l
> 2862

I actually meant just for Device Tree bindings, but it does appear
that 'Documentation' is used a bunch there too.

My reasons for not liking full paths is that the intention was always
to move 'Documentation/devicetree' to a new location outside of the
kernel source tree.

[...]

> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Kontron's sl28cpld board management controller
> > 
> > "S128CPLD" ?
> 
> still not, its sl28cpld, think of a project/code name, not the product
> appended with CPLD.
> 
> > "Board Management Controller (BMC)" ?
> 
> sounds like IPMI, which I wanted to avoid.

Is there a datasheet?

> > > +maintainers:
> > > +  - Michael Walle <michael@walle.cc>
> > > +
> > > +description: |
> > > +  The board management controller may contain different IP blocks
> > > like
> > > +  watchdog, fan monitoring, PWM controller, interrupt controller
> > > and a
> > > +  GPIO controller.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: kontron,sl28cpld-r1
> > 
> > We don't usually code revision numbers in compatible strings.
> > 
> > Is there any way to pull this from the H/W?
> 
> No, unfortunately you can't. And I really want to keep that, in case
> in the future there are some backwards incompatible changes.

Rob,

I know you reviewed this already, but you can give your opinion on
this specifically please?  I know that we have pushed back on this in
the past.


-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
