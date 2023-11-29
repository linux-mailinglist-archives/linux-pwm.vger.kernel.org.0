Return-Path: <linux-pwm+bounces-223-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F07FD1B0
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 10:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2AE283795
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3DD12B7F;
	Wed, 29 Nov 2023 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="j9c8t25h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874A85;
	Wed, 29 Nov 2023 01:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701248857; bh=MxUryVoPVuqc8qu9wP86kz9GHNHSIGe1UNdivmza+6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9c8t25hLZJsozRtTBaNhLoj/t99xeMdmAkcekGME2psqMNdAm4GTkYl70HG+PNre
	 QVSy4PdC2FGq8SB0t2Qypdg7k3hDSSTFc8sPTIrP+ZD9X+y3MN20zQvY0WIeZoo3dR
	 q/45oByqYGu9kkAdUrc36gEhASWcTT3gMIPWch+r82uIaf5t1XEdL3U9KdLnB9k4D1
	 qwC0aPIWgcc7M2R2Em2i8U1P0UOhAdRx/ZfHygKqsmFC68hKE+97pjYWd2In9RjeO4
	 cxm/v+W+bz3YX3uMlYqK5dM1lmiT86XEluXCSn+ATD31jjvxTrqdy+Lal8HDTMaell
	 kI0+G7Hj4I1bA==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 373ED100100; Wed, 29 Nov 2023 09:07:37 +0000 (GMT)
Date: Wed, 29 Nov 2023 09:07:37 +0000
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZWb_WR1T9HiQuiBs@gofer.mess.org>
References: <cover.1700323916.git.sean@mess.org>
 <ab49d3c11dd3fa432459cc8e11a77127f1a803dd.1700323916.git.sean@mess.org>
 <ZWCm8_S7epYQwZiG@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWCm8_S7epYQwZiG@orome.fritz.box>

On Fri, Nov 24, 2023 at 02:36:51PM +0100, Thierry Reding wrote:
> On Sat, Nov 18, 2023 at 04:16:18PM +0000, Sean Young wrote:
> [...]
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index c4b066f7c5097..495aba06c64c3 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -286,6 +286,7 @@ struct pwm_ops {
> >   * @npwm: number of PWMs controlled by this chip
> >   * @of_xlate: request a PWM device given a device tree PWM specifier
> >   * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
> > + * @atomic: can the driver execute pwm_apply_cansleep in atomic context
> 
> I'm a little reluctant to suggest that we rename this to might_sleep as
> well because it would require that we audit each and every driver to set
> this properly, since by default all devices have so far been defaulting
> to "might_sleep". But then again, I think that's something that we're
> going to need to do at some point anyway.
> 
> In the interim, I think we could keep it like this and address this as a
> follow-up.

Yes, I agree that the name atomic is not ideal. However, calling it
might_sleep means we have to touch every driver. That's not impossible,
but not ideal either.

For now, I'll leave it as is.


Sean

