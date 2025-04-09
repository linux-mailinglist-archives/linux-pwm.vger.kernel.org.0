Return-Path: <linux-pwm+bounces-5420-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCABA82B67
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B5E19E57A1
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355B27700F;
	Wed,  9 Apr 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtQKUrHW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5E277007;
	Wed,  9 Apr 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213571; cv=none; b=EDOQCCjOAchZJGfDheDbka07jGSwonw78PBGNw1XclG90Vm5KHKa7ZtW7dV3RBFp+cwy3QybEj3s0KrxSRWr2LKgse4rU4jXHVDT9jFr2eayEfElz2t6Bx1aoAoXDJMxvagSXyjWwIwlBq5JWKZHw9F8hXlXtKLJF9iRtXvdLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213571; c=relaxed/simple;
	bh=vMJrlyFnjoqqmGoioQWBvWZ1yISZadfrxOaMgELN/sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsK1BrqeI5d/T4yg4AiL1WSlqbYjtMus7TXNVhmfE57khNYbJsTWiVPsI3pLNjvgIZows6lG3sKgS79j9VMZWyZbiwKNtA95pvnNq18tEccHYfY2LmlDTvQzw7lmDn83+zzTz+hYSCB3wN8x8N5AeDAtixR47pVj3Mxt+CGKewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtQKUrHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF76C4CEE7;
	Wed,  9 Apr 2025 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744213571;
	bh=vMJrlyFnjoqqmGoioQWBvWZ1yISZadfrxOaMgELN/sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtQKUrHWrZ2FSeQYFkcEV4CGuq/CYzfyJgUtdMPvbSuuWopwf18CFbnX6iiaeMC+F
	 SX/zNt1LEM80SCx3aq2OE8R9y+R6anoOpS3vpbYdQcVoW7oRu+reD/2pUpsWUXo2LR
	 iCNE/gJmyvbvpkBW3o8+fGMIN9doH3mbJkgubJfSbf9sihVaNJE5R2lRdFDJk/bQwh
	 MQXZPzonSVoU/v1zZDgYhGw7x42Hf07pRQrnnCSyeGRoaEdCpuUeV/qF2TghtkCWC8
	 4aGkvZdEAZS4cOF208CY3JI6qzFcetbedt1cU4pFYcr/5xi338lNywdl8V2azguFyh
	 9cbiNbA405jCw==
Date: Wed, 9 Apr 2025 16:46:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
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
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <7126e672-a829-489e-a0c0-8d6d64a8b2f4@sirena.org.uk>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
 <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQn7E9YAulFrDkPz"
Content-Disposition: inline
In-Reply-To: <Z_aUeKm0k1zReS_D@smile.fi.intel.com>
X-Cookie: Words must be weighed, not counted.


--cQn7E9YAulFrDkPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 06:38:32PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:19:27PM +0100, Mark Brown wrote:

> > BUG() can be compiled out, CONFIG_BUG.

> Yes, and it's still has unreachable() there. So, this change is correct.
> See include/asm-generic/bug.h for the details of the implementation.
> And yes, if we have an architecture that does not do this way, it has to
> be fixed.

unreachable() just annotates things, AFAICT it doesn't actually
guarantee to do anything in particular if the annotation turns out to be
incorrect.

--cQn7E9YAulFrDkPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf2ljsACgkQJNaLcl1U
h9BlaQf4gUpWNlETPHRZXjDQr/n4EFgXaLshmryE1reYNw7Jh07SJCohl7snptEs
IRVt9+5+nNGtISlJs4QXa6Hkqr/ytOpw5rXRmTSBkKhhbvdStUJkUv9X7jkQiNy/
1zhBb6ShA8nqUjHnZRhvjEO6JGKp4Cu1Iugs8pUjEfkDwLqU6NCq3yxqqqGnhGAY
/t7uOcrizg3jQtZYzmaXjZZYGv4yKaujcVEffu2QyhtF5ulLGwNm9hYz7x5ZHLBq
zJllpNQrrQp/6/GFZw/FY4J/8Xam5xUPHuxCe2ibHn0Xq1ym/JobQc2BjihrwKT+
xQwyPXj7Kb9z78qnphRGjcRw4Oeo
=pR1K
-----END PGP SIGNATURE-----

--cQn7E9YAulFrDkPz--

