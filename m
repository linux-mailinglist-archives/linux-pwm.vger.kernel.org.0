Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702E2CFDA1
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLESkk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 13:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgLESkh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 13:40:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ED0C061A4F
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 10:39:56 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klcTK-00077e-Ey; Sat, 05 Dec 2020 19:39:54 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klcTJ-0002Zb-CX; Sat, 05 Dec 2020 19:39:53 +0100
Date:   Sat, 5 Dec 2020 19:39:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johannes Pointner <h4nn35.work@gmail.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: pwm: imx27: pwm-backlight strange behavior
Message-ID: <20201205183953.uzcc4u43jzb7mzy4@pengutronix.de>
References: <CAHvQdo1CEQfD4gUG7gVFMqaohXAq-dZiz84VY1ZrVN6DdnRBkQ@mail.gmail.com>
 <20201204114824.u7mxu6alcsjqry5y@pengutronix.de>
 <CAHvQdo0eFy9fS7nfc48Ray9J8Sf-T4dsYToL_9xXHsMCGTS_4g@mail.gmail.com>
 <20201205174255.fx5osroywrcggbeo@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qr5fkrkhtaw4meal"
Content-Disposition: inline
In-Reply-To: <20201205174255.fx5osroywrcggbeo@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qr5fkrkhtaw4meal
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 05, 2020 at 06:42:55PM +0100, Uwe Kleine-K=F6nig wrote:
> On Sat, Dec 05, 2020 at 12:18:25PM +0100, Johannes Pointner wrote:
> > Hello Uwe,
> >=20
> > On Fri, Dec 4, 2020 at 12:48 PM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello Johannes,
> > >
> > > On Thu, Dec 03, 2020 at 01:00:56PM +0100, Johannes Pointner wrote:
> > > > I just tested 5.10-rc6 with a imx6dl-board and found an issue
> > > > regarding the pwm-backlight.
> > > > Using 5.10 at about level 67 I got a new maximum and with level 68
> > > > it's restarting at about level 1.
> > > > This was working properly for me with kernel 5.4.
> > >
> > > Reverting only the last hunk helps already I assume? I starred at the
> > > patch for some time now and don't see a relevant change.
> > Yes, that's right. If I just revert the calculation in the function
> > pwm_imx27_apply it works again.
> > >
> > > Can you please enable PWM_DEBUG and TRACING in the kernel configurati=
on
> > > and then do:
> > >
> > >         echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> > >
> > > reproduce a wrong setting (the less you do other than that the easier=
 it
> > > will be to analyse the trace) and then send me the contents of
> > >
> > >         /sys/kernel/debug/tracing/trace
> > >
> > I attached the trace log. I also added a trace where I
> > reverted(trace_revert.log) the commit.
> > I did for both logs the following sequence of commands:
> > root# echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> > root# echo 0 > /sys/class/backlight/backlight/brightness
> > root# echo 1 > /sys/class/backlight/backlight/brightness
> > root# echo 50 > /sys/class/backlight/backlight/brightness
> > root# echo 67 > /sys/class/backlight/backlight/brightness
> > root# echo 68 > /sys/class/backlight/backlight/brightness
> >=20
> > > ? Also please lookup the frequency of the per clk (grep for "pwm" in
> > > /sys/kernel/debug/clk/clk_summary).
> > root# grep pwm  /sys/kernel/debug/clk/clk_summary
> >                               pwm4       1        1        0
> > 66000000          0     0  50000
>=20
> Ah, I understood. The problem is:
>=20
> 	do_div(c, NSEC_PER_SEC * prescale);
>=20
> with (in your case) prescale =3D 6. This make the second argument
> 1000000000 * 6 =3D 6000000000 which doesn't fit into an u32 and so is
> discarded to something considerably smaller.
>=20
> A quick and dirty fix would be:
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index c50d453552bd..e7449edb6dc1 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -235,7 +235,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
> =20
>  	period_cycles /=3D prescale;
>  	c =3D clkrate * state->duty_cycle;
> -	do_div(c, NSEC_PER_SEC * prescale);
> +	do_div(c, NSEC_PER_SEC);
> +	do_div(c, prescale);
>  	duty_cycles =3D c;
> =20
>  	/*
>=20
>=20
> but that's ugly. I'll think about how to properly fix this.

Argh, that looses more precision than I thought at first. Another
(probably more sensible) workaround is to reduce the period length to at
most 606060 ns such that prescale doesn't get bigger than 4. (Assuming
your display works with this, too. I would expect it does, but you want
to check the datasheet first.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qr5fkrkhtaw4meal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/L0/YACgkQwfwUeK3K
7Amm2gf/cWWt2BrblwTCJOTMKZPFU8BaK5HhbcUhgQ1MGZ5do257JLCd9sbimgKP
Qh+L2xjr1mj8aLy9U1B/Xdhl3q/Kul3LY+F2lv0g6mqio2oJiTcoevG6CyS9oPH3
yZJwZ3RfZ2BTNMM0uy8vzs+cswJjJmdOGwBz1Zc5ngZYE8TI/N1yqj5R5zDyZyU6
U9PUH6XgHh8li53uKSgZjA8mCjk017IM91c3y3yAtLzhbpcfD7HM/flfQESWVSPX
VSm0o0gaxzOx/Kp7/OvrNr8ANba8ogJNjwvaOa5AjtSeQ3P4vLB5mpxjvXPbkWTi
F5mGHNlzFwwZ+T7CBQ3QT6nTdjc3Ig==
=a6hS
-----END PGP SIGNATURE-----

--qr5fkrkhtaw4meal--
