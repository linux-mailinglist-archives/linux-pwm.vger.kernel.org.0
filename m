Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9936A0EF
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Apr 2021 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhDXLcq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Apr 2021 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhDXLcq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Apr 2021 07:32:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2EC061574
        for <linux-pwm@vger.kernel.org>; Sat, 24 Apr 2021 04:32:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1laGW5-0002hG-TH; Sat, 24 Apr 2021 13:32:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1laGW5-0003yu-IV; Sat, 24 Apr 2021 13:32:05 +0200
Date:   Sat, 24 Apr 2021 13:32:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Introduce single-PWM of_xlate function
Message-ID: <20210424113204.besr7gye2htzkbkr@pengutronix.de>
References: <20210423213304.1371143-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umx3eoqn4tuipz4y"
Content-Disposition: inline
In-Reply-To: <20210423213304.1371143-1-bjorn.andersson@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--umx3eoqn4tuipz4y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 23, 2021 at 04:33:04PM -0500, Bjorn Andersson wrote:
> The existing pxa driver and the upcoming addition of PWM support in the
> TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> thereby a need for a of_xlate function with the period as its single
> argument.
>=20
> Introduce a common helper function in the core that can be used as
> of_xlate by such drivers and migrate the pxa driver to use this.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I'm OK with the idea as such. I'd like to see the semantic expanded a
bit however such that the function can parse

	pwms =3D <&mypwm 50000>;

and also

	pwms =3D <&mypwm 500000 PWM_POLARITY_INVERTED>;

=2E You suggetion only covers the former.

See
https://lore.kernel.org/r/20210315111124.2475274-2-u.kleine-koenig@pengutro=
nix.de
for my first attempt to unify of_pwm_xlate_with_flags and
of_pwm_simple_xlate accordingly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--umx3eoqn4tuipz4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCEAbEACgkQwfwUeK3K
7AllDwf7Bf7vhyQDoQiHxWV1r7kDGBePcnWCysh/Zbq2Cki5mCcx3N/Tg5M+SZJx
+NstCe89990Rx9csl5vRkuHvja7Ng8l9PkxCEuw3JjDuzwoYGF5gZqFya6HaVwIa
wQ6oMtypriYsxn9fy3E5CoGsO9TDOUIEhjFVLGezzMgLFnYgzLoqYcdmV7ZKLyyE
wGYEZmqpmx8qRsoCoTKjwsVYXRXUPepUkHhDGyrqRcv0xQ1KG9mzTG1JNh9Owd7C
pfw1/FmMzfYMyzU+hrnxp6SYO4UOjgZHOD57vg9HVj/S1+FFGuvmw7yhTZfwf4dn
yvetfDwfqs8vVFT8UIODzBTb1EvhaA==
=f0LX
-----END PGP SIGNATURE-----

--umx3eoqn4tuipz4y--
