Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701F6232BD5
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 08:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgG3GQr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgG3GQr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jul 2020 02:16:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F3C061794
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 23:16:46 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k11ro-00032m-Hv; Thu, 30 Jul 2020 08:16:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k11rj-0006Ev-DC; Thu, 30 Jul 2020 08:16:31 +0200
Date:   Thu, 30 Jul 2020 08:16:31 +0200
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
        linux-pwm@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v18 3/3] Input: new da7280 haptic driver
Message-ID: <20200730061631.y4r4s6v3xepktj54@pengutronix.de>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <20200729072145.ifzoe656sjpxdior@pengutronix.de>
 <20200730050653.GA1665100@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fz3lejizyldfimsi"
Content-Disposition: inline
In-Reply-To: <20200730050653.GA1665100@dtor-ws>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fz3lejizyldfimsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Adding vsprintf maintainers to Cc:]

Hello,

On Wed, Jul 29, 2020 at 10:06:53PM -0700, Dmitry Torokhov wrote:
> On Wed, Jul 29, 2020 at 09:21:45AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Tue, Jul 28, 2020 at 11:36:38PM -0700, Dmitry Torokhov wrote:
> > > > v9:=20
> > > > 	- Removed the header file and put the definitions into the c file.
> > > > 	- Updated the pwm code and error logs with %pE
> > >=20
> > > I believe the %pE is to format an escaped buffer, you probably want to
> > > %pe (lowercase) to print errors. I am also not quite sure if we want =
to
> > > use it in cases when we have non-pointer error, or we should stick wi=
th
> > > %d as most of the kernel does.
> >=20
> > compared with %d %pe is easier to understand as it emits "-ETIMEOUT"
> > instead of "-110". And yes, %pE is wrong.
>=20
> While I can see that symbolic name instead of a numeric constant might
> be appealing, I do not believe that we want fragments like this with
> endless conversions between integer and pointer errors:
>=20
> 	if (haptics->const_op_mode =3D=3D DA7280_PWM_MODE) {
> 		haptics->pwm_dev =3D devm_pwm_get(dev, NULL);
> 		if (IS_ERR(haptics->pwm_dev)) {
> 			error =3D PTR_ERR(haptics->pwm_dev);
> 			if (error !=3D -EPROBE_DEFER)
> 				dev_err(dev, "unable to request PWM: %pE\n",
> 					ERR_PTR(error));
> 			return error;
> 		}
>=20
> Maybe we should introduce something like '%de' for the integer error
> case?

I suggested that some time ago with limited success, see
https://lore.kernel.org/lkml/20200129115516.zsvxu56e6h7gheiw@pathway.suse.c=
z/
=2E

> In the meantime I would prefer using %d when we have integer
> error. We should not see these error messages anyway ;)

I don't agree. Error messages are supposed to be helpful and I prefer
some casting between error pointer and error int over emitting bare
numbers to the kernel log. (And additionally the uglyness might help to
convince the vsprintf guys that %de might be a good idea after all :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fz3lejizyldfimsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8iZbwACgkQwfwUeK3K
7Alqgwf/QhPTWri/aJ6aKC1Qf4GZICrCZy5Xn1coDwtnUcU/daCkeA6gtX4fGffV
pAVA/5PJ/H2T0urdRlwPynwLunhL0FVKOlFB3ta+Ir7aiI8r8V7joD0Eqbb56gCh
yJCowGmV4Pz1BmkjlZqo9c2BFAxqLMOePENs85PfgMrcayhsuG55kNtFb7ZyXzvW
QMJ5tuaOeesM/5iAjUKSGQneGXYvJPOLGkwmPxER+ACeWIqCWaXSeNIeU/d22wCT
a2csqlFa6SG3J8D8lcWa+9xH80VmvF60ROr5BjQWah5ccbO7zwH9nc9hY5rdg+Ub
tFmojQ9HJW32hSFz2olina/eIgV39g==
=9HiY
-----END PGP SIGNATURE-----

--fz3lejizyldfimsi--
