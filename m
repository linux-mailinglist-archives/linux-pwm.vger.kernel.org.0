Return-Path: <linux-pwm+bounces-4622-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA28A101C5
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DD93A4399
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEE2500C1;
	Tue, 14 Jan 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSDQUTLK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4F2500B0;
	Tue, 14 Jan 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842294; cv=none; b=WF8jR+zUMq6RLIOhckyf83qSAlRt3TImbt+z/l8/E7Mwd8x9GZ8s2yNfIM4/d7QHg+ZXw+hkwaG0qcL4K52JhWNIMZL9GQFagj5+vr5p4HOEWyoMBPlKE0RIHmEz0jtZZI516NI2iNcrH/DL/O9vXwfk5OTSwXwmbbL4H9Y6dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842294; c=relaxed/simple;
	bh=iiO05K3Bxxi9dSe08vcscT16JO/vw8lUwAhzAZKYWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9/e+QLOcwSqwtG642srBKJLfH1KInGajTInIXNmK2S+WBO3ag1vwcvhH9jMXyELfL3x5oHPhRJoC9Xbstg3KmYk8HPjK/+AZQ16BTJG9reuUfvHtQgO0Wv2jEKKAC0UHkOL2y1yYbMJCAponPXSJjhJFbRpDg4tqxDGAHhYJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSDQUTLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA81C4CEDD;
	Tue, 14 Jan 2025 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736842294;
	bh=iiO05K3Bxxi9dSe08vcscT16JO/vw8lUwAhzAZKYWNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSDQUTLK93tuwOlPYS+6GQ6ms41EHH4/N6CewjGCJomnrvtwuVXNbNAUTlLQCIOhV
	 vt7dJhwlh1qyk/gBQRwG3zHgEhUGPzf2j5gaz/Vqha+tUodxoBMgDpYwz8BqGIQSyG
	 Vot2mIZoGpU3YSQ5ZB71W4EGLImKO7wBokVnYxWWdpW0RYkuN/gc6yVStStmkUNlLv
	 FGH6Y7D/trhAqu/72vNRijkEfFvVv2UBBG4RN/h5PtToDYVH5u0XuW1MC9QBqaAod4
	 cRq4hjKrpYJ5dmiL4RNTTzLE0t46saoPKGJ/uCaMbkSS7G8tdwqO5eXBic7wNI4hcE
	 X2unBGrRZ+5bA==
Date: Tue, 14 Jan 2025 09:11:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: mfd: gpio: Add MAX7360
Message-ID: <gerivs3f3gd3a227tu3ojn6wi6l2fbtwvw4q6n4k5aaqqupyya@xojqkp6nkrkb>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-1-9519b4acb0b1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-mdb-max7360-support-v3-1-9519b4acb0b1@bootlin.com>

On Mon, Jan 13, 2025 at 01:42:25PM +0100, Mathieu Dubois-Briand wrote:
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  maxim,constant-current-disable:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: >

Drop >

> +      Bit field, each bit disables constant-current output of the associated
> +      GPIO, starting from the least significant bit for the first GPIO.

maximum: 0xff?

> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - ngpios
> +

allOf: here, so you won't re-indent it later.

> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - maxim,max7360-gpio
> +then:
> +  required:
> +    - interrupt-controller
> +else:
> +  properties:
> +    interrupt-controller: false
> +    maxim,constant-current-disable: false
> +
> +    ngpios:
> +      maximum: 6
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
> +      ngpios = <8>;
> +      maxim,constant-current-disable = <0x06>;
> +
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };

...

> +  interrupt-names:
> +    items:
> +      - const: inti
> +      - const: intk
> +
> +  keypad-debounce-delay-ms:
> +    description: Keypad debounce delay in ms
> +    minimum: 9
> +    maximum: 40
> +    default: 9
> +
> +  autorepeat: true

Drop, not needed.

> +
> +  rotary-debounce-delay-ms:
> +    description: Rotary encoder debounce delay in ms
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  linux,axis:
> +    description: The input subsystem axis to map to this rotary encoder.

Missing type. I guess you wanted to reference rotary encoder schema,
next to input and matrix-keymap?

> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  gpio:
> +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> +    description: >

Drop >

> +      PORT0 to PORT7 general purpose input/output pins configuration.
> +
> +  gpo:
> +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> +    description: >

Drop >

> +      COL2 to COL7 general purpose output pins configuration.
> +      Allows to use unused keypad columns as outputs.
> +      The MAX7360 has 8 column lines and 6 of them can be used as GPOs. Value
> +      of ngpios must be coherent with the value of keypad,num-columns, as their
> +      sum must not exceed the number of physical lines.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - linux,keymap
> +  - linux,axis
> +  - "#pwm-cells"

gpio and gpo nodes are optional? How would the driver behave? I assume
you need to define the partition between GPIOs, especially that 'ngpios'
are a required property in their schema.

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
> +          ngpios = <8>;
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
> +          ngpios = <4>;
> +        };
> +      };
> +    };
> 
> -- 
> 2.39.5
> 

