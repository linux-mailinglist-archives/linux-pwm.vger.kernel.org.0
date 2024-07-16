Return-Path: <linux-pwm+bounces-2828-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13766932D67
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB692B23446
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179A19B3E3;
	Tue, 16 Jul 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC/09R/Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71E1DDCE;
	Tue, 16 Jul 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145894; cv=none; b=UL/k4YjxA5D+l1KJ+04VXxMgEwShz1549y0uT3KZDZhUXD5F557MFmCZOB6r9r6+mKDiK1lA1b7HGXg2nIGS7rAvYHclko2tbKJNT+N01FZa22H1AMpymQHymmntuTddbYzQSJWGCL0HmDdawTtISoqpI7Ql6QYpUVOguJRIsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145894; c=relaxed/simple;
	bh=7bdeBRk2eXQxVNqE62jOD4bNViPSgDbpp6IsB4XA/sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caxn8FoyI34MXKa3cD6araizPkW34h3mIUnz3avOBrgEOf1XAKw7rmVqr5jQ5k0Wv6Styqdl76Y2Q/siAbSqtr5De8cYktfOEmaRrCPEhUOBs/MWAK8xgtZmxjYPi1yAwXLfDdiWwV81XD2USxC6xk8dhPbgA3jQjnv5tf5NUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC/09R/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9098C116B1;
	Tue, 16 Jul 2024 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721145894;
	bh=7bdeBRk2eXQxVNqE62jOD4bNViPSgDbpp6IsB4XA/sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XC/09R/Y6r9goUkhLNzEdOCM7A8ckw1j4j5nvljL16ILcXSU+YgH3pumBdl671Vm+
	 +D34YCZlvA3JpUcYEYR6lJlPUSiE96JoorlY3HDiVibwigPoIY94WkVfY8Kzz8Y0cf
	 W1n2M7q+2qboPIQoc7klHgfhO62E/qM2d2JqYn/Vdy3jQGbRax/VMGiM1BZbx1vKUH
	 8Nbo5xGjaWUT82PtSD6JtTXaRaz5HZzpy28LG1OmDGFNxh2XGCF5uoCUoRG8SsLpoc
	 veP+7Drs5XCPbORsFjJO6Ah9PwH5MgUvh1qoTyzZIfFLZty+fzemMw1DB2gm7YXEDk
	 3Osgxv8thO9jQ==
Date: Tue, 16 Jul 2024 17:04:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pratikmanvar09@gmail.com, francesco@dolcini.it
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: imx: Add optional clock '32k'
Message-ID: <20240716-corporal-worry-15183ca9ea68@spud>
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
 <20240715-pwm-v2-1-ff3eece83cbb@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fRibbrrJ4CaRBetE"
Content-Disposition: inline
In-Reply-To: <20240715-pwm-v2-1-ff3eece83cbb@nxp.com>


--fRibbrrJ4CaRBetE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 04:29:50PM -0400, Frank Li wrote:
> The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
> increase maxItems for clock and clock-names.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--fRibbrrJ4CaRBetE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpaaIAAKCRB4tDGHoIJi
0ja3AQC57LpLdwDup3Cn5u7VwR4VXDEFrlgTSi5VVFGw+ctrgQEA1Yu0luAj3nJu
Hbszo+7oLDmuM6hm8gKxB/zULvBtzAQ=
=Oabq
-----END PGP SIGNATURE-----

--fRibbrrJ4CaRBetE--

