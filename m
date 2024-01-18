Return-Path: <linux-pwm+bounces-848-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F4683168C
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jan 2024 11:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9467C1F249C1
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jan 2024 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8420B1B;
	Thu, 18 Jan 2024 10:17:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A0208D5
	for <linux-pwm@vger.kernel.org>; Thu, 18 Jan 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573035; cv=none; b=EXonp+tVJLxxL5bK4+PqWgktAV81kAPO29XpPAtH+zxcG3bEJKfINeEPjUpIN2NnLwjOqkq0mDhuAm1HLxrVeeoJCU2pFf9SP1468caUFnISZry4fHcDf+KRwInKhlqroAnc1EqCLXdMErDIxwwyA5/fgrAtcSn0TKqxO8ADETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573035; c=relaxed/simple;
	bh=nvH/+q2N6Cd7sJKxG0KRQwvC9INP3R9zrgZljiQfg4g=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=ncmQMukjZfaodEux0GzwIe9/K8b0+UCL4cf7djCjb/TSse8aCmbb4EJ7OsKZ9W064JaDP4Q1hEQ//uNbfMJjfMprUMqyqK4JHpyvZVaDZVDVp37k7qa6jqGiGwNSndNSzyqOYiXji/O5qQjPTs1wSKid8cFOLb7xzudlbwh7KFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQPS8-0006ET-BN; Thu, 18 Jan 2024 11:16:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQPS5-000fSu-VC; Thu, 18 Jan 2024 11:16:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQPS5-002KPs-2m;
	Thu, 18 Jan 2024 11:16:49 +0100
Date: Thu, 18 Jan 2024 11:16:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lee@kernel.org, 
	thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux4microchip@microchip.com
Subject: Re: [PATCH v3 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to
 json-schema
Message-ID: <kht2fxv2fbeod4pakk6q6m4gthftdr6asjqjojgb45kqlsrxpl@37umfctsorhs>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-3-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctdxky3tp4klhg4f"
Content-Disposition: inline
In-Reply-To: <20240118092612.117491-3-dharma.b@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ctdxky3tp4klhg4f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 18, 2024 at 02:56:11PM +0530, Dharma Balasubiramani wrote:
> Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> format.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I will update the short log to

	dt-bindings: pwm: atmel,hlcdc: Convert bindings to json-schema

to match my preferences (unless you object) and apply for next after the
merge window.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ctdxky3tp4klhg4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWo+pAACgkQj4D7WH0S
/k6GLwgAs+MEUZnzvgpfyAgXp1x4fFMoEQokVCvLZGX1tqfXkY1UtYujR0eCWFH1
8LqCQTya4u1FnUv3c9zMTZ51NINu2hGoc7sbrKI9pTmrgbvB4JXUr+0Plu5NpHHo
OCFoUuJ4X5z/p38sAvExr34RA0jfKMjJQ24bHzmxda+GfqyDVIeazpzmmbf8YItE
2YQcxyKA3QvSRtscHT3ORpfIifhKfqbxQ733K3pu7koLfRBbjg93ytSR0FZ/IRVd
MdcqAYpwDjhx4J0aufPMuCBevj2xTPHqBGL9CPMKXeyOr5H9bpIC3A2J20VcjUD1
QslvGv7SwhqVJW5C2RCytH5l9gQJoQ==
=3SAX
-----END PGP SIGNATURE-----

--ctdxky3tp4klhg4f--

