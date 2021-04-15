Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1A361018
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhDOQ0q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOQ0p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 12:26:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF7DC061574;
        Thu, 15 Apr 2021 09:26:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x4so28839171edd.2;
        Thu, 15 Apr 2021 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jyH3HdOd9UkAaM7HlQMLpD8REdK46Ccawf0yY1ovzww=;
        b=mKB7iXcKYJ2r9LfwtCEG1Av4zQgh4wGme2vgiLdxtssRu3OHI1P51HAyWvKVLaUEF9
         0oIWPP1btTCCkw8BkKeyFZ9YmVVM4tOOdk9Kv6lRiwq5vM8ErVFMOcf3eCnbiix4Goas
         CrzoCRCznsajH03B0vtm84z6USNNqYuxY3MvhhsnGS0o9uMYKZvlqI89NGcXaKdVz2vA
         lGyZucIfKWd1FF9NdDiABcQ8Bv2Tb5eU2ADEIfBtgYtgZQXF2T6uqhlmNgofLFOs0FaQ
         qzwMnqCcOetYXuqAU9D21U8q3kePjcMA+zP9szJc0jeFNiLVkqSlmyXJCTS+35/NlJX9
         PaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jyH3HdOd9UkAaM7HlQMLpD8REdK46Ccawf0yY1ovzww=;
        b=iXjO4uvtMrnwNWneaPwXu8Bly+OMI0ktlQN4XeYFQzfYQT22+9SWBCu/Rr2wccUr8y
         /rvrU2N8Y/vJyk+L5QuWDzd2FKX6aXNsLKabUR3LIU8r2WPEvu1JHt/OYkCnXe5AKNyU
         RH8XQc+Q5mjw45Vk627gV+womin243+dCPi5YOX22VxhSHiT0PtdYyhx7Gn834J9qoMK
         M6PlC3UEKK9MNhU1XKr2lH7/nsUaei0lSg5jyP+NdHLbXGKhq4UEQ7xl0F+c16Ao6R0Z
         0Gw1AOvgffFZxdYNwOOZiZi5d9WKL46Og8Fc5TnzRM/mzEX/MRpc15dzDsSfWsstqafY
         lr2A==
X-Gm-Message-State: AOAM530B9AawcKzZdRTKhqqdwNxCn+WJADADqMqiB7SRvy2Wcr3RkeEW
        dhXlOc/4DtEMIP+JqHuIVL4293q4sW8=
X-Google-Smtp-Source: ABdhPJz6xTW+/ErlqOlG9emoNNpsPztjM0l/wufr1ZGMdpOIobwhiBH5COWz+6yHliHwjgIIgpSLPw==
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr5313484edt.366.1618503980921;
        Thu, 15 Apr 2021 09:26:20 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id y16sm2881265edc.62.2021.04.15.09.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:26:19 -0700 (PDT)
Date:   Thu, 15 Apr 2021 18:27:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <YHhpVusyiBLWIM0V@orome.fritz.box>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
 <YHWFs1f0XHkqbddp@orome.fritz.box>
 <20210413175631.pwbynvwmnn7oog4m@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ssHf/w3M5y+cB+4m"
Content-Disposition: inline
In-Reply-To: <20210413175631.pwbynvwmnn7oog4m@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ssHf/w3M5y+cB+4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 07:56:31PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Apr 13, 2021 at 01:51:15PM +0200, Thierry Reding wrote:
> > On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > > > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> > >=20
> > > My concern here in the previous round was that PWM_USAGE_POWER isn't a
> > > name that intuitively suggests its semantic. Do you disagree?
> >=20
> > I suggested PWM_USAGE_POWER because I think it accurately captures what
> > we want here.
> >=20
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> > > >  include/dt-bindings/pwm/pwm.h                 | 1 +
> > > >  2 files changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm.txt
> > > > index 084886bd721e..fe3a28f887c0 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > @@ -46,6 +46,9 @@ period in nanoseconds.
> > > >  Optionally, the pwm-specifier can encode a number of flags (define=
d in
> > > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > > +- PWM_USAGE_POWER: Only care about the power output of the signal.=
 This
> > > > +  allows drivers (if supported) to optimize the signals, for examp=
le to
> > > > +  improve EMI and reduce current spikes.
> > >=20
> > > IMHO there are too many open questions about which freedom this gives=
 to
> > > the lowlevel driver. If the consumer requests .duty_cycle =3D 25ns +
> > > .period =3D 100ns, can the driver provide .duty_cycle =3D 25s + .peri=
od =3D
> > > 100s which nominally has the same power output? Let's not introduce m=
ore
> > > ambiguity than there already is.
> >=20
> > The freedom given to the driver should be to adjust the signal within
> > reasonable bounds. Changing the time unit by a factor of 1000000000 is
> > not within reason, and I doubt anyone would interpret it that way, even
> > if we didn't document this at all.
>=20
> Please define a rule that allows to judge if any given implementation is
> correct or not. For the record neither "within reasonable bounds" nor "a
> factor of 1000000000 is not within reason" is good enough.

We haven't had any rules thus far and I have yet to see a single report
that drivers get this completely wrong. So "within reason", which I
think is what driver authors will do by default, is good enough in
practice.

> This is not only important to be able to review drivers that implement
> it, but also for consumers, because they should know what to expect.

Again, consumers should expect that the PWM driver will do something
that is within reasonable margins. If that ever ends up being wrong for
a given use-case we may need to change that.

But I don't think it's necessary to take out all flexibility if we don't
have to. As long as things work fine there's no reason to make the rules
any more strict.

> > To be frank I think that quest of yours to try and rid the PWM API of
> > all ambiguity is futile.
>=20
> I consider my quest about rounding reasonable. And I think this is
> painful because when the PWM framework was introduced it was too much ad
> hoc and the APIs were not thought through enough. And because I don't
> want to have that repeated, I express my concerns here.

Maybe try to look at this from another perspective. Maybe what you call
adhoc API was actually deliberately designed this way. To be honest I
don't know what the intentions were when the original PWM API was
created, that was way before I took on maintenance of the PWM subsystem.
The PWM framework adopted the existing API and there was no reason to
change it because it worked just fine.

And I still don't see a reason for the API to change. Like I said, if we
ever run into a case where the current flexibility gets in the way and
yields unpredictable or unusable results, then that's something we have
to improve. But I don't think we should make any such changes if they're
not necessary, because then we may end up making matters worse.

Also, I think this actually corroborates the need for something like the
usage flags in the PWM specifier. Currently drivers will do their best
to generate a PWM signal that's as close as possible to the requested
parameters. If that's not enough for a specific use-case, then that's
something that the new use-case has to describe somehow. They could do
that using a usage flag (perhaps something like PWM_USAGE_STRICT, which
may tell the driver to return an error if the requested parameters
cannot be applied exactly). Another possibility is to give consumers a
way of running a given state through the driver but not applying just
yet so that they can inspect what the driver would have programmed and
then make adjustments (that's along the lines of what you had in mind
with the "round state" concept, I suppose).

> > I've been trying to be lenient because you seem
> > motivated, but I think you're taking this too far. There are always
> > going to be cases that aren't completely clear-cut and where drivers
> > need the flexibility to cheat in order to be useful at all. If we get to
> > a point where everything needs to be 100% accurate, the majority of the
> > PWM controllers won't be usable at all.
> >=20
> > Don't let perfect be the enemy of good.
>=20
> I admit here I don't have a constructive idea how to define what is
> needed.
>=20
> For example if we only care about the relative duty cycle, a consumer
> requests
>=20
> 	.period =3D 1045
> 	.duty_cyle =3D 680
>=20
> and the driver can provide multiples of 100 ns for both .period and
> .duty_cycle, the candidates that might be sensible to chose from are
> (IMHO):
>=20
>  - exact relative duty:
>=20
> 	.period =3D 104500
> 	.duty_cycle =3D 68000
>=20
>  - round both values in the same direction, minimizing error
>=20
>  	.period =3D 1100
> 	.duty_cycle =3D 700
>=20
>    (requested relative duty =3D 65.07%, implemented =3D 63.64%; when
>    rounding both down we get 60%)
>=20
>  - round both values mathematically:=20
>=20
>  	.period =3D 1000
> 	.duty_cycle =3D 700
>=20
>    (yielding a relative duty of 70% instead of the requested 65.07%)
>=20
>  - Maybe
>=20
>  	.period =3D 1000
> 	.duty_cycle =3D 600
>=20
>    might also be preferable for some consumers?! (60%)
>=20
>  - Maybe
>=20
>  	.period =3D 2000
> 	.duty_cycle =3D 1300
>=20
>    is a good compromise because the relative duty is nearly exactly
>    matched and the period is only stretched by a factor < 2.
>=20
> In my eyes a driver author should be told which of these options should
> be picked. Do you consider it obvious which of these options is the
> objective best? If so why? Do you agree that we should tell driver
> authors how to implement this before we have several drivers that all
> implement their own ideas and getting this in a consistent state is
> another pain?

We already have several drivers implementing things inconsistently. And
again, I don't see how that's a problem. Most of the time, values for
period will be hand-picked to match the requirements of the use-case on
a given platform (for backlights or LEDs, for example, you don't want a
period that's too long, because then you'll get flicker). The duty cycle
is then simply used as a way of getting a power output of the desired
percentage. For something like PWM backlight, if interpolation doesn't
work, you have the option of specifying discrete levels with hand-picked
values.

Backlight and LEDs are the vast majority of applications for PWMs used
in the kernel today. Another category would be regulators and they end
up being pretty much the same in where the values come from.

The one use-case that's perhaps a bit more tricky is the sysfs interface
because people can throw whatever they want at it. But even that is not
likely to be problematic in practice because users will either be
satisfied with the result that they get when computationally getting the
numbers, or end up hand-picking values for those as well, with the only
difference being that they are programmed from userspace.

For the particular case of PWM_USAGE_POWER, I think it really only says
that the power output of the signal should be as requested. It does not
mean that the driver can pick whatever values it wants. Drivers should
still try to match period and duty cycle as closely as possible because
there's not enough other information to know if, for example, stretching
the clock by a factor of 2 is reasonable for the use-case.

> (My bet is you are lax and don't consider consistency among drivers soo
> important. In this case we don't agree. I think it's important for
> consumer driver authors to be able to rely on some expectations
> independently which lowlevel driver is in use.)

Well, yeah. Consumers should be able to rely on the expectation that the
provider will try to best match the given parameters. Something like
PWM_USAGE_POWER can be used to give the driver a bit more freedom, but
it doesn't mean it should switch into crazy mode.

Again, most of the time the values that we're dealing with here will be
hand-picked for a given use-case, which means a given PWM channel and
what it will be used for. So the values that the API and driver get are
going to be something that the driver can set to within a reasonable
margin, otherwise users will go and pick a better value.

So in practice these problems just don't exist, and we're spending a
huge amount of time tryng to solve a non-existent problem. And that's
the reason why we're not coming up with a good solution. You can't come
up with a good solution to a problem that doesn't exist because you
don't know any of the parameters.

Thierry

--ssHf/w3M5y+cB+4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB4aVMACgkQ3SOs138+
s6FulBAAloD3l7tCQd5lvP1mGbBi2vIvvbFliPxzoiBSZDt3iENH5i8nZv8y78cX
aNfvdDJh0SRNQ8GzObsiWFPs0doKPxhnmAZX+aPwYiMSyNPbC8xT5+sNCTEKGpq1
WICN387DTROPd+lSCTmDP+G4tUGdoq0f26otjWQEtGm1YOLwIqGmAJ6tFl7+i22Z
Tz/GQ7kDoTjYmCRzg1MqOYgFDquKOQsxvDhUikpHcfnE4iqJefLr7G2V1VNbbveL
weIt5VueY2BWtWHqWvOzoaH4AKtaEQ9XrKo5c1HybNodKhKX0vVD40F4FADFQE/6
FoRYjR9Ajl7+EvWHBxPYBQhW/7OhMdenDnLfmJriSIjpyoEXkyWnjNd3JaHRYPRP
6eE6+pXkU/wMb7gAHvUelwn/7l/a1OPIZQBQYZDRiNTqHU3dglqO9YSjOTAorumB
DYI1z/AhJDOhQ7dOYaYZmclisj2ZwefwIBwMdTQSAeYB08Y3s/aD1rH+tW6oOtEt
nzjAtGYuVW1Xhc3ljbBTOppvgpPwjv06W9zq+64sTZAvJUqxVCsBasBK681qxhWF
XoYMaMaLoKz1OyrrAXUexkwNRDbmvmJRY8558lCvBG+WMjnW8u1CuOyeIzlppV38
QQSRb8UM4jv43HiUH6gQlw+RG8tTcNyGJhz+a4YLYqgREaIW3yg=
=izae
-----END PGP SIGNATURE-----

--ssHf/w3M5y+cB+4m--
