Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F066300BB9
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Jan 2021 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbhAVSoP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Jan 2021 13:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbhAVSNW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Jan 2021 13:13:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8AEC0613D6
        for <linux-pwm@vger.kernel.org>; Fri, 22 Jan 2021 10:12:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l30vI-0007P8-Ac; Fri, 22 Jan 2021 19:12:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l30vH-0002y0-JD; Fri, 22 Jan 2021 19:12:39 +0100
Date:   Fri, 22 Jan 2021 19:12:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: iqs620a: Correct a stale state variable
Message-ID: <20210122181239.ut33bmzxlvy2mx5f@pengutronix.de>
References: <1611030629-21746-1-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="schzdac6g4yw6zyi"
Content-Disposition: inline
In-Reply-To: <1611030629-21746-1-git-send-email-jeff@labundy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--schzdac6g4yw6zyi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jan 18, 2021 at 10:30:29PM -0600, Jeff LaBundy wrote:
> If duty cycle is first set to a value that is sufficiently high to
> enable the output (e.g. 10000 ns) but then lowered to a value that
> is quantized to zero (e.g. 1000 ns), the output is disabled as the
> device cannot drive a constant zero (as expected).
>=20
> However if the device is later re-initialized due to watchdog bite,
> the output is re-enabled at the next-to-last duty cycle (10000 ns).
> This is because the iqs620_pwm->out_en flag unconditionally tracks
> state->enabled instead of what was actually written to the device.
>=20
> To solve this problem, use one state variable that encodes all 257
> states of the output (duty_scale) with 0 representing tri-state, 1
> representing the minimum available duty cycle and 256 representing
> 100% duty cycle.
>=20
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

>  1 file changed, 37 insertions(+), 51 deletions(-)

Nice cleanup, thanks for picking up this idea.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--schzdac6g4yw6zyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmALFZQACgkQwfwUeK3K
7AkBxAf/eeAsCsu+VHnGVAZZ5yHrA1Nu+gK4X8WX9+uXNuKsQKybOmuBbjjEP/CD
xS/jU3NmGHu8SEgJQ+TxWfAC8HRq8rfTOnE/ZPVjECesx0zJFXLonkooVucXvGHy
h78qNvSiNOeIf1Gouwtlc3AB30DmGASbVj5Y/TsgZEKW7u7kiG48S8pvkQDIvpOr
LXiqGhy0kWkE49BmnqUroUoNoL2D4WWgdVXt4EFwvb9FZXtesTmyHFkVZ4OXkCU+
HaQxqG84tAYzqNNIAPM1iACb3x9X115JdcscZxol8YKGhmAFuOBGa05mV3WaWmML
v8ff9to0da8p3aMSIMDo0nUKoGc1GA==
=32WE
-----END PGP SIGNATURE-----

--schzdac6g4yw6zyi--
