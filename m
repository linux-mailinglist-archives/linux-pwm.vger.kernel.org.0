Return-Path: <linux-pwm+bounces-4448-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C46819FA27A
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Dec 2024 21:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228C5163D4C
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Dec 2024 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27161C5F27;
	Sat, 21 Dec 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLvAk3/S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AB1C5F06;
	Sat, 21 Dec 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734813268; cv=none; b=grVOu/CO0vAbRhH83LJX9xWxsJ5mJ/uq0tJ72j4iZKeINbbnQVUizHJ1vEs2xe7LbSnLLNgjrZXndkMJO+Hr3SH6VCXXUgoF8veyEKJFbjpz7d6L/gMXuqAwoEgD0IwarYzbwc4hvFOi6XrB5M++UTFyW6Cpkun4fIAkwrzhhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734813268; c=relaxed/simple;
	bh=m8vLiyX2tNz+6CdcUKD+Mmd7VXLnsKgjXcaAoZ8jlyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0ZdbUzHv8Wx10Mqfoh7T5FRGOLD0BX1pjMo+z/UaLPLt+9tsKrA8/K2gEF6Z91U54dA5LrKSR/vujAEWiGibLM8CyBspklrpGDKuwhlmLv0yh1kwQmh8OQxwRN4nSkD3v6yTUpghif/8vjA5TQfqcuZU6PXBL+5lnyF8qUaXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLvAk3/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996D6C4CECE;
	Sat, 21 Dec 2024 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734813268;
	bh=m8vLiyX2tNz+6CdcUKD+Mmd7VXLnsKgjXcaAoZ8jlyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aLvAk3/Sig9s2wKapU9fwUMi1ssuKBdrhFz4nAzdAdKNdayKsSvygwfq9VUwUuDaC
	 mEM+cwkQFi6PyCvsHYkdWxIwbeC6tIopjafbmbg2DE5hCywTlQd0L3c0AGJ1R3eHCW
	 FBqUep5u+ttpLciqKjJGrNgTLpbuHQ4X2wAoN0L+yOernC2W5yqt6XjmmoBTsHGx9I
	 +kGDfwobHcsnoNKjKAkLF28jbrVkJ2DbhopSO5VK5qvE0zyKO96AN4i9KjRzRVzbuo
	 aCcUHxDm6h+zPSUuyuIW5Sz7m+3zVTP7altc01wdc53olXIwW0vvcetbGcYrRP8oQw
	 5pVg69ScoxFlw==
Message-ID: <58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.org>
Date: Sat, 21 Dec 2024 21:34:17 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: Add MAX7360 subdevices
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-2-8e8317584121@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241219-mdb-max7360-support-v1-2-8e8317584121@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2024 17:21, Mathieu Dubois-Briand wrote:
> ---
>  .../devicetree/bindings/gpio/max7360-gpio.yaml     | 96 ++++++++++++++++++++++
>  .../devicetree/bindings/input/max7360-keypad.yaml  | 67 +++++++++++++++
>  .../devicetree/bindings/input/max7360-rotary.yaml  | 52 ++++++++++++
>  .../devicetree/bindings/pwm/max7360-pwm.yaml       | 35 ++++++++
>  4 files changed, 250 insertions(+)


I don't understand how this patchset was split. MFD binding cannot be
empty and cannot be before child devices.

All filenames are wrong here: use compatibles.


> 
> diff --git a/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
> new file mode 100644
> index 000000000000..3c006dc0380b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/max7360-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 GPIO controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 GPIO controller, in MAX7360 MFD
> +  https://www.analog.com/en/products/max7360.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-gpio
> +      - maxim,max7360-gpo

Why? What are the differences?

> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  ngpios:
> +    minimum: 0
> +    maximum: 8

Why this is flexible?

> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts:
> +    description: The interrupt line the device is connected to.

Drop

> +    maxItems: 1
> +
> +  constant-current-disable:

You always need vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Bit field, each bit disables constant-current output of the
> +                 associated GPIO.

Oddly aligned.

Missing constraints.

> +
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - ngpios
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - maxim,max7360-gpio
> +then:
> +  required:
> +    - interrupt-controller
> +    - interrupts
> +else:
> +  properties:
> +    interrupt-controller: false
> +    interrupts: false
> +    constant-current-disable: false
> +
> +    ngpios:
> +      maximum: 6
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    max7360_gpo: max7360_gpo {

Plaese follow DTS coding style.

Keep only one, complete example.

> +            compatible = "maxim,max7360-gpo";
> +            gpio-controller;
> +            #gpio-cells = <0x2>;
> +            ngpios = <4>;

Odd indentation. Your MFD patch had very different one.

> +    };
> +
> +    max7360_gpio: max7360_gpio {
> +            compatible = "maxim,max7360-gpio";
> +
> +            gpio-controller;
> +            #gpio-cells = <0x2>;
> +            ngpios = <8>;
> +            constant-current-disable = <0x06>;
> +
> +            interrupt-controller;
> +            #interrupt-cells = <0x2>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
> +    };
> diff --git a/Documentation/devicetree/bindings/input/max7360-keypad.yaml b/Documentation/devicetree/bindings/input/max7360-keypad.yaml
> new file mode 100644
> index 000000000000..8bc3c841465b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/max7360-keypad.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/max7360-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 Keypad Controller
> +
> +maintainers:
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 Keypad Controller, in MAX7360 MFD
> +  https://www.analog.com/en/products/max7360.html
> +
> +allOf:
> +  - $ref: matrix-keymap.yaml#
> +  - $ref: input.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-keypad
> +
> +  interrupts:
> +    description: The interrupt line the device is connected to.


Really? Each separate device has its own interrupt line? How is it
possible if diagram here:
https://www.analog.com/en/products/max7360.html

has only one interrupt?

Fold the binding into the parent node.


> +    maxItems: 1
> +
> +  debounce-delay-ms:
> +    description: Debounce delay in ms
> +    minimum: 9
> +    maximum: 40
> +    default: 9
> +
> +  linux,input-no-autorepeat:
> +    description: If present, the keys will not autorepeat when pressed
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - linux,keymap
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/input/input.h>
> +
> +    max7360_keypad {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Please read and follow DTS coding style.

> +      compatible = "maxim,max7360-keypad";
> +
> +      keypad,num-rows = <8>;
> +      keypad,num-columns = <4>;
> +
> +      linux,keymap = <
> +        MATRIX_KEY(0x00, 0x00, KEY_F5)
> +        MATRIX_KEY(0x01, 0x00, KEY_F4)
> +        MATRIX_KEY(0x02, 0x01, KEY_F6)
> +        >;
> +
> +      interrupt-parent = <&gpio1>;
> +      interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
> +
> +      debounce-delay-ms = <10>;
> +      linux,input-no-autorepeat;
> +    };
> diff --git a/Documentation/devicetree/bindings/input/max7360-rotary.yaml b/Documentation/devicetree/bindings/input/max7360-rotary.yaml
> new file mode 100644
> index 000000000000..19afa8344249
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/max7360-rotary.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/max7360-rotary.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 Rotary Encoder
> +
> +maintainers:
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 Rotary Encoder, in MAX7360 MFD
> +  https://www.analog.com/en/products/max7360.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-rotary
> +
> +  interrupts:
> +    description: The interrupt line the device is connected to.
> +    maxItems: 1
> +
> +  debounce-delay-ms:
> +    description: Debounce delay in ms
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  linux,axis:
> +    description: The input subsystem axis to map to this rotary encoder.
> +

Fold into parent node.

> +description: |
> +  Maxim MAX7360 PWM controller, in MAX7360 MFD
> +  https://www.analog.com/en/products/max7360.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-pwm
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +


Fold into parent.



Best regards,
Krzysztof

