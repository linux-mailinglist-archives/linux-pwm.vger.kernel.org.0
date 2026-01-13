Return-Path: <linux-pwm+bounces-7895-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D5D1757B
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 09:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A4AB30057C6
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3EF3806CB;
	Tue, 13 Jan 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D4bCiz1s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F73803E1;
	Tue, 13 Jan 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293730; cv=none; b=WodNiEz3DrxaLhJpAQb4klkZ9HU7MHU++B9ihKYYOKUcYNZ+brhYO0eWicDgtKUmTeWqWPlN16IHMaHCYvZ31xQo/eup/P8h2Qd1pYntz3LbAqWsiUYh50E86zE2Vwm6dSIYFOJ6VtDQ3vKJRLARb8yZxgVybbXwOeQRbBLQT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293730; c=relaxed/simple;
	bh=eTaa7uYVYlhQUbpYnGgaDJsedn/8UNk3+6twemkS4Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZukX1NU1q3a0+1dmcA0XjcxVp5qKDP6re7aNZsGWpiq2dbkVQiodbgpXxRYyiTDkSnpX8TzsuVd6yyfa2/Xl5Noo5+/d4eTL91LzA5x5a/ry1arE5hNdBvQAddpdFbU/Uv9XxaIhNhrEzFEN+j+JA0Hnu6CL+qNp0tabog+xTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D4bCiz1s; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7A1CA1A2827;
	Tue, 13 Jan 2026 08:42:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3871B60732;
	Tue, 13 Jan 2026 08:42:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22D80103C8A64;
	Tue, 13 Jan 2026 09:41:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768293724; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pU7qH//lkIIPOm3hIL5pTBY7h36/3Zgg7ieWlukkNE0=;
	b=D4bCiz1sH77ktIaCzuq9ouXD6Bb+9rcZLbksqXn5C5ZShIDVgPNKcycB5YHLz1ljAdTywQ
	yizWUJ2Ong5/FkCDGAY2FwIRFtw57d1tgtKzXkbBUejiYBk6x84Jl+81nnJroZsIteoCc/
	HtNh0V8qXoeW6/JwFvMcybq32S+Y7BMLJlOKfQdC1+mkuUlvaOe/efPeSi9+HT3O36e085
	KVGIxEQfMxo6pGC1Nw8Ly7EpKh/QRV7ImiupwpK4xZBTi8R/8yxfH232Y0gsjoWLEh6Ogb
	vzHUA7bwXJpaICbUmsXzlCR0TknanG2tPNKrXGK9+0AHTIjUZPh3oP8iXHnX9g==
Message-ID: <d077abbb-6a4b-4349-88be-0d90e23eb570@bootlin.com>
Date: Tue, 13 Jan 2026 09:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pwm: sun50i: Add H616 PWM support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joao Schim <joao@schimsalabim.eu>
References: <20251217082504.80226-1-richard.genoud@bootlin.com>
 <20251217082504.80226-3-richard.genoud@bootlin.com>
 <en7wscywn3xpw7cxvc2ngwrmjfciglzxgaje5qc5ngiehrjufh@jbvgp2neyzzx>
 <9c55d591-a280-4ed7-91b1-0c867cfff658@bootlin.com>
 <mu3ciykmtxoaa24mdw7mofpdapbii23qrubw6uzptszok43tta@tq3rguupehwe>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <mu3ciykmtxoaa24mdw7mofpdapbii23qrubw6uzptszok43tta@tq3rguupehwe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Uwe,
>>>> +	for (unsigned int i = 0; i < data->npwm; i++) {
>>>
>>> Huh, AFAIK we're not using declarations in for loops in the kernel.
>>
>> Actually, I've read somewhere (in LWN I guess) that Linus seems ok with that,
>> but I'll remove it if you prefer.
> 
> If you find your source again, I'd be interested.
I took me some time, but I finally found it (thanks to Hervé):
https://lore.kernel.org/all/CAHk-=wiCOTW5UftUrAnvJkr6769D29tF7Of79gUjdQHS_TkF5A@mail.gmail.com/


> 
> Best regards
> Uwe

Regards,
Richard

