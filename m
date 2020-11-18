Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B717B2B7AA7
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 10:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKRJuc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 04:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgKRJub (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 04:50:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884E2C0613D4
        for <linux-pwm@vger.kernel.org>; Wed, 18 Nov 2020 01:50:31 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK6f-00031y-A8; Wed, 18 Nov 2020 10:50:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kfK6e-0007zn-Gs; Wed, 18 Nov 2020 10:50:28 +0100
Date:   Wed, 18 Nov 2020 10:50:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Soham Biswas <sohambiswas41@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, thierry.reding@gmail.com,
        Joe Perches <joe@perches.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: core: Use octal permission
Message-ID: <20201118095026.rehosqupefcebe77@pengutronix.de>
References: <20201117175452.26914-1-sohambiswas41@gmail.com>
 <20201117181214.GK1869941@dell>
 <CAMmt7eO5te05AuVC+MR-zLB-z+r9FCuJwtON=1QXXY2YwQG0eg@mail.gmail.com>
 <20201118085113.GO1869941@dell>
 <20201118093506.srljfosnamxe5wwz@pengutronix.de>
 <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvlf4a3jhtx76ztv"
Content-Disposition: inline
In-Reply-To: <ebe315dae8855ed2c55d6ce48f84aa4edd93e5fd.camel@perches.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kvlf4a3jhtx76ztv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 01:41:31AM -0800, Joe Perches wrote:
> On Wed, 2020-11-18 at 10:35 +0100, Uwe Kleine-K=F6nig wrote:
>=20
> > Actually I'd prefer keeping the symbolic name because this is easier to
> > grep for. So to convince me a better reason than "checkpatch says so" is
> > needed.
>=20
> https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7=
g21uMGQ@mail.gmail.com/
> -------------------------------------------------------------------
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 2 Aug 2016 16:58:29 -0400
>=20
> The symbolic names are good for the *other* bits (ie sticky bit, and
> the inode mode _type_ numbers etc), but for the permission bits, the
> symbolic names are just insane crap. Nobody sane should ever use them.
> Not in the kernel, not in user space.
>=20
>            Linus

OK, "Linus says so" is considerably stronger than "checkpatch says so".
So if you respin the patch with a better commit log, that's fine for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kvlf4a3jhtx76ztv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+07mAACgkQwfwUeK3K
7Anq6gf/aBPAhX7wPPXpxIUh1OwtKPHGMvK1Z6Gcvw05zm5hUiHV72mrKPenIfJh
Qdo0dXJW7oHVDrT0bM5U1A+ysNX0RsJVGgR8xvAVHPcC9TVklG+ZIYeE3tRmizBf
jztKCMkcGnpdx7lPO6ltsaVKWs7AqNN5I7/rCRXmb0TTXEaTGxujbpEuf07tkGB6
0p9CHdudR/Dw58qjBpgykBy9F0G6BzOz6En+kGb4wGRS0DVUFkN/Sfrb37+4pLR0
LpBR5ZPQV2eMvScpG7GTtGqBASU5t0fHCV55wa2LGKciOUCi3s80j3wP2YKwiuuj
bYv++oQMhUJrcD6OfoPcHuzgv/T3pQ==
=Ye7n
-----END PGP SIGNATURE-----

--kvlf4a3jhtx76ztv--
