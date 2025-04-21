Return-Path: <linux-pwm+bounces-5603-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99FDA94EA2
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F2918923A7
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E66255254;
	Mon, 21 Apr 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Bm+qWHlJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9D1D5CD7;
	Mon, 21 Apr 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745227687; cv=none; b=kYgR2ma05VlkJT6nHc3mVt+QYzFiEQ/HgeHqY1FBOGsXebLBngoN3QHAKaQw7Li3ffgQGg0I1df+tVjFgeY3GutlAiJEnglqU99NR7SlSqqlaGxt567DUh/JED3QpppUqOqf9NA24B4ClweMgRAlkt9/vWnfPfuf/CdYC1TYwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745227687; c=relaxed/simple;
	bh=PumI3WcICmUpAGtTG1Q6SsCBiubfiAlEn/ivdaCqqTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxLEbbGM0IH1qGgMH4Xfv+fR3LBwb7YrfPOKK4K6kN97PB3Zid2qD/Nkz2ZdVbLsFzSJV0Fc8XlCPADeKtnZ7O1X78BZKT75GypnVqity8/Dw0NQAUIVPCVmDTLaxzXn6DBRpYmTQInaVlcx169O3OyU2b51bvW5LSDzShgHQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Bm+qWHlJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F3946D5;
	Mon, 21 Apr 2025 11:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745227557;
	bh=PumI3WcICmUpAGtTG1Q6SsCBiubfiAlEn/ivdaCqqTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bm+qWHlJIgoqPPsVUWe+MihMMXKvQ5hV44rmvOv3IrWiUcP/QaBC7sZ1FeYTrjDOh
	 lsr/Og8V88ApCfWAtzasF3nbmQyR7frrfbQUr2O1IW+8BI17XGvIayrGB0crLtEJgZ
	 nD01CfYAnd43txRk/MZznNQhOvw+tv4HCHbjU74U=
Date: Mon, 21 Apr 2025 12:28:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 09/17] dt-bindings: mfd: adp5585: add properties for
 input events
Message-ID: <20250421092802.GG29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-9-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-9-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:25PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
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
>  1 file changed, 186 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index d690a411b3a4307f6dd5f4a432a357e89fefabb0..b7c36e2d4bfc4e75c856a0b8b9c842627bf3b1b2 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -49,6 +49,84 @@ properties:
>    "#pwm-cells":
>      const: 3
>  
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  poll-interval:
> +    enum: [10, 20, 30, 40]
> +    default: 10
> +
> +  adi,keypad-pins:
> +    description: Specifies the pins used for the keypad matrix.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  adi,unlock-keys:
> +    description:
> +      Specifies a maximum of 2 keys that can be used to unlock the keypad.
> +      If this property is set, the keyboard will be locked and only unlocked
> +      after these keys are pressed. The value 127 serves as a wildcard which
> +      means any key can be used for unlocking.

Is this really something that should be set through DT ? Aren't there
use cases for configuring this from userspace ? Same for some of the
other properties below.

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
> @@ -56,11 +134,28 @@ patternProperties:
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
> @@ -68,8 +163,29 @@ allOf:
>              const: adi,adp5585-01
>      then:
>        properties:
> +        adi,unlock-keys: false
> +        adi,unlock-trigger-sec: false
>          gpio-reserved-ranges: false
> -
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
>    - if:
>        properties:
>          compatible:
> @@ -81,6 +197,25 @@ allOf:
>                - adi,adp5585-02
>      then:
>        properties:
> +        adi,unlock-keys: false
> +        adi,unlock-trigger-sec: false
> +        adi,keypad-pins:
> +          minItems: 2
> +          maxItems: 10
> +          items:
> +            enum: [0, 1, 2, 3, 4, 6, 7, 8, 9, 10]
> +        adi,reset1-keys:
> +          items:
> +            anyOf:
> +              - minimum: 1
> +                maximum: 25
> +              - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
> +        adi,reset2-keys:
> +          items:
> +            anyOf:
> +              - minimum: 1
> +                maximum: 25
> +              - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
>          gpio-reserved-ranges:
>            maxItems: 1
>            items:
> @@ -99,11 +234,33 @@ allOf:
>      then:
>        properties:
>          gpio-reserved-ranges: false
> +        adi,keypad-pins:
> +          minItems: 2
> +          maxItems: 19
> +          items:
> +            minimum: 0
> +            maximum: 18
> +        adi,reset1-keys:
> +          items:
> +            anyOf:
> +              - minimum: 1
> +                maximum: 88
> +              - minimum: 97
> +                maximum: 115
> +        adi,reset2-keys:
> +          items:
> +            anyOf:
> +              - minimum: 1
> +                maximum: 88
> +              - minimum: 97
> +                maximum: 115
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
> @@ -119,6 +276,33 @@ examples:
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

-- 
Regards,

Laurent Pinchart

