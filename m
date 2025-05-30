Return-Path: <linux-pwm+bounces-6194-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08EFAC8C37
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815457AA0CF
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B94223329;
	Fri, 30 May 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0rd1HcM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7C21170D;
	Fri, 30 May 2025 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601460; cv=none; b=TJqXTyOZCsLIFuDSGwLWYXYfHG+Ipd1bQHdRdqJdPj5er9PuJJwNRdbEHOz33ryr1yYBqUQth0m37X0Wvzdas+DbhX344g0UUpt8iV2nqzUGtuqnvxtNqeAzl8Cvqr9WhRC1vfiDkhaH1hkaLWktlHgTRkM0x8gdPWHS2KGPf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601460; c=relaxed/simple;
	bh=WPHxWQPAr2btHznTt7J65awww0BQaCR48DXniOnUmxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O97E9aeiCTs6h3J9NsOYZOdcBfSlzgkv7PFCK1E/fHO5iYaY63UjR2W4YJz0E+d/kjvPljJdz03H9j7S+Vv5mNn3R9DeQ7O4lhn9qvhO6HBnup1pvgubzGSFm5WXSSNN6nyGIaglo9y3EDs75P1TatxLg2QeAr+/fvXEXhsvaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0rd1HcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB3C4CEE9;
	Fri, 30 May 2025 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748601459;
	bh=WPHxWQPAr2btHznTt7J65awww0BQaCR48DXniOnUmxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0rd1HcMJdvXasKpHlp0L/zx9S+j02WqCsoozMBNeajmeyPGk7wWHEY8snvpybyNg
	 G6G5XP4VhgC372QYoRwD16NLnnipq1/ERWOC9BXPVbeb27UsIjPq8cXpnHIZpxDRB1
	 Y6ahrB9UxO1hwPgpOnTCrfk5EOvJPDhJ0DkDhWKNZ8mpOM9LpiwoGdonpQ70n+cijI
	 6zYOT4ET87NTIpbSQZsIDkL1FVwhb3opxs9nJ1D4e+5W8rB1Hj2QCb+h93435/Yrgb
	 uCyX6wRbVWp1VDD05mOaoKUT+fdRcSg2jhkp3CfIfiVVtM4jiP8MFk5Wyg3g5w1Z6r
	 2qLQkj90/5pQQ==
Date: Fri, 30 May 2025 11:37:36 +0100
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <aDmKcNez0Bj41Tcv@finisterre.sirena.org.uk>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-5-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eDCYdTcGZ7ZBhmc4"
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-5-ce3b9e60a588@bootlin.com>
X-Cookie: Well begun is half done.


--eDCYdTcGZ7ZBhmc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:00:13PM +0200, Mathieu Dubois-Briand wrote:
> Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
> provide an IRQ status for each separate line: only the current gpio
> level can be retrieved.
>=20
> Add support for these chips, emulating IRQ status by comparing GPIO
> levels with the levels during the previous interrupt.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--eDCYdTcGZ7ZBhmc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmg5im8ACgkQJNaLcl1U
h9DTwAf/UABWOSYe+DgB55VrRGIdUvqDiKGB1vhxAuuWTdVWR3ofUQBVZGPUHjNw
AfbBY68x/zxKc+N3cgbcHMSprD4Zo/Yz5Rd3b9UESKm8mEiXkE1rPLNJUyhKXiL4
5OqORKFdzb3OSgw6odJpOr2as2EMv4CIZO/a2cdjBLXf1itzFl8Do64rfh0QIcgn
c8zZGISxQ/InhG/DI7s98CSaZwZ3kyIQVZx/BYUU2bCykwXi8RggU41UW/7OBCOu
xl90au/+KXs+6WPKdv+CnZqE8J0RrqJNFi18z6vu57S6Yk/hGwTwofMAMvZ39Snf
Yk3GjCiRd9/6ndTZDB8mOVc4Ra/ACA==
=w5Lk
-----END PGP SIGNATURE-----

--eDCYdTcGZ7ZBhmc4--

