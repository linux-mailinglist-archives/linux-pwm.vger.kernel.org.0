Return-Path: <linux-pwm+bounces-2574-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3839910F53
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998CE1F23085
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B51BB693;
	Thu, 20 Jun 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDAK5onK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A361BB68E;
	Thu, 20 Jun 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905123; cv=none; b=i8q4JskhGbMASp3TJ4bObaIaRgQS62vSR4IjHvpJMpAiYMZJpl6kmWAas4X2+IRZ3S3A01fmtoI3auo0Ts4qHDSMZLWUTKnkpciyKNOx/bswR+16aYQt/xR5TU149e+EKD75Iqc5QXy4cNfKDLYlepB0rTKX6ODiVHhPwIv90uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905123; c=relaxed/simple;
	bh=eu4204Po9QE0cYQjUDURrwCjSksfyHPOc0038gSWWEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0iYR5t+pZm7EbKZdf22IFUcVuLJKKyVufAYOCPcAeK8VJh4qikYoPxODzVdIhS3Z6yWuZ4txfcOzt+LrGKGI/6z46nyPLbGPLjI/9gR1TvusrDJVsvbiT1qsF0vyIh3jlKaC190EahFMu0wsqQgS2AW2+mH+ZCm1OgwwwSWc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDAK5onK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16421C32786;
	Thu, 20 Jun 2024 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718905123;
	bh=eu4204Po9QE0cYQjUDURrwCjSksfyHPOc0038gSWWEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDAK5onKrqnhU5bYs5axr1F0ZcK/BSq0+01f/D2Yvr21A0lXiv+VFAHRgHFt/qumm
	 KfxMCVqD1+T2Zx5DCCrefKTtncP9krvMzuY1zmPG8s68s89wpWPf1atPZxaunBkdCj
	 83fSnFHmJUGy5ddv/1hbrhHKDtj5vNYPNhR1ybXn9geYDP96R+huEH5tlitVltQpx0
	 s4zrvbC2Pv3P/MIj0w4FfSjQrKA6yZZx+XD4Hhf5eaYesvuL/sgnENd2O0cwYaOZeR
	 FrEB8k1ug51kAo8Y8R3KD/EqjVKvTpisZGmwJpvW6/p3wjQmUQRQir1Z2HJPO7v0W3
	 kFXmQLFHdRBAg==
Date: Thu, 20 Jun 2024 18:38:38 +0100
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
Message-ID: <20240620173838.GB1318296@google.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240620084451.GC3029315@google.com>
 <imyuhtcsjrbyodsndzbaqfwa4jxny25eylfdh4u4xtsiotsk5g@45l556pcrzys>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <imyuhtcsjrbyodsndzbaqfwa4jxny25eylfdh4u4xtsiotsk5g@45l556pcrzys>

On Thu, 20 Jun 2024, Uwe Kleine-König wrote:

> Hello Lee,
> 
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
> 
> Yes, because a) I was unsure what he didn't like about the subject, and
> (more importantly) b) I split the patch in question. I should have
> written that in the cover letter, sorry.
> 
> (Note I only announced to have fixed the subject prefix of the pwm
> patch. I assume you won't include that in your pull request, but if you
> do, please do s/-/: / on it. That's another thing I failed with for this
> series.)

Which patches need to be in the pull-request and which can be hoovered
up by their associated subsystems?

-- 
Lee Jones [李琼斯]

