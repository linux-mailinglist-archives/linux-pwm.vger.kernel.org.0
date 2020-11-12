Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E423D2B036C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 12:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgKLLFG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 06:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgKLLFD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 06:05:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1C8C0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2020 03:05:02 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdAPU-00010D-59; Thu, 12 Nov 2020 12:05:00 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdAPT-0008Go-Hs; Thu, 12 Nov 2020 12:04:59 +0100
Date:   Thu, 12 Nov 2020 12:04:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: sti: Remove unnecessary blank line
Message-ID: <20201112110457.uzno3tz7dv2xokae@pengutronix.de>
References: <20201111191449.409402-1-thierry.reding@gmail.com>
 <20201111191449.409402-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lymjkbt23omv7677"
Content-Disposition: inline
In-Reply-To: <20201111191449.409402-2-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lymjkbt23omv7677
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[dropped Ajit Pal Singh from Cc:]

On Wed, Nov 11, 2020 at 08:14:49PM +0100, Thierry Reding wrote:
> A single blank line is enough to separate logical code blocks.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

I would consider this too minor to create a patch for, but as you
already invested the time:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lymjkbt23omv7677
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+tFtYACgkQwfwUeK3K
7AmGhgf/d8waZwCeF2OyI7sL2QcBl84NLT/PHaW2fiNX4riQz4ZN+3AJYOv5CpDy
pKGHTXqEMgZeYnjjbvrkhvpmUJTuWFIY4IbXAYQKefpulXXeYHmuu0PEaQ+rhGcs
H0/L+oy9ArlzooXLq3FLnPBactYLvcrB4W0NfsMlWZUqZSazndxpWW4kteBDd4rt
PqMGji+ft9EO3sb0cs4YKT2Gzt8Qf01M78U+lRb1etCctWMem/kgG0J23p0f1jR1
niMvD1Wh7YAu3ofYZr3RU592+/bAzm4Bsb4x09tiz+gqQwOOTR1Oj6FDvJoPZo9+
PfBvjkf28yu+qGiVbuNLS0g92JLWGA==
=yj9v
-----END PGP SIGNATURE-----

--lymjkbt23omv7677--
