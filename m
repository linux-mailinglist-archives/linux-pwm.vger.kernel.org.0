Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B35224687
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 01:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgGQXEm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 19:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQXEm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 19:04:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DE5C0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:04:41 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jwZP9-0006OI-0R; Sat, 18 Jul 2020 01:04:35 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jwZP8-0003RR-07; Sat, 18 Jul 2020 01:04:34 +0200
Date:   Sat, 18 Jul 2020 01:04:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v2] pwm: bcm-iproc: handle clk_get_rate() return
Message-ID: <20200717230431.4oj44cfnkhkd2o6z@pengutronix.de>
References: <20200717182512.26001-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ahgp5eqlhd5enic"
Content-Disposition: inline
In-Reply-To: <20200717182512.26001-1-scott.branden@broadcom.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5ahgp5eqlhd5enic
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 11:25:12AM -0700, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>=20
> Handle clk_get_rate() returning <=3D 0 condition to avoid
> possible division by zero.

You advertise handling <=3D 0, but in the code only =3D=3D 0 is checked. One
of the two is wrong ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5ahgp5eqlhd5enic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8SLnwACgkQwfwUeK3K
7AmfdwgAk8gWLxkwQKT9ApRiJ25C12PNu+T1nJQzle/itAdvq83W5gP6Lzud1iOh
a8px2Q5xIP20aHy5Z21OCUOzxqDl7+9o6kczLPLvJesanMC0+DCwBzkyQp/Vs/Kq
kSX+mdliVsMZGe0YVlXtuFtss1cs04KksXD0Ge1gMlciEXywgPMYhh0edJg53zKT
9jJ5NtV7tiNKacdSODSfdK6Z8KTTqzK36V+ZFWVzFZkJ9nk1XS7y1rbuC6unlK7O
2mPfE/QuKuP7tmslau5ejLlBZKoVS3qFeAFMzmaI/3HxMuML87XkMwz8ophU3TLl
sEZOpcLNEK2sPvO1T0WVo+PBtnEpuQ==
=6nzc
-----END PGP SIGNATURE-----

--5ahgp5eqlhd5enic--
