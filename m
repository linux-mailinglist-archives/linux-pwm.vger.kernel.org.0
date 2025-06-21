Return-Path: <linux-pwm+bounces-6462-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA2FAE2A43
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED95C17795C
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4313C9C4;
	Sat, 21 Jun 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qPlu7BCi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jP5By4tz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191D19BBC;
	Sat, 21 Jun 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750522811; cv=none; b=YI15vOk3YXWEezA2N/Cz5xk/6SipS8RRePdKEPJg4E3THdYU7f/mOdoFg7OhuHgqoga/aFJJKlCFQqZ3zJ5BDqW2okO/2aRuaIWp2m6tTXQyK+3dcK3br3OLXQLFS/e8GYaErtG3IQCpjevPIf3sjoqiQN04zvDFwKvy3HOREoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750522811; c=relaxed/simple;
	bh=1kwlWE50IrDKcOsB0Q92H3E7Gf1/s26EaRGwuaWDrQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTUcPAJ5YrLuc67Bohy1Ijne6ai8rZqMnHr5I2BmK47sK8Q9uzPsUTUtJ1kGGk9cRXRxvluzVhvk00bA6gCBHnMAtgvxPu1ABZ/Wen0sQJ79vxlK1Tj30OOjHW2ZQ0A2i0GZELVFofveHYEA5mqPmD6J97bjFED4OZb+vb05HSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qPlu7BCi; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jP5By4tz; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bPfh06YPqz9snC;
	Sat, 21 Jun 2025 18:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750522800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmGkueZv92x8FVoX2PUBUwwGVfuumaUY5sT7yc1Es/s=;
	b=qPlu7BCimxSBdGvk5KOedTZYTE3w+irmAPpNZostJ+ueK+cC7donVMSG6Whhe0DBqZG2JD
	SgIaKogXo+2lKwyR2kfBuyGGe5rEOWwciwbuQtZZvKMkePAoWTsAp3j5Ehm/2Hbl3dbpBW
	0SnjohFmhfd/b30bj2YsrifuIX84i5AvioFR60TD9fV3NjDVPov0V00gGeMPfAIrWp73iK
	ZKqw8viWC8/V1HaEYnpwVQUG8PVUpa75hiFjAbtKb0DLgWPByYKg/6qhn57RoVF+CZ9YQa
	TB/U2wLcms+/e4KQFPHv0HU9fFvgf5OMn/+xwF9LcMOktJpFtGzGs+lJ/vP/1Q==
Message-ID: <9a846ef0-e558-41b7-b285-6106723f2343@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750522798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmGkueZv92x8FVoX2PUBUwwGVfuumaUY5sT7yc1Es/s=;
	b=jP5By4tzF40KKmW8w6xjwlu8B20jehJSvC8+dW+dpyBn1WhrnSqkv9wOoyauj/wzAR5vPH
	g7czqRPju9VWnds97jQz+UtBtv7nP8qXsGsL11TkBjCKWQgOC4FCDVRBqgDenLJpYXtXzc
	ReqRM+Z22sILWG5MgAsNKgRUqlQXStJ49gEouJruZGO9zWXGSW1rjdUwTy9vpXzjPZTYfs
	JGwkNulN7ZKXsM3X6dXNQOAkCDAOgqGnRdh2mXDUEmZ8bpB7narxpyOB/xU5Dg3Vv47kU+
	CwlKokVMeqCbdW9EyGucdXJfZ5B9Cho0vZwDO5t4bnWwY4Hl1U6KtFD7kl+JmQ==
Date: Sat, 21 Jun 2025 18:19:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pwm@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>
 <20250617133744.GA1888765-robh@kernel.org>
 <2e152214-5f2d-451c-8659-941184cd8fdd@mailbox.org>
 <foiatljwemu3owuogzekgiydcyedxbhb2nyvzbs53zuxx7yohs@atpwrceby5fd>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <foiatljwemu3owuogzekgiydcyedxbhb2nyvzbs53zuxx7yohs@atpwrceby5fd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mr1bsa3wx79ntexb9wpe3m78dwnswoum
X-MBO-RS-ID: a1a734fcd8b5f712755

On 6/20/25 12:27 PM, Uwe Kleine-König wrote:
> Hello Marek,

Hi,

> On Tue, Jun 17, 2025 at 03:48:13PM +0200, Marek Vasut wrote:
>> On 6/17/25 3:37 PM, Rob Herring wrote:
>>
>> [...]
>>
>>>> +++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
>>>> @@ -0,0 +1,48 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Argon40 Fan HAT PWM controller
>>>> +
>>>> +maintainers:
>>>> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> +
>>>> +description: |
>>>
>>> Don't need '|'.
>>
>> Fixed in V4 ...
> 
> That sounds as if there is already a v4 on the lists. I don't find such
> a patch series though. Am I missing something or just misinterpreting
> your words?

Its coming once I sort out all the feedback, I did not post V4 yet.

-- 
Best regards,
Marek Vasut

