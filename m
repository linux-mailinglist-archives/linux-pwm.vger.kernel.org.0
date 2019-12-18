Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0E1257FF
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2019 00:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRXw4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Dec 2019 18:52:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43255 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLRXw4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Dec 2019 18:52:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so4619877oth.10;
        Wed, 18 Dec 2019 15:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upTnIcIu5vXgr/U3LW+h6pgWAnb1nRIxYnJwMc85zdo=;
        b=LXpsiD4oTKbrYqn8/GHCGICohWfGDI30nIOme0JHO5Vkl7mU1a2n/2DAW/TKCQbxZg
         WguUtlX69KI1MM9JB/EAkLwYwTvjU/1zwCjJj/5bsJ6DI9vXVNE8oqbZpQ7Lv3cMv2Nc
         1DDmiB0f77TzCLqk3AWkp9FDCIwWg6mjT2gN8M3opjHbBlCaBALzRzjA7Y2IBkFHaAHe
         cSEdTV/D73rYElK2J1sWcx2Fh7dSVJjBg0FKjwD9QJnSp4Antgn0JDiwbIcJje74gcQf
         g2xgVCET5KT+maK1KlAvEDhlnxu32fPvh8HRj+hJfOBa8QI/WVaFSIuit1tC+tHVKzLw
         1+hw==
X-Gm-Message-State: APjAAAXNmwm/bcntuXGk0n8pzMOwvdZf45A83SpeaW20mNK9TIx5lNVe
        Ca0lmpP49m9VqXfBf9RGLQ==
X-Google-Smtp-Source: APXvYqyyri2C2KUfkCWtaDSlXF3NDr5pX9GjBMF7k4cC2tFr+H6V5d6jbaP0Cat8KCIYFYChKIS/yA==
X-Received: by 2002:a05:6830:20cf:: with SMTP id z15mr5461285otq.277.1576713173789;
        Wed, 18 Dec 2019 15:52:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 4sm1457087otu.0.2019.12.18.15.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:52:53 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:52:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20191218235252.GA19438@bogus>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-2-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575851866-18919-2-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 09, 2019 at 12:38:32AM +0000, Jeff LaBundy wrote:
> This patch adds device tree bindings for the Azoteq IQS620A, IQS621,
> IQS622, IQS624 and IQS625 multi-function sensors.
> 
> A total of three bindings are presented (one MFD and two child nodes);
> they are submitted as a single patch because the child node bindings
> have no meaning in the absence of the MFD binding.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
> Changes in v2:
>   - Removed "prox" child node and moved "keys" and "pwm" child nodes to their
>     own bindings
>   - Replaced linux,fw-file property with more common firmware-name property
>   - Converted all bindings to YAML

Good job for first go.

> 
>  .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 +++++++++++++++
>  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 +++++++++++++++++++++
>  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 ++++
>  3 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml

A couple of minor things below. With those fixed:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> new file mode 100644
> index 0000000..e9b54e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/iqs62x-keys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Azoteq IQS620A/621/622/624/625 Keys and Switches
> +
> +maintainers:
> +  - Jeff LaBundy <jeff@labundy.com>
> +
> +description: |
> +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sensors
> +  feature a variety of self-capacitive, mutual-inductive and Hall-effect sens-
> +  ing capabilities that can facilitate a variety of contactless key and switch
> +  applications.
> +
> +  These functions are collectively represented by a "keys" child node from the
> +  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs62x.yaml for
> +  further details and examples. Sensor hardware configuration (self-capacitive
> +  vs. mutual-inductive, etc.) is selected based on the device's firmware.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - azoteq,iqs620a-keys
> +      - azoteq,iqs621-keys
> +      - azoteq,iqs622-keys
> +      - azoteq,iqs624-keys
> +      - azoteq,iqs625-keys
> +
> +  linux,keycodes:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 16
> +    description: |
> +      Specifies the numeric keycodes associated with each available touch or
> +      proximity event according to the following table. An 'x' indicates the
> +      event is supported for a given device. Specify 0 for unused events.
> +
> +      -------------------------------------------------------------------------
> +      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS624 | IQS625 |
> +      -------------------------------------------------------------------------
> +      | 0  | CH0 Touch          |    x    |    x   |    x   |    x   |    x   |
> +      |    | Antenna 1 Touch*   |    x    |        |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x   |    x   |
> +      |    | Antenna 1 Prox.*   |    x    |        |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 2  | CH1 Touch          |    x    |    x   |    x   |    x   |    x   |
> +      |    | Ant. 1 Deep Touch* |    x    |        |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x   |    x   |
> +      -------------------------------------------------------------------------
> +      | 4  | CH2 Touch          |    x    |        |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 5  | CH2 Proximity      |    x    |        |        |        |        |
> +      |    | Antenna 2 Prox.*   |    x    |        |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 6  | Metal (+) Touch**  |    x    |    x   |        |        |        |
> +      |    | Ant. 2 Deep Touch* |    x    |        |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 7  | Metal (+) Prox.**  |    x    |    x   |        |        |        |
> +      |    | Antenna 2 Touch*   |    x    |        |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 8  | Metal (-) Touch**  |    x    |    x   |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 9  | Metal (-) Prox.**  |    x    |    x   |        |        |        |
> +      -------------------------------------------------------------------------
> +      | 10 | SAR Active***      |    x    |        |    x   |        |        |
> +      -------------------------------------------------------------------------
> +      | 11 | SAR Quick Rel.***  |    x    |        |    x   |        |        |
> +      -------------------------------------------------------------------------
> +      | 12 | SAR Movement***    |    x    |        |    x   |        |        |
> +      -------------------------------------------------------------------------
> +      | 13 | SAR Filter Halt*** |    x    |        |    x   |        |        |
> +      -------------------------------------------------------------------------
> +      | 14 | Wheel Up           |         |        |        |    x   |        |
> +      -------------------------------------------------------------------------
> +      | 15 | Wheel Down         |         |        |        |    x   |        |
> +      -------------------------------------------------------------------------
> +      *   Two-channel SAR. Replaces CH0-2 plus metal touch and proximity events
> +          if enabled via firmware.
> +      **  "+" and "-" refer to the polarity of a channel's delta (LTA - counts),
> +          where "LTA" is defined as the channel's long-term average.
> +      *** One-channel SAR. Replaces CH0-2 touch and proximity events if enabled
> +          via firmware.
> +
> +required:
> +  - compatible
> +  - linux,keycodes

Add: 

additionalProperties: false

> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - azoteq,iqs620a-keys
> +          - azoteq,iqs621-keys
> +          - azoteq,iqs622-keys
> +then:
> +  patternProperties:
> +    "^hall-switch-(north|south)$":
> +      type: object
> +      description:
> +        Represents north/south-field Hall-effect sensor touch or proximity
> +        events. Note that north/south-field orientation is reversed on the
> +        IQS620AXzCSR device due to its flip-chip package.
> +
> +      properties:
> +        linux,code:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description: Numeric switch code associated with the event.
> +
> +        azoteq,use-prox:
> +          $ref: /schemas/types.yaml#/definitions/flag
> +          description:
> +            If present, specifies that Hall-effect sensor reporting should
> +            use the device's wide-range proximity threshold instead of its
> +            close-range touch threshold (default).
> +
> +      required:
> +        - linux,code
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
> new file mode 100644
> index 0000000..24e6004
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/iqs62x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
> +
> +maintainers:
> +  - Jeff LaBundy <jeff@labundy.com>
> +
> +description: |
> +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sensors
> +  integrate multiple sensing technologies in a single package.
> +
> +  Link to data sheets: https://www.azoteq.com/
> +
> +properties:
> +  compatible:
> +    enum:
> +      - azoteq,iqs620a
> +      - azoteq,iqs621
> +      - azoteq,iqs622
> +      - azoteq,iqs624
> +      - azoteq,iqs625
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Specifies the name of the calibration and configuration file selected by
> +      the driver. If this property is omitted, the name is chosen based on the
> +      device name with ".bin" as the extension (e.g. iqs620a.bin for IQS620A).
> +
> +  keys:
> +    $ref: ../input/iqs62x-keys.yaml
> +
> +  pwm:
> +    $ref: ../pwm/iqs620a-pwm.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

Add: 

additionalProperties: false

> +
> +examples:
> +  - |
> +    /*
> +     * Dual capacitive buttons with additional "air button," unipolar lid
> +     * switch and panel-mounted LED.
> +     */
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            iqs620a@44 {
> +                    compatible = "azoteq,iqs620a";
> +                    reg = <0x44>;
> +                    interrupt-parent = <&gpio>;
> +                    interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +
> +                    keys {
> +                            compatible = "azoteq,iqs620a-keys";
> +
> +                            linux,keycodes = <KEY_SELECT>,
> +                                             <KEY_MENU>,
> +                                             <KEY_OK>,
> +                                             <KEY_MENU>;
> +
> +                            hall-switch-south {
> +                                    linux,code = <SW_LID>;
> +                                    azoteq,use-prox;
> +                            };
> +                    };
> +
> +                    iqs620a_pwm: pwm {
> +                            compatible = "azoteq,iqs620a-pwm";
> +                            #pwm-cells = <2>;
> +                    };
> +            };
> +    };
> +
> +    pwmleds {
> +            compatible = "pwm-leds";
> +
> +            panel {
> +                    pwms = <&iqs620a_pwm 0 1000000>;
> +                    max-brightness = <255>;
> +            };
> +    };
> +
> +  - |
> +    /* Single inductive button with bipolar dock/tablet-mode switch. */
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            iqs620a@44 {
> +                    compatible = "azoteq,iqs620a";
> +                    reg = <0x44>;
> +                    interrupt-parent = <&gpio>;
> +                    interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +
> +                    firmware-name = "iqs620a_coil.bin";
> +
> +                    keys {
> +                            compatible = "azoteq,iqs620a-keys";
> +
> +                            linux,keycodes = <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <KEY_MUTE>;
> +
> +                            hall-switch-north {
> +                                    linux,code = <SW_DOCK>;
> +                            };
> +
> +                            hall-switch-south {
> +                                    linux,code = <SW_TABLET_MODE>;
> +                            };
> +                    };
> +            };
> +    };
> +
> +  - |
> +    /* Dual capacitive buttons with volume knob. */
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            iqs624@44 {
> +                    compatible = "azoteq,iqs624";
> +                    reg = <0x44>;
> +                    interrupt-parent = <&gpio>;
> +                    interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +
> +                    keys {
> +                            compatible = "azoteq,iqs624-keys";
> +
> +                            linux,keycodes = <BTN_0>,
> +                                             <0>,
> +                                             <BTN_1>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <0>,
> +                                             <KEY_VOLUMEUP>,
> +                                             <KEY_VOLUMEDOWN>;
> +                    };
> +            };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> new file mode 100644
> index 0000000..6b7aaef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/iqs620a-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Azoteq IQS620A PWM Generator
> +
> +maintainers:
> +  - Jeff LaBundy <jeff@labundy.com>
> +
> +description: |
> +  The Azoteq IQS620A multi-function sensor generates a fixed-frequency PWM
> +  output represented by a "pwm" child node from the parent MFD driver. See
> +  Documentation/devicetree/bindings/mfd/iqs62x.yaml for further details as
> +  well as an example.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - azoteq,iqs620a-pwm
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"

Add: 

additionalProperties: false

> +
> +...
> --
> 2.7.4
> 
