Return-Path: <linux-pwm+bounces-775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0182CA7D
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jan 2024 09:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429B8B2282A
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jan 2024 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3651865A;
	Sat, 13 Jan 2024 08:27:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F47168C2
	for <linux-pwm@vger.kernel.org>; Sat, 13 Jan 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZM0-0000a3-FZ; Sat, 13 Jan 2024 09:26:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZLz-002KQ5-Mc; Sat, 13 Jan 2024 09:26:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZLz-008lyp-1y;
	Sat, 13 Jan 2024 09:26:55 +0100
Date: Sat, 13 Jan 2024 09:26:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-mips@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH] pwm: jz4740: Don't use dev_err_probe() in .request()
Message-ID: <pwjhf6humll7vgpny5bwstbmgkqqm5rgxcj7xvfi6xcz74o32l@l2iktgudl6ow>
References: <20240106141302.1253365-2-u.kleine-koenig@pengutronix.de>
 <8e18487f-7190-425d-b2c9-4877c1db8535@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aw7d7ueqwina3lqx"
Content-Disposition: inline
In-Reply-To: <8e18487f-7190-425d-b2c9-4877c1db8535@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--aw7d7ueqwina3lqx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jan 06, 2024 at 06:20:44PM +0100, Krzysztof Kozlowski wrote:
> On 06/01/2024 15:13, Uwe Kleine-K=F6nig wrote:
> > dev_err_probe() is only supposed to be used in probe functions. While it
> > probably doesn't hurt, both the EPROBE_DEFER handling and calling
> > device_set_deferred_probe_reason() are conceptually wrong in the request
> > callback. So replace the call by dev_err() and a separate return
> > statement.
> >=20
> > This effectively reverts commit c0bfe9606e03 ("pwm: jz4740: Simplify
> > with dev_err_probe()").
>=20
> Too much automation :(
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I added that patch to my for-next branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with the intention to send it for inclusion in 6.8-rc after being in
next for a few days.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aw7d7ueqwina3lqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWiSUsACgkQj4D7WH0S
/k6oowf9FQSjMKMTKZk20J7Auejec3JaRw4nlkfu0ZRMJ9cKJFMecW7WC8vau8dd
BaravwM07CG0O4vWHfdHt0tI40Nq5aVPvOnir4G4F8Fk4RHen1q14nnxTU8yRHpZ
ZSiivUa4MghfqlMtrRcpt/NWk9Jt6CprVP7DoDrEwblgfMTEIsHZL+OHP7cAald5
GJB0r8HXYFKe5er1n3s5ChOymDoU7atFmtJj+6xbnVpWN9y3vsF2aQUcHT/oIlsz
D4cVqmmhUWQH03xdqW2NsryM4mZ3fCo3EOU7yPBcylm1fbcI8p8CP+23x5FcAR1i
cPNGtEq4u3vwS6iQ2gY5J0Vzw3D7DQ==
=FMYR
-----END PGP SIGNATURE-----

--aw7d7ueqwina3lqx--

