Return-Path: <linux-pwm+bounces-2207-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7668CB3FF
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAC3B24268
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396D14900E;
	Tue, 21 May 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I75bpz/Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CD69DF7;
	Tue, 21 May 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318357; cv=none; b=D7s2jVTYsI2h/i+f51HW0gGfUDutpoxEVYAfBhZ1yFPxMtOgsmSgRhoDWMp+GUdBgnowKlmUNZ0FOEUo8PLPiTYGShdAc4W+Q4qSPYbq2qI/KIH+IWbVeG2EQiN8ssLWtAbrGQKVyTAzWnov3G+0VTmJ6oK5TFlX/Lz2qjME0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318357; c=relaxed/simple;
	bh=q2yoRuIo85m8Z6ImV81l45Ie2jVyv8NbcTBVXQYNINE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMKVaNoWetLmWgziKCtcMlcTdI6KnMwg8ZVIveL+ZZw7lQY8OmBkeDNwGRtuOi0N1qJDlx7EChf0J+wOwRgwE2DfCxUvqZGH5AYLeW1u0GZADIviWvso0+yikTEg+TSTxF//udw49E1d78GtKf956mcA6y5+kO4IDYewpR41wCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I75bpz/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF26C2BD11;
	Tue, 21 May 2024 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716318356;
	bh=q2yoRuIo85m8Z6ImV81l45Ie2jVyv8NbcTBVXQYNINE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I75bpz/ZrJBhtuMHBG9w8pGgtZBKngSo1hzZjyrTF9hTbZStSyaaa0OXO7aaCWFW9
	 XZUWM9AlFsDXJxB6wfq2gRpjAT3ODKd9xCnZCQOPCd1XoaF/DAaMtwQDQ9ylUzNQYN
	 Tsz5uVMvpMXzJscDB/CmyfH5Ov7rQT0ARV8gS10QjpXKVBjIldAOvYvd1drtPasKD6
	 /3eL42gGNe7FRk8HJiea8XobXZ+2QGi4An928gX9we6rdabY6EWgTGenbC0zRBA3qk
	 722Dui0BA+KRe45YFH8ZLl5QkD68AFIKXgXc1KzS4viOZQYl7sR5LCsAGrWRamlxKN
	 65oIrFA3ex4pw==
Message-ID: <11a383f3-a6db-4de7-a5f8-2938c69e98fc@kernel.org>
Date: Tue, 21 May 2024 21:05:50 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: Add bindings for the Analog Devices
 ADP5585
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2024 21:59, Laurent Pinchart wrote:
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> These bindings model the device as an MFD, and support the GPIO expander
> and PWM functions.
> 
> These bindings support the GPIO and PWM functions.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> I've limited the bindings to GPIO and PWM as I lack hardware to design,
> implement and test the rest of the features the chip supports.
> ---
>  .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++++++++++++
>  .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
>  MAINTAINERS                                   |   7 ++
>  4 files changed, 195 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> new file mode 100644
> index 000000000000..210e4d53e764
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADP5585 GPIO Expander
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +
> +description: |
> +  The Analog Devices ADP5585 has up to 11 GPIOs represented by a "gpio" child
> +  node of the parent MFD device. See
> +  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further details as
> +  well as an example.
> +
> +properties:
> +  compatible:
> +    const: adi,adp5585-gpio
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-reserved-ranges: true

There are no resources here, so new compatible is not really warranted.
Squash the node into parent.

> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> new file mode 100644
> index 000000000000..217c038b2842
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADP5585 Keypad Decoder and I/O Expansion
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The ADP5585 is a 10/11 input/output port expander with a built in keypad
> +  matrix decoder, programmable logic, reset generator, and PWM generator.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - adi,adp5585-00  # Default
> +          - adi,adp5585-01  # 11 GPIOs
> +          - adi,adp5585-02  # No pull-up resistors by default on special pins
> +          - adi,adp5585-03  # Alternate I2C address
> +          - adi,adp5585-04  # Pull-down resistors on all pins by default
> +      - const: adi,adp5585
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  gpio:
> +    $ref: /schemas/gpio/adi,adp5585-gpio.yaml
> +
> +  pwm:
> +    $ref: /schemas/pwm/adi,adp5585-pwm.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio
> +  - pwm
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,adp5585-01
> +    then:
> +      properties:
> +        gpio:
> +          properties:
> +            gpio-reserved-ranges: false

This also points to fact your child node is pointless. It does not stand
on its own...

> +    else:
> +      properties:
> +        gpio:
> +          properties:
> +            gpio-reserved-ranges:
> +              items:
> +                - const: 5
> +                - const: 1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mfd@34 {
> +            compatible = "adi,adp5585-00", "adi,adp5585";
> +            reg = <0x34>;
> +
> +            gpio {
> +                compatible = "adi,adp5585-gpio";
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                gpio-reserved-ranges = <5 1>;
> +            };
> +
> +            pwm {
> +                compatible = "adi,adp5585-pwm";
> +                #pwm-cells = <3>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mfd@34 {
> +            compatible = "adi,adp5585-01", "adi,adp5585";
> +            reg = <0x34>;
> +
> +            vdd-supply = <&reg_3v3>;
> +
> +            gpio {
> +                compatible = "adi,adp5585-gpio";
> +                gpio-controller;
> +                #gpio-cells = <2>;

Different by one property? So just keep one example, unless there are
more differences.

> +            };
> +
> +            pwm {
> +                compatible = "adi,adp5585-pwm";
> +                #pwm-cells = <3>;
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml b/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> new file mode 100644
> index 000000000000..351a9d5da566
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/adi,adp5585-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADP5585 PWM Generator
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Analog Devices ADP5585 generates a PWM output with configurable frequency
> +  and duty cycle represented by a "pwm" child node of the parent MFD device.
> +  See Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further
> +  details as well as an example.
> +
> +allOf:
> +  - $ref: /schemas/pwm/pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adp5585-pwm
> +
> +  "#pwm-cells":
> +    const: 3

Also no resources, so this can be part of the parent node.



Best regards,
Krzysztof


