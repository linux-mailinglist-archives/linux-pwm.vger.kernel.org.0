Return-Path: <linux-pwm+bounces-7808-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D7CCB747
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 11:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F0E2300889D
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D8280A29;
	Thu, 18 Dec 2025 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YUCSxJdQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDC22652D;
	Thu, 18 Dec 2025 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054495; cv=none; b=vC4pd6GdM9iSvS9hA938FAvmw5ycSCC1BWgJgA0pxz+RSMPvRMwjBQjfmVTI7tqoeT3wv2xOkAnJbqDD/DIkA4G6fAq09+oLDbBLj0ffgSNRsZVUzoM2FhHXApTv+5iD4Lf+lBBA4RKZpLWRSLX044aqPG4G9TDFiR5bd7BsrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054495; c=relaxed/simple;
	bh=kl9BmRKC/ETlO27pKtDOmO8nxjHIQw8kVe3A5sElFgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGZTzDhCgNYZnOKKefWCRmxmDRbNoGCU7vX0EpUXudXVCSRoStLtddCWg5Qb+z9YuGnlNQd4RBzpcf13bFn5PRIAwdUHxIdUWnMf7aHoernzr1a5yVc0cremfKU9Gk2408izSE8nv1HrS4sQNgtdhd/aBpDwQyqLKMOI8NatQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YUCSxJdQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9DD381A22C5;
	Thu, 18 Dec 2025 10:41:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70034606B6;
	Thu, 18 Dec 2025 10:41:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEC92102F0B4B;
	Thu, 18 Dec 2025 11:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766054488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xAfqh3tryZsL7bk4EO/IchLBlHkI/yv2iAw4kjviLco=;
	b=YUCSxJdQfdTcB0M4Q9Hv6tJl6AQ1ImSO1TotM5jebpSsyOmRI2hKSuoTBpv+XERXFCat9P
	n1ZC4D6kAiDsuwP+sSU4iL0N/PBYQ2W74Hcjw8C5wHYazjxsz431nDHeqWKpiLyv6JfoDp
	uTy8LbrFnw+KMg0mWXzaZ8p4DF4dTcm5PAAFTNM+6aVQaIjgkPROu1N18Au7yqiwBX9GxY
	TSe+HFDYkx+U5WuFvUisV+ob2uM0tds5w50w6SvmmJo5uKu/Iyu9JXIAb7binHgpYhC8CG
	SkPc2TIJlSRohX2eDt9Mv7Zno5ODadXcXCNQl8rCd4YAVvG/E2qfoG4bARvung==
Message-ID: <2a0f82e9-0a8b-45ec-9d8f-d4842ce120ad@bootlin.com>
Date: Thu, 18 Dec 2025 11:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: pwm: allwinner: add h616 pwm
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251217082504.80226-1-richard.genoud@bootlin.com>
 <20251217082504.80226-2-richard.genoud@bootlin.com>
 <52ac76fc-4362-4b5a-ae28-29b874f78399@kernel.org>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <52ac76fc-4362-4b5a-ae28-29b874f78399@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 18/12/2025 à 11:15, Krzysztof Kozlowski a écrit :
> On 17/12/2025 09:25, Richard Genoud wrote:
>> Allwinner H616 PWM block is quite different from the A10 or H6, but at
>> the end, it uses the same clocks as the H6; so the sun4i pwm binding can
>> be used.
>> It has 6 channels than can generate PWM waveforms or clocks if bypass is
>> enabled.
>>
>> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Hm? Where did I suggest anything about adding clock cells or documenting
> this allwinner device?
Hum, indeed.
The suggestion, as I understood it, was to re-use the sun4i PWM binding, 
which is why this patch exists now. But I agree, the suggestion wasn't 
on the content itself.
Sorry if it's misleading.

> 
> 
> Best regards,
> Krzysztof

Regards,
Richard

