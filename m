Return-Path: <linux-pwm+bounces-5142-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F5AA5EA2B
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 04:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80701899666
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 03:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC178F4A;
	Thu, 13 Mar 2025 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="eOgH9qr9";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="eOgH9qr9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286171C32;
	Thu, 13 Mar 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741837074; cv=none; b=mnlhJpHzZYCe8J4RB/jNuDHzwmJtvI5I2IkGAxp9i8YSJVQERTBP/ECJV/AahQjDxl/XsCurhk+pMFVAVPDBWUNubJrnuVwg0Exjw62qbIGASXZ8B1p7mQAbMMEBnA6H4j/Av8jE7c9s4+FA9I8uSYRh8kRrTYM9VA/nNOkjldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741837074; c=relaxed/simple;
	bh=qgutmQSJZQTykjOfEgpTzKzrAn+q9wCeu7RgQnJUaIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRZIUAnr1631OrhIvncnC/ykc8uSwfx71tM/du8iCrNfHwebQZ0Bp+6WfvIuXqITSrxg3Owlo8754jd2QtxQ+neFMCzaWkNxEnvh1e5ZsUn0vhlezCYOi2Sbj/ENbwA7WKD4kjkdFLfynZEc6mDMrJYg3mN2NJyU2MoBTbV0PVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=eOgH9qr9; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=eOgH9qr9; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1741837070; bh=qgutmQSJZQTykjOfEgpTzKzrAn+q9wCeu7RgQnJUaIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eOgH9qr9kfMgykVmloDw+pcglofhsqCzEhv2jUlYsT0iX9iUxDRxH/dp3xKpb3b9K
	 A+dEr4DllWkLLoica0oSjKuawSTJ7RaR00VYLeiLRi2TjltFxFW5M9GDeEQi7qtrv5
	 SkOdejjiQfI5oaeySRZH8qYGa3IU/z4asqtXVkIJswSDt4h4rzM2BH+9NK0zLdjGiq
	 fjwl+oDyrpzlEU8tJ9OZAZhaKIZ4BKwPo34aNEXZQzIfhS8OnrQu23ENPpiW9HfAlE
	 JqKtXKH2I5zXOOgMHjkr1n1ktkeUNZ2ykh5w1tuX/sTQcLfCfIQndyfGbLciKdTgXG
	 HBAcNbIk9VtJA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 3C9DF3A89CC;
	Thu, 13 Mar 2025 03:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1741837070; bh=qgutmQSJZQTykjOfEgpTzKzrAn+q9wCeu7RgQnJUaIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eOgH9qr9kfMgykVmloDw+pcglofhsqCzEhv2jUlYsT0iX9iUxDRxH/dp3xKpb3b9K
	 A+dEr4DllWkLLoica0oSjKuawSTJ7RaR00VYLeiLRi2TjltFxFW5M9GDeEQi7qtrv5
	 SkOdejjiQfI5oaeySRZH8qYGa3IU/z4asqtXVkIJswSDt4h4rzM2BH+9NK0zLdjGiq
	 fjwl+oDyrpzlEU8tJ9OZAZhaKIZ4BKwPo34aNEXZQzIfhS8OnrQu23ENPpiW9HfAlE
	 JqKtXKH2I5zXOOgMHjkr1n1ktkeUNZ2ykh5w1tuX/sTQcLfCfIQndyfGbLciKdTgXG
	 HBAcNbIk9VtJA==
Received: from [192.168.1.228] (74-111-126-194.sta.estpak.ee [194.126.111.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 4222A3A8968;
	Thu, 13 Mar 2025 03:37:48 +0000 (UTC)
Message-ID: <5b62671c-719a-44f2-b28e-878159859a01@mleia.com>
Date: Thu, 13 Mar 2025 05:37:44 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
Content-Language: ru-RU
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, piotr.wojtaszczyk@timesys.com,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
 <57ae63a2-544b-4241-a54d-8fa9917c1e44@mleia.com>
 <yvljnqnlka3ecw2n3hw2zgfszlldvbww3k7gq72dczmf6jwzfo@4vqnygxuzvk5>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <yvljnqnlka3ecw2n3hw2zgfszlldvbww3k7gq72dczmf6jwzfo@4vqnygxuzvk5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250313_033750_272654_1B152B05 
X-CRM114-Status: UNSURE (   7.86  )
X-CRM114-Notice: Please train this message. 

Hi Uwe,

On 3/13/25 00:56, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 12, 2025 at 07:59:21PM +0200, Vladimir Zapolskiy wrote:
>>> +  "#pwm-cells":
>>> +    const: 3
>>
>> It shall be 1.
> 
> No, 3 is the right choice.
> 

could you please elaborate?

I find that here the only configurable parameter is PWM period, so it
should be sufficient to have one cell only like in marvell,pxa-pwm.yaml
or google,cros-ec-pwm.yaml.

--
Best wishes,
Vladimir

