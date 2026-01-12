Return-Path: <linux-pwm+bounces-7894-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C5D11C23
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 11:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A08E30055A1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984429BDBA;
	Mon, 12 Jan 2026 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="WOIojuOf";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="kZ34JSvh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03C29B78D;
	Mon, 12 Jan 2026 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212883; cv=none; b=XXnSyOustDS2uUR/hsBwas/2EPLaYtSSktyjnEcqc/PLwCNssOPWJ4KUlaAcdpsGoEcTX50APLDkDztuO9N2X+7M/UxmFy645ec8GrgzzzpOEwUIAhztTs4K54tKIfOMcfMz3W0u+l6e3RgBISHVOtpnENiI4x7r2PhK20J8Jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212883; c=relaxed/simple;
	bh=TnpQUvJ527eVwMXBZYhbLsnGOQrXDJENMWY2sTT8Lv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkUd3KilybPlGIzmePo+FJjtIeQ932GFFPwMncoNS1UwtfTg6nUEqMDAjt5WdtepbamAZn5Bo86/p1IsjOIXWMt2bqUP23fS7klCMH657SQzwJIuasj/Aa8m+aTO1kczL+XBuOHTgieUMm+ygnr4p/m410NTDsoe4R0FCE+k2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=WOIojuOf; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=kZ34JSvh; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768212881; bh=TnpQUvJ527eVwMXBZYhbLsnGOQrXDJENMWY2sTT8Lv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WOIojuOfUGdy/xij8sel/MB5Xq5jZPvH4V5TRSlrWwu+9IhzRUM+R2QCiOtNxTJUv
	 e9RwQqq6c5Z9zItIWBE5vrSBgwc4urKAVbgcbJ0BIOYWeaQakeRhFQJmXIvrbx1hLl
	 1LcOt6GxPQUrPjCDXTLZyxst8fodtf3eKsDEAtxugU/ceCb4npar+Vmp9IC4eRnbs9
	 hC8bx1wSVR9SzVUKgMre32BA8iE50wOyU/DCpA28y9Afk3JuyaAx22YkI5iwv0RkxM
	 qfeMhHyVJGNYDJls1rh4STXSYnL24SiEEnseYGcrbLs9Vrpzexn1gKfdYvkkP1aiPc
	 X22Zne0zCtE6A==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id E423D3EBBAC;
	Mon, 12 Jan 2026 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768212880; bh=TnpQUvJ527eVwMXBZYhbLsnGOQrXDJENMWY2sTT8Lv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kZ34JSvhZuw4dczNIwYdjpy07yXmmOM59LEY3sf9lFrJMbsSHG3kv6sDqvGl3Sy76
	 KLp+rgAZBXcbb4M4CpD2cUhKQh0hb1Xja8/oopI/X0vdopS9ByIrhe09ToEBo5jMtL
	 8gdlN1fzuIMZjZdZ/drW6b0y7E/GUVyfxG+//VTHAALqnks21+zlXQ4XZ1yPH0ofF9
	 TiCY0T/mAdiQqNV9a5yRVNWfDh47XMl0KgdIU5h2vFSj2ij/wlXS1ATYYYIL+W/RGG
	 +JBe4CG1mXfiG3mm2vIVI68rgfNy3uPdo8uouvLxvEOgo0/4LSZdBdiLtT24y1Eb8X
	 pmsjkFjdPC+vA==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 525733EBBA0;
	Mon, 12 Jan 2026 10:14:40 +0000 (UTC)
Message-ID: <20bd5723-212b-474d-84ea-52dec73a5333@mleia.com>
Date: Mon, 12 Jan 2026 12:14:39 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Add optional Motor
 Control PWM interrupt
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260110014524.3379187-1-vz@mleia.com>
 <20260110014524.3379187-2-vz@mleia.com>
 <20260112-garnet-axolotl-of-acceptance-3978fd@quoll>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260112-garnet-axolotl-of-acceptance-3978fd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260112_101440_950511_BC358454 
X-CRM114-Status: GOOD (  12.33  )

On 1/12/26 11:10, Krzysztof Kozlowski wrote:
> On Sat, Jan 10, 2026 at 03:45:23AM +0200, Vladimir Zapolskiy wrote:
>> NXP LPC32xx Motor Control PWM has an interrupt line shared with TIMER4,
>> and the interrupt may be used to report events from programmable counters
>> e.g. timer counter limit (period), match counter (pulse-width), or from
>> counters on input lines of PWM channels.
>>
>> As a reference and for more details see NXP LPC32xx User Manual, table 595.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>   .../devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml       | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
>> index cdd83ac29caf..53520f005acb 100644
>> --- a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
>> @@ -32,6 +32,16 @@ required:
>>   
>>   allOf:
>>     - $ref: pwm.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nxp,lpc3220-motor-pwm
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          maxItems: 1
> 
> Properties must be defined in top-level. You only narrow constraints or
> disallow them :false per variant in if:then: blocks.
> 

It makes sense. In this case would it be better to split the schema file
into two, one for each PWM type? Two described PWM types are too unsimilar,
apparently it was wrong to merge them under a single .yaml file in the commit
4cd2f417a0ac ("dt-bindings: pwm: Convert lpc32xx-pwm.txt to yaml format").

-- 
Best wishes,
Vladimir

