Return-Path: <linux-pwm+bounces-626-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E40281C8B4
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 12:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1B9282D09
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C717730;
	Fri, 22 Dec 2023 11:04:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907617723
	for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGdJv-0007sM-7Q; Fri, 22 Dec 2023 12:03:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGdJt-000jdp-OE; Fri, 22 Dec 2023 12:03:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGdJu-001cxd-Hw; Fri, 22 Dec 2023 12:03:58 +0100
Date: Fri, 22 Dec 2023 12:03:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Add pwm_apply_state() compatibility stub
Message-ID: <6u5antjrcfujnr4wjuzjhompgryxfhaat5ulbs5t46vxvrmyc7@kpo46ce35nlq>
References: <20231222091445.342131-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3yrrl4t6dmcflleo"
Content-Disposition: inline
In-Reply-To: <20231222091445.342131-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--3yrrl4t6dmcflleo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 22, 2023 at 10:14:46AM +0100, Uwe Kleine-K=F6nig wrote:
> From: Thierry Reding <thierry.reding@gmail.com>
>=20
> In order to make the transition to the new pwm_apply_might_sleep() a bit
> smoother, add a compatibility stub. This will prevent new calls to the
> old function introduced via other subsystems from breaking builds. Once
> the next merge window has closed we can take another stab at removing
> the stub.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

I suggested such a stub already before, so I like it.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3yrrl4t6dmcflleo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWFbR0ACgkQj4D7WH0S
/k60awgAmRRcxf+oXTevCVDEG+0oCFcoyyBekFtlj6wTXvaJuAzwWQcZm/1pQgxp
lK1TDhF+aAVRSCLMB59aKQZo/n1DDuJ3FyHXfdJdpobYqM2Z8gw0LVXcX2eNr785
03g/U3gBRVCBYF/T51tipFrzG3OECDR+mDPrjmtTg6pccOYeklN2wuEKeYymMSmY
6z04iXGOivmqQK/fqjUAmLfg0/1haU+9XWc2BCaCLvzDoJslUWRFHgxPA1sBs3U1
NL1aj7YHCcKl6RyblumaengDeHHOvCMGG1hAQgDGG7Pj9evz38TpaaMWE4pidJU6
mTRiqeYOvDuoU1tsYpGhuhQXzSgw9A==
=IroC
-----END PGP SIGNATURE-----

--3yrrl4t6dmcflleo--

