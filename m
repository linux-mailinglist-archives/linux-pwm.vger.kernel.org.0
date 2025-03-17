Return-Path: <linux-pwm+bounces-5202-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810AA643FF
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 08:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE16164126
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B882221ADD1;
	Mon, 17 Mar 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqUTHxNP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861BC1D9A79;
	Mon, 17 Mar 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197284; cv=none; b=t4Sg/eN2V+RQAIVd09wDEJQARH3m3jxLkUQkhWiIKKmfA0aZ801J0Pu6mD18Z55a7/lZz3MwZHUIqfeocp1LGWOvmAtzlLrEy3vvjiuksLzPVJeF6PIphdpVoKKs0exUzYD1wbc/W322WEwjjt5H6pf+0NtDY85HNvbjHnKA/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197284; c=relaxed/simple;
	bh=ViqUjySpVr7jXmsPFEtRuHWYsn4CWdA3BUmtlzRVBa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LScnbM7yY3rm63JQIR0lI45GE3LOTmJ9ew52Ko1cO3FK+Fu/x2EoDr8E9o2TtMBuFcvuVTmFHvA0roomZzwJ+9Eq5z56ZQjLYC/O8F+FHTcQ0EC4aCyjRGrjzsFTu6Bru8biRZHZAkkaKRYswmP5k/RFu6z3BdI/AeEBlmI0GmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqUTHxNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A2AC4CEE3;
	Mon, 17 Mar 2025 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742197284;
	bh=ViqUjySpVr7jXmsPFEtRuHWYsn4CWdA3BUmtlzRVBa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TqUTHxNPAsxSeuUrVIpUjcP4rDPWjGrchbZ5vzsVbUrPVDYg4A8HxqlUhcQBJK7MX
	 evwO55/sPDbHTWd+Lr03hcV/K7pbenFUttJ+aaDVkxX1Wipp5oTisI9jJt+kaubef6
	 EjEEtWiTtwggRPkL8T+PYHnDUJFgqOvZqN5ViLosx0dIdidaLdo9Z8oZzXSf9Jb71b
	 4UGC8S9/zNV2hzIgKxUP/zkJS0JQ+tyyZPveiZaX5jQHeU8Q1i2NmDcUqwCcad0TZF
	 HSBCbSvxS91sujsu/WKJHHO7Me1ehj2d0iSW5X2XS1WZBZ6GvSod5kwKt8DPWCgp47
	 1xLY/didS5Mow==
Message-ID: <f1ccbdc1-3f47-46a8-bcc2-ca6135882392@kernel.org>
Date: Mon, 17 Mar 2025 08:41:15 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
 <20250313-dev-adp5589-fw-v1-5-20e80d4bd4ea@analog.com>
 <20250314-outstanding-futuristic-cat-5d8240@krzk-bin>
 <c59477b2a94cbd10bc530809fbcdc0f2d1b79d07.camel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c59477b2a94cbd10bc530809fbcdc0f2d1b79d07.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2025 10:38, Nuno Sá wrote:
> On Fri, 2025-03-14 at 09:49 +0100, Krzysztof Kozlowski wrote:
>> On Thu, Mar 13, 2025 at 02:19:22PM +0000, Nuno Sá wrote:
>>>    reg:
>>>      maxItems: 1
>>> @@ -63,13 +70,26 @@ allOf:
>>>        properties:
>>>          gpio-reserved-ranges: false
>>>      else:
>>> -      properties:
>>> -        gpio-reserved-ranges:
>>> -          maxItems: 1
>>> -          items:
>>> +      if:
>>
>> Do not nest if:then:else:if:then, it leads to code impossible to read.
>> Just provide if-then cases for each of your variant.
>>
> 
> Alright...
> 
>>
>>
>>
>>> +        properties:
>>> +          compatible:
>>> +            contains:
>>> +              enum:
>>> +                - adi,adp5585-00
>>> +                - adi,adp5585-02
>>> +                - adi,adp5585-03
>>> +                - adi,adp5585-04
>>> +      then:
>>> +        properties:
>>> +          gpio-reserved-ranges:
>>> +            maxItems: 1
>>
>> one tem?
>>
>>>              items:
>>> -              - const: 5
>>> -              - const: 1
>>
>> But here two...
>>
>>> +              items:
>>> +                - const: 5
>>> +                - const: 1
>>
>> and this is confusing. I don't get what you want to express.
>>
> 
> I just kept it as before (maybe I messed up in some other way but the 2 items:

No, your code is very different.

> were already in the binding):

I see only one GPIO range.

> 
> https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml#L70
> 
> If this is not needed I can simplifying during this patch. Is this sufficient?
> 
> ...
> 
>         gpio-reserved-ranges:
>           maxItems: 1
>           items:
>             - const: 5
>             - const: 1

Again, different code and not correct as you have now two ranges. Open
original code - it is clear not the same. So two tries - your patch and
code above - are different but I don't get why you claim your code is
identical.

Best regards,
Krzysztof

