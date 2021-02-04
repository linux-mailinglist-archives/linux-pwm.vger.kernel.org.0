Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A992530F44C
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Feb 2021 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhBDNzr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Feb 2021 08:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBDNzY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Feb 2021 08:55:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E9DC061573
        for <linux-pwm@vger.kernel.org>; Thu,  4 Feb 2021 05:54:41 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7f5j-0005Ff-6n; Thu, 04 Feb 2021 14:54:39 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l7f5g-0007to-TZ; Thu, 04 Feb 2021 14:54:36 +0100
Date:   Thu, 4 Feb 2021 14:54:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Ban Tao <fengzheng923@gmail.com>,
        linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <20210204135436.xkxkp6qxjpcnfxgg@pengutronix.de>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203151200.fdzzq23teoypbxad@pengutronix.de>
 <YBrQTM5iADZgA2v1@ulmo>
 <20210203205913.dvmppahnkmcj2dac@pengutronix.de>
 <YBv44P71Z0cD1BSG@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5n55ifqwrdmxs635"
Content-Disposition: inline
In-Reply-To: <YBv44P71Z0cD1BSG@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5n55ifqwrdmxs635
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Feb 04, 2021 at 02:38:40PM +0100, Thierry Reding wrote:
> All I'm saying is that I don't think we need to require everyone to
> adopt a prefix, especially if this hasn't been followed consistently,
> because then we don't actually gain anything.

Is "we didn't do this consistently in the past" a reason to never
improve here? I hope it's not ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5n55ifqwrdmxs635
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAb/JkACgkQwfwUeK3K
7AnaxQf9EqzF2WspMJC8fSN3GE4BD1gqJYSbjZfa7M8+apxIRpbITARFTlBxpTQc
UQ0YWm3rtSwHfcs5ta/SoBBvCi66A2TcrdVbGo+ShByNBKr7aQpVlKUw20AB8+cS
Xo9KgQNSqULN+qzh4rxZXeVv20DKamENwZ3FNtnwgN/tDZcDAfhK0k7b1USIwA/9
dz0PPL/DeFMCimiWCKn2wv+2bc8LdL7gO68b9gSmtVMySvfDVMrhA+JEZimH0puM
5LGEmN4OX3yifk0ljYFyBJBhj8terLo/isnUjY4jXp/IIJiFVDVBkc4RSHdD2k9i
2qv88x9eUn2lFbRk4w8MUOWNkkTirw==
=1dCm
-----END PGP SIGNATURE-----

--5n55ifqwrdmxs635--
