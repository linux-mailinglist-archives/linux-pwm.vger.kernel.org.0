Return-Path: <linux-pwm+bounces-5793-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F398EAA5F13
	for <lists+linux-pwm@lfdr.de>; Thu,  1 May 2025 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B245B3B50F2
	for <lists+linux-pwm@lfdr.de>; Thu,  1 May 2025 13:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322FB189905;
	Thu,  1 May 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J58UFm9g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7D2DC76A;
	Thu,  1 May 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746105301; cv=none; b=txOLz9P6NnEq6SGwbQaFNqKNUXo0y03Nli2l4Vxna+s44KUI3HBaDRJ0/zt8cxtM/L3cBmnSGUoLGeaxWf0bDoTZvDjLBVxoMr9SOQXxZhcv6hO5+GfBUlzoKBt6B6LytC0K0Lernh6ytNNCfl++wwdI7NeOcuMFeF4g5q5+iZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746105301; c=relaxed/simple;
	bh=6ptm9e4+N5Xyo1RCMVV1pfCM3SsY2ZQgu3Uh/K4ek1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrOZDWWMHcpoz3rhi6Xs2p4y+jhwZ/1qRIjuu0e1Ggycwz2bCZB84MaNeUikfaKdeIV9HKY4c5dOzW0qnq9cn84nuf9vvflsQHdVfg0gATZu01FTIFsKT4OMfClt6n60LiOE9DieEBkpQDKUd6wPmaE2GTvWOsFwFSzugaXU498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J58UFm9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA3CC4CEE4;
	Thu,  1 May 2025 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746105300;
	bh=6ptm9e4+N5Xyo1RCMVV1pfCM3SsY2ZQgu3Uh/K4ek1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J58UFm9gNYOlLCrcSO6OxX6RPkPjwASSoVPejxOPQtMgK6DVbO37HkxQPsLZz+kRv
	 PAinzrv821hFUBbMok1HnTGoVqSxpm069Q2Pi2ZzbL4rtMQedEhK25DslHGQZtgGin
	 Y/mhgOiRlU82tjDVUpLtpGYrufX6e1BP+38x2QYbY8P8rolHG4wcoVaToZxhb8iLSN
	 mTm1I0OLFr4lrPW3fIz/8zYoGlqO5vAnzcqWkzgM/jmRZKCSPzxYs3JpX0fa7mEsPI
	 ztfSGRgj3gDV7zwepeaIbQh78A2YmIr+AAS65Xo4LQ/btBt5PkjYrhB5GQLLzAOifi
	 XOJ+FUPGOvwmg==
Date: Thu, 1 May 2025 14:14:54 +0100
From: Lee Jones <lee@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: daniel.lezcano@linaro.org, alexandre.torgue@foss.st.com,
	tglx@linutronix.de, ukleinek@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jic23@kernel.org, robh@kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v6 0/7] Add STM32MP25 LPTIM support: MFD, PWM, IIO,
 counter, clocksource
Message-ID: <20250501131454.GO1567507@google.com>
References: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>

On Tue, 29 Apr 2025, Fabrice Gasnier wrote:

> This series adds support for STM32MP25 to MFD PWM, IIO, counter and
> clocksource low-power timer (LPTIM) drivers.
> This new variant is managed by using a new DT compatible string, hardware
> configuration and version registers.
> It comes with a slightly updated register set, some new features and new
> interconnect signals inside the SoC.
> Same feature list as on STM32MP1x is supported currently.
> The device tree files add all instances in stm32mp251 dtsi file.
> 
> Changes in V6
> ---
> - Fixed kernel test robot warning
>   https://lore.kernel.org/oe-kbuild-all/202504261456.aCATBoYN-lkp@intel.com/
> 
> Changes in V5
> ---
> - Add a necessary delay in clocksource driver, when enabling the timer.
> - Add collected Acks
> - Dropped IIO trigger patch as applied by Jonathan [1] (no dependency)
>   [1] https://lore.kernel.org/all/20250331110435.26157ebe@jic23-huawei/
> 
> Changes in V4
> ---
> - Simplify IIO trigger driver as per Jonathan's comments.
> - Rework clocksource driver: encapsulate mp25 changes in separate function
>   after Daniel's suggestion.
> - Add some definitions to MFD header.
> 
> Changes in V3
> ---
> - Yaml indentation issue fixed, reported by Rob's bot
> 
> Changes in V2
> ---
> - Review comments from Krzysztof
>   - Adopt compatible fallback in dt-bindings and driver
>   - drivers: drop "st,stm32mp25-..." compatibles when unused (e.g. no .data)
>   - counter driver: no update (patch dropped)
>   - defconfig: only enable the necessary config for upstream board
>   - add lptimer DT node in stm32mp257f-ev1 board
> - Add missing management of IER access for stm32mp25
> 
> Fabrice Gasnier (7):
>   dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
>   mfd: stm32-lptimer: add support for stm32mp25
>   clocksource: stm32-lptimer: add support for stm32mp25
>   pwm: stm32-lp: add support for stm32mp25
>   arm64: defconfig: enable STM32 LP timer clockevent driver
>   arm64: dts: st: add low-power timer nodes on stm32mp251
>   arm64: dts: st: use lptimer3 as tick broadcast source on
>     stm32mp257f-ev1
> 
>  .../bindings/mfd/st,stm32-lptimer.yaml        |  40 +++-
>  arch/arm64/boot/dts/st/stm32mp251.dtsi        | 177 ++++++++++++++
>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |   8 +
>  arch/arm64/configs/defconfig                  |   2 +
>  drivers/clocksource/timer-stm32-lp.c          |  61 ++++-
>  drivers/mfd/stm32-lptimer.c                   |  33 ++-
>  drivers/pwm/pwm-stm32-lp.c                    | 219 +++++++++++++++---
>  include/linux/mfd/stm32-lptimer.h             |  37 ++-
>  8 files changed, 537 insertions(+), 40 deletions(-)

Is it just the Clocksource Ack that we're waiting on now?

-- 
Lee Jones [李琼斯]

