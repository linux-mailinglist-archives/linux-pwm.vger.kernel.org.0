Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359C535CDF6
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbhDLQlG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbhDLQcY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 12:32:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDB4C061350
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 09:27:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVzPI-0002Jm-Hm; Mon, 12 Apr 2021 18:27:24 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVzPH-0001ZI-Vk; Mon, 12 Apr 2021 18:27:23 +0200
Date:   Mon, 12 Apr 2021 18:27:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xlhucg6eoih6yebb"
Content-Disposition: inline
In-Reply-To: <20210412132745.76609-4-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xlhucg6eoih6yebb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> Add the flag and corresponding documentation for PWM_USAGE_POWER.

My concern here in the previous round was that PWM_USAGE_POWER isn't a
name that intuitively suggests its semantic. Do you disagree?

> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
>  include/dt-bindings/pwm/pwm.h                 | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentatio=
n/devicetree/bindings/pwm/pwm.txt
> index 084886bd721e..fe3a28f887c0 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -46,6 +46,9 @@ period in nanoseconds.
>  Optionally, the pwm-specifier can encode a number of flags (defined in
>  <dt-bindings/pwm/pwm.h>) in a third cell:
>  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> +- PWM_USAGE_POWER: Only care about the power output of the signal. This
> +  allows drivers (if supported) to optimize the signals, for example to
> +  improve EMI and reduce current spikes.

IMHO there are too many open questions about which freedom this gives to
the lowlevel driver. If the consumer requests .duty_cycle =3D 25ns +
=2Eperiod =3D 100ns, can the driver provide .duty_cycle =3D 25s + .period =
=3D
100s which nominally has the same power output? Let's not introduce more
ambiguity than there already is.

This is a NAck.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xlhucg6eoih6yebb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB0dOgACgkQwfwUeK3K
7AkyoAgAj56WHSz3mbbQpQYJfzLAgaVxZH4sopRLrKgguHa/mEHhlxerTk239Pit
0ePi/frDOR6+xWdP96WxYTIdivJ3+Tddpqgt+L6d9yu8S4DSRZwtrpU+3/DGjAhm
TsTjV0Sj/xMb81vBwizQjFOyopsKEXHujAE4Y2+8CwtR7ns2m0L43hifWD8eaJKB
WapPTzjH0CYZHOr0t6EbX0JQVqYNObZywx/1NRyyjjy8ypJ1Vt52mpuw35tmGL8r
sC5Ur2byGV7thCkewB6ufCy6Ks50AIzdktrgaLMjOE2c8SL2Gg1HjWov1heOVUWq
qNrgmb3zkNOEr4spJpdNiAbbLoQsRA==
=V9Pw
-----END PGP SIGNATURE-----

--xlhucg6eoih6yebb--
