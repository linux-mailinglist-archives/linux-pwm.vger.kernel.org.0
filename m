Return-Path: <linux-pwm+bounces-2179-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E38C9297
	for <lists+linux-pwm@lfdr.de>; Sat, 18 May 2024 23:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE2A1C20951
	for <lists+linux-pwm@lfdr.de>; Sat, 18 May 2024 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588F6BFA6;
	Sat, 18 May 2024 21:50:11 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B95C603
	for <linux-pwm@vger.kernel.org>; Sat, 18 May 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069011; cv=none; b=g3PnWoWNLiroeU4tpH/i7Wm+O3cXwbbQjk9+5JobzD/3L3n6Foh2s2g+Go8ZIvyJ4e52/O2oNlaVvDq1dBapABd42xg56v99KylawvPl3YO1/IghqXlc0VUL/PHHSWUboC+8DEQKQfdErPa2govFVlsNreGotinumuFINkHg6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069011; c=relaxed/simple;
	bh=LkalhpTJtKj/V/7cnlafYnegl4avMRdy03KcF5HoN0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCN2BuSP2RBOhjVexl+HDNiUV+6oFS2vv4fzBuyWNBWwYAQd+3W5AfNADOpzrQ+O276T+UPP1RbZtxCtl3jURP1oWWPnPvSAcyNOiU0ceN1pIRSJAVW40DtJRc10hi1tZUZMQrS8+0QIHpwiGfhk7VTCf3uYH9/DL/aAV/nvjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s8Rvv-0004h9-1D; Sat, 18 May 2024 23:49:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s8Rvs-0022tH-Ml; Sat, 18 May 2024 23:49:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s8Rvs-007rW5-1z;
	Sat, 18 May 2024 23:49:36 +0200
Date: Sat, 18 May 2024 23:49:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>, Guenter Roeck <linux@roeck-us.net>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: pwm: describe the cells in #pwm-cells in
 pwm.yaml
Message-ID: <oan6mlql2co4jsmnh3ghbomakdphab352fyq3plupellevkvly@f3jhiwidtkv3>
References: <20240517-patient-stingily-30611f73e792@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5mzdz6sjp46o5pa"
Content-Disposition: inline
In-Reply-To: <20240517-patient-stingily-30611f73e792@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--k5mzdz6sjp46o5pa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 06:38:46PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> When commit 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings
> to json-schema") converted the pwm provider section of the text binding
> to dt-schema it also updated all references to pwm.txt in pwm provider
> bindings to pwm.yaml.
>=20
> Most pwm provider bindings had a reference to pwm.txt as it contains a
> description of what the cells in #pwm-cells are, albeit in the consumer
> section of the document. Only information in the provider section of the
> document was moved to the yaml binding, and it contains no information
> about the cell format, making all references to it for the cell format
> unhelpful.
>=20
> Fixes: 89650a1e3b6f ("dt-bindings: pwm: Convert PWM bindings to json-sche=
ma")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>=20
> I yoinked the wording from pwm.txt. Having "Typically" feels a bit
> clumsy, but a given provider is free to override that order AFAIU.

All drivers that have 3 cells use that order, some drivers use less and
skip different values.

The patch looks fine, thanks. Will apply it after the merge window.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k5mzdz6sjp46o5pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZJIm8ACgkQj4D7WH0S
/k7DTwgAraN3fJOaIOLC5VKHDnwJQlMIaZjEL5SGJiFHDYb/4B17nm6oWl2fOpLb
w/2Fky3ybzg8/wqbDWQOOm9/3qK7MD5cF+pZWr3P9DH+tXVh4u/719TJ9YkaSKJ1
KW/gRT1PaDyibyJ7Qp4og+DNfpK0wg9W3dd3JE/Ggczi+jDf2+L0tNlj5Gmf7NuE
f767PhkURNijgxwZagcwgYlO0oHahLW6ORnt4k+48sYLdmTBVGwzj92jIVpd2K6d
LqAd3iHHHdneIXwX7BX1F3k7Zfjg1Rg1umaJ5I+roEmcxYsynn3ULCjPeVhN7CKV
WAcG4VDTeF8RaqPeQ60EuPQeJoVnog==
=RAwU
-----END PGP SIGNATURE-----

--k5mzdz6sjp46o5pa--

