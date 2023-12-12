Return-Path: <linux-pwm+bounces-530-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AEE80EA6B
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 12:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179CF1F213A6
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887225D49C;
	Tue, 12 Dec 2023 11:31:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A11ED3
	for <linux-pwm@vger.kernel.org>; Tue, 12 Dec 2023 03:31:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD0yi-00040o-6c; Tue, 12 Dec 2023 12:31:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD0yh-00FKF9-JA; Tue, 12 Dec 2023 12:31:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD0yh-001b0d-A2; Tue, 12 Dec 2023 12:31:07 +0100
Date: Tue, 12 Dec 2023 12:31:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] pwm: Replace ENOTSUPP with EOPNOTSUPP
Message-ID: <20231212113107.4yykyuptc7zz7lzp@pengutronix.de>
References: <cover.1702369869.git.sean@mess.org>
 <af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="einuuad7epqbrnz6"
Content-Disposition: inline
In-Reply-To: <af5b2e8ac6695383111328267a689bcf1c0ecdb1.1702369869.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--einuuad7epqbrnz6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 08:34:01AM +0000, Sean Young wrote:
> ENOTSUPP is not a standard error code and should be avoided.

I'd write:

	According to Documentation/dev-tools/checkpatch.rst ENOTSUPP is
	not recommended and EOPNOTSUPP should be used instead.

to give the sentence a bit of authority.

Other than that I'm fine with the change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--einuuad7epqbrnz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4RHoACgkQj4D7WH0S
/k6GBQf/XgiUjmr+wovqNyanDNWjL+x5SDSVzmAtyOhfCPCk4FLDLxeVZLV34aTi
d43qNyiIzdMcXYfn5BfrPwpQP/yYDkD26cZwDScqrtbVe8XBwP5wJMuoL4x9HwlO
J21gnxysAfYhqZCtilGOiMqJy1ixjByrEr4wR8MDGMtvguCnb1LgMw/zIvtRAC0A
VrU6nhr0AQZ6d8Av7Wi9KHyoJ7ylgi/8T4TPZcHO3QPIH98MbVDiqTXv619+0Osg
kAL5wAJ7Qp+1GgmcvaUFBnr53iBAhsWY/EKOCuSAxosLEPpGbOdmePCWN97uyArl
CvBMWfzpNKt4fvOdQLdKveefWnS+EQ==
=t4xt
-----END PGP SIGNATURE-----

--einuuad7epqbrnz6--

