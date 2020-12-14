Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0710E2D99F5
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Dec 2020 15:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394902AbgLNO3R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Dec 2020 09:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgLNO3J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Dec 2020 09:29:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A40C0613CF;
        Mon, 14 Dec 2020 06:28:28 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g25so9107787wmh.1;
        Mon, 14 Dec 2020 06:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WbwXe9quDTjEIBnxNObrlhost7h1SRASX7jkTiQADg4=;
        b=VVge0eDoPq1w7KFSj4BNK6aeWw2GL4RNzH1mw5KPWCWgpzXaaJTOfXZm862WrFVydl
         KZf6Bd8NUj9s8R8Qmx3admJ+XsTx5DfNgZbBWu95opZM5qJB+4arILqvjouYdxGWtX/Z
         iYCjGbS7NNrVHUCzQF3fdsI1upYvE5Jl05aefnroOQw/6kq6FtGcBKFryvq0rh8c7Ha0
         muJv1j8GuwTfbjA79v+3xzV5UznnPFHKaVA5xKdyDRtxC0FumJLq0t17IosemLZDq2in
         Qh68lhLIRn71Z0pdRIUshE7qHnqWmHhug8BNJyLhh0xahN75FjUu9HBuUqgZJf+QJH32
         Yh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbwXe9quDTjEIBnxNObrlhost7h1SRASX7jkTiQADg4=;
        b=QyOXJ45FN4dtt7+8ERxH4TidhNvVMF1L1VEXvT2jE5ibrsI3anoIfPMVccbm1cKwgq
         MPgdRh9wXAdzNwZ7iUHff+6Hp/6lOkeQD0K2wOqdl+GKdYc3Z6rPqry3NA0jc92ehHk0
         +bt3tgX/VUlRQX/S0H461FS+9ywbAg7etAM8iixpHJZ1lL6+4bNpuBs8Aw6NbQh0FsCK
         9Q8FKlnvJ394uwAD1U+6fk0OslB1ifqsPblDwOLzHqKQpuRLFEFV6EzNz81vHKbwYm82
         bufWrQHD71O+QCO9rOM8teF1A6T+dUgcC+Q3RFtUHdMGYsTMA+eiDO491e58QdQVC3m7
         0H5A==
X-Gm-Message-State: AOAM530Cb5622cg3kuDX0pfamq6cHOB71uGUxe0yFgOQFn7GPoFF2lMD
        2rNq43rL2Z18al7CMuNrR+M=
X-Google-Smtp-Source: ABdhPJztTjJ3Mno2kBfq66vcVUA3yudN5/QzNjZ2Tk+JFMEn7QqOekDARBeUwEVQhC/DDSuzCL5K1A==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr28916141wmm.42.1607956107601;
        Mon, 14 Dec 2020 06:28:27 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n3sm32829874wrw.61.2020.12.14.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 06:28:26 -0800 (PST)
Date:   Mon, 14 Dec 2020 15:28:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X9d2iFCzSkqLu8zR@ulmo>
References: <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
 <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo>
 <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
 <X9Mu8zrJjFTe6fJq@ulmo>
 <20201211103454.tqcfzy3ayn2gz7k4@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qdhNoo9CZ0Xx8WmL"
Content-Disposition: inline
In-Reply-To: <20201211103454.tqcfzy3ayn2gz7k4@pengutronix.de>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qdhNoo9CZ0Xx8WmL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 11:34:54AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Dec 11, 2020 at 09:33:55AM +0100, Thierry Reding wrote:
> > On Thu, Dec 10, 2020 at 09:39:26PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Dec 10, 2020 at 06:10:45PM +0100, Thierry Reding wrote:
> > > > Like I said, that's not what I was saying. I was merely saying that=
 if
> > > > there aren't any use-cases that current users rely on that would be
> > > > broken by using this simpler implementation, then I'm okay with it,=
 even
> > > > if it's less flexible than a more complicated implementation. It sh=
ould
> > > > be possible to determine what the current users are by inspecting d=
evice
> > > > trees present in the kernel. Anything outside the kernel isn't some=
thing
> > > > we need to consider, as usual.
> > >=20
> > > If "users in mainline" is the criteria that's a word.
> >=20
> > I didn't say "users in mainline", I said "use-cases". What I don't want
> > to happen is for this change under discussion to break any existing use-
> > cases of any existing users in the kernel. I said that we can determine
> > what the existing users are by looking at which device trees use the
> > compatible strings that the driver matches on.
> >=20
> > > So you agree we remove the following drivers?:
> > >=20
> > >  - pwm-hibvt.c
> > >    Last driver specific change in Feb 2019, no mainline user
> > >  - pwm-sprd.c
> > >    Last driver specific change in Aug 2019, no mainline user
> >=20
> > No, that's an extrapolation of what I was saying above. Drivers with no
> > apparent users are a separate topic, so don't conflate it with the issue
> > at hand.
>=20
> I cannot follow (and I think that's the problem between us and why those
> conflicts happen between us). For me it's a logic consequence of
> "Anything outside the kernel isn't something we need to consider, as
> usual." that drivers that are untouched for some period and have no
> mainline users can/should go away. (Is "extrapolation" as strong as
> "implication", or has it subjective interpretation added? My dictionary
> isn't accurate enough for that question.) But it seems there is
> something with my logic or you not saying exactly what you actually
> mean. (Did I miss any option? If yes it might be covered by a problem in
> my logic.)

To me this is not as black and white as it seems to be for you. First I
wasn't talking about unused drivers, but about use-cases that are not
represented in mainline. Secondly I didn't say anything about removing
support for use-cases that weren't in use upstream. All I said was that
I didn't want any changes to regress existing use-cases.

"Guessing" how that statement reflects on my thoughts about unused
drivers is extrapolation. Your logic implication could've been correct,
but in this case it wasn't because I consider a driver that was
upstreamed to be part of the kernel, and people invested a fair amount
of work to get it to that point, so I'm in no hurry to get rid of them.
Instead, I prefer to give people the benefit of the doubt and assume
that they had planned to get users upstream and for some reason just
haven't gotten around to it.

On the other hand, almost 18-24 months without activity is quite long. A
compromise that works well for me is to keep drivers, even unused ones,
as long as they're not getting in the way.

> Having said that, even in the question at hand (i.e. what is the better
> compromise for mapping the inter-channel hardware limitations to
> software policy in the pac9685 driver) the idea "let's inspecting device
> trees present in the kernel" doesn't work, because for this driver there
> are none, too. (It might be used by a mainline machine via ACPI, but
> this is even less possible to consider for our judgements than a device
> tree with such a device and no user but the sysfs PWM interface.)

Perhaps Clemens and Sven can shed some light into how this driver is
being used. There clearly seem to be people interested in this driver,
so why are there no consumers of this upstream. What's keeping people
=66rom upstreaming device trees that make use of this?

> > While it's certainly unfortunate that these don't seem to be used, I see
> > no reason why we should remove them. They don't create much of a
> > maintenance burden, so I'm fine with keeping them in the hopes that
> > users may still show up at some point.
>=20
> The problem I have with them is that I expect your voice of dissent when
> I find the time to improve the rounding behaviour of these drivers.
> My ultimate goal is to make the PWM framework a system where consumers
> can rely on a consistent behaviour of the API and a way to actually
> order what they need and get it. I'm not entirely sure we agree that
> we're not there yet.

I don't think we entirely agree that the framework is currently
inconsistent. As you and others have shown in various threads, one way
of rounding isn't necessarily always the best way. Some consumers expect
a certain accuracy and don't care whether we over- or undershoot. Some
controllers may give more accurate results when rounding up than when
rounding down and for others rounding to nearest is the best option. A
lot of consumers don't care all that much about rounding as long as the
duty-cycle/period ratio is reasonably close.

So there are a lot of variables in all of this and I don't think we can
fix the rules so that they work for everyone. That's why I think we need
to stick with the status quo that does work for pretty much everyone so
far by being not overly strict and then extend that if we have to (i.e.
if we come across a use-case where the current status quo doesn't work).

> > > Most PWMs are added to cpu.dtsi files with status =3D "disabled", I w=
onder
> > > if it makes sense to check the machine.dts files if some of the PMWs =
are
> > > completely unused. Do you consider status =3D "okay" a use that we ha=
ve to
> > > retain even if the node has no phandle?
> >=20
> > A PWM controller may be in use via sysfs even if it has no phandle.
>=20
> Yeah, I expected you will say that. (And I agree.)

sysfs on the PWM side does complicate things a little bit, but on the
other hand it's not very different from other consumers. For any change
at the API level (such as adding rounding modes, if we have to) we just
need to make sure this can be represented using the sysfs interface as
well.

And by the way, as an additional argument against removing seemingly
unused drivers: it's technically possible to instantiate a PCA9685 from
userspace using sysfs, and there might be people relying on this to get
their job done. Again, there are many shades of grey here and lots of
unknowns, and extrapolation doesn't work very well under those
circumstances.

Thierry

--qdhNoo9CZ0Xx8WmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/XdoUACgkQ3SOs138+
s6EcAxAAokZjx0juPgwBG8xP/EGvM//I5u9br6Mll2Ksuq8hQi8auK3NfFy/5wvs
6WX64dQMGoS0QD7mY54Yc74jCi2SpV9BrncQVnvwRLLisuEbsTz9hmSqGWobDhqx
xalY6O/ndHXWHY4PKwiFOPu1fpT64zWTI0v/SuCXf0jvM2wVSxaTDusvbGvZ4kx8
ziYXpvJCAeKyk/kPqSb6QGLyhqhAWQb65MB9qPqndvIx6YdaN7T3sIeKza4Kc4Kx
sBubKfS9a1d9z2o9OFN2QZzRYDC/v10ZcyXvsZ2IEpU3kw0ofpI0rkGx4+sHxKN8
tR627NKADbuxDPKSQ+pGMMVj4PdKy9qY1BVqDhjRSO18xXVRKa0yyxpIKhGKfRzx
ci+mkympXoBmWzQeJucMwn74RqIWI3IrlAhlWfDQQphQ7ZgwwzDghy5VSET3Alym
woAUVOL/6Sgqk7vwwY2M3ljg6GLs3gTGAFhE7b5uNXzpnteaiQ5VRQ7TyvduG0HG
+JjKe6sqUsEZqKcKOtjmpokaoOkYNCfqLJqgxj0cdEiNUYx+pk4dtpQbUR39GzUw
1BpuWJSqXmaeUOSDVltpqiQjahPvG6p3bJ+F3tN+zqzUjKg3OGsCO2oWaVRg8JPf
l+BBTFxhxGwRVDEQYAVt0SIofUusnORR4ZxhXT+BtLc3tWu4kic=
=t04u
-----END PGP SIGNATURE-----

--qdhNoo9CZ0Xx8WmL--
