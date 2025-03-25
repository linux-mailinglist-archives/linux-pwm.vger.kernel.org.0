Return-Path: <linux-pwm+bounces-5272-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE062A6EB0A
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABBF3ACAE4
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACAC1A76AE;
	Tue, 25 Mar 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kodc+eER"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A84D530;
	Tue, 25 Mar 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889815; cv=none; b=PB9BO/3tuvR1NVxXhN9AnxVZxvY1YnFf80+w+Bp7kJtt1MYK+MQXsYlbkhqB/WA03FkzUSP2+Kp6iNWJ5WW2h+VETHFEXnex1OF61e5J84o6F0qFnS+mnjEOw3GAzWS9Kbnla/Kbn2nxyp78r9YJzg8ni65J22ImdxMr4lEvgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889815; c=relaxed/simple;
	bh=9uUKGyUB0WQ/1kbUYVgNq2hE+kFTuC/cc2gC83yJOkY=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=hroUS6pEGPGhrD0KatLtLr8DFCpHqdhrEDtIAvMa9F1yppQ0V41m6iKAz3P3uTFcCAqZWEgvWT9sfNTbdxPtYCwEDPFh7Yw6FtpAq3nCPFv7aRuAU/Zd+53U/f4NO1SUHssPMRIAOzouIvoRo5Zq1tPPZliyNi9QLUSUu2nkAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kodc+eER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953A7C4CEE4;
	Tue, 25 Mar 2025 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742889815;
	bh=9uUKGyUB0WQ/1kbUYVgNq2hE+kFTuC/cc2gC83yJOkY=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=Kodc+eERFMSW0DHCjw1LRCw7LRDA8mQLSe1nD3GDSytmcvL3x8QfuNtRbDq0yGo7t
	 f9Xz3egtGUINOb2zZgHQd40Y6te1bC3aQBYV665ODmT/MDdFXPcQgMttgZuFCmLhco
	 HJan0DBnE8h5S0Uaq4exfLD6uZC7dMtoqmlggddy/azZCWjxi2ZO9BdVGWjHa2d8Nb
	 IHcOrlQyyiUgYnhjBLwTbakyU44UGtmAh+5T2j1xJjdPV8Xad2t8WNW5oqbPmaIRcG
	 mZJ6MDiyhPC2aWkwQjab8wlKiLbVc5uhYLvWe9kGwxenov/0RticZUeWfnaP47GS/r
	 XU0osaqiRBWiQ==
Content-Type: multipart/signed;
 boundary=749e0a89a59d4b144def041172d41866f10aeaa2d8bd591b89238716dc11;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 25 Mar 2025 09:03:30 +0100
Message-Id: <D8P6VHQPKLTO.17D0D63R63AGI@kernel.org>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Mathieu Dubois-Briand"
 <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
X-Mailer: aerc 0.16.0
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
 <D8K23TCWC5TO.3T1YPKL3G0OY5@kernel.org>
 <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
 <Z9v0Mv6hYna3Znq8@smile.fi.intel.com>
In-Reply-To: <Z9v0Mv6hYna3Znq8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>

--749e0a89a59d4b144def041172d41866f10aeaa2d8bd591b89238716dc11
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > Also, what is the advantage of this? Your caller doesn't have to
> > > call devm_regmap_add_irq_chip_fwnode(), but on the flip side you
> > > have to cram all its parameters in the gpio_regmap config. I'd like
> > > to keep that small and simple (but still extensible!). IMHO just
> > > setting the irq_domain is enough to achieve that.
> >=20
> > This was a request from Andy on my previous series.
>
> The benefit is deduplication of a lot of code. You may consider it the sa=
me as
> GPIO library does with IRQ chip. This is just the same on a different lev=
el.

I'd say "a lot of code" is slightly exaggerated :-) I was hesitant
because it sounded like a one-off for the regmap_irq support. There
could theoretically be other irq_domain providers (I think).

I just had a quick look at all the gpio_regmap drivers and they all
use regmap_irq. So maybe it's fair to say that one could be directly
supported within gpio_regmap.

> Besides the driver in this series, I would think of other GPIO drivers th=
at
> are not (yet) converted to regmap (partially because of this is being abs=
ent)
> or existing drivers, if any, that may utilise it.

Yes probably all of the existing ones :)

-michael

--749e0a89a59d4b144def041172d41866f10aeaa2d8bd591b89238716dc11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ+JjUxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gNlQF8DdstlMCMTWZP9/iSY2OUBfTMuiNEdE5N
5Y/+ME1vDpDuwVKXM4WXbNULrK03UtiRAX0b4ebT46pIKOxwJjAhAvI6T8PQHvSq
oqWoCmmSSQOWBm3LttqGq0dFLTDltZapkuQ=
=mHti
-----END PGP SIGNATURE-----

--749e0a89a59d4b144def041172d41866f10aeaa2d8bd591b89238716dc11--

