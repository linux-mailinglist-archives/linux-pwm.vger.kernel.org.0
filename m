Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D41230403
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgG1HY2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgG1HY1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 03:24:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D73CC0619D4
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 00:24:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so13654238wrm.12
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VdDZUU19qDZriJhUPGfcHbxuvpV2FWI8A0HgGKJC8cE=;
        b=Saa0mQjox5IT+8LfzWTLzBs0DOwcNR3klvP5AWtzHNk7EWcIipa72zTeOo994dvRQV
         7EK35DniAH0F3H3tqnDuyoEArGmJaM0UmuXv5R3MKoDSk3Jj3mkq34SbSIzScGw4uW1N
         pySsiw7d1/IvjfSSSrr4bALHIo1uOtGagEMhmeQ8fRyrCfqHcPGVIkgXOFf5QUEJYkQD
         ESHjDesdqoRfsDU5hnYBWT+4UtC5Fk//lpi8BxyZbfAZEM/uuNckvOOnlEpbGdSab9N2
         0Hmqr2tT26F2aTqBihBu50iq45WnAnFlt80+CkewyAsKcanfk1oMsecQOGXaiXUtFOxZ
         Wddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VdDZUU19qDZriJhUPGfcHbxuvpV2FWI8A0HgGKJC8cE=;
        b=h8GvTC2ca1Gvo/etm9sEgC1QPA97djnjR9zKiDLua4EPH/QsnfRLn1JXt7ii7v0xDl
         sIODaAdEyya6WMlafrsjL9RC+QPJ/asqDVxEcbBCJ6S5bjqidg9z2nCxV8ZefcpDw55H
         Mib5m0tqyhKHMwUwUKdjrGYPBhUgNLnEj4kkVlf8zLK+6rBbVWdLOoDlhJjlmse90W18
         5mMY3Zkw5+PWFz0x7x97JvK6llQqgTphWING/PWHJGq6bBjtuG539tkmSfsTLs6R5E3X
         aVII7i5N6B3btGgp67hByNZKlIru5TZ9YXglqPPyNRVapo42EOu3XDBUyyWAx8fFCsyK
         RNyw==
X-Gm-Message-State: AOAM532/VmBe7jCK3W7FKiIqvFphXtHwxlftVBnum4oDiyD/mXI5GNUQ
        4PZO2QNWcI6YlB4CB2OaYDExiFdvvmk=
X-Google-Smtp-Source: ABdhPJwB5lXf9X1lh58EpA+mJMTPPubl1qt2FH6w/NK2sDnGtN6tzav1weWuj/7BTnRqhEOJQPC7Jw==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr23431063wrj.336.1595921065647;
        Tue, 28 Jul 2020 00:24:25 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id b18sm15907130wrs.46.2020.07.28.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 00:24:24 -0700 (PDT)
Date:   Tue, 28 Jul 2020 08:24:22 +0100
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
Message-ID: <20200728072422.GF1850026@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200725231834.25642-3-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 26 Jul 2020, Michael Walle wrote:

> Add a device tree bindings for the board management controller found on
> the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v5:
>  - none
> 
> Changes since v4:
>  - fix the regex of the unit-address
> 
> Changes since v3:
>  - see cover letter
> 
>  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  54 +++++++
>  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++++
>  .../kontron,sl28cpld-intc.yaml                |  54 +++++++
>  .../bindings/mfd/kontron,sl28cpld.yaml        | 153 ++++++++++++++++++
>  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
>  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
>  6 files changed, 358 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>  create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
>  create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> new file mode 100644
> index 000000000000..9a63a158a796
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/kontron,sl28cpld-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO driver for the sl28cpld board management controller
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  This module is part of the sl28cpld multi-function device. For more
> +  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.

Paths are normally relative.

> +  There are three flavors of the GPIO controller, one full featured
> +  input/output with interrupt support (kontron,sl28cpld-gpio), one
> +  output-only (kontron,sl28-gpo) and one input-only (kontron,sl28-gpi).
> +
> +  Each controller supports 8 GPIO lines.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - kontron,sl28cpld-gpio
> +      - kontron,sl28cpld-gpi
> +      - kontron,sl28cpld-gpo
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  gpio-line-names:
> +      minItems: 1
> +      maxItems: 8
> +
> +required:
> +  - compatible
> +  - "#gpio-cells"
> +  - gpio-controller
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
> new file mode 100644
> index 000000000000..1cebd61c6c32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/kontron,sl28cpld-hwmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hardware monitoring driver for the sl28cpld board management controller
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  This module is part of the sl28cpld multi-function device. For more
> +  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - kontron,sl28cpld-fan
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
> new file mode 100644
> index 000000000000..4c39e9ff9aea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/kontron,sl28cpld-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Interrupt controller driver for the sl28cpld board management controller
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  This module is part of the sl28cpld multi-function device. For more
> +  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
> +
> +  The following interrupts are available. All types and levels are fixed
> +  and handled by the board management controller.
> +
> +  ==== ============= ==================================
> +   IRQ line/device   description
> +  ==== ============= ==================================
> +    0  RTC_INT#      Interrupt line from on-board RTC
> +    1  SMB_ALERT#    Event on SMB_ALERT# line (P1)
> +    2  ESPI_ALERT0#  Event on ESPI_ALERT0# line (S43)
> +    3  ESPI_ALERT1#  Event on ESPI_ALERT1# line (S44)
> +    4  PWR_BTN#      Event on PWR_BTN# line (P128)
> +    5  SLEEP#        Event on SLEEP# line (S149)
> +    6  watchdog      Interrupt of the internal watchdog
> +    7  n/a           not used
> +  ==== ============= ==================================
> +
> +properties:
> +  compatible:
> +    enum:
> +      - kontron,sl28cpld-intc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> new file mode 100644
> index 000000000000..e3a62db678e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kontron's sl28cpld board management controller

"S128CPLD" ?

"Board Management Controller (BMC)" ?

> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  The board management controller may contain different IP blocks like
> +  watchdog, fan monitoring, PWM controller, interrupt controller and a
> +  GPIO controller.
> +
> +properties:
> +  compatible:
> +    const: kontron,sl28cpld-r1

We don't usually code revision numbers in compatible strings.

Is there any way to pull this from the H/W?

> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +patternProperties:
> +  "^gpio(@[0-9a-f]+)?$":
> +    $ref: ../gpio/kontron,sl28cpld-gpio.yaml
> +
> +  "^hwmon(@[0-9a-f]+)?$":
> +    $ref: ../hwmon/kontron,sl28cpld-hwmon.yaml
> +
> +  "^interrupt-controller(@[0-9a-f]+)?$":
> +    $ref: ../interrupt-controller/kontron,sl28cpld-intc.yaml
> +
> +  "^pwm(@[0-9a-f]+)?$":
> +    $ref: ../pwm/kontron,sl28cpld-pwm.yaml
> +
> +  "^watchdog(@[0-9a-f]+)?$":
> +    $ref: ../watchdog/kontron,sl28cpld-wdt.yaml
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sl28cpld@4a {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "kontron,sl28cpld-r1";
> +            reg = <0x4a>;

Nit: Could you put the 'reg' and 'compatible' at the top please?

Same for all nodes.

> +            watchdog@4 {
> +                compatible = "kontron,sl28cpld-wdt";
> +                reg = <0x4>;
> +                kontron,assert-wdt-timeout-pin;
> +            };
> +
> +            hwmon@b {
> +                compatible = "kontron,sl28cpld-fan";
> +                reg = <0xb>;
> +            };
> +
> +            pwm@c {
> +                #pwm-cells = <2>;
> +                compatible = "kontron,sl28cpld-pwm";
> +                reg = <0xc>;
> +            };
> +
> +            pwm@e {
> +                #pwm-cells = <2>;
> +                compatible = "kontron,sl28cpld-pwm";
> +                reg = <0xe>;
> +            };
> +
> +            gpio@10 {
> +                compatible = "kontron,sl28cpld-gpio";
> +                reg = <0x10>;
> +                interrupts-extended = <&gpio2 6
> +                               IRQ_TYPE_EDGE_FALLING>;
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                gpio-line-names = "a", "b", "c";
> +
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +
> +            gpio@15 {
> +                compatible = "kontron,sl28cpld-gpio";
> +                reg = <0x15>;
> +                interrupts-extended = <&gpio2 6
> +                               IRQ_TYPE_EDGE_FALLING>;
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +
> +            gpio@1a {
> +                compatible = "kontron,sl28cpld-gpo";
> +                reg = <0x1a>;
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            gpio@1b {
> +                compatible = "kontron,sl28cpld-gpi";
> +                reg = <0x1b>;
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            interrupt-controller@1c {
> +                compatible = "kontron,sl28cpld-intc";
> +                reg = <0x1c>;
> +                interrupts-extended = <&gpio2 6
> +                               IRQ_TYPE_EDGE_FALLING>;
> +
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +        };
> +    };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
