Return-Path: <linux-pwm+bounces-8876-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJJXN1XfBWqjcwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8876-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2026 16:42:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8693554354B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2026 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7AC30760B1
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2026 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F5407572;
	Thu, 14 May 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkDt38PE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A993C4B89;
	Thu, 14 May 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769093; cv=none; b=Aikna0NqvV/qvYFwTQ3n/ymNRfW8yaK0ElYjpYfisuCYck/QpaLPHhTMMMTAOFBWuuh1R7CpLXQC6N4VGsRNrWfyEu6A+RPxZAXW0AiUO5GsIu4l18RWZN0ZpLsqrd8haFT4siTDM82GCkWDGlp6XJ1aBiR1SRQEnhBFv9VItho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769093; c=relaxed/simple;
	bh=6iGfJZhncc8TZYCUGnqm+IpTKIkhFAcFKCIJIf6eUSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ach0kzZsaNSVWQ3FSZx0em+0CJHOaIJnO+jDKV3nzhniI8mau4ZAy5m1LpisJTFuMXXru5d4JboQ3n5iLNSCpAkXg6IwldqkqPeFIrvfaTUbO+6bcsW1EJYCGpY70867m6EaWGMFAO8+bu2Tq8vlGcfTPYI6oX81MDseAmpDkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkDt38PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43CCC2BCB3;
	Thu, 14 May 2026 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769093;
	bh=6iGfJZhncc8TZYCUGnqm+IpTKIkhFAcFKCIJIf6eUSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BkDt38PEb9XlTwH7zQZH6xmvM/K8ws918v/NQNjjIfW4RE4Z1lfJPmGTlY7lNb2Dw
	 kjVJqtdvonYl5imzBcDzZAvVyr+/5/sp/gM/1SdF262ZtnWAYWf3YfqbgAoqEOHnnR
	 ntXd5rGMT5K0GoF9whvlyKxGd+aNm4HGdMANdWj9G4m6z3KIsW7WjBVCjrKXqNctNg
	 zv8WxNAtO+FtSz34keNchpmFILXSJLSf5qbQAxV3qjU8v//ESdHe68TiCOlNzhNtz+
	 DwR799y4GN7g/Z3+NH4IN5cNb23ElQEdg9Krlq6sl0Bh5z4JpWclM/ORijPtRiQ/DK
	 jnezgCT3g80Zw==
Message-ID: <1d1a21a6-720d-4e8d-9798-27f8cc593403@kernel.org>
Date: Thu, 14 May 2026 16:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: dwc: add optional reset
To: Xuyang Dong <dongxuyang@eswincomputing.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
 p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
 pinkesh.vaghela@einfochips.com
References: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
 <20260424095435.1721-1-dongxuyang@eswincomputing.com>
 <ee58a5d6-9268-445c-a270-1f4a49b49c6e@kernel.org>
 <622e18f1.5bb3.19dd36d0c40.Coremail.dongxuyang@eswincomputing.com>
 <7bd6129a-dd37-48e8-a54c-cc149a2b84a2@kernel.org>
 <1ac7fae4.5c66.19dd892ec4d.Coremail.dongxuyang@eswincomputing.com>
 <b3a1b5ba-c381-407f-9118-aac7217138af@kernel.org>
 <f4f7edf.6067.19e15df803f.Coremail.dongxuyang@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <f4f7edf.6067.19e15df803f.Coremail.dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8693554354B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8876-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,3.7.107.208:email]
X-Rspamd-Action: no action

On 11/05/2026 09:10, Xuyang Dong wrote:
>>
>> On 29/04/2026 11:30, Xuyang Dong wrote:
>>>>>>>  
>>>>>>> +allOf:
>>>>>>> +  - $ref: pwm.yaml#
>>>>>>> +
>>>>>>> +  - if:
>>>>>>> +      properties:
>>>>>>> +        compatible:
>>>>>>> +          contains:
>>>>>>> +            const: eswin,eic7700-pwm
>>>>>>
>>>>>> Same problem as v3 which I commented. I do not understand why your new
>>>>>> device has also 1 reset.
>>>>>>
>>>>>> Your commit msg MUST explain why 1 reset is valid.
>>>>>>
>>>>>
>>>>> Hi Krzysztof,
>>>>>
>>>>> Although the PWM IP supports two clock domains, each requiring a reset, 
>>>>> the EIC7700 implementation uses the same clock domain for both clock 
>>>>> signals. Therefore, the eic7700-pwm only supports one reset.
>>>>>
>>>>
>>>> If we speak about eic7700, explain why it has two resets now, according
>>>> to schema, even though you say it has not.
>>>>
>>>> But I was speaking about dw-apb-timers-pwm, which has one reset as well!
>>>> Why you are not having proper constraints? Please read writing bindings
>>>> document.
>>>>
>>>
>>> Hi Krzysztof,
>>>
>>> Let me clarify the reset signals.
>>>   - snps,dw-apb-timers-pwm2: IP spec has 2 optional reset signals (one per
>>> clock domain), SoC vendor decides whether to wire them — so maxItems: 2, 
>>> optional in required.
>>
>> Two reset signals but what is exactly optional? Each of them? Only the
>> first? Binding does not allow the first to be optional.
>>
> 
> Hi Krzysztof,
> 
> Thank you for the review. 
> 
> For the generic snps,dw-apb-timers-pwm2 binding, both reset signals 
> are now fully optional by not including resets in the required list.
> 
> When a single optional reset signal is used, the interface bus reset 
> (index 0) is used by default.
> 
> Keep the YAML as follows:
> +  resets:
> +    minItems: 1
> +    items:
> +      - description: Interface bus reset
> +      - description: PWM timer logic reset
> 
> Add the following description to the commit message:

We speak about hardware, not binding. I asked, why your new device has
only one reset.

> 
> Whether each signal is wired on a given SoC is a board integration 
> decision, so the resets property is optional for snps,dw-apb-timers-pwm2. 
> When present, up to two handles may be supplied: the bus reset is always 
> at index 0 and the timer reset at index 1.
> 
>>>   - eswin,eic7700-pwm: SoC physically ties both signals to one reset — so
>>> exactly 1, required.
>>
>> Then two would not be right and you need to restrict that.
>>
> 
> For the specific eswin,eic7700-pwm binding, the reset signal is required 
> and fixed to one via conditional schema (if:then:), with maxItems: 1 
> and resets added to required. And add an example for eswin,eic7700-pwm.
> The changes are as follows:
> 
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: eswin,eic7700-pwm
> +    then:
> +      properties:
> +        resets:
> +          maxItems: 1
> +      required:
> +        - resets
> +
> 
> +  - |
> +    pwm@50818000 {
> +      compatible = "eswin,eic7700-pwm";
> +      reg = <0x50818000 0x4000>;
> +      #pwm-cells = <3>;
> +      clocks = <&bus>, <&timer>;
> +      clock-names = "bus", "timer";
> +      resets = <&reset>;
> +    };
> 
> Then change the binding's subject from "dt-bindings: pwm: dwc: add optional 
> reset" to "dt-bindings: pwm: dwc: add eswin,eic7700-pwm compatible and resets".
> 
> Do these changes look acceptable to you?

So two resets or one reset? I am completely confused what you are
replying to.

Please read writing bindings document.

Best regards,
Krzysztof

