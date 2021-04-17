Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD80363101
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhDQPrf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbhDQPrf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 11:47:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99519C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 08:47:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXnA2-0003Gp-N1; Sat, 17 Apr 2021 17:47:06 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXnA2-0006JL-DK; Sat, 17 Apr 2021 17:47:06 +0200
Date:   Sat, 17 Apr 2021 17:47:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 8/8] pwm: pca9685: Add error messages for failed
 regmap calls
Message-ID: <20210417154706.viuhjndqxt42chi7@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-8-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rjyk2u3xdjjkrfxa"
Content-Disposition: inline
In-Reply-To: <20210412132745.76609-8-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rjyk2u3xdjjkrfxa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 03:27:45PM +0200, Clemens Gruber wrote:
> Regmap operations can fail if the underlying subsystem is not working
> properly (e.g. hogged I2C bus, etc.)
> As this is useful information for the user, print an error message if it
> happens.
> Let probe fail if the first regmap_read or the first regmap_write fails.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rjyk2u3xdjjkrfxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7AvcACgkQwfwUeK3K
7AmH7gf/XrBNOieEI7U/RlT+rH1YxyG7n0VcODOkFaZuaef4aUQDaCKVDWgHTf4Z
l1j7o8NmN8+lx7KmM1r7TXq9j2rh2Z2/G46RVCnSzYLokDjz50ChOIiRHMqS7vhJ
qBOZAju+nvi5UuPXSD9TGbLpLhJVQO3JgulHosUQRXrOjYmaS3228TX8lnoHDsf2
2NTZzNy3CTIKBYQ7d8Kadm40GSkAkTqht1SRa/v++0SDgAjrGSQBFANNcIvPszv2
5Xnkr3AqcijirX3lmiKSvLpHvzyimen+3d1RyNvBTMDg9o0+GMchWQMtB8SBF4jr
/5XL4eyHWtRlR5odCt8cODt5ZFSl+g==
=3VMg
-----END PGP SIGNATURE-----

--rjyk2u3xdjjkrfxa--
