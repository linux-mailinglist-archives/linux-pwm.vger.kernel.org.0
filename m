Return-Path: <linux-pwm+bounces-157-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A1C7F53B0
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 23:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77241C208D3
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 22:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF51D52F;
	Wed, 22 Nov 2023 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F4A4
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 14:48:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5w1B-0000B4-U8; Wed, 22 Nov 2023 23:48:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5w1B-00AuMP-54; Wed, 22 Nov 2023 23:48:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5w1A-0064oh-Ru; Wed, 22 Nov 2023 23:48:24 +0100
Date: Wed, 22 Nov 2023 23:48:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pwm@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 070/108] pwm: microchip-core: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231122224824.ar7p5avoahcc737c@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-71-u.kleine-koenig@pengutronix.de>
 <20231122-endanger-extenuate-97ef77b117da@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aozsxgemqxos4exo"
Content-Disposition: inline
In-Reply-To: <20231122-endanger-extenuate-97ef77b117da@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--aozsxgemqxos4exo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Wed, Nov 22, 2023 at 11:14:21AM +0000, Conor Dooley wrote:
> On Tue, Nov 21, 2023 at 02:50:12PM +0100, Uwe Kleine-K=F6nig wrote:
> > @@ -65,7 +64,7 @@ struct mchp_core_pwm_chip {
> > =20
> >  static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_c=
hip *chip)
> >  {
> > -	return container_of(chip, struct mchp_core_pwm_chip, chip);
> > +	return pwmchip_priv(chip);
> >  }
>=20
> I know this is likely a coccinelle job, but can we now delete things
> like to_mchp_core_pwm() if there's a standard helper for this now?

An upside of keeping this helper is that it yields the right type.
pwmchip_priv() returns a void *.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aozsxgemqxos4exo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVehTcACgkQj4D7WH0S
/k4sEQgAloBPZuZff4mYKJMDwBWh2FfgW5dNxrj6ZWelh56IRMsWWtWUJSrq7E56
OY6aW3qI/2vlbrsZ/nlCoX93nb+wyKAYN/m5MqRipjDcZr6RXEhAQhEFQu4JaG07
ksZPvzkCBgO0XdLx5g4KAYx7Y88Ip3P4NrmzOeJu1GnJx898sH4iFmsIwMl87cz6
ORqsyVOk4fJInd6I+pm9Y2pk5KtHfuVJkZlu/ElNso2wOLK3ca+pX1kW5DwI59IP
K7gmPTEIWzH38SXpjdhrjVMUoxeFWOPqKNjgBKJqt5gSsQjeZzFLAJF+jYfWUNTS
PLBeRZqgKIha/qSHqMPcbrCOUU2Rlw==
=eq0a
-----END PGP SIGNATURE-----

--aozsxgemqxos4exo--

