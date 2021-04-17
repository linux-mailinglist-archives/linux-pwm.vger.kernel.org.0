Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA73630FE
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhDQPqr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 11:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbhDQPqq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 11:46:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD6C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 08:46:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXn9G-0003DZ-2a; Sat, 17 Apr 2021 17:46:18 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXn9F-0006Iu-PB; Sat, 17 Apr 2021 17:46:17 +0200
Date:   Sat, 17 Apr 2021 17:46:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] pwm: pca9685: Restrict period change for enabled
 PWMs
Message-ID: <20210417154617.uamygwgvfs5qopek@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-7-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lblwo5wjig2aavxn"
Content-Disposition: inline
In-Reply-To: <20210412132745.76609-7-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lblwo5wjig2aavxn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 03:27:44PM +0200, Clemens Gruber wrote:
> Previously, the last used PWM channel could change the global prescale
> setting, even if other channels are already in use.
>=20
> Fix it by only allowing the first enabled PWM to change the global
> chip-wide prescale setting. If there is more than one channel in use,
> the prescale settings resulting from the chosen periods must match.
>=20
> GPIOs do not count as enabled PWMs as they are not using the prescaler
> and can't change it.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

I think this patch could be a tad simpler (by just counting the number
of enabled channels instead of maintaining a bitmap). Still this is
beneficial, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lblwo5wjig2aavxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7AscACgkQwfwUeK3K
7AlJDggAjcrJSrAajTzJk1qLkWHThVtd0xdAcxRa0Cebvfyl8OQO62kD3W9NvGIc
qE4k0FuVsN7J8sGOPbfKfRFD7+YlYiDxZWi2yvgj0TMbMpnCx3/6U8FbyEwIRIXq
bATVIYpv9YDmVhsJRV3ue/I6FyeBnN6ugh/LMgxwj9oRPpLD2H7rZy+iYShbeA3b
dpF5QNOzpjtMi/Pw5YQ3PsBf1GYDMFbLvYCn2wBewTJ7zUUzT3frGEyL8LkMQbga
Kj3720JhF3ZyFvcInIz6OeIKgjJmn+U80zXqsF20j02c67RR15EoU0s8n6lmLlxQ
l7Hh1obHvypOCIvlcVGKV/knWEtjpA==
=A33i
-----END PGP SIGNATURE-----

--lblwo5wjig2aavxn--
