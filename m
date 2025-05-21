Return-Path: <linux-pwm+bounces-6065-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F0ABF60F
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069D03A3EF2
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EE727815B;
	Wed, 21 May 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU1DDpcZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB623C51E;
	Wed, 21 May 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834125; cv=none; b=HRBj20t1oN+oa0/KO2+8LztvGA570QeNr5PYciXanx/c63X/vdHfEs6Wiwb+3hJzquvVmImJgVWfKno7z5f7JRTPDEB8titBONn6LsF75VB+3VPYcWY2OhL16tO+R2L8MPWqEiu0gSY7GelSxYFui3ygOS4hmPyNuC6E5c0GAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834125; c=relaxed/simple;
	bh=bJ89VqRXyIKcA7dmHXxP3puOM3fMxjcRRauLe32PJ9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyy0Gney81ypw7pGy9uBZxHjw5TiYTxKAfQkVuvxgW/6J6oFSYwSe41UgEpGWEWh/Ai/H796CL0vJEiyBt5kmD5ZozYnvwRqSR/lV7Ez0eh12ThwP0kk/UWjTSzK6/JWT8LZAs29CnOdM5zVj2fYA1gZ2JvLk8GWh3NhCCX3ADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU1DDpcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D439AC4CEE4;
	Wed, 21 May 2025 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834123;
	bh=bJ89VqRXyIKcA7dmHXxP3puOM3fMxjcRRauLe32PJ9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BU1DDpcZV1QLIMxJ/w+9FxYCBWcON4QN3j0lfb7MBePKWGU8Aqt2yHfYBBD7PDMce
	 vV13dBkyYBviRiwW3kMV6gSRSKPMhO5F/Zu54KnoBodaYIZ0Vc3I5phEpqQNd9sl0l
	 rGAUwREyOR2b9l5dYAGLs8abnd9+b4n9DVhUxR/dpbi03gnZDqKLoWRGyVlx983GZA
	 dq/TpCgvJmfnBs3hxUZmMSrlsZV6/ZfDElCyblA+ptl7UnTHitG+U4Wh/7GjoCwcj7
	 8laqffoDSR+Ki/T4ib8mwzf0E3Ma7KTQfErqxYBHcwyMbeuGlUnH5f42zwYzIJ4RWp
	 yI9XdSaCgjKHg==
Message-ID: <499207c7-aa40-470c-801f-a8154a253276@kernel.org>
Date: Wed, 21 May 2025 15:28:38 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: pwm: adi,axi-pwmgen: add external clock
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-2-6cd63cc001c8@baylibre.com>
 <20250521-tidy-heron-of-genius-4dc9a1@kuoka>
 <be02b9cd-803c-4aae-9420-ff3bf445efc1@baylibre.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <be02b9cd-803c-4aae-9420-ff3bf445efc1@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2025 15:14, David Lechner wrote:
> On 5/21/25 5:09 AM, Krzysztof Kozlowski wrote:
>> On Tue, May 20, 2025 at 04:00:45PM GMT, David Lechner wrote:
>>> Add external clock to the schema.
>>>
>>> The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
>>> the use of an external clock for the PWM output separate from the AXI
>>> clock that runs the peripheral.
>>>
>>> In these cases, we should specify both clocks in the device tree. The
>>> intention here is that if you specify both clocks, then you include the
>>> clock-names property and if you don't have an external clock, then you
>>> omit the clock-names property.
>>>
>>> There can't be more than one allOf: in the top level of the schema, so
>>> it is stolen from $ref since it isn't needed there and used for the
>>> more typical case of the if statement (even though technically it isn't
>>> needed there either at this time).
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    | 26 ++++++++++++++++++----
>>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>> index bc44381692054f647a160a6573dae4cff2ee3f31..90f702a5cd80bd7d62e2436b2eed44314ab4fd53 100644
>>> --- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>> @@ -16,8 +16,7 @@ description:
>>>  
>>>    https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
>>>  
>>> -allOf:
>>> -  - $ref: pwm.yaml#
>>> +$ref: pwm.yaml#
>>>  
>>>  properties:
>>>    compatible:
>>> @@ -30,7 +29,13 @@ properties:
>>>      const: 3
>>>  
>>>    clocks:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: axi
>>> +      - const: ext
>>>  
>>>  required:
>>>    - reg
>>> @@ -38,11 +43,24 @@ required:
>>>  
>>>  unevaluatedProperties: false
>>>  
>>> +allOf:
>>> +  - if:
>>> +      required: [clock-names]
>>
>>
>> No, don't do that. If you want clock-names, just add them for both
>> cases. Otherwise, just describe items in clocks and no need for
>> clock-names.
> 
> Would it be OK then to make clock-names required and just let the
> driver still handle one clocks, no clock-names for backwards compatibility?

So just don't make it required.

> 
>>
>>
>>
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 2
>>> +    else:
>>> +      properties:
>>> +        clocks:
>>> +          maxItems: 1
>>> +
>>>  examples:
>>>    - |
>>>      pwm@44b00000 {
>>>          compatible = "adi,axi-pwmgen-2.00.a";
>>>          reg = <0x44b00000 0x1000>;
>>> -        clocks = <&spi_clk>;
>>> +        clocks = <&fpga_clk>, <&spi_clk>;
>>
>> What was the clock[0] before? Axi, right, so SPI_CLK. Now FPGA is the
>> AXI_CLK? This feels like clock order reversed.
> 
> The problem being fixed here is that since there was only one clock in
> the binding, existing .dts files have either have the spi_clock or
> the FPGA/AXI clock. So the one clock could be either and there are
> existing .dtbs out in the world with both cases.

No problem like that was explained in commit msg. Nevertheless driver
assumed the first clock is the SPI, didn't it? So that's your ABI, even
if binding was not conclusive here.


> 
> But we could consider reversing this so that if someone uses the new
> bindings with an old kernel, then it would still work.

You cannot use new bindings with old kernel. How would that work? Put
YAML file there? Nothing would change.

Binding is supposed to be complete for exactly this reason. You cannot
change it afterwards without breaking users.

Best regards,
Krzysztof

