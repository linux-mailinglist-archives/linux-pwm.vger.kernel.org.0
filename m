Return-Path: <linux-pwm+bounces-3355-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1086984822
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7BB22FA2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2024 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1D11AB511;
	Tue, 24 Sep 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhpUpX7B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C1224D7;
	Tue, 24 Sep 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189994; cv=none; b=DQ6m8TDxA0s3LdNE+Y4Poso1BFJporQCoWUYVc5k4z3LkrfLn14ehZ7d+XZB1kw5htQxvCcfs385Np3OAwvtc/a4LKmZch9/PjLTShXJ5DAhmshFq+8XkEuYzWE15I/qaIAW7OB2zH2vKNhfOkx6V1iDnd1xaPLgAV8RjQjZ/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189994; c=relaxed/simple;
	bh=wLEhhCE0jdrFjf4Bccj8YSgM6u/n+FpUlXZY6C0JBYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkEOGJotmw5LGrbr1EmHIN4h56yglz/eAumN5T49vNipIp2iAqVZDMs7df0INLNeM4xHt1JXp+KYzHFs5icLJiwVH2U5zwdFO7/E0mEXWMXGgRhPY9DY+Zs+Ws1iW5EiWcQ+LM29dhohvF1wsAk8Ld48X71KXoYsT7WsSJXgbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhpUpX7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC706C4CEC4;
	Tue, 24 Sep 2024 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727189993;
	bh=wLEhhCE0jdrFjf4Bccj8YSgM6u/n+FpUlXZY6C0JBYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhpUpX7BjCn3gO2OMSlZBWzdrgFE8Y7V3jn5JRJzs5TH50IeTW6W6ZZPicsdUcGMk
	 +1Qkaxf1DKRKIrRwgvEn3q/jvz6F6/9LMZeGoXaMl5cGcgRuk7xr1jsyxicvC7qMQ6
	 co7mtRuyBsEVcdNKDp6X+OhWPT80axS7pjQxsPRY/k308cC+InUI7efvUD0klmDXU1
	 Jk0mBgdYI39K/nL8qkxdqRXJ1L4xIHr60YH52abxuOnE5SvuA1R6AHZDhN0hoktDoR
	 eok2ubDCaPHP+jhimrJyiGOl0pPJkmlJAYU2cCmqetn3ZBeG9DnzY1AVX5kIUckQ0M
	 Xh4aoKLeWYRZQ==
Date: Tue, 24 Sep 2024 15:59:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, aardelean@baylibre.com,
	dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: adc: ad7606: Make corrections
 on spi conditions
Message-ID: <20240924-unvocal-playback-2753bbbb0e45@spud>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-2-0e78782ae7d0@baylibre.com>
 <20240921-playgroup-regally-f26c17be26dc@spud>
 <56090167-15a0-4386-89a6-c379d70faae6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LGfhlP19buc7EotU"
Content-Disposition: inline
In-Reply-To: <56090167-15a0-4386-89a6-c379d70faae6@baylibre.com>


--LGfhlP19buc7EotU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 04:41:50PM +0200, Guillaume Stols wrote:
>=20
> On 9/21/24 23:55, Conor Dooley wrote:
> > On Fri, Sep 20, 2024 at 05:33:22PM +0000, Guillaume Stols wrote:
> > > The SPI conditions are not always required, because there is also a
> > > parallel interface. The way used to detect that the SPI interface is
> > > used is to check if the reg value is between 0 and 256.
> > And, yaknow, not that the bus you're on is a spi bus? I don't think this
> > comment is relevant to the binding, especially given you have a property
> > for it.
>=20
> Apologies, I missed to change the commit message, it will be fixed in the
> next series.
>=20
> Since Jonathan did not like very much inferring the interface with the re=
g's
> value that I used i the previous verison, I introduced this flag.
>=20
> However this is only intended to be use in bindings, to determine whether=
 or
> not spi properties should be added.

To be honest, if it is not needed by software to understand what bus the
device is on, it shouldn't be in the bindings at all. What was Jonathan
opposed to? Doing an if reg < 1000: do y, otherwise do x?
I'd not bother with any of that, and just make cpha (or w/e it was)
optional with a description explaining the circumstances in which is it
needed.

> In the driver side of things, the bus interface is inferred by the parent=
's
> node (SPI driver is an module_spi_driver while parallel driver is
> module_platform_driver).

--LGfhlP19buc7EotU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLT4wAKCRB4tDGHoIJi
0mCAAQDudOcnB4isEwsLcFNtTyQ31oYWCGB1e95rCdJm05qJ2wEA4xjzPpUt3/Qb
TKW1SfNsOP2E71J9oya3wCXkKqNqrQY=
=Mq6o
-----END PGP SIGNATURE-----

--LGfhlP19buc7EotU--

