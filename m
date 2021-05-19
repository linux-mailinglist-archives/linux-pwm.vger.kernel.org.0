Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1CD3897BB
	for <lists+linux-pwm@lfdr.de>; Wed, 19 May 2021 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhESUV2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 May 2021 16:21:28 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:45632 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESUV2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 May 2021 16:21:28 -0400
Received: by mail-oo1-f48.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so3280093oop.12;
        Wed, 19 May 2021 13:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oz0/YJoURbTznyuffRuq6rxLXJB3zz/sK4EYSBr8mLY=;
        b=OOEShmnhiovPxO+OO9NVy2omtbHcBtEejBsU3r0s9rBeBnSMmEm3Ksca+Kr+7pNGf/
         jkGDNJx6axltd8KhhbpdnhxFmI3MzkeXdsu6qvXp63ClvNSOw7Zw0l+n6J7/byiFB0HM
         TYSbuRrtI1YrIB8M20rP6IyFy5uQtP7A/XXRD1TKNqSugz1rqekVPioxnRWU1ACwF9c2
         rowGJLsVQZWx5VF1K06vYNrkOeH2VLzzg0u9ujeIrKzVoj+2AUVHICfQQRA/eUqCQ/Hn
         Kwbbrl7/ivQ2V5JQYtezH/wOS8fnd0TBajbECkM2UJIfETfjjpZlST8rQo+QcZ56tvfr
         vCjw==
X-Gm-Message-State: AOAM532x0eiL90MMuwjkurQlqn+/sADRG6z7/8A/MkqTUsaZ1ue8tnmn
        rnyA4SCNJ929QuOPBKv0jQ==
X-Google-Smtp-Source: ABdhPJzwDeL/mPSqrfMjTmz4S1736w7fy206SUD7bP0L+IkZ5uj8fKlE2OjvqnyAK60okuQVFpiiWA==
X-Received: by 2002:a4a:cb95:: with SMTP id y21mr944381ooq.68.1621455607464;
        Wed, 19 May 2021 13:20:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p1sm181095otk.58.2021.05.19.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:20:06 -0700 (PDT)
Received: (nullmailer pid 3580694 invoked by uid 1000);
        Wed, 19 May 2021 20:20:04 -0000
Date:   Wed, 19 May 2021 15:20:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v6 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Message-ID: <20210519202004.GA3566127@robh.at.kernel.org>
References: <20210518005517.9036-1-billy_tsai@aspeedtech.com>
 <20210518005517.9036-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518005517.9036-2-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, May 18, 2021 at 08:55:16AM +0800, Billy Tsai wrote:
> This patch adds device binding for aspeed pwm-tach device which is a
> multi-function device include pwm and tach function and pwm/tach device
> bindings which should be the child-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 66 +++++++++++++++
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 84 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 62 ++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..0b23281e9f5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 ASPEED, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED Tach controller can support upto 16 fan input.
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

blank line between each DT property sub-schema please.

> +    aspeed,min-rpm:
> +      description:
> +        define the minimal revolutions per minute of the measure fan
> +        used to calculate the sample period of tach
> +      default: 1000
> +    aspeed,pulse-pr:
> +      description:
> +        Value specifying the number of pulses per revolution of the
> +        monitored FAN.
> +      default: 2
> +    aspeed,tach-div:
> +      description:
> +        define the tachometer clock divider as an integer. Formula of
> +        tach clock = clock source / (2^tach-div)^2
> +      minimum: 0
> +      maximum: 15
> +      # The value that should be used if the property is not present
> +      default: 5
> +  required:
> +    - reg
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..d742ccfcc003
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 ASPEED, Inc.
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
> +  reg:
> +    maxItems: 1
> +  clocks:
> +    maxItems: 1
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

Normally, you configure the PWM on the client side, not the producer 
side.

> +        };
> +      };
> +
> +      tach: tach {
> +        compatible = "aspeed,ast2600-tach";

Are pwm and tach separate h/w blocks? 

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_tach0_default>;
> +        fan@0 {
> +          reg = <0>;

How does one configure which PWM is connected to each fan?

Existing bindings use 'reg' for PWM channel and another property for 
tach channel. Please don't do something different.

> +          aspeed,min-rpm = <1000>;
> +          aspeed,pulse-pr = <2>;
> +          aspeed,tach-div = <5>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> new file mode 100644
> index 000000000000..f1354c8d35b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 ASPEED, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2600 PWM controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support upto 16 PWM outputs.
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
> +    aspeed,wdt-reload-enable:
> +      type: boolean
> +      description:
> +        Enable the function of wdt reset reload duty point.
> +    aspeed,wdt-reload-duty-point:
> +      description:
> +        Define the duty point after wdt reset, 0 = 100%
> +      minimum: 0
> +      maximum: 255
> +  required:
> +    - reg
> -- 
> 2.25.1
> 
