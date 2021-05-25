Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE73906C5
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhEYQlF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhEYQlF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 12:41:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F045C061574
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:39:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so32924830wrq.7
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEKgoi2/bl5p1Vp5VslwoOtEKcH+XHZmWKomAsa1ah4=;
        b=Iz7gosRTk5IGEy3BTOerDjpxERmnYHc3S4V/cEO+bStXkiWnXSUkzx++25aTQClwsY
         mJaZ1QHEi0FHxZrNElSvsFwctxa9qDZQIabueuI21b5C334LCIxz3dRB3nvMkzkXFZvq
         h4e2qye7Xw5ea7YoRNK4ErV14YD4F8sZi7DHsXfVNFoaFe3+rYlYqjZNAFvfUYIT4dTa
         pnB3jIjzsL47b8sL3PSZhMW9tjLfez8lRjVa2UOlu93uo5mqMk9ikF0pVsWPUGFeKJCH
         9OUNN98bvhN0dIYhq1NNoJtuXFtm13ePS7OzVgEsvsKOceozDbL20UlsaA71p7UjqUyu
         GhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEKgoi2/bl5p1Vp5VslwoOtEKcH+XHZmWKomAsa1ah4=;
        b=bDj/HTk4zOS/7416TIi3i243RrcLdJR2famdk1CXy9FV8XONBuB9aIWTxlfaDV/vds
         1930iH0fDMFMW80NQq9cmRkeeECJaM1Ui6Q49lZEb6EgMKU11KDPTapF7Kebra934AdW
         iPbNTNbvQ+A2KL4DOom8xN6prMjH4jy6qooaiZDx8di2hwKFJMz8l5qpYAo1hT6KziKF
         mm4nCtvc/TrKzAddfKUmz7bLriFwwjCCIOemzvggtuBlm/CLQE+aLdPrHmEeDBPo7ghv
         A3YwvDzTe1OBCbyXB2X3mSa/AEa09T5aOl06B1YSqz3FaASNKzjyhn7bP8P39h8z1X+L
         O83A==
X-Gm-Message-State: AOAM530F1uA95kFM5mDHwqZ0/q8W5OsJYQggKYJdyO3kIi/LBIkRirgf
        Yq5Tpuu29h/KH9fvHsdW29s=
X-Google-Smtp-Source: ABdhPJwOqI8HA0KrvXSLUIa4TLMtXrZvotnrSrOccv3vDeHR28gkQLfrT+HQTPMVGpG27i7qAoV2QA==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr29122996wrt.189.1621960773804;
        Tue, 25 May 2021 09:39:33 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 11sm11715857wmo.24.2021.05.25.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:39:32 -0700 (PDT)
Date:   Tue, 25 May 2021 18:41:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Roman Beranek <roman.beranek@prusa3d.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
Message-ID: <YK0onNy2r30aNw2g@orome.fritz.box>
References: <20210511220014.1945519-1-roman.beranek@prusa3d.com>
 <CAO1O6seU7t==O=yCVBQK0iAkeEyO3dbRQ71obJh3Jm26xxWobw@mail.gmail.com>
 <20210512044133.6yfwyluzdx6yfh4c@pengutronix.de>
 <CAO1O6sfZ0O7JExw07UytBcNROc9TQsu9bBp-+zFF3824PxxvRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zw6ChVpkyZLA/4W4"
Content-Disposition: inline
In-Reply-To: <CAO1O6sfZ0O7JExw07UytBcNROc9TQsu9bBp-+zFF3824PxxvRA@mail.gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Zw6ChVpkyZLA/4W4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 11:18:24AM +0200, Emil Lenngren wrote:
> Hi Uwe,
>=20
> Den ons 12 maj 2021 kl 06:41 skrev Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de>:
> >
> > Hello Emil,
> >
> > On Wed, May 12, 2021 at 02:55:26AM +0200, Emil Lenngren wrote:
> > > Well that's one way of "solving it" ;)
> > >
> > > But on what hardware do you really need to wait until one full pulse
> > > cycle ends, before a disable command takes effect?
> > >
> > > On the hardware I've tested on (GR8 and V3s), it's enough to wait at
> > > most two clock cycles in order for it to take effect before we can
> > > close the gate. And with clock cycle I mean 24 MHz divided by the
> > > prescaler. With prescaler 1, that's 84 nanoseconds. By closing the
> > > gate when the pwm should be disabled, I guess we could save some
> > > nanoampere or microampere (is this important?)
> >
> > If I understood correctly you really have to wait longer to achieve that
> > the output is inactive in the disabled state. Do you talk about the same
> > thing?
>=20
> Exactly, i.e. after writing 0 to the EN bit, we don't have to wait
> until the current period ends before we can observe that the output
> signal goes to the inactive state.
>=20
> Simple test:
>=20
> 1. Set pwm interval to a long time like 2 seconds, and duty to 50%.
> 2. Enable clock gating.
> 3. Enable the pwm by writing 1 to the EN bit.
> 4. Observe the LED blink once per second.
> 5. Now at a random time write 0 to the EN bit in order to disable the
> pwm. Don't turn off the clock gating.
> 6. If you just look with the eye it appears the LED turns off
> immediately, regardless of when in the pulse cycle we disabled it.
>=20
> Just tested the above using "devmem" on a V3s.
>=20
> By using a large prescaler and testing some different prescalers, I've
> concluded that it takes at least 1 and at most 2 clock cycles before
> we can safely turn off the gate and be certain that the output pin has
> changed to disabled.
>=20
> It would be good if people having other hardware could confirm this is
> correct there as well.
>=20
> Please take a look at some previous material I wrote:
> https://lkml.org/lkml/2020/3/17/1158
> https://linux-sunxi.org/PWM_Controller_Register_Guide (Observed
> behaviour on GR8 from NextThing)
> https://pastebin.com/GWrhWzPJ

I'm pretty sure Alexandre at the time reported that the instantiation of
the controller that he was using required waiting for the period to
complete before the output went to the disabled state. It's possible
that this was changed in subsequent versions of the IP, so perhaps we
need to distinguish based on compatible string?

Thierry

--Zw6ChVpkyZLA/4W4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCtKJoACgkQ3SOs138+
s6E1JQ/9HBO69yTjzg/VrUEso77SFSIA1lN06S4tgKqlKULo4dc/wOu51VmixraP
tTGvyiKbZXiFNtvJN77lGKB3T7m/+JtgIi5Tyle+6kun1xPSHee8rF5bUD0ebyFb
lnZSeOgoKzz8TSEJ7jIN19NxQCn5R4OfviHWIM/JZNoWcFkVCOBkeqlxWf63gFDD
8EpDEavfS05OVEACybCf3sgl9SZJBsvMmlJvuHw8G+u62iFmrlOKRxEZSaqQS5nm
EKsb+qSrTjTws4uGuy9mIjz00cViUWwl/yK0cQ3km5spvmjXQRQfLr7KyAQUfwN1
iUiy725WqQl28jXoXWf83t6wQ/aCBxzaZHMmW7LbRrerqzyBuqBLj+mQfL6Vw7BC
AbFlCRQPD87bNuRhlQ72wypz00tgX0xXbr+mQ5l8+Kx52QAliapJIH3GR4VthBQl
8YqsuXwMnNApsDTP7LxGp+mVPWLvUXvtFYOLSofXzI5eY4f0A53v1PBjh9VrTgq3
Z6/VZVmWi3GeRXyqiHIK9xUdsrEuXU6iKIXugx5SpZI19WIyTxsNO9LDWp81QwbM
4YDSeq7Yb40DZOIGxYz9vzCe3RTgqHiTRTrhS5rrjeV/kI1/1Vg/dIdxczz7oMMG
E7gVp8D1scYVJh8L/v0Ps6ppIn5UfrzFXNYSSC7FAkw138V8Z9A=
=FYSH
-----END PGP SIGNATURE-----

--Zw6ChVpkyZLA/4W4--
