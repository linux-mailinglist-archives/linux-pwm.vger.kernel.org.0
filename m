Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC16447E6C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Nov 2021 12:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhKHLHO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Nov 2021 06:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbhKHLHN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Nov 2021 06:07:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918EC061570
        for <linux-pwm@vger.kernel.org>; Mon,  8 Nov 2021 03:04:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk2Rv-0003Ef-6Y; Mon, 08 Nov 2021 12:04:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk2Ru-0005i2-5I; Mon, 08 Nov 2021 12:04:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk2Ru-0001nI-4M; Mon, 08 Nov 2021 12:04:26 +0100
Date:   Mon, 8 Nov 2021 12:04:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jisheng Zhang <jszhang@marvell.com>, linux-pwm@vger.kernel.org,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: berlin: Put channel config into driver data
Message-ID: <20211108110413.6kfe6fguabvgclnd@pengutronix.de>
References: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
 <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
 <20210630061804.2qrsqbd4xl7wtunh@pengutronix.de>
 <20210909141603.6u5p3dkgderru67x@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="frssanxrxqfvtmoa"
Content-Disposition: inline
In-Reply-To: <20210909141603.6u5p3dkgderru67x@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--frssanxrxqfvtmoa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Sep 09, 2021 at 04:16:03PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Jun 30, 2021 at 08:18:04AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, May 04, 2021 at 03:25:35PM +0200, Uwe Kleine-K=F6nig wrote:
> > > Instead of allocating extra data in .request() provide the needed mem=
ory
> > > in struct berlin_pwm_chip. This reduces the number of allocations. A =
side
> > > effect is that on suspend and resume the state for all four channels =
is
> > > always saved and restored. This is easier (and probably quicker) than
> > > looking up the matching pwm_device and checking its PWMF_REQUESTED bi=
t.
> >=20
> > I noticed you applied the other three patches in this series, but
> > skipped this one and marked it as rejected.
> >=20
> > Please point out what you don't like about this patch instead of just
> > dropping it without comment.
>=20
> Any news on this? I still consider the patch good and would like to know
> your objections.

This patch is still in my private working copy and I still don't know
why you rejected it. :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--frssanxrxqfvtmoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGJBCQACgkQwfwUeK3K
7AlDWwf/esdD5nB8vzANTCcwyKtAniTgqNS07dMEkoToKZeof/EYgDZXditzqYpc
S7K5JY05lgesca2pNjn4jpmGOg1WRjeCCBVsnzkFl3nAr7Nx3I2gI9vnsSOftlVn
UmgMcC1tuvgK728x4kd/5e8mzzznXzYXz4o/qVdr2XFQ+QQXTCmFE9vDFOYMAsSg
QEwdgz16CAH20Ud2oVhktQzKK/zthC1fNWkq0QthVEHsjSW9W35uddiQlu2avQdV
l7mbUwviNWqC/Z8ZyVZVAOePydZlOBIANgjCwaDhUD3X0VnfuUous+pWLrqKiWZn
CrxryqSAsJ9k8oJ4zJock9Mb44y3OA==
=nYbu
-----END PGP SIGNATURE-----

--frssanxrxqfvtmoa--
