Return-Path: <linux-pwm+bounces-513-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF680D0E4
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 17:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4331C2156A
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE204C61B;
	Mon, 11 Dec 2023 16:15:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9DBF
	for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 08:15:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCiwh-0007WX-Ug; Mon, 11 Dec 2023 17:15:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCiwh-00F8m8-Dy; Mon, 11 Dec 2023 17:15:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rCiwh-0011uN-4u; Mon, 11 Dec 2023 17:15:51 +0100
Date: Mon, 11 Dec 2023 17:15:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [GIT PULL] pwm fixes for 6.7-rc5
Message-ID: <20231211161550.vz4g3f746nci7lma@pengutronix.de>
References: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
 <ZXMzFVphyrcG8r9H@orome.fritz.box>
 <20231208181503.cjlajo3y5xc3vlqv@pengutronix.de>
 <ZXbmPLlc3dJ9TyVx@orome.fritz.box>
 <20231211160730.6464spg5bjouaw4m@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otuyr5ps44n6n6ks"
Content-Disposition: inline
In-Reply-To: <20231211160730.6464spg5bjouaw4m@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--otuyr5ps44n6n6ks
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Dec 11, 2023 at 05:07:30PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 11, 2023 at 11:36:44AM +0100, Thierry Reding wrote:
> > On Fri, Dec 08, 2023 at 07:15:03PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Fri, Dec 08, 2023 at 04:15:33PM +0100, Thierry Reding wrote:
> > > > On Fri, Dec 08, 2023 at 03:02:53PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > > [...]
> > > > >=20
> > > > > Please pull this as a fix for the next -rc release.
> > > >=20
> > > > I don't know why you didn't let me know about your plans to send th=
is
> > > > out. We should've at least discussed this.
> > >=20
> > > I tried to discuss that but didn't get any response. I pointed out in
> > > two mails[1] that I think this should go in before 6.7 and I announced
> > > this PR last week[2]. Also you usually ignore me on irc.
> >=20
> > I'm no longer able to keep up with IRC, sorry. Email is the most
> > reliable way for me to communicate, although obviously that also doesn't
> > work all the time since I missed that last email from you where you
> > "announced" that you were going to send a PR.

One point I forgot to mention: As you seem to have noticed the two
earlier mails about this fix: A simple "I'll care for that" in reply to
one of them would have been nice.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--otuyr5ps44n6n6ks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV3NbYACgkQj4D7WH0S
/k7hZQf4jvE8vGEGzVqKbr1jDNTor4Tuh8zmZ53LPah8CjohzcMu49UYQWjcPLlY
fWT8745+wy0YoBPZoEK/ML+92GNnpdjx7VoRQlK6PFF3fHK6VNEhFWUSFVQ50TbX
DutFdt7Uda8I5B+QfFvmfWypFnra40l2r7yfSFv/R2GvzoEkZJMReXYUYu/9iHmi
WhHowNuVeNyKBdTA3N80VEZzDl6ZjsGLzqomRNDV2QtBQ5gJRZ9I+HmtDYShp0om
zSte1nZdbCkdewJCat8e8gZjXMBH6vt5+VP4kc0QX+zl5BovCqbWXJUgInnxhuy/
TlQJgjoiTNxyDlFpqSocTpov2fgI
=KBiA
-----END PGP SIGNATURE-----

--otuyr5ps44n6n6ks--

