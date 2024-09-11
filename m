Return-Path: <linux-pwm+bounces-3210-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0BE975C4D
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9201C21C3F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831314B08C;
	Wed, 11 Sep 2024 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="F3qYw2AT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73635143C6C;
	Wed, 11 Sep 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089259; cv=none; b=bUxeSp5oWVXuaP1w3TqNzUpr+JuVS1LePJffLD43CLWcNcEGwb+sP0fEuaPlNLjgdOYBAn1IvH8dHMnoyX+kGrdnpsUZ7aoSLXp//ugYXr7RqZ3bPQz4pzAJM0VkI/A2V+UWak2MIrSxCpa7Mbb7J3l1ynAG/Pm+CXp832cThLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089259; c=relaxed/simple;
	bh=/qqhuekgL5/2mokq09cTCap52gMtKBmQIhZInpvqgCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmkxd0kQ6+oy3ENeNTgnFug7fGOlcgeOS8mR7Itc9XyPdoiFHPFbUmIxRHCYvJoLInXCSvRYp46hMhuJS2bpcRGerzffW1XQcf4noVHDR3ZrNVgZUbjwEV2YkkxUKlqjY6TYTi/M0lJGg8eqvfPYgKa3MLFlpjMb7ALeDwygxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=F3qYw2AT; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 93E85882B7;
	Wed, 11 Sep 2024 23:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726089256;
	bh=5pX01IbUi1YPMQgRIwJR9xstxKGLbp3/uMr33+3I8GE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F3qYw2ATZApgZVcWZJqjO4g9PRXLYxrHEgq6O0FYzJh6+T0aICQAu0iiFkeaBZGBP
	 JYmPRV2RCKkkqpW7HBk+P38bf5W+sSZRxmfI0dVNMR5p/3e9X79fvzT1ePIPOvrOj+
	 5rejIWKHbsE53WaZXxnuhvnjDprKKovKyYC2VtG+HZLW5ja1grs2HyPmnzEKoZVfi+
	 XLHJ0hF03+qK87qvymPD2nLAODlyAL/2JduLcX+vVJTMAsFIcXiJ8Y9SSLW0KSHRHC
	 1u3NV9qTb5zyFBAedlzBinUqYFVXT1jLKOX/PjyL73cWGmEasg8Nb0TImNr5tIMd3c
	 AY29ALjkkwB2g==
Message-ID: <a34ae0b8-ff5c-415c-9d36-1f94fba99243@denx.de>
Date: Wed, 11 Sep 2024 23:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: imx: Add optional clock '32k'
To: Frank Li <Frank.li@nxp.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pratikmanvar09@gmail.com, francesco@dolcini.it,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-1-fbb047896618@nxp.com>
 <2ede9457-8102-47e4-86dd-5888b6e5b8e6@denx.de>
 <ZuIHLRhOjDOouWD7@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZuIHLRhOjDOouWD7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/11/24 11:10 PM, Frank Li wrote:
> On Wed, Sep 11, 2024 at 10:28:52PM +0200, Marek Vasut wrote:
>> On 9/10/24 9:07 PM, Frank Li wrote:
>>> The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
>>> increase maxItems for clock and clock-names.
>>
>> This mentions MIPI subsystem, but the IP in question here is PWM.
> 
> Here, mipi just name of subsystem, not related MIPI IP at all.
> 
> There are many IP in i.MX8QXP mipi subsystem, such as i2c, PWM, MIPI PHY,
> MIPI controller, PLL, clock-gate, ...
> 
>>
>> Are you sure the clock are assigned to the correct IP ?
>>
>> Shouldn't the clock be assigned to some MIPI IP instead ?
>>
> 
> Are both question still validate if treat 'mipi' just name of subsystem.
> 
>> Could you please clarify this in the commit message ?
> 
> 'mipi' just name of subsystem because the major ip is for MIPI. is word
> 'mipi-subsystem' better?
Let's find out.

What is the 32kHz clock used for in the PWM block ?

