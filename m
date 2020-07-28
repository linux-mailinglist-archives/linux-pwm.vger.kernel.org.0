Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7722304C7
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 09:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgG1H5y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 03:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgG1H5x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 03:57:53 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76BC061794;
        Tue, 28 Jul 2020 00:57:53 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A69F222F00;
        Tue, 28 Jul 2020 09:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595923068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5vr5u2CwCzWonURU4FUJ7Qx0KdSzpRO+jGgc5tpaZ4=;
        b=aJnGZRBXgjyowmj1Nw/blJsXNKWHvVlXJjqofsf24qgiRvczfkyVePpySUTExaysc7Ag/E
        3oO2fWhzUREsA8aeFk6XHMA4tXxdT4nGgpTnTuo9BGeHqIJuI/xPzaZSh0/g4QxcMPBSgB
        AEMmw8OIZ8zoAlbuwZ1a09xXi3rYnCQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 09:57:47 +0200
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
In-Reply-To: <20200728072422.GF1850026@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-3-michael@walle.cc> <20200728072422.GF1850026@dell>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <1065b0107ce6fd88b2bdd704bf45346b@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-07-28 09:24, schrieb Lee Jones:
> On Sun, 26 Jul 2020, Michael Walle wrote:
> 
>> Add a device tree bindings for the board management controller found 
>> on
>> the Kontron SMARC-sAL28 board.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> Changes since v5:
>>  - none
>> 
>> Changes since v4:
>>  - fix the regex of the unit-address
>> 
>> Changes since v3:
>>  - see cover letter
>> 
>>  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  54 +++++++
>>  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++++
>>  .../kontron,sl28cpld-intc.yaml                |  54 +++++++
>>  .../bindings/mfd/kontron,sl28cpld.yaml        | 153 
>> ++++++++++++++++++
>>  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
>>  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
>>  6 files changed, 358 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>>  create mode 100644 
>> Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
>>  create mode 100644 
>> Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
>>  create mode 100644 
>> Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
>>  create mode 100644 
>> Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
>>  create mode 100644 
>> Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml 
>> b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>> new file mode 100644
>> index 000000000000..9a63a158a796
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpio/kontron,sl28cpld-gpio.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: GPIO driver for the sl28cpld board management controller
>> +
>> +maintainers:
>> +  - Michael Walle <michael@walle.cc>
>> +
>> +description: |
>> +  This module is part of the sl28cpld multi-function device. For more
>> +  details see 
>> Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
> 
> Paths are normally relative.

grep Documentation/ Documentation

I know there are a lot false positives (esp in the first one)..

$ grep -r "\.\./" Documentation | wc -l
1826
$ grep -r "Documentation/" Documentation|wc -l
2862

> 
>> +  There are three flavors of the GPIO controller, one full featured
>> +  input/output with interrupt support (kontron,sl28cpld-gpio), one
>> +  output-only (kontron,sl28-gpo) and one input-only 
>> (kontron,sl28-gpi).
>> +
>> +  Each controller supports 8 GPIO lines.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - kontron,sl28cpld-gpio
>> +      - kontron,sl28cpld-gpi
>> +      - kontron,sl28cpld-gpo
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>> +  interrupt-controller: true
>> +
>> +  "#gpio-cells":
>> +    const: 2
>> +
>> +  gpio-controller: true
>> +
>> +  gpio-line-names:
>> +      minItems: 1
>> +      maxItems: 8
>> +
>> +required:
>> +  - compatible
>> +  - "#gpio-cells"
>> +  - gpio-controller
>> +
>> +additionalProperties: false
>> diff --git 
>> a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml 
>> b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
>> new file mode 100644
>> index 000000000000..1cebd61c6c32
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
>> @@ -0,0 +1,27 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/kontron,sl28cpld-hwmon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hardware monitoring driver for the sl28cpld board management 
>> controller
>> +
>> +maintainers:
>> +  - Michael Walle <michael@walle.cc>
>> +
>> +description: |
>> +  This module is part of the sl28cpld multi-function device. For more
>> +  details see 
>> Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - kontron,sl28cpld-fan
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> diff --git 
>> a/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml 
>> b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
>> new file mode 100644
>> index 000000000000..4c39e9ff9aea
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: 
>> http://devicetree.org/schemas/interrupt-controller/kontron,sl28cpld-intc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Interrupt controller driver for the sl28cpld board management 
>> controller
>> +
>> +maintainers:
>> +  - Michael Walle <michael@walle.cc>
>> +
>> +description: |
>> +  This module is part of the sl28cpld multi-function device. For more
>> +  details see 
>> Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
>> +
>> +  The following interrupts are available. All types and levels are 
>> fixed
>> +  and handled by the board management controller.
>> +
>> +  ==== ============= ==================================
>> +   IRQ line/device   description
>> +  ==== ============= ==================================
>> +    0  RTC_INT#      Interrupt line from on-board RTC
>> +    1  SMB_ALERT#    Event on SMB_ALERT# line (P1)
>> +    2  ESPI_ALERT0#  Event on ESPI_ALERT0# line (S43)
>> +    3  ESPI_ALERT1#  Event on ESPI_ALERT1# line (S44)
>> +    4  PWR_BTN#      Event on PWR_BTN# line (P128)
>> +    5  SLEEP#        Event on SLEEP# line (S149)
>> +    6  watchdog      Interrupt of the internal watchdog
>> +    7  n/a           not used
>> +  ==== ============= ==================================
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - kontron,sl28cpld-intc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>> +  interrupt-controller: true
>> +
>> +required:
>> +  - compatible
>> +  - interrupts
>> +  - "#interrupt-cells"
>> +  - interrupt-controller
>> +
>> +additionalProperties: false
>> diff --git 
>> a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml 
>> b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
>> new file mode 100644
>> index 000000000000..e3a62db678e7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
>> @@ -0,0 +1,153 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Kontron's sl28cpld board management controller
> 
> "S128CPLD" ?

still not, its sl28cpld, think of a project/code name, not the product
appended with CPLD.

> "Board Management Controller (BMC)" ?

sounds like IPMI, which I wanted to avoid.

> 
>> +maintainers:
>> +  - Michael Walle <michael@walle.cc>
>> +
>> +description: |
>> +  The board management controller may contain different IP blocks 
>> like
>> +  watchdog, fan monitoring, PWM controller, interrupt controller and 
>> a
>> +  GPIO controller.
>> +
>> +properties:
>> +  compatible:
>> +    const: kontron,sl28cpld-r1
> 
> We don't usually code revision numbers in compatible strings.
> 
> Is there any way to pull this from the H/W?

No, unfortunately you can't. And I really want to keep that, in case
in the future there are some backwards incompatible changes.

>> +  reg:
>> +    description:
>> +      I2C device address.
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +patternProperties:
>> +  "^gpio(@[0-9a-f]+)?$":
>> +    $ref: ../gpio/kontron,sl28cpld-gpio.yaml
>> +
>> +  "^hwmon(@[0-9a-f]+)?$":
>> +    $ref: ../hwmon/kontron,sl28cpld-hwmon.yaml
>> +
>> +  "^interrupt-controller(@[0-9a-f]+)?$":
>> +    $ref: ../interrupt-controller/kontron,sl28cpld-intc.yaml
>> +
>> +  "^pwm(@[0-9a-f]+)?$":
>> +    $ref: ../pwm/kontron,sl28cpld-pwm.yaml
>> +
>> +  "^watchdog(@[0-9a-f]+)?$":
>> +    $ref: ../watchdog/kontron,sl28cpld-wdt.yaml
>> +
>> +required:
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        sl28cpld@4a {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            compatible = "kontron,sl28cpld-r1";
>> +            reg = <0x4a>;
> 
> Nit: Could you put the 'reg' and 'compatible' at the top please?
> 
> Same for all nodes.

Sure, I've looked at previous examples, but they are not
consistent, but it looked to me if the "#" properties are
listed first.

-michael
