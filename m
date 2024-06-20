Return-Path: <linux-pwm+bounces-2558-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2074E910069
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C776E1F21C58
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3646199EBA;
	Thu, 20 Jun 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtrvQbvj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763771802E;
	Thu, 20 Jun 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875952; cv=none; b=jWYJjWLSODXpGq/d2IQ7gI7Qb/vY7FZqy9NbixU/ujox5j4m7pHByUdjlQKAU+xA/+cAQZ/z9NFaC9ekPe25lbiUGgkskq21AWFywcKKr9TsbIH8VJYYYPielckAqIiD9/HpoTrWizrYvgsxVnMjzeawTxm288aGWGcHf+qe7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875952; c=relaxed/simple;
	bh=O/Et+olhzP5XobD8bdj3w1CIIC0vknNGVO0piDAW26s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy6dEN0oOH83rk/Kv13aZ4SaybwaCo5Xwp4gfyGgiqe83UNWEJ6kzRu46LdxB+T80LvY/GFjNSaUmvfgqFTI1ZJngYxL8O+y2O0wUNn7qi0o8sEMtNVTlmmcJrr8ivzUvU3BDKQ8q9FJgLrBo5m74IbU1WvbcO75vlBCXgNb6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtrvQbvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B89C2BD10;
	Thu, 20 Jun 2024 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718875952;
	bh=O/Et+olhzP5XobD8bdj3w1CIIC0vknNGVO0piDAW26s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtrvQbvjvB3OlS0NqQVMZ78pc5yjJBlgxYROJaDdmAeUuwpZ8PiDoIYaZiiohLS/m
	 dqJQcp+fiJC0KNtb5Fs1T5S3WX79Ftgk5Y8xP62GafReVKgi1HtoSGJo7HXCJb/ihD
	 sq4+4RX9VfZBaAld4D2usmp06jkDelxewiIrEbdiY1JcRlhyizfGiKXR1apqEHkWvZ
	 Eb8ELdwoKiR/1DVZMqNE6V2lE3zd6kDsrDhZ5kom+uoxBCnIFNlgJSdHNlAeDkpyrM
	 yTK1Im4WXdZJSlwXXKMmTJpW2s+/7eteThN+IyFz4jcV0KfbPEy7p33D5fwS80kinE
	 NwQ91k8PEhPlw==
Date: Thu, 20 Jun 2024 10:32:27 +0100
From: Lee Jones <lee@kernel.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x)
 instead of TIM_DIER_CCxIE(x)
Message-ID: <20240620093227.GI3029315@google.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240620084451.GC3029315@google.com>
 <ZnPvW6Zx69wVjNRS@ishi>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnPvW6Zx69wVjNRS@ishi>

On Thu, 20 Jun 2024, William Breathitt Gray wrote:

> On Thu, Jun 20, 2024 at 09:44:51AM +0100, Lee Jones wrote:
> > On Wed, 19 Jun 2024, Uwe Kleine-König wrote:
> > 
> > > These two defines have the same purpose and this change doesn't
> > > introduce any differences in drivers/counter/stm32-timer-cnt.o.
> > > 
> > > The only difference between the two is that
> > > 
> > > 	TIM_DIER_CC_IE(1) == TIM_DIER_CC2IE
> > > 
> > > while
> > > 
> > > 	TIM_DIER_CCxIE(1) == TIM_DIER_CC1IE
> > > 
> > > . That makes it necessary to have an explicit "+ 1" in the user code,
> > > but IMHO this is a good thing as this is the code locatation that
> > > "knows" that for software channel 1 you have to use TIM_DIER_CC2IE
> > > (because software guys start counting at 0, while the relevant hardware
> > > designer started at 1).
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > > ---
> > >  drivers/counter/stm32-timer-cnt.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Did you drop William's Ack on purpose?
> > 
> > -- 
> > Lee Jones [李琼斯]
> 
> No problem, here it is again for the sake of the LKML scraper tools:
> 
> Acked-by: William Breathitt Gray <wbg@kernel.org>
> 
> Lee, do you prefer taking this patchset through your tree?

I think that would make things easier.

A pull-request for you and the PWM folk would follow.

-- 
Lee Jones [李琼斯]

