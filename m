Return-Path: <linux-pwm+bounces-2215-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54148CBB9F
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 08:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA51F22123
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F879952;
	Wed, 22 May 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1PieJV5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51459147;
	Wed, 22 May 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361082; cv=none; b=giIJbHW5kqG5T1M7TWvGhhS15uBqEwcGBbeYH3ZtvSqTW/hVGs/9hTus7+8KcxXysBlxtoFPSYyZwOhYfwqquW1O67+FG+VtwZO1j3uvCJM3oHn0WF6odPGZpqDO53/gq5NoXIoC3b4Yw8tNAk/Wz/HlIiziCyqkcn4s2mKGEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361082; c=relaxed/simple;
	bh=zW4bTdJWK81AR2+O8wSlEJaH4FcFXtOYcg1BuXGhn9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnE3x6GWmoiV60MZPJ8XfMMgJyv/GRdXqhHSmDHUPRW1nNxgge87CsB4i/ut1avsvTGIP/mFZQH3dGg9pSq+OCsj2JgNB7foavYly8NCjRqt8xF8vzNGlPeLuHN8mb3vYOCdUGpMk/pi5MUa3k9I79NNAP2ZnQcXedrAFsdjzQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1PieJV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39181C2BD11;
	Wed, 22 May 2024 06:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716361082;
	bh=zW4bTdJWK81AR2+O8wSlEJaH4FcFXtOYcg1BuXGhn9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n1PieJV5GQxwoN6cinS+3f6pE72OKEoAUIa0NA8eOl045vEbW4KG+TBaS2FLMcYFi
	 hoqtJXIJlLu+b+t5lpPtYujk/3HCY2Fle1dMrj8uRb539SUzWdygSg1Yd3pbOvqDkG
	 iAX4e5Rb7riYGqZIn03i2wAw11jlIeI9ecCoLuVmmBAiuMEeikrei2v3hbVDD+NqBm
	 rMN/z0Rqa5VSedNhqlvReMqTxzLPHt2ku5HHHezgDJbRQ+12h35sIY8Wovxme2sxwN
	 BUq8mBLYvm4xjLetB8qhJsIG9MW2SPyJ3xqVqcUTwlo8X52/Le62oYdYS7r16QozJz
	 yzi7UEd3B1c/g==
Message-ID: <075f5a03-f288-4dfb-a293-3a6c0675881b@kernel.org>
Date: Wed, 22 May 2024 08:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: Add bindings for the Analog Devices
 ADP5585
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-3-laurent.pinchart@ideasonboard.com>
 <11a383f3-a6db-4de7-a5f8-2938c69e98fc@kernel.org>
 <20240521194309.GA8863@pendragon.ideasonboard.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240521194309.GA8863@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2024 21:43, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> On Tue, May 21, 2024 at 09:05:50PM +0200, Krzysztof Kozlowski wrote:
>> On 20/05/2024 21:59, Laurent Pinchart wrote:
>>> The ADP5585 is a 10/11 input/output port expander with a built in keypad
>>> matrix decoder, programmable logic, reset generator, and PWM generator.
>>> These bindings model the device as an MFD, and support the GPIO expander
>>> and PWM functions.
>>>
>>> These bindings support the GPIO and PWM functions.
>>>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> ---
>>> I've limited the bindings to GPIO and PWM as I lack hardware to design,
>>> implement and test the rest of the features the chip supports.
>>> ---
>>>  .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
>>>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++++++++++++
>>>  .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
>>>  MAINTAINERS                                   |   7 ++
>>>  4 files changed, 195 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
>>> new file mode 100644
>>> index 000000000000..210e4d53e764
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
>>> @@ -0,0 +1,36 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices ADP5585 GPIO Expander
>>> +
>>> +maintainers:
>>> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> +
>>> +description: |
>>> +  The Analog Devices ADP5585 has up to 11 GPIOs represented by a "gpio" child
>>> +  node of the parent MFD device. See
>>> +  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further details as
>>> +  well as an example.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: adi,adp5585-gpio
>>> +
>>> +  gpio-controller: true
>>> +
>>> +  '#gpio-cells':
>>> +    const: 2
>>> +
>>> +  gpio-reserved-ranges: true
>>
>> There are no resources here, so new compatible is not really warranted.
>> Squash the node into parent.
> 
> Child nodes seem (to me) to be the standard way to model functions in
> MFD devices. Looking at mfd_add_device(), for OF-based systems, the
> function iterates over child nodes. I don't mind going a different

Only to assign of node, which could be skipped as well.

> routes, could you indicate what you have in mind, perhaps pointing to an
> existing driver as an example ?

Most of them? OK, let's take the last added driver in MFD directory:
cirrus,cs42l43
It has three children and only two nodes, because only these two devices
actually need/use/benefit the subnodes.


> 
>>> +
>>> +required:
>>> +  - compatible
>>> +  - gpio-controller
>>> +  - "#gpio-cells"
>>> +
>>> +additionalProperties: false
>>> +
>>> +...
>>> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
>>> new file mode 100644
>>> index 000000000000..217c038b2842
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
>>> @@ -0,0 +1,117 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices ADP5585 Keypad Decoder and I/O Expansion
>>> +
>>> +maintainers:
>>> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> +
>>> +description: |
>>
>> Do not need '|' unless you need to preserve formatting.
>>
>>> +  The ADP5585 is a 10/11 input/output port expander with a built in keypad
>>> +  matrix decoder, programmable logic, reset generator, and PWM generator.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - adi,adp5585-00  # Default
>>> +          - adi,adp5585-01  # 11 GPIOs
>>> +          - adi,adp5585-02  # No pull-up resistors by default on special pins
>>> +          - adi,adp5585-03  # Alternate I2C address
>>> +          - adi,adp5585-04  # Pull-down resistors on all pins by default
>>> +      - const: adi,adp5585
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  vdd-supply: true
>>> +
>>> +  gpio:
>>> +    $ref: /schemas/gpio/adi,adp5585-gpio.yaml
>>> +
>>> +  pwm:
>>> +    $ref: /schemas/pwm/adi,adp5585-pwm.yaml
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - gpio
>>> +  - pwm
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: adi,adp5585-01
>>> +    then:
>>> +      properties:
>>> +        gpio:
>>> +          properties:
>>> +            gpio-reserved-ranges: false
>>
>> This also points to fact your child node is pointless. It does not stand
>> on its own...
> 
> That doesn't make the child pointless just for that reason. There are
> numerous examples of child nodes that don't stand on their own.

No, your if-then must be in the schema defining it. This is just
unmaintianable code. It proves that child's compatible means nothing. If
you cannot use child's compatible to make any meaningful choices, then
it is useless.


Best regards,
Krzysztof


