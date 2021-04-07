Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF04235770D
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhDGVln (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhDGVln (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 17:41:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87908C061760
        for <linux-pwm@vger.kernel.org>; Wed,  7 Apr 2021 14:41:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUFvX-0007ju-B9; Wed, 07 Apr 2021 23:41:31 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUFvX-0002BI-1b; Wed, 07 Apr 2021 23:41:31 +0200
Date:   Wed, 7 Apr 2021 23:41:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] pwm: pca9685: Add error messages for failed
 regmap calls
Message-ID: <20210407214130.6retlpofjppl3o53@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-8-clemens.gruber@pqgruber.com>
 <20210407061619.fl6ffos6csvgtnjh@pengutronix.de>
 <YG4acW/xZS2+/kDz@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnpc6ko75vlz4xpc"
Content-Disposition: inline
In-Reply-To: <YG4acW/xZS2+/kDz@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qnpc6ko75vlz4xpc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Wed, Apr 07, 2021 at 10:47:45PM +0200, Clemens Gruber wrote:
> On Wed, Apr 07, 2021 at 08:16:19AM +0200, Uwe Kleine-K=F6nig wrote:
> > You didn't check all return codes? How did you select the calls to
> > check?
>=20
> No, because it would become a big mess and really obstruct readability
> in my opinion.
>=20
> So I chose some kind of middleground:
> I decided to check the first regmap_read and regmap_write in probe and
> return the error code if something goes wrong there.
> If something goes wrong after probe, I only print an error message.
>=20
> Is that acceptable?

I wanted to have that in the commit log, but just noticed that I didn't
read it carefully enough, it's already there.

So if you change %d in the error messages to %pe I'm happy with this
patch.

Thanks
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qnpc6ko75vlz4xpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBuJwMACgkQwfwUeK3K
7AkELQf/aPOL73PAnyQwBMySWiPeBzJKT5lSTj+3b2tF3IVXiaB8NRko/QK04BD0
i17P0PPHdoDFupi9dOJdhuHLB5jpDddRdYmnWtqBI7NV4czNehZOWvW4D43qnFt4
tpQp54oweioxbJSBn80SNeb+V+Y8dYZCOelo9aHsqtIH5FPVYYJZZkt/+OtiFtqD
6VhKq9QshFWXWZUN/7ICmdOtoMZMA00ZMDSLaz953AOYfG6TGmrVhoVzY5YofOuw
GKQdf5INZp0xVfNHJDPWGsokkuqHE6G+YSuZYN4n6oen/5NcC9kmTdE1ON4+kQLu
QhvrHd4GFgWn2ra7uTCvAb/IkhX/Fg==
=RTFu
-----END PGP SIGNATURE-----

--qnpc6ko75vlz4xpc--
