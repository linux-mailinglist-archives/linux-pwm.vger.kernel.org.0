Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035F312BE7
	for <lists+linux-pwm@lfdr.de>; Fri,  3 May 2019 12:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfECK7U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 May 2019 06:59:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37865 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECK7U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 May 2019 06:59:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id d22so198050wrb.4
        for <linux-pwm@vger.kernel.org>; Fri, 03 May 2019 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5rxy6SfJBZnAq3uFHN0kqyFQfSAzVuo5Do6PMEVa1dI=;
        b=GFF4C6isNDRPJr902DGZp8mI7Yk6pabvBWcF3wpso0z+AFBg5UQ7TH0oi+mA4xZr9i
         Y6gYIE5MtavBerOk2x1cZNjBiPjkIKUwlWL07g8sCZSxAkFPQF76XThfe39q0b70bORj
         vS3hMKRiunXOr2KIgBd10DMddcqxdA+MnCR/NewxbcrRN0lYX3MT46UDe14Z9u7JkEwx
         c9iJZpLNW1HTh8GGK+D7f1epln2EYlTro+jOlG6hRSyEQ3USxa+MhfKN/XFKrGY1WJQW
         PNXvlC/eQWKUOnyoNvcaGVOT1in/KElcWEv8Q7D61uJIqj3bx3dPnmNPNYhDC+BkdkDw
         0i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5rxy6SfJBZnAq3uFHN0kqyFQfSAzVuo5Do6PMEVa1dI=;
        b=OUew4A4TinzU3ogVRyFoZcc5GxIKnp+u/QYK7PBGl5cpc8eL+2AqbiUcsS7Jk0dZT7
         3I2eQKrgZLMuMn9kivw+uJsJP1orFyNfWSsXU1HdPJqxOg2iXaYfjAOcFcryXBK7gtFl
         WqeCjbzYP9WhuwJ7ao5aNPtw0d7vrWLn8cMttRA2VdFlD1uk/hdv4AjAI/opJhOjJM+G
         dAUwiS546C6jGCkiNsY6Ag/4t48O3SKwoLGdH2dr86J5Khn2boNvnBaVoIv2E1h3bBFe
         32qVRIQIFwNxRIg52E3XA3vsRTnxIDLfx3C3N6MXo1C7SulspUclIQ7tOGpcbhTrhnLr
         y5xg==
X-Gm-Message-State: APjAAAXInlhGfVmH098RT9fo4e3VG4jVLFxBbO/RAGTe/qKCXNoI9uer
        02TInGxU/jTfNvCv3qstdXk=
X-Google-Smtp-Source: APXvYqysOV6PS0TrpR9tHQ2oxal5goDHq8Aa/ejcUJ1qgiCQFSjyO5fsuqwHc5tRmQI8iqY5ofBsCw==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr6705313wro.206.1556881157830;
        Fri, 03 May 2019 03:59:17 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id i8sm2678244wrb.5.2019.05.03.03.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 03:59:16 -0700 (PDT)
Date:   Fri, 3 May 2019 12:59:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190503105915.GA32400@ulmo>
References: <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190502091638.0f5a40b0@collabora.com>
 <20190502073326.sgqgkiexjkipvi27@pengutronix.de>
 <20190502100951.23ef9ed1@collabora.com>
 <20190502084243.anz5myut63g4torn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20190502084243.anz5myut63g4torn@pengutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 10:42:43AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Boris,
>=20
> On Thu, May 02, 2019 at 10:09:51AM +0200, Boris Brezillon wrote:
> > On Thu, 2 May 2019 09:33:26 +0200
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >=20
> > > Hello Boris,
> > >=20
> > > On Thu, May 02, 2019 at 09:16:38AM +0200, Boris Brezillon wrote:
> > > > On Mon, 29 Apr 2019 11:04:20 -0700
> > > > Doug Anderson <dianders@chromium.org> wrote:
> > > >  =20
> > > > > Hi,
> > > > >=20
> > > > > On Sun, Apr 28, 2019 at 11:56 PM Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@pengutronix.de> wrote: =20
> > > > > >
> > > > > > On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:  =
 =20
> > > > > > > Hi,
> > > > > > >
> > > > > > > I'm not sure if I'm misreading you, but I thought I'd add her=
e before
> > > > > > > this expires out of my inbox:
> > > > > > >
> > > > > > > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-K=C3=B6nig
> > > > > > > <u.kleine-koenig@pengutronix.de> wrote:   =20
> > > > > > > > My intention here is more to make all drivers behave the sa=
me way and
> > > > > > > > because only two drivers updated the pwm_state this was the=
 variant I
> > > > > > > > removed.   =20
> > > > > > >
> > > > > > > To be clear, this patch on its own is probably breaking thing=
s. Just
> > > > > > > because the other drivers don't implement the documented beha=
vior
> > > > > > > doesn't mean you should break this driver. Maybe the others j=
ust
> > > > > > > aren't used in precise enough scenarios where this matters.
> > > > > > >   =20
> > > > > > > > When you say that the caller might actually care about the =
exact
> > > > > > > > parameters I fully agree. In this case however the consumer=
 should be
> > > > > > > > able to know the result before actually applying it. So if =
you do
> > > > > > > >
> > > > > > > >         pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =
=3D 12, ...})
> > > > > > > >
> > > > > > > > and this results in .period =3D 100 and .duty_cycle =3D 0 t=
hen probably the
> > > > > > > > bad things you want to know about already happend. So my id=
ea is a new
> > > > > > > > function pwm_round_state() that does the adaptions to pwm_s=
tate without
> > > > > > > > applying it to the hardware. After that pwm_apply_state cou=
ld do the
> > > > > > > > following:
> > > > > > > >
> > > > > > > >         rstate =3D pwm_round_state(pwm, state)
> > > > > > > >         pwm.apply(pwm, state)
> > > > > > > >         gstate =3D pwm_get_state(pwm)
> > > > > > > >
> > > > > > > >         if rstate !=3D gstate:
> > > > > > > >                 warn about problems   =20
> > > > > > >
> > > > > > > For our case (we're using this with pwm-regulator), I don't r=
ecall [*]
> > > > > > > we need to be 100% precise about the period, but we do need t=
o be as
> > > > > > > precise as possible with the duty:period ratio -- so once we =
get the
> > > > > > > "feedback" from the underlying PWM driver what the real perio=
d will
> > > > > > > be, we adjust the duty appropriately.   =20
> > > > > >
> > > > > > I admit that I didn't understood the whole situation and (some)=
 things
> > > > > > are worse with my patches applied. I still think that changing =
the
> > > > > > caller's state variable is bad design, but of course pwm_get_st=
ate
> > > > > > should return the currently implemented configuration.   =20
> > > > >=20
> > > > > Regardless of the pros and cons of the current situation, hopeful=
ly
> > > > > we're in agreement that we shouldn't break existing users?  In ge=
neral
> > > > > I'll probably stay out of the debate as long as we end somewhere =
that
> > > > > pwm_regulator is able to somehow know the actual state that it
> > > > > programmed into the hardware.
> > > > >=20
> > > > > +Boris too in case he has any comments. =20
> > > >=20
> > > > Well, the pwm_round_state() approach sounds okay to me, though I do=
n't
> > > > really see why it's wrong to adjust the state in pwm_apply_state()
> > > > (just like clk_set_rate() will round the rate for you by internally
> > > > calling clk_round_rate() before applying the config). =20
> > >=20
> > > This are two orthogonal things. The "should pwm_apply_state change the
> > > state argument" isn't really comparable to the clk stuff, as there on=
ly
> > > the frequency is provided that is passed by value, not by reference as
> > > the PWM state.
> > >=20
> > > The key argument for me to *not* change it is that it might yield
> > > surprises, still more as today most drivers don't adapt. An -- I admit
> > > constructed, not real-word -- case where adaption would go wrong is:
> > >=20
> > > 	pwm_apply_state(pwm1, &mystate);
> > > 	pwm_apply_state(pwm2, &mystate);
> >=20
> > I see, but it's also clearly documented that pwm_apply_state() might
> > adjust the period/duty params [1], and it's not like we have a lot of
> > PWM users converted to use pwm_apply_state(), so I'd expect them to be
> > aware of that and use a reference pwm_state if they need to apply it
> > to different devices.
>=20
> If we accept that pwm_apply_state should adapt its state argument that
> would be ok for me, too. Then however we should make this consistent and
> consider a deviation that is not reported there as a bug.
>=20
> Note there are also more subtile problems. For example something like:
>=20
> 	def enable(self):
> 		state =3D pwm_get_state(self.pwm)
> 		state.duty_cycle *=3D 2
> 		pwm_apply_state(self.pwm, state)
>=20
> 	def disable(self):
> 		state =3D pwm_get_state(self.pwm)
> 		state.duty_cycle /=3D 2
> 		pwm_apply_state(self.pwm, state)
>=20
> doesn't guarantee that the sequence enable(); disable(); is idempotent.
> So my favourite would be to not modfies the caller's copy of state for
> pwm_apply_state(). (Note, this doesn't necessarily have implications
> about the semantik of the lowlevel driver callbacks.) Still
> pwm_get_state() should work and yield the corrected settings.
>=20
> > > > Note that pwm_config() is doing exactly the same: it adjusts the
> > > > config to HW caps, excepts in that case you don't know it. =20
> > >=20
> > > I don't see what you mean here. I don't see any adaption.
> >=20
> > I mean that the config you end up is not necessarily what you asked
> > for, and pwm_apply_state() was making that explicit by returning the
> > actual PWM state instead of letting the user think its config has been
> > applied with no adjustment.
>=20
> Ah. Of course the lowlevel driver has to work with the capabilities of
> the hardware. That is something we cannot get rid of. It's just a
> question how we communicate this to the consumer.
>=20
> > > > I do understand that some users might want to check how the HW will
> > > > adjust the period/duty before applying the new setup, and in that
> > > > regard, having pwm_round_rate() is a good thing. But in any case, i=
t's
> > > > hard for the user to decide how to adjust things to get what it wan=
ts
> > > > (should he increase/decrease the period/duty?). =20
> > >=20
> > > It depends on the use case. For one of them I suggested an algorithm.
> >=20
> > Yes, I was just trying to say that passing a PWM state to
> > pwm_round_state() is not enough, we need extra info if we want to make
> > it useful, like the rounding policy, the accepted deviation on period,
> > duty or the duty/period ratio, ....
>=20
> Ack. My suggestion is that round_rate should do:
>=20
> 	if polarity is unsupported:
> 		polarity =3D !polarity
> 		duty_cycle =3D period - duty_cycle

This should really be up to the consumer. The PWM framework or driver
doesn't know whether or not the consumer cares about the polarity or
whether it only cares about the power output.

> 	period =3D biggest supportable period <=3D requested period, 0 if no
> 		such period exists.
>=20
> 	duty_cycle =3D biggest supportable duty cycle <=3D requested
> 		duty_cycle, 0 if no such value exists

This doesn't really work. We need some way to detect "value does not
exist" that is different from value =3D=3D 0, because value =3D=3D 0 is a
legitimate use-case.

> This would allow to let the consumer (or framework helper function)
> decide which deviation is ok.

So what's the consumer supposed to do if it gets back these values? How
does it know how to scale them if the deviation is not okay? What in
case the hardware can do achieve a good period that is slightly bigger
than the requested period and which would give a very good result?

Thierry

> > > > My impression is that most users care about the duty/period ratio w=
ith
> > > > little interest in accurate period settings (as long as it's close
> > > > enough to what they expect of course). For the round-up/down/closest
> > > > aspect, I guess that's also something we can pass to the new API. S=
o,
> > > > rather than passing it a duty in ns, maybe we could pass it a ratio
> > > > (percent is probably not precise enough for some use cases, so we c=
ould
> > > > make it per-million). =20
> > >=20
> > > Yeah, something like that would be good. Still for the device drivers=
 I
> > > would use the callback I suggested because that is easier to implemen=
t.
> >=20
> > Sorry, I just joined the discussion and couldn't find the email where
> > you suggested a new driver hook to deal with that.=20
>=20
> https://www.spinics.net/lists/linux-pwm/msg09627.html
>=20
> > > This way the complexity is once in the framework instead of in each
> > > driver.
> >=20
> > I think we want to make it possible for drivers to do complex
> > adjustments, and that implies passing all info  to the new driver
> > hook. The core can then provide generic helpers for simple use-cases
> > (approximation for static period/duty steps, where no reclocking is
> > involved).
>=20
> The problem is that it is hard to come up with a formalism to map "all
> info" because there are so many different ways to prefer one
> configuration over another. I believe we won't be able to design a sane
> callback prototype that allows to map all use cases.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMHwAACgkQ3SOs138+
s6GfjBAApfef9lLpp1SYPigLcrEu/buiFN3VqHx3Poeiz5FfS0ILUDf8NMuOKtsi
LOQ0w6AydvW1OSO3r16czvW8ItqGIYX4Kss/ZMgGsKSfdQYdmR1QUyOwGw9Yh4UA
bY2uS1G5jGpsshCNkCW9jh1AwZWE8xsBERav4P2fODEeIMjQaTI2kNxBkC93vMmM
Uau6UqGpc6Etwk6mku3evnQUPjORoOBcLGvNEb+LeifoUYzBT9VRJqOSgAlwodr4
r/DoWakD1KnoWVxzQBo5kSXqTci9KLeE2H87bcPvPx2agdbkVNvGLMjeMsZlY9uo
B047bg0pbBPAjwDA6hEDB3/ycXlRT7LhTGG61r5fxgEfbrKkqYph/Ef9UFaq3DXv
fMUAUf6JKktSUE+hCmlXdbC9M2lGiGcSvPoC+Ny06fBpm4Ns1Fxrhck89t5+BaZ9
88nUFT0H7+KhHcY4sYP64W6SLVXh/Me3Xm+OEMdLGWCMa8kf+40IMaX2lrV7OI+0
SJpdetL6wuMl4vmh9mI0F6Kw4mpHyvxyHzJGpW1A0FDfMadgqVjX6mvQixuyxamA
b2HCG5/n83z7mibtIjh3rWz9ilC5Ohr9XRk75QwF9oQIJjQZrxFyqDJA7eu89vlF
IA/KqYW7TH3SweYVhzPuREz+CvMyyjn8yQgNGxEcGC0ML5wZyVg=
=M9mj
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
