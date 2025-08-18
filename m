Return-Path: <linux-pwm+bounces-7090-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C4B2A1D7
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 14:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC671B24652
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A4320391;
	Mon, 18 Aug 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMiZ0+i6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070532038D;
	Mon, 18 Aug 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520006; cv=none; b=teZ9irRihZqDj83wKdrG3GH4GSWCZG64xM/DmeeGms9sPyHladzuelyKNnOOtwGeo+arNEkV+C3SA2zVeU4EUmF5cw7OcmrEHHJBFBvCaMvLWgbdd5iG7W/bzCufEiUv4fA5gK8a8ECI60ScCPA023fVI8ASdaGfqPgYJ+fbpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520006; c=relaxed/simple;
	bh=t4+uhsBkQu6PC00tarer6boEHDmE/F7D2ji+WgIEBJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb2cUuqexMNDSAKRv1xfcTLpdg7dznv3emGBthbFkVU//3Ygz2MOQo/UwOCxFcJhrWFs5J2rsCI14SRKvmznct6BNKoJZ9LeDhahQCUBPRQY6a0HQzZBO2QlMHBNw3cqqCD/guIROcec66gJ9sDl0NnlJPCofaVIT+tMFwMal7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMiZ0+i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DE7C4CEEB;
	Mon, 18 Aug 2025 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755520005;
	bh=t4+uhsBkQu6PC00tarer6boEHDmE/F7D2ji+WgIEBJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMiZ0+i6ABoaGxgRcZSfRDHBY1hoSSgDV6NQcY0oF4nAJ3qurQiPlqqSBMtsOqA55
	 msgNxMnNhohSDANx3D5nXmExTjTNLwCk1bZGb7oVTC+nyfUaFvoG7p1DigqdLFAjpR
	 1TYoksrBwuVsJvk+shUMY0WHGpZTgiYAnDAy3tUoU4Lswl0rM/QG/Z0tWiFoxYRu5m
	 hZR2kGSePMH+8H0OYEwKZ9sig2+sodjuPJ5U62kRso4ojhKA/ijzbtvsXNb1kyXs9Q
	 zk8yOaG1e/XXfd6FzB83CkDi6hNVMP9bMbu70liWVHpTB8UVM8/yPqkkH/JbJTgMgV
	 n3a/+17PBD3yw==
Date: Mon, 18 Aug 2025 20:09:33 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: berlin: Fix wrong register in suspend/resume
Message-ID: <aKMX_c3gvYc6E3DT@xhacker>
References: <20250815031016.31000-1-jszhang@kernel.org>
 <rscqtwztqwtihcq7rwvyjvnkbo5bmve257i66e3it52cnft7pb@6gwbgx5o7lpt>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rscqtwztqwtihcq7rwvyjvnkbo5bmve257i66e3it52cnft7pb@6gwbgx5o7lpt>

On Sun, Aug 17, 2025 at 12:52:01PM +0200, Uwe Kleine-König wrote:
> Hello,

Hi,

> 
> On Fri, Aug 15, 2025 at 11:10:16AM +0800, Jisheng Zhang wrote:
> > The 'enable' register should be BERLIN_PWM_EN rather than
> > BERLIN_PWM_ENABLE.
> > 
> > Fixes: bbf0722c1c66 ("pwm: berlin: Add suspend/resume support")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/pwm/pwm-berlin.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> > index 831aed228caf..858d36991374 100644
> > --- a/drivers/pwm/pwm-berlin.c
> > +++ b/drivers/pwm/pwm-berlin.c
> > @@ -234,7 +234,7 @@ static int berlin_pwm_suspend(struct device *dev)
> >  	for (i = 0; i < chip->npwm; i++) {
> >  		struct berlin_pwm_channel *channel = &bpc->channel[i];
> >  
> > -		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
> > +		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_EN);
> 
> BERLIN_PWM_ENABLE is 1 and BERLIN_PWM_EN is 0. What is the effect? Is
> the low bit just ignored and the right thing happens? Or does this

operate the wrong address then kernel panic

> result in a bus exception and the machine catches fire?

Yep, cpu exception then kernel panic.

> 
> If it's more the latter than the former, I wonder how that didn't pop up
> earlier.

This bug has been fixed in vendor's repo for a long time, it's just
because we didn't upstream the fix.

Thanks

