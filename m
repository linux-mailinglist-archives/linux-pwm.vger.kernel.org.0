Return-Path: <linux-pwm+bounces-2208-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002258CB45C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 21:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2234D1C2240D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE71514885C;
	Tue, 21 May 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D+CeS+gJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1427433AD;
	Tue, 21 May 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320602; cv=none; b=Hq+9z6ZmZpltpT8jEHUo203N9VnS8uM6r5OFJIuP231ZCUKxu2By+Miaz1JyLkxvWEmRKeJpLu0/JDWzubYFwbhQ1gO+i+Vuh9uTLYY+f2UraHWfU0VBAE8tlLdfzoBZA3u14HaWI79u/HTBrZUAzWK37xocnrW7wGlh96C1MWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320602; c=relaxed/simple;
	bh=6GWHtegSVvL3L0DC6XS+r+/hqyotmvJxS0QqwcXV5nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkr1wCFme0B7NRxLusQ6WV1wEbK/K/GwnaSAZlQCeb2iyxNUrCObDW/IUENF/YMvtOF8DvoNqRnnuVR0mdDrB4nwLG8JZ4qDJwk/JFMwOWkrxtXWKhe103KfDZjtsQcV0ybrbFFCcX/96/Ocqs9pwg6DGPiRpqeRdmr+E66Ricc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=D+CeS+gJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 674FEC8E;
	Tue, 21 May 2024 21:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716320586;
	bh=6GWHtegSVvL3L0DC6XS+r+/hqyotmvJxS0QqwcXV5nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+CeS+gJqF/hgy30UsprUq0Gu1iilZYeB6vN8Tc+iOsWhppRztMj1DSpyLFh/i7iA
	 BS3+d+W7+HuaNODKhXJV4meWQ6G1+kVzz6S1QUXgGPRWuRo8dVipfbXuWftIxjSAFE
	 JlceWhfoJ1mnC956vYe8eHRY/fA5l9oab3nZ5o44=
Date: Tue, 21 May 2024 22:43:09 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: Add bindings for the Analog Devices
 ADP5585
Message-ID: <20240521194309.GA8863@pendragon.ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
 <11a383f3-a6db-4de7-a5f8-2938c69e98fc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11a383f3-a6db-4de7-a5f8-2938c69e98fc@kernel.org>

Hi Krzysztof,

On Tue, May 21, 2024 at 09:05:50PM +0200, Krzysztof Kozlowski wrote:
> On 20/05/2024 21:59, Laurent Pinchart wrote:
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > These bindings model the device as an MFD, and support the GPIO expander
> > and PWM functions.
> > 
> > These bindings support the GPIO and PWM functions.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > I've limited the bindings to GPIO and PWM as I lack hardware to design,
> > implement and test the rest of the features the chip supports.
> > ---
> >  .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
> >  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++++++++++++
> >  .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
> >  MAINTAINERS                                   |   7 ++
> >  4 files changed, 195 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> > new file mode 100644
> > index 000000000000..210e4d53e764
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADP5585 GPIO Expander
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +
> > +description: |
> > +  The Analog Devices ADP5585 has up to 11 GPIOs represented by a "gpio" child
> > +  node of the parent MFD device. See
> > +  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further details as
> > +  well as an example.
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,adp5585-gpio
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +
> > +  gpio-reserved-ranges: true
> 
> There are no resources here, so new compatible is not really warranted.
> Squash the node into parent.

Child nodes seem (to me) to be the standard way to model functions in
MFD devices. Looking at mfd_add_device(), for OF-based systems, the
function iterates over child nodes. I don't mind going a different
routes, could you indicate what you have in mind, perhaps pointing to an
existing driver as an example ?

> > +
> > +required:
> > +  - compatible
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +
> > +additionalProperties: false
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > new file mode 100644
> > index 000000000000..217c038b2842
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADP5585 Keypad Decoder and I/O Expansion
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +
> > +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +  The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > +  matrix decoder, programmable logic, reset generator, and PWM generator.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - adi,adp5585-00  # Default
> > +          - adi,adp5585-01  # 11 GPIOs
> > +          - adi,adp5585-02  # No pull-up resistors by default on special pins
> > +          - adi,adp5585-03  # Alternate I2C address
> > +          - adi,adp5585-04  # Pull-down resistors on all pins by default
> > +      - const: adi,adp5585
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  gpio:
> > +    $ref: /schemas/gpio/adi,adp5585-gpio.yaml
> > +
> > +  pwm:
> > +    $ref: /schemas/pwm/adi,adp5585-pwm.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - gpio
> > +  - pwm
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,adp5585-01
> > +    then:
> > +      properties:
> > +        gpio:
> > +          properties:
> > +            gpio-reserved-ranges: false
> 
> This also points to fact your child node is pointless. It does not stand
> on its own...

That doesn't make the child pointless just for that reason. There are
numerous examples of child nodes that don't stand on their own.

> > +    else:
> > +      properties:
> > +        gpio:
> > +          properties:
> > +            gpio-reserved-ranges:
> > +              items:
> > +                - const: 5
> > +                - const: 1
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        mfd@34 {
> > +            compatible = "adi,adp5585-00", "adi,adp5585";
> > +            reg = <0x34>;
> > +
> > +            gpio {
> > +                compatible = "adi,adp5585-gpio";
> > +                gpio-controller;
> > +                #gpio-cells = <2>;
> > +                gpio-reserved-ranges = <5 1>;
> > +            };
> > +
> > +            pwm {
> > +                compatible = "adi,adp5585-pwm";
> > +                #pwm-cells = <3>;
> > +            };
> > +        };
> > +    };
> > +
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        mfd@34 {
> > +            compatible = "adi,adp5585-01", "adi,adp5585";
> > +            reg = <0x34>;
> > +
> > +            vdd-supply = <&reg_3v3>;
> > +
> > +            gpio {
> > +                compatible = "adi,adp5585-gpio";
> > +                gpio-controller;
> > +                #gpio-cells = <2>;
> 
> Different by one property? So just keep one example, unless there are
> more differences.

I found the two examples useful during development of the binding to
test the gpio-reserved-ranges rule (I got it wrong in the first place,
and the dt schema validator told me), but I'm fine dropping one of the
two.

> > +            };
> > +
> > +            pwm {
> > +                compatible = "adi,adp5585-pwm";
> > +                #pwm-cells = <3>;
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml b/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> > new file mode 100644
> > index 000000000000..351a9d5da566
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/adi,adp5585-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADP5585 PWM Generator
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +
> > +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +  The Analog Devices ADP5585 generates a PWM output with configurable frequency
> > +  and duty cycle represented by a "pwm" child node of the parent MFD device.
> > +  See Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further
> > +  details as well as an example.
> > +
> > +allOf:
> > +  - $ref: /schemas/pwm/pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adp5585-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 3
> 
> Also no resources, so this can be part of the parent node.

I'll sure follow the same design for the GPIO and PWM functions :-)
Let's answer the above question first.

-- 
Regards,

Laurent Pinchart

