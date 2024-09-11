Return-Path: <linux-pwm+bounces-3212-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B51975C77
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB601F2342B
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D814EC51;
	Wed, 11 Sep 2024 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="rAjdXYQf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5786143C6C;
	Wed, 11 Sep 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090388; cv=none; b=fp6TzT56I0WQznUI0s8IFAaudVxAoIU7NmFvUFhjWVk+pUDR677V8+qJ7fDgx2SMWxiXE13phzZWF23J86pPkWiZAk2mtH6Cfl51WZ336NLVanueg0chZEDyus0yWpCY9LFLd3EPZ2lD9ysWWU8+H85VPFk/qUD4gkPtgIN6/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090388; c=relaxed/simple;
	bh=PnxYhyVNbyCOopm8g5LJu3HReBrjQHCQkN49t80pc7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAbCnCNCdX4QVh3HkeO0VRKqpBEJ6dVv+x1OafAkMQ7s/0TTrcPkZWRwa5mI1IslPWf8bkhOGUf7D1N97qNuISlwj/BCtrlyXN5X7h+OrJCY3tOocn4yZ5g+eISZ1jDovlxwnuVE5vC/u9lEKHLEAhwyAJpPJq7Kh1kpw75SKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=rAjdXYQf; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0528988B67;
	Wed, 11 Sep 2024 23:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726090384;
	bh=ddpYuBZRcEsA1dU6Hx5Ycr4lFfoUaN9MGd+rgWKCyPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rAjdXYQf8csIxExtF5HSVODOC+fbUcTy+BlGK9xSTg3qNnhhx+tvnUK+7+nSOSvxO
	 gqXVpcslSnYyieEZUVqygUdpTKRh7o9Zbn5QLd3n1y63d5gT/e1onmTWj3y8g6D0U7
	 w+U5S98dA4m0C4lvw8TuwvY04MpZSXrI/mfdqAoxjg/1KHTrlFhXRrxzIRZHuWfD2L
	 wSivy9tXoiqaWa86Rs91g33nsIdYb8owQ/bqAoQerTjWMUAKQA0Kl7ip0MmPpoF31j
	 ps/2E1Y0rtG1B9hveMxKmfcjnpcNAobBSwq/GkKEAQSKC6W5RmI882incyoa68XRvL
	 DUkIwdZPwgHKQ==
Message-ID: <522db306-64b1-42f5-8446-e6dd56eea7ec@denx.de>
Date: Wed, 11 Sep 2024 23:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] pwm: imx27: Add optional 32k clock for pwm in
 i.MX8QXP MIPI subsystem
To: Frank Li <Frank.li@nxp.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pratikmanvar09@gmail.com, francesco@dolcini.it, Liu Ying <victor.liu@nxp.com>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-3-fbb047896618@nxp.com>
 <40ecdbb2-8470-4e33-8a74-ccae6532174a@denx.de>
 <ZuILmHRO9rIXfxIm@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZuILmHRO9rIXfxIm@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/11/24 11:28 PM, Frank Li wrote:
> On Wed, Sep 11, 2024 at 10:31:40PM +0200, Marek Vasut wrote:
>> On 9/10/24 9:07 PM, Frank Li wrote:
>>> From: Liu Ying <victor.liu@nxp.com>
>>>
>>> PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
>>> provides that.
>>>
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>> Change from v2 to v3
>>> - use buck clk API
>>>
>>> Change from v1 to v2
>>> - remove if check for clk
>>> - use dev_err_probe
>>> - remove int val
>>> ---
>>>    drivers/pwm/pwm-imx27.c | 13 ++++++++++++-
>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>>> index ce9208540f1b8..2a9fba6f9d0a8 100644
>>> --- a/drivers/pwm/pwm-imx27.c
>>> +++ b/drivers/pwm/pwm-imx27.c
>>> @@ -81,10 +81,11 @@
>>>    #define MX3_PWMPR_MAX			0xfffe
>>>    static const char * const pwm_imx27_clks[] = {"ipg", "per"};
>>> +static const char * const pwm_imx27_opt_clks[] = {"32k"};
>>>    #define PWM_IMX27_PER			1
>>>    struct pwm_imx27_chip {
>>> -	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks)];
>>> +	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks) + ARRAY_SIZE(pwm_imx27_opt_clks)];
>>>    	int clks_cnt;
>>>    	void __iomem	*mmio_base;
>>> @@ -371,6 +372,16 @@ static int pwm_imx27_probe(struct platform_device *pdev)
>>>    		return dev_err_probe(&pdev->dev, ret,
>>>    				     "getting clocks failed\n");
>>> +	for (i = 0; i < ARRAY_SIZE(pwm_imx27_opt_clks); i++)
>>> +		imx->clks[i + imx->clks_cnt].id = pwm_imx27_opt_clks[i];
>>> +
>>> +	ret = devm_clk_bulk_get_optional(&pdev->dev, ARRAY_SIZE(pwm_imx27_opt_clks),
>>> +					 imx->clks + imx->clks_cnt);
>>> +	if (ret)
>>> +		return dev_err_probe(&pdev->dev, ret, "get optional clocks failed\n");
>>> +
>>> +	imx->clks_cnt += ARRAY_SIZE(pwm_imx27_opt_clks);
>>> +
>>
>> This will succeed even if the regular PWM clock are invalid or not present,
>> wouldn't it? I don't think removing that protection is an improvement.
> 
> I have not touch regular PWM clock's code. Just add more optional clocks.
> 
> devm_clk_bulk_get(imx->clks);
> devm_clk_bulk_get_optional(imx->clks + required_cnt);
> 
> so imx->clks have two part {required_part, optional_part};
> 
> require part is the same as the before. If it invalidate or not present,
> driver will fail probe.

Ah, understood, thank you for clarifying.

>> Also, it is not clear whether the 32kHz clock are really supplying the PWM,
>> see my comment on 1/3 in this series.
> 
> Yes, it is for pwm.
Do the older SoCs (iMX8M or iMX6 or such) also need 32kHz clock for PWM?

I think what I am asking is, what exactly does consume the 32kHz clock 
in the PWM IP ?

