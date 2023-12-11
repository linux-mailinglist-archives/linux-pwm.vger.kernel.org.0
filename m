Return-Path: <linux-pwm+bounces-512-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E4C80D088
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 17:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F931C208FF
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE0C4C3C4;
	Mon, 11 Dec 2023 16:07:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A31C196
	for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 08:07:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCioj-0005Ze-Fm; Mon, 11 Dec 2023 17:07:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCioi-00F8lB-FC; Mon, 11 Dec 2023 17:07:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCioi-0011id-60; Mon, 11 Dec 2023 17:07:36 +0100
Date: Mon, 11 Dec 2023 17:07:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de
Subject: Re: [GIT PULL] pwm fixes for 6.7-rc5
Message-ID: <20231211160730.6464spg5bjouaw4m@pengutronix.de>
References: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
 <ZXMzFVphyrcG8r9H@orome.fritz.box>
 <20231208181503.cjlajo3y5xc3vlqv@pengutronix.de>
 <ZXbmPLlc3dJ9TyVx@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umurbqcqvqos4jtp"
Content-Disposition: inline
In-Reply-To: <ZXbmPLlc3dJ9TyVx@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--umurbqcqvqos4jtp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Dec 11, 2023 at 11:36:44AM +0100, Thierry Reding wrote:
> On Fri, Dec 08, 2023 at 07:15:03PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 08, 2023 at 04:15:33PM +0100, Thierry Reding wrote:
> > > On Fri, Dec 08, 2023 at 03:02:53PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > [...]
> > > >=20
> > > > Please pull this as a fix for the next -rc release.
> > >=20
> > > I don't know why you didn't let me know about your plans to send this
> > > out. We should've at least discussed this.
> >=20
> > I tried to discuss that but didn't get any response. I pointed out in
> > two mails[1] that I think this should go in before 6.7 and I announced
> > this PR last week[2]. Also you usually ignore me on irc.
>=20
> I'm no longer able to keep up with IRC, sorry. Email is the most
> reliable way for me to communicate, although obviously that also doesn't
> work all the time since I missed that last email from you where you
> "announced" that you were going to send a PR.
>=20
> > So I don't think "you didn't let me know" is a fair suggestion and I
> > honestly don't know what I should do better next time.
> >=20
> > Given your reply might confuse Linus about what to do with my PR: Do you
> > agree this bcm2835-pwm fix should go in before 6.7?
>=20
> Of course it should go into 6.7 and it would've gone in. I usually pick
> patches up into linux-next first because that's what most people will
> end up running and where they will first notice when it's been taken
> care of.

Getting a commit into Linus's tree makes it appear in next, too. Then
people who have sent a fix will notice that it's been taken care of in a
suitable manner.

> Then I will typically try to batch things up and will usually
> wait until around -rc6 before sending this type of trivial fix to avoid
> sending multiple PRs for simple one-line fixes like this.

In my book it's wrong to delay a fix of a null pointer dereference that
is known since one day after -rc1 until -rc6. And for me being trivial
is another reason to not delay it.

Also batching fixes for pwm seems a bit pointless to me. Looking at the
commits to drivers/pwm that were applied out of a merge window I
found:

 - v6.3-rc6~21^2~6..v6.3-rc6~21^2
   6 commits from a single series

 - v5.14-rc2~22^2~5..v5.14-rc2~22^2
   5 commits from a single series

 - v5.10-rc7~24
   a single commit

 - v5.4-rc7~18^2
   a single commit

 - v5.4-rc6~4^2
   a single commit

 - v5.3-rc4~28^2
   a single commit

 - Some SPDX changes around v5.2 that didn't go in via the pwm tree

 - v4.11-rc7~28^2~3..v4.11-rc7~28^2
   three independent commits. I wonder about the third one, looks like
   an accident that shouldn't have go in at that point

 - v4.9-rc8~16^2~2..v4.9-rc8~16^2
   two commits
   According to the date stamp of the older of the two, it was sent
   before 4.8-rc6, so that one should probably have go in before
   v4.9-rc1.

 - v4.7-rc4~16^2~3..v4.7-rc4~16^2
   three independent commits

 - v4.6-rc4~17^2
   a single commit

 - v4.1-rc5~25^2
   a single commit

 - v3.18-rc2~21^2~18..v3.18-rc2~21^2
   a late merge of the -rc1 PR

 - v3.15-rc2~16^2~7
   not merged via pwm

 - v3.14-rc5~18^2
   a single commit

 - v3.10-rc2~8^2~18
   a single commit

 - v3.6-rc3~4^2
   Several commits after the pwm framework was introduced in v3.6-rc1

So after the first release containing the pwm framework the pwm
subsystem doesn't seem to be prone to many fixes where batching saves
relevant overhead. I rather prefer to have fixes go in in a timely
manner in the earliest -rc possible such that they stand to profit from
the stabilisation period before a release. (What would -rc2 to -rc5 be
good for otherwise?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--umurbqcqvqos4jtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV3M74ACgkQj4D7WH0S
/k7q3wgAg/HorS1uQyrMiowYQVbo5WuowTj0yTvhldHteaTTY8t/ZJEla099m8Lu
AbtDJziy4jbciImODS3qcmQ2VTq7JYOAyv+PrPCA3QlUwRk6+oMEs4FQoa8JDc/w
aTSSAcDzcZmFEA5o73t3xbSf/67zzw9Zlw3vJ5Zg2/BrLG+rvtAmynPY5/0Fzj7e
BW5Irk0qok9jRJZYrgrndeCeqDbPXZevLLxmdPrAOXgzX2sKz4PW4wdlt5SCwUW/
x6NAngS0SXPtCT7HoWZuNjYjxXrMk6adbQyNko0NxNypZwgJvkGOtykweGhxdf0Y
QvHnJ7JNSohf393wNdTiTKD6FlTIUQ==
=CUUb
-----END PGP SIGNATURE-----

--umurbqcqvqos4jtp--

