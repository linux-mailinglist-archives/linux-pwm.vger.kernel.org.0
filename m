Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36633BB744
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jul 2021 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhGEGon (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEGon (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 02:44:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1DCC061574
        for <linux-pwm@vger.kernel.org>; Sun,  4 Jul 2021 23:42:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0IIt-0008Sy-6o; Mon, 05 Jul 2021 08:42:03 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0IIq-00038G-R2; Mon, 05 Jul 2021 08:42:00 +0200
Date:   Mon, 5 Jul 2021 08:42:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm: ep93xx: Fix uninitialized variable bug in
 ep93xx_pwm_apply()
Message-ID: <20210705064200.adl72wngfidov7xn@pengutronix.de>
References: <YNx1y8PlSLehZVIY@mwanda>
 <20210630153600.327ff7vcrx76lw26@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kks4xpy4yqeqdftx"
Content-Disposition: inline
In-Reply-To: <20210630153600.327ff7vcrx76lw26@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kks4xpy4yqeqdftx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 30, 2021 at 05:36:00PM +0200, Uwe Kleine-K=F6nig wrote:
> this problem was found already earlier by Colin King:
>=20
> 	https://lore.kernel.org/r/20210629172253.43131-1-colin.king@canonical.com
>=20
> I'm fine with either change.

FTR: Thierry applied Colin's patch, so I'm discarding this one from
patchwork as not applicable.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kks4xpy4yqeqdftx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDiqa8ACgkQwfwUeK3K
7AkIqAf+JkteW/uZUQyk1+Ob90zPhNWHL/Zs1ADVtXTLffha5f+XU3LmDxcvzGsg
D+j0gfnClBIRFLEVnNh5+heuERDz7zmMZEyrDt28NPa3uEMHPBMh4RQLnM832vUY
pzk8H0F8DFs6pin9ToDYsFIvo0jSruZl6WwGEtPoTSMab6wNAqaIOfJp4JetICC9
EzJApcGhIHykl0RzRrfHGQzZxG5TdIRLvOCt588ybmcXopfnPmhzx1TKUKDfZTbn
VDNDWMkC71zrUcybzhP5nF3xYcRlpyxO/VIOdNS0esZ/WjFD3HPenrcNY3+FUgkP
R0Y+/DZNe3TUHViXDNacm2c4XP+jpw==
=QLDn
-----END PGP SIGNATURE-----

--kks4xpy4yqeqdftx--
