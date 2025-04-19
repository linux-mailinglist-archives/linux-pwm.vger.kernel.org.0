Return-Path: <linux-pwm+bounces-5582-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6ACA942DE
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 12:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AFF3BB615
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEFB1D5141;
	Sat, 19 Apr 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kio4HHdO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C517C224;
	Sat, 19 Apr 2025 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059138; cv=none; b=SqIXcReqtJ9I9W+rgS2fp/4jgqGAM2aiUtT8QmMw9jbCCVnvaw/esQhrNlcXqVDTaY2AYJxN+fFFgiCoMoSMLE+MG/gdOpbzwohZb5MuHRgKnMvX3VVcO4R+eaK8zXhA2GQhaEeZONPcBi7CooarBT7m6ZELou5yzqFIAxGkU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059138; c=relaxed/simple;
	bh=xY0aaUKiZ3nf6klLxrhBlG9cVhweGxQOTCb/Ekznwd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv5sQSVNMEz8AYJebST3BE5G+do1GG35G3Ir1WncWHYMUiqgSAROPBO6vJEZSoPhEx+KL+frRQgtMhAtA4FdTlH+TPSmP/F0FGFV496+QMQS5FQ4Nhg1uBe2mY6d/Lm4PtHYgiSlRlnM0SyU5jgcWeILk1VcOBTMHBdL1o1b2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kio4HHdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5053C4CEE7;
	Sat, 19 Apr 2025 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745059137;
	bh=xY0aaUKiZ3nf6klLxrhBlG9cVhweGxQOTCb/Ekznwd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kio4HHdOutRt0lX2iSm8cL9uJdAUhJ+605V0kO6NHfszftpZB1SzbYW1Zb7rFcau4
	 r/9DIAxMBLwzRRUT9e5NVgI0dmKFFewiROwZI6Eq1alhEhv4fL4GQmgY0yQ+Otk7ly
	 M62eiTqiLW3tdSXi8iC8Lhkbvr0f6CYqrYbOfKAsCqhvIbJui4wNP61RMfR1KiE1Zf
	 9nIufnoRKDrJyIWV4yFuP3RARs+ugw4NFriv59FhMTJyM8p9KNSHiu0K4iyEHAC588
	 tRHoW13+hfHVSQhTZRCwy4dJ+wlVMTJPaLVYcKoNnV3FoDsH6QFw9MHAHvdtASQLgh
	 tQf3vWUTqHPjw==
Date: Sat, 19 Apr 2025 12:38:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
Message-ID: <innhzhoplngaorr3oqsxigccbzho7eptp42lmd4otux4xsuvhx@pdhzjy6jwrtf>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-5-7a2535876e39@bootlin.com>
 <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i2qjelbfoeyv45bu"
Content-Disposition: inline
In-Reply-To: <1b280408-888e-48e1-8e6b-de4e7a913e74@sirena.org.uk>


--i2qjelbfoeyv45bu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 05/12] regmap: irq: Remove unreachable goto
MIME-Version: 1.0

On Wed, Apr 09, 2025 at 04:19:27PM +0100, Mark Brown wrote:
> On Wed, Apr 09, 2025 at 04:55:52PM +0200, Mathieu Dubois-Briand wrote:
> > BUG() never returns, so code after it is unreachable: remove it.
>=20
> BUG() can be compiled out, CONFIG_BUG.

In that case BUG is defined as:

	#define BUG() do {              \
		do {} while (1);        \
		unreachable();          \
	} while (0)

so the return can be dropped as suggested in the patch.

Best regards
Uwe

--i2qjelbfoeyv45bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgDfTEACgkQj4D7WH0S
/k7/vwf8ClL68F1xm5thX7WLNjkcCjj0pl/3M+1HJ25yTuZ6yblDFzo6mRfBwfM5
X0JG3yzxvMGlWGNLLql8B1J5DundDprN2qp6YOpMl1f5JneoI0KIXTY3lNT+0y4N
P0V5eGYy96j3JGZ9p60X05EFHvfxMLZPBnTkj31X0fux7eodlRHQCmx4rjyOct4G
TYUeb/HE+qZ/TnZKSU2biAzWsegr7RgnT8/oMVE+GFp6UZT5n6MAC6ZtjRt3p2jE
KCG83+YMP9Vul2ZDXphhp3Vk6N8rIJgIaM0/PY0UotrGSyGyXccPAU7YC/srM4yA
5RSfNSBdYe055b1jwS4NM5wo2lYXnw==
=g+OB
-----END PGP SIGNATURE-----

--i2qjelbfoeyv45bu--

