Return-Path: <linux-pwm+bounces-5173-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86961A5FC3F
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 17:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4C53AD31C
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360926A1A3;
	Thu, 13 Mar 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUBDOc9w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D42698B9;
	Thu, 13 Mar 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884015; cv=none; b=XNSishg505WVpi5eE6xNBVjS15INArzd9RKzlvfsJzD+p5WSpjl85r5xdcJnb/SDlDvFyzqLOrfySmBqf77+k2d8vk+KaRWBJTjN+oFaPfilf5PadpDQ+mMHjfbBkop5/AB2w0whBx1/7NytkmLUqmB3whRpzU9o1AU/CRWT4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884015; c=relaxed/simple;
	bh=p8AVcBEQ4JH4wcFU3EvZQIw+okBDu/uodFFvEyHDmr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX56mM2sZS/1xYofO0BZvfrhF1m7cRzrOv6Xf72j1Wf2XED/k3yJo30UCk8EDhl30uGd9gfJ/YtAZO22NT3SpQdslPv1g5QTb17r5xWDbDfBsgVJ2wleH2u+TBYy7q9eJ+/ZAMjiI0VCYMNXzSUpkhdZfY6kx+dCzM6eCEa6nOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUBDOc9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124B1C4CEDD;
	Thu, 13 Mar 2025 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741884014;
	bh=p8AVcBEQ4JH4wcFU3EvZQIw+okBDu/uodFFvEyHDmr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUBDOc9w3N3QjozeGeQIILT8Mbe5q45yfDahRhGlWKbXa6cAbkX28apn5101mzy0q
	 r71b8K0QrswxlVM5UG8sxjOtJficURk0jRjeStTWrQAhljkS3N/XvAkSp3G7BRRDq/
	 jEfUNBcPn6VkQtJRHV2qR0sVlTt5RQcALX5skRPgStcridDEVUtZ/yRLq/L7zoOjR+
	 nu5W9LqomCOD6KOvsgQkcVhAb/5Q30CknG/rSnlFTV+go2RSYFjLNHbzp8kZaub6VS
	 HKRgHske4Yf60+FjEutO8HFykny5ohBDeyE/ExZDr83PIdcqsrK+PWsgOds4njbUY1
	 PWqLQw+Gk8mMw==
Date: Thu, 13 Mar 2025 16:40:08 +0000
From: Lee Jones <lee@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: ukleinek@kernel.org, alexandre.torgue@foss.st.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jic23@kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de,
	catalin.marinas@arm.com, will@kernel.org,
	devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v3 2/8] mfd: stm32-lptimer: add support for stm32mp25
Message-ID: <20250313164008.GC3645863@google.com>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
 <20250305094935.595667-3-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305094935.595667-3-fabrice.gasnier@foss.st.com>

On Wed, 05 Mar 2025, Fabrice Gasnier wrote:

> Add support for STM32MP25 SoC.
> A new hardware configuration register (HWCFGR2) has been added, to gather
> number of capture/compare channels, autonomous mode and input capture
> capability. The full feature set is implemented in LPTIM1/2/3/4. LPTIM5
> supports a smaller set of features. This can now be read from HWCFGR
> registers.
> 
> Add new registers to the stm32-lptimer.h: CCMR1, CCR2, HWCFGR1/2 and VERR.
> Update the stm32_lptimer data struct so signal the number of
> capture/compare channels to the child devices.
> Also Remove some unused bit masks (CMPOK_ARROK / CMPOKCF_ARROKCF).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in V2:
> - rely on fallback compatible as no specific .data is associated to the
>   driver. Compatibility is added by reading hardware configuration
>   registers.
> - read version register, to be used by clockevent child driver
> - rename register/bits definitions
> ---
>  drivers/mfd/stm32-lptimer.c       | 33 ++++++++++++++++++++++++++++-

Looks okay.

>  include/linux/mfd/stm32-lptimer.h | 35 ++++++++++++++++++++++++++++---

Assumingly this patch is not independent of the others?

-- 
Lee Jones [李琼斯]

