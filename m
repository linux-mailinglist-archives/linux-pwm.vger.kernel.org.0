Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75F2A3CF9
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Nov 2020 07:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKCGuv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Nov 2020 01:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgKCGuv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2020 01:50:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63147C0617A6
        for <linux-pwm@vger.kernel.org>; Mon,  2 Nov 2020 22:50:51 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kZq9U-0003L7-Ae; Tue, 03 Nov 2020 07:50:44 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kZq9T-0000J5-M6; Tue, 03 Nov 2020 07:50:43 +0100
Date:   Tue, 3 Nov 2020 07:50:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tiehrpwm: handle deferred probe with dev_err_probe()
Message-ID: <20201103065042.q5hdtgt5hocpbie3@pengutronix.de>
References: <20201030201254.24557-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bmre73pghmxnepi4"
Content-Disposition: inline
In-Reply-To: <20201030201254.24557-1-grygorii.strashko@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bmre73pghmxnepi4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 10:12:54PM +0200, Grygorii Strashko wrote:
> The devm_clk_get() may return -EPROBE_DEFER which is not handled properly
> by TI EHRPWM driver and causes unnecessary boot log messages.
>=20
> Hence, add proper deferred probe handling with new dev_err_probe() API.
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bmre73pghmxnepi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+g/b8ACgkQwfwUeK3K
7Am8Iwf+OUodyjVZVhlpvWoJPt4Hb+j7LMbxqbySou1Q+8vdNBQ2ixHrnPjRajUr
AMvkSBABdoLpGN5Co3eZUBaQkmYHnJz0BjMFesaR+tq79/nutXQvlvR/EJPiXOve
NyWyB7J9XRHT+SIm3Y95fbpSaUDnYY3qD7dIJpebVVVt9Drf37OwXrfDe/7q1k1v
nPyUyHPzTtgJy5ImjeFzliIa+p/DNk81crjDAVMbOKFyfNIfMn7yM20tw6T7aerN
zQ3DN170BM7CIAaVVMTYnFJP/XQ5E5fAIgoLe6f+mu6hSDxHCIuwalgUTGExjIqp
ZtuyHU3jQmA8Amy+nGV+DoEhDM11IA==
=N+vN
-----END PGP SIGNATURE-----

--bmre73pghmxnepi4--
