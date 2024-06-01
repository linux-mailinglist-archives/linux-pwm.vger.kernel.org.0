Return-Path: <linux-pwm+bounces-2314-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570B8D70D1
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2024 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C40B21CC1
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F3152782;
	Sat,  1 Jun 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neoRfGaJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F710949;
	Sat,  1 Jun 2024 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717255077; cv=none; b=PK1+z2Q8diavpFAUrhcJWdm1kalPI4+K2xWt9lIGlVelRwduOSICw508HC7aCZKVFalQFEAqkap79ziE/lsVa0suZN2uDB4lUp5uAo1/Ywer+YF4/z3hDr1TUYCnH+l7XkjQFXJKgYfJ860wlq4jzfIbDH+6AD9z0LR9f8UPHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717255077; c=relaxed/simple;
	bh=MiheRmDa9YIwfK0COcyZiMZofO0kN5bJO2zbV82w0Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPipJJiysFYx8ygxjEObwv/iEXMYuebTLeVWJwgoXssubOjhkAi9jXaC83sa9XPZYL4TmP/eMoqbz5J8Z1rc3Nkd5aEh6l7Pg656EDPZYXFhRdNxJfh7P18mp8/YOSoTzwQbKNL0WEW0//eJmHpTOQqiDmdIYkEmRB4NyEnj54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neoRfGaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E88C116B1;
	Sat,  1 Jun 2024 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717255076;
	bh=MiheRmDa9YIwfK0COcyZiMZofO0kN5bJO2zbV82w0Q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=neoRfGaJsRFWOk1FaODamSrVPP9Mkt05R2gvMBipBnzK1gyg+ILcqorphKVKXP7Gs
	 F/R4Odn6vSj9GoNdKKK3FYuEB+UWeeTe0ceeBrwyPkZ2HsXvXMJdTUKFpNjGUC4lqW
	 jpKJONY/2Yw1n2vrfXULQcfubiHTr6FYDdxpIOJ6vG+LdNB1Mh5SW8UVUHipwo8G++
	 49rP8vVdhEOxQpE+M/kQzy43pt0aeAgPylF8ofIkz15XsbAJVnXd8q1eL3iYrynKPb
	 2zkxDRnj0veTWOOgfykURUV6zWrRKZfuCj8/xqemaiA8jWzGLV9B4bw4ZcqAHZvwOa
	 hMjCOb4ycNi2Q==
Message-ID: <da382d43-fa82-44c0-9630-086f59e6efa2@kernel.org>
Date: Sat, 1 Jun 2024 17:17:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: pwm: sun20i: Add options to select a
 clock source and DIV_M
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Aleksandr Shubin <privatesub2@gmail.com>, Cheo Fusi
 <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240531141152.327592-1-kikuchan98@gmail.com>
 <20240531141152.327592-6-kikuchan98@gmail.com>
 <851280ad-ac0e-47d1-99e2-4f3b5ea29f2f@kernel.org>
 <CAG40kxEbMQc-ni0HDVR7rtj48aFu-jz8sYUAO+fdmZSmXWrizw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAG40kxEbMQc-ni0HDVR7rtj48aFu-jz8sYUAO+fdmZSmXWrizw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/05/2024 19:57, Hironori KIKUCHI wrote:
> Hello,
> 
>>> This patch adds new options to select a clock source and DIV_M register
>>> value for each coupled PWM channels.
>>
>> Please do not use "This commit/patch/change", but imperative mood. See
>> longer explanation here:
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
>> Bindings are before their users. This should not be last patch, because
>> this implies there is no user.
> 
> I'm sorry, I'll fix them.
> 
>> This applies to all variants? Or the one you add? Confused...
> 
> Apologies for confusing you. This applies to all variants.
> 
>>
>>>
>>> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
>>> ---
>>>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>>> index b9b6d7e7c87..436a1d344ab 100644
>>> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>>> @@ -45,6 +45,25 @@ properties:
>>>      description: The number of PWM channels configured for this instance
>>>      enum: [6, 9]
>>>
>>> +  allwinner,pwm-pair-clock-sources:
>>> +    description: The clock source names for each PWM pair
>>> +    items:
>>> +      enum: [hosc, apb]
>>> +    minItems: 1
>>> +    maxItems: 8
>>
>> Missing type... and add 8 of such items to your example to make it complete.
> 
> Thank you. I'll fix it.
> 
>>
>>> +
>>> +  allwinner,pwm-pair-clock-prescales:
>>> +    description: The prescale (DIV_M register) values for each PWM pair
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +    items:
>>> +      items:
>>> +        minimum: 0
>>> +        maximum: 8
>>> +      minItems: 1
>>> +      maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 8
>>
>> This does not look like matrix but array.
> 
> I wanted to specify values like this:
> 
>     allwinner,pwm-pair-clock-prescales = <0>, <1>, <3>;
>     allwinner,pwm-pair-clock-sources = "hosc", "apb", "hosc":
> 
> These should correspond to each PWM pair.
> This way, I thought we might be able to visually understand the relationship
> between prescalers and sources, like clock-names and clocks.
> 
> Is this notation uncommon, perhaps?

It's still an array.

> 
>>
>> Why clock DIV cannot be deduced from typical PWM attributes + clock
>> frequency?
> 
> This SoC's PWM system has one shared prescaler and clock source for each pair
> of PWM channels. I should have noted this earlier, sorry.
> 
> Actually, the original v9 patch automatically deduced the DIV value
> from the frequency.
> However, because the two channels share a single prescaler, once one channel is
> enabled, it affects and restricts the DIV value for the other channel
> in the pair.
> This introduces a problem of determining which channel should set the shared DIV
> value. The original behavior was that the first channel enabled would win.

There's nothing bad in this.

> 
> Instead, this patch try to resolve the issue by specifying these
> values for each PWM
> pairs deterministically.
> That's why it requires the new options.

This does not solve that wrong divider can be programmed for second
channel in each pair.

Best regards,
Krzysztof


