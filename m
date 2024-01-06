Return-Path: <linux-pwm+bounces-681-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1C38260C2
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 17:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8B71C210A5
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6688BFD;
	Sat,  6 Jan 2024 16:58:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36745C8C3
	for <linux-pwm@vger.kernel.org>; Sat,  6 Jan 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM9za-0006Os-HC; Sat, 06 Jan 2024 17:57:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM9zZ-000qUr-JR; Sat, 06 Jan 2024 17:57:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM9zZ-0042J5-1d;
	Sat, 06 Jan 2024 17:57:49 +0100
Date: Sat, 6 Jan 2024 17:57:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	kernel@pengutronix.de, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: rockchip: Allow "interrupts" prooperty
Message-ID: <urivnhzvsrqanux2lvvp5aodtjt76jn5jmnoqnjw6ueqqgz5ld@2xyyvmmlsxjt>
References: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gopfpgmsl7hdmwp"
Content-Disposition: inline
In-Reply-To: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--7gopfpgmsl7hdmwp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

not sure who will pick this up. Whoever it does, please do

Subject ~=3D s/proop/prop/

on application.

Best regards,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7gopfpgmsl7hdmwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWZhowACgkQj4D7WH0S
/k6AgAf+IdovkJ77fbDI4QhGcZtxUmMzcNPYb3BLz9duBcXXk8qfKk1Wxkx0vHfu
ynoQTlZwv+Yh68caPvo77ilF9+yPLjmvhbtCpLlNigcjBNiNN8wdrAypjU2icYpR
FoTyY/2s0bvMtczNfncmpNFYeFfxgoayanHHmV2VYXiLl+keJB/uQ+U3MC0Oa1DM
hVoiACdSg6TJb0GeJKDPfqOfMYHrYxzUBkSytIDMHZ8i0TqzgIIv89YdMR+dX8ng
1XVXoZXuOecbCHX9DyybcY0o+Mz0PUSCJ0zRgyvCt151/VoHSJQ+c8lyIjRWQJju
C20p+jgXW9Wc4EX2I8JRYqxpyMZxsQ==
=gGlH
-----END PGP SIGNATURE-----

--7gopfpgmsl7hdmwp--

