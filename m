Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9365C34D5DE
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhC2RQG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhC2RQD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 13:16:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAA0C061574
        for <linux-pwm@vger.kernel.org>; Mon, 29 Mar 2021 10:16:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQvUe-0008Bk-Cw; Mon, 29 Mar 2021 19:16:00 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQvUe-0007Vq-2L; Mon, 29 Mar 2021 19:16:00 +0200
Date:   Mon, 29 Mar 2021 19:15:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 6/7] pwm: pca9685: Restrict period change for
 prescaler users
Message-ID: <20210329171559.rfelpt42shlebct5@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-6-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="axmib6bx2qpqrpz4"
Content-Disposition: inline
In-Reply-To: <20210329125707.182732-6-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--axmib6bx2qpqrpz4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 02:57:06PM +0200, Clemens Gruber wrote:
> @@ -330,14 +345,22 @@ static int pca9685_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> =20
>  	if (!state->enabled || duty < 1) {
>  		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> +		clear_bit(pwm->hwpwm, pca->prescaler_users);

Hmm, so if "my" channel runs at say

	.duty_cycle =3D 2539520 ns
	.period =3D 5079040 ns

and I call pwm_apply_state(mypwm, { .duty_cycle =3D 0, .period =3D 5079040,
enabled =3D true }); it might happen that another channel modifies the
period and I won't be able to return to the initial setting.

So I think it's sensible to only clear the user bit if the PWM is
disabled, but not if it is configured for duty_cycle =3D 0.

Does this make sense?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--axmib6bx2qpqrpz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBiC0wACgkQwfwUeK3K
7AlkBgf/ZsIVifdArIudb+NAdINg7Trcn1pB1kFTd+KLscaLK5SsgfynrgY9Wspu
zTNGm71C8o17Yw24uyrAhUZF1Vt7BMFjaPPhOulBFEKVWDDkmm6XoB8WP96djYH8
fhg1pjZ/EvM8CmYZqmfnGnMDO2huSZNWlj8a1V7gPyzFKflZ1Jy82+K/SCvlQVSQ
B0yYhvLF/rHPCqWvS1u2OJVZJ5jpzM0MsgmOHXqka+Y+u2FaRI1dg+M9AVRBOPsi
lF183kQLJEaiMlJAuzPp8KWd30WTb2I7Mcy8tv4TY9PTg6TpUqmRc4oCB/5cBIt6
LeXwv0Rz3KJkQeBK8bnF2NQj8LmwZA==
=gKsr
-----END PGP SIGNATURE-----

--axmib6bx2qpqrpz4--
