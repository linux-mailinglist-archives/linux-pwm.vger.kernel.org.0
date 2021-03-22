Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59A9343C0B
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 09:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhCVIrv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 04:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCVIre (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 04:47:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BA3C061574;
        Mon, 22 Mar 2021 01:47:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso10879760wmi.3;
        Mon, 22 Mar 2021 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WbdCiWzCxeWbc2p5/beWzVhb0x0dDZx3geHqSJDmH5o=;
        b=WWotAzaYCTPM7dCVb0Qh1qBNHmOV/hj2Q4jFsz8ssKenN/3f8c/wnbbsCqwtGwcRWT
         syxEelvbEl/T4AKv2DFyQAnD/Coz/l0IaDlbwReH6zy6uSg5qLFtypwfpQFMJt9dsXe3
         7RmtYNDVApM6Tag5hZPueL7Zd8a7mY7tWcW17B/07t7uP632uI810eXKnDRRTqWnHd3B
         Uo8hXBWdEbsHQJOv6qKaseN6xpXRoLKqZ+R+qCNzGrcSAWsZs58G62/xHl/rl4FHvDUJ
         WyFIw6MoZOrNWnec8jQ+aSP8xUrXIroliF17KWEzx2Av4bELNHSQEBEQ+XLCTRriyS6C
         /usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbdCiWzCxeWbc2p5/beWzVhb0x0dDZx3geHqSJDmH5o=;
        b=b6DV8CtdqoKs3uCWyOeLly6FtLvaKYb8xFWrPCr83zgjiaolZ10Isl5yK3K6vSx/L+
         e+TukggQRkb3mejM5XYxyS4kCst5Tyt3ORVZLGeIyzz+qGQ/w7HWf3fDrZB/+IpbrOPr
         VTOHZi/qZY8hIXR/pd+r1WI8v7OrbcCdlEEVdb7Ib5Z2KymjlTmW9hbvtXffUrfi6LuK
         7rAlSSsYD1726UWYts3Em+BEpcEhrgGAXykySRIi5saPQmQRIMO0bEl/zkqekm1qAwsx
         2vtCE9tvO4uy2qXNerDw44CHjaeNtjWR4xT5rqIXa/KY6Ob99QFAvHsqdjFALJ+l5C4X
         fTKA==
X-Gm-Message-State: AOAM5318F7AwfP3rysdr0R0TCQcomEMVuTTnhaQ84wmutyMHsCx4HmvN
        EqmBUIo4MErv+7Semt/aAOrB59Aa6DA=
X-Google-Smtp-Source: ABdhPJxsC54AfXoVkyLl5YHqh5gPiOTK9VGZqSWfqy43dZO6fKowzqSYQUAmQYKPbVaWRrS2s2tMoA==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr14575605wmk.117.1616402853374;
        Mon, 22 Mar 2021 01:47:33 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u2sm19703680wmm.5.2021.03.22.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:47:32 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:47:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YFhZtiA3YnqKolag@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t2Use13uT5HzaTop"
Content-Disposition: inline
In-Reply-To: <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--t2Use13uT5HzaTop
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 09:35:32PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Dec 17, 2020 at 06:43:04PM +0100, Clemens Gruber wrote:
> > On Wed, Dec 16, 2020 at 11:00:59PM -0500, Sven Van Asbroeck wrote:
> > > On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
> > > <clemens.gruber@pqgruber.com> wrote:
> > > >
> > > > Implements .get_state to read-out the current hardware state.
> > > >
> > >=20
> > > I am not convinced that we actually need this.
> > >=20
> > > Looking at the pwm core, .get_state() is only called right after .req=
uest(),
> > > to initialize the cached value of the state. The core then uses the c=
ached
> > > value throughout, it'll never read out the h/w again, until the next =
=2Erequest().
> > >=20
> > > In our case, we know that the state right after request is always dis=
abled,
> > > because:
> > > - we disable all pwm channels on probe (in PATCH v5 4/7)
> > > - .free() disables the pwm channel
> > >=20
> > > Conclusion: .get_state() will always return "pwm disabled", so why do=
 we
> > > bother reading out the h/w?
> >=20
> > If there are no plans for the PWM core to call .get_state more often in
> > the future, we could just read out the period and return 0 duty and
> > disabled.
> >=20
> > Thierry, Uwe, what's your take on this?
>=20
> I have some plans here. In the past I tried to implement them (see
> commit 01ccf903edd65f6421612321648fa5a7f4b7cb10), but this failed
> (commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3).
>=20
> > > Of course, if we choose to leave the pwm enabled after .free(), then
> > > .get_state() can even be left out! Do we want that? Genuine question,=
 I do
> > > not know the answer.
> >=20
> > I do not think we should leave it enabled after free. It is less
> > complicated if we know that unrequested channels are not in use.
>=20
> My position here is: A consumer should disable a PWM before calling
> pwm_put. The driver should however not enforce this and so should not
> modify the hardware state in .free().

There had been discussions in the past about at least letting the PWM
core warn about any PWMs that had been left enabled after pwm_put(). I
still think that's worthwhile to do because it is consistent with how
the rest of the kernel works (i.e. drivers are supposed to leave devices
in a quiescent state when they relinquish control), and consumers are
ultimately responsible for making sure they've cleaned up their
resources.

Most PWM drivers do a variant of this and assert a reset, disable clocks
and/or release runtime PM references when removing the PWM chip on
->remove(), but that happens at a different time than pwm_put(), so I
think it makes sense to nudge consumers in the right direction and WARN
when they've left a PWM enabled when calling pwm_put().

If we do that, it shouldn't take very long for any violations to get
fixed and then we don't have to enforce this in PWM drivers or the core.

Thierry

--t2Use13uT5HzaTop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYWbMACgkQ3SOs138+
s6E0/xAAi3K3cEjtmE0i7CWSGUeTDm22dDFNy1P/qNW2qvUig4E33jKPzyom2ap1
vWJcYPOftG5FYG8Y1JZvfZTdBFu8FbalI4pmnSuHVZvcUwXkBGV5R+5uV1W8lbEm
wqZV4pNeCNGkUzyBYmLYjEjHoJQFgKpWEH6IW++g+Y+78x4Zz74Ira/nFUypd6SR
tWrTAM2HXbqBG4vsG8YgVOOq7ds1HTf/jL0CoY2NsPBlXo20qo46c4XMUL3tZ/MU
DRhoLFHevFVQIL4dBV7NeA5ZUckxJCVTW2lF2I5szkVyOTkAN0ujmvW52ziOrBXG
vXUz3AQtPpLOCuTTAR68jeUhvMhWvrOPbkksEdz9yfyK0GeUCz4752PEJbpPmTks
8ApNC/5JBEH36y66+piJy6FqlShci7yR3OJRVkoiBiWOvpq+yV3OF+0AvR8/QpEU
Q5/BefUmswkPwkSD+7MmzpQ534Zd0myCyC2UAK7fq2jkUqJZA/JU31mQw8Ho6WZp
OdFrbfOS08coVfBIJOsCV01oLgUmZOXbsBQEbPv+M8m4K2Uagav8rimUpJs0NSPu
HuYvQyFR2LF2cavkhimTTUdRhJ16L2rM0sI0ZGO+phz53CWvjh2l3+bEmeWFcC0x
pi+BvMbiCuRQVKX8U2Y8t5jX1Bq/XdW3VFj0CoXSSjrrHyikkto=
=etHA
-----END PGP SIGNATURE-----

--t2Use13uT5HzaTop--
