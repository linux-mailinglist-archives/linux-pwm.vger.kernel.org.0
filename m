Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6D361D6C
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbhDPJcp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDPJcp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Apr 2021 05:32:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976FEC061574
        for <linux-pwm@vger.kernel.org>; Fri, 16 Apr 2021 02:32:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXKpj-0003F5-Vg; Fri, 16 Apr 2021 11:32:15 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXKpi-0003Ey-FE; Fri, 16 Apr 2021 11:32:14 +0200
Date:   Fri, 16 Apr 2021 11:32:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <20210416093212.rf5iwb7o4j2tjsc3@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
 <YHWFs1f0XHkqbddp@orome.fritz.box>
 <20210413175631.pwbynvwmnn7oog4m@pengutronix.de>
 <YHhpVusyiBLWIM0V@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mx2mgq5rqk7ys7bd"
Content-Disposition: inline
In-Reply-To: <YHhpVusyiBLWIM0V@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mx2mgq5rqk7ys7bd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Apr 15, 2021 at 06:27:02PM +0200, Thierry Reding wrote:
> On Tue, Apr 13, 2021 at 07:56:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 13, 2021 at 01:51:15PM +0200, Thierry Reding wrote:
> > > On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> > > > >  include/dt-bindings/pwm/pwm.h                 | 1 +
> > > > >  2 files changed, 4 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Docu=
mentation/devicetree/bindings/pwm/pwm.txt
> > > > > index 084886bd721e..fe3a28f887c0 100644
> > > > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > @@ -46,6 +46,9 @@ period in nanoseconds.
> > > > >  Optionally, the pwm-specifier can encode a number of flags (defi=
ned in
> > > > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > > > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > > > +- PWM_USAGE_POWER: Only care about the power output of the signa=
l. This
> > > > > +  allows drivers (if supported) to optimize the signals, for exa=
mple to
> > > > > +  improve EMI and reduce current spikes.
> > > >=20
> > > > IMHO there are too many open questions about which freedom this giv=
es to
> > > > the lowlevel driver. If the consumer requests .duty_cycle =3D 25ns +
> > > > .period =3D 100ns, can the driver provide .duty_cycle =3D 25s + .pe=
riod =3D
> > > > 100s which nominally has the same power output? Let's not introduce=
 more
> > > > ambiguity than there already is.
> > >=20
> > > The freedom given to the driver should be to adjust the signal within
> > > reasonable bounds. Changing the time unit by a factor of 1000000000 is
> > > not within reason, and I doubt anyone would interpret it that way, ev=
en
> > > if we didn't document this at all.
> >=20
> > Please define a rule that allows to judge if any given implementation is
> > correct or not. For the record neither "within reasonable bounds" nor "a
> > factor of 1000000000 is not within reason" is good enough.
>=20
> We haven't had any rules thus far and I have yet to see a single report
> that drivers get this completely wrong. So "within reason", which I
> think is what driver authors will do by default, is good enough in
> practice.

For me commit 11fc4edc483b ("pwm: bcm2835: Improve precision of PWM")
indicates that there is a problem. Someone used the pwm-ir-tx driver on
top of pwm-bcm2835. The former driver's expectation is that

	period =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
	duty =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * period, 100);
	pwm_config(pwm, duty, period);

yields a frequency near pwm_ir->carrier (minimizing

	abs(1 / implemented_freq - 1 / pwm_ir->carrier)

(or should it minimize abs(implemented_freq - pwm_ir->carrier) instead?
Not entirely sure.). The result was that the pwm-bcm2835 driver was
changed to implement a different rounding. I took the time to look at
the drivers in 11fc4edc483b^, with the following result:

 - pwm-ab8500.c: ignores period_ns in .config
 - pwm-atmel.c: rounds down period
 - pwm-atmel-hlcdc.c: rounds up period (unsure)
 - pwm-atmel-tcb.c: rounds down period (unsure)
 - pwm-bcm2835.c: rounds down period
 - pwm-bcm-iproc.c: rounds down period
 - pwm-bcm-kona.c: rounds down period
 - pwm-berlin.c: rounds down period
 - pwm-brcmstb.c: rounds down period
 - pwm-clps711x.c: doesn't support changing period (IMHO in a buggy way
   because the period in the dts is just overwritten)
 - pwm-crc: rounds down period
 - pwm-cros-ec.c: doesn't support changing period
 - pwm-ep93xx.c: rounds down period
 - pwm-fsl-ftm.c: rounds down period
 - pwm-hibvt.c: rounds down period
 o pwm-img.c: confusing rounding behaviour
 - pwm-imx1.c: just implements relative duty cycle
 - pwm-imx27.c: rounds down period
 + pwm-imx-tpm.c: rounds to nearest period (unsure)
 - pwm-jz4740.c: rounds down period
 - pwm-lp3943.c: rounds down period (apart from corner cases)
 - pwm-lpc18xx-sct.c: rounds down period
 - pwm-lpc32xx.c: rounds down period
 - pwm-lpss.c: rounds up period
 + pwm-mediatek.c: tries to implement round-nearest
 - pwm-meson.c: tries to round down period
 o pwm-mtk-disp.c: confusing rounding behaviour
 - pwm-mxs.c: rounds down period
 + pwm-omap-dmtimer.c: rounds to closest period
 + pwm-pca9685.c: rounds to closest period
 - pwm-puv3.c: rounds down period
 - pwm-pxa.c: rounds down period
 - pwm-rcar.c: rounds down period
 o pwm-renesas-tpu.c: confusing rounding behaviour
 + pwm-rockchip.c: rounds closest period
 - pwm-samsung.c: rounds down period (unsure)
 - pwm-sifive.c: rounds down period
 - pwm-spear.c: rounds down period
 - pwm-sti.c: rounds down period
 - pwm-stm32.c: rounds down period
 - pwm-stm32-lp.c: rounds down period
 - pwm-stmpe.c: just implements relative duty cycle
 + pwm-sun4i.c: rounds closest period
 + pwm-tegra.c: tries to round nearest period
 - pwm-tiecap.c: rounds down period
 - pwm-tiehrpwm.c: rounds down period
 - pwm-twl.c: just implements relative duty cycle
 - pwm-twl-led.c: just implements relative duty cycle
 - pwm-vt8500.c: rounds down period
 - pwm-zx.c: rounds down period

(- =3D doesn't behave "reasonable" to be used by pwm-ir-tx, + =3D behaves
"reasonable" for pwm-ir-tx, o =3D don't know, too complicated for me to
understand quickly (should we count that as -?))

So among the 51 drivers 7 were suitable to be used by the pwm-ir-tx
driver and pwm-bcm2835 was "fixed" to become the eighth. IMHO this is
ridiculous.

The right way is to improve the capabilities for consumers to make
informed requests.

> > This is not only important to be able to review drivers that implement
> > it, but also for consumers, because they should know what to expect.
>=20
> Again, consumers should expect that the PWM driver will do something
> that is within reasonable margins. If that ever ends up being wrong for
> a given use-case we may need to change that.

Would you say that having 40 of 50 drivers being unsuitable to be used
by pwm-ir-tx is a problem? If soon someone appears who reports that
using pwm-ir-tx with pwm-mxs.c is broken, should we adapt how pwm-mxs.c
rounds? If someone else appears who reports that pwm-sun4i.c doesn't
work with the motor control driver (that assumes round-down because
that's safer and is correct for most drivers), should we change
pwm-sun4i.c to break the pwm-sun4i.c/pwm-ir-tx combination?

IMHO this isn't a sane long-term plan. And in my eyes this is a good
enough reason to work on improving the framework.

> But I don't think it's necessary to take out all flexibility if we don't
> have to. As long as things work fine there's no reason to make the rules
> any more strict.
>=20
> > > To be frank I think that quest of yours to try and rid the PWM API of
> > > all ambiguity is futile.
> >=20
> > I consider my quest about rounding reasonable. And I think this is
> > painful because when the PWM framework was introduced it was too much ad
> > hoc and the APIs were not thought through enough. And because I don't
> > want to have that repeated, I express my concerns here.
>=20
> Maybe try to look at this from another perspective. Maybe what you call
> adhoc API was actually deliberately designed this way.

In my eyes everyone who designs an API deliberately lax is a fool.
(There are some valid reasons to not fix an API's behaviour. "Oh,
drivers might round in one or the other direction, they can pick their
way themselves" isn't such a reason. Something like: "Either way to fix
rounding behaviour results in computationally complexity for some
drivers and consumers should never care which behaviour is picked" can
be valid.)

> To be honest I don't know what the intentions were when the original
> PWM API was created, that was way before I took on maintenance of the
> PWM subsystem.  The PWM framework adopted the existing API and there
> was no reason to change it because it worked just fine.
>=20
> And I still don't see a reason for the API to change. Like I said, if we
> ever run into a case where the current flexibility gets in the way and
> yields unpredictable or unusable results, then that's something we have
> to improve. But I don't think we should make any such changes if they're
> not necessary, because then we may end up making matters worse.
>=20
> Also, I think this actually corroborates the need for something like the
> usage flags in the PWM specifier. Currently drivers will do their best
> to generate a PWM signal that's as close as possible to the requested
> parameters.

No, see above, most driver round down, not closest. (One problem is also
that "as close as possible" isn't well defined.)

> If that's not enough for a specific use-case, then that's
> something that the new use-case has to describe somehow. They could do
> that using a usage flag (perhaps something like PWM_USAGE_STRICT, which
> may tell the driver to return an error if the requested parameters
> cannot be applied exactly).

I think this will result in too much problems in practise.

> Another possibility is to give consumers a way of running a given
> state through the driver but not applying just yet so that they can
> inspect what the driver would have programmed and then make
> adjustments (that's along the lines of what you had in mind with the
> "round state" concept, I suppose).

Yes. And this function can only be efficiently worked with if the
rounding behaviour is known.

> > > I've been trying to be lenient because you seem
> > > motivated, but I think you're taking this too far. There are always
> > > going to be cases that aren't completely clear-cut and where drivers
> > > need the flexibility to cheat in order to be useful at all. If we get=
 to
> > > a point where everything needs to be 100% accurate, the majority of t=
he
> > > PWM controllers won't be usable at all.
> > >=20
> > > Don't let perfect be the enemy of good.
> >=20
> > I admit here I don't have a constructive idea how to define what is
> > needed.
> >=20
> > For example if we only care about the relative duty cycle, a consumer
> > requests
> >=20
> > 	.period =3D 1045
> > 	.duty_cyle =3D 680
> >=20
> > and the driver can provide multiples of 100 ns for both .period and
> > .duty_cycle, the candidates that might be sensible to chose from are
> > (IMHO):
> >=20
> >  - exact relative duty:
> >=20
> > 	.period =3D 104500
> > 	.duty_cycle =3D 68000
> >=20
> >  - round both values in the same direction, minimizing error
> >=20
> >  	.period =3D 1100
> > 	.duty_cycle =3D 700
> >=20
> >    (requested relative duty =3D 65.07%, implemented =3D 63.64%; when
> >    rounding both down we get 60%)
> >=20
> >  - round both values mathematically:=20
> >=20
> >  	.period =3D 1000
> > 	.duty_cycle =3D 700
> >=20
> >    (yielding a relative duty of 70% instead of the requested 65.07%)
> >=20
> >  - Maybe
> >=20
> >  	.period =3D 1000
> > 	.duty_cycle =3D 600
> >=20
> >    might also be preferable for some consumers?! (60%)
> >=20
> >  - Maybe
> >=20
> >  	.period =3D 2000
> > 	.duty_cycle =3D 1300
> >=20
> >    is a good compromise because the relative duty is nearly exactly
> >    matched and the period is only stretched by a factor < 2.
> >=20
> > In my eyes a driver author should be told which of these options should
> > be picked. Do you consider it obvious which of these options is the
> > objective best? If so why? Do you agree that we should tell driver
> > authors how to implement this before we have several drivers that all
> > implement their own ideas and getting this in a consistent state is
> > another pain?
>=20
> We already have several drivers implementing things inconsistently.

I'm more ambitious here. I think inconstancies should be purged.

> And again, I don't see how that's a problem.

So what should consumer driver authors request that wants "50% relative
duty cycle with a period between 60 and 250 Hz" if they don't know how
the underlying PWM driver behaves? Sure, you can say, a fitting value
should be picked that yields a good enough setting for the machine that
is currently worked with. But there is an algorithm that allows (given a
consistent behaviour of the lowlevel drivers) to automatically pick a
suitable setting. And this is what I want target for because I consider
this is right behaviour for a good OS.

Do you remember the times when you had to specify mode lines for your
monitor in your X-server's configuration? Do you think that today's
status quo where needing to hand-tune an xorg.conf is a big exception
is an improvement? I think yes, and my efforts for PWM are similar.

If you're happy with the PWM framework that it only solves the problems
it already solved 10 years ago there is no need to work on it. If
however you want to improve the solutions saying "oh, there are
inconsistencies, but I don't see how that's problem" isn't good enough.

> Most of the time, values for
> period will be hand-picked to match the requirements of the use-case on
> a given platform (for backlights or LEDs, for example, you don't want a
> period that's too long, because then you'll get flicker). The duty cycle
> is then simply used as a way of getting a power output of the desired
> percentage. For something like PWM backlight, if interpolation doesn't
> work, you have the option of specifying discrete levels with hand-picked
> values.
>=20
> Backlight and LEDs are the vast majority of applications for PWMs used
> in the kernel today. Another category would be regulators and they end
> up being pretty much the same in where the values come from.
>=20
> The one use-case that's perhaps a bit more tricky is the sysfs interface
> because people can throw whatever they want at it. But even that is not
> likely to be problematic in practice because users will either be
> satisfied with the result that they get when computationally getting the
> numbers, or end up hand-picking values for those as well, with the only
> difference being that they are programmed from userspace.

So the PWM API doesn't provide what it should be there for: Abstracting
PWM hardware. Consumers seem to have to know exactly what hardware is
used and modify their usage of the API accordingly. (Or even adapt the
driver to do what matches their use-case break another one.) :-\

> For the particular case of PWM_USAGE_POWER, I think it really only says
> that the power output of the signal should be as requested. It does not
> mean that the driver can pick whatever values it wants. Drivers should
> still try to match period and duty cycle as closely as possible because
> there's not enough other information to know if, for example, stretching
> the clock by a factor of 2 is reasonable for the use-case.

So if this factor of 2 is the best some given driver can provide, the
request should be declined, right? Where do you draw the line? Is 1.5
the biggest factor that should be allowed? IMHO this is a question we
should be ready to answer before driver authors start proposing patches.

> > (My bet is you are lax and don't consider consistency among drivers soo
> > important. In this case we don't agree. I think it's important for
> > consumer driver authors to be able to rely on some expectations
> > independently which lowlevel driver is in use.)
>=20
> Well, yeah. Consumers should be able to rely on the expectation that the
> provider will try to best match the given parameters. Something like
> PWM_USAGE_POWER can be used to give the driver a bit more freedom, but
> it doesn't mean it should switch into crazy mode.

I didn't suggest doing something deliberately crazy. I only want a to
know how to judge a patch that adds support for this concept. Because
then we will have to decide if you take this patch or not.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mx2mgq5rqk7ys7bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB5WZkACgkQwfwUeK3K
7Ak+iQf/egYGQ/ADMtgb5ZB0PjT3P5/C+nCoVhUyLblDMAImBY1UtzQVYG27x/Bu
zEBB2064koMY93S8VzW3r2A1AhpIF05/SYPC2AK9YB8jX0dDZa4p7C00OhcrgJJI
p1jWiVARTslYG4FmpPEC74PClyxeub1DmLINWe3QlUZemFPGz/e3nqc/nMYQg4JV
L7b7PJz5MGF4HVqocy2vWM6kpLNhAA85rS/mOaqHpBjUlFTd1xcr5epJyOHoDp/h
myu/VLFztK2r0P48c90N//Z0gzuBrWQf5cT6sFU4w/8HQR/FCkCgeJt5ntKocA7x
ZaYmYzes/WhI71yQoj7c+2k2j5cQow==
=us6s
-----END PGP SIGNATURE-----

--mx2mgq5rqk7ys7bd--
