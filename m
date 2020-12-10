Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04412D599A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 12:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgLJLpm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 06:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgLJLoX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 06:44:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DFC0613CF
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 03:43:41 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knKM8-00068o-3f; Thu, 10 Dec 2020 12:43:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knKM6-0000XR-CS; Thu, 10 Dec 2020 12:43:30 +0100
Date:   Thu, 10 Dec 2020 12:43:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sean@mess.org, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201210114330.6pgtome3aq3hj55t@pengutronix.de>
References: <1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75lrswuigp2g2w5p"
Content-Disposition: inline
In-Reply-To: <1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--75lrswuigp2g2w5p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 08, 2020 at 11:01:45PM +0100, Lino Sanfilippo wrote:
> Use the newer .apply function of pwm_ops instead of .config, .enable,
> .disable and .set_polarity. This guarantees atomic changes of the pwm
> controller configuration. It also reduces the size of the driver.
>=20
> Since now period is a 64 bit value, add an extra check to reject periods
> that exceed the possible max value for the 32 bit register.
>=20
> This has been tested on a Raspberry PI 4.
>=20
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Side note: I'm a bit surprised about the output of

	b4 diff 1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de

This is probably due to the fact that compared to v3 you also rebased.
Still the diff is quite big.

Best regards and thanks for your patch
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--75lrswuigp2g2w5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/SCd8ACgkQwfwUeK3K
7AmZWAf+LEKGVZjqR9SrgShtkRoQm3CGpU1qgqHlwn7DtLcP3RzI6D/EKlOe2vQe
VAtrTI3p2cH7j+HP9LO4JQZgkjvp95g4jsecW6At23YI3oxplzbl9fsqrX7iINGj
S+imzTYo1CC9u6GZFrKy9lBpN1Wh6Uy5kF660+mgBvIMADm78hiv9IDJXKw8zsWk
aDlmtXKZ9+WjUnPNB9n42RzTA6ZcarJhiypt6wHV1dARUz5fVf1JpUUyVvb8aUIo
9/f+AFAJkYxch3vUM+L2FvCuAvGj8uwp9J2GkfMd/g93QtjIg4uTmaCgPqBIVYNC
yoWwtlvJNrRMKiRq+pSKHMwHh3sJ7g==
=Went
-----END PGP SIGNATURE-----

--75lrswuigp2g2w5p--
