Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E58231A43
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgG2HWF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgG2HWF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2020 03:22:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A9C061794
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 00:22:04 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0gPM-0003pE-ES; Wed, 29 Jul 2020 09:21:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0gPJ-00042r-9P; Wed, 29 Jul 2020 09:21:45 +0200
Date:   Wed, 29 Jul 2020 09:21:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Roy Im <roy.im.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200729072145.ifzoe656sjpxdior@pengutronix.de>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jb6kq5unqof2j4e3"
Content-Disposition: inline
In-Reply-To: <20200729063638.GY1665100@dtor-ws>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jb6kq5unqof2j4e3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jul 28, 2020 at 11:36:38PM -0700, Dmitry Torokhov wrote:
> > v9:=20
> > 	- Removed the header file and put the definitions into the c file.
> > 	- Updated the pwm code and error logs with %pE
>=20
> I believe the %pE is to format an escaped buffer, you probably want to
> %pe (lowercase) to print errors. I am also not quite sure if we want to
> use it in cases when we have non-pointer error, or we should stick with
> %d as most of the kernel does.

compared with %d %pe is easier to understand as it emits "-ETIMEOUT"
instead of "-110". And yes, %pE is wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jb6kq5unqof2j4e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8hI4YACgkQwfwUeK3K
7AkB5gf+N9Wv/PsK4tYxuCcM2KSR0mxt7QizYVPKeAI51kqD6cNZSJbMOdO27yWI
7zr8A//A5v91uqmLbfZHTTK+fEqOFUbM4Btr9/euXT2Hat8S1ADSYsfvEv+6ntdl
HFqjsbx1b13YPATOPoE0vWrTfnKMq9WDpCuc9G68B3fMSTZ9q3WU6bphpEW4viDq
ZxYFYPJLZbVufvzH6Ad3PXwmJpsvtAoLVNzh/ZfFn3luTYKV9tkXb0xneS07xLTx
/4eCgSi7kFlhvc3FGv3usecj3NfZ39EYVLgmwshl2jXa77wQo8NicQarzCfohhz2
g3RvEx1zi/dTCvJYjKH4o1w3GiuF7w==
=McvG
-----END PGP SIGNATURE-----

--jb6kq5unqof2j4e3--
