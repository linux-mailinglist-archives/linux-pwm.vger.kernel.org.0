Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71B359D45
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhDILZR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhDILZQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 07:25:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C57C061760;
        Fri,  9 Apr 2021 04:25:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id v6so6827729ejo.6;
        Fri, 09 Apr 2021 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cbo+DXvK45YRkq2giTOBH2tx/RdgPCKXEbdJaZjL3o4=;
        b=Qeep4bRnU8LENO71Sy+3g9QeKeI5LfIPnzxy+FKwQcBEi9A/iJT6Np32IcCpgKrqD+
         q1fnqqjMlIF5bVHipLNhCkGQV2YKG/HO7HirgR9yzo6rdqYp5YmWg+ATI8ckr0lACXcL
         dTbNaQMk/6orDt58faxYVKGXNPbHQfWWq8/LnZpQTNcLfj99iuDusYVh4XByvU6nlSNr
         uHOuTCYUhaD0R5L/bW3tKrAPwxI/dvE0ml6aeUMmRavkGu7vq8UzklY3NelUJ3B7p/nv
         T5GhyNffr8wYf6KA//3J/GU7vJ6947XVib0ODDDPanrWWVDIHgyT+geloMwEa0NjFdsZ
         hkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cbo+DXvK45YRkq2giTOBH2tx/RdgPCKXEbdJaZjL3o4=;
        b=hMHzzuZp/GY5WQhkI1w4SkSloRcFzPiE45kxxt0issO95MWmLJOpW/wIWHfJ0f2ueB
         F/aIVWkJYAQGGP4z4oDeVjCJ/T6DSZlRlkFLfryZG7PggsgRKDmeZIIMzgQiuSQe8KqW
         J+hZdJH0yaLj6lFVv0HTm5Won7yS6O4JdqsuENGuNdSkQSfw5bGbxxttpNkVjjHEn+eG
         47IlwmzMQFcgOgaQglze8Dv75p2umietXliXhlhUbeUXRY+YL95bNB3OBDo4Lo9noiUP
         LFEK1eGyhNV5miCXlT/w+R+y+TNnozwVMe9aDndkwzApQ5hxw7SIJz+gVbZb9PmJQf4W
         WOgQ==
X-Gm-Message-State: AOAM530cV/4DiLkN/wVycNei589HbL1QDLL1UDPb20WzZFxbrzNB8cID
        GOcjTNnccsQD0OcPm6hn2Zc=
X-Google-Smtp-Source: ABdhPJxV8P7Fx754nV6CKaEvI9W2XdWYiYZis1aHD+K/n0cncD86J2fpH7VPtbbR/n1kFFDkmjyGSA==
X-Received: by 2002:a17:906:9bd3:: with SMTP id de19mr4717225ejc.329.1617967502168;
        Fri, 09 Apr 2021 04:25:02 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id l2sm1043990ejz.93.2021.04.09.04.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:25:00 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:25:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <YHA5sPuZmbSLU3aM@orome.fritz.box>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
 <YG78IHIMGtl8Pokp@orome.fritz.box>
 <YG8miEOZXsH0NTcA@workstation.tuxnet>
 <20210408173637.w26njwystfuyrgan@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KTkCqOTt+VsekVzf"
Content-Disposition: inline
In-Reply-To: <20210408173637.w26njwystfuyrgan@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--KTkCqOTt+VsekVzf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 07:36:37PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Apr 08, 2021 at 05:51:36PM +0200, Clemens Gruber wrote:
> > On Thu, Apr 08, 2021 at 02:50:40PM +0200, Thierry Reding wrote:
> > > Yes, I think that's basically what this is saying. I think we're perh=
aps
> > > getting hung up on the terminology here. PWM_STAGGERING_ALLOWED gives
> > > the impression that we're dealing with some provider-specific feature,
> > > whereas what we really want to express is that the PWM doesn't care
> > > exactly when the active cycle starts and based on that a provider that
> > > can support it may optimize the EMI behavior.
> > >=20
> > > Maybe we can find a better name for this? Ultimately what this means =
is
> > > that the consumer is primarily interested in the power output of the =
PWM
> > > rather than the exact shape of the signal. So perhaps something like
> > > PWM_USAGE_POWER would be more appropriate.
> >=20
> > Yes, although it would then no longer be obvious that this feature leads
> > to improved EMI behavior, as long as we mention that in the docs, I
> > think it's a good idea
> >=20
> > Maybe document it as follows?
> > PWM_USAGE_POWER - Allow the driver to delay the start of the cycle
> > for EMI improvements, as long as the power output stays the same
>=20
> I don't like both names, because for someone who is only halfway into
> PWM stuff it is not understandable. Maybe ALLOW_PHASE_SHIFT?

Heh... how's that any more understandable?

> When a consumer is only interested in the power output than
>=20
> 	.period =3D 20
> 	.duty_cycle =3D 5
>=20
> would also be an allowed response for the request
>=20
> 	.period =3D 200
> 	.duty_cycle =3D 50
>=20
> and this is not what is in the focus here.

Actually, that's *exactly* what's important here. From a consumer point
of view the output power is the key in this case. The specifier is a
description of a particular PWM in the consumer context. And the
consumer not going to care what exactly the PWM controller might end up
configuring to achieve best results. If the controller allows the phase
shift to be changed and the constraints allow it, then that's great, but
it isn't something that the consumer has to know if all it wants is that
the power output is as requested.

Put another way, the more generically we can describe the constraints or
use cases, the more flexibility we get for drivers to fulfill those
constraints. For example one controller might support phase shifting and
use that for PWM_USAGE_POWER for better EMI behaviour. But another PWM
controller may not support it. But it could perhaps want to optimize the
PWM signal by reversing the polarity of one channel or whatever other
mechanism there may be.

If we add a flag such as ALLOW_PHASE_SHIFT, then only controllers that
support programmable phase shift will be able to support this. If some
other mechanism can also be used to support "equivalent power" use
cases, that would have to be described as some other flag, which has
essentially the same meaning. So you can get into a situation where you
have multiple flags used for the same thing.

Thierry

--KTkCqOTt+VsekVzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwOa4ACgkQ3SOs138+
s6GwhQ/6A96x54jvvgMXyX1Y+IqI/xhZhGPDf3V94OiLCKG/O5GFOx5pnyrH7X9w
Qz61XkBlrK8ww4EKZ0I/HxZyVsrwjtOvQVsNs1iadZzwVFpznB2ISPsHfBO6ikqM
0W23v6cWCSZ1ZVNz9X2SijzkD8QAK2RfKTiwlMqkP8kPKus2xOLfo6E769r3kItj
aqSGqsDC2WYXmYffC8lcAWBdVznFYZ3EGDuarKoRHReLjQFVOnJqwzBanM0EpxQa
Jtj8zEmmKfYEy5gUOTyLQUTDUtpZ4t0SdEv8AMUThHzCHzQ/mprADm2PT9wtp9GO
VwgF7OSlW7AJ1YutEHHHmIzxSBtmLWpASd0kiu5pYgGgLhWvkWm2n1FjIBV69XdC
/n1YS0JRjKRLcDKhjtZ2/wmJVJtWJFTuk1zD2Hp0UI1ivJuafvmuzqwqjEz0vutY
4HSfhkWbCCyq/764ilAqKd5HZyggp91fvIcUK0TwIZMgESz533QqYPFeQdSjejYP
qqz0/E/s9ArJOpaWEmT3F1XGBhlxnUeSlxJBBzI3J7Py4pazkFjZRSurRqLUgnH2
4esLQXaq3mmkXd59Ie2xz0osv3lFa1wYB/+ccwSt/59L3KLyLHmf+mzltwwaX0i+
J1dP7xW8VybL4w8TqrEPIxQQiQChYlrU5+glsDS8XSlm/n2TrEI=
=+a3n
-----END PGP SIGNATURE-----

--KTkCqOTt+VsekVzf--
