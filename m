Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0010936358C
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Apr 2021 15:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhDRNbh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRNbg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 09:31:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB48C06174A
        for <linux-pwm@vger.kernel.org>; Sun, 18 Apr 2021 06:31:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lY7Vu-0004eh-AP; Sun, 18 Apr 2021 15:31:02 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lY7Vt-000683-Eg; Sun, 18 Apr 2021 15:31:01 +0200
Date:   Sun, 18 Apr 2021 15:30:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <20210418133058.q7wd22v7hk5xwhsz@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
 <YHWFs1f0XHkqbddp@orome.fritz.box>
 <20210413175631.pwbynvwmnn7oog4m@pengutronix.de>
 <YHhpVusyiBLWIM0V@orome.fritz.box>
 <20210416093212.rf5iwb7o4j2tjsc3@pengutronix.de>
 <YHlqtpLo59pB48pn@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ukl755hyffbqs5m7"
Content-Disposition: inline
In-Reply-To: <YHlqtpLo59pB48pn@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ukl755hyffbqs5m7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Apr 16, 2021 at 12:45:10PM +0200, Thierry Reding wrote:
> On Fri, Apr 16, 2021 at 11:32:12AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Apr 15, 2021 at 06:27:02PM +0200, Thierry Reding wrote:
> > > On Tue, Apr 13, 2021 at 07:56:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > Please define a rule that allows to judge if any given implementati=
on is
> > > > correct or not. For the record neither "within reasonable bounds" n=
or "a
> > > > factor of 1000000000 is not within reason" is good enough.
> > >=20
> > > We haven't had any rules thus far and I have yet to see a single repo=
rt
> > > that drivers get this completely wrong. So "within reason", which I
> > > think is what driver authors will do by default, is good enough in
> > > practice.
> >=20
> > For me commit 11fc4edc483b ("pwm: bcm2835: Improve precision of PWM")
> > indicates that there is a problem. Someone used the pwm-ir-tx driver on
> > top of pwm-bcm2835. The former driver's expectation is that
> >=20
> > 	period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> > 	duty =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
> > 	pwm_config(pwm, duty, period);
> >=20
> > yields a frequency near pwm_ir->carrier (minimizing
> >=20
> > 	abs(1 / implemented_freq - 1 / pwm_ir->carrier)
> >=20
> > (or should it minimize abs(implemented_freq - pwm_ir->carrier) instead?
> > Not entirely sure.). The result was that the pwm-bcm2835 driver was
> > changed to implement a different rounding. I took the time to look at
> > the drivers in 11fc4edc483b^, with the following result:
> >=20
> >  - pwm-ab8500.c: ignores period_ns in .config
> >  - pwm-atmel.c: rounds down period
> >  - pwm-atmel-hlcdc.c: rounds up period (unsure)
> >  - pwm-atmel-tcb.c: rounds down period (unsure)
> >  - pwm-bcm2835.c: rounds down period
> >  - pwm-bcm-iproc.c: rounds down period
> >  - pwm-bcm-kona.c: rounds down period
> >  - pwm-berlin.c: rounds down period
> >  - pwm-brcmstb.c: rounds down period
> >  - pwm-clps711x.c: doesn't support changing period (IMHO in a buggy way
> >    because the period in the dts is just overwritten)
> >  - pwm-crc: rounds down period
> >  - pwm-cros-ec.c: doesn't support changing period
> >  - pwm-ep93xx.c: rounds down period
> >  - pwm-fsl-ftm.c: rounds down period
> >  - pwm-hibvt.c: rounds down period
> >  o pwm-img.c: confusing rounding behaviour
> >  - pwm-imx1.c: just implements relative duty cycle
> >  - pwm-imx27.c: rounds down period
> >  + pwm-imx-tpm.c: rounds to nearest period (unsure)
> >  - pwm-jz4740.c: rounds down period
> >  - pwm-lp3943.c: rounds down period (apart from corner cases)
> >  - pwm-lpc18xx-sct.c: rounds down period
> >  - pwm-lpc32xx.c: rounds down period
> >  - pwm-lpss.c: rounds up period
> >  + pwm-mediatek.c: tries to implement round-nearest
> >  - pwm-meson.c: tries to round down period
> >  o pwm-mtk-disp.c: confusing rounding behaviour
> >  - pwm-mxs.c: rounds down period
> >  + pwm-omap-dmtimer.c: rounds to closest period
> >  + pwm-pca9685.c: rounds to closest period
> >  - pwm-puv3.c: rounds down period
> >  - pwm-pxa.c: rounds down period
> >  - pwm-rcar.c: rounds down period
> >  o pwm-renesas-tpu.c: confusing rounding behaviour
> >  + pwm-rockchip.c: rounds closest period
> >  - pwm-samsung.c: rounds down period (unsure)
> >  - pwm-sifive.c: rounds down period
> >  - pwm-spear.c: rounds down period
> >  - pwm-sti.c: rounds down period
> >  - pwm-stm32.c: rounds down period
> >  - pwm-stm32-lp.c: rounds down period
> >  - pwm-stmpe.c: just implements relative duty cycle
> >  + pwm-sun4i.c: rounds closest period
> >  + pwm-tegra.c: tries to round nearest period
> >  - pwm-tiecap.c: rounds down period
> >  - pwm-tiehrpwm.c: rounds down period
> >  - pwm-twl.c: just implements relative duty cycle
> >  - pwm-twl-led.c: just implements relative duty cycle
> >  - pwm-vt8500.c: rounds down period
> >  - pwm-zx.c: rounds down period
> >=20
> > (- =3D doesn't behave "reasonable" to be used by pwm-ir-tx, + =3D behav=
es
> > "reasonable" for pwm-ir-tx, o =3D don't know, too complicated for me to
> > understand quickly (should we count that as -?))
>=20
> I'm not sure I understand correctly, but aren't you actually making a
> point against always using round-down now?

Not really. This is indeed a case where round-down isn't the right thing
for a consumer. As there are also use cases where round-down is
right, the conclusion has to be: Currently the PWM API isn't powerful
enough to map the different needs of different consumers. IMHO we need
pwm_round_nearest_state() here.

And the reason I mentioned this was to contradict your position that
there isn't any problem. (You said "I have yet to see a single report
that drivers get this completely wrong." It depends on what you consider
"completely wrong", but I'd say
https://lore.kernel.org/linux-pwm/20190603090058.qd3tbiffmdgqm34d@gofer.mes=
s.org/
was a report about a driver that gets it wrong enough to actually hurt
and in reply to that report the driver was changed possibly breaking
other use cases and ignoring the fact that pwm-bcm2835.c was just one of
roughly 40 lowlevel drivers (so ~80%) that are "broken" in the same
way.)

> > So among the 51 drivers 7 were suitable to be used by the pwm-ir-tx
> > driver and pwm-bcm2835 was "fixed" to become the eighth. IMHO this is
> > ridiculous.
>=20
> Just because a driver rounds down doesn't automatically make it
> unsuitable.

A driver that rounds down yields a suboptimal setting in ~50% of the
cases. So if you are lucky, you get a setting that is good enough
(either because round-down is round-nearest here, or because round-down
while not being the optimum is still good enough).

Additionally given that the pwm-ir-tx driver cannot inspect the
resulting setting, even nearest possible setting might be too different
and the data sent is wrong. With pwm_round_nearest_state() this could be
determined before actually sending wrong data.

> > The right way is to improve the capabilities for consumers to make
> > informed requests.
>=20
> Agreed. But that's a different problem from forcing everyone to round
> down.

It's intermangled. With rounding nearest the maths involved to implement
pwm_round_nearest_state() and pwm_round_down_state() is more complex
compared to round down. (Round up would also work, but this isn't
sensible IMHO.) If you don't know if the driver rounds down or up or
nearest it is hardly possible to implement these functions. Together
with round_nearest being harder to implement than round-down in some
cases (and round-down being never harder than round_nearest) for a
lowlevel driver this convinces me that round-down is the way to go.

> It's also different from adding something like PWM_USAGE_POWER. I
> never said that the API was perfect for every possible use-case. What I
> said was that we should be solving problems that actually exist.

Do you consider yielding a non-optimal setting with a probablility of
~50% an actually existing problem?

> > In my eyes everyone who designs an API deliberately lax is a fool.
>=20
> You might want to bring that up with RMK then, who initially wrote the
> PWM API.

Yes this was defined lax, but I guess not deliberately lax. This isn't
optimal but ok.

> But I already said that this argument goes both ways. If you
> make the API deliberately strict you risk making it completely useless.

I believe my proposal to be well thought out and so the API should
be more useful in the end.

> > (There are some valid reasons to not fix an API's behaviour. "Oh,
> > drivers might round in one or the other direction, they can pick their
> > way themselves" isn't such a reason. Something like: "Either way to fix
> > rounding behaviour results in computationally complexity for some
> > drivers and consumers should never care which behaviour is picked" can
> > be valid.)
>=20
> Also note that this doesn't have anything to do with the API itself.
> There is no ambiguity in the API as to what period or duty cycle is
> specified. There's no rounding or anything like that in the API.

<sarcastic>Oh yes, it's not a problem in the API, only with every single
driver implementing it.</sarcastic>

> How drivers interpret the parameters is necessarily device-specific
> and PWMs just so happen to not need to be 100% accurate, which has the
> nice benefit of allowing a wide range of controllers to work with a wide
> range of use-cases.
>=20
> I mean we've been over this. If you want to make the API very strict you
> will ultimately end up making it useless because only the occasional
> driver will be able to exactly program the parameters that were
> requested.

Note, I don't want to make .apply strict in this sense. I only want to
dictate how to deviate from the requested state.

> And I don't know how many times I have to say this, but for the vast
> majority it simply doesn't matter. Why should we prevent one PWM
> controller from being usable if the use-case couldn't care less if the
> signal ends up being slightly off?

I completely agree, so no need to repeat. But your statement doesn't
apply to my improvements because no controller is prevented from being
useable. If you think that my approach will make a single driver useless
for a certain use case either you didn't understand it or you identified
a problem in it that I missed up to now and you failed to communicate.

> > > We already have several drivers implementing things inconsistently.
> >=20
> > I'm more ambitious here. I think inconstancies should be purged.
>=20
> And how are you planning on doing that, exactly? There are factors in
> this that can't be controller because the hardware was designed in a
> specific way. Not all hardware is equal, so not all controllers will be
> able to generate exactly the same signal as other controllers. There's
> no way to get rid of these inconsistencies, so why bother trying?

There is. I will work on my idea and propose it as a patch.

> > > And again, I don't see how that's a problem.
> >=20
> > So what should consumer driver authors request that wants "50% relative
> > duty cycle with a period between 60 and 250 Hz" if they don't know how
> > the underlying PWM driver behaves? Sure, you can say, a fitting value
> > should be picked that yields a good enough setting for the machine that
> > is currently worked with. But there is an algorithm that allows (given a
> > consistent behaviour of the lowlevel drivers) to automatically pick a
> > suitable setting. And this is what I want target for because I consider
> > this is right behaviour for a good OS.
>=20
> Like I said, in most cases there's no need for the consumer driver
> author to pick that value because it will come from device tree. If the
> period needs to be between 60 and 250 Hz, then the board designer can
> pick any value that can be most accurately be programmed in hardware. If
> there are additional restrictions on the duty cycle then they may take
> that into account as well.
>=20
> > Do you remember the times when you had to specify mode lines for your
> > monitor in your X-server's configuration? Do you think that today's
> > status quo where needing to hand-tune an xorg.conf is a big exception
> > is an improvement? I think yes, and my efforts for PWM are similar.
>=20
> You're comparing apples to oranges.

Of course monitor mode lines are different from pwm_states. The
comparable thing is: Back then you had to specify the input for some
algorithm by hand. For the X-server a way was found to make that hand
picking unnecessary. This is possible for PWM states, too.

> The reason why you no longer have to configure modelines for X to work
> is because drivers can probe the monitor's EDID for the equivalent of
> those modelines.

With your reasoning it was not necessary to implement reading EDID data
and autotuning graphics driver. The system integrator of the monitor
could have just written an X-server configuration with the needed
values.

> For PWM the equivalent of EDID would be DT or PWM lookup tables. So PWM
> isn't the Neanderthal that you make it out to be.

Let's keep discussing the pwm-ir-tx driver. It has to pick a period
depending on the signal to transmit. So do you want to put the period to
pick for all relevant carrier frequencies in the device tree or a lookup
table?

Having pwm_round_{down,nearest}_state() is the more universal approach
here.

> But if you want to stick with the example of monitors: display drivers
> are not always able to exactly generate the required pixel clock for a
> given mode. The end result is that sometimes your vertical refresh rate
> of a monitor is not exactly the 60 Hz that you've asked for but perhaps
> 60.03 Hz or 59.27 Hz. And just like for PWM this doesn't matter in the
> majority of cases. In the cases where it does matter and you need
> perfect synchronization the system designers will have made sure that
> the target refresh rate can be met.

The system designers can provide a hand picked value to the driver in
this case. The better solution however is to teach the driver to pick
the right value alone and so save future system designers from having to
repeat the analysis by hand again and again for each new machine.

> That said, PWM_USAGE_POWER is a solution for a new problem. So far you
> are the one objecting to this improvement and the only reasons for
> objecting have been along the lines of "I don't like it", or "I think
> it's going to cause problems".

If that is what you understood, then you didn't get what I want.

The problem I see is that the concept of PWM_USAGE_POWER (apart from
having a bad name) is not well defined. Consumers don't know what they
can expect when requesting a USAGE_POWER state and lowlevel driver
authors don't know what to provide. It all depends on what you consider
reasonable when you consider applying a patch.

> > > Most of the time, values for
> > > period will be hand-picked to match the requirements of the use-case =
on
> > > a given platform (for backlights or LEDs, for example, you don't want=
 a
> > > period that's too long, because then you'll get flicker). The duty cy=
cle
> > > is then simply used as a way of getting a power output of the desired
> > > percentage. For something like PWM backlight, if interpolation doesn't
> > > work, you have the option of specifying discrete levels with hand-pic=
ked
> > > values.
> > >=20
> > > Backlight and LEDs are the vast majority of applications for PWMs used
> > > in the kernel today. Another category would be regulators and they end
> > > up being pretty much the same in where the values come from.
> > >=20
> > > The one use-case that's perhaps a bit more tricky is the sysfs interf=
ace
> > > because people can throw whatever they want at it. But even that is n=
ot
> > > likely to be problematic in practice because users will either be
> > > satisfied with the result that they get when computationally getting =
the
> > > numbers, or end up hand-picking values for those as well, with the on=
ly
> > > difference being that they are programmed from userspace.
> >=20
> > So the PWM API doesn't provide what it should be there for: Abstracting
> > PWM hardware. Consumers seem to have to know exactly what hardware is
> > used and modify their usage of the API accordingly. (Or even adapt the
> > driver to do what matches their use-case break another one.) :-\
>=20
> You seem to have a strange definition of what "abstraction" means. I
> don't even know what to reply to this.

I thought this is a common definition of abstraction. My idea of a good
abstraction is to be able to tell the consumer "here is a PWM" and they
can make use of it independently of the underlaying hardware in the
bounds of what the actual hardware permits. That is, the consumer should
be able to ask: What is the setting nearest to {.period =3D 1ms,
=2Eduty_cycle =3D 500ns} that is actually implementable and then judge if
this is good enough or not for their use case. (Note this is different
=66rom being able to say: Implement exactly {.period =3D 1ms, .duty_cycle =
=3D
500ns} what I have the impression is your view on my goal.)

What is your definition of abstraction?

> > > For the particular case of PWM_USAGE_POWER, I think it really only sa=
ys
> > > that the power output of the signal should be as requested. It does n=
ot
> > > mean that the driver can pick whatever values it wants. Drivers should
> > > still try to match period and duty cycle as closely as possible becau=
se
> > > there's not enough other information to know if, for example, stretch=
ing
> > > the clock by a factor of 2 is reasonable for the use-case.
> >=20
> > So if this factor of 2 is the best some given driver can provide, the
> > request should be declined, right? Where do you draw the line? Is 1.5
> > the biggest factor that should be allowed? IMHO this is a question we
> > should be ready to answer before driver authors start proposing patches.
>=20
> I said the driver should still try to match period and duty cycle as
> closely as possible, but if stretching by a factor of 2 is the best it
> can do, then that's tough luck, but not a reason to reject the request.

I don't understand how a driver should pick this "closest possible"
setting because I don't consider it obvious what "closest possible"
means for you. For a PWM_USAGE_POWER request of { .period =3D 1045,
=2Eduty_cyle =3D 680 } which of the following candidates is the closest
possible:

  - { .period =3D 104500, .duty_cycle =3D 68000 }

  - { .period =3D 1100, .duty_cycle =3D 700 }

  - { .period =3D 1000, .duty_cycle =3D 700 }

  - { .period =3D 1000, .duty_cycle =3D 600 }

  - { .period =3D 2000, .duty_cycle =3D 1300 }

? Or which of these would be acceptable? Or asked differently: If you
added support for PWM_USAGE_POWER to a driver for hardware where
=2Eduty_cycle and .period must be integer factors of 100 ns, which state
would you configure in reply to the above request and why do you
consider it the best choice? Does it depend on the usecase you have in
mind while implementing, or is there an objective metric?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ukl755hyffbqs5m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB8NI8ACgkQwfwUeK3K
7AndMgf/ZqfelRvw5emeqsK9TqqQFjdLsrWYNUSwmk1psz5fI9DfuIM6pU9GLQ0X
XltjMtkltw5NeZFeSckBMOueiKxtwenTuMrANfBNupjYaQEY4KGyHlk5WbkTTPIH
J5Q16Ig6flX+Qdd0MktNbNweqsfFKRxHz2U6j43JYMwcoAAD3Pz6RViVLhBWNsHa
Ocfy1OGR6R30EoBzb6DGfQm4J2kGcWIFl7ndLs2jEnMMPGwX2Qh3nMrug2NlH8v7
CO/aCF+z6adgJzNERls38/VhIXtunu7jv+ocbrYZkhTpFcxCEHoDf2B0SN0dVNBn
iGdkPM/ilhJba5ZM56KU5Cokolnefw==
=mitG
-----END PGP SIGNATURE-----

--ukl755hyffbqs5m7--
