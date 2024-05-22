Return-Path: <linux-pwm+bounces-2217-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1798CBBE3
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 09:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5832B2173B
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65BF7BAE3;
	Wed, 22 May 2024 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ndi6oztd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FC79B84;
	Wed, 22 May 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362558; cv=none; b=PZjDct+smYByrxVin499DDv37q3KNh6Ae0VsvL4D9M9qP8FpxPXQqRbrEPWovPHtUFGycsfzEr2S94lRI21kMEw9AyvRL/3ScF13xBSo8wAxEJooql9oOEk679ko+5XEhyhiQdhK5pU87bdeZW8L0pWx0X9lDucZ23gHuHeOvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362558; c=relaxed/simple;
	bh=+gQoZVjTvnl9vfPUcSZnq0UdJRBPKKt9+VqX3W+fyGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnpkNrrjrWX+D0Gy5+GbQsyE/PlOzMab4rquvgEOk5TlmGuPQA3hX5/nYUpiYFXNs76Q1jfdOBhzrPovZGokyjj4b280fjR7TawTWjNVE/7GeIPuQ2L039B0trwdbwFwZvkWrf25jfB6XTsrgCJxdnjHcJO7XFk6fnvCocA+OpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ndi6oztd; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A8AD0581;
	Wed, 22 May 2024 09:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716362541;
	bh=+gQoZVjTvnl9vfPUcSZnq0UdJRBPKKt9+VqX3W+fyGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ndi6oztds2yWefxeeLePVRYfNP75J9SdKohS01rLzVLEAbRWXUKXuvMSWgJkQq9S1
	 sXl+Fhrgeq0r5VVfa/jHXp6zEyFpaP40u4HNXt3kH0CX/WTj5FnN40mUx6RtXnZMa6
	 h28nAKW9Zdux1c5SAa60goM5IEu7mxUp68u1bTQg=
Date: Wed, 22 May 2024 10:22:24 +0300
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
Message-ID: <20240522072224.GC8863@pendragon.ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
 <11a383f3-a6db-4de7-a5f8-2938c69e98fc@kernel.org>
 <20240521194309.GA8863@pendragon.ideasonboard.com>
 <075f5a03-f288-4dfb-a293-3a6c0675881b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <075f5a03-f288-4dfb-a293-3a6c0675881b@kernel.org>

On Wed, May 22, 2024 at 08:57:56AM +0200, Krzysztof Kozlowski wrote:
> On 21/05/2024 21:43, Laurent Pinchart wrote:
> > Hi Krzysztof,
> > 
> > On Tue, May 21, 2024 at 09:05:50PM +0200, Krzysztof Kozlowski wrote:
> >> On 20/05/2024 21:59, Laurent Pinchart wrote:
> >>> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> >>> matrix decoder, programmable logic, reset generator, and PWM generator.
> >>> These bindings model the device as an MFD, and support the GPIO expander
> >>> and PWM functions.
> >>>
> >>> These bindings support the GPIO and PWM functions.
> >>>
> >>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> ---
> >>> I've limited the bindings to GPIO and PWM as I lack hardware to design,
> >>> implement and test the rest of the features the chip supports.
> >>> ---
> >>>  .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
> >>>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++++++++++++
> >>>  .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
> >>>  MAINTAINERS                                   |   7 ++
> >>>  4 files changed, 195 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> >>>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> >>>  create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> >>> new file mode 100644
> >>> index 000000000000..210e4d53e764
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
> >>> @@ -0,0 +1,36 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Analog Devices ADP5585 GPIO Expander
> >>> +
> >>> +maintainers:
> >>> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> +
> >>> +description: |
> >>> +  The Analog Devices ADP5585 has up to 11 GPIOs represented by a "gpio" child
> >>> +  node of the parent MFD device. See
> >>> +  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further details as
> >>> +  well as an example.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: adi,adp5585-gpio
> >>> +
> >>> +  gpio-controller: true
> >>> +
> >>> +  '#gpio-cells':
> >>> +    const: 2
> >>> +
> >>> +  gpio-reserved-ranges: true
> >>
> >> There are no resources here, so new compatible is not really warranted.
> >> Squash the node into parent.
> > 
> > Child nodes seem (to me) to be the standard way to model functions in
> > MFD devices. Looking at mfd_add_device(), for OF-based systems, the
> > function iterates over child nodes. I don't mind going a different
> 
> Only to assign of node, which could be skipped as well.

It has to be assigned somehow, otherwise the GPIO and PWM lookups won't
work. That doesn't have to be done in mfd_add_device() though, it can
also be done manually by the driver. Looking at the example you gave,
cs42l43_pin_probe() handles that assignment. I would have considered
that a bit of a hack, but if that's your preferred approach, I'm fine
with it. Could you confirm you're OK with that ?

> > routes, could you indicate what you have in mind, perhaps pointing to an
> > existing driver as an example ?
> 
> Most of them? OK, let's take the last added driver in MFD directory:
> cirrus,cs42l43
> It has three children and only two nodes, because only these two devices
> actually need/use/benefit the subnodes.

Still trying to understand what bothers you here, is it the child nodes,
or the fact that they have a compatible string and are documented in a
separate binding ? Looking at the cirrus,cs42l43 bindings and the
corresponding drivers, the pinctrl child node serves the purpose of
grouping properties related to the pinctrl function, and allows
referencing pinctrl entries from other DT nodes. All those properties
could have been placed in the parent node. Are you fine with the
adi,adp5585 having gpio and pwm child nodes, as long as they don't have
compatible strings, and are documented in a single binding ?

> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - gpio-controller
> >>> +  - "#gpio-cells"
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +...
> >>> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> >>> new file mode 100644
> >>> index 000000000000..217c038b2842
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> >>> @@ -0,0 +1,117 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Analog Devices ADP5585 Keypad Decoder and I/O Expansion
> >>> +
> >>> +maintainers:
> >>> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> +
> >>> +description: |
> >>
> >> Do not need '|' unless you need to preserve formatting.
> >>
> >>> +  The ADP5585 is a 10/11 input/output port expander with a built in keypad
> >>> +  matrix decoder, programmable logic, reset generator, and PWM generator.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - adi,adp5585-00  # Default
> >>> +          - adi,adp5585-01  # 11 GPIOs
> >>> +          - adi,adp5585-02  # No pull-up resistors by default on special pins
> >>> +          - adi,adp5585-03  # Alternate I2C address
> >>> +          - adi,adp5585-04  # Pull-down resistors on all pins by default
> >>> +      - const: adi,adp5585
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  vdd-supply: true
> >>> +
> >>> +  gpio:
> >>> +    $ref: /schemas/gpio/adi,adp5585-gpio.yaml
> >>> +
> >>> +  pwm:
> >>> +    $ref: /schemas/pwm/adi,adp5585-pwm.yaml
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - gpio
> >>> +  - pwm
> >>> +
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: adi,adp5585-01
> >>> +    then:
> >>> +      properties:
> >>> +        gpio:
> >>> +          properties:
> >>> +            gpio-reserved-ranges: false
> >>
> >> This also points to fact your child node is pointless. It does not stand
> >> on its own...
> > 
> > That doesn't make the child pointless just for that reason. There are
> > numerous examples of child nodes that don't stand on their own.
> 
> No, your if-then must be in the schema defining it. This is just
> unmaintianable code. It proves that child's compatible means nothing. If
> you cannot use child's compatible to make any meaningful choices, then
> it is useless.

The compatible string may not be very useful. The child nodes have a
use.

-- 
Regards,

Laurent Pinchart

