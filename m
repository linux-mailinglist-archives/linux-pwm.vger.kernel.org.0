Return-Path: <linux-pwm+bounces-3580-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D533A997B44
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 05:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97970284341
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 03:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805D1917D2;
	Thu, 10 Oct 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Bz4DAGzl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D4BE57;
	Thu, 10 Oct 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530970; cv=none; b=bMIFuAo3bdR8WDgO2/aUKJlRcBl3UMrsBbC1JxX4MGiygcCB0JswXRupDNTrgHwV5TKdZQN3m1BOv8zJEgKhhpbtq0cT1ykIDo7ub6mKhYuP6StrVTmJVLC6f/Hy/UDAZiBaSB0bI4aa06dF6Kp3mBzorGLYgJFG/XL6QE3n/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530970; c=relaxed/simple;
	bh=PyF5geQSl03RGWICGtUFnjvq/wA03VKXDbCICjL6w14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5NCtozIfcvbnofYujDVVksWRFqi/qBLLOi2JhG1NaTb4Bpk8DDC8irEgHYvdCuFf3wf/kyHymHvnSpykEfz5B2QbTviYxUx5gy2Jsiq2s5BtRMJyUgIcBSa29xWIikHfm/AjiedoHKUWZaFOLWfAESgAjQsmcJS0LMl0f6ZQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Bz4DAGzl; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 723AF88FAB;
	Thu, 10 Oct 2024 05:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728530966;
	bh=gQnsQNQ/PBK1SteM9oC4cO5u8kTLGnBUpC1Tp8O2a+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bz4DAGzlzPqKpi94IKhRnwm9EDdVDYpweUjGZCxQC5/5v0ZScB7AHUZz99xNZ3sO4
	 fXwHcb7Wfo9g1chTT07xZ3hg5iFnq2wW6XoqMOs1YdkzmI9d3BtX9usExRCZZJQLzV
	 fO3hNP8Mq+sf/y5TZAPx6e7mnwBjwjBGeNJ724egjSM81vhEV5VWl+VcmLrtD8e50W
	 EECJ93i9aovobS4t1zqCX1ZT0BP6CJDEKP02T/pxQj/Vfe3eBSSbD8ndTnnMHse5+3
	 by8zd7hh3H5bfHb22YWv0AwSVzznnQYTNEq0KmGuZSzbip+bdhut1fsmmlM4iYJJg2
	 HMrbWIqvnBwMg==
Message-ID: <0ea547b0-5ccb-4cf7-bb57-807caf8649ca@denx.de>
Date: Thu, 10 Oct 2024 03:18:58 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.li@nxp.com>
Cc: u.kleine-koenig@baylibre.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, festevam@gmail.com, francesco@dolcini.it,
 imx@lists.linux.dev, jun.li@nxp.com, kernel@pengutronix.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 p.zabel@pengutronix.de, pratikmanvar09@gmail.com, robh@kernel.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org, xiaoning.wang@nxp.com
References: <20241008194123.1943141-1-Frank.Li@nxp.com>
 <41cc47bd-f18f-463b-a0dc-843088ecf91e@denx.de>
 <ZwajVXRwDLDg2rc7@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZwajVXRwDLDg2rc7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/9/24 5:37 PM, Frank Li wrote:
> On Wed, Oct 09, 2024 at 03:55:35AM +0200, Marek Vasut wrote:
>> On 10/8/24 9:41 PM, Frank Li wrote:
>>
>> [...]
>>
>>> +	c = clkrate * 1500;
>>> +	do_div(c, NSEC_PER_SEC);
>>> +
>>> +	local_irq_save(flags);
>>> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
>>> +
>>> +	if (duty_cycles < imx->duty_cycle && (cr & MX3_PWMCR_EN)) {
>>
>> I think you can use state->enabled instead of (cr & MX3_PWMCR_EN).
> 
> state->enabled is new state. Need check old state here. If old state is
> disable, needn't this workaround at all.
Can you add code comment like this please ?

Thank you !

