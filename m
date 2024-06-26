Return-Path: <linux-pwm+bounces-2617-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD5918576
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9D81F24B61
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95D18A923;
	Wed, 26 Jun 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5BGYU+I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19AF1836F9;
	Wed, 26 Jun 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414829; cv=none; b=tv2FIDzdch5adIIIO5qvN+Z11tg2+zkSNJ+AXIIyoq3YRT8PLupQNtoNN904KAGwh0M/VvkAYw9LqUjUgCwoPRnZuYzYM1EgXMcclXJKX2xH6uAxIt4LQdO5VNa30KtdT0yVt0w9u0befl6p2jfGx2D1cLLZL0R3pRBD5hckUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414829; c=relaxed/simple;
	bh=nyFfYXcb8BHeCVoCZIVl/CHDqWGfVZeZvhuIHlrHsVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtDrFWCC/h1GAdu94zsVYVyaUIMUCZ3Wmw7BxNS4qlpQRl6OiEtKyeERjsjy12FkcGqAipJQsictijDVcmpH+B2rcfKEGEUei6+IShP8gRt33zLWilxMlom6qrtQtMCK219S1l1n+nXogS//nvdTmiqxvjxbRRr4pgPZ8iJhDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5BGYU+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B2DC116B1;
	Wed, 26 Jun 2024 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414828;
	bh=nyFfYXcb8BHeCVoCZIVl/CHDqWGfVZeZvhuIHlrHsVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5BGYU+IwcgJQ6wzQoc8q3zuJLZ9s2znsJkN2Qr3X9/Cb0eNV3SpZM/USpdlJTQGu
	 8EqcZZWEuuEJc2FsvqCE1RgDsYSM+cwsgs/uZfnEI1gW/KGo8jFhnrE7uvEi1anaWN
	 DOgC9lo1TVq9C0LFW9qDF7ojk8D976NnIwkvCIkNRae6M+r2L9tsbjJAVbfOaw1fzf
	 +BWWGHS4tBiAfL1AZHAXAfcMBVYNtK5d/XPhdUhU4geWcsA77NyEYIDdIFzGbl9wLH
	 AM55/hnVqLmm5rODA8gHNA5zBwsQMwEgzEnkCxG7rWyJMj9oTkJi229m1e50GwOahp
	 qvo9Bl3kHrBOw==
Date: Wed, 26 Jun 2024 16:13:43 +0100
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2 0/5] mfd: stm32-timers: Make register definition more
 flexible
Message-ID: <20240626151343.GA2504017@google.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1718791090.git.u.kleine-koenig@baylibre.com>

On Wed, 19 Jun 2024, Uwe Kleine-König wrote:

> Hello,
> 
> (implicit) v1 is available at
> https://lore.kernel.org/lkml/cover.1718352022.git.u.kleine-koenig@baylibre.com
> .
> 
> Changes introduced here:
> 
>  - Split the patch removing TIM_DIER_CC_IE() and use appropriate subject
>    prefixes. Lee and William didn't like the patch touching both
>    include/linux/mfd/stm32-timers.h and
>    drivers/counter/stm32-timer-cnt.c not having a hint to the counter
>    subsystem (at least that's my interpretation of their feedback).
>    Not mentioning mfd didn't seem to be considerably better in my eyes,
>    so I split this patch.
>  - Fix typo noticed by Thorsten.
>  - Update subject prefix of the last patch to match what is usually done
>    for pwm.
> 
> I have some further updates to the pwm-stm32 driver that will probably
> go in before v6.10-rc1. They shouldn't conflict, still I'd prefer to let
> the pwm patch go in via my tree as I might have some further changes for
> that driver. So if this is merged using the mfd or counter tree, please
> skip the pwm patch. A stable branch would be welcome in this case.
> 
> Best regards
> Uwe
> 
> 
> Uwe Kleine-König (5):
>   mfd: stm32-timers: Unify alignment of register definition
>   mfd: stm32-timers: Add some register definitions with a parameter
>   counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x) instead of
>     TIM_DIER_CCxIE(x)
>   mfd: stm32-timers: Drop unused TIM_DIER_CC_IE
>   pwm: stm32: Make use of parametrised register definitions
> 
>  drivers/counter/stm32-timer-cnt.c |   4 +-
>  drivers/pwm/pwm-stm32.c           |  22 ++--
>  include/linux/mfd/stm32-timers.h  | 179 ++++++++++++++++--------------
>  3 files changed, 107 insertions(+), 98 deletions(-)
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

Applied patches 1-4 and submitted for build testing.

If all is good, I'll sent out a PR for William.

Note to self: ib-mfd-counter-5.11

-- 
Lee Jones [李琼斯]

