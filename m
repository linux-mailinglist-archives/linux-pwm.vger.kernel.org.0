Return-Path: <linux-pwm+bounces-8696-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cUsdEFvo7WmUogAAu9opvQ
	(envelope-from <linux-pwm+bounces-8696-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 12:26:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CEE46960E
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D10A3012EB0
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Apr 2026 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8533D4F0;
	Sun, 26 Apr 2026 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eb4I3kZa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m1973184.qiye.163.com (mail-m1973184.qiye.163.com [220.197.31.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0B30DEA6;
	Sun, 26 Apr 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777199191; cv=none; b=d4WamQpt+1J9p7Cf+k3kn1ncO4MDtpiVIiKcQOtOV20LMtSUPPekynGFJ+RaOutV/FLoc2tqeWGab9snOeKPb0FSSwVsuks2em7GxXgbvDwC9zj2CxvE0/pOYOmoVY1JOT7CXG+4XKTITZJwvn/gnpjkRuWVhvcvF/AeQEZeYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777199191; c=relaxed/simple;
	bh=NU+3pI4S3vTdc99oasSjbBJ8xb5MfMfeWxgKJ05r3B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH0CcRw+tncosI+paglJbSA4KrjJSCE6WfiG0ejcYvZWtd5H2C0KXj2n/bpSZ/FhojqmHbjSbZiM1A/PgZLZ39v42zQwMo5sltWQKIewlbJTkUksATe27hP0lOYg07br1gOyhlxyOB9TgFqpB6LCC4c0yVgeYWtXm7C1JS6SnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eb4I3kZa; arc=none smtp.client-ip=220.197.31.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.43] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c2b8e6e5;
	Sun, 26 Apr 2026 18:09:58 +0800 (GMT+08:00)
Message-ID: <544c8d66-b242-4895-b8de-2f1dfdd0c7b4@rock-chips.com>
Date: Sun, 26 Apr 2026 18:09:59 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
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
 <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dc9446f9103a3kunm6b0f68e1145d79
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQh5KTlZPHh0aGBkaTU
	MdQhpWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eb4I3kZaySR2+F0gMBqA+RVFFlrWOKdh4b1SAYLJKcnbvJzdFS3sxr68WQO9M8q2IYHeje3rvXLc0fvoKnlmY70h3B0YqxEyL/k1lwEJe3P43wERT4kvuBmCEXLea3V6AmnaLYA6wjfjEaWn+q21PmIEP8kRvTgW6DbdSnvdcoQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=sxbl4epg48KUX2MzjpAavq4/tG2sfpxD57DOODEbyl0=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: D9CEE46960E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8696-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:url,rock-chips.com:dkim,rock-chips.com:mid]

Hi Nicolas，

On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
> The Rockchip RK3576 brings with it a new PWM IP, in downstream code
> referred to as "v4". This new IP is different enough from the previous
> Rockchip IP that I felt it necessary to add a new driver for it, instead
> of shoehorning it in the old one.
> 
> Add this new driver, based on the PWM core's waveform APIs. Its platform
> device is registered by the parent mfpwm driver, from which it also
> receives a little platform data struct, so that mfpwm can guarantee that
> all the platform device drivers spread across different subsystems for
> this specific hardware IP do not interfere with each other.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   MAINTAINERS                   |   1 +
>   drivers/pwm/Kconfig           |  11 ++
>   drivers/pwm/Makefile          |   1 +
>   drivers/pwm/pwm-rockchip-v4.c | 383 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 396 insertions(+)
> 
......
> diff --git a/drivers/pwm/pwm-rockchip-v4.c b/drivers/pwm/pwm-rockchip-v4.c
> new file mode 100644
> index 000000000000..b7de72c433c5
> --- /dev/null
> +++ b/drivers/pwm/pwm-rockchip-v4.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + *
> + * A Pulse-Width-Modulation (PWM) generator driver for the generators found in
> + * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4". Uses
> + * the MFPWM infrastructure to guarantee exclusive use over the device without
> + * other functions of the device from different drivers interfering with its
> + * operation while it's active.
> + *
> + * Technical Reference Manual: Chapter 31 of the RK3506 TRM Part 1, a SoC which
> + * uses the same PWM hardware and has a publicly available TRM.
> + * https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf
> + *
> + * Authors:
> + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> + *
> + * Limitations:
> + * - The hardware supports both completing the currently running period
> + *   on disable (by switching to oneshot mode with a single repetition and
> + *   only disable when the complete irq fires), and abrupt disable (freeze).
> + *   Only the latter is implemented in the driver.
> + * - When the output is disabled, the pin will remain driven to whatever state
> + *   it last had.

This limitation exists because after disabling the PWM output via 
registers, the actual shutdown only happens after the current period 
completes.

Therefore, the better approach is to add a delay of one full period
before disabling &rockchip_mfpwm_func.core.

> + * - Adjustments to the duty cycle will only take effect during the next period.
> + * - Adjustments to the period length will only take effect during the next
> + *   period.
> + * - The hardware only supports offsets in [0, period - duty_cycle]
> + */
> +
......
> +
> +	if (wfhw->rate) {
> +		if (!was_enabled) {
> +			dev_dbg(&chip->dev, "Enabling PWM output\n");
> +			ret = clk_enable(pc->pwmf->core);
> +			if (ret)
> +				goto err_mfpwm_release;
> +			ret = clk_set_rate_exclusive(pc->pwmf->core, wfhw->rate);
> +			if (ret) {
> +				clk_disable(pc->pwmf->core);
> +				goto err_mfpwm_release;
> +			}
> +
> +			/*
> +			 * Output should be on now, acquire device to guarantee
> +			 * exclusion with other device functions while it's on.
> +			 *
> +			 * It's highly unlikely that this fails, as mfpwm has
> +			 * already been acquired before, and this is just a
> +			 * usage counter increase. Not worth the added
> +			 * complexity of clearing the PWMV4_REG_ENABLE again,
> +			 * especially considering the CTRL_UPDATE_EN behaviour.
> +			 */
> +			ret = mfpwm_acquire(pc->pwmf);
> +			if (ret) {
> +				clk_rate_exclusive_put(pc->pwmf->core);
> +				clk_disable(pc->pwmf->core);
> +				goto err_mfpwm_release;
> +			}
> +		}
> +	} else if (was_enabled) {
> +		dev_dbg(&chip->dev, "Disabling PWM output\n");

Delay for one full PWM period before disabling the dclk.

Although this may introduce some latency for disable -> re-enable 
operations, it ensures that the state after shutdown aligns with the 
actual polarity configuration.

> +		clk_rate_exclusive_put(pc->pwmf->core);
> +		clk_disable(pc->pwmf->core);
> +		/* Output is off now, extra release to balance extra acquire */
> +		mfpwm_release(pc->pwmf);
> +	}
> +
> +err_mfpwm_release:
> +	mfpwm_release(pc->pwmf);
> +
> +	return ret;
> +}
> +
> 

Best regards,
Damon


