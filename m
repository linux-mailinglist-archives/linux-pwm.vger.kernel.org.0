Return-Path: <linux-pwm+bounces-1663-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233586C445
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Feb 2024 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3233B21004
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Feb 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B054FB5;
	Thu, 29 Feb 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="k5YjcgSb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8354FA0;
	Thu, 29 Feb 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196883; cv=none; b=mmEmshx5g8WteEwK5yBLUt+WOaFpuuzx89B4oinoNhCf+axz28y+4bGRhGJL6/tFU6YKZUUVFLRAw2aMqoWUSHSPMs8PuZ7y1OIDPgwYxAY+WQrLBmwX0YlPsrPyFM948W1xn5rbcq0aTPVmqDsLgI8tKjFEl8kJ/CNFWCPT5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196883; c=relaxed/simple;
	bh=Ak8rXUZULtrRHmfF0ffCmGBhBA/0vaiKCFsiyM3s6pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiKNqml1OReSdMJTtKdZjItxC89whSYy0tgaubedP9yGQow7l0WJ6F0m3Ns7YeXUtYLBaYdgAsh4jB+viEkZMBxRftqz22BknXEEovDPEBcpcwKcQKrgU5nvYnmpSNLpZW4Y8ORJDKIo2TsEOPoSmuaP/dvApGwlTeIlpa0ujns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=k5YjcgSb; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1709196354; bh=Ak8rXUZULtrRHmfF0ffCmGBhBA/0vaiKCFsiyM3s6pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5YjcgSb0qA6yXD5ZB3RjkN7LDaCQM4rOQpU5s1ENBAt6oxqTZKmca33H4djL2DG0
	 40Lylc0SUiNPe6pqTyid911P1VT1aUEIPWk8XzxGRfKpictrLBBzoUkcjDgjUvlMY3
	 qRc3tnld4uZMPaCzmyrMSWL1RICzq6BnTTu8mkbcUVp0Ap+M7TmyHOdVgZadyDwtaj
	 izk1Qo4u591pTvsCVyk9ZUt6/LJWXxDUFpGECbdpsWLgtqXZpIETobjUn8Bl+Pi2ds
	 ke3VMRb43eG1147ZHBFg8C7kESRUzXB7WTfR1Oia4nzhP22N7S2+0DTTnxYThHcTY7
	 Iv2mVRVonbdQg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 3F8DA100778; Thu, 29 Feb 2024 08:45:54 +0000 (GMT)
Date: Thu, 29 Feb 2024 08:45:54 +0000
From: Sean Young <sean@mess.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Chris Morgan <macroalpha82@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Message-ID: <ZeBEQtI7rplfdpMT@gofer.mess.org>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
 <65de00aa.540a0220.f1081.6933@mx.google.com>
 <3e65fd65-ccfc-4a77-8934-52791662bdce@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e65fd65-ccfc-4a77-8934-52791662bdce@gmx.net>

On Tue, Feb 27, 2024 at 05:59:40PM +0100, Stefan Wahren wrote:
> Hi Chris,
> 
> Am 27.02.24 um 16:32 schrieb Chris Morgan:
> > I have a series of devices with GPIO controlled force feedback that
> > this driver helps us control better. So I'm looking forward to this,
> > thank you.
> Thanks for testing. I didn't had much time recently and i was fighting
> with hr timer resolution stuff. But will try to send the next version in
> March.
> > Note that when I set the resolution too low (I got confused and set
> > the period to 255) my device locked up hard and only a forced
> > power cycle could bring it back.
> Unfortunately this is a general design issue by driving the GPIO by a
> kernel driver and "expected" behavior. I didn't have a good solution for
> it yet.

When we reprogram the timer with hrtimer_forward(), we could check whether
we have overrun - i.e. we are already beyond the expires time. This could
be a hint that a) we cannot generate the pwm signal and b) this might
be what causes the hang, because we are returning HRTIMER_RESTART yet
no new expires has been programmed.

Crashing the machine if the period is too short is not really good enough
for mainline, I think. There is talk of pwm chardevs in the future.


Sean

