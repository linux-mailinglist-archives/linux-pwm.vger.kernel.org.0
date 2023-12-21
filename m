Return-Path: <linux-pwm+bounces-594-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FFA81B241
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 10:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D22B27349
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E4A208B6;
	Thu, 21 Dec 2023 09:21:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91E1A71D
	for <linux-pwm@vger.kernel.org>; Thu, 21 Dec 2023 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGFFJ-0007aX-M2; Thu, 21 Dec 2023 10:21:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGFFH-000UZK-Pi; Thu, 21 Dec 2023 10:21:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGFFI-001NoA-JI; Thu, 21 Dec 2023 10:21:36 +0100
Date: Thu, 21 Dec 2023 10:21:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] MAINTAINERS: pwm: Thierry steps down, Uwe takes over
Message-ID: <6nj7rmq36hj5m26b7yhlbmpfps5wuxkx4zwyvttg4cpgocimj7@xtqm4qleo3s6>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
 <ZXbsDRslZNKCeJF9@orome.fritz.box>
 <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
 <ZXcpswXxb1oQldp5@orome.fritz.box>
 <20231212203352.wl3rzob75fct4lov@pengutronix.de>
 <ZYMPc50eBi6oBClu@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5o64rpghlrnmwvgo"
Content-Disposition: inline
In-Reply-To: <ZYMPc50eBi6oBClu@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--5o64rpghlrnmwvgo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's not easy to let go responsibility for a subsystem that one cared
for for a long time, but Thierry realized that his heart isn't in the
pwm framework any more.

Thierry cared for the pwm subsystem (commit 200efedd8766 ("pwm: Take
over maintainership of the PWM subsystem")) as a maintainer during
nearly 12 years. A big thanks for the time, effort and dedication spend
during that time.

Uwe takes over maintenance.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
Hello Thierry,

On Wed, Dec 20, 2023 at 04:59:47PM +0100, Thierry Reding wrote:
> On Tue, Dec 12, 2023 at 09:33:52PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Dec 11, 2023 at 04:24:35PM +0100, Thierry Reding wrote:
> > > It all adds up in the end and keeps me from doing other things.
> >=20
> > If that means you'd be glad to give up the PWM maintainer job, I'd
> > happily take over this post.
>=20
> "Glad" is not the word that I would choose. After all I've looked after
> this subsystem for almost 12 years, and letting it go isn't something
> that is particularly easy. However, I do realize that my heart isn't in
> it anymore and I don't want to be in the way of anyone.
>=20
> So I'll take you up on that offer. Do you want to send a patch?

Sure, here it comes.

I hesitated to remove you completely, but I guess you intended a clean
cut? Or would you prefer to stay as a reviewer?

Usually I would have added you to CREDITS, but as you will continue to
fill your various other responsibilities (I expect), this felt wrong.=20

Best regards
Uwe

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5342cf32d73f..16c6aa0ad1ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17561,12 +17561,11 @@ F:	Documentation/devicetree/bindings/leds/irled/p=
wm-ir-tx.yaml
 F:	drivers/media/rc/pwm-ir-tx.c
=20
 PWM SUBSYSTEM
-M:	Thierry Reding <thierry.reding@gmail.com>
-R:	Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
+M:	Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-=
pwm.git
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux-pwm.=
git
 F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
 F:	Documentation/devicetree/bindings/pwm/
 F:	Documentation/driver-api/pwm.rst

base-commit: 881791886bfa8e353c3203f95bfbaaeee25d2d50
--=20
2.42.0


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5o64rpghlrnmwvgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWEA58ACgkQj4D7WH0S
/k59/ggArCgJhP6eM/Mre5suPnAXldYCv+t6ejnV5um384hqZ58irLxQpTh0ERx+
Mu+ABYHXoM5W68M1VQY+6uBD5uq06Nk3Ejyr0HZ/soY6/JU4kXsZMBSbEUXzxqMP
5l767cOQCtPBUW2UCJMdrPOg0ho9m8UvnNEwARQxSPoT0tg9RdeFtK0Zrfyq3TMu
poDm+BrlTrwnMqD7KK9rp2YJW6mGw6IaDbXzpgpGmHUQ50HVOOLfrXoErZ1tB5ri
GqjzWoJPxybc3WMcfIaMbPx2V01V56npyy5O2dEqT/Rvpb+BGzjNGTOINg3OKum1
OyP5vz0v49o0ToqoFoEWAa4N8nIzyQ==
=kZaJ
-----END PGP SIGNATURE-----

--5o64rpghlrnmwvgo--

