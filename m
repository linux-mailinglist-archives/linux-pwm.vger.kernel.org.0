Return-Path: <linux-pwm+bounces-5235-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE6A67B1C
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 18:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1329188039D
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F7212D86;
	Tue, 18 Mar 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4VFs7rk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43482212B39;
	Tue, 18 Mar 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319544; cv=none; b=i26aJs4GDKVT9FUHzSzVAo03wQ7q8fKADShP0XNmYi+31pMVf/uBYJlTNio5WUqhoIzU3wrWTpcWMZrwT0E1m0DjQrBInjcylyLXtq5gELLxBnNJVOrFITz9nEJ9qsEJjeUvvj8zJZfjZ41WYtVVWk/V27tF/Ej4NOm34MzBns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319544; c=relaxed/simple;
	bh=RD0JLKRX6PTSdhVgrH66/PsHlVA2+EiFixHfbS53Qb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgBdjvhAEkKJA+MBDRU4rkcCXshRd/szKzDNx4X4dAnOFJN3TE8hHt/4NTiZmB9UxFsujHomN4bGAPJ8+Q/MUbwJo343XiVc4I3hsuQl7iCHWDivbgXxWco3XTZmRZH1+0Yueuw5J9mLD85J4xPZ2bsrmW9Y9hPwwENNP2IfIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4VFs7rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0A9C4CEDD;
	Tue, 18 Mar 2025 17:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742319543;
	bh=RD0JLKRX6PTSdhVgrH66/PsHlVA2+EiFixHfbS53Qb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4VFs7rkfiS6hsYXIVu8zmkn24VKExBemCN5o5Jo4HjlTBUvXXoqM4U1H1lFiSrnz
	 TC0vdJ3xsR7dYXeEbhW/4S2g1EP9BPGwNeWkU4DquIut6UHq+5xUhjXqUaVopVD+8A
	 NobCzGiQ5ERwHpJxTk26qxDburej1W2uKi7ej2RmnVF+DN71jC+/uLL9a6EYuyzQK+
	 1gJSPbwKNXh63FQE0rgnQxe7HyM2gqvhYMzMhBKTzm0wA6HomAAGUVaGtwpOiMsidi
	 F17VRa5UOhyRsSl23YJ/zp5qZa0VebQpk42to8oCKEborSK7qB7sZt2adXxLkEwrP2
	 JiJ6EMTxFw07A==
Date: Tue, 18 Mar 2025 12:39:02 -0500
From: Rob Herring <robh@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 01/11] dt-bindings: mfd: gpio: Add MAX7360
Message-ID: <20250318173902.GA3256960-robh@kernel.org>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-1-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-1-fb20baf97da0@bootlin.com>

On Tue, Mar 18, 2025 at 05:26:17PM +0100, Mathieu Dubois-Briand wrote:
> Add device tree bindings for Maxim Integrated MAX7360 device with
> support for keypad, rotary, gpios and pwm functionalities.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++++++
>  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 170 +++++++++++++++++++++
>  2 files changed, 253 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> new file mode 100644
> index 000000000000..21d603d9504c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/maxim,max7360-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 GPIO controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 GPIO controller, in MAX7360 chipset
> +  https://www.analog.com/en/products/max7360.html
> +
> +  The device provide two series of GPIOs, referred here as GPIOs and GPOs.
> +
> +  PORT0 to PORT7 pins can be used as GPIOs, with support for interrupts and
> +  constant-current mode. These pins will also be used by the torary encoder and
> +  PWM functionalities.
> +
> +  COL2 to COL7 pins can be used as GPOs, there is no input capability. COL pins
> +  will be partitionned, with the first pins being affected to the keypad
> +  functionality and the last ones as GPOs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-gpio
> +      - maxim,max7360-gpo
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  maxim,constant-current-disable:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bit field, each bit disables constant-current output of the associated
> +      GPIO, starting from the least significant bit for the first GPIO.
> +    maximum: 0xff
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - maxim,max7360-gpio
> +        ngpios: false
> +    then:
> +      required:
> +        - interrupt-controller
> +    else:
> +      properties:
> +        interrupt-controller: false
> +        maxim,constant-current-disable: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio {
> +      compatible = "maxim,max7360-gpio";
> +
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      maxim,constant-current-disable = <0x06>;
> +
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> new file mode 100644
> index 000000000000..d3c09531dc5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max7360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 Keypad, Rotary encoder, PWM and GPIO controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 device, with following functions:
> +    - keypad controller
> +    - rotary controller
> +    - GPIO and GPO controller
> +    - PWM controller
> +
> +  https://www.analog.com/en/products/max7360.html
> +
> +allOf:
> +  - $ref: /schemas/input/matrix-keymap.yaml#
> +  - $ref: /schemas/input/input.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: inti
> +      - const: intk
> +
> +  keypad-debounce-delay-ms:

The existing debounce-delay-ms or poll-interval properties don't work 
for you?

> +    description: Keypad debounce delay in ms
> +    minimum: 9
> +    maximum: 40
> +    default: 9
> +
> +  rotary-debounce-delay-ms:
> +    description: Rotary encoder debounce delay in ms
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  linux,axis:
> +    description: The input subsystem axis to map to this rotary encoder.

You should have a $ref to rotary-encoder.yaml too. None of the other 
properties in it are needed? 

> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  gpio:
> +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> +    description:
> +      PORT0 to PORT7 general purpose input/output pins configuration.
> +
> +  gpo:
> +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> +    description: >
> +      COL2 to COL7 general purpose output pins configuration.
> +      Allows to use unused keypad columns as outputs.

Are these paragraphs? If so, add a blank line between paragraphs. If 
not, re-wrap the lines.

> +      The MAX7360 has 8 column lines and 6 of them can be used as GPOs. GPIOs
> +      numbers used for this gpio-controller node do correspond to the column
> +      numbers: values 0 and 1 are never valid, values from 2 to 7 might be valid
> +      depending on the value of the keypad,num-column property.
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: /schemas/pinctrl/pincfg-node.yaml
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          pattern: '^PORT[0-7]|ROTARY$'

Don't you need ()?:

^(PORT[0-7]|ROTARY)$'

> +        minItems: 1
> +        maxItems: 8
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [gpio, pwm, rotary]
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - linux,keymap
> +  - linux,axis
> +  - "#pwm-cells"
> +  - gpio
> +  - gpo
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      io-expander@38 {
> +        compatible = "maxim,max7360";
> +        reg = <0x38>;
> +
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <23 IRQ_TYPE_LEVEL_LOW>,
> +                     <24 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-names = "inti", "intk";
> +
> +        keypad,num-rows = <8>;
> +        keypad,num-columns = <4>;
> +        linux,keymap = <
> +          MATRIX_KEY(0x00, 0x00, KEY_F5)
> +          MATRIX_KEY(0x01, 0x00, KEY_F4)
> +          MATRIX_KEY(0x02, 0x01, KEY_F6)
> +          >;
> +        keypad-debounce-delay-ms = <10>;
> +        autorepeat;
> +
> +        rotary-debounce-delay-ms = <2>;
> +        linux,axis = <0>; /* REL_X */
> +
> +        #pwm-cells = <3>;
> +
> +        max7360_gpio: gpio {
> +          compatible = "maxim,max7360-gpio";
> +
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          maxim,constant-current-disable = <0x06>;
> +
> +          interrupt-controller;
> +          #interrupt-cells = <0x2>;
> +        };
> +
> +        max7360_gpo: gpo {
> +          compatible = "maxim,max7360-gpo";
> +
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +        };
> +
> +        backlight_pins: backlight-pins {
> +          pins = "PORT2";
> +          function = "pwm";
> +        };
> +      };
> +    };
> 
> -- 
> 2.39.5
> 

