Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21B83B86F9
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhF3QYB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 12:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3QYB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 12:24:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C4C061756
        for <linux-pwm@vger.kernel.org>; Wed, 30 Jun 2021 09:21:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lycxt-0001KS-5s; Wed, 30 Jun 2021 18:21:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lycxs-000721-6A; Wed, 30 Jun 2021 18:21:28 +0200
Date:   Wed, 30 Jun 2021 18:21:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays
 consistent
Message-ID: <20210630162128.ufmul6euxkwnou25@pengutronix.de>
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
 <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
 <alpine.DEB.2.22.394.2106292138100.1194476@ramsan.of.borg>
 <20210630064826.4u2p37tlbriiwtsn@pengutronix.de>
 <CAMuHMdV0w8mxxLVT4abrD-FgqS9Kg4BLomDQbXS_csdMyqhypQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vq2jtkefpxcy6sh4"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV0w8mxxLVT4abrD-FgqS9Kg4BLomDQbXS_csdMyqhypQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vq2jtkefpxcy6sh4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 30, 2021 at 12:22:22PM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Wed, Jun 30, 2021 at 8:48 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Jun 29, 2021 at 09:44:38PM +0200, Geert Uytterhoeven wrote:
> > > On Sat, 1 May 2021, Uwe Kleine-K=F6nig wrote:
> > > > Without this change it can happen that if changing the polarity suc=
ceeded
> > > > but changing duty_cycle and period failed pwm->state contains a mix=
ture
> > > > between the old and the requested state.
> > > >
> > > > So remember the initial state before starting to modify the configu=
ration
> > > > and restore it when one of the required callback fails.
> > > >
> > > > Compared to the previous implementation .disable() (if necessary) i=
s called
> > > > earlier to prevent a glitch.
> > > >
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > >
> > > Thanks for your patch, which is now commit d7bff84fe7ed8c3b ("pwm:
> > > Ensure for legacy drivers that pwm->state stays consistent") in
> > > pwm/for-next.
> > >
> > > This commit broke the backlight on the Atmark Techno Armadillo 800 EVA
> > > board (arch/arm/boot/dts/r8a7740-armadillo800eva.dts), which now show=
s a
> > > black screen.  Reverting the commit fixes the problem.
> > >
> > > Do you have an idea what is wrong, and how to fix it?
> >
> > I starred at the patch for some time now and couldn't find a problem.
> > Looking at drivers/pwm/pwm-renesas-tpu.c I don't see something obvious.
> > (The .set_polarity callback is faulty as I doesn't commit the request to
> > hardware, but that shouldn't matter here.)
> >
> > I guess the first request the backlight driver emits is
> >
> >         .period =3D 33333,
> >         .duty_cycle =3D 33333,
> >         .enabled =3D true,
> >         .polarity =3D PWM_POLARITY_INVERSED,
> >
> > which should result into the following driver calls (with and without
> > the breaking commit):
> >
> >         tpu_pwm_set_polarity(chip, pwm, PWM_POLARITY_INVERSED);
> >         tpu_pwm_config(chip, pwm, 33333, 33333);
> >         tpu_pwm_enable(chip, pwm);
> >
> > Can you confirm that?
>=20
> tpu_pwm_config() is no longer called:
>=20
>      renesas-tpu-pwm e6600000.pwm: tpu_pwm_set_polarity:334: channel
> 2, polarity =3D 1
>     -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel =3D 2,
> duty_ns =3D 0, period_ns =3D 33333
>     -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel =3D 2,
> duty_ns =3D 33333, period_ns =3D 33333
>      renesas-tpu-pwm e6600000.pwm: tpu_pwm_enable:346: channel 2

OK, I see a problem (though this doesn't explain the display staying
off directly after boot):

After doing:

	pwm_apply_state(pwm, { .period =3D 33333, .duty_cycle =3D 0, .enabled =3D =
false, .polarity =3D ..});

=2Eperiod and .duty_cycle are assumed to be set even though calling
->config was skipped because .enabled is false.

So when

	pwm_apply_state(pwm, { .period =3D 33333, .duty_cycle =3D 0, .enabled =3D =
true, .polarity =3D ..});

is called next, ->config isn't called because the core assumes
=2Eduty_cycle and .period are already setup fine.

So we either must not skip calling ->config when .enabled is false:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ab38627bcacd..f8a5a095a410 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -558,12 +558,8 @@ static int pwm_apply_legacy(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 		pwm->state.polarity =3D state->polarity;
 	}
=20
-	if (!state->enabled) {
-		if (pwm->state.enabled)
-			chip->ops->disable(chip, pwm);
-
-		return 0;
-	}
+	if (!state->enabled && pwm->state.enabled)
+		chip->ops->disable(chip, pwm);
=20
 	if (state->period !=3D pwm->state.period ||
 	    state->duty_cycle !=3D pwm->state.duty_cycle) {
@@ -577,7 +573,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 		pwm->state.duty_cycle =3D state->duty_cycle;
 	}
=20
-	if (!pwm->state.enabled) {
+	if (state->enabled && !pwm->state.enabled) {
 		err =3D chip->ops->enable(chip, pwm);
 		if (err)
 			goto rollback;

or we have to call ->config unconditionally:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ab38627bcacd..05d7afe25b42 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -565,17 +565,21 @@ static int pwm_apply_legacy(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
 		return 0;
 	}
=20
+	/*
+	 * We cannot skip this even if state->period =3D=3D pwm->state.period &&
+	 * state->duty_cycle =3D=3D pwm->state.duty_cycle because we might have
+	 * exited early in the last call to pwm_apply_state because of
+	 * !state->enabled and so the two values in pwm->state might not be
+	 * configured in hardware.
+	 */
+	err =3D chip->ops->config(pwm->chip, pwm,
+				state->duty_cycle,
+				state->period);
+	if (err)
+		goto rollback;
+=20
+	pwm->state.period =3D state->period;
+	pwm->state.duty_cycle =3D state->duty_cycle;
-	if (state->period !=3D pwm->state.period ||
-	    state->duty_cycle !=3D pwm->state.duty_cycle) {
-		err =3D chip->ops->config(pwm->chip, pwm,
-					state->duty_cycle,
-					state->period);
-		if (err)
-			goto rollback;
-
-		pwm->state.period =3D state->period;
-		pwm->state.duty_cycle =3D state->duty_cycle;
-	}
=20
 	if (!pwm->state.enabled) {
 		err =3D chip->ops->enable(chip, pwm);

I slightly prefer the latter patch, but if this is indeed your problem
both should fix it for you.

Can you give that a try please?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vq2jtkefpxcy6sh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDcmgUACgkQwfwUeK3K
7AlVTwf/bWcZuucIYy2/WBe4kPAqq5rnlgPzJ1TqTEYQweJn9Xs5dQ8RULHpiw+v
LK4iH0e0iNF0rvbUZyzY3ekQdy3qCzIEjsrouzB+r/ArwGqOWykeZmpVjkiIHSj6
ZO0LglfEjrM0fiyAdEHwbR9QfdJeGdhkLiZBTFLkW5yU03ojhWTdLAmDqoMGaY8n
AqKxNIy4c0nTboxF+rYJQFAZ5L5+7rx34BX+ndbG2Lvec0gbwf6hxPA4NIAcxfdV
Cwc5c2Ws1Qzb7azxJbCxAY3dEv4Hf6VatmfvaQo1AlcdJvIBbsWTup5+7nRPH6TC
0eepJS64AQI835lr5NSLGEBpTii5xQ==
=yLfw
-----END PGP SIGNATURE-----

--vq2jtkefpxcy6sh4--
