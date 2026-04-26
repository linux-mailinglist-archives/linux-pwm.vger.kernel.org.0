Return-Path: <linux-pwm+bounces-8697-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q4m8NdHy7WkepQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8697-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 13:11:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4067469889
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 13:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EFD300E70D
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E6359703;
	Sun, 26 Apr 2026 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="k3j+KzqG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503D165F16;
	Sun, 26 Apr 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201869; cv=none; b=jZqW933EtW8l6AmqRO19BMI3o93TFeC3GKmDFGuzqArIPui8DjoK8GRqgGIr3VAddXrkZWoN2vzlFwn5/iN/tfSMyVGTTkpcPkR81Hub3EbKF4mOM2i/AaFhXsqvQQ9Mh5RIF3HKzkU1HuKjD7b5eX1zMgdlmTugLLw9UE04MzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201869; c=relaxed/simple;
	bh=3HWdO9G2DFHbWy3pq1NGFJr6mA281UK6sb66l/eo520=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQB5jIST9EVgi1hh+3vsUZeD16jK3LPYRXXSkCEeOTDv/UBgRkIAoyW//pdUnxwfvdUZmJLPdIBsiYKufkTzVZ3buRPZnYytVuT2nmp6ArOFH/eLIIwQDjJFijQL5YWtq92YXu3DqWxKYe8HujHuVnMjTv/aJK3ksDv6+cQQnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=k3j+KzqG; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.43] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c2bf0f7e;
	Sun, 26 Apr 2026 18:55:20 +0800 (GMT+08:00)
Message-ID: <91eed9a4-4dc3-4846-baf3-e9cef53be79b@rock-chips.com>
Date: Sun, 26 Apr 2026 18:55:20 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] counter: Add rockchip-pwm-capture driver
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
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-4-ae7cfbbe5427@collabora.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260420-rk3576-pwm-v5-4-ae7cfbbe5427@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9dc96df5f203a3kunm44ef251f147654
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGRhISVYdHRlPS0MZS0
	tDSUNWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=k3j+KzqGo1yaYNVbzfra2FBJAB62XBtxGRT9nkLjxBKiMb1q/TYYcRi9XcqBDo/RiMjdsaPIkvHa9ZoY23x44LOUxm+CFZK78NVUnV9cMTGU17QFoIC5YUd5A6tD1VJ9wWOAw3i5/SIB/vW3gEGp87tCuoH3P0kJQUAyzPnKtgk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=msZgS8n7WJEel0UQMVZgdBaQJewEl2x1ppuOvvbY4aQ=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: D4067469889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8697-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damon.ding@rock-chips.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:email,rock-chips.com:dkim,rock-chips.com:mid]

Hi Nicolas,

On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
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
>   MAINTAINERS                            |   1 +
>   drivers/counter/Kconfig                |  11 ++
>   drivers/counter/Makefile               |   1 +
>   drivers/counter/rockchip-pwm-capture.c | 307 +++++++++++++++++++++++++++++++++
>   4 files changed, 320 insertions(+)
> 

For functional validation, I connected PWM0/PWM1 (continuous output)
to PWM2 (capture input) pairwise.

I enabled the counter via:
/sys/bus/counter/devices/counter0/count0/enable

Then I verified the functionality by reading the count values from:
/sys/bus/counter/devices/counter0/count0/count
/sys/bus/counter/devices/counter0/count1/count

Tested-by: Damon Ding <damon.ding@rock-chips.com>

BTW: Is there any user-space test tool similar to libpwm for the
counter subsystem?

......
> diff --git a/drivers/counter/rockchip-pwm-capture.c b/drivers/counter/rockchip-pwm-capture.c
> new file mode 100644
> index 000000000000..09a92f2bc409
> --- /dev/null
> +++ b/drivers/counter/rockchip-pwm-capture.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + *
> + * A counter driver for the Pulse-Width-Modulation (PWM) hardware found on
> + * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4". It
> + * allows for measuring the high cycles and low cycles of a PWM signal through
> + * the generic counter framework, while guaranteeing exclusive use over the
> + * MFPWM device while the counter is enabled.
> + *
> + * Authors:
> + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/counter.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/rockchip-mfpwm.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#define RKPWMC_INT_MASK			(PWMV4_INT_LPC | PWMV4_INT_HPC)
> +
> +struct rockchip_pwm_capture {
> +	struct rockchip_mfpwm_func *pwmf;
> +	struct counter_device *counter;
> +};
> +
> +static struct counter_signal rkpwmc_signals[] = {
> +	{
> +		.id = 0,
> +		.name = "PWM Clock"
> +	},
> +};
> +
> +static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +};

For the capture function, it uses the PWM's reference clock (dclk) as 
the time base to measure how many reference cycles the high and low 
levels of the input waveform last respectively.

I find it a bit strange to set COUNTER_SYNAPSE_ACTION_BOTH_EDGES for 
counting. If we treat the input waveform as a sequence of square waves 
sampled by dclk cycles, it feels like we should count on a single edge 
(rising edge only) rather than both edges.

> +
> +static struct counter_synapse rkpwmc_pwm_synapses[] = {
> +	{
> +		.actions_list = rkpwmc_hpc_lpc_actions,
> +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> +		.signal = &rkpwmc_signals[0]
> +	},
> +};
> +

Best regards,
Damon


