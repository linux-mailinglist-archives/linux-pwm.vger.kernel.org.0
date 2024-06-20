Return-Path: <linux-pwm+bounces-2556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720B90FF45
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C439C1F249AD
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422E1A8C17;
	Thu, 20 Jun 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF1lig/H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACD1A8C0B;
	Thu, 20 Jun 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873097; cv=none; b=QQDXtEJau9+KRASbXCtDvXRWs1twFIjdvFngl4axiH61A9XaGvZKmwsYc4yARVX988v84CouRNJMqig37Fymjye00RToywNm57ILtyvODL2elu//g/ot5aV6TjCzbKwRIsfhLSsIa6EeaFkciRRpJrxSW3V0RdIWn+mRWknmEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873097; c=relaxed/simple;
	bh=g9sCHOwPXjh8FEzTD/8HrE3pyN+mCBZy4wtJBPu7b7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2QfWDjXB+3WuABWPJ1vVskb//s6qTQ5WwMZwKYiCHtPzoeIwwP2+/9m3kTkBHcZOklWHPbrE73bvmaAL0Fbc4DKrX9aZVmOWZRnWBCd8WvT877jE4frfuQE2ugu5D1r0pk6UuXEqhvwF0yfLO7kYq3t7siw+BYPmNaT1eVZedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF1lig/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309ECC2BD10;
	Thu, 20 Jun 2024 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718873096;
	bh=g9sCHOwPXjh8FEzTD/8HrE3pyN+mCBZy4wtJBPu7b7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KF1lig/HOJVi8YdqwyKDsPovl8wMVEneFLEOEmECkeLiFt9vTvQwyKINK8+IfIuwI
	 yGw5HXHSFkwivUMmwgTH4XQxfhlV1cdKKarV+k6DR/k2dKZIJtJ3BPyrwp9u63HAbH
	 kTxSOnSrHfVeUG6OGkfSgbMFgYfRohuiGDLDQaBiokltB7oPRkL3wNyTql7xAQDp2y
	 JPa8cj9BrXw02ZnqMr2Me4pe9pQ1eLPOIxThDyoHDwNSuatEq9CvITiHHbrkZwmUaz
	 PZsfw6HqGgt0A933CT5c5fljlAASg9+LsVUiHaeDM++b/gXiUAvfAIg4oB0pguevpc
	 9jQu4eF9f3JBA==
Date: Thu, 20 Jun 2024 09:44:51 +0100
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
Subject: Re: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x)
 instead of TIM_DIER_CCxIE(x)
Message-ID: <20240620084451.GC3029315@google.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>

On Wed, 19 Jun 2024, Uwe Kleine-König wrote:

> These two defines have the same purpose and this change doesn't
> introduce any differences in drivers/counter/stm32-timer-cnt.o.
> 
> The only difference between the two is that
> 
> 	TIM_DIER_CC_IE(1) == TIM_DIER_CC2IE
> 
> while
> 
> 	TIM_DIER_CCxIE(1) == TIM_DIER_CC1IE
> 
> . That makes it necessary to have an explicit "+ 1" in the user code,
> but IMHO this is a good thing as this is the code locatation that
> "knows" that for software channel 1 you have to use TIM_DIER_CC2IE
> (because software guys start counting at 0, while the relevant hardware
> designer started at 1).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Did you drop William's Ack on purpose?

-- 
Lee Jones [李琼斯]

