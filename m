Return-Path: <linux-pwm+bounces-593-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E441B81B21C
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 10:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC8B2413B
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980E4B142;
	Thu, 21 Dec 2023 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="FwPH4GXP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907164F209;
	Thu, 21 Dec 2023 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703149765; bh=lFWTKc5mD2kTDDc0wFLLO5erlDdU0hWBc6tGlk/pGi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwPH4GXP/Fw4dYW3IFoBe9zA/+ZBHfZjWZ8wc//IKMK8DEfzMeJcjpQ2hisggK7nC
	 LW90WhFIL88Fq2qClnXa9H5/wJ/eJgJMBgd/2vCVfsMJaJrJxrhr1lt5Aazh9gEcSg
	 3/Tke6x57f0s/vqrDTnYHKIGjFRjXbK8CxhXQjAAkA8b+fcm1cWVG9yhFF9hLSuOUZ
	 exHtHZjJHkMiH68umi5+uR9NuelIoCvxVB9qL+upXoIvH/khPTLRUQ1jIDa/6o1W68
	 f4e39OxWs/hyv1ae5y+P6F24qMi9dGmsN2s3gXhf+gpDJmU59XVFlBlbcBoiC8G+TJ
	 mFtptvBOdlAig==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id C1A721000FD; Thu, 21 Dec 2023 09:09:25 +0000 (GMT)
Date: Thu, 21 Dec 2023 09:09:25 +0000
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH v10 0/6] Improve pwm-ir-tx precision
Message-ID: <ZYQAxflmh2_hjMK2@gofer.mess.org>
References: <cover.1703003288.git.sean@mess.org>
 <170308520277.565566.3116568532099401071.b4-ty@gmail.com>
 <ZYMRyijtS4mUXia1@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYMRyijtS4mUXia1@orome.fritz.box>

On Wed, Dec 20, 2023 at 05:09:46PM +0100, Thierry Reding wrote:
> On Wed, Dec 20, 2023 at 05:06:06PM +0100, Thierry Reding wrote:
> > On Tue, 19 Dec 2023 16:30:23 +0000, Sean Young wrote:
> > > The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> > > from delays as this is done in process context. Make this work in atomic
> > > context.
> > > 
> > > changes:
> > > 
> > > v10:
> > >  - Uwe Kleine-König review comments/fixes
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [6/6] media: pwm-ir-tx: Trigger edges from hrtimer interrupt context
> >       commit: 363d0e56285e80cda997d41d94c22313b673557d
> 
> Hi Sean,
> 
> I actually applied all of them (except I took patch 5 from v11), not
> sure why b4 only kept track of patch 6.

Great, thank you. I'm very pleased about this: the pwm-ir-tx driver
now produces an prefect signal on rpi. The alternative driver, gpio-ir-tx,
bitbangs and holds the cpu under spinlock for 100ms or however long the
signal is, which is just a disaster (for e.g. real time linux). This gives
us a way out.

> Mauro didn't reply when I asked
> whether he's okay with me picking this up into the PWM tree, but given
> that you're the pwm-ir-tx maintainer I think that'll be fine. If not I
> can back this out again.

Mauro is not very responsive nowadays, but I'm sure it's fine.


Sean

