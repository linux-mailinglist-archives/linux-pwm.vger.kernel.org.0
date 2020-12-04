Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE32CF544
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 21:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLDUHD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 15:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLDUHD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 15:07:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167ACC061A51
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 12:06:23 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klHLQ-0003m7-Hh; Fri, 04 Dec 2020 21:06:20 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klHLO-00025h-FW; Fri, 04 Dec 2020 21:06:18 +0100
Date:   Fri, 4 Dec 2020 21:06:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND for 5.10] pwm: sl28cpld: fix getting driver data
 in pwm callbacks
Message-ID: <20201204200618.4t4briks4iv4vcgz@pengutronix.de>
References: <20201203084142.3810204-1-u.kleine-koenig@pengutronix.de>
 <X8oubGP9CvoOQKtF@ulmo>
 <20201204135102.foq5gvvzfcwbwphh@pengutronix.de>
 <X8pfAmiXa8MqF9Gl@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wvt4xbgxixtahvyv"
Content-Disposition: inline
In-Reply-To: <X8pfAmiXa8MqF9Gl@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wvt4xbgxixtahvyv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Dec 04, 2020 at 05:08:34PM +0100, Thierry Reding wrote:
> On Fri, Dec 04, 2020 at 02:51:02PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 04, 2020 at 01:41:16PM +0100, Thierry Reding wrote:
> > > I thought I had seen you discuss this with Lee and gotten the impress=
ion
> > > that you were going to respin this to move the platform_set_drvdata()=
 to
> > > an earlier point, which I think is the more correct approach.
> >=20
> > Lee asked on irc why I didn't move the platform_set_drvdata to an
> > earlier stage and I told him why. Then the conversation was over.
>=20
> Okay, looking at the logs that you posted, the discussion didn't quite
> end the way I remembered it. Still, I would've expected a bit more
> discussion and a chance to reach consensus before you went off on your
> own and submitted this patch "out-of-band".

I interpreted Lee's silence as "hmm, ok, we don't agree". And giving
more weight to the opinion of the one who invested the time to create a
patch and communicate with the reporter (i.e. me) I considered it ok to
keep my opinion. And you didn't comment for over a week to the patch,
Michael's and my ping via mail and me addressing you via irc. Together
with this patch being urgent in my eyes (and this being the only urgent
patch on my radar) I thought it ok to send it directly to Linus two days
after I tried to contact you without success.

Other than that: Given that you (and Lee?) seem to feel strong about
dev_get_drvdata being better than container_of, indeed a bit more
discussion would have been appropriate. But I see the problem on your
side because Lee stopped discussing after reading my arguments and you
didn't even start.

And for the record: I also feel strong that container_of is better than
dev_get_drvdata for the following reasons:

 - container_of is computationally cheaper than dev_get_drvdata;
 - container_of provides (a bit) type safety, compared to dev_get_drvdata
   providing none;
 - container_of is more universal, as you cannot easily use
   dev_get_drvdata e.g. in the PWM driver provided by
   drivers/gpio/gpio-mvebu.c.
 - Maybe subjectively I think that conceptually container_of is nicer.
   That's "use the struct that contains the pwm_chip" compared
   to "use the struct registered in probe belonging to this pwm_chip's
   coupled device".

> > > container_of() isn't exactly wrong, but it's really just papering over
> > > the fact that platform_set_drvdata() is in the wrong place, so I'd
> > > prefer a patch that does that instead.
> >=20
> > platfrom_set_drvdata is in a perfectly fine position if you only rely on
> > it in the platform_driver's remove callback which is the case with my
> > patch. I wrote in my commit log
>=20
> In general it's still a bad idea to call platform_set_drvdata() after
> you register with the framework, so I think that's a worthwhile change
> irrespective of your fix.

*shrug*

> > | Instead of setting the driver data earlier use the traditional
> > | container_of approach as this way the driver data is conceptually and
> > | computational nearer.
> >=20
> > which is still think to be true. The main thing I don't like about the
> > platform_set_drvdata approach is that you have to rely on
> > dev_get_drvdata() returning the value set with platform_set_drvdata()
> > which IMHO is an implementation detail of the platform driver code.
>=20
> Well yeah, but it's an implementation detail that pretty much all
> platform drivers rely on and that's been like this ever since
> platform_{get,set}_drvdata() were introduced over 15 years ago.
>=20
> So it's not like this is suddenly going to stop working.

Yes, however that hardly makes it prettier in my book.

Two statistics about that area:

- All PWM drivers in drivers/pwm/ use dev_get_drvdata only in PM
  callbacks but not PWM ops. Compared to the latter PM callbacks don't
  get a pwm_chip argument and so cannot use container_of.

- The following drivers use platform_set_drvdata only after pwmchip_add:

  - pwm-ab8500.c
  - pwm-atmel.c
  - pwm-atmel-hlcdc.c
  - pwm-atmel-tcb.c
  - pwm-berlin.c
  - pwm-cros-ec.c
  - pwm-ep93xx.c
  - pwm-fsl-ftm.c
  - pwm-hibvt.c
  - pwm-lpc18xx-sct.c
  - pwm-lpc32xx.c
  - pwm-lpss-platform.c
  - pwm-meson.c
  - pwm-mtk-disp.c
  - pwm-mxs.c
  - pwm-omap-dmtimer.c
  - pwm-pxa.c
  - pwm-sifive.c
  - pwm-sl28cpld.c
  - pwm-sti.c
  - pwm-stm32.c
  - pwm-stm32-lp.c
  - pwm-stmpe.c
  - pwm-sun4i.c
  - pwm-tiecap.c
  - pwm-tiehrpwm.c
  - pwm-twl.c
  - pwm-twl-led.c
  - pwm-vt8500.c
  - pwm-zx.c
 =20
  None of these currently has a problem with respect to ordering of
  platform_set_drvdata vs pwmchip_add (now that pwm-sl28cpld.c is
  fixed).

  For completeness: The following drivers use platform_set_drvdata
  before pwmchip_add:
 =20
  - pwm-bcm2835.c
  - pwm-bcm-iproc.c
  - pwm-bcm-kona.c
  - pwm-brcmstb.c
  - pwm-clps711x.c
  - pwm-crc.c
  - pwm-img.c
  - pwm-imx1.c
  - pwm-imx27.c
  - pwm-imx-tpm.c
  - pwm-iqs620a.c
  - pwm-jz4740.c
  - pwm-lp3943.c
  - pwm-mediatek.c
  - pwm-rcar.c
  - pwm-renesas-tpu.c
  - pwm-rockchip.c
  - pwm-samsung.c
  - pwm-spear.c
  - pwm-sprd.c
  - pwm-tegra.c

So arguing that pwm-sl28cpld.c should continue to use dev_get_drvdata in
the PWM callbacks and fixing only this single driver's order between
platform_set_drvdata and pwmchip_add now seems strange to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wvt4xbgxixtahvyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/KlrYACgkQwfwUeK3K
7AnB0Qf+MWflWc7qDJvzXAIdeJXLHkmAzbRE1AvzsCsGX/iC91sEvH50TVqZ56he
sgytzIf/opr3EjEsOHdAoltRfeh/K2oNZl9NVtnDTJvtCOISjGeFsSWurQb0AMP4
uA98JLSu/SgpGH3VUE0RSu9+8Y8feozr29tGhxXExNP+kwU0xuZM5XAih/HLA2FA
sV276/QTars4dwbI4VafD38NteKuWulOeMlVAyiPq4eyWOD1kE8txrCiZ6yiemXn
/pxDtfOIwcGLYxz6VB+iE2ITc+6VDtIhWyzdXP49XOOMmanUDp7gmHLgVKGVR3lA
Gcmc5j/wl1RG1sYQIU4jFgWPQsicMg==
=MWBZ
-----END PGP SIGNATURE-----

--wvt4xbgxixtahvyv--
