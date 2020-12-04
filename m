Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7B2CF198
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 17:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgLDQJY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgLDQJY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 11:09:24 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA48C061A4F;
        Fri,  4 Dec 2020 08:08:38 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id d17so9397580ejy.9;
        Fri, 04 Dec 2020 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gWwBtI9K0o3f2poYGSY4hjn5Co+CtK5kM2YhlDdQnPU=;
        b=djSsalYx5z28Vo6zHumIu44G1hllrfbtmcG98POKpd3MeJUfIVAUWHtMIyIImQBW45
         qbIkxzXKiPh5n5omdPR2lxWDj5/MaQw7fmyUzp+NzMQ6iNURFfkbt0m6nkGjOanShWyh
         qv5xPydle3XJ8TbQf6WXALyoj9XM2y/gfQiZs76pqpt7jc+0EmGWlcn32HCSYNKrXHaF
         AybDneGl3OBg1RhGiJCNBbXRm9wMFIb3rCptxn9Hk2gyjyeIkP6hK9a86drjrO16Le5V
         DVBVMT1nz/iWXZMs4616VMvSgwv+B+jhL3YPgCn6tzP21NEFrvHKaY9mBiciqwJRpxEs
         Ky4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gWwBtI9K0o3f2poYGSY4hjn5Co+CtK5kM2YhlDdQnPU=;
        b=Z7LbSwOgD+NWbLs2BeBXUL8wtv+nevZjmrrc7MGM2ZiVTaE1Az4HnE0SvwIDWcZFvI
         6lJ2L3I3rXijaRacM/Qt1SFaGuQo+XrthbKHBr1a7oScVsj9P7HmPE8nez5hKTRtii5U
         sRgiCtW7aMOMigL2utE2EnVdMqNDw9vJ3lafhGkHQIS7XT//AytvWtmRh7Zg7VLq7Q7N
         gEdu2ep+4NwIncCUQkoMeX0ETdNkDM0HH6ha8mbr3qSgdx26mA9oJK0+QLkFGj1Y0mT/
         ODZe8o08KFp2QRwVAYRrx5H6dHG+LIPzsZy+KwPPE1EOB0v/RKJB579E1iCO1bXcUGSF
         jOoA==
X-Gm-Message-State: AOAM531ni8CdYLEduqCczemDLTUoPHjZ99tNuIudJHy1HLYAZRYPCvkQ
        909Umuo0HC9/8LWj2xZde4NYYoWVWCA=
X-Google-Smtp-Source: ABdhPJywullbQCkep1TAgyOB2kRnvbg1WtrOrijfPxq+UocnmHAU1DQzWJ3aIzloLhctMLzs5RjatA==
X-Received: by 2002:a17:906:f0c9:: with SMTP id dk9mr7862937ejb.51.1607098116768;
        Fri, 04 Dec 2020 08:08:36 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m7sm3267371ejr.119.2020.12.04.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:08:35 -0800 (PST)
Date:   Fri, 4 Dec 2020 17:08:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND for 5.10] pwm: sl28cpld: fix getting driver data
 in pwm callbacks
Message-ID: <X8pfAmiXa8MqF9Gl@ulmo>
References: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
 <X8oubGP9CvoOQKtF@ulmo>
 <20201204135102.foq5gvvzfcwbwphh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/boB7jv0eC9hw1rL"
Content-Disposition: inline
In-Reply-To: <20201204135102.foq5gvvzfcwbwphh@pengutronix.de>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/boB7jv0eC9hw1rL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2020 at 02:51:02PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Dec 04, 2020 at 01:41:16PM +0100, Thierry Reding wrote:
> > On Thu, Dec 03, 2020 at 09:41:42AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Currently .get_state() and .apply() use dev_get_drvdata() on the stru=
ct
> > > device related to the pwm chip. This only works after .probe() called
> > > platform_set_drvdata() which in this driver happens only after
> > > pwmchip_add() and so comes possibly too late.
> > >=20
> > > Instead of setting the driver data earlier use the traditional
> > > container_of approach as this way the driver data is conceptually and
> > > computational nearer.
> > >=20
> > > Fixes: 9db33d221efc ("pwm: Add support for sl28cpld PWM controller")
> > > Tested-by: Michael Walle <michael@walle.cc>
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello Linus,
> > >=20
> > > Thierry (who usually sends PWM patches to you) didn't react to this
> > > patch sent to the pwm Mailinglist last week
> > > (https://lore.kernel.org/r/20201124212432.3117322-1-u.kleine-koenig@p=
engutronix.de)
> > > yet.
> > >=20
> > > Given v5.10 isn't far away any more and I don't know when Thierry will
> > > take a look and act, I'm sending this directly to you. The affected
> > > driver was new in 5.10-rc1 and at least once the unpatched driver
> > > created an oops:
> > >=20
> > > 	https://lavalab.kontron.com/scheduler/job/108#L950
> > >=20
> > > Michael Walle who tested this patch is the original author of the
> > > driver. IMHO it would be good to have this fixed before 5.10.
> > >=20
> > > If you prefer a pull request, I can setup something (but I don't have
> > > access to Thierry's tree, so it will be for a repository that's new to
> > > you).
> > >=20
> > > Best regards
> > > Uwe
> > >=20
> > >  drivers/pwm/pwm-sl28cpld.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > I thought I had seen you discuss this with Lee and gotten the impression
> > that you were going to respin this to move the platform_set_drvdata() to
> > an earlier point, which I think is the more correct approach.
>=20
> Lee asked on irc why I didn't move the platform_set_drvdata to an
> earlier stage and I told him why. Then the conversation was over.

Okay, looking at the logs that you posted, the discussion didn't quite
end the way I remembered it. Still, I would've expected a bit more
discussion and a chance to reach consensus before you went off on your
own and submitted this patch "out-of-band".

> > container_of() isn't exactly wrong, but it's really just papering over
> > the fact that platform_set_drvdata() is in the wrong place, so I'd
> > prefer a patch that does that instead.
>=20
> platfrom_set_drvdata is in a perfectly fine position if you only rely on
> it in the platform_driver's remove callback which is the case with my
> patch. I wrote in my commit log

In general it's still a bad idea to call platform_set_drvdata() after
you register with the framework, so I think that's a worthwhile change
irrespective of your fix.

> | Instead of setting the driver data earlier use the traditional
> | container_of approach as this way the driver data is conceptually and
> | computational nearer.
>=20
> which is still think to be true. The main thing I don't like about the
> platform_set_drvdata approach is that you have to rely on
> dev_get_drvdata() returning the value set with platform_set_drvdata()
> which IMHO is an implementation detail of the platform driver code.

Well yeah, but it's an implementation detail that pretty much all
platform drivers rely on and that's been like this ever since
platform_{get,set}_drvdata() were introduced over 15 years ago.

So it's not like this is suddenly going to stop working.

> > Now, I can no longer find a link to the discussion that I recall, so it
> > was either on IRC (where I don't have any logs) or I'm loosing my mind.
>=20
> It was on IRC but I thought to have written an email about this, too.
> But I don't find it either.
>=20
> > I'll prepare a patch that moves platform_set_drvdata() for Michael to
> > test. If that works I'll send a PR with fixes to Linus early next week.
>=20
> You're late, Linus already merged my patch.

Oh well... I'll just send my patch along with the rest of the batch for
v5.11 then.

Thierry

--/boB7jv0eC9hw1rL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KXv8ACgkQ3SOs138+
s6GGDA//deq5YoLekxYPp8CKY7F6V+QUeZPVIRxjgsWTwhKj2/53NRI8xOKl8TGa
qKvOUoz6KqxkQvLCEK//BEw4sHqobqKfyRMZzqtalcXa6yt4u9Kh78/l8f/ISc24
GIu36NDWDtwFsgOEOypGiQklR29BTm44MYhikVtjNx8nSy9rDQWDXcQsfiukwkuF
4LQN+xFvP+N70lUPOnx3pyIax/KvH9K6zwYr2dd0lsLeiHMQDu5CRA15EExSHPO2
6FJz2GryJ1C5kCV4btVJN79j4cX/G+mmAM7ZRcB2znlyJVS5lg829qg8b3T9IukI
t9yLoMqTUshqA6G49V3yezulRKsILCkfwkNan6gT8oN6d60hVRW8CFvvuqleEJ+4
X2oHMTjM5SmbN9g6MOaC53E/tHpnFUVvG5pwKXX3BEjHePpZgt/kGBrnuWh1O59V
pF1tvIDwWZSa3j2DGVS5xnqiBTtoe90V/zg3RLtXEHkhFBoPyGdVpY6brYefZYIb
tZF0zpC3AaovTAk7ZWVRUpBrwZG4scqHzTBY6ondjU4SqSULOVs+hb9EGozM+6Xu
nu0JvYct1quz6ZL32U/CicPklbLma7TdyGukUgAbXfEjHKTzuAu7aV7li8aXfHU4
6KIGMnY3+8ZEW8Rg6ETltzWdNB/L9X3408JgT2bdW5QtczAmw50=
=kcbU
-----END PGP SIGNATURE-----

--/boB7jv0eC9hw1rL--
