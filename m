Return-Path: <linux-pwm+bounces-5415-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6BA82A0A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A27A2AB4
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D884266590;
	Wed,  9 Apr 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5NYgS7N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0A198E8C;
	Wed,  9 Apr 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211976; cv=none; b=LVEWLwZx38D3igP1yJUHuSHwWFv10tfkHnxtXAa9lZrrHYSX2DQKPPFppn1h6bJzboyBt9+YMVXTYB4wn+80p9+xr2FMKs9jjJAbGYmXuvtVoLIT1GK05T0lxRobwaO8qHEqw1clz92J/p5VPhj6Nmg/UNZCcIqalZGl/XynM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211976; c=relaxed/simple;
	bh=NeomZw9+DPq5KpWTRNo/0lEsrpLUPG4nFaavnDmdc0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWbINkDDTZolmuZv4K1AUln8k1fWVudXHEjx/364bKHrnFIaRFRhMZ+xsIVvlwJnLfNvRAWtIOzw9iktD+lRvv9eIlbc6QdnGq82cB0NL+/ykIWcRcHPdt9N4tyY/y/QgtdBGdtSCr129fnqa88Vg/yq41cJLTmwynaeZF2FIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5NYgS7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1645C4CEE2;
	Wed,  9 Apr 2025 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744211974;
	bh=NeomZw9+DPq5KpWTRNo/0lEsrpLUPG4nFaavnDmdc0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5NYgS7NvPHEBE4Wu73p5gqF8sAI4EGpLcPs2FIiPBBj2lS+M+Q1z+MWfRUHrwqou
	 xDOHm7rTJ/K4u9wvLhuz1aoaHzbX9WHTwLGPGJoR1XHiqe4quu+YGvX7xkppHyFm/4
	 gjZ+gbM+Lv35sCQO0BIhKAMrm+nxQFcGvm+NvAt2sga65pSulUjMpyElK66L0h3w06
	 pZW+9mqw/CGSXHp3Fax0OpJWdUt+sfSqz+g/fEVWsKVer96LGRnEZU8rQR63WywMN+
	 4BfKrTmNLQXJ6bkmM9DCxT1vSLQ2aUU84Qx6216Dti6bevmM2E13m3WNZQDRwHg1YL
	 fVw6bBwuVbwzw==
Date: Wed, 9 Apr 2025 16:19:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BYUP7jXFrzr2lfUp"
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
X-Cookie: Words must be weighed, not counted.


--BYUP7jXFrzr2lfUp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 04:55:52PM +0200, Mathieu Dubois-Briand wrote:
> BUG() never returns, so code after it is unreachable: remove it.

BUG() can be compiled out, CONFIG_BUG.

--BYUP7jXFrzr2lfUp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2j/8ACgkQJNaLcl1U
h9CbmQf/SCMi4nu6jgz97GD4VidWAdiJFF0TbdY32OKI1BCS4Bz4ULVB3auTnlL3
Da6w8bylWLU9a7Bw/zmxCR/KHFTpuRgKuw45cVQXxj+EawLl7vJwvQj8w4zSXM6Y
OYm+a6a+wNCFsiN1x/CdQDEjk2vlcT1tKjgw674j7FzyRDokJej+CaBRA/L1/yHO
tnv9oBlKpLzaPGti39AqeyC9uO7M0/meAw+9Zg2m6blijZML85AZEpaEMGvAnTPP
LMGIgFdNtcdB+frLw3QHKtcLHM+V2fvUwr5Pc/6+0/GmXc6rW2I8fLIwHUzEHLea
BpzVN5RC9pQ0L0fB/+6+6UiTialtHQ==
=oey7
-----END PGP SIGNATURE-----

--BYUP7jXFrzr2lfUp--

