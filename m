Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B28361E2C
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 12:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbhDPKo4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbhDPKoz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Apr 2021 06:44:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0197C061574;
        Fri, 16 Apr 2021 03:44:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so41484430ejr.5;
        Fri, 16 Apr 2021 03:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1KGDjxlswScQbQGbOKk0xTZQmm/KErZthJQE0yDWY48=;
        b=LIvvMgLaZCNzN9xsJr0Pq5d0aVrjZ0V8wTj48cfqzmYA8JY1rL50gF1EYVm64uvxL9
         0oWxEr72qUDgfUMqZg8CF1FSd9CGqh1YhhsKyBQSiTliCyEQ4b2DNiPTqw3T0RIxTjyp
         Pqh9tMA3fLL3azOBvjRcksN9/aQ9TLG5j+1c0xjHRjjaWbLw+7jXy+Kf788ofSNNdv5q
         GkoB81sjED7IZH0PkjTdfCuk8n8q+RAFxbz1tNlWqqN7we5E95PPI8bPRA68MAgVoNHx
         2V4k4OIMhXtaZHkq8Wyo3kGQQ/7cakKFRE+8mewp+Z4kUsPRibFCQeEMl8xg2X9qClqp
         iNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KGDjxlswScQbQGbOKk0xTZQmm/KErZthJQE0yDWY48=;
        b=NWX/u/LrhRgzTOBEydvKjOLWxJsZXtBFhYjQU4px5Z//9ijBIcCEP984ANl2ED8uhz
         CWgaly7ZlW/GizIwCwPhl+3rc2j0XiTot2bhnbMydEjdrI6vVXgyNOJ8FxHE/Yn9qtcO
         fExV22bSZqHgN/2Lb+XvLFZIeRoAglbu4XkDoKiLihirHWFt0487kN9tcIe4MOblDRMz
         R5mzmBPTViLD67jezei3yfGmt50LBTmpn1GUjAuU55hMcyv4sk2g2j8hkNWvujKIIVtM
         GBqsG53sZ+550q96JVaCyViTS6zjVayKLROyJUriRXPuAZFIUADFwhB+1dFGzQpInr4h
         NVrA==
X-Gm-Message-State: AOAM532xYkDAW+qHyfwZRSKZfkN6q6alUwzmbhRHxBNuoxkEXjLy0Iu2
        RXlpUaGeYLigNUTSWtPWY5M=
X-Google-Smtp-Source: ABdhPJxu1FknTYKIMfxDvQZMawZStEpZLHXrn5na2De/9dJEQR5kKrfBNZ9JhIPxa/0DPpvfE3eR6Q==
X-Received: by 2002:a17:906:1fd7:: with SMTP id e23mr7499053ejt.528.1618569869160;
        Fri, 16 Apr 2021 03:44:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id i2sm3986909ejv.99.2021.04.16.03.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 03:44:27 -0700 (PDT)
Date:   Fri, 16 Apr 2021 12:45:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <YHlqtpLo59pB48pn@orome.fritz.box>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
 <YHWFs1f0XHkqbddp@orome.fritz.box>
 <20210413175631.pwbynvwmnn7oog4m@pengutronix.de>
 <YHhpVusyiBLWIM0V@orome.fritz.box>
 <20210416093212.rf5iwb7o4j2tjsc3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2PQKZfgfbkaecTmP"
Content-Disposition: inline
In-Reply-To: <20210416093212.rf5iwb7o4j2tjsc3@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2PQKZfgfbkaecTmP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 16, 2021 at 11:32:12AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Apr 15, 2021 at 06:27:02PM +0200, Thierry Reding wrote:
> > On Tue, Apr 13, 2021 at 07:56:31PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Apr 13, 2021 at 01:51:15PM +0200, Thierry Reding wrote:
> > > > On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> > > > > >  include/dt-bindings/pwm/pwm.h                 | 1 +
> > > > > >  2 files changed, 4 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Do=
cumentation/devicetree/bindings/pwm/pwm.txt
> > > > > > index 084886bd721e..fe3a28f887c0 100644
> > > > > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > > @@ -46,6 +46,9 @@ period in nanoseconds.
> > > > > >  Optionally, the pwm-specifier can encode a number of flags (de=
fined in
> > > > > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > > > > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > > > > +- PWM_USAGE_POWER: Only care about the power output of the sig=
nal. This
> > > > > > +  allows drivers (if supported) to optimize the signals, for e=
xample to
> > > > > > +  improve EMI and reduce current spikes.
> > > > >=20
> > > > > IMHO there are too many open questions about which freedom this g=
ives to
> > > > > the lowlevel driver. If the consumer requests .duty_cycle =3D 25n=
s +
> > > > > .period =3D 100ns, can the driver provide .duty_cycle =3D 25s + .=
period =3D
> > > > > 100s which nominally has the same power output? Let's not introdu=
ce more
> > > > > ambiguity than there already is.
> > > >=20
> > > > The freedom given to the driver should be to adjust the signal with=
in
> > > > reasonable bounds. Changing the time unit by a factor of 1000000000=
 is
> > > > not within reason, and I doubt anyone would interpret it that way, =
even
> > > > if we didn't document this at all.
> > >=20
> > > Please define a rule that allows to judge if any given implementation=
 is
> > > correct or not. For the record neither "within reasonable bounds" nor=
 "a
> > > factor of 1000000000 is not within reason" is good enough.
> >=20
> > We haven't had any rules thus far and I have yet to see a single report
> > that drivers get this completely wrong. So "within reason", which I
> > think is what driver authors will do by default, is good enough in
> > practice.
>=20
> For me commit 11fc4edc483b ("pwm: bcm2835: Improve precision of PWM")
> indicates that there is a problem. Someone used the pwm-ir-tx driver on
> top of pwm-bcm2835. The former driver's expectation is that
>=20
> 	period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> 	duty =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
> 	pwm_config(pwm, duty, period);
>=20
> yields a frequency near pwm_ir->carrier (minimizing
>=20
> 	abs(1 / implemented_freq - 1 / pwm_ir->carrier)
>=20
> (or should it minimize abs(implemented_freq - pwm_ir->carrier) instead?
> Not entirely sure.). The result was that the pwm-bcm2835 driver was
> changed to implement a different rounding. I took the time to look at
> the drivers in 11fc4edc483b^, with the following result:
>=20
>  - pwm-ab8500.c: ignores period_ns in .config
>  - pwm-atmel.c: rounds down period
>  - pwm-atmel-hlcdc.c: rounds up period (unsure)
>  - pwm-atmel-tcb.c: rounds down period (unsure)
>  - pwm-bcm2835.c: rounds down period
>  - pwm-bcm-iproc.c: rounds down period
>  - pwm-bcm-kona.c: rounds down period
>  - pwm-berlin.c: rounds down period
>  - pwm-brcmstb.c: rounds down period
>  - pwm-clps711x.c: doesn't support changing period (IMHO in a buggy way
>    because the period in the dts is just overwritten)
>  - pwm-crc: rounds down period
>  - pwm-cros-ec.c: doesn't support changing period
>  - pwm-ep93xx.c: rounds down period
>  - pwm-fsl-ftm.c: rounds down period
>  - pwm-hibvt.c: rounds down period
>  o pwm-img.c: confusing rounding behaviour
>  - pwm-imx1.c: just implements relative duty cycle
>  - pwm-imx27.c: rounds down period
>  + pwm-imx-tpm.c: rounds to nearest period (unsure)
>  - pwm-jz4740.c: rounds down period
>  - pwm-lp3943.c: rounds down period (apart from corner cases)
>  - pwm-lpc18xx-sct.c: rounds down period
>  - pwm-lpc32xx.c: rounds down period
>  - pwm-lpss.c: rounds up period
>  + pwm-mediatek.c: tries to implement round-nearest
>  - pwm-meson.c: tries to round down period
>  o pwm-mtk-disp.c: confusing rounding behaviour
>  - pwm-mxs.c: rounds down period
>  + pwm-omap-dmtimer.c: rounds to closest period
>  + pwm-pca9685.c: rounds to closest period
>  - pwm-puv3.c: rounds down period
>  - pwm-pxa.c: rounds down period
>  - pwm-rcar.c: rounds down period
>  o pwm-renesas-tpu.c: confusing rounding behaviour
>  + pwm-rockchip.c: rounds closest period
>  - pwm-samsung.c: rounds down period (unsure)
>  - pwm-sifive.c: rounds down period
>  - pwm-spear.c: rounds down period
>  - pwm-sti.c: rounds down period
>  - pwm-stm32.c: rounds down period
>  - pwm-stm32-lp.c: rounds down period
>  - pwm-stmpe.c: just implements relative duty cycle
>  + pwm-sun4i.c: rounds closest period
>  + pwm-tegra.c: tries to round nearest period
>  - pwm-tiecap.c: rounds down period
>  - pwm-tiehrpwm.c: rounds down period
>  - pwm-twl.c: just implements relative duty cycle
>  - pwm-twl-led.c: just implements relative duty cycle
>  - pwm-vt8500.c: rounds down period
>  - pwm-zx.c: rounds down period
>=20
> (- =3D doesn't behave "reasonable" to be used by pwm-ir-tx, + =3D behaves
> "reasonable" for pwm-ir-tx, o =3D don't know, too complicated for me to
> understand quickly (should we count that as -?))

I'm not sure I understand correctly, but aren't you actually making a
point against always using round-down now?

> So among the 51 drivers 7 were suitable to be used by the pwm-ir-tx
> driver and pwm-bcm2835 was "fixed" to become the eighth. IMHO this is
> ridiculous.

Just because a driver rounds down doesn't automatically make it
unsuitable.

> The right way is to improve the capabilities for consumers to make
> informed requests.

Agreed. But that's a different problem from forcing everyone to round
down. It's also different from adding something like PWM_USAGE_POWER. I
never said that the API was perfect for every possible use-case. What I
said was that we should be solving problems that actually exist.

> > > This is not only important to be able to review drivers that implement
> > > it, but also for consumers, because they should know what to expect.
> >=20
> > Again, consumers should expect that the PWM driver will do something
> > that is within reasonable margins. If that ever ends up being wrong for
> > a given use-case we may need to change that.
>=20
> Would you say that having 40 of 50 drivers being unsuitable to be used
> by pwm-ir-tx is a problem? If soon someone appears who reports that
> using pwm-ir-tx with pwm-mxs.c is broken, should we adapt how pwm-mxs.c
> rounds? If someone else appears who reports that pwm-sun4i.c doesn't
> work with the motor control driver (that assumes round-down because
> that's safer and is correct for most drivers), should we change
> pwm-sun4i.c to break the pwm-sun4i.c/pwm-ir-tx combination?

Clearly if there are two conflicting use-cases we need to find a way to
distinguish between them. But again, I'm not opposing improving things
in general. All I'm saying is that we shouldn't start making any
improvements that we don't even know are necessary.

The bottom line is that if we don't have a real use-case or an actual
bug, chances are we're just going to guess what is right, but we don't
really know, nor do we have a way of validating that our guess is any
good.

Also, if you go around and change existing behaviour, you're likely to
cause regressions. And you're going to cause them for no reason.

> IMHO this isn't a sane long-term plan. And in my eyes this is a good
> enough reason to work on improving the framework.

Again, yes, no problem improving the framework if there's an actual
problem. And whether you consider this sane or not isn't really
relevant. It works. That's what counts.

So if you do want to propose any changes, please make sure that they are
really necessary by a) showing how the current framework fails in a
specific case and b) showing how the proposed changes are going to fix
the issue. That's what we did back when the atomic API was introduced
and that's going to be my benchmark for any new proposals.

> > But I don't think it's necessary to take out all flexibility if we don't
> > have to. As long as things work fine there's no reason to make the rules
> > any more strict.
> >=20
> > > > To be frank I think that quest of yours to try and rid the PWM API =
of
> > > > all ambiguity is futile.
> > >=20
> > > I consider my quest about rounding reasonable. And I think this is
> > > painful because when the PWM framework was introduced it was too much=
 ad
> > > hoc and the APIs were not thought through enough. And because I don't
> > > want to have that repeated, I express my concerns here.
> >=20
> > Maybe try to look at this from another perspective. Maybe what you call
> > adhoc API was actually deliberately designed this way.
>=20
> In my eyes everyone who designs an API deliberately lax is a fool.

You might want to bring that up with RMK then, who initially wrote the
PWM API. But I already said that this argument goes both ways. If you
make the API deliberately strict you risk making it completely useless.

> (There are some valid reasons to not fix an API's behaviour. "Oh,
> drivers might round in one or the other direction, they can pick their
> way themselves" isn't such a reason. Something like: "Either way to fix
> rounding behaviour results in computationally complexity for some
> drivers and consumers should never care which behaviour is picked" can
> be valid.)

Also note that this doesn't have anything to do with the API itself.
There is no ambiguity in the API as to what period or duty cycle is
specified. There's no rounding or anything like that in the API.

How drivers interpret the parameters is necessarily device-specific
and PWMs just so happen to not need to be 100% accurate, which has the
nice benefit of allowing a wide range of controllers to work with a wide
range of use-cases.

I mean we've been over this. If you want to make the API very strict you
will ultimately end up making it useless because only the occasional
driver will be able to exactly program the parameters that were
requested.

And I don't know how many times I have to say this, but for the vast
majority it simply doesn't matter. Why should we prevent one PWM
controller from being usable if the use-case couldn't care less if the
signal ends up being slightly off?

> > To be honest I don't know what the intentions were when the original
> > PWM API was created, that was way before I took on maintenance of the
> > PWM subsystem.  The PWM framework adopted the existing API and there
> > was no reason to change it because it worked just fine.
> >=20
> > And I still don't see a reason for the API to change. Like I said, if we
> > ever run into a case where the current flexibility gets in the way and
> > yields unpredictable or unusable results, then that's something we have
> > to improve. But I don't think we should make any such changes if they're
> > not necessary, because then we may end up making matters worse.
> >=20
> > Also, I think this actually corroborates the need for something like the
> > usage flags in the PWM specifier. Currently drivers will do their best
> > to generate a PWM signal that's as close as possible to the requested
> > parameters.
>=20
> No, see above, most driver round down, not closest. (One problem is also
> that "as close as possible" isn't well defined.)

The probably round down because that's just what division does by
default. Again, this is just because it doesn't actually matter in
practice for the cases that people care about.

> > If that's not enough for a specific use-case, then that's
> > something that the new use-case has to describe somehow. They could do
> > that using a usage flag (perhaps something like PWM_USAGE_STRICT, which
> > may tell the driver to return an error if the requested parameters
> > cannot be applied exactly).
>=20
> I think this will result in too much problems in practise.

What I think or you think is irrelevant. This is pure speculation until
we have an actual use-case that requires this.

> > Another possibility is to give consumers a way of running a given
> > state through the driver but not applying just yet so that they can
> > inspect what the driver would have programmed and then make
> > adjustments (that's along the lines of what you had in mind with the
> > "round state" concept, I suppose).
>=20
> Yes. And this function can only be efficiently worked with if the
> rounding behaviour is known.
>=20
> > > > I've been trying to be lenient because you seem
> > > > motivated, but I think you're taking this too far. There are always
> > > > going to be cases that aren't completely clear-cut and where drivers
> > > > need the flexibility to cheat in order to be useful at all. If we g=
et to
> > > > a point where everything needs to be 100% accurate, the majority of=
 the
> > > > PWM controllers won't be usable at all.
> > > >=20
> > > > Don't let perfect be the enemy of good.
> > >=20
> > > I admit here I don't have a constructive idea how to define what is
> > > needed.
> > >=20
> > > For example if we only care about the relative duty cycle, a consumer
> > > requests
> > >=20
> > > 	.period =3D 1045
> > > 	.duty_cyle =3D 680
> > >=20
> > > and the driver can provide multiples of 100 ns for both .period and
> > > .duty_cycle, the candidates that might be sensible to chose from are
> > > (IMHO):
> > >=20
> > >  - exact relative duty:
> > >=20
> > > 	.period =3D 104500
> > > 	.duty_cycle =3D 68000
> > >=20
> > >  - round both values in the same direction, minimizing error
> > >=20
> > >  	.period =3D 1100
> > > 	.duty_cycle =3D 700
> > >=20
> > >    (requested relative duty =3D 65.07%, implemented =3D 63.64%; when
> > >    rounding both down we get 60%)
> > >=20
> > >  - round both values mathematically:=20
> > >=20
> > >  	.period =3D 1000
> > > 	.duty_cycle =3D 700
> > >=20
> > >    (yielding a relative duty of 70% instead of the requested 65.07%)
> > >=20
> > >  - Maybe
> > >=20
> > >  	.period =3D 1000
> > > 	.duty_cycle =3D 600
> > >=20
> > >    might also be preferable for some consumers?! (60%)
> > >=20
> > >  - Maybe
> > >=20
> > >  	.period =3D 2000
> > > 	.duty_cycle =3D 1300
> > >=20
> > >    is a good compromise because the relative duty is nearly exactly
> > >    matched and the period is only stretched by a factor < 2.
> > >=20
> > > In my eyes a driver author should be told which of these options shou=
ld
> > > be picked. Do you consider it obvious which of these options is the
> > > objective best? If so why? Do you agree that we should tell driver
> > > authors how to implement this before we have several drivers that all
> > > implement their own ideas and getting this in a consistent state is
> > > another pain?
> >=20
> > We already have several drivers implementing things inconsistently.
>=20
> I'm more ambitious here. I think inconstancies should be purged.

And how are you planning on doing that, exactly? There are factors in
this that can't be controller because the hardware was designed in a
specific way. Not all hardware is equal, so not all controllers will be
able to generate exactly the same signal as other controllers. There's
no way to get rid of these inconsistencies, so why bother trying?

> > And again, I don't see how that's a problem.
>=20
> So what should consumer driver authors request that wants "50% relative
> duty cycle with a period between 60 and 250 Hz" if they don't know how
> the underlying PWM driver behaves? Sure, you can say, a fitting value
> should be picked that yields a good enough setting for the machine that
> is currently worked with. But there is an algorithm that allows (given a
> consistent behaviour of the lowlevel drivers) to automatically pick a
> suitable setting. And this is what I want target for because I consider
> this is right behaviour for a good OS.

Like I said, in most cases there's no need for the consumer driver
author to pick that value because it will come from device tree. If the
period needs to be between 60 and 250 Hz, then the board designer can
pick any value that can be most accurately be programmed in hardware. If
there are additional restrictions on the duty cycle then they may take
that into account as well.

> Do you remember the times when you had to specify mode lines for your
> monitor in your X-server's configuration? Do you think that today's
> status quo where needing to hand-tune an xorg.conf is a big exception
> is an improvement? I think yes, and my efforts for PWM are similar.

You're comparing apples to oranges. The reason why you no longer have to
configure modelines for X to work is because drivers can probe the
monitor's EDID for the equivalent of those modelines.

For PWM the equivalent of EDID would be DT or PWM lookup tables. So PWM
isn't the Neanderthal that you make it out to be.

But if you want to stick with the example of monitors: display drivers
are not always able to exactly generate the required pixel clock for a
given mode. The end result is that sometimes your vertical refresh rate
of a monitor is not exactly the 60 Hz that you've asked for but perhaps
60.03 Hz or 59.27 Hz. And just like for PWM this doesn't matter in the
majority of cases. In the cases where it does matter and you need
perfect synchronization the system designers will have made sure that
the target refresh rate can be met. This may mean, though, that you
cannot support arbitrary monitors. Instead you may have to select one
specific monitor with exactly the pixel clock that you can match.

> If you're happy with the PWM framework that it only solves the problems
> it already solved 10 years ago there is no need to work on it. If
> however you want to improve the solutions saying "oh, there are
> inconsistencies, but I don't see how that's problem" isn't good enough.

Again, this isn't about me trying to oppose progress. If there's a real
problem that needs a different solution, then I agree we should improve
things. But so far none of these proposals are because there are new
problems. You're just trying to change how things work because it bugs
you that they are not completely consistent. And please keep in mind
that if you go around changing behaviour just for the sake of
consistency you might accidentally end up breaking existing use-cases.
And that's just going to annoy other people.

So again, if you want to change something, please go and find a real
problem that needs that change.

That said, PWM_USAGE_POWER is a solution for a new problem. So far you
are the one objecting to this improvement and the only reasons for
objecting have been along the lines of "I don't like it", or "I think
it's going to cause problems".

> > Most of the time, values for
> > period will be hand-picked to match the requirements of the use-case on
> > a given platform (for backlights or LEDs, for example, you don't want a
> > period that's too long, because then you'll get flicker). The duty cycle
> > is then simply used as a way of getting a power output of the desired
> > percentage. For something like PWM backlight, if interpolation doesn't
> > work, you have the option of specifying discrete levels with hand-picked
> > values.
> >=20
> > Backlight and LEDs are the vast majority of applications for PWMs used
> > in the kernel today. Another category would be regulators and they end
> > up being pretty much the same in where the values come from.
> >=20
> > The one use-case that's perhaps a bit more tricky is the sysfs interface
> > because people can throw whatever they want at it. But even that is not
> > likely to be problematic in practice because users will either be
> > satisfied with the result that they get when computationally getting the
> > numbers, or end up hand-picking values for those as well, with the only
> > difference being that they are programmed from userspace.
>=20
> So the PWM API doesn't provide what it should be there for: Abstracting
> PWM hardware. Consumers seem to have to know exactly what hardware is
> used and modify their usage of the API accordingly. (Or even adapt the
> driver to do what matches their use-case break another one.) :-\

You seem to have a strange definition of what "abstraction" means. I
don't even know what to reply to this.

> > For the particular case of PWM_USAGE_POWER, I think it really only says
> > that the power output of the signal should be as requested. It does not
> > mean that the driver can pick whatever values it wants. Drivers should
> > still try to match period and duty cycle as closely as possible because
> > there's not enough other information to know if, for example, stretching
> > the clock by a factor of 2 is reasonable for the use-case.
>=20
> So if this factor of 2 is the best some given driver can provide, the
> request should be declined, right? Where do you draw the line? Is 1.5
> the biggest factor that should be allowed? IMHO this is a question we
> should be ready to answer before driver authors start proposing patches.

I said the driver should still try to match period and duty cycle as
closely as possible, but if stretching by a factor of 2 is the best it
can do, then that's tough luck, but not a reason to reject the request.
A potentially unusable result is better than no result at all.

But this is again pure speculation. In practice this isn't going to
happen because nobody is going to design a system to perform some task
using components that are not capable of performing those tasks. So if
you need to set a period of 60 Hz for a PWM signal for a given use-case
and you need it to be exactly 60 Hz, then you're going to have to use
components that can achieve these 60 Hz. If you choose hardware that can
only do 30 Hz, there's just no way you can make it work.

> > > (My bet is you are lax and don't consider consistency among drivers s=
oo
> > > important. In this case we don't agree. I think it's important for
> > > consumer driver authors to be able to rely on some expectations
> > > independently which lowlevel driver is in use.)
> >=20
> > Well, yeah. Consumers should be able to rely on the expectation that the
> > provider will try to best match the given parameters. Something like
> > PWM_USAGE_POWER can be used to give the driver a bit more freedom, but
> > it doesn't mean it should switch into crazy mode.
>=20
> I didn't suggest doing something deliberately crazy. I only want a to
> know how to judge a patch that adds support for this concept. Because
> then we will have to decide if you take this patch or not.

Sorry, but I'm not a psychic. I don't know what exactly people will want
to do with this, so I can't give you a checklist for what I consider to
be okay and what not. We'll have to decide that as these cases come up.
Right now it means that the drivers will be able to modify the offset in
order to optimize for EMI.

Thierry

--2PQKZfgfbkaecTmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmB5arQACgkQ3SOs138+
s6GClRAApoOpRJP+E7r4oPcmOkgq8/J2M3bQmlPTlO5PEwo1uqywIfTO0PIt9K55
F6Md+oG5RUhJAW6BHh7EXwskCh1+mK7sP3VpLgX4SBTS5Mz1oz5NP5lRd9NVe0yH
XcWsyqCCvNLkWSJkCK3ne8wEUBcji2uoJ2jjeFgGAb7ygNcvqMMw/rCqrwRcoa8M
m3lXZwxQx4Dg2O8IgpNkPB2YXt5NGVeOGWgTm4K4xk0Rcx7fg4E4Vn7pu2VaLOvB
lsRGQTyi6suOcPSnj88ZMa3F+Rh6oYF/qxmgtZpxQrZZ4KffOaQgckfKHcrEjl3W
HEL8ZXYsTB3yfubETH6XWFL7CIj1hwtPGsiucRaBbMisf4AJkCQWNm699sXYD4WR
Fpydp4OPma5h7o4PNWig/b0hRn1+qYcQvgsP6enlLGVczieSuyw5cdYKJTl5v1rL
gVzLV/oTvzfITESyJsxFm3LlENrzFRBOUn9NSF65pGlPgPNUcWzKYV0zhiYkyvJd
smQ+cFegBwM4ajTZxb9AUBX5Oyu6kggmbVGrHhXucJm428AZi5GKYykJzgCvGfgA
FvNLWSRq0ZRNwDFRPctnwyJyB9Hmom5OagLjdLUiSSWLl1TDcu7RHchUJCkk2i8f
jtPg6WkXfB6Pr7NHCveYBtl0niGLx4VU3GwE1KBOxDmlhDIaze0=
=8lvc
-----END PGP SIGNATURE-----

--2PQKZfgfbkaecTmP--
