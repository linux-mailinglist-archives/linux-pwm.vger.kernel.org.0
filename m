Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8536120F127
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgF3JIL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbgF3JIK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 05:08:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD5C061755
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jun 2020 02:08:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jqCFL-000619-6a; Tue, 30 Jun 2020 11:08:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jqCFK-0001al-AU; Tue, 30 Jun 2020 11:08:06 +0200
Date:   Tue, 30 Jun 2020 11:08:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200630090806.6bgjgi34gtcrzfze@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200629160844.6ecf79c1@xps13>
 <20200629195044.uvgma53cajiko3gf@pengutronix.de>
 <20200630085828.1aebdf99@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6efgvsv3vhhwcas"
Content-Disposition: inline
In-Reply-To: <20200630085828.1aebdf99@xps13>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--q6efgvsv3vhhwcas
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Miquel,

On Tue, Jun 30, 2020 at 08:58:28AM +0200, Miquel Raynal wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote on Mon, 29 Jun
> 2020 21:50:44 +0200:
>=20
> > On Mon, Jun 29, 2020 at 04:08:44PM +0200, Miquel Raynal wrote:
> > > Hello Uwe, Thierry,
> > >=20
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
> > > 12:54:53 +0200:
> > >  =20
> > > > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > > > functions but can also manage the intensity on each of its ports wi=
th
> > > > PWM. Each output is independent and may be tuned with 16 values (4
> > > > bits per output). The period is always 32kHz, only the duty-cycle m=
ay
> > > > be changed. One can use any output as GPIO or PWM.
> > > >=20
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > --- =20
> > >=20
> > > Can I have a status on this patch please?
> > >=20
> > > If it was forgotten, I would be good to have it queued now, otherwise,
> > > may I know the reason? =20
> >=20
> > You could reply to my feedback ... If you could say there: "What you
> > want isn't possible" I'd count this as a strong indication to not ask to
> > implement Andy's suggestion. (Even if this would be possible, I'm not
> > sure this is a good idea, but still ...)
>=20
> Sorry for the misunderstanding, but I already replied twice to Andy
> about this. Once in October, again in November, then I gave a shot to
> the idea of splitting the drivers (GPIO vs. PWM) in January. So I
> thought you were sharing your thoughts out loud but was not expecting
> any specific feedback on it.

Ah ok. Probably the discussion took too long already and was swapped out
on my end.

I will take a look once more later this week. One thing I noticed while
skimming the patch was, that the added defines could make use of a nice
prefix. MAX_PWM for example sounds quite generic.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q6efgvsv3vhhwcas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl77APMACgkQwfwUeK3K
7AmdWwf+NJnKEOUjeeHA3Ud3w8l7E+nDL0RwEKeFDSjcFcoPKx+gC9VOj+8qFbA5
rMEQZUXEY3sN5K36oVWQ4F6RU7e8LZwU1Q458H0t1+YK4wnVaT/lq4qisRejIot9
1nuyfRuz4LfbAzERL5CIpCQu+LsfDbg6ZyUOiyR12N42wVYWGcdi/wS77eXPtS6C
+R+vYVrZtwIW+xK5OeY8PXycziJeLkYTZ382yObdsN0y6+05oYpBe8HUgEp9IxHG
6qEebvwI6Ta2p+SBo1WBbKqntOqDZDR0fRvGABLI9fRTDRC++fBXlNYVdepIP52C
5pJbowCjeSdTZXZPI5VgbdQvMzoejw==
=0bW1
-----END PGP SIGNATURE-----

--q6efgvsv3vhhwcas--
