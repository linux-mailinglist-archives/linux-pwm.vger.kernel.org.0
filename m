Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8D3AE676
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jun 2021 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhFUJuZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Jun 2021 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhFUJuY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jun 2021 05:50:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009BFC061574
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jun 2021 02:48:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvGXJ-0002i6-D7; Mon, 21 Jun 2021 11:48:09 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvGXJ-0002Go-1u; Mon, 21 Jun 2021 11:48:09 +0200
Date:   Mon, 21 Jun 2021 11:48:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     helpdesk@kernel.org
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: linux-pwm Archives on lore.kernel.org incomplete
Message-ID: <20210621094808.dhom6zuijdw2yqkg@pengutronix.de>
References: <20210618082411.hojl5hedrgx3tsmy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6y3jenn4evgw377"
Content-Disposition: inline
In-Reply-To: <20210618082411.hojl5hedrgx3tsmy@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y6y3jenn4evgw377
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 18, 2021 at 10:24:11AM +0200, Uwe Kleine-K=F6nig wrote:
> for a recent discussion I wanted to point out an old mail thread on this
> list and I noticed that it is missing in the archives on
> lore.kernel.org.
>=20
> So I cloned the linux-pwm public-inbox from lore and did:
>=20
> 	cd git/0.git
> 	git rev-list HEAD | while read rev; do git cat-file blob $rev:m | formai=
l -z -c -x Message-Id; done > ~/tmp/linux-pwm-known-ids.txt
> 	list-archive-maker.py -s ~/Maildir-work/.lists.linux-pwm/ -e linux-pwm -=
k linux-pwm-known-ids.txt -l linux-pwm.vger.kernel.org
>=20
> which found 400+ mails missing, some of them are spam, but a
> considerable amount isn't.
>=20
> I'd like to complete the archives, but I'm for sure not the oldest
> subscriber. So it would be great if you could check your archives for
> further missing mail.
>=20
> Just follow the instructions on this page:
> https://korg.wiki.kernel.org/userdoc/lore
>=20
> The list of message-ids that I already have is available at
> https://www.kleine-koenig.org/~uwe/linux-pwm-known-ids.txt . You'll need
> that during the archive sanitization process to pass to the -k switch.
>=20
> Please tar up and xz -9 the resulting directory with mbox files and send
> the archive to me (preferably via some download link, but mail should
> work, too, I suggest to not send it to the list though) so I can add it
> to what I already have. I will then talk the the kernel.org admins to
> add these mails to the archive.

I got a message-drop from Thierry which includes quite some more mail
and seems to cover the complete livetime of the linux-pwm list.
After sorting out spam I now identified a total of 1527 mails missing in
the linux-pwm archive:

$ notmuch-work search --output=3Dmessages List:linux-pwm.vger.kernel.org an=
d not tag:lore-linux-pwm | wc -l
1527

Assuming you are willing to feed these to lore.kernel.org: How should I
send you these mails? Should I include the spam mails and a list of
which mails I considered spam?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y6y3jenn4evgw377
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDQYFUACgkQwfwUeK3K
7AlEgAf+JbAIFRKXn98glJvrz74iY3NtTKQFdm3ykuFqVinmtwDSNNBZz6lNnUaK
8W3OBBqejXdiellpSTZ9c8aTQIyuEAJgyg89WHCWf04LOVKds7XCbMXPnyf3XVhu
UZf3id0ozzmkK9/mA3cqail3Xso4exEpwYUl/LAsTtOU1Wz5BiH5myPheSUgTTxU
ZkZZ03rQyRmP4xOyI8PGVNzYR5zS+GRnR8WGJA8iEDTu/e7FurnG+cPvHLyk/urU
s5XiBUkDNyfjbxmQka8dZKSr7/jvepOHOcOO5P3SxRxZI1zGMA53csfBTKyieceZ
WckeYEybTGjUMVxpIdub/awftekmdg==
=tKkV
-----END PGP SIGNATURE-----

--y6y3jenn4evgw377--
