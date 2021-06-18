Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87363AC5F4
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jun 2021 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhFRI00 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Jun 2021 04:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhFRI0Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Jun 2021 04:26:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE48C061574
        for <linux-pwm@vger.kernel.org>; Fri, 18 Jun 2021 01:24:16 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lu9nT-0002xd-2x; Fri, 18 Jun 2021 10:24:15 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lu9nS-0003cp-GD; Fri, 18 Jun 2021 10:24:14 +0200
Date:   Fri, 18 Jun 2021 10:24:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     helpdesk@kernel.org, kernel@pengutronix.de
Subject: linux-pwm Archives on lore.kernel.org incomplete
Message-ID: <20210618082411.hojl5hedrgx3tsmy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyh5rdttu3ax7x5w"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lyh5rdttu3ax7x5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

for a recent discussion I wanted to point out an old mail thread on this
list and I noticed that it is missing in the archives on
lore.kernel.org.

So I cloned the linux-pwm public-inbox from lore and did:

	cd git/0.git
	git rev-list HEAD | while read rev; do git cat-file blob $rev:m | formail =
-z -c -x Message-Id; done > ~/tmp/linux-pwm-known-ids.txt
	list-archive-maker.py -s ~/Maildir-work/.lists.linux-pwm/ -e linux-pwm -k =
linux-pwm-known-ids.txt -l linux-pwm.vger.kernel.org

which found 400+ mails missing, some of them are spam, but a
considerable amount isn't.

I'd like to complete the archives, but I'm for sure not the oldest
subscriber. So it would be great if you could check your archives for
further missing mail.

Just follow the instructions on this page:
https://korg.wiki.kernel.org/userdoc/lore

The list of message-ids that I already have is available at
https://www.kleine-koenig.org/~uwe/linux-pwm-known-ids.txt . You'll need
that during the archive sanitization process to pass to the -k switch.

Please tar up and xz -9 the resulting directory with mbox files and send
the archive to me (preferably via some download link, but mail should
work, too, I suggest to not send it to the list though) so I can add it
to what I already have. I will then talk the the kernel.org admins to
add these mails to the archive.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lyh5rdttu3ax7x5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDMWCgACgkQwfwUeK3K
7AnL1gf9GQnLpnTrBClXDvzLEQ6OPpxCD+uFOA3lKgbikNUaVzpcKcjwIObepydA
LtC+JM1qNjerhsnXwaYPH/8BQMtIdQdnC2oZZAjf0qxV8TyJm24h1/jmnfTNUV/3
361SpFw/9LNzBA/KAWvUVAYmVFJAixq8DvPSWV62oS8f7BGngA9NjlyeC4cfkYGr
usyOT5VfN0lCKVEO+Ok8kwJEAhCQ1ErRUfC6upNHldYkq03YX8D4GX0g/5yaqWDO
cT/ATgwPl7Jzd2Br/HciArUi3gcjkWp1X5rTqonrhtDhGUQ9JVx1euMBNyQxLKdQ
SvgnPg572YlJqv8O771GVsPJt4nocw==
=4cNu
-----END PGP SIGNATURE-----

--lyh5rdttu3ax7x5w--
