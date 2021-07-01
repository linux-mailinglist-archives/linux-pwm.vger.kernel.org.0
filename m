Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA83B909F
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhGAKsE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 06:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhGAKsC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 06:48:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E9C061756
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 03:45:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyuCH-0008MF-5M; Thu, 01 Jul 2021 12:45:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyuCG-0002WD-6L; Thu, 01 Jul 2021 12:45:28 +0200
Date:   Thu, 1 Jul 2021 12:45:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 0/3] pwm: Some improvements for legacy drivers
Message-ID: <20210701104528.dbnhhswxp6rgzzj3@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWFL42BV9m7Oigvy0m7=-i4W0hnQT8izHdNNiYG0BfiMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ybkf4rnxt26ezue"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWFL42BV9m7Oigvy0m7=-i4W0hnQT8izHdNNiYG0BfiMQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3ybkf4rnxt26ezue
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2021 at 10:58:32AM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Thu, Jul 1, 2021 at 9:29 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > this is the successor of my earlier patch "pwm: Ensure for legacy
> > drivers that pwm->state stays consistent" that was applied shortly to
> > next until Geert found a problem with it.
> >
> > I split the patch in three parts now: First the legacy handling is just
> > moved to a separate function without any semantic change. Then a glitch
> > is fixed, but without the regression I introduced initially. In the
> > third and last patch the longstanding FIXME about breaking pwm->state if
> > a callback fails is addressed.
> >
> > Uwe Kleine-K=F6nig (3):
> >   pwm: Move legacy driver handling into a dedicated function
> >   pwm: Prevent a glitch for legacy drivers
> >   pwm: Restore initial state if a legacy callback fails
> >
> >  drivers/pwm/core.c | 139 ++++++++++++++++++++++++++-------------------
> >  1 file changed, 79 insertions(+), 60 deletions(-)
>=20
> Thanks, works fine on Armadillo 800 EVA!
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for testing.

> > base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
>=20
> That's plain v5.13-rc1, which is probably not what Thierry is targeting?

his for-next branch is based on v5.13-rc1 and there are no changes in it
touching drivers/pwm/core.c, so I expect this to be fine.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3ybkf4rnxt26ezue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdnL4ACgkQwfwUeK3K
7AkWUwf/fCmh5nCg8CE3qhlZXPHce/tWIE1h2Sv2HYGIkF4joYjfvUzBzMPtF2dw
eaVzms7s5ewkfCBafpNtp52+ChoM5lBz5ZzRzhW/ys5NSd44O2y7Y0EHH9uJbZVI
VKag50vzN3cgmH49jsgpA8gByIHSPtqypqWg4BWKRWIsa9NRp3WD6pLd5qbCwGIr
VYThg+OdSWRTNvE0Am2IHpkNV9e81zJP00qyRY+4bn1QZHDCyTOMun/SLpUL3gKD
qvXCJQd60Tt98s9vaAllOzsbNVW/TjgjuwT9ZiI4zeR48jD7t70r8BvGK9uaAdcC
6DOuxH6nvH+XZOP9Eqy3BzJUfohQzg==
=nX0s
-----END PGP SIGNATURE-----

--3ybkf4rnxt26ezue--
