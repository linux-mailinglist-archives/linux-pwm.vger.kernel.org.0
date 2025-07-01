Return-Path: <linux-pwm+bounces-6622-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F17AEF169
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ADD7A9D6A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371426B77D;
	Tue,  1 Jul 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJAiyqyd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356A26B742;
	Tue,  1 Jul 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359200; cv=none; b=tZysoDizTdogHlf5+zy/C41Qv0rFJYYmI1Bt7sUS02kSXEY6TtGPn66jOqLLhv761na1syCHrhCT49w/xqCMXI7ktEeZaGfNAopoT87Tj2lvJpQD9eUfQUQX1HlwX37TWAjXK+ol1sC+m/i9Ts6btWhZu4aWDdQpgQ1VA3HxZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359200; c=relaxed/simple;
	bh=+6SLbZmX+21Rd1SXpw9czrDma6pP7nmqskRnVGf4jV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flcVULekFLNKabGTtXgzhQX3kaIxBnMJF0yzY8lfiecvimJL1aKZQAH+Qc8fZGFydbMHB1id79WMmYFUOstpn6+cIo+Ghe+YYrxKsuNZwDQmluhY3cpwTYYwSMdt09KUXlUqYZtc5mzcp+jyGj2FjVAqz43bD3dElj9en3RAGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJAiyqyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C5C4CEEB;
	Tue,  1 Jul 2025 08:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751359198;
	bh=+6SLbZmX+21Rd1SXpw9czrDma6pP7nmqskRnVGf4jV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJAiyqydGLso3Vljfbu7fD9uDL05Hi4dM980cjgy68/3V/AH606u1nWja22rHPL/E
	 v27lX84xl8FCEDJBZ8vPqWnTJwrTmF1y0iDL3G1UjQ5WF/r+60kcUAmhmAWQ/a8fVe
	 U49CjCIXiJEaWxKSNwNKtAtdrhr1qo8V5ZAo9Wb/x4grUoTtzgqdeMamNX+aUsm1BY
	 r/HMwrdVSSB1Zh+Znocj5T0UG2hMTPy6vn83KAdOHVjtY2OJ0W+XImkAkYRzS59XzX
	 mOsnvBglgU9WDG5MZOgEYg6UiSKhAZsCmkCN5Y3ecr5vlQpdBrsLSqsYkkvHHisu2I
	 Tu0PuSxbz9+0w==
Date: Tue, 1 Jul 2025 10:39:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v6 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
Message-ID: <txppsdw4w7ocnysvrm54ta4ulplwawd5pk2l5wt3bhrag6qbev@gr4ah7lgjigi>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
 <20250630-dev-adp5589-fw-v6-16-a0f392a0ba91@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqscdmphlstc25ju"
Content-Disposition: inline
In-Reply-To: <20250630-dev-adp5589-fw-v6-16-a0f392a0ba91@analog.com>


--mqscdmphlstc25ju
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
MIME-Version: 1.0

On Mon, Jun 30, 2025 at 12:53:07PM +0100, Nuno S=E1 via B4 Relay wrote:
> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the keyboard function using the platform device
> registered by the core MFD driver.
>=20
> The ADP5589 has 19 pins and also features an unlock function.
>=20
> Changes in v6:
>  - Improve kconfig text.

Is it intended to have the changelog for the series in the commit log in
the end?

> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---

I would expect that not, so it should go here.

Best regards
Uwe

--mqscdmphlstc25ju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjntkACgkQj4D7WH0S
/k4UfwgAqR6n1VQfqgq0d9sdWLAEXCxZFfTeeisIg00MKHCsWFnW57KvO4ptWnnA
NRI6rlGoCMkmk+MmPl1HHbXq/ReMdGJmH3cqGqiNqnxz+s0Kv3Bsg5JtcDEQYJU/
StJqUIg2C2zr3iKMtS5Tk3T3zBiyMd8v8gpPgHfhRcWO2VQBI1unND9RlYuvZfp2
pyqi7jFCrTIpBPzuyeIqAH+CTOKIPz3oC7AcF4ksxyeZNn/re43BTtUlel2NCe+L
exgHue1i/txpt5ta/K3gFZWdxtU6SsrbFfeII4DgSxBBis29QJGXwAFazsSCF2v2
45Lq4NIl2B+s5bKFSE2wQxBDWuFcdg==
=Dzj1
-----END PGP SIGNATURE-----

--mqscdmphlstc25ju--

