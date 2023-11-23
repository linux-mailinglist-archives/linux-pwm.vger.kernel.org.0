Return-Path: <linux-pwm+bounces-175-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DA7F6493
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E575FB20F99
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DA322319;
	Thu, 23 Nov 2023 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47444D48
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 08:58:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6D2J-0006H2-5h; Thu, 23 Nov 2023 17:58:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6D2I-00B55v-NY; Thu, 23 Nov 2023 17:58:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6D2I-006p3p-EP; Thu, 23 Nov 2023 17:58:42 +0100
Date: Thu, 23 Nov 2023 17:58:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 0/4] Improve pwm-ir-tx precision
Message-ID: <20231123165842.ubmhifvtqd7g6jy6@pengutronix.de>
References: <cover.1700323916.git.sean@mess.org>
 <ZV3BJ67_JCpTYEMl@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lhq35gjz426k7cq"
Content-Disposition: inline
In-Reply-To: <ZV3BJ67_JCpTYEMl@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--2lhq35gjz426k7cq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 22, 2023 at 08:51:51AM +0000, Sean Young wrote:
> On Sat, Nov 18, 2023 at 04:16:16PM +0000, Sean Young wrote:
> > The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> > from delays as this is done in process context. Make this work in atomic
> > context.
>=20
> Hi Uwe,
>=20
> Do you have any comments on this series?
>=20
> I hope you don't dislike the pwm_apply_atomic()/pwm_apply_cansleep(), I am
> not wedded to this name, it's just me reading the room and thinking that
> would be the most acceptable to everyone - I may have misread this.
>=20
> Thank you for any feedback

I didn't find much time to look into it. Skimming over it, I like it.
I'll take a deeper look soon.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2lhq35gjz426k7cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVfhMEACgkQj4D7WH0S
/k5VjQf/RXq2YwJVvkqbzmIbWkFY8/xy8v7UkG2WxHRig/EYkTRvU3jMLR5A2uU/
B8me7fmfpocgDwGDcQjIQReckZs25ugows+NXe4xPyNwhS3OhTjOQ/yHOsrDr55Y
OmMWF8ynfifLwS85okR7cittck6EYPF5wATXaNrBM53BWaaZKSWe2cuGeKTj0U0o
dQAzySGhNEYzwwbmxqGpmLrNuG03AjLsjPw8w6zmydoGNkOYG0gNcel40mHrYCp1
L305kwhc+r+S5eK8RykXKvgRes8zLx3tdhRAwK1cYAwWCVBrzk6TjFxpSYb2L6fy
vM1kOKD/m2cpHYbWCzxo5hmlpKuQ7w==
=YZwi
-----END PGP SIGNATURE-----

--2lhq35gjz426k7cq--

