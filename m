Return-Path: <linux-pwm+bounces-4594-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B8A0B64C
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 13:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1FC16697B
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D641CAA89;
	Mon, 13 Jan 2025 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoohdWU5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168522CF30;
	Mon, 13 Jan 2025 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769935; cv=none; b=YoLR8Pjv90oKqVSMaD8+joBjSH6PiZRk9zaDXz4408l1vUJ06Li484BcQWwUQ9p6/k7zjIEME+deBueL14o5UcWOS+8qE6rQWEePPsrfxfXndZn9GzqMYAQTATCGQk7npNTLs5JtV3tyL2zUdhmsW8/u51ksEWz9QLyP1R45k+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769935; c=relaxed/simple;
	bh=Tl8WEdfhX9UOf3ddQ1wjXuebH+A8ftC+yTOtlapkx/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbluLGNR5O5tdqcEewFttiIBKMfB2Sd+F2URZ+5XCERZ7EWkpMuDxnPovIT175DrJTATciH8mP/Mydb0rPcNPjRlLlfkyEviRcusJZdkpL778axmugploj2+J0d6w3DYSEtRh76NRPsvsG0Pc0eAklzjV4ePqRJOPuEFmkS8t1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoohdWU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218DCC4CED6;
	Mon, 13 Jan 2025 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736769934;
	bh=Tl8WEdfhX9UOf3ddQ1wjXuebH+A8ftC+yTOtlapkx/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WoohdWU5YbBBxI8nqcF/rAaJMLotkaXR0hRoH0MsQen1GSkch/m3fOKVmheuoWopG
	 brDm4hEncm8lQ0YXl1YzCOxS/e3KI9axD4ex/rUrr0ap3Qgy+R4ZdCcdVVaKtRc8PU
	 xb/l7PCCgUKiQCLKRcEKIxHHQkcMDTTdl8SYqqStTfeXLHq/4VgzxVrtvFvmztoj2P
	 AJu7VKAB45aw5JHMatStcgksoWbUtEmPaOivPKv/Cg1At93zaPz9C0kAbXuPO2M/NM
	 PxImlQFjoDTDQVvKiz6DYtGOUWGfiHHWBz2n3P+dagI8KcAwloHrrE69ci4PP/Hc+t
	 ZshmTYZcF2eaw==
Message-ID: <9f6ae7ab-bda5-4551-a679-783ccca60383@kernel.org>
Date: Mon, 13 Jan 2025 13:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
 <20250109133707.3845-2-antoniu.miclaus@analog.com>
 <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
 <2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
 <499ef047-d3fc-4d2a-ba7d-342ff08a351d@kernel.org>
 <98dad0cd3ba55411797c1871c5ceb5f656b8225b.camel@gmail.com>
 <f47bc5f9-cabc-4cbb-b641-693f3c729012@kernel.org>
 <CY4PR03MB33993668E69121A9F786E5219B1F2@CY4PR03MB3399.namprd03.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CY4PR03MB33993668E69121A9F786E5219B1F2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/01/2025 12:50, Miclaus, Antoniu wrote:
>>>
>>> Oh sure... Makes sense and I forgot that the property is not new...
>>>
>>>> But looking for pins brought second point - here you claim these are
>>>> mutually exclusive while datasheet suggests that both inputs can be
>>>> connected. Unless they come from the same source always?
>>>>
>>>
>>> If you have a single ended input then only one pin (the positive one) will be
>>> used. If the input signal is differential, then both pins will be used. So they
>>
>> But the clocks describe input pins, at least in typical case, so that's
>> my question: how many clock sources do you have here? One or two?
>>
>>> are mutually exclusive... You either have single ended or a differential input.
>>> And depending on the input type, the limit of the input frequency varies.
>>
>> Based on this, this is the same clock, so using "diff" is not a property
>> of "clocks". Look at other bindings how they encode differential choice
>> for some signals - usually bool property, but not always - see other
>> adi/admv devices.
> 
> This approach that you suggest was implemented in patch series v1 (as boolean) / v3 (as enum).
> Based on feedback in v3 received from Jonathan I switched to this. Should I revert it?

I see:
https://lore.kernel.org/lkml/20241220195220.1e1e1d6f@jic23-huawei/

I think that v3 was preferred with arguments above. You have one clock
input and you want to configure the device differently, based on how
this clock is wired. But it is still one clock.

Wait for Jonathan before reverting to v3.

Best regards,
Krzysztof

