Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAFD36B6A3
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Apr 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhDZQUa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Apr 2021 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhDZQU2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Apr 2021 12:20:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB21C061574
        for <linux-pwm@vger.kernel.org>; Mon, 26 Apr 2021 09:19:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb3xZ-0008EQ-09; Mon, 26 Apr 2021 18:19:45 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb3xY-0005it-Fl; Mon, 26 Apr 2021 18:19:44 +0200
Date:   Mon, 26 Apr 2021 18:19:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Introduce single-PWM of_xlate function
Message-ID: <20210426161944.65rmbqzgqqqqpoby@pengutronix.de>
References: <20210423213304.1371143-1-bjorn.andersson@linaro.org>
 <20210424113204.besr7gye2htzkbkr@pengutronix.de>
 <20210426152427.GG1908499@yoga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="id67to7g2nombnxm"
Content-Disposition: inline
In-Reply-To: <20210426152427.GG1908499@yoga>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--id67to7g2nombnxm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 26, 2021 at 10:24:27AM -0500, Bjorn Andersson wrote:
> On Sat 24 Apr 06:32 CDT 2021, Uwe Kleine-K?nig wrote:
>=20
> > Hello,
> >=20
> > On Fri, Apr 23, 2021 at 04:33:04PM -0500, Bjorn Andersson wrote:
> > > The existing pxa driver and the upcoming addition of PWM support in t=
he
> > > TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> > > thereby a need for a of_xlate function with the period as its single
> > > argument.
> > >=20
> > > Introduce a common helper function in the core that can be used as
> > > of_xlate by such drivers and migrate the pxa driver to use this.
> > >=20
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >=20
> > I'm OK with the idea as such. I'd like to see the semantic expanded a
> > bit however such that the function can parse
> >=20
> > 	pwms =3D <&mypwm 50000>;
> >=20
> > and also
> >=20
> > 	pwms =3D <&mypwm 500000 PWM_POLARITY_INVERTED>;
> >=20
> > . You suggetion only covers the former.
>=20
> One concern though is that a single-channel pwm with the optional flag
> would syntactically be indistinguishable from a multi-channel property
> without flags. Presumably the values are out of range though, so I
> suppose there's no problem in practice.

I personally have no problem with it, for clk-providers it is also
normal that some need an id and others don't. If we have such concerns
(Thierry?) we should insist that new drivers always require an channel
id (which is always 0 for single-channel PWMs).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--id67to7g2nombnxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCG6B0ACgkQwfwUeK3K
7AnbVAgAk7WlLeM/zxEGvihmQed8fTEUMpL7CsoXfT+MjTsIx/fDiiuAZhzBofsi
Pp8cdt6VBOgax4hs6ZZ1UemfrjLe2azE6ae6MSWvuy9q37ssmBHtF/E9KvWUwt6S
02DthDkh4Kn1sKnnTcYqiEb3u6umPYM6lI8tNPHO5nF6DAZYGSeYjQPNwxmfY7+7
JBzS9jVNfBAvbLVryriq7FJDKVudw36DlhFLHxC5mXhdMs7liNhjFEmTZyWmDzHa
ExiN78LJgv883uxXhRuYcenwI9saubKdqG8nUQHaQvmKgZTzWlWm+xYX47bjv87k
6FvWd4m1Zf3PqrCJjN4vI5O7e49lMA==
=Z5KQ
-----END PGP SIGNATURE-----

--id67to7g2nombnxm--
