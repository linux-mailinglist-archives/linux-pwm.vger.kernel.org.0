Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065E53C7977
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jul 2021 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhGMWR1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 18:17:27 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:40868 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbhGMWR0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 18:17:26 -0400
Received: by mail-io1-f47.google.com with SMTP id l5so29153647iok.7;
        Tue, 13 Jul 2021 15:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpU6tfEd13P9yTBdvZdhGhlLt5ObHps/ZkeBp0WE0QA=;
        b=WzXeyk5idb10YtXdVHcIc1VFDKztbKiJGOynvqU1W1eoZTo/butXACmF284sv4DI48
         eEwfKgpEfBS6I0v3cqn1jJLULunHHjce+a7Ofk3hT/K0zjAi0xmvT051NFq0KchJ4CIA
         lM3Zf2pKPLalVxwFxVTXBL5LiYTzdJI5+PbbGOa7xhqYUWlmfFLojkG+pSYnYEoTMx/g
         pWYcyKbDmYhJ6Lum09iTLX3Kv0rsxUvy29HZNqcuBXGU58HLPBk2M5e9JA16dgdVEXA+
         AF4lfz91XM/IVhV8piqR0CLG6k689wHgW/rVDED5q7FKbfV7CtgdIDdhZSiN5LxBhhpb
         hRNw==
X-Gm-Message-State: AOAM532LCx6VxbzZ9giri8b1OwtLA2zZvoB+2eP5feqOdlpXVd4H6DXN
        Lac1A+UficgaxJp6HZ8vYw==
X-Google-Smtp-Source: ABdhPJzuVTo5lRZxqxJXVtSulqUkfqAXPBFkEEpwR+JcZEG4LgbqZ7v6QYhqAItUH3hRjVsS4lroTA==
X-Received: by 2002:a05:6638:3882:: with SMTP id b2mr6002780jav.15.1626214475237;
        Tue, 13 Jul 2021 15:14:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z22sm73610iog.13.2021.07.13.15.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:14:34 -0700 (PDT)
Received: (nullmailer pid 941748 invoked by uid 1000);
        Tue, 13 Jul 2021 22:14:31 -0000
Date:   Tue, 13 Jul 2021 16:14:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v9 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Message-ID: <20210713221431.GA936073@robh.at.kernel.org>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709065217.6153-2-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 09, 2021 at 02:52:16PM +0800, Billy Tsai wrote:
> This patch adds device binding for aspeed pwm-tach device which is a
> multi-function device include pwm and tach function and pwm/tach device
> bindings which should be the child-node of pwm-tach device.

I'll say it again, the fan control h/w needs some common bindings for 
describing fans and fan connections to pwm and tach. I'm not going to 
sign off on more fan bindings just doing their own thing.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 69 +++++++++++++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 87 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 64 ++++++++++++++
>  3 files changed, 220 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..a08471f96a61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 16 fan input.
> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  pinctrl-0: true
> +
> +  pinctrl-names:
> +    const: default
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties:
> +  type: object
> +  properties:
> +    reg:
> +      description:
> +        The tach channel used for this fan.
> +      maxItems: 1
> +
> +    aspeed,min-rpm:
> +      description:
> +        define the minimal revolutions per minute of the measure fan
> +        used to calculate the sample period of tach
> +      default: 1000
> +
> +    aspeed,pulse-pr:
> +      description:
> +        Value specifying the number of pulses per revolution of the
> +        monitored FAN.
> +      default: 2
> +
> +    aspeed,tach-div:
> +      description:
> +        define the tachometer clock divider as an integer. Formula of
> +        tach clock = clock source / (2^tach-div)^2
> +      minimum: 0
> +      maximum: 15
> +      # The value that should be used if the property is not present
> +      default: 5
> +
> +  required:
> +    - reg
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..ab49aff1928a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM Tach controller Device Tree Bindings
> +
> +description: |
> +  The PWM Tach controller is represented as a multi-function device which
> +  includes:
> +    PWM
> +    Tach
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2600-pwm-tach
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +patternProperties:
> +  "^pwm(@[0-9a-f]+)?$":
> +    $ref: ../pwm/aspeed,ast2600-pwm.yaml
> +
> +  "^tach(@[0-9a-f]+)?$":
> +    $ref: ../hwmon/aspeed,ast2600-tach.yaml
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    pwm_tach: pwm_tach@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
> +      reg = <0x1e610000 0x100>;
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      resets = <&syscon ASPEED_RESET_PWM>;
> +
> +      pwm: pwm {
> +        compatible = "aspeed,ast2600-pwm";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #pwm-cells = <3>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_pwm0_default>;
> +        pwm-ch@0 {
> +          reg = <0>;
> +          aspeed,wdt-reload-enable;
> +          aspeed,wdt-reload-duty-point = <32>;
> +        };
> +      };
> +
> +      tach: tach {
> +        compatible = "aspeed,ast2600-tach";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_tach0_default>;
> +        tach-ch@0 {
> +          reg = <0>;
> +          aspeed,min-rpm = <1000>;
> +          aspeed,pulse-pr = <2>;
> +          aspeed,tach-div = <5>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> new file mode 100644
> index 000000000000..f501f8a769df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 PWM controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed PWM controller can support upto 16 PWM outputs.
> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pwm
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  pinctrl-0: true
> +
> +  pinctrl-names:
> +    const: default
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties:
> +  description: Set extend properties for each pwm channel.
> +  type: object
> +  properties:
> +    reg:
> +      description:
> +        The pwm channel index.
> +      maxItems: 1
> +
> +    aspeed,wdt-reload-enable:
> +      type: boolean
> +      description:
> +        Enable the function of wdt reset reload duty point.
> +
> +    aspeed,wdt-reload-duty-point:
> +      description:
> +        Define the duty point after wdt reset, 0 = 100%
> +      minimum: 0
> +      maximum: 255
> +
> +  required:
> +    - reg
> -- 
> 2.25.1
> 
> 
