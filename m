Return-Path: <linux-pwm+bounces-7507-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94ABC1444F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F673A65EF
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227072F12CD;
	Tue, 28 Oct 2025 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bEruiZnB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com [220.197.32.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87F22D7A5;
	Tue, 28 Oct 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649562; cv=none; b=Avy1yxbasEaDewGyyMVt3kDDthMf9/kZ1vWcgRX2YDKyaQF93urWGduUEqmgN7WyapgYJO2jK9jXX5L+Bw50bUAmMZwWdOUQG8iD3hoceXEd5X3t139h+9KP8RXc8LUhL38pLG5GbnJQDOrUrXN51VJudnEJppOMVzSNmqNb9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649562; c=relaxed/simple;
	bh=DCoMGRIHlQtoLLO1bGNuOufjU661UemuV7j+kHMgpOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czosaLzB+ddQaF5wHLlxY0IFzzAByg31ChlB6bbiXva08NRQUEFqjue+po5oiu0x3xmYyHPYL+dkWrn4+sjUD30PPrQ3sAV3tPHX9111T4RZ6EsEql7XKL3jTuhYEQps0MMW76MBeG2Q6chmxBMG+7wjYbBj1mEERFw6Z/pYgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bEruiZnB; arc=none smtp.client-ip=220.197.32.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 277c22857;
	Tue, 28 Oct 2025 19:05:48 +0800 (GMT+08:00)
Message-ID: <2822bc51-2c3c-423c-8777-af52c5f0da95@rock-chips.com>
Date: Tue, 28 Oct 2025 19:05:47 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] counter: Add rockchip-pwm-capture driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-4-654a5cb1e3f8@collabora.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20251027-rk3576-pwm-v3-4-654a5cb1e3f8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a2a7edc5f03a3kunmddd3695f160f5d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx5MSFZLSxhPSUoeTEtCSR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bEruiZnB71xueUYJgaoCvzPxOfhsvA5KMVFq3QVee2vR0a5M2oLjHIWURnA/KnjEX9jELibw9sz3H5zs3QUAKS3dU3FwLNfzzqsk82FV+DOfPAz3rdWepdDZtXXg60FUw2P43lkXid+u9eveq7Kj7mQl/CrSQs3xG3yIg/CtrBw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=K2mscf8leSzJwhOu2M/nnAE9gaYBbj3LyHdaS1gioCE=;
	h=date:mime-version:subject:message-id:from;

Hi Nicolas,

On 10/28/2025 1:11 AM, Nicolas Frattaroli wrote:
> Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
> PWM capture functionality.
> 
> Add a basic driver for this that works to expose HPC/LPC counts and
> state change events to userspace through the counter framework. It's
> quite basic, but works well enough to demonstrate the device function
> exclusion stuff that mfpwm does, in order to eventually support all the
> functions of this device in drivers within their appropriate subsystems,
> without them interfering with each other.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---

......

> +
> +/*
> + * Channel 0 receives a state changed notification whenever the LPC interrupt
> + * fires.
> + *
> + * Channel 1 receives a state changed notification whenever the HPC interrupt
> + * fires.
> + */
> +static struct counter_signal rkpwmc_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "Channel 0"
> +	},
> +	{
> +		.id = 1,
> +		.name = "Channel 1"
> +	},
> +};
> +
> +static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +

Redundant blank line. ;-)

If the dclk cycle is regarded as the 'input signal', then the HPC/LPC 
counters should be COUNTER_SYNAPSE_ACTION_BOTH_EDGES.

If to deal with the interrupt for HPC or LPC, the LPC interrupt occurs 
in several pclk cycles after the rising edge while the HPC interrupt is 
generated similarly after the falling edge. Shall we distinguish the 
synapses between LPC and HPC? LPC is COUNTER_SYNAPSE_ACTION_RISING_EDGE 
and HPC is COUNTER_SYNAPSE_ACTION_FALLING_EDGE.

> +};
> +
> +static struct counter_synapse rkpwmc_pwm_synapses[] = {
> +	{
> +		.actions_list = rkpwmc_hpc_lpc_actions,
> +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> +		.signal = &rkpwmc_signals[0]
> +	},
> +	{
> +		.actions_list = rkpwmc_hpc_lpc_actions,
> +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> +		.signal = &rkpwmc_signals[1]
> +	},
> +};
> +
> +static const enum counter_function rkpwmc_functions[] = {
> +	COUNTER_FUNCTION_INCREASE,
> +};
> +

......

> +
> +static struct counter_comp rkpwmc_ext[] = {
> +	COUNTER_COMP_ENABLE(rkpwmc_enable_read, rkpwmc_enable_write),
> +};
> +
> +enum rkpwmc_count_id {
> +	COUNT_LPC = 0,
> +	COUNT_HPC = 1,
> +};
> +
> +static struct counter_count rkpwmc_counts[] = {
> +	{
> +		.id = COUNT_LPC,
> +		.name = "PWM core clock cycles during which the signal was low",
> +		.functions_list = rkpwmc_functions,
> +		.num_functions = ARRAY_SIZE(rkpwmc_functions),
> +		.synapses = rkpwmc_pwm_synapses,
> +		.num_synapses = ARRAY_SIZE(rkpwmc_pwm_synapses),
> +		.ext = rkpwmc_ext,
> +		.num_ext = ARRAY_SIZE(rkpwmc_ext),
> +	},
> +	{
> +		.id = COUNT_HPC,
> +		.name = "PWM core clock cycles during which the signal was high",
> +		.functions_list = rkpwmc_functions,
> +		.num_functions = ARRAY_SIZE(rkpwmc_functions),
> +		.synapses = rkpwmc_pwm_synapses,
> +		.num_synapses = ARRAY_SIZE(rkpwmc_pwm_synapses),
> +		.ext = rkpwmc_ext,
> +		.num_ext = ARRAY_SIZE(rkpwmc_ext),
> +	},
> +};
> +
> 

Additionally, I test the capture by connecting pwm0_ch0 and pwm2_ch0, 
and the capture results are correct.

I think the counter/frequency meter/biphasic counter functions can also 
be adapted to the counter framework. And they will be available soon in 
the future. :-)

Best regards,
Damon


