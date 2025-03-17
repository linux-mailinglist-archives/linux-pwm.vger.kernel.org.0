Return-Path: <linux-pwm+bounces-5208-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6AA656D0
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 16:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5325018953DC
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1621991CF;
	Mon, 17 Mar 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ratPUe7I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89B16DEB1;
	Mon, 17 Mar 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226782; cv=none; b=QRYtp/ODoG51H4/BoMy5Ju3ujnJP63YmVpMhLS8LeA48zexEZ6nRqqVVuAOpCbPNPNgi/O0BjYOBBUw4bum4M4NmKmqvhqEOs6rwDanpABmHPJCnCViKkbNZ+mlCfzEygp9/ZcCJIkCFNwGPLPXMvhZg4FNTZWCv/ei0HxDuP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226782; c=relaxed/simple;
	bh=I4KiVVHC5g1m2cFhjhHnsy8qLJknEwLQDwed2imfmnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyBbuzDhWdtwAVfX6duh4mpgLbtH6S+EIrDECxn8dUAQnK/WYCHrszMrFeRTD8cR6xeLgf4igRAsI1rtzoTdyUFH5alClY8EeuPUqNl/DaT9z7QscJgDKxDQW5597gUVzRtxY/oArbusQrV1AX5/DlnnC06nBmsy/giCF4X3Iis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ratPUe7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9730AC4CEE3;
	Mon, 17 Mar 2025 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742226781;
	bh=I4KiVVHC5g1m2cFhjhHnsy8qLJknEwLQDwed2imfmnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ratPUe7INMUI9VoydGNNTxUXZzpJ1WbD/MmC+Y2ESLHNk2w/ViH44RDbLy1+1C5FT
	 oUg1w3ua9XLZGqJAcitld3fUOMKxk+KvQyBR1ruIGPC2MD3UzOfzJa98vgX/hx8VLW
	 jKvRDUNUP97feARLQAESpLQ2KC0cfdKnklHn5bZf8yfkScnF4oS31XP4P7Br/VDxGp
	 LoLV7v8yQ72VoDpH+/ABydDosXXWxulOZ22KgeEhy4zSiOwXrrS22ZaO8PZUvBROYg
	 iSNGnrbQRKjbts2SRnnLNBFcgjPSdfwmdF16xKViulsogOjcP3rp/J4/49llYg126c
	 6awtQvmueYmRw==
Date: Mon, 17 Mar 2025 10:53:00 -0500
From: Rob Herring <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 09/18] dt-bindings: mfd: adp5585: add properties for
 input events
Message-ID: <20250317155300.GA4188705-robh@kernel.org>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
 <20250313-dev-adp5589-fw-v1-9-20e80d4bd4ea@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-dev-adp5589-fw-v1-9-20e80d4bd4ea@analog.com>

On Thu, Mar 13, 2025 at 02:19:26PM +0000, Nuno Sá wrote:
> Add properties related to input events. These devices can act as
> keyboards and can support events either via a keymap Matrix or through
> GPIs. Note that the device needs to be an interrupt controller for GPIs
> based events.
> 
> We specifically need a property specifying the pins used by the keymap
> matrix since these devices have no requirement for rows and columns to be
> contiguous without holes which is enforced by the standard input
> properties.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/mfd/adi,adp5585.yaml       | 188 ++++++++++++++++++++-
>  1 file changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index 87256a37b5f4b6a019f581b164c276d8805d2e52..e976c9240df79afae1d0949e6ac91d477bfaceef 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -49,6 +49,85 @@ properties:
>    "#pwm-cells":
>      const: 3
>  
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  adi,keypad-pins:
> +    description: Specifies the pins used for the keypad matrix.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

I would would assume there's a minimum of 3 pins (unless someone wants 
to implement 1 key with 2 pins) and a maximum number of pins the chip 
supports. And what about constraints on the values of each entry?

> +
> +  adi,key-poll-ms:
> +    description: Configure time between consecutive scan cycles.
> +    enum: [10, 20, 30, 40]
> +    default: 10

Use the common property "poll-interval".

> +
> +  adi,unlock-keys:
> +    description:
> +      Specifies a maximum of 2 keys that can be used to unlock the keypad.
> +      If this property is set, the keyboard will be locked and only unlocked
> +      after these keys are pressed. The value 127 serves as a wildcard which
> +      means any key can be used for unlocking.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      anyOf:
> +        - minimum: 1
> +          maximum: 88
> +        - minimum: 97
> +          maximum: 115
> +        - const: 127
> +
> +  adi,unlock-trigger-sec:
> +    description:
> +      Defines the time in which the second unlock event must occur after the
> +      first unlock event has occurred.
> +    maximum: 7
> +    default: 0
> +
> +  adi,reset1-keys:
> +    description:
> +      Defines the trigger events (key presses) that can generate reset
> +      conditions one the reset1 block.

Are these in raw key values or keymap values?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 3
> +
> +  adi,reset2-keys:
> +    description:
> +      Defines the trigger events (key presses) that can generate reset
> +      conditions one the reset2 block.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +
> +  adi,reset1-active-high:
> +    description: Sets the reset1 signal as active high.
> +    type: boolean
> +
> +  adi,reset2-active-high:
> +    description: Sets the reset2 signal as active high.
> +    type: boolean
> +
> +  adi,rst-passtrough-enable:
> +    description: Allows the RST pin to override (OR with) the reset1 signal.
> +    type: boolean
> +
> +  adi,reset-trigger-ms:
> +    description:
> +      Defines the length of time that the reset events must be active before a
> +      reset signal is generated. All events must be active at the same time for
> +      the same duration.
> +    enum: [0, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
> +    default: 0
> +
> +  adi,reset-pulse-width-us:
> +    description: Defines the pulse width of the reset signals.
> +    enum: [500, 1000, 2000, 10000]
> +    default: 500
> +
>  patternProperties:
>    "-hog(-[0-9]+)?$":
>      type: object
> @@ -56,11 +135,28 @@ patternProperties:
>      required:
>        - gpio-hog
>  
> +dependencies:
> +  linux,keymap:
> +    - adi,keypad-pins
> +    - interrupts
> +  interrupt-controller:
> +    - interrupts
> +  adi,unlock-trigger-sec:
> +    - adi,unlock-keys
> +  adi,reset1-active-high:
> +    - adi,reset1-keys
> +  adi,rst-passtrough-enable:
> +    - adi,reset1-keys
> +  adi,reset2-active-high:
> +    - adi,reset2-keys
> +
>  required:
>    - compatible
>    - reg
>  
>  allOf:
> +  - $ref: /schemas/input/matrix-keymap.yaml#
> +  - $ref: /schemas/input/input.yaml#
>    - if:
>        properties:
>          compatible:
> @@ -68,7 +164,29 @@ allOf:
>              const: adi,adp5585-01
>      then:
>        properties:
> +        adi,unlock-keys: false
> +        adi,unlock-trigger-sec: false
>          gpio-reserved-ranges: false
> +        adi,keypad-pins:
> +          minItems: 2
> +          maxItems: 11
> +          items:
> +            minimum: 0
> +            maximum: 10
> +        adi,reset1-keys:
> +          items:
> +            anyOf:
> +              - minimum: 1
> +                maximum: 30
> +              - minimum: 37
> +                maximum: 47
> +        adi,reset2-keys:
> +          items:
> +            anyOf:
> +              - minimum: 1
> +                maximum: 30
> +              - minimum: 37
> +                maximum: 47
>      else:
>        if:
>          properties:
> @@ -81,6 +199,25 @@ allOf:
>                  - adi,adp5585-04
>        then:
>          properties:
> +          adi,unlock-keys: false
> +          adi,unlock-trigger-sec: false
> +          adi,keypad-pins:
> +            minItems: 2
> +            maxItems: 10
> +            items:
> +              enum: [0, 1, 2, 3, 4, 6, 7, 8, 9, 10]
> +          adi,reset1-keys:
> +            items:
> +              anyOf:
> +                - minimum: 1
> +                  maximum: 25
> +                - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
> +          adi,reset2-keys:
> +            items:
> +              anyOf:
> +                - minimum: 1
> +                  maximum: 25
> +                - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
>            gpio-reserved-ranges:
>              maxItems: 1
>              items:
> @@ -90,11 +227,33 @@ allOf:
>        else:
>          properties:
>            gpio-reserved-ranges: false
> +          adi,keypad-pins:
> +            minItems: 2
> +            maxItems: 19
> +            items:
> +              minimum: 0
> +              maximum: 18
> +          adi,reset1-keys:
> +            items:
> +              anyOf:
> +                - minimum: 1
> +                  maximum: 88
> +                - minimum: 97
> +                  maximum: 115
> +          adi,reset2-keys:
> +            items:
> +              anyOf:
> +                - minimum: 1
> +                  maximum: 88
> +                - minimum: 97
> +                  maximum: 115
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -110,6 +269,33 @@ examples:
>              gpio-reserved-ranges = <5 1>;
>  
>              #pwm-cells = <3>;
> +
> +            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio>;
> +
> +            adi,reset1-keys = <1 43>;
> +            adi,reset2-keys = <2 3>;
> +            adi,reset-trigger-ms = <2000>;
> +
> +            /*
> +             * col0, col1, col2
> +             * row0, row1, row2
> +             */
> +            adi,keypad-pins = <0 1 2 6 7 8>;
> +
> +            linux,keymap = <
> +                MATRIX_KEY(0x00, 0x00, KEY_1)
> +                MATRIX_KEY(0x00, 0x01, KEY_2)
> +                MATRIX_KEY(0x00, 0x02, KEY_3)
> +
> +                MATRIX_KEY(0x01, 0x00, KEY_A)
> +                MATRIX_KEY(0x01, 0x01, KEY_B)
> +                MATRIX_KEY(0x01, 0x02, KEY_C)
> +
> +                MATRIX_KEY(0x02, 0x00, BTN_1)
> +                MATRIX_KEY(0x02, 0x01, BTN_2)
> +                MATRIX_KEY(0x02, 0x02, BTN_3)
> +            >;
>          };
>      };
>  
> 
> -- 
> 2.48.1
> 

