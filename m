Return-Path: <linux-pwm+bounces-3175-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A14972395
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8637FB2396A
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 20:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0E18B461;
	Mon,  9 Sep 2024 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vn+TqAAF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A116EB55;
	Mon,  9 Sep 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913383; cv=none; b=fLTGHDoJJMewG6Vespzwlv63akdArF/yC6n01yloB3S9WziANGU26FzOsZve8V9cMbhDUO38yNFga/24bpUygwTzkdpyk6C5J+qTJ8p8wUhOWw4W5DXCu04hwAtI5yxG+alqOuv6skJFCro27EqIlzDwvi2GRjDiREHLGiC7Xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913383; c=relaxed/simple;
	bh=9Qg/whBffpQgTzV4nzL8BF5QVFakLrwBoplzeCEAj68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjhzXhiRiCxKMF3urt/hHppxxAMz/NAFcN5hPfloUWSZW92dM5Ib0tKkT/G+Skq86TrW0EXfe3UCQ3eyubn3YXL/ZLLx7x8N/O2w06255ZmzmRUwk9hGGPtmvpOEiDW5fv533abc2Cr42g3AjWXbs2rEwN2+v9NO4jeygwJJV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vn+TqAAF; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 895F188E1F;
	Mon,  9 Sep 2024 22:22:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725913380;
	bh=q+N5FF/TdNl/iXzXHe7XaDX7qzb5sWKmOL6lslePxZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vn+TqAAFXLRqUYmBUZMdYyecDUeSbD5QYItdANq1xS0j8O8s0IpZQ9FKxYsZ7rGfa
	 WbgH2awAEBa9PQ+moYGT4OpmYhUDfoULoP2Gew2Ma625sSTh/mF4/aVF+GJbHHGS5d
	 YbTgKKCdm7+3HcH3T/lztS1vutXhSCOBVISMKgGpRg4FQ1vg5a9HLKuwc7TgGcVgrK
	 JQTxOfjMDtOFnpqf4gN4JJmm5tsRZsqReoCGM77qvPnT/JDWaBrC7RILUM03oVyQFk
	 KbmpROZmgiZUMSCg4ITRzzvg6u5yCM6A/5n3onnMPofNAg6i81uBa95lSuhtu4r/GQ
	 sqHeKTrY1xgoQ==
Message-ID: <cceb5ece-3aba-45d1-a5e3-3419245f345b@denx.de>
Date: Mon, 9 Sep 2024 22:19:59 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
 kernel@pengutronix.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, pratikmanvar09@gmail.com,
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 ukleinek@kernel.org, xiaoning.wang@nxp.com
References: <20240909193855.2394830-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240909193855.2394830-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/9/24 9:38 PM, Frank Li wrote:

[...]

> +	 * Use __raw_writel() to minimize the interval between two writes to
> +	 * the SAR register to increase the fastest pwm frequency supported.
> +	 *
> +	 * When the PWM period is longer than 2us(or <500KHz), this workaround
> +	 * can solve this problem. No software workaround is available If PMW

PWM , typo

> +	 * period is shorter than IO write.
> +	 */
> +	c = clkrate * 1500;
> +	do_div(c, NSEC_PER_SEC);
> +
> +	local_irq_save(flags);
> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> +	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> +		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
> +		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
> +		    /*
> +		     * If counter is close to period, controller may roll over
> +		     * when next IO write.
> +		     */
> +		    val + c >= period_cycles)
> +			writel_relaxed(imx->duty_cycle, reg_sar);

Maybe use imx->mmio_base + MX3_PWMSAR instead of reg_sar here, to be 
consistent with imx->mmio_base + MX3_PWMSR above ?

> +	}
> +	writel_relaxed(duty_cycles, reg_sar);

Same here

> +	local_irq_restore(flags);
> +
>   	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
[...]

Looks good otherwise, thanks !

