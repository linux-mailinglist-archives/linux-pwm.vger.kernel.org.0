Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C4D40AB8B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Sep 2021 12:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhINKVL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Sep 2021 06:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhINKVB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Sep 2021 06:21:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95234C061764
        for <linux-pwm@vger.kernel.org>; Tue, 14 Sep 2021 03:19:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ5XS-0001eP-Ke; Tue, 14 Sep 2021 12:19:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ5XR-0005tS-18; Tue, 14 Sep 2021 12:19:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ5XQ-0006WW-W9; Tue, 14 Sep 2021 12:19:41 +0200
Date:   Tue, 14 Sep 2021 12:19:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/7] pwm: ep93xx: Prepare clock before using it
Message-ID: <20210914101938.mo6puyhgp276jyu2@pengutronix.de>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
 <20210613233041.128961-8-alexander.sverdlin@gmail.com>
 <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
 <c2d54eb9c0061a779678e311ee6761fa6f117856.camel@gmail.com>
 <20210914075815.alqnyux5ficgvkme@pengutronix.de>
 <173088b768fbc1dbb49b6f53f7ac04a44f120f3a.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ai6jn7aao6nof6f"
Content-Disposition: inline
In-Reply-To: <173088b768fbc1dbb49b6f53f7ac04a44f120f3a.camel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4ai6jn7aao6nof6f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 14, 2021 at 12:15:14PM +0200, Alexander Sverdlin wrote:
> Thank you, Uwe,
>=20
> On Tue, 2021-09-14 at 09:58 +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Jun 14, 2021 at 01:30:41AM +0200, Alexander Sverdlin wrote:
> > > > > Use clk_prepare_enable()/clk_disable_unprepare() in preparation f=
or switch
> > > > > to Common Clock Framework.
> > > > >=20
> > > > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > >=20
> > > > Maybe it would make sense to move the prepare into the probe functi=
on?!
> > > > Anyhow, for now preparing the driver for the common-clk switch is t=
he
> > > > focus and for that the conversion is correct, so:
> > > >=20
> > > > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > >=20
> > > would you take this patch only, please?
> > > It didn't work out to sell the whole series as one piece and
> > > most of them were taken individually...
> >=20
> > Hmm, this patch is marked as accepted in patchwork
> > (http://patchwork.ozlabs.org/project/linux-pwm/patch/20210613233041.128=
961-8-alexander.sverdlin@gmail.com/).
> > There is also a v2, that is also marked as accepted
> > (http://patchwork.ozlabs.org/project/linux-pwm/patch/20210726140001.248=
20-8-nikita.shubin@maquefel.me/).
> >=20
> > Not sure what want wrong here
>=20
> Sorry for the noise!

No, it's no noise because I didn't see either of the versions in any
tree. So the patches were marked as applied without being applied ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4ai6jn7aao6nof6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFAdzcACgkQwfwUeK3K
7Ak95gf/e4GuqPSYxyaPLcf4oYhaTsoyeNdmlrlH8HYMu4hdRnvM5fWtKyCZHnYp
wNZrXq/rxSWAqrakpa4LTu0JCwS9uokSqgH42V6IHwne7pQBfAM4RhLLViwWQJr5
Bf1o5B+FTZ8BmD+ieH/FC4gbQLK8SiosH0VfkIe7zapN9lSblDLs9tFzsfgfs9jf
E0fiwPkmpfvaVNH+ln5+abaBzyQVsG2f4npPkpPd0FO8KsnXzbk2iSo/44Vn+tRL
UcBKW05y3lMhewtNSDKNCPlXw1LO36Ax8g3Ark/U+1CfBvIrAOKormHduXm+/a9Q
0MxKP9mbV5cSzYdpbVKOTAla0jtKWA==
=Och2
-----END PGP SIGNATURE-----

--4ai6jn7aao6nof6f--
