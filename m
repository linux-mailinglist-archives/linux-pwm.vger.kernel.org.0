Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D28219C1C
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgGIJ1D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgGIJ1B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 05:27:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99111C061A0B
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2020 02:27:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtSpX-0005D8-Oi; Thu, 09 Jul 2020 11:26:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtSpX-00081I-Ej; Thu, 09 Jul 2020 11:26:59 +0200
Date:   Thu, 9 Jul 2020 11:26:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     helpdesk@kernel.org
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: adding linux-pwm archives to lore.kernel.org?
Message-ID: <20200709092659.drrmvv53qs2q4lid@pengutronix.de>
References: <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o26seyou7yd2a6ok"
Content-Disposition: inline
In-Reply-To: <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--o26seyou7yd2a6ok
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Konstantin(?),

On Sat, Jun 13, 2020 at 04:15:33PM +0200, Uwe Kleine-K=F6nig wrote:
> On Sat, May 23, 2020 at 07:05:58PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Feb 13, 2020 at 11:26:18AM +0100, Uwe Kleine-K=F6nig wrote:
> > > I consider the archives on lore.kernel.org very useful and would like=
 to
> > > see the linux-pwm list archived there, too.
> > >=20
> > > Assuming you agree (or at least don't disagree) we'd need to follow
> > > https://korg.wiki.kernel.org/userdoc/lore. Therefor we need an archive
> > > of the already sent mails. My personal archive only goes back to Oct
> > > 2018, so I guess I'm not in the best position to provide it. But I can
> > > nevertheless care for the buerocratics and start with my archive given
> > > that I get some support from someone with a more complete archive.
> > >=20
> > > What do you think?
> >=20
> > I didn't get feedback from Thierry (=3D linux-pwm maintainer) but I sti=
ll
> > think adding linux-pwm to kernel.org's public-inbox instance is
> > valuable. (And if it's only to experiment with b4.)
>=20
> In the meantime Thierry said to support the idea to get the linux-pwm
> list archived on lore.kernel.org and also provide his archive for the
> initial population.
>=20
> I assume you're OK in principle to archive linux-pwm and it's "just" a
> matter of lacking time to work on getting this list up and running on
> lore.k.o? Is there anything we can do to simplify the things for you?

Do you get my mail? Is there some problem with the request, or is it
just -ENOTIME on your end? Would it help to already initialize a public
inbox v2 repository?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o26seyou7yd2a6ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8G4uAACgkQwfwUeK3K
7Al2Owf/REEfznnztjezLkSak6qJh+RDZfu8Z5+h4L64XAorWLubWg2yaLMqow5R
tbpGtUzwXC7uYk21+xwzGe8BkFnPpkv+zS8nxsxLG6Onvg5SujWWe/8io0buPgub
u7XAtgIL3LC4YGsM8HxDuXakcczyXaCo2HcE7HfOiJlwuQiaB4pc/dxq5dkd1K12
cf92uEabMjhZB09x7c412vBBBlt6/eOAYDqvy+us+j80pdF4XWWP01f5rN5m+B+J
MmHgf7rwgA6mqGnZepn9AZM7i2GWtu23nDf9zsxKZLLu1i2O9HOFJBfcCDTf5/W7
XaShR2JTuo4J0mQjK7crBU7TJsAszw==
=e6Cb
-----END PGP SIGNATURE-----

--o26seyou7yd2a6ok--
