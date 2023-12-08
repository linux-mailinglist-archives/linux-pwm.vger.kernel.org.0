Return-Path: <linux-pwm+bounces-469-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136180ABD3
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 19:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6135E1C209BC
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1EB41C87;
	Fri,  8 Dec 2023 18:15:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063C133
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 10:15:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBfNQ-00007E-6C; Fri, 08 Dec 2023 19:15:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBfNP-00ETWp-HM; Fri, 08 Dec 2023 19:15:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rBfNP-00GXj7-7r; Fri, 08 Dec 2023 19:15:03 +0100
Date: Fri, 8 Dec 2023 19:15:03 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [GIT PULL] pwm fixes for 6.7-rc5
Message-ID: <20231208181503.cjlajo3y5xc3vlqv@pengutronix.de>
References: <20231208140253.m6lpundvnvtfsloh@pengutronix.de>
 <ZXMzFVphyrcG8r9H@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gnhtjtriajzvd7xt"
Content-Disposition: inline
In-Reply-To: <ZXMzFVphyrcG8r9H@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--gnhtjtriajzvd7xt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Dec 08, 2023 at 04:15:33PM +0100, Thierry Reding wrote:
> On Fri, Dec 08, 2023 at 03:02:53PM +0100, Uwe Kleine-K=F6nig wrote:
> > [...]
> >=20
> > Please pull this as a fix for the next -rc release.
>=20
> I don't know why you didn't let me know about your plans to send this
> out. We should've at least discussed this.

I tried to discuss that but didn't get any response. I pointed out in
two mails[1] that I think this should go in before 6.7 and I announced
this PR last week[2]. Also you usually ignore me on irc.

So I don't think "you didn't let me know" is a fair suggestion and I
honestly don't know what I should do better next time.

Given your reply might confuse Linus about what to do with my PR: Do you
agree this bcm2835-pwm fix should go in before 6.7?

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20231128205548.hfvknhimerqdunpx@pengu=
tronix.de/
    https://lore.kernel.org/linux-pwm/20231121112029.gyv3gqirlycysyr4@pengu=
tronix.de/
[2] https://lore.kernel.org/linux-pwm/20231130061353.65nfjd7uwbpiswv2@pengu=
tronix.de/

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gnhtjtriajzvd7xt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVzXSYACgkQj4D7WH0S
/k6p2Af/QPcSHB7P7iw1aL7QvHsISZTfDI0Lt0RUPaUm/0x29ff+hWDHNZOglxDg
ZuTa/dJY4UXftLbcs0HiQK1kAaYvOTqWXrkFbO3lmvZb8E/2a70cQM+SU9eYPXu7
43H69BgXPDklUCA7xHVQM0PsSMiSvWgIYb+uNh1dESKeVmDsWHNaVOX8z73jQHmn
OLvTgQG7CY5NiSJKkQxSAOmPFpsgldxIXWa8lkhQXtIBA54114BK/J0dH5vcF4es
KKfYeHi68VjzT4am5YkBl3NRt7o9CuwWriHfs7+/MI/AwZ02nwQGulYFw207Jo8M
yG5lHYAqg1nmWTBRjyl0zw6kGvu5pA==
=n9x0
-----END PGP SIGNATURE-----

--gnhtjtriajzvd7xt--

