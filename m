Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34B3696DD
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhDWQ3q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWQ3q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 12:29:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A2C061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 09:29:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZyfy-0004y6-BJ; Fri, 23 Apr 2021 18:29:06 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZyfw-0006A7-IY; Fri, 23 Apr 2021 18:29:04 +0200
Date:   Fri, 23 Apr 2021 18:29:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] pwm: reword docs about pwm_apply_state()
Message-ID: <20210423162904.t6v6f7wq3u4ms7yg@pengutronix.de>
References: <20210423074411.2167332-1-u.kleine-koenig@pengutronix.de>
 <5aa17591-dcc7-6d29-0ca3-3b4a3be7f3ef@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlry6iqarwyqjxn7"
Content-Disposition: inline
In-Reply-To: <5aa17591-dcc7-6d29-0ca3-3b4a3be7f3ef@infradead.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jlry6iqarwyqjxn7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2021 at 08:08:48AM -0700, Randy Dunlap wrote:
> On 4/23/21 12:44 AM, Uwe Kleine-K=F6nig wrote:
> > The main issue is that the current documentation talks about the
> > non-existent function pwm_get_last_applied_state. (This was right in the
> > context of
> > https://lore.kernel.org/linux-pwm/20210406073036.26857-1-u.kleine-koeni=
g@pengutronix.de/
> > but was then missed to adapt when this patch was reduced to a
> > documentation update.)
> >=20
> > While at is also clarify "last applied PWM state" to "PWM state that was
> > passed to the last invocation of pwm_apply_state()" to better
> > distinguish to the last actually implemented state and reword to drop a
> > word repetition.
> >=20
> > Fixes: 539ed98e2bd3 ("pwm: Clarify documentation about pwm_get_state()")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  Documentation/driver-api/pwm.rst | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-ap=
i/pwm.rst
> > index 381f3c46cdac..a7ca4f58305a 100644
> > --- a/Documentation/driver-api/pwm.rst
> > +++ b/Documentation/driver-api/pwm.rst
> > @@ -55,11 +55,11 @@ several parameter at once. For example, if you see =
pwm_config() and
> > pwm_{enable,disable}() calls in the same function, this probably means =
you
> > should switch to pwm_apply_state().
> >=20
> > The PWM user API also allows one to query the[-last applied-] PWM state=
 [-with-]
> > [-pwm_get_last_applied_state().-]{+that was passed to the+}
> > {+last invocation of pwm_apply_state() using pwm_get_state().+} Note th=
is is
> > different to what the driver has actually implemented if the request ca=
nnot be
> > [-implemented-]{+satisfied+} exactly with the hardware in use. There is=
 currently no way for
> > consumers to get the actually implemented settings.
> >=20
> > In addition to the PWM state, the PWM API also exposes PWM arguments, w=
hich
> > are the reference PWM config one should use on this PWM.
> >=20
> > base-commit: 64d7d074acd52e1bdff621f2cb86c0aae9bcef80
> >=20
>=20
> Looks like the patch got horribly word wrapped. ?

No, this was created using git format-patch --word-diff, which for
continuous text is much better parsable (for a human at least).

The same chang in the more usual form looks as follows:

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pw=
m.rst
index 381f3c46cdac..a7ca4f58305a 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -55,11 +55,11 @@ several parameter at once. For example, if you see pwm_=
config() and
 pwm_{enable,disable}() calls in the same function, this probably means you
 should switch to pwm_apply_state().
=20
-The PWM user API also allows one to query the last applied PWM state with
-pwm_get_last_applied_state(). Note this is different to what the driver has
-actually implemented if the request cannot be implemented exactly with the
-hardware in use. There is currently no way for consumers to get the actual=
ly
-implemented settings.
+The PWM user API also allows one to query the PWM state that was passed to=
 the
+last invocation of pwm_apply_state() using pwm_get_state(). Note this is
+different to what the driver has actually implemented if the request canno=
t be
+satisfied exactly with the hardware in use. There is currently no way for
+consumers to get the actually implemented settings.
=20
 In addition to the PWM state, the PWM API also exposes PWM arguments, which
 are the reference PWM config one should use on this PWM.

With that it's hardly possible to identify what I actually changed.

I just noticed that the patch is not only incompatible for you but also
git-am cannot apply it, so I will have to resend. :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jlry6iqarwyqjxn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCC9c0ACgkQwfwUeK3K
7Am+GQf/ch6KzM5y0qoAjTLJYYBw8D93pieWdbigQYvHeQrwL0gg/aC3ejBHlbxJ
BtO1Uiy1dGL4j8MZrjFKOGDTwJyHCN4LzQk7OK+iPRBdCX+dQROiKp9MqaptJsAq
g+GCS9vzT6C3CQTiHqIiHxHKn2PkZieSDjpWvsn0qyKiFEcj86afqDT2LY0F3ye1
0q2TilPSazEXg+jvvmLAXkUsW14ImuNd8VgBLe2D9itupLZPzoaSn7zaNBpBohju
1N5nMreq0ssvxP9j0Am1w14lOOqvkr8PIk1ntd2STLa4HqjWg3EGgJU5UnweSNCe
SNd2NOei7CTSjUPLbW05KM6BGZsk+g==
=tAzu
-----END PGP SIGNATURE-----

--jlry6iqarwyqjxn7--
