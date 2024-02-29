Return-Path: <linux-pwm+bounces-1665-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A126486CEF8
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Feb 2024 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C43A2863B1
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Feb 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0207B3F2;
	Thu, 29 Feb 2024 16:22:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD04AEF8
	for <linux-pwm@vger.kernel.org>; Thu, 29 Feb 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223723; cv=none; b=i0Ycn8FBQwpmqmnLaTmADLfWb8YelNSMZLVdYaLcnSdyjFAi2oEXKwY4RyoChivmQ5mPR+GQavaWtJj3BPpm5rZYqeoBYnHMtWDShWt6i/rQYjUwbNe2+F8R0mds1bsoZ6JfLgxM1aEjq5SxBlprcdw8Ksbw5XbSMSRJUqwciOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223723; c=relaxed/simple;
	bh=9xr/DteE9ZS8doTdMEIRTmS8ga6UIWvenhyigxLRvhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojMJr8LGyHXlyzMfnaqGvWrOY3w16QJBhRrzSpENR5p8cNTmP1K8gvFgBT6CResive50wzPIhzV+g6D3p3pCLoTRFtyIfObQ3cWl61WvoF/TKaqGaFODm+kpxp3OB9rzmIwKWVIr+jbyIeIwnP50WXrmbcF3mTVmTXhh48d38QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfjAN-00085N-Kw; Thu, 29 Feb 2024 17:21:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfjAM-003cf2-F7; Thu, 29 Feb 2024 17:21:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rfjAM-00E2c2-1C;
	Thu, 29 Feb 2024 17:21:50 +0100
Date: Thu, 29 Feb 2024 17:21:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: Add RZ/V2M PWM binding
Message-ID: <jubuf7nz65onuqrdrnt6bejplexvodsldqvqj527fxcotehxl7@z3kbhkhlnaxh>
References: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
 <20240212210652.368680-2-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rl3jxwyibjwzx6ez"
Content-Disposition: inline
In-Reply-To: <20240212210652.368680-2-fabrizio.castro.jz@renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--rl3jxwyibjwzx6ez
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 09:06:49PM +0000, Fabrizio Castro wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add device tree bindings for the RZ/V2{M, MA} PWM Timer (PWM).
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

If you send a patch, it needs your S-o-b. (Though you could probably
trick me into applying v6 :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rl3jxwyibjwzx6ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXgrx0ACgkQj4D7WH0S
/k5dwAf/e179OLb30R7QH30xEqFAJN+SJBFnx3NXxhZTPSVo0cLHJVX3v4cEm6pU
HLc0LLNY4e7y1GJgcglTL+rG2oCVVIpBEjX/HSBNmRma2OiAEa9leqvdOsDR4xW3
al+XaqG01+XACbecDYJHr+2gpswmUHfvYXqIt+l6GK78XfUmQjrok+CaWKtYwOp5
2U/NgOIeDGhLi6uTuJpI7K4UcDiHoXFcq7IlaKeSadGCXzawKxLNX8bdcp6qasUX
jNFSNkcRkGNzL1Ww6+IrEETvUrzmBcVDCB3dbtNJ+R7CY4IoBDQQukdEEupNgrpa
EEYb5KB8/i3C2vLn/X5NzXMzm1K75g==
=cAGr
-----END PGP SIGNATURE-----

--rl3jxwyibjwzx6ez--

