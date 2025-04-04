Return-Path: <linux-pwm+bounces-5333-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8EA7BFB5
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7417117B119
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F01F3FE5;
	Fri,  4 Apr 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es+r2Jc5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675C1F30DD;
	Fri,  4 Apr 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777613; cv=none; b=Py9ztr1CEKFkztgtpuoq/kkFuZ8Yob6SSz0a9a3H/l+1KcvKBZFAzTj/krgcwmHcFnyJY5Nsc/fR443nnsS6LJmAv+lscOehkPqY63mOo88Gm9dDrdZTYBD07qWq4AkkszUjnSyfcc17mYlUxvh/kJOJnGjCebt2Zh8VNM7q0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777613; c=relaxed/simple;
	bh=/RZ9Jsfr5r/ynHY5LjHn47dZxf3iZyn2PfuGAOJz5PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1I6OoaKNzZyLOjJtkSFKiXPQ1Xl6vVV3Aa5KCxBrrbfWD2fY4y5qiOvi7IeX8rcDLV+7DR6cwNOCMeWlqiRVvsS5Wd39rjbW8R5rAytgtXZiA28ApRzTYwLsqg9wn5jQw3/q9KUFRvoIfp06PkXkkOJKs2GVgtX+YaadgmxTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es+r2Jc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C24DC4CEDD;
	Fri,  4 Apr 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743777612;
	bh=/RZ9Jsfr5r/ynHY5LjHn47dZxf3iZyn2PfuGAOJz5PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es+r2Jc5llwE6fe/0G2YE8Tfxo8QLszDIi+FELtIsScuyexbh7Ua23Tg3UkzVbiaK
	 Dk7CB4DvhEbYh0HIb9k3xUBvhhoBWQLEjGBeNZNTJ52NyjceFMVdYe0BS1EX3pyVY0
	 CzjXkIlAuhJ4JHEBU9qRjLtvu+Txbqe+pb87yWDbJk6Tnys0UwneBEpjog4YrET0iv
	 p6UHblTneFfbN8LAeZ62rHqSSCJMCmuoSqaaPaUCPgcqZn057vcZREwk9tQYYurXf8
	 58qiPPyYRSTLGAEeT1bt1kSoMIAl4JDMr63DwcVHla27uTPkP2A06Za4Sw+z9bMiRl
	 SKwbcDwFUGcbg==
Date: Fri, 4 Apr 2025 15:40:06 +0100
From: Lee Jones <lee@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: ukleinek@kernel.org, alexandre.torgue@foss.st.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, jic23@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, robh@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v4 2/8] mfd: stm32-lptimer: add support for stm32mp25
Message-ID: <20250404144006.GB372032@google.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
 <20250314171451.3497789-3-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314171451.3497789-3-fabrice.gasnier@foss.st.com>

On Fri, 14 Mar 2025, Fabrice Gasnier wrote:

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
> Changes in V4:
> - Add DIEROK, ARROK status flags, and their clear flags.
> Changes in V2:
> - rely on fallback compatible as no specific .data is associated to the
>   driver. Compatibility is added by reading hardware configuration
>   registers.
> - read version register, to be used by clockevent child driver
> - rename register/bits definitions
> ---
>  drivers/mfd/stm32-lptimer.c       | 33 ++++++++++++++++++++++++++-
>  include/linux/mfd/stm32-lptimer.h | 37 ++++++++++++++++++++++++++++---

At least the Clocksource driver depends on this.

I need Acks from the other Maintainers before I can merge this.

-- 
Lee Jones [李琼斯]

