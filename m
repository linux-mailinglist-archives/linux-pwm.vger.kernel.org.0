Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC80540595F
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbhIIOnl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbhIIOnf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 10:43:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB1C0613D9
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 07:16:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOKqS-0004UW-RR; Thu, 09 Sep 2021 16:16:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOKqR-0008DC-Kg; Thu, 09 Sep 2021 16:16:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOKqR-0006dw-Je; Thu, 09 Sep 2021 16:16:03 +0200
Date:   Thu, 9 Sep 2021 16:16:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jisheng Zhang <jszhang@marvell.com>, linux-pwm@vger.kernel.org,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: berlin: Put channel config into driver data
Message-ID: <20210909141603.6u5p3dkgderru67x@pengutronix.de>
References: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
 <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
 <20210630061804.2qrsqbd4xl7wtunh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s3daw2boiil3uajd"
Content-Disposition: inline
In-Reply-To: <20210630061804.2qrsqbd4xl7wtunh@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s3daw2boiil3uajd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Jun 30, 2021 at 08:18:04AM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, May 04, 2021 at 03:25:35PM +0200, Uwe Kleine-K=F6nig wrote:
> > Instead of allocating extra data in .request() provide the needed memory
> > in struct berlin_pwm_chip. This reduces the number of allocations. A si=
de
> > effect is that on suspend and resume the state for all four channels is
> > always saved and restored. This is easier (and probably quicker) than
> > looking up the matching pwm_device and checking its PWMF_REQUESTED bit.
>=20
> I noticed you applied the other three patches in this series, but
> skipped this one and marked it as rejected.
>=20
> Please point out what you don't like about this patch instead of just
> dropping it without comment.

Any news on this? I still consider the patch good and would like to know
your objections.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s3daw2boiil3uajd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE6FyAACgkQwfwUeK3K
7Alatwf8D0f+P56UcuZi2rXby8RbVaUN/1yM4rt1BbtYVlYpZS9DhUJX//G+cpcu
nJ/WY+Y2CyvGxGCTeoeNaxXk3A/p/l17mxR+8SZNMiuRgqw82g51AdPQ2X+zydtW
qbbKgyY6JmHIDsAbz7U5RWankUfb/pFetk69D0kWN30wJ8e4CWgZ7lshm0HTt5WB
3xD2xgn53Riq/2je8htLPK45F73DsDMBRNycxHV+Qm/wJ8gYkCSNkVok7mnbQIxA
HuEKes0D+5IALEaLKxK089ysxZvwkR/2Jq/kW8hTIS9JldBNKc+59MuezfpoyOb/
w80E2NO2ZfTmSqZBQV0+ws9MLe+eZw==
=B69t
-----END PGP SIGNATURE-----

--s3daw2boiil3uajd--
