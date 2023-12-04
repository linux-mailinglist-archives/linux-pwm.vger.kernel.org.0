Return-Path: <linux-pwm+bounces-280-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E7A803B31
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD0281032
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321E32E658;
	Mon,  4 Dec 2023 17:12:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8844ECE
	for <linux-pwm@vger.kernel.org>; Mon,  4 Dec 2023 09:12:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rACUr-0008FR-FW; Mon, 04 Dec 2023 18:12:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rACUr-00DZDG-0q; Mon, 04 Dec 2023 18:12:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rACUq-00EBIe-Nz; Mon, 04 Dec 2023 18:12:40 +0100
Date: Mon, 4 Dec 2023 18:12:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
	linux-mips@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: jz4740: Add trailing \n to error messages
Message-ID: <20231204171240.3gnvz3mghhz53cjj@pengutronix.de>
References: <20231123083322.405390-1-u.kleine-koenig@pengutronix.de>
 <ZWCaVQXjlBHMW8Jf@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5e5aqrtd3x4uevh2"
Content-Disposition: inline
In-Reply-To: <ZWCaVQXjlBHMW8Jf@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--5e5aqrtd3x4uevh2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 24, 2023 at 01:43:01PM +0100, Thierry Reding wrote:
> On Thu, Nov 23, 2023 at 09:33:23AM +0100, Uwe Kleine-K=F6nig wrote:
> > Error messages are supposed to end in \n. Add the line terminator to the
> > two error messages that lack this.
> >=20
> > Suggested-by: Paul Cercueil <paul@crapouillou.net>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > this was noticed by Paul in
> > https://lore.kernel.org/linux-pwm/ba21c20b20364a39d5ffff81dac8bd300a746=
dbb.camel@crapouillou.net.
> > Instead of sneaking this into a patch that probably won't get applied
> > quickly, make this explicit.
> >=20
> > I based it on top of my PR that can be found at
> > https://lore.kernel.org/linux-pwm/20231121112029.gyv3gqirlycysyr4@pengu=
tronix.de,
> > but applies just fine to v6.7-rc1.
> >=20
> > If you want a fixes-line, that would be:
> >=20
> > Fixes: 485b56f08f33 ("pwm: jz4740: Improve algorithm of clock calculati=
on")
> >=20
> > for the first hunk and
> >=20
> > Fixes: ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver")
> >=20
> > for the second. If this is backported to something before
> > v5.10-rc1~57^2~11, there is another instance with a missing \n.
> >=20
> > Best regards
> > Uwe
>=20
> My recollection is that the newlines aren't strictly required because
> printk will typically insert them itself (unless KERN_CONT is involved
> at some point). So I don't think this really fixes anything, but I'm
> willing to pick this up for consistency.

Well, they will behave if the next printk (on the same CPU?) doesn't use
KERN_CONT. So this change fixes a really unlikely race condition.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5e5aqrtd3x4uevh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVuCIcACgkQj4D7WH0S
/k4fUQf+JgcgbwtAzbnsGGxjCu0m+N5Y7/39rrWiFJEX+MiHD1wSke4kVGPE4DDO
h9myIG1MAoZAAYX1FYG5/fzCs9B0D0KdaG52chkejOQ9+0ZEGRvfaEfCLmJsUoM/
CRwhS95IiAbwuAVhQk0Qtn5KEBpIrIDUWyOdikVtXflTUQEu9N+vGFHyyL73uHXf
aLmEq01f2FK7Z1y7BRK8+BCN+jyygMKTFufDeMesSko8YrydO2PbZ8t8YIQxv8YT
zdX64t5osuGzZ0vCMgWBMjXWb6920Hi4x1OAAeKw8mU+3PvTPAJwDFmFlrWcThU0
3AdFt8Kyzo7XgGGy+odixBybDO3cCw==
=7t6b
-----END PGP SIGNATURE-----

--5e5aqrtd3x4uevh2--

