Return-Path: <linux-pwm+bounces-8864-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CPRJIDkAWoEmAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8864-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 16:15:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3650FDE8
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 16:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F453013AB5
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7213FB07E;
	Mon, 11 May 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvCT8tLT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388983E63B8
	for <linux-pwm@vger.kernel.org>; Mon, 11 May 2026 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508427; cv=none; b=Wuc/Z9mM3RY0oASToYieiHRVeIHjS23THee2gXJ3N5CcrAhn+kCaG7sqsaQj4w5tYRpxg5Yydz9ClfNW9/66DpOrz1WD9hHXgk+ak3WcFZzLFa8ubkM7ZPOcfeA0l5XmG6Eh89AEqIcY8H/2wVICR5Ud9bmi9FEvvDmn3obgAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508427; c=relaxed/simple;
	bh=c00x+tDayDK3Kt1FSHj2HYahT1APb/2S+xJqWZhIrn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKkNHyqmPXhxxrYJFYZzTsFpkH9PxnT8mdAhtMYKJp4MuT8XWGYy0r5weu5SQ+Q5OcYfJCp73CSUqZYDY+8eWqTXfE51zO92twJqLgH+V9dStnLxqJmiu2S9ei+NpMuOQW827PkB1YP8MZEZMvQovnXew8g1ZNqP+2pYK9ykXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvCT8tLT; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f00a567cfaso2970438eec.0
        for <linux-pwm@vger.kernel.org>; Mon, 11 May 2026 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508425; x=1779113225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IIRmX8yvWOE0keIC88cl37prTEp8JFShOTj497UPSeU=;
        b=jvCT8tLTyufySXE3Kp2dHWKI8dRA2aiGt8WmikoLKpm9u0jDe9iBRWhvqC2gmoDjIj
         DxXh2U5zaPE3vmGYvIIBiFiTI03H/sTKZmx1wKXuIab4NAQROLOQH9DYYaXzvGcIW0jB
         rnMkmluC5mEo/8MpZ7bnS1nRR4JgaCaD8m+a1JF18I7pSMcBUmxLe4KPDikC3c4BKshC
         2QRQKMrICpRWaNORkhxuuA2PTJgkD0TKoe1hYgUIdjy4DWMI0lofw/qskjSG8oFeoVYm
         KuKFV1ozVcSMBpNlYTcIkaEPyEtVvmk1NBRUQyOOM82V5dEVmKnYW0vLMhLSnL5oOANR
         k17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508425; x=1779113225;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIRmX8yvWOE0keIC88cl37prTEp8JFShOTj497UPSeU=;
        b=eywMcDsLgsTkBqOPiGtuVEH/PjiJHXSCRdvJfIgbEXysPLDjezTZ7EFmmiProPXA6Y
         pUB9FGaipvbRc0y7USjJCrVLvSoff96c4Gvk3xNqMuIBBLCQ3eG/weSsTqPvDs1BZhuS
         9r5LINz98C+0HxOLMgABnLdVXjioVHZdixOIXeIaQRHuZbAIjXXE5D7+xsKiosyxc844
         W8TlBTEDNKHo8Gh4aesoVLkf/SonhjPs9ScTCqjcInflST76KZVtrdv/Nb/5VBSHnxon
         d2k5nks+6OVoo93r9jcXEIkc/8d9EQHgmqhXbYy7AUy7EcGtWcHpYmEX/cGFfbc6nLCA
         yRyg==
X-Forwarded-Encrypted: i=1; AFNElJ+qB+rG7KfM7gAFGAi/oPMjqoMX4DeJlVAPdaVjz7/yF2ZJEnh6Ch/I7UZtDx+cz+fL2Jr/TD96YlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLG+h3cAIOpWdIVvjBkopEOGo+zojQ9JTR2FRR3tRiUNiW+KB5
	PMg1+Ml7oO/0lWUNbSjIwhrEaaBy6Tme596Rsso28zOC7d//PJnq0owt
X-Gm-Gg: Acq92OFH0buT8peGjKAIyFdmR+OtWw0bUCZ5EWuK4SrTWD29uM8rMpEGhyJq0TLyibr
	VpwaBJBDo0aztG5mvrjVi/yQgjelFw+cuxSzkS6pvqGsaAPxqb8fKP+SSaV28stlRM5u1hp6ZQ5
	Rn1vJFj0JyzY5sFSM1JFNXks/JbeaW6KIpdDw+8QmXtdggCQWOfopCM7P4br7476I7ARYji+3Jm
	IOdu1lx2lED9mIwLLAxjhVVBNpt7vlTVn4zpAeJt6WUk4P/EsY2AhlPfZ8NrCaYqctqWMbMKsk4
	2PjCzZfnObQ767/QTTmb7Ca/NkqYMVp1fNw5uaBE0cmW4iTCx07B0sn5Darz9HnAd7NhcCF2Jr5
	718+zVDH9VE4nAQAiFfzDoBRit24VNkyPaVrWhlupN0ZJJqLCO11urHOaGnWnf56w0KZWvYgUXT
	6mkUwfabcmIcDfnLRK5s4gmO555KvI1X25fcBKSuPiNTPYZEtMvKiZxbDpXRRO81U2BthwB7Lu
X-Received: by 2002:a05:7301:4593:b0:2df:498e:811b with SMTP id 5a478bee46e88-2f6e25fb074mr8270299eec.7.1778508425153;
        Mon, 11 May 2026 07:07:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm13979264eec.2.2026.05.11.07.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 07:07:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b53f8ed-bfd5-47c0-a7da-146726fba593@roeck-us.net>
Date: Mon, 11 May 2026 07:07:03 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>,
 Neal Gompa <neal@gompa.dev>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Mark Kettenis <kettenis@openbsd.org>, Sasha Finkelstein <k@chaosmail.tech>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
 Joshua Peisach <jpeisach@ubuntu.com>
References: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
 <20260507-apple-m3-initial-devicetrees-v3-2-ca07c81b5dc7@jannau.net>
 <85ea46a7-1136-4ea0-9eec-7dfa465df20b@roeck-us.net>
 <20260511085028.GA192358@robin.jannau.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260511085028.GA192358@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D1C3650FDE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8864-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,jannau.net:email,ubuntu.com:email,gompa.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 01:50, Janne Grunau wrote:
> On Sun, May 10, 2026 at 08:29:39AM -0700, Guenter Roeck wrote:
>> On Thu, May 07, 2026 at 09:33:08AM +0200, Janne Grunau wrote:
>>> The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
>>> existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
>>> "apple,t8103-wdt" used by the driver.
>>
>> '"apple,t8103-wdt" used by the driver' is not true. The watchdog driver
>> only supports "apple,wdt".
> 
> It slipped my mind that
> https://lore.kernel.org/linux-watchdog/20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net/
> wasn't picked up yet.
> 

Me too. Applied both.

Thanks,
Guenter


>>
>>>
>>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>>> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
>>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>>> Signed-off-by: Janne Grunau <j@jannau.net>
>>> ---
>>>   Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>>> index 05602678c070..845b5e8b5abc 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>>> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>>> @@ -16,7 +16,9 @@ properties:
>>>     compatible:
>>>       oneOf:
>>>         - items:
>>> -          - const: apple,t6020-wdt
>>> +          - enum:
>>> +              - apple,t6020-wdt
>>> +              - apple,t8122-wdt
>>>             - const: apple,t8103-wdt
>>>         - items:
>>>             - enum:
>>
>> I second Sashiko's findings that the driver will fail to bind because it
>> only supports "apple,wdt". I would not mind and apply the patch anyway,
>> but the statement in the description is just plain wrong and thus
>> misleading. Please fix.
> 
> I would prefer if the addition of the "apple,t8103-wdt" to the driver is
> picked.
> 
> Thanks,
> 
> Janne
> 


