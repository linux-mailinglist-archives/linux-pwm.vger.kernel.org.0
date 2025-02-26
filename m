Return-Path: <linux-pwm+bounces-4996-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06459A46088
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 14:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8836416827F
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163BA2144AF;
	Wed, 26 Feb 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZpAmK6O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EAD7464;
	Wed, 26 Feb 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575905; cv=none; b=IdoVfEhlsEbJsbmhqaHTdxSJbRXb7xZ5913MfziZLo+68CMMwLrHufPF8of10659mxxlsxhc1vwJFMDRZ0ckSwW/kjzmi++AJ8hCZDmB3jlFqmMvMVlgRUizLAb8p0G1WjTf+I433ljACiKVqt73sYG7ZuL/ypPHpTGrUsVWWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575905; c=relaxed/simple;
	bh=bjVlsvLBOM7oVxLFv550/V99CFQCpay+9nslgLYQNs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXsYIWrNvUII1nyEErAQfVGW26IVOcpVCwrhbKxK3sQTgDiKkIAkCtrOviN9HIO+EyI7Thnx7r1mBCa5AQXZWBU9II0FKhJaEDBNVUBObEZMAZ9bFE6UhfRu7ft6HodGn0Yj8Go5e1xc6E940DfHWdJyje+8RQUnEyY7U40GLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZpAmK6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25D4C4CED6;
	Wed, 26 Feb 2025 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740575904;
	bh=bjVlsvLBOM7oVxLFv550/V99CFQCpay+9nslgLYQNs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZpAmK6OmPPXdOKdQAJ8TDd3iL5slf4J8ox7f8bN33QeX9duxiSN0tIJNQVkHN8Ro
	 GM+AcGcws6AghkcU2OoXo7xCulRGWLVBERRvSvO90RNgcuR33A7aeqhTCedASa57aD
	 p16JUBGgvjeoFD2CGefXIkLbDcCQ8k0PrM7uXVcCnNsuzX1R9u8P0BDvAWp26aCzOV
	 TNHYtC5wWM6OVXJPSYSFrnpiNPE9sTXRaQeQzOYg9QxjmArTIK8kWmLK0wsgQxqwZc
	 HYU1AStDgPGgaHtDjcShDBSAJHGKZo7BlWTcH9oh8LSELCopc+/2pmVvb/bwxVg9Xs
	 7EQ/hGrqDDYfg==
Date: Wed, 26 Feb 2025 13:18:16 +0000
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
Subject: Re: [PATCH v4 06/10] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <ef7b9c80-88f9-4985-814e-e58cd44a3611@sirena.org.uk>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-6-8a35c6dbb966@bootlin.com>
 <Z69eue2dV37vw61v@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/ZnMkqajxP1BmR2o"
Content-Disposition: inline
In-Reply-To: <Z69eue2dV37vw61v@smile.fi.intel.com>
X-Cookie: I've been there.


--/ZnMkqajxP1BmR2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2025 at 05:18:17PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 14, 2025 at 12:49:56PM +0100, Mathieu Dubois-Briand wrote:

> > +	int ret, i;

> 	unsigned int i;
> ?

If it's just an iterator it's idiomatic to use signed ints.  IIRC if it
makes a difference to the code generation it's likely to be positive.

--/ZnMkqajxP1BmR2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme/FJcACgkQJNaLcl1U
h9DQ8Af/fxLiNmnQb8ioOReWGeFUKZvjmO/mJ5ANAtemDTiaMKVnIsLZMihmn/B2
+70z79eF26afBgEU1LBny6ne+p8KRWLGUL6vs92uHUla5bfKe1ZgAI8BUUV8Ogbx
GZyPQ+bBWUUcqPczn9ttmLum7ekJvVybhBOvp588OiWUcOt1FNhp8eRyQlWzy+Ed
RRrKTS1tJUqQ4Yph7qv2nHN5cXW1qihotymBqR2biySVSoPleXZNfJAmiZL25SSd
RpuG5LAzY11iS2Mbg/nLRHRdppdaMdJvhMgcnY3RS+G4KHeozJhLy0KpI18/tB5d
TZp4Krkq13kYk/mGspSpeUqDVNXs7g==
=zw63
-----END PGP SIGNATURE-----

--/ZnMkqajxP1BmR2o--

