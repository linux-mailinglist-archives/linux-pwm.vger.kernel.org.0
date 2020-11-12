Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726852B0095
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgKLHxf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 02:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKLHxe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 02:53:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ECDC0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 23:53:34 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kd7QC-0002Em-Gl; Thu, 12 Nov 2020 08:53:32 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kd7QB-0007eL-Rv; Thu, 12 Nov 2020 08:53:31 +0100
Date:   Thu, 12 Nov 2020 08:53:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Use -EINVAL for unsupported polarity
Message-ID: <20201112075329.x7xxn3hdndmkeqtt@pengutronix.de>
References: <20201111202257.414889-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ae6dw22r45mih2pj"
Content-Disposition: inline
In-Reply-To: <20201111202257.414889-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ae6dw22r45mih2pj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 09:22:57PM +0100, Thierry Reding wrote:
> Instead of using a mix of -EOPNOTSUPP and -ENOTSUPP, use the more
> standard -EINVAL to signal that the specified polarity value was
> invalid.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I wonder if we should go further and do the same if the request cannot
be fulfilled for other reasons (usually: period to big)

-ERANGE and -EINVAL seem to be a common there, there is also an -ETIME
in drivers/pwm/pwm-imx-tpm.c and drivers/pwm/pwm-renesas-tpu.c uses
ENOTSUPP.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ae6dw22r45mih2pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+s6fYACgkQwfwUeK3K
7AnLgAgAkMcADMdSK7JauErj+EdB/acEvtLBRmGdUdDGsyVuSWnDYWz2xw1pj5ui
p9mZSPl8y7PNSrJbQ46FPgJHMUKX1KI3vSmA3KXRpi8iuBsN4xY2f+sQsjn/NKdi
enoUP2MYuZvskEE0a36pMWBSqYXdykkwiijhFTsCWE2p7wY7UHhSiXQuKVb0SQv6
1nV1VcYTEjeaPYAEeiLez5upr2BvmsmfDvh8AW06cYOPjR6/2o92lLeemSm+1MfJ
KmZQ3fL57NCCsvGVWpzN0+Z7j2XL7nqLVzcFVosbi8L/TGkBlsDzWldssQs/E9us
9xMqJnopjWjAb1239/b5XMmP/cgjCQ==
=X9zP
-----END PGP SIGNATURE-----

--ae6dw22r45mih2pj--
