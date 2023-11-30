Return-Path: <linux-pwm+bounces-271-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB357FF2F0
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800EC1C20431
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835141C65;
	Thu, 30 Nov 2023 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceG8tyGs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB83C6B6
	for <linux-pwm@vger.kernel.org>; Thu, 30 Nov 2023 14:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82531C433C8;
	Thu, 30 Nov 2023 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701355992;
	bh=06UE3U4SFn4bgLtRE8IitgsXW8unu+tkFneXuPCGtK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceG8tyGssf2ok839w+j1pfDo2Y1FovDMbq7Z250gzWv24Q7gI4OOuw9Pr/txKsurD
	 7vO4BM/8KPnPyL8rItYMtexvfNcfE1gqhUsJP1rbGpC0p5jMWhe0aSEVgQEXECwEqe
	 oLN9IFGfKd0kEv3VmhB+7fCmq1600lnjjSVV5UPRojH06n25gosq82gjyq3ULNM8gp
	 ygbU/RKxHE090Wph04q5DmZmTGyIMIL5qQnRgMytoKLM2KFwOcv7/lZI5V1GsBiur7
	 g0mvuF/YadUtc6qLWjhtmBZNrRPFuI6JvydNw3KTVH+EbIV3redZSz+WfohyRkz8ZQ
	 34Dun9/qlSpjw==
Date: Thu, 30 Nov 2023 14:53:08 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 0/3] pwm: Alternative way to convert leds-qcom-lpg to
 devm_pwmchip_alloc()
Message-ID: <20231130145308.GB3259151@google.com>
References: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>

On Fri, 24 Nov 2023, Uwe Kleine-König wrote:

> Hello,
> 
> on my way home thinking about my pwm-lifetime series[1] it occurred to
> me how the leds-qcom-lpg driver could be converted to use
> pwmchip_alloc() much prettier. Instead of patch #102 it can just not use
> the feature to allocate private data and use (a new)
> pwmchip_{get,set}_drvdata() function pair.
> 
> The 2nd patch is just split out of the conversion. In my original series
> the equivalent was contained in the converting patch.
> 
> I'd expect that this sorts out the concerns about the ugliness I added
> in two of the "non-pure" PWM drivers. A similar approach can be used (with the
> same changes in core.c and pwm.h) for adapting the ti-sn65dsi86 driver.

This is much better, thank you.

How should this be merged?

> [1] https://lore.kernel.org/linux-pwm/20231121134901.208535-1-u.kleine-koenig@pengutronix.de
> 
> Uwe Kleine-König (3):
>   pwm: Provide wrappers for storing and getting private data
>   leds: qcom-lpg: Introduce a wrapper for getting driver data from a pwm
>     chip
>   leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
> 
>  drivers/leds/rgb/leds-qcom-lpg.c | 27 ++++++++++++++++++---------
>  drivers/pwm/core.c               |  2 ++
>  include/linux/pwm.h              | 19 +++++++++++++++++++
>  3 files changed, 39 insertions(+), 9 deletions(-)
> 
> (This base commit isn't published to not annoy the list with reports about
> failed builds because of missing changes.)
> 
> base-commit: e40bd269dc0aa05aaf5390d66428601dc7433433
> -- 
> 2.42.0
> 

-- 
Lee Jones [李琼斯]

