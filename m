Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46E2799C4
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Sep 2020 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIZNs3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Sep 2020 09:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZNs3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Sep 2020 09:48:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2DC0613CE
        for <linux-pwm@vger.kernel.org>; Sat, 26 Sep 2020 06:48:29 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMAYp-0001ti-Sb; Sat, 26 Sep 2020 15:48:23 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMAYp-00020w-9T; Sat, 26 Sep 2020 15:48:23 +0200
Date:   Sat, 26 Sep 2020 15:48:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, michal.vokac@ysoft.com,
        l.majewski@majess.pl, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/5] pwm: imx27: enable clock unconditional for
 register access
Message-ID: <20200926134823.zog3722y3l3ti25x@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
 <20200925155330.32301-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qt7vcyvtyddeyqig"
Content-Disposition: inline
In-Reply-To: <20200925155330.32301-2-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qt7vcyvtyddeyqig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 25, 2020 at 05:53:26PM +0200, Marco Felsch wrote:
> The current implementation enables the clock if the current PWM state
> is '!enabled' to ensure the register access and left the clock on if the
> new state is 'enabled'. Further apply calls don't enable the clock since
> they relying on the fact the the clock is already running. Change this
> behaviour since it is not very intuitive.
>=20
> This commit changes this behaviour. Now the clocks are unconditional
> enabled/disabled before/after the register access. If the PWM should be
> turned on (state.enabled) we enable the clock again and vice versa if
> the PWM should be turned off (!state.enabled).
>=20
> Therefore I added the enable member to the driver state struct since
> the usage of cstate and pwm_get_state() is a layer violation. I removed
> this violation while on it.

while looking through patch 2 I found something missing here:
You don't initialize .enabled in .probe().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qt7vcyvtyddeyqig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9vRqQACgkQwfwUeK3K
7AlQvwf4rsbbSogi68QnXz27MXReFpj2VwdzXQz+abhIIbvD56QEeSnjRKNS45UN
pPczURSbuEgWKGFwttmYroN8ef3V668zhwqFlnx/hBe/1w80NrnRhnGTApKVFljw
044VY4wyeetC26oW+HgeoEKumIRYtfRsDyjERxJyP+4cHwqOpcKhCPusGH+5o3ZG
SbxH/r8c6nJQnNlJAU33xx1WDVt2yc2vHhFUQlZkp6VfuPNgm3aZDLtbwmFQA/FT
/U0ecAmW2zAqU0/IsM/gjTyHrpdzkk8WlmubbRyj+VcZMt1KK/AW3zcjNccDgImS
r13UnmKwjIXszbk/aLqS9Vg+/DH/
=53iy
-----END PGP SIGNATURE-----

--qt7vcyvtyddeyqig--
