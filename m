Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984882CFD1A
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 19:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgLESTc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 13:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgLERq4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 12:46:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006EC061A56
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 09:43:01 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klbaC-0002Fr-Dr; Sat, 05 Dec 2020 18:42:56 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klbaB-0007oE-JT; Sat, 05 Dec 2020 18:42:55 +0100
Date:   Sat, 5 Dec 2020 18:42:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johannes Pointner <h4nn35.work@gmail.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: pwm: imx27: pwm-backlight strange behavior
Message-ID: <20201205174255.fx5osroywrcggbeo@pengutronix.de>
References: <CAHvQdo1CEQfD4gUG7gVFMqaohXAq-dZiz84VY1ZrVN6DdnRBkQ@mail.gmail.com>
 <20201204114824.u7mxu6alcsjqry5y@pengutronix.de>
 <CAHvQdo0eFy9fS7nfc48Ray9J8Sf-T4dsYToL_9xXHsMCGTS_4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vo3fik2zwrymxksr"
Content-Disposition: inline
In-Reply-To: <CAHvQdo0eFy9fS7nfc48Ray9J8Sf-T4dsYToL_9xXHsMCGTS_4g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vo3fik2zwrymxksr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 05, 2020 at 12:18:25PM +0100, Johannes Pointner wrote:
> Hello Uwe,
>=20
> On Fri, Dec 4, 2020 at 12:48 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Johannes,
> >
> > On Thu, Dec 03, 2020 at 01:00:56PM +0100, Johannes Pointner wrote:
> > > I just tested 5.10-rc6 with a imx6dl-board and found an issue
> > > regarding the pwm-backlight.
> > > Using 5.10 at about level 67 I got a new maximum and with level 68
> > > it's restarting at about level 1.
> > > This was working properly for me with kernel 5.4.
> >
> > Reverting only the last hunk helps already I assume? I starred at the
> > patch for some time now and don't see a relevant change.
> Yes, that's right. If I just revert the calculation in the function
> pwm_imx27_apply it works again.
> >
> > Can you please enable PWM_DEBUG and TRACING in the kernel configuration
> > and then do:
> >
> >         echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> >
> > reproduce a wrong setting (the less you do other than that the easier it
> > will be to analyse the trace) and then send me the contents of
> >
> >         /sys/kernel/debug/tracing/trace
> >
> I attached the trace log. I also added a trace where I
> reverted(trace_revert.log) the commit.
> I did for both logs the following sequence of commands:
> root# echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> root# echo 0 > /sys/class/backlight/backlight/brightness
> root# echo 1 > /sys/class/backlight/backlight/brightness
> root# echo 50 > /sys/class/backlight/backlight/brightness
> root# echo 67 > /sys/class/backlight/backlight/brightness
> root# echo 68 > /sys/class/backlight/backlight/brightness
>=20
> > ? Also please lookup the frequency of the per clk (grep for "pwm" in
> > /sys/kernel/debug/clk/clk_summary).
> root# grep pwm  /sys/kernel/debug/clk/clk_summary
>                               pwm4       1        1        0
> 66000000          0     0  50000

Ah, I understood. The problem is:

	do_div(c, NSEC_PER_SEC * prescale);

with (in your case) prescale =3D 6. This make the second argument
1000000000 * 6 =3D 6000000000 which doesn't fit into an u32 and so is
discarded to something considerably smaller.

A quick and dirty fix would be:

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index c50d453552bd..e7449edb6dc1 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -235,7 +235,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
=20
 	period_cycles /=3D prescale;
 	c =3D clkrate * state->duty_cycle;
-	do_div(c, NSEC_PER_SEC * prescale);
+	do_div(c, NSEC_PER_SEC);
+	do_div(c, prescale);
 	duty_cycles =3D c;
=20
 	/*


but that's ugly. I'll think about how to properly fix this.

Thanks for your report
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vo3fik2zwrymxksr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/LxpwACgkQwfwUeK3K
7Amw8Qf/TnzKgf/JcIfiibh/bb4jridlMWelIMgRmKjFfnnvn5fTNrMrcPJmUSaV
8+8/xvZtDRe6/wBCJMmVOk0f6/quaY/u3haDr428OgEZMKeJrs/FS6v19viuxAUg
wrsV35z/RSb+Vrm3aGo+nN6MqDf8/NTHiuzDGwnXayJgCsUo7S70FiniJN4UCXQP
VIyTjKGKYAiwKmb3248mur95wZjpjAb9LBYP0tIcbXK7rFUmaDpFkhyZiFbcvaO0
Qbsu38uRIVn6DkT7n4JipSA0H83nkd0CIdXhsPZ+k0MAr41ssqGwMsg2zjmHMRyo
3iCFJbb0hK8VqDl/6JlpTaxLcezv1Q==
=GzvK
-----END PGP SIGNATURE-----

--vo3fik2zwrymxksr--
