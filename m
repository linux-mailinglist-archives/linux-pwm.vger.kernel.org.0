Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C545A9D0
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Nov 2021 18:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhKWRS7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 12:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhKWRS7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 12:18:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D84C061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 09:15:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpZOX-0005aS-Ht; Tue, 23 Nov 2021 18:15:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpZOX-000dCy-5N; Tue, 23 Nov 2021 18:15:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpZOW-0005zG-5N; Tue, 23 Nov 2021 18:15:48 +0100
Date:   Tue, 23 Nov 2021 18:15:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] pwm: Some improvements for legacy drivers
Message-ID: <20211123171548.sgn7dbkhiioejgds@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <YZUp4ZdTpXrpCKjg@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5nefpe532k3tmwru"
Content-Disposition: inline
In-Reply-To: <YZUp4ZdTpXrpCKjg@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5nefpe532k3tmwru
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 05:12:17PM +0100, Thierry Reding wrote:
> On Thu, Jul 01, 2021 at 09:29:24AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > this is the successor of my earlier patch "pwm: Ensure for legacy
> > drivers that pwm->state stays consistent" that was applied shortly to
> > next until Geert found a problem with it.
> >=20
> > I split the patch in three parts now: First the legacy handling is just
> > moved to a separate function without any semantic change. Then a glitch
> > is fixed, but without the regression I introduced initially. In the
> > third and last patch the longstanding FIXME about breaking pwm->state if
> > a callback fails is addressed.
> >=20
> > Uwe Kleine-K=F6nig (3):
> >   pwm: Move legacy driver handling into a dedicated function
> >   pwm: Prevent a glitch for legacy drivers
> >   pwm: Restore initial state if a legacy callback fails
> >=20
> >  drivers/pwm/core.c | 139 ++++++++++++++++++++++++++-------------------
> >  1 file changed, 79 insertions(+), 60 deletions(-)
>=20
> I've applied this to for-next, let's see if this blows up or not.

Up to now for-next didn't blow up, but the simplest explanation isn't
that my patches are fine but that for-next still points at
pwm/for-5.16-rc1 which is already in Linus' tree. I suspect you forget
to push?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5nefpe532k3tmwru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGdIcAACgkQwfwUeK3K
7Am5lQf8D90Kk0esCmvw4eya7wEn0ynNZ111SAfPmxgEku+UJ3iR/i1+vYqR+C3G
V5C/k8zFs3b2JfNcNqqEILahADzwlCU0BHHmW1h78v6pfB/YFrOSWoFoyAN8DmoN
tikq8gI299m8hQUWhRyVAMjbgm2TGPGJnFj01NVmqabrtpUdlYx/0nOHeCH8w202
CTOKEeNgoeV4q9RFSMVWhtLj2SC3ekTPhqvkMwvilHeeKb2IRTiJ96QO+QoFLqPH
4elycrwKrGyEyhRXaMFJUqGOr3NddY9YufkJcY3yeOTh8yDtjwh4H1CvG9UdcBix
q8m3G3aeNi3GHgrmL1Lbe2bWe1qyjQ==
=NLW/
-----END PGP SIGNATURE-----

--5nefpe532k3tmwru--
