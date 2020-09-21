Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12038271E93
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 11:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgIUJKF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 05:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUJKF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2020 05:10:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E568C061755
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2020 02:10:05 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHpd-0005sH-5c; Mon, 21 Sep 2020 11:09:57 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHpb-0000up-5n; Mon, 21 Sep 2020 11:09:55 +0200
Date:   Mon, 21 Sep 2020 11:09:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] pwm: imx27: fix disable state for inverted PWMs
Message-ID: <20200921090955.sw3mrlxgh45pcpru@pengutronix.de>
References: <20200909130739.26717-1-m.felsch@pengutronix.de>
 <20200909130739.26717-4-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydfpghr6vcmgzvw6"
Content-Disposition: inline
In-Reply-To: <20200909130739.26717-4-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ydfpghr6vcmgzvw6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marco,

On Wed, Sep 09, 2020 at 03:07:39PM +0200, Marco Felsch wrote:
> Up to now disabling the PWM is done using the PWMCR.EN register bit.
> Setting this bit to zero results in the output pin driving a low value
> independent of the polarity setting (PWMCR.POUTC).
>=20
> There is only little documentation about expectations and requirements
> in the PWM framework but the usual expectation seems to be that
> disabling a PWM or setting .duty_cycle =3D 0 results in the output driving

s/or/together with/

> the inactive level. The pwm-bl driver for example uses this setting to
> disable the backlight and with the pwm-imx27 driver this results in an
> enabled backlight if the pwm signal is inverted.
>=20
> Keep the PWMCR.EN bit always enabled and simulate a disabled PWM using
> duty_cycle =3D 0 to fix this. Furthermore we have to drop the sw-reset
> from apply() else the PWMCR.EN is cleared too. Therefore the

s/else/otherwise/

> pwm_imx27_wait_fifo_slot() is extended to guarantee a free FIFO slot.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Without having looked deeper into this patch the approach described here
looks sound to me. Dropping the sw-reset in .apply is also nice as this
results in a spike.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ydfpghr6vcmgzvw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9obeAACgkQwfwUeK3K
7Am/1wf/Sj+N0zFdHakS/1zqrBYGt3MbeVsW0ZaNnxRghKe+u6q36sKcnNG8E9cS
44N3TdasImfCZzV+aptK2ocH4yFpgUrBc0ZRhulyKy0d4SRdsPbIBLyXpfnYTzAA
HM6vj0Jmo3jdSspkuIyHMLPxvsd5fu8U3gf3z7WnRkXsGpKgUEVdzuyD+qTPq4JM
fvAbKBSPYSvvZNxPdoh6hM1/BeGvJ5u47UaD4b6SLLT2CXpF525npIOuIfYNrrQb
w7B60sJ5pUUVWkYZ4iUSa/u+tzbFp7m7hYn3WiAcvFNxrueeQjlXFpxgLwqOEvHr
1297hEatXxvDy1FGDdNn16Yxs4URFQ==
=PFVe
-----END PGP SIGNATURE-----

--ydfpghr6vcmgzvw6--
