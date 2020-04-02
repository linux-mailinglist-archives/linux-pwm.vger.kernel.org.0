Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05D19BC3C
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgDBHKa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 03:10:30 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:53199 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgDBHK3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Apr 2020 03:10:29 -0400
IronPort-SDR: sUV6pGamhZnBd3ntboz/WPkR63NRAM5FlPEAt8NaFDmDLPdifmpXsFIMz5MebV/J4AGt9WiucP
 OB9CrOk/ZWaZdnUDV2HQlr/AGDVOEjqbcX39sP+Er3gPH8SqWmXpK6C8GUj/q6I+ZB96Ehn88Y
 8NRwJFV4TsFw+7ox+elV75ZNkQEGIGSuSccdMZpbOQxrm56CQR6X1sWWBNnnls24zv5CZLF2DX
 vnOlNXCfhOTGEIHuGSsip0kAmNwhN1CweVpCRDJugXX31Nl/0xrk+pY6ETOGuyRuUeVwrtG/TM
 kzY=
X-IronPort-AV: E=Sophos;i="5.72,334,1580770800"; 
   d="scan'208";a="11656785"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 02 Apr 2020 09:10:27 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 02 Apr 2020 09:10:27 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 02 Apr 2020 09:10:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1585811427; x=1617347427;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V+DaRroG8ClyjJOENjUeKU/FaoyteT1zWovnbFBIGgk=;
  b=dfv20e82kINgFiCyLNjS0GKXNZ4YMi5ElbUFeNMVKkc6biKUGMSQSEQn
   Bmqorm5aw0YlvIBYNqema2VFtGwUUEEuWQivlaLC6AoKiMQasHyIZtht0
   w80uTek1vgH+pMsQIlFWFqEH2GfI7crvB/3eLFHhNLw9e4YWELypK/waZ
   OECaVPXpg7fKNXNsxKW64i0yBzH2/R3CHhy7rt76jFbfZ5qv2gxGNCmk4
   d5j0R9R5/gfQK/Yndzy5S7de4A/8kplDlwuPd8pEO4mpMuvWIzOmgWlwI
   DgD/3fUMYrP/zL/l7JBAYv9l8shAaX+O/lgx2v4OKjQY6qFxL1bBZXH/p
   w==;
IronPort-SDR: 23YaI0cr4WgxH7qJoLxPCbEP5mvByS77wOroFSIwfASWXnyBLa4yo9RRDuHDFuJ507U8opxjdQ
 qoOe4Fi9jRLeMXTB9UBD4TDlYygn96txachBBPiztAdUJ1wmud9wuj9GkAGJMrCkIfY29oL9Lj
 TtTVVhHWMsz4g7LZXKlNR2DjPX8x7bfN4myKnpvT5NSsfibnuOsnnlqd7UOTCAkddnAUI4SpE8
 IaXcm9jqh16WdjbxDX7Ap2udRItHssmRUtJbBOfn99ehIXeNtVRSr5oepqmSZDBWsl9BjKQv91
 R3c=
X-IronPort-AV: E=Sophos;i="5.72,334,1580770800"; 
   d="scan'208";a="11656784"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Apr 2020 09:10:27 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id F3BEE280065;
        Thu,  2 Apr 2020 09:10:34 +0200 (CEST)
Message-ID: <df9591bd009580842e193f28be1eb75d5af1b9f9.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>
Date:   Thu, 02 Apr 2020 09:10:25 +0200
In-Reply-To: <20200401174540.GA2978178@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
         <20200330130743.GB2431644@ulmo>
         <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
         <20200330160238.GD2817345@ulmo> <20200401163640.GA91358@workstation.tuxnet>
         <20200401174540.GA2978178@ulmo>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 2020-04-01 at 19:45 +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Wed, Apr 01, 2020 at 06:36:40PM +0200, Clemens Gruber wrote:
> > On Mon, Mar 30, 2020 at 06:02:38PM +0200, Thierry Reding wrote:
> > > On Mon, Mar 30, 2020 at 04:18:22PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <
> > > > thierry.reding@gmail.com> wrote:
> > > > > 
> > > > > On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer
> > > > > wrote:
> > > > > > duty_cycle was only set, never read.
> > > > > > 
> > > > > > Signed-off-by: Matthias Schiffer <
> > > > > > matthias.schiffer@ew.tq-group.com>
> > > > > > ---
> > > > > >  drivers/pwm/pwm-pca9685.c | 4 ----
> > > > > >  1 file changed, 4 deletions(-)
> > > > > 
> > > > > Applied, thanks.
> > > > 
> > > > I'm not sure this patch is correct.
> > > 
> > > What makes you say that? If you look at the code, the driver sets
> > > this
> > > field to either 0 or some duty cycle value but ends up never
> > > using it.
> > > Why would it be wrong to remove that code?
> > > 
> > > > We already have broken GPIO in this driver. Do we need more
> > > > breakage?
> > > 
> > > My understanding is that nobody was able to pinpoint exactly when
> > > this
> > > regressed, or if this only worked by accident to begin with. It
> > > sounds
> > > like Clemens has a way of testing this driver, so perhaps we can
> > > solve
> > > that GPIO issue while we're at it.
> > > 
> > > The last discussion on this seems to have been around the time
> > > when you
> > > posted a fix for it:
> > > 
> > >     https://patchwork.ozlabs.org/patch/1156012/
> > > 
> > > But then Sven had concerns that that also wasn't guaranteed to
> > > work:
> > > 
> > >     https://lkml.org/lkml/2019/6/2/73
> > > 
> > > So I think we could either apply your patch to restore the old
> > > behaviour
> > > which I assume you tested, so at least it seems to work in
> > > practice,
> > > even if there's still a potential race that Sven pointed out in
> > > the
> > > above link.
> > > 
> > > I'd prefer something alternative because it's obviously confusing
> > > and
> > > completely undocumented. Mika had already proposed something
> > > that's a
> > > little bit better, though still somewhat confusing.
> > > 
> > > Oh... actually reading further through those threads there seems
> > > to be a
> > > patch from Sven that was reviewed by Mika but then nothing
> > > happened:
> > > 
> > > 	https://lkml.org/lkml/2019/6/4/1039
> > > 
> > > with the corresponding patchwork URL:
> > > 
> > > 	https://patchwork.ozlabs.org/patch/1110083/
> > > 
> > > Andy, Clemens, do you have a way of testing the GPIO
> > > functionality of
> > > this driver? If so, it'd be great if you could check the above
> > > patch
> > > from Sven to fix PWM/GPIO interop.
> > 
> > Looks good. Tested it today and I can no longer reproduce the
> > issues
> > when switching between PWM and GPIO modes.
> > It did not apply cleanly on the current mainline or for-next
> > branch, so
> > I'll send a fixed up version of the patch with my Tested-by tag
> > shortly.
> 
> Awesome, thank you!
> 
> > I noticed an unrelated issue when disabling and enabling the
> > channel
> > though, for which I will either send a patch or maybe try to
> > convert the
> > driver to the atomic API first and then look if it is still a
> > problem.
> > (Issue is that if you disable the channel, the LED_OFF counter is
> > cleared, which means you have to reconfigure the duty cycle after
> > reenabling. It's probably better if only the FULL_OFF bit is
> > toggled in
> > enable/disable as it has precedence over the others anyway and then
> > the
> > previous state would not be changed..?)
> 
> Converting to the atomic API would certainly be beneficial because it
> gives you much more control over what you want to program to
> hardware.
> 
> Other than that, yes, if ->enable() called after ->disable() doesn't
> put
> the PWM into the same state that it was before ->disable(), then
> that'd
> be a bug. From what you're saying this will make the driver only work
> if
> there's a ->config() call after ->disable(). That's wrong.
> 
> So yes, setting only that LED_FULL bit in ->disable() and clearing it
> in
> ->enable() sounds like a better option than the current
> implementation.

I think what you're seeing is the same bug that prompted me to send my
patchset - patch 4/4 moves to the atomic API and changes the logic to
fix the interaction between config() and enable()/disable(). As it
seems like 2/4 will have to be reverted though and my 4/4 depends on
the cleanup of 2/4 and 3/4 (and 3/4 and 4/4 still need some work as
well), feel free to have a jab at the issue yourself, as I don't know
when I'll be able to get back to it.

Thanks,
Matthias


> 
> Thierry
> 
> * Unknown Key
> * 0x7F3EB3A1

