Return-Path: <linux-pwm+bounces-3218-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA9975E1A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 02:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61BA285B08
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Sep 2024 00:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426368C07;
	Thu, 12 Sep 2024 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="eBfVkyDN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E92F3E;
	Thu, 12 Sep 2024 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102082; cv=none; b=gUbFVClz9wAcTKGY/uN1iEcz23LLNgmnVzYnSFu9KaZ9fbYMapJ1WPeyRTsB+h3TmFszuYMf8ixH/jC+D0qYkP6GKPCPxmGOmPz/0K+rqJMn7FGNuVi7VkOZ5L750+HxOOWaNBlZB3RvPaI5pGkvr0mzHC2OFhdPLjUBvLErrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102082; c=relaxed/simple;
	bh=GOa4DvAI+iAtw7Bld2LWvZe2Z7Z8JBi0H6zIfMGiyA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1WuDqwJgsgW/RgidCdsiG0cM0Vs3Prtm6uDpkKnEVUlD1ZZiXvmdZDiCPubB39fbZwYUIKaqpRYUHcvWZpa3pFBhzTKGWZ8JbD/C0/o0DG8MaxPVMPPJ/AiKT5yOfhEd87yHRsarPT+wUfgIQnO7BkB5rGnk97adBSgDWYvoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=eBfVkyDN; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5621488ABF;
	Thu, 12 Sep 2024 02:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726102078;
	bh=V1pvavRlucmUWFj87Kof6Y+0KiBkjYpzg5jNu3rdjBQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eBfVkyDNh7XvfozoPzCrSFvh7eO5+SnCK7j4MTP15UZLStwpVcx1p36+dHcDpUyB/
	 xlWzTOWqUHmCp1VQV85L2HIDuRf4M07g+TZcksjAToxWEFXH2wPbw+0ZL0RYq5D4sF
	 Cxo56L3EQKEuu3ZhCkibH/wo9gvJDYF+F8y7usBbZgvoUsIYBS4H320g0eo8Ff9+wh
	 RQxt654zmeMGpvs2rlCPq45hfjepkYwVt4lBJle7+DTMouKB2mcDjhKvzKPrIKdYDV
	 Zu1DiMNyFNwlubMAukeEIv8nYGxh866blr3ckY3N0tQyOtah22MY1VJE6/s0fRWlFr
	 2qVKJQZXO087Q==
Message-ID: <7b2982e3-7193-459c-8724-c88ab6773058@denx.de>
Date: Thu, 12 Sep 2024 02:15:18 +0200
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
 <a34ae0b8-ff5c-415c-9d36-1f94fba99243@denx.de>
 <ZuIXVTk4q0eA8L7H@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZuIXVTk4q0eA8L7H@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/12/24 12:19 AM, Frank Li wrote:
> On Wed, Sep 11, 2024 at 11:14:15PM +0200, Marek Vasut wrote:
>> On 9/11/24 11:10 PM, Frank Li wrote:
>>> On Wed, Sep 11, 2024 at 10:28:52PM +0200, Marek Vasut wrote:
>>>> On 9/10/24 9:07 PM, Frank Li wrote:
>>>>> The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
>>>>> increase maxItems for clock and clock-names.
>>>>
>>>> This mentions MIPI subsystem, but the IP in question here is PWM.
>>>
>>> Here, mipi just name of subsystem, not related MIPI IP at all.
>>>
>>> There are many IP in i.MX8QXP mipi subsystem, such as i2c, PWM, MIPI PHY,
>>> MIPI controller, PLL, clock-gate, ...
>>>
>>>>
>>>> Are you sure the clock are assigned to the correct IP ?
>>>>
>>>> Shouldn't the clock be assigned to some MIPI IP instead ?
>>>>
>>>
>>> Are both question still validate if treat 'mipi' just name of subsystem.
>>>
>>>> Could you please clarify this in the commit message ?
>>>
>>> 'mipi' just name of subsystem because the major ip is for MIPI. is word
>>> 'mipi-subsystem' better?
>> Let's find out.
>>
>> What is the 32kHz clock used for in the PWM block ?
> 
> After read document again, it is one option of input, CLKSRC in PWMCR.
Thank you for checking.

It seems PWMCR CLKSRC is currently hard-coded to IPG_HIGH in this PWM 
driver, so the 32kHz clock are currently not used ?

The question is, does it make sense to add them ? And if so, what would 
be the use case compared to current IPG_HIGH ?

