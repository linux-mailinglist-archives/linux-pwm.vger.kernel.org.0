Return-Path: <linux-pwm+bounces-5217-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46012A670B6
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 11:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BF4189BBA2
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994AD204F97;
	Tue, 18 Mar 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzMzJb4S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C01DF723;
	Tue, 18 Mar 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292361; cv=none; b=a8+RIcID6E5VKDfxY6r0TVqQzcjEMRg7f3+Y//Yhvm+/CBJ+VbYHM+TbKY7AD6L2iw2meQQEXUOf+/Uj/7zaZrSqP1vOeLDXvbClyIArzBY90kmMB0iLapl42uaBWIxGK75cm0HPpwdorEmD+z2cEBRSPn1/kImHxDPu4dwq5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292361; c=relaxed/simple;
	bh=T3bHKUxclsfhdannYbovFZH5KGdJa2QdzkUB8e9znU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6UpBrABlJhZzhGlKy/j4kcDiDk24ncc8Roc3jBRpUrxA4KDEQUEsWx9k+ylUIRL8xjYbNVJcb1W+xrad7ynhpBDG5X5473M9vIgBsMysZFAkhN4/qs8TPFe9ZOFAQgHnKeHKc36L5hpyEw8ylosKLT3/ilAmCgGww51kTBbg9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzMzJb4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B009C4CEDD;
	Tue, 18 Mar 2025 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742292360;
	bh=T3bHKUxclsfhdannYbovFZH5KGdJa2QdzkUB8e9znU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzMzJb4SYQBTXA1fP2qUbk6QZQeKBJecnbTtbEdkkJb3kAPSrIUnZlr5P8QdGY68+
	 zbhh7By8hO7XZM+Qf+LLtKDkPYlunvY9wQWTcY6KqzpGxC4NFEZIy28CIXp2JoJ3Yv
	 oh0r06rr3oLVN8PySEjo0EQKzeLzGy2TBt8fyfgnDGmlIMNzT2ZJFjZP8DMqf/+1Oh
	 4CgbfwaGqLK2GJQ9umvakEflJlCFwKOREQY82ItlK32kqNQ2/Ip2XJe62Td0Yzaxgi
	 n/D77+0zWy7pfruNohI7eS7xl95QNEg0B7N8Qe/JReADC78vc1XfAOZ8GTri71RE+C
	 tHIRuBxNdtwvg==
Date: Tue, 18 Mar 2025 10:05:55 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] backlight: pwm_bl: Read back PWM period from provider
Message-ID: <Z9lFg98srzYivGoI@aspen.lan>
References: <20250226-pwm-bl-read-back-period-from-hw-v1-1-ccd1df656b23@linaro.org>
 <xltamao27utfrsax2pc6mh5tthanmrqszz4k7gyw3knqkm24xp@4tydmhfh6g4j>
 <cmjyaveolhjtfhqbjpc6ghh7g2f5jmeyavoms5lqup6dyidngl@ljvxgoyw57md>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cmjyaveolhjtfhqbjpc6ghh7g2f5jmeyavoms5lqup6dyidngl@ljvxgoyw57md>

On Thu, Feb 27, 2025 at 04:06:47AM +0100, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Feb 26, 2025 at 05:34:50PM +0100, Uwe Kleine-König wrote:
> > On Wed, Feb 26, 2025 at 05:31:08PM +0200, Abel Vesa wrote:
> > > The current implementation assumes that the PWM provider will be able to
> > > meet the requested period, but that is not always the case. Some PWM
> > > providers have limited HW configuration capabilities and can only
> > > provide a period that is somewhat close to the requested one. This
> > > simply means that the duty cycle requested might either be above the
> > > PWM's maximum value or the 100% duty cycle is never reached.
> >
> > If you request a state with 100% relative duty cycle you should get 100%
> > unless the hardware cannot do that. Which PWM hardware are you using?
> > Which requests are you actually doing that don't match your expectation?
>
> drivers/leds/rgb/leds-qcom-lpg.c (which probably should at least get
> a MAINTAINERS entry to have you CC'd considering all the PWM bits in
> it). See the following discussion (I point you to my message in the
> middle of a thread, which has a summary and probably is a good
> starting point):
>
> https://lore.kernel.org/all/vc7irlp7nuy5yvkxwb5m7wy7j7jzgpg73zmajbmq2zjcd67pd2@cz2dcracta6w/

I had a quick glance at this thread.

It sounded to me like the PWM driver was scaling the requested period
to match h/ware capability but then neglected to scale the requested
duty cycle accordingly. That means the qcomm PWM driver programming a
fractional value into the hardware that was not being anywhere close
to duty_cycle / period.

So the recommendation was to fix the PWM driver rather than have
pwm_bl.c work around it?


Daniel.

