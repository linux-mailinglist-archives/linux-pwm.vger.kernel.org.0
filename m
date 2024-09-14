Return-Path: <linux-pwm+bounces-3272-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC897904C
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107EE1F24054
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06C71CEEB0;
	Sat, 14 Sep 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3AFowFB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC627A15A;
	Sat, 14 Sep 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312187; cv=none; b=tSUBqwQQ8WCHUZYXIGlRD+SS71vAxR7/c2n2SakhkReYpsReD2essj3QYAkXaDc1OhuLyL7mk/6ybE6ShkHO32nAZbEkkXI59Wsospv0fWfgM8thE88WezmEodSgfefSHoW8BkQbuJPAbl+IXQqwwQ1TimVZh7mvl2smJDJ7LG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312187; c=relaxed/simple;
	bh=dj3RBJNoLKQBK3vq1ElWbWaAStCLklS2fV4ce+qLNLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npXadbZT0wVoKEkp2R0HeIMTl2VaIEaHAItCpFXTcQlRAryLPVwNi56sgz4kZXC+9Mru5mdH+B/9nQeGFORKMyI61Kqdavz05tldKNUDdofEhag0GXOpJ2MlC+ZtqDU0JUYEtw4m2Z452hM8/jflekvrCTl9PCbFdbbfwZPpT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3AFowFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43321C4CEC0;
	Sat, 14 Sep 2024 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726312186;
	bh=dj3RBJNoLKQBK3vq1ElWbWaAStCLklS2fV4ce+qLNLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A3AFowFBpYHm3nEXBsh3KY+x69JVDf+m+f2xnGnr/5M3fRQDzUsqxBbp1VK4Xe5Jz
	 XL6KwzGdfp8Tob718K9bFBbD8mu+Q6PVKpTG7Z3vfdNpNm0ecEZ9Ljk7WpvFx9UVpY
	 pAD5OLo7Jzw5qMmjcZpvIItjpZ0IIY9bEYXydbrWEs2BkHjYaj+mrpXGAU7zE6qNIN
	 I+5GJwVAg5zNwYxUigqH9XdOQqifOWpWmuJR0Vweje6uBMGNC0jr2TenJWxT0hkYDN
	 uGJRrJbTWH2XYn3KohTR1QLabVJ/IM9ZY8hyiBiLm44VQrym4WDnLmQGHahZemO6s3
	 NDewcY92WN7/Q==
Date: Sat, 14 Sep 2024 12:09:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com
Subject: Re: [PATCH 7/8] iio: adc: ad7606: Switch to
 xxx_get_device_match_data
Message-ID: <20240914120936.01e3d694@jic23-huawei>
In-Reply-To: <e6d3926a-002d-445a-8ac5-8d47b2be27b0@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-7-cea3e11b1aa4@baylibre.com>
	<20240817163354.68ec95f4@jic23-huawei>
	<e6d3926a-002d-445a-8ac5-8d47b2be27b0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Sep 2024 11:21:34 +0200
Guillaume Stols <gstols@baylibre.com> wrote:

> On 8/17/24 17:33, Jonathan Cameron wrote:
> > On Thu, 15 Aug 2024 12:12:01 +0000
> > Guillaume Stols <gstols@baylibre.com> wrote:
> > =20
> >> On the parallel version, the current implementation is only compatible
> >> with id tables and won't work with fx_nodes. So in this commit, the go=
al
> >> is to switch to use get_device_match_data, in order to simplify the
> >> logic of retrieving chip data.
> >>
> >> Also, chip info is moved in the .h file so to be accessible to all the
> >> driver files that can set a pointer to the corresponding chip as the
> >> driver data. =20
> > This means each driver gets their own copy.
> >
> > Better to use an extern in the header and keep the actual data
> > in the core module. =20
>=20
> ack.
>=20
> Given your previous comment about introducing=20
> platform_device_get_match_data, I guess I should instead do it directly=20
> in the driver's probe, like its done in axp20x_adc.c ? Somehting like tha=
t:
>=20
> if (!dev_fwnode(&pdev->dev)) {
>  =C2=A0=C2=A0=C2=A0 const struct platform_device_id *id;
>=20
>  =C2=A0=C2=A0=C2=A0 id =3D platform_get_device_id(pdev);
>  =C2=A0=C2=A0=C2=A0 chip_info =3D (const struct ad7606_chip_info *)id->dr=
iver_data;
> } else {
>  =C2=A0=C2=A0=C2=A0 struct device *dev =3D &pdev->dev;
>  =C2=A0=C2=A0=C2=A0 chip_info =3D device_get_match_data(dev);
> }

Yes, something along those lines makes sense.

If there are enough instances of this we can have a standard
definition for this similar to the i2c / spi ones that defaults
to device_get_match_data() if available, and falls back to the old
way if not.

If you want to add that great, if not it can be a separate
bit of work for another day.

Jonathan





