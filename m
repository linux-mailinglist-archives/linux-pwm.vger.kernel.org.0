Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382EB352FF5
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Apr 2021 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhDBTxS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Apr 2021 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhDBTxS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Apr 2021 15:53:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D7C0613E6
        for <linux-pwm@vger.kernel.org>; Fri,  2 Apr 2021 12:53:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSPqy-00028g-91; Fri, 02 Apr 2021 21:53:12 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSPqx-0008Ve-MY; Fri, 02 Apr 2021 21:53:11 +0200
Date:   Fri, 2 Apr 2021 21:52:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] dt-bindings: pwm: pca9685: Add
 nxp,staggered-outputs property
Message-ID: <20210402195258.xqmt5cie5jhws2bq@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-5-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opcwn6b37j2a5mei"
Content-Disposition: inline
In-Reply-To: <20210329125707.182732-5-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--opcwn6b37j2a5mei
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Mon, Mar 29, 2021 at 02:57:05PM +0200, Clemens Gruber wrote:
> The pca9685 driver supports a new nxp,staggered-outputs property for
> reduced current surges and EMI. This adds documentation for the new DT
> property.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>

This patch would need an ack by the dt guys, so you should Cc: them in
the next round if this (or a similar) patch is still part of the series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--opcwn6b37j2a5mei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBndhcACgkQwfwUeK3K
7AlSNAgAjiZRY5bGPsn0MLq8k4/JGbwduZhKpwzC+nIdXsYBDlicYCPQ43UUdlCG
SzeSHmobU10y29czpK8HZiOEkQB02MHLUJ329wUiIrKw+I9qbXvuj915gx8LGJVu
n9QPLHyYDVQHCz8nEWysc8pAk1aKUbAcBJ05uvIFLoMIzjg8wxvOZ6kw7ixKBfgb
oWEK1O52tspy/BX/4dvtA1FScc8SsSmBrRniVqV/StFHKk7jlJQlBOFnlqjWDdpX
68hHcUjIrHn0fdb2QyBGicTtROqOStvKvMS+s/b2oq6fHDcSvAn1Kqc6n678ll7N
DvzpRh0nGx7UxBzmARS/GyStsF72Qw==
=DcOT
-----END PGP SIGNATURE-----

--opcwn6b37j2a5mei--
