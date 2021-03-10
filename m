Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C212333B9B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Mar 2021 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhCJLko (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Mar 2021 06:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhCJLke (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Mar 2021 06:40:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA54C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 10 Mar 2021 03:40:34 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJxCD-0007eB-Lh; Wed, 10 Mar 2021 12:40:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJxC3-0001F5-OJ; Wed, 10 Mar 2021 12:39:59 +0100
Date:   Wed, 10 Mar 2021 12:39:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [GIT PULL] Immutable branch between MFD, PWM and RTC due for the
 v5.13 merge window
Message-ID: <20210310113959.dnokjrt7dos43fx6@pengutronix.de>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
 <20210301102826.GK641347@dell>
 <20210309200520.GA4931@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3r3tpixs7nevo2h"
Content-Disposition: inline
In-Reply-To: <20210309200520.GA4931@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--r3r3tpixs7nevo2h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Tue, Mar 09, 2021 at 08:05:20PM +0000, Lee Jones wrote:
> On Mon, 01 Mar 2021, Lee Jones wrote:
>=20
> > The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f=
1bd8:
> >=20
> >   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> >=20
> > are available in the Git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-=
rtc-v5.13
> >=20
> > for you to fetch changes up to 80629611215d1c5d52ed3cf723fd6d24a5872504:
> >=20
> >   MAINTAINERS: Add entry for Netronix embedded controller (2021-03-01 1=
0:26:17 +0000)
> >=20
> > ----------------------------------------------------------------
> > Immutable branch between MFD, PWM and RTC due for the v5.13 merge window
> >=20
> > ----------------------------------------------------------------
> > [...]
>=20
> FYI, if anyone has pulled this, they should probably rebase it onto
> v5.12-rc2 and delete the v5.12-rc1 tag from their tree:
>=20
>   https://lwn.net/Articles/848431/

I'm not directly affected, but I wonder: The idea of an immutable branch
is that the same history gets included in different trees. If now each
maintainer rebases individually the result isn't the same
history any more in each tree which somewhat defeats the idea of using
immutable branches.

IMHO there are two ways forward: Either someone (Lee again?) creates a
new pull request for this series rebased on -rc2; or we accept that
these few patches are based on -rc1. For the latter it would be
beneficial to merge the tag into a tree that is already based on -rc2.

Currently this branch makes it into next only via mfd[1].

A little bit of statistics for the interested: Between the broken commit
48d15436fde6 and its fix (caf6912f3f4a) there are 655 commits that are
broken (git rev-list --ancestry-path 48d15436fde6..caf6912f3f4a | wc
-l). We won't get rid of these. (Well unless Linus descides to rewrite
history which would surprise me.)

In current next (b01d57bfdc41c8f635b08b8a5af8a31217d46936) there are
3244 commits that include the broken commit 48d15436fde6
(git rev-list --ancestry-path 48d15436fde6..next/master | wc -l) and
only 1411 of them also include the fix
(git rev-list --ancestry-path caf6912f3f4a..next/master | wc -l). So
next currently introduces 3244 - 1411 - 655 =3D 1178 additional broken
commits. My feeling is that unless this number goes down considerably,
we don't have to recourse to special measures to fix the 6 commits in
this pull request and merging it based on -rc1-dontuse should be fine.

A list of merges into next that contain the problematic commit but not
its fix can be generated using

git rev-list --merges --first-parent linus/master..next/master |=20
while read c; do=20
	if git merge-base --is-ancestor 48d15436fde6 $c^2 && ! git merge-base --is=
-ancestor caf6912f3f4a $c^2; then
		git show -s --pretty=3Doneline "$c";
	fi;
done | nl

It currently shows 37 merges.

Best regards
Uwe

[1] git rev-list --merges --first-parent 80629611215d1c5d52ed3cf723fd6d24a5=
872504..next/master  | while read c; do if  git merge-base --is-ancestor 80=
629611215d1c5d52ed3cf723fd6d24a5872504 $c^2; then git show -s --pretty=3Don=
eline "$c"; fi; done


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r3r3tpixs7nevo2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBIsAwACgkQwfwUeK3K
7Ak/GQf/UTCav/0l0GHkJwcggTh+NVobxUxgiaQuNTXdzaFjuPWSe5CWhXzYWFcZ
G06E5h2wfNxQbo839jZMcujCZ7MjPAnPUGNIemLn8on7j6Xs6l4hTruOx4n6OFuA
seDHTHq81atFsHGYzILkm+JHZBUdTRYVaC1uCx2jGP1jUgwvRtSO0xAVCUg6jYrq
yH7a5Xr+oPZwFhpeDYjSTftyCB3DvsV+dNfb1Voetl3vxHUmL3XHW2EwMwOE5Zs/
oEDQc2QZA6RLfK6zgOO+y8fwzBIo3Sqb98rc9K7+d5GIzxsQ/8oDt3nCKGSb12Te
6ZPMymagwG9Cko+7viVVmzi052SWeg==
=Zd02
-----END PGP SIGNATURE-----

--r3r3tpixs7nevo2h--
