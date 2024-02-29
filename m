Return-Path: <linux-pwm+bounces-1664-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13C86C459
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Feb 2024 09:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA051C20953
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Feb 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5556472;
	Thu, 29 Feb 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="oQOk/lBj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1955E4B;
	Thu, 29 Feb 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197052; cv=none; b=Ci2qGuhdXpb03U404oDFsqsJ0oAd8icSLObamM4qJ8OPdZVzAgbwIo7oN4T5sPtnl92d6d1Exz/ZBnqvo/abkeA+P6Q+si+PnhcXNX2MV9lraWa8suJAcPVTIVXalPsynjnbMZaQ7GwpiRI0GExc1abCvV2UTyNIhxTAB4T09PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197052; c=relaxed/simple;
	bh=mGS4lYHxAVt7BYzfDFj+Pr2eK3MJK0exKsw5YqUxAgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6jLWBkQFhc86bb8wDspfSdxnQl51x92szeti2kUk0b6s/JEsxE9QjQrr29+gtWbkkc4906A9fTcVgJmRx4rRagOo580cgdVjfgdsp6L4ULIlT7NmPHWhn7u+JJJoZIplMSgQez97fCcECGH/3Kanx+Tf3GhnwJlCtU5fRZv0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=oQOk/lBj; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1709197047; bh=mGS4lYHxAVt7BYzfDFj+Pr2eK3MJK0exKsw5YqUxAgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQOk/lBjFOgW2j9EaHB+W1ysVr+hNg7IcWcgW7fykuYY9BfNOPMWID5EleangK4mr
	 y5ip/97RTyTVPy/9blv8iopfHgol12UsmPE5nq/2E6fSiQAu1OCUnOo5ByTxAhRAfI
	 ubAQdmkczjZ8muANoCeR+L+Lec3PJz3b3sm4PKZLILj8/n0qK4z0/L38s0nUUs5xaQ
	 xTLN0aHYmFSPFV461xX0iE1RZtduDKwimDv2FU7bSWghJAcDU9sojiEdETSxH5AFIb
	 FW1gZKFJTm7xJlzcLwGJV0GsH8MLfsCSTfzOlMqa3O1YmKuUOmtH4hXmju9SIToHVd
	 5fnStDMS7SzcQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 7C5E2100778; Thu, 29 Feb 2024 08:57:27 +0000 (GMT)
Date: Thu, 29 Feb 2024 08:57:27 +0000
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
Message-ID: <ZeBG9wFVZBpYz9SS@gofer.mess.org>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
 <65de00aa.540a0220.f1081.6933@mx.google.com>
 <3e65fd65-ccfc-4a77-8934-52791662bdce@gmx.net>
 <ZeBEQtI7rplfdpMT@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBEQtI7rplfdpMT@gofer.mess.org>

On Thu, Feb 29, 2024 at 08:45:54AM +0000, Sean Young wrote:
> On Tue, Feb 27, 2024 at 05:59:40PM +0100, Stefan Wahren wrote:
> > Hi Chris,
> > 
> > Am 27.02.24 um 16:32 schrieb Chris Morgan:
> > > I have a series of devices with GPIO controlled force feedback that
> > > this driver helps us control better. So I'm looking forward to this,
> > > thank you.
> > Thanks for testing. I didn't had much time recently and i was fighting
> > with hr timer resolution stuff. But will try to send the next version in
> > March.
> > > Note that when I set the resolution too low (I got confused and set
> > > the period to 255) my device locked up hard and only a forced
> > > power cycle could bring it back.
> > Unfortunately this is a general design issue by driving the GPIO by a
> > kernel driver and "expected" behavior. I didn't have a good solution for
> > it yet.
> 
> When we reprogram the timer with hrtimer_forward(), we could check whether
> we have overrun - i.e. we are already beyond the expires time. This could
> be a hint that a) we cannot generate the pwm signal and b) this might
> be what causes the hang, because we are returning HRTIMER_RESTART yet
> no new expires has been programmed.

I mean something like:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/rc/pwm-ir-tx.c#n144


Sean

