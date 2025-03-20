Return-Path: <linux-pwm+bounces-5255-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D0A6A0C6
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 08:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB42176D6A
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802CC207A06;
	Thu, 20 Mar 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDmxdIKD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC17204F85;
	Thu, 20 Mar 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457004; cv=none; b=BfuD3DmkQL9RRMeewP0rSkxYuiddiSkaRKRoTmDUWDG0yvnc9zBWMqJnyV/KlR8SrZVarz9Rv/aDwI1DJstwVJ8fg5jb+IjZnRR3uIFI22Iln2hOpOMOgmBu71MpOO8k6rOWZJ8QsWAP6q2bapI8cW/WiASszDLQuvNq8mGC7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457004; c=relaxed/simple;
	bh=5HaHlb3LdE5BLe3N6Wb1gvDWqG3ehdRcH7l+nIy3zx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjCE2ordkQ+uUVsh0mqtNp0FH8/ox3a0nFfa3GsIk/zk42AYGKIJBbudbEsJF7zk8ECzj1HirtlyXRwLlj6rpneMqtaUe5abz9wZhU+QF3zc77ghpx/wDOdlcRUkO/lVaVn7+LQOWUVSwRBfZ25TPUJkYUqPbldujMEZ6ta1bAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDmxdIKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C58CC4CEDD;
	Thu, 20 Mar 2025 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742457004;
	bh=5HaHlb3LdE5BLe3N6Wb1gvDWqG3ehdRcH7l+nIy3zx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDmxdIKD6oIAzIPEFVVhiYrsavGtsRLKkRyi7uissXoXY2JMuKPGcQBV6/FIqKJNN
	 ORMeruO9kQQPPLlmL50LtR1oCTGJiQlFTZhs2ZeFeCuEpFUxdFQXmmRCTSK0cWliSI
	 MWwEx8ZRr6nVNC5MouJLCq1uwYmu7oUNbPXtkVcwxrwvHsmUk9YCj3pUC8zgWKotm3
	 Zw4AC0oKWQJob/qGsSpVIOlMY97LK0qQGbg19K7rQKnsWbH+WAfcGkEZDdbjHCRZ2f
	 DC3QLXuOcb2sHJujPTbyS23JZpTy7yHEPHBmTVCTjQkvZqN6vgOk/n4B1o/4k2INom
	 eSgl9rViiHPfQ==
Date: Thu, 20 Mar 2025 08:50:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	mathieu.dubois-briand@bootlin.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kfurgyfqcymyt52d"
Content-Disposition: inline
In-Reply-To: <Z9qoGmNKcozbIjeH@smile.fi.intel.com>


--kfurgyfqcymyt52d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootlin.c=
om wrote:
> > +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > +					   struct pwm_device *pwm,
> > +					   const struct pwm_waveform *wf,
> > +					   void *_wfhw)
>=20
> I would expect other way around, i.e. naming with leading underscore(s) t=
o be
> private / local. Ditto for all similar cases.

I guess that one of the other waveform drivers is the source of that. I
chose to name the void pointer with the underscore because I consider
that the strange one that has the void* type for technical reasons.
That's obviously subjective, but I'm happy with that choice.

> > +static int max7360_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct pwm_chip *chip;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	if (!dev->parent)
> > +		return dev_err_probe(dev, -ENODEV, "no parent device\n");
>=20
> Why? Code most likely will fail on the regmap retrieval. Just do that fir=
st.
>=20
> > +	chip =3D devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
>=20
> This is quite worrying. The devm_ to parent makes a lot of assumptions th=
at may
> not be realised. If you really need this, it has to have a very good comm=
ent
> explaining why and object lifetimes.

Pretty sure this is broken. This results for example in the device link
being created on the parent. So if the pwm devices goes away a consumer
might not notice (at least in the usual way). I guess this was done to
ensure that #pwm-cells is parsed from the right dt node? If so, that
needs a different adaption. That will probably involve calling
device_set_of_node_from_dev().

Best regards
Uwe

--kfurgyfqcymyt52d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfbyKYACgkQj4D7WH0S
/k7SWgf/dyLm21zpgsxSkf/1BAmivq9bOQ2nUPl3FWsik+NtKVmzdlk1AFAoqgyN
5dbrTDXRFgrSsdvgMXLu9YIROWv7Auf4dqevkB2MplneL4PoUaZlLerqP5DAGtZ/
1Kh0N/XbcwUG+tLqYVF0Qy31biUuKYqWlLhttZkAjCwBenc6gLGOKp+8HxRzJRQ/
ZJgVgL09M3ZI9xU0mFtUoMIcuvbHl0ydcEMa95to8R7L923FKgKZdXCF1181yv8O
kfG/RQFBryfg/PvsTorRfPaCt29yrAa9njCy7sQsGzsZaGEb2YZlaEcs2OFsik2l
deVtif5NH/HD3szq2pMLvWSyTNf9Bg==
=mUp7
-----END PGP SIGNATURE-----

--kfurgyfqcymyt52d--

