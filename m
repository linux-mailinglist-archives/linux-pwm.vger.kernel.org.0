Return-Path: <linux-pwm+bounces-4592-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F297A0B580
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C881884D44
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56024246339;
	Mon, 13 Jan 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZjzEpQ5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE53246324;
	Mon, 13 Jan 2025 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767445; cv=none; b=mAmZ6MKfy6gJGwuI4oyG91DDJ+DQPTbCUaEe39/ENWM0r064nvbG3RQzo2eErumjhb9fw3vBoeC9Zlt7mhwcYxAEF+LW64GYRScbRo5ML2/7uHHzpAu4X9O6qiY67HTza1p7riKyD++jj0SnBV4t7lh+2aLB3xTZXbGg8ZGGQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767445; c=relaxed/simple;
	bh=QR3s227urM9NghcFxW59UIOKQvvW5b6Cpn0kVjkcw6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Od+Ea+j0Q15ZwPt5+oA4mwgeb/UbRGH5lNnE4wGz7oKrZBY+MsG1Dz4lVL2GZX2ZxI/Qu0IjXDtY1hKR2nY6hI70AwoSVeYciFT0W//qUq0bo7m6CYiXhDIdAygkUBZWkA+Co4a5kYLX8ajmJnaYuJpMludkq1Xrvvwzn9AbZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZjzEpQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BB7C4CEE8;
	Mon, 13 Jan 2025 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736767444;
	bh=QR3s227urM9NghcFxW59UIOKQvvW5b6Cpn0kVjkcw6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bZjzEpQ5Q3vRlFXoSkFWYA/Sq4pm8vB6U6F1rRvo6znK2HmbHuXBtlHzX0muWq4nv
	 Z91219eKchv0g4bUEZh0kyDnAyLljM2F28mm4ljJbsSzErvlwmlpjjHlTyA4MlkmHN
	 ri5o1M7MP1hcoYCoqRI1KQUM/EUeBEcVe8eANbseTMh2dl9KZwo2fbbNkuitBr0xzO
	 QPLYTdBzKvgIEQYv02SpjBc1oH8awTYngyzyDNX7VSTGiSb6yMfr2rDe02m79e0lP1
	 copUrIb23Bqebtk0YoEliyyoRvMk/nQDTkD7XmY9mUseCb/xcPbzjPtkHoWROJJgDu
	 2HJk009IKKThQ==
Message-ID: <f47bc5f9-cabc-4cbb-b641-693f3c729012@kernel.org>
Date: Mon, 13 Jan 2025 12:24:00 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
 <20250109133707.3845-2-antoniu.miclaus@analog.com>
 <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
 <2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
 <499ef047-d3fc-4d2a-ba7d-342ff08a351d@kernel.org>
 <98dad0cd3ba55411797c1871c5ceb5f656b8225b.camel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <98dad0cd3ba55411797c1871c5ceb5f656b8225b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/01/2025 12:17, Nuno Sá wrote:
> On Mon, 2025-01-13 at 11:21 +0100, Krzysztof Kozlowski wrote:
>> On 13/01/2025 10:55, Nuno Sá wrote:
>>> On Mon, 2025-01-13 at 09:37 +0100, Krzysztof Kozlowski wrote:
>>>> On Thu, Jan 09, 2025 at 03:37:05PM +0200, Antoniu Miclaus wrote:
>>>>>    clock-names:
>>>>>      description:
>>>>> -      Must be "clkin"
>>>>> -    maxItems: 1
>>>>> +      Must be "clkin" if the input reference is single ended or "clkin-
>>>>> diff"
>>>>> +      if the input reference is differential. By default single ended
>>>>> input
>>>>> is
>>>>> +      applied.
>>>>> +    enum: [clkin, clkin-diff]
>>>>> +    default: clkin
>>>>
>>>> Which pins are these? I went through adf4371 datasheet and no reference
>>>> on clock inputs like clkin or clkin-diff.
>>>>
>>>>
>>>
>>> Hmm, I guess we should call this 'refp' and 'refp-n' then (the latter seems
>>> a
>>> bit more odd)? Or just 'ref' and 'ref-diff'?
>>
>> That mistake was done at the beginning - the "clkin" is just useless
>> name. It cannot be "clkout" and it cannot be anything else than clk, so
>> it is 100% redundant.
>>
> 
> Oh sure... Makes sense and I forgot that the property is not new...
> 
>> But looking for pins brought second point - here you claim these are
>> mutually exclusive while datasheet suggests that both inputs can be
>> connected. Unless they come from the same source always?
>>
> 
> If you have a single ended input then only one pin (the positive one) will be
> used. If the input signal is differential, then both pins will be used. So they

But the clocks describe input pins, at least in typical case, so that's
my question: how many clock sources do you have here? One or two?

> are mutually exclusive... You either have single ended or a differential input. 
> And depending on the input type, the limit of the input frequency varies.

Based on this, this is the same clock, so using "diff" is not a property
of "clocks". Look at other bindings how they encode differential choice
for some signals - usually bool property, but not always - see other
adi/admv devices.

Best regards,
Krzysztof

