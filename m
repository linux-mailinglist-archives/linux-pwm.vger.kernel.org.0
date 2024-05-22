Return-Path: <linux-pwm+bounces-2218-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A528CBC2C
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3992811E7
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA37CF1A;
	Wed, 22 May 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJHqHpyT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18E3BBC9;
	Wed, 22 May 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363609; cv=none; b=iFcp8nyFcH682yrIGnVpg7Z3Xpg5QpBzQCXQt2R2hvDjuPPgTXCfSj7dqUdbUMIL3FZxc0n3Rtmm1NldYZjdR7OMIi5R+PkzwmzxqExwr0HhIcx6LTd4V1p5pqIO4+ZpcQYXoYukIWV+QxoRmKlqPPtn+oTGRDbDPCJCSZrftTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363609; c=relaxed/simple;
	bh=alH0vAWFhvDWRtiEnbqkphPSEOdwiGks2NcpAfpkPjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnOFn5cIUVAwNmhqQeF8ihQKZ5PIHeTTRIVFjZBBPxCQWh9oL45YQXRjTKQCS5zecaFtN8jJy77TJwkDbcIcVcgpaqMvlf7a/Cm4vi7z/y4rNZeU+nXLZ6h445mpkPfOtKARO2qiYdirkLOltxo+P7DccrvxbsNE81VrBBpL/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJHqHpyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB379C32789;
	Wed, 22 May 2024 07:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716363609;
	bh=alH0vAWFhvDWRtiEnbqkphPSEOdwiGks2NcpAfpkPjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FJHqHpyTB69clfA4N4Tn5tLzqzUsQb2JSUR6wnaVO1r6kmYpou2q1CXN7Yew5+RJz
	 uZw4/DFaoEQIAo7SRDwebc9IWTaUw/Mbv99cYaLgPVur5mEZD8BhsfwnNGJILWjvuP
	 yx2UvH+BetIRP3jASw19I2dKSL7J+mi/JIUzc/oi71S/S1YbR01tR8DqJGso+FjZHd
	 b+ZilW3rULI3ode2ZBgrYLTuGmIgpBFaqkaOZNAe3aI6Rju50m70I1qbxN1oFzKsMv
	 lOq/emdBCENbOid3MZR9hRl5uNkcZeSpOUnCsWv17zvQY2XE0QVqvVeXPdbZH0Kuq3
	 XQU+wMi/lEGSw==
Message-ID: <92e85dff-ad02-4673-a625-2248b249c262@kernel.org>
Date: Wed, 22 May 2024 09:40:02 +0200
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
 <075f5a03-f288-4dfb-a293-3a6c0675881b@kernel.org>
 <20240522072224.GC8863@pendragon.ideasonboard.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240522072224.GC8863@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 09:22, Laurent Pinchart wrote:
> On Wed, May 22, 2024 at 08:57:56AM +0200, Krzysztof Kozlowski wrote:
>> On 21/05/2024 21:43, Laurent Pinchart wrote:
>>> Hi Krzysztof,
>>>
>>> On Tue, May 21, 2024 at 09:05:50PM +0200, Krzysztof Kozlowski wrote:
>>>> On 20/05/2024 21:59, Laurent Pinchart wrote:
>>>>> The ADP5585 is a 10/11 input/output port expander with a built in keypad
>>>>> matrix decoder, programmable logic, reset generator, and PWM generator.
>>>>> These bindings model the device as an MFD, and support the GPIO expander
>>>>> and PWM functions.
>>>>>
>>>>> These bindings support the GPIO and PWM functions.
>>>>>
>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>> ---
>>>>> I've limited the bindings to GPIO and PWM as I lack hardware to design,
>>>>> implement and test the rest of the features the chip supports.
>>>>> ---
>>>>>  .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 ++++++
>>>>>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 ++++++++++++++++++
>>>>>  .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 ++++++
>>>>>  MAINTAINERS                                   |   7 ++
>>>>>  4 files changed, 195 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
>>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
>>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..210e4d53e764
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
>>>>> @@ -0,0 +1,36 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/gpio/adi,adp5585-gpio.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Analog Devices ADP5585 GPIO Expander
>>>>> +
>>>>> +maintainers:
>>>>> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>> +
>>>>> +description: |
>>>>> +  The Analog Devices ADP5585 has up to 11 GPIOs represented by a "gpio" child
>>>>> +  node of the parent MFD device. See
>>>>> +  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml for further details as
>>>>> +  well as an example.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: adi,adp5585-gpio
>>>>> +
>>>>> +  gpio-controller: true
>>>>> +
>>>>> +  '#gpio-cells':
>>>>> +    const: 2
>>>>> +
>>>>> +  gpio-reserved-ranges: true
>>>>
>>>> There are no resources here, so new compatible is not really warranted.
>>>> Squash the node into parent.
>>>
>>> Child nodes seem (to me) to be the standard way to model functions in
>>> MFD devices. Looking at mfd_add_device(), for OF-based systems, the
>>> function iterates over child nodes. I don't mind going a different
>>
>> Only to assign of node, which could be skipped as well.
> 
> It has to be assigned somehow, otherwise the GPIO and PWM lookups won't
> work. That doesn't have to be done in mfd_add_device() though, it can
> also be done manually by the driver. Looking at the example you gave,
> cs42l43_pin_probe() handles that assignment. I would have considered
> that a bit of a hack, but if that's your preferred approach, I'm fine
> with it. Could you confirm you're OK with that ?

I am fine with the drivers doing that. It's not a hack, for all
sub-devices (e.g. also auxiliary bus) you won't have automatic of_node
assignment.

> 
>>> routes, could you indicate what you have in mind, perhaps pointing to an
>>> existing driver as an example ?
>>
>> Most of them? OK, let's take the last added driver in MFD directory:
>> cirrus,cs42l43
>> It has three children and only two nodes, because only these two devices
>> actually need/use/benefit the subnodes.
> 
> Still trying to understand what bothers you here, is it the child nodes,
> or the fact that they have a compatible string and are documented in a
> separate binding ? Looking at the cirrus,cs42l43 bindings and the

What bothers me (and as expressed in many reviews by us) is representing
driver structure directly in DT. People model DT based how their Linux
drivers are represented. I don't care about driver stuff here, but DT/DTS.

> corresponding drivers, the pinctrl child node serves the purpose of
> grouping properties related to the pinctrl function, and allows
> referencing pinctrl entries from other DT nodes. All those properties

If you have sub-subnodes, it warrants for me such child. Why? Because it
makes DTS easier to read.

> could have been placed in the parent node. Are you fine with the
> adi,adp5585 having gpio and pwm child nodes, as long as they don't have
> compatible strings, and are documented in a single binding ?

As well not, because then you have even less reasons to have them as
separate nodes. With compatible, one could at least try to argue that
sub-devices are re-usable across families.

>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - gpio
>>>>> +  - pwm
>>>>> +
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            const: adi,adp5585-01
>>>>> +    then:
>>>>> +      properties:
>>>>> +        gpio:
>>>>> +          properties:
>>>>> +            gpio-reserved-ranges: false
>>>>
>>>> This also points to fact your child node is pointless. It does not stand
>>>> on its own...
>>>
>>> That doesn't make the child pointless just for that reason. There are
>>> numerous examples of child nodes that don't stand on their own.
>>
>> No, your if-then must be in the schema defining it. This is just
>> unmaintianable code. It proves that child's compatible means nothing. If
>> you cannot use child's compatible to make any meaningful choices, then
>> it is useless.
> 
> The compatible string may not be very useful. The child nodes have a
> use.

What is their use? Grouping few properties? As mentioned above -
grouping subnodes like pinctrl does, is argument on its own for code
readability. Grouping few properties, which in many other devices are in
top-node (see last 100 reviews of new drivers doing exactly the same),
is not that argument.

OTOH, my first, main argument was:

They do not have any resources on their own. Otherwise please point me -
which property represents their resource, like clock, reset, gpio,
suppy, IO address?

Best regards,
Krzysztof


