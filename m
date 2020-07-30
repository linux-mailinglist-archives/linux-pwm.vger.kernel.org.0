Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0C232C30
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 09:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgG3HAh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jul 2020 03:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3HAe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jul 2020 03:00:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C47BC061794
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2020 00:00:34 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k12YD-0006w4-F8; Thu, 30 Jul 2020 09:00:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k12Y9-0007TC-HZ; Thu, 30 Jul 2020 09:00:21 +0200
Date:   Thu, 30 Jul 2020 09:00:21 +0200
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
Message-ID: <20200730070021.l2yuomsc3uwua5bx@pengutronix.de>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <20200729072145.ifzoe656sjpxdior@pengutronix.de>
 <20200730050653.GA1665100@dtor-ws>
 <20200730061631.y4r4s6v3xepktj54@pengutronix.de>
 <20200730063404.GH1665100@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6mvmazbtlauombxa"
Content-Disposition: inline
In-Reply-To: <20200730063404.GH1665100@dtor-ws>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6mvmazbtlauombxa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 29, 2020 at 11:34:04PM -0700, Dmitry Torokhov wrote:
> On Thu, Jul 30, 2020 at 08:16:31AM +0200, Uwe Kleine-K=F6nig wrote:
> > I suggested that some time ago with limited success, see
> > https://lore.kernel.org/lkml/20200129115516.zsvxu56e6h7gheiw@pathway.su=
se.cz/
> > .
> >=20
> > > In the meantime I would prefer using %d when we have integer
> > > error. We should not see these error messages anyway ;)
> >=20
> > I don't agree. Error messages are supposed to be helpful and I prefer
> > some casting between error pointer and error int over emitting bare
> > numbers to the kernel log. (And additionally the uglyness might help to
> > convince the vsprintf guys that %de might be a good idea after all :-)
>=20
> Sorry, but I do not think that I want to introduce this pointless
> casting just to sway printk folks. Either we have proper way of
> formatting error codes, or we do not and we stick with what was working
> since forever.

You got me wrong. Getting an argument to rediscuss %de is just a minor
side reason for me. Getting an expressive error message is the relevant
reason.

There is also an inconsitence in what you suggest that I don't like. If
in a probe function devm_clk_get fails it should say "-ENODEV" but if
it's clk_enable that fails it should say "-5"?

Also "we stick with what was working since forever" is a poor argument.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6mvmazbtlauombxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8icAIACgkQwfwUeK3K
7AnIkAf/d0H21gepKuzCj8TF4i7RhVdQmovVhCkjECV45VfUaPWJVa5DPDT51HVp
ddTSzc4cQybR+P11UlUZxDh19YETlA7weL1KOPOqVQsdolbW7jg55nisi0UP5PEN
rPfPU6HBQCr4G1pFsoljrxtLUe/oXfz52LMF1MQtRaOoOebAxuDZJ66D45I2fAm1
ZXFmjlpv8x0ynqwD2JjmZGc8YQG2+qa5ncHlZg2Ip6dNL99PMMuQ6vFK7+tDah0f
10opv9MtabIWYebuDxP5Pn3LeAG5Vw11oMjZKsf9ndwDCSqg1F4uLYYX7iDsR1lb
sGIy10masMtW9D+19sXnR2cqwFDzWQ==
=DuS1
-----END PGP SIGNATURE-----

--6mvmazbtlauombxa--
