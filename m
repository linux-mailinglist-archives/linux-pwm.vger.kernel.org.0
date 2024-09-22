Return-Path: <linux-pwm+bounces-3322-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C180197E3BB
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Sep 2024 23:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590A31F2125A
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Sep 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584E768EF;
	Sun, 22 Sep 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="UwHc0Xap"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E12B9B4;
	Sun, 22 Sep 2024 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727041322; cv=none; b=lQmj52KX7RlKiSH6Z5OdBASK4iaEcERQSruLQdv84deXIGWr2pGyN7ehaGXMW/lhFVZfwpDhtPZHIiH0WNrtWx87r8IGWR/UGwXc+zuDcqoQCVXFE/KsAms5/C92SUU8gfN82xhVxI4pLXIA3Ouicn+7qAuGYZZBC6wLbfH/Wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727041322; c=relaxed/simple;
	bh=RbsB7lsvyOsZ0dTvImk2Oj3Ixw6IoZl8Fz3E0VPnKfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYOOEUJHMK1sWIYMzifTPl9zhki17/lHfjXZLECt9yuYRQh79baFhHsuQxtGHROw0ih5fRGZ+JBcKfZDBPHbHIkoEJx9LA+NXgsFDxdR/gAdlnrnQQDYXJanFLUmQQy3LpIlnKDiA98flPjzBzMHTHXR8APkGdKZS3l2F0CtuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=UwHc0Xap; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CBA23888B7;
	Sun, 22 Sep 2024 23:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727041313;
	bh=OeoZq3/qGvqIVWMMmedNVeIHba/YDnXg02p2YwetYOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UwHc0Xap3IpcE094oz0WCJgf3L1yZOLS648xCIUrQrGeYvLJIJ0hqS80r8aIqmahr
	 hS1U4Dim52wR8jqV42VmF3GUiArIaZCS/M0spfB+zeOS7NyafFCltURLaawlpDSMoY
	 Fwb9kz4lIMsooliYL07055+YbF8CWCWb9A5BsXLG6pdAtLLtmT373F6Pejja8QMh5u
	 +JzbtupSmVsIWa7Yw0WDC4ifVRHGVmIXC2nEatX4RVFDI9VIQUG2zSt9xse28+ti0i
	 +EJVvZNbAmE1RNxfiScf4vg9Px17c8DUNzs9Jkw/Cn685tFCB2l3UShkgtT3t5tQWS
	 JQJllBRIk73Uw==
Message-ID: <4bbee009-3985-4679-a85e-76f4259ff8d6@denx.de>
Date: Sun, 22 Sep 2024 22:28:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
 kernel@pengutronix.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, pratikmanvar09@gmail.com,
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 ukleinek@kernel.org, xiaoning.wang@nxp.com
References: <20240917192510.3031493-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240917192510.3031493-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 9/17/24 9:25 PM, Frank Li wrote:

[...]

> @@ -223,6 +224,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>   	unsigned long long c;
>   	unsigned long long clkrate;
> +	unsigned long flags;
> +	int val;
>   	int ret;
>   	u32 cr;
>   
> @@ -263,7 +266,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,

[...]

> +	c = clkrate * 1500;
> +	do_div(c, NSEC_PER_SEC);
> +
> +	local_irq_save(flags);
> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));

I think the multi-write I mentioned in v5 for > 500 kHz case could 
further improve the patch, let's see what others think:

if (state->period < 2000) { /* 2000ns = 500 kHz */
    /* Best effort attempt to fix up >500 kHz case */
    udelay(6); /* 2us per FIFO entry, 3 FIFO entries written => 6 us */
    writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
    writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
    /* Last write is outside, after this conditional */
} else if (duty_cycles ...

> +	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> +		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
> +		/*
> +		 * If counter is close to period, controller may roll over when
> +		 * next IO write.
> +		 */

c is only used in this if (duty_cycles ...) { } conditional, the 
do_div() above can be moved here:

	c = clkrate * 1500;
	do_div(c, NSEC_PER_SEC);

> +		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
> +		    val + c >= period_cycles)
> +			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> +	}
> +	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	local_irq_restore(flags);

