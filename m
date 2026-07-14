Return-Path: <linux-pwm+bounces-9723-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6J/GMlaZVmp3+wAAu9opvQ
	(envelope-from <linux-pwm+bounces-9723-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 22:17:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8140758AE9
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 22:17:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cyberchaos.dev header.s=mail header.b="tjN/8m7L";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9723-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9723-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cyberchaos.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B18CE30095D7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 20:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A4279917;
	Tue, 14 Jul 2026 20:17:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C4427FB4;
	Tue, 14 Jul 2026 20:17:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060242; cv=none; b=H7stuTHttyPkR4c54Ub/6odEH8qEbx9EIJ86OJUYHhFwTKM6fgXYXWZcfOpzIB7V8QK3/C5E50xgYA6oLTvrFY3UwiHLovuu1bRmQJSK+y68ih1eVvcUUY5cf9YPhKDlaXIl8RM1zw/zMDz7l6Y2bNXXVoomdao05L/VrFoQcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060242; c=relaxed/simple;
	bh=mCkwUnsR1fBOIOb27f0NoQumZOK3szpsu/04nApDvdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ781M3rW+Qt5fQu6h9dFC4XdJrlIQmjtoRxE6DK/O3vv4sg60JhyihD4f1ZN6ac49oluj0tiOdIxzn/uv6QwGbdvh4G+fC4IoIFQClkuK3vH1v3gSphXqIbojVTOg3A191UmZYClGYrO+J5fVZD8+bcTeZaVaIrwvYsj+YWHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=tjN/8m7L; arc=none smtp.client-ip=195.39.247.168
Message-ID: <aa4836dd-2550-40cb-b0ee-c5df1ad54ece@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1784060236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AA21xBD9Q5Qe5hVx+FxIwd0X/SmbnFEGy+/VQWU77zE=;
	b=tjN/8m7LbLXhnzZ2y4b1CDHAMtDhQ108OPUAmno49iH2axmfZYlweKYwcgWu7M0Sv/H8rF
	Fh4aGmxaUT5TJIjqUR8piJQmCuLnwhWAC3EDXHdGpecHs+j/ZHwu8xYHKrk/kQGBHxT7t6
	YB7rzvEsnVADMFnxr+P2upd8RgsgnQo=
Date: Tue, 14 Jul 2026 22:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 09/10] dt-bindings: arm: apple: Add M4 based devices
To: Sven Peter <sven@kernel.org>, Yureka Lilian <yureka@cyberchaos.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Thomas Gleixner <tglx@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Hector Martin <marcan@marcan.st>,
 Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>,
 Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-9-e5655ee56523@cyberchaos.dev>
 <cd9da9aa-6e91-4534-a86c-a4421aafbd38@kernel.org>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <cd9da9aa-6e91-4534-a86c-a4421aafbd38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyberchaos.dev,reject];
	R_DKIM_ALLOW(-0.20)[cyberchaos.dev:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9723-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[yureka@cyberchaos.dev,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:yureka@cyberchaos.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lpieralisi@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:marcan@marcan.st,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yureka@cyberchaos.dev,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[cyberchaos.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cyberchaos.dev:from_mime,cyberchaos.dev:mid,cyberchaos.dev:email,cyberchaos.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8140758AE9

On 7/14/26 21:50, Sven Peter wrote:
>
>
> On 7/5/26 15:17, Yureka Lilian wrote:
>> The Apple devices with the t8132 SoC (M4) are very similar to their M3
>> predecessors.
>>
>> In addition to the MacBook Pro and the various MacBook Air and iMac
>> variants, a Mac mini is offered again with the M4.
>>
>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>> ---
>>   Documentation/devicetree/bindings/arm/apple.yaml | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/apple.yaml 
>> b/Documentation/devicetree/bindings/arm/apple.yaml
>> index e49403c73f9d..3262292252d2 100644
>> --- a/Documentation/devicetree/bindings/arm/apple.yaml
>> +++ b/Documentation/devicetree/bindings/arm/apple.yaml
>> @@ -315,6 +315,18 @@ properties:
>>             - const: apple,t8122
>>             - const: apple,arm-platform
>
> Please also add M4 to the top of the binding in the description.
Ack
>>   +      - description: Apple M4 SoC based platforms
>> +        items:
>> +          - enum:
>> +              - apple,j604  # MacBook Pro (14-inch, M4, 2024)
>> +              - apple,j623  # iMac (24-inch, 2x USB-C, M4, 2024)
>> +              - apple,j624  # iMac (24-inch, 4x USB-C, M4, 2024)
>> +              - apple,j713  # MacBook Air (13-inch, M3, 2025)
>> +              - apple,j715  # MacBook Air (15-inch, M3, 2025)
> Copy/paste errors: these two should be M4 as well and I think the ones 
> at the top should be 2025 instead of 2024, shouldn't they?
I have the M3->M4 typo fixes queued locally. Only the MacBook Air was 
released in 2025, the others in 2024 (according to Wikipedia at least).
>
>
> Best,
>
> Sven


My intention is to rebase and send out v2 with the fixes I've 
accumulated locally once the M3 Pro/Max device trees have been merged 
into apple-soc.



Thanks,

— Yureka


