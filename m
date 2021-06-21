Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18223AE381
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jun 2021 08:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFUGuD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Jun 2021 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFUGuD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jun 2021 02:50:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67221C061574
        for <linux-pwm@vger.kernel.org>; Sun, 20 Jun 2021 23:47:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvDik-00050F-HA; Mon, 21 Jun 2021 08:47:46 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvDij-0005ts-Uo; Mon, 21 Jun 2021 08:47:45 +0200
Date:   Mon, 21 Jun 2021 08:47:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: PWM-Patches for next merge window [Was: Re: [PATCH 1/4] pwm: core:
 Support new usage_power setting in PWM] state
Message-ID: <20210621064745.v7ndjlybjav7ai6y@pengutronix.de>
References: <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
 <YLn3MZ+6HJM/UrRT@orome.fritz.box>
 <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
 <YL4vzvznTzqih0pA@orome.fritz.box>
 <20210607185158.jweahkoa3cxwl2nh@pengutronix.de>
 <20210609204144.nkksqjovs2yqfiyo@pengutronix.de>
 <YMIPjGtYfby6ZXKl@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dp2gsenshcsom644"
Content-Disposition: inline
In-Reply-To: <YMIPjGtYfby6ZXKl@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dp2gsenshcsom644
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Jun 10, 2021 at 03:11:40PM +0200, Thierry Reding wrote:
> On Wed, Jun 09, 2021 at 10:41:44PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 07, 2021 at 08:51:58PM +0200, Uwe Kleine-K=F6nig wrote:
> > > My problem is not that in the end a solution is picked that wasn't my
> > > favourite. My problem is that I have the impression my arguments were
> > > not considered but simply ignored.
> >=20
> > Another thing that annoys me is that there are currently ~20 open
> > patches by me in patchwork, most of them are easy to understand cleanups
> > and fixes, most of them are older than Clemens' series and most of them
> > are uncommented by you. And in this situation you apply the only
> > controversial series.
>=20
> Clemens' series is actually older than those cleanups because it's been
> in the works for many months now. And the reason why I'm prioritizing
> Clemens' series is because it has broader impact and I want to make sure
> it gets maximum soaking time in linux-next.

Hmm, I would have done that differently, but I don't expect that you
expected agreement from my side.

> Small fixes and cleanups are less likely to break things, so I'm going
> to apply them after.

I wonder what's the ideal delay for fixes and cleanups in your book.
We're two weeks after merging that high-impact patch series and Linus
just released -rc7.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dp2gsenshcsom644
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDQNg4ACgkQwfwUeK3K
7Am8nAf7Bzs6QcV90BnqHaYOhsE9mYovFgnpn6cTTu5bNlJsOKT6o6LpKfxoSQ+X
GikWnDbnIblvg/0AvwkJDesUea8IFdiHDRPiXy3PH4ojfmzIFnGEe2DowW+8uV05
y1MWXK1KsK288q7lp9Cf9vUcIiadUItLmC/LASV8056+rwy/S2uk3sqiIQo55Q7m
ymJbKwYtw5ILGkWLQFtohg3p0lvn4JkCYz4WWH5RdoUzOAxoSfj65aBRjxPAYJl5
g4XvsW8Q6Z3aBAPG0ueJPkwR4OTVGSt7/OR2CDAXvjArUzlWS5zSKJHfxC3FZCQh
LL9KUiBSzvFVl+EAfgLHCCInVsbt9w==
=uCza
-----END PGP SIGNATURE-----

--dp2gsenshcsom644--
