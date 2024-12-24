Return-Path: <linux-pwm+bounces-4485-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DEF9FBAD5
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 10:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEECD18849DA
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000B190470;
	Tue, 24 Dec 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFPUsrfC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978C2BB15;
	Tue, 24 Dec 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735030824; cv=none; b=ppc8svZNEfinL5AlpFuFjlYdHfOmp8ZnlywNwqdH8aipMfVWWUIH44CJmpUFe4JqYCAwKseUQmYRRs/TcHCYveGbTTQn4H6vouZCGl7AafrLzWqNncEFcS1nx4q9bqWxZJ83SQKWF3Oi5Jys8PMpO5PWOjqEJt5u71TvXPfZbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735030824; c=relaxed/simple;
	bh=iIFRZhvlUCHjcvWzeF5tljgi55EYFpAF+OSKsDDBICk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFCwbag0SEBJBTwwfVdH/ImVyhCgsUp9GG2yXM+IGJIFSwAwPXRmZHPrnuBZejZiC36HNsNoVVj/4b5PrlfpC8/UqOgVmsmEaB7TZTcy/0byHT4n86RSuXRAglP2XR+SLZ2anKA5sabovg5hlTyDhOI9c9VZyHnTimZYX+jG2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFPUsrfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9126C4CED0;
	Tue, 24 Dec 2024 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735030823;
	bh=iIFRZhvlUCHjcvWzeF5tljgi55EYFpAF+OSKsDDBICk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QFPUsrfCNbb/EuUE2bR4P/Se3TgwvsvOKwb3LzdHN80KEZ5QcTlwi+cOH4eCngI8F
	 vcBJ8XW8kkcgAkq6qWc25fUGY/gcqT33JQ3soPtRlOeoUq0eOq8JIpAI+bhTWcJoAa
	 kEil1r7tuKaH7bGxDN2OR9p5O/2/wVERKPJdRJjf7ia7hln1x09C1uXuMRYbzP10Fh
	 nwWRtfkvdT5sKSRP5Z6ahyyNfAE33aPyhqcy/z6taFkxU17Q/I+zlrsFP5Jm+SXEwu
	 fY0i9xqBHpSCHiO7YSjGcx7aECOUUW2O12D+ob947jIFaptzLj+j3/Svj4aRPFjKR+
	 BxvbYFDn2A4Lg==
Message-ID: <b1d541c1-296a-4b56-bea3-52e5becadf0e@kernel.org>
Date: Tue, 24 Dec 2024 10:00:17 +0100
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
 <58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.org>
 <D6J6JNPPZRKM.3F9YUY9CW3L2F@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <D6J6JNPPZRKM.3F9YUY9CW3L2F@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2024 16:20, Mathieu Dubois-Briand wrote:
> On Sat Dec 21, 2024 at 9:34 PM CET, Krzysztof Kozlowski wrote:
>> On 19/12/2024 17:21, Mathieu Dubois-Briand wrote:
>>> ---
>>>  .../devicetree/bindings/gpio/max7360-gpio.yaml     | 96 ++++++++++++++++++++++
>>>  .../devicetree/bindings/input/max7360-keypad.yaml  | 67 +++++++++++++++
>>>  .../devicetree/bindings/input/max7360-rotary.yaml  | 52 ++++++++++++
>>>  .../devicetree/bindings/pwm/max7360-pwm.yaml       | 35 ++++++++
>>>  4 files changed, 250 insertions(+)
>>
>>
>> I don't understand how this patchset was split. MFD binding cannot be
>> empty and cannot be before child devices.
>>
> 
> Ok, my bad. So I believe squashing both dt-bindings commit should fix
> this.
> 
>>> diff --git a/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
>>> new file mode 100644
>>> index 000000000000..3c006dc0380b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/max7360-gpio.yaml
>>> @@ -0,0 +1,96 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/gpio/max7360-gpio.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Maxim MAX7360 GPIO controller
>>> +
>>> +maintainers:
>>> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
>>> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>>> +
>>> +description: |
>>> +  Maxim MAX7360 GPIO controller, in MAX7360 MFD
>>> +  https://www.analog.com/en/products/max7360.html
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - maxim,max7360-gpio
>>> +      - maxim,max7360-gpo
>>
>> Why? What are the differences?
>>
> 
> Ok, so maybe my approach here is completely wrong. I'm not sure what
> would be the best way to describe the device here, if you have any
> suggestion I would be happy to use it. Let me try to summarize the GPIO
> setup of the chip.
> 
> First we have two series of GPIOs on the chips, which I tend to think
> about as two separate "banks". Thus two separate subnodes of the max7360
> node.

First, splitting MFD device into multiple children is pretty often wrong
approach because it tries to mimic Linux driver design.

Such split in DT makes sense if these are really separate blocks, e.g.
separate I2C addresses, re-usable on different designs.

In this case Functional Block Diagram shows separate blocks, but still
the same I2C block. This can be one device. This can be also two devices
if that's easier to represent in DT.

But in any case binding description should explain this.

> 
> - On one side we have what I refer to as GPIOs, here with
>   maxim,max7360-gpio:
>   - PORT0 to PORT7 pins of the chip.
>   - Shared with PWM and rotary encoder functionalities. Functionality
>     selection can be made independently for each pin. This selection is
>     not described here. Runtime will have to ensure the same pin is not
>     used by two drivers at the same time. E.g. we cannot have at the
>     same time GPIO4 and PWM4.
>   - Supports input and interrupts.
>   - Outputs may be configured as constant current.
>   - 8 GPIOS supported, so ngpios maximum is 8. Thinking about it now, we
>     should probably also set minimum to 8, I don't see any reason to
>     have ngpios set to something less.
> 
> On the other side, we have what I refer to as GPOs, here with
> maxim,max7360-gpo compatible:
>   - COL2 to COL7 pins of the chip.
>   - Shared with the keypad functionality. Selections is made by
>     partitioning the pins: first pins for keypad columns, last pins for
>     GPOs. Partition is described here by ngpios and on keypad node by
>     keypad,num-columns. Runtime will have to ensure values are coherent
>     and configure the chip accordingly.
>   - Only support outputs.
>   - No support for constant current mode.
>   - Supports 0 to 6 GPOs, so ngpios maximum is 6.
> 
>>> +
>>> +  gpio-controller: true
>>> +
>>> +  "#gpio-cells":
>>> +    const: 2
>>> +
>>> +  ngpios:
>>> +    minimum: 0
>>> +    maximum: 8
>>
>> Why this is flexible?
>>
> 
> I believe this makes sense, as this keypad/gpos partition really changes
> the actual number of GPIOS. Yet we could argue that this is just runtime
> configuration. Tell me what you think about it, if you think this should
> be a fixed value, I will find a way.

Depends whether this is actual runtime configuration. If you configure
keypad in DT, then the pins go away from GPIOs (especially considering
that board might have these pins really connected to keypad). Anyway,
explain this briefly in binding description.

> 
Best regards,
Krzysztof

