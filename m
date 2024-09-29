Return-Path: <linux-pwm+bounces-3390-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9DE98954D
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DDF1C21695
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76889176FA4;
	Sun, 29 Sep 2024 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5+kpIhX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF811DFF0;
	Sun, 29 Sep 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727612616; cv=none; b=c8BPQdVgFk/xflSoIcatBCBmjPrcP6HI/9UoEXVbV4LNFLqL46Lup7LQKnu94BYHUpmFjx3BJNvzuGnP8/mlBnSx/fl8ajS5V6fZdfScAU+Q8eGE6L17Rx2g38vFHcelaw8e888Vshd6WaDv+JR3rB9Ez5/8uYkyK8r67tpFB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727612616; c=relaxed/simple;
	bh=9vvd/AnELVNbNgBOq5qzm33t5mZauECMr7Mca1EEq/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jaiai2mpNMOhnomHtHDHTyFhwSFAoc9N3QbNpXvzZWAWrPmw7tyLJAKLkUTe0ZQmnYNJpUd8uTp+7i6Wq8Y4QCNfaMEtFYAJYWakKu9ALrOOS/DTUeJEAcw2Ep2whrc1dfukQ69h5iAEQdyeeVyibldcoCAS5pdd8ieORzpeUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5+kpIhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94069C4CEC5;
	Sun, 29 Sep 2024 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727612615;
	bh=9vvd/AnELVNbNgBOq5qzm33t5mZauECMr7Mca1EEq/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V5+kpIhX5PshRlqx8uI1Ti7GhQ/7ZkAAJVrqQgSAV4m4+RCxpmmVNLfEC3Cl27KMv
	 BXCr9jia+J8aeD9/oI+/5Clv97wV/c5HyzO/eSSHMaF7kdQT6QBQJWkvoN9YP/SRGc
	 2fM5o2AraqCFJS7vQBjMLYYdUsMR2sXqcRQLy7DsGVBPhhXFDEDC04hjA3Ade6MT3D
	 eO39OIi1nxsqVKXw4LE3v/P1j122CDFhSv1CIIouF/0rr19aTZgnMyE/D3L+0Z+ZcU
	 Vm6F4eAD+x0jxzkeyhgCPi0sqyEr3zuB5LXcYfsNFDH3yCilhFDAwDVmaFv5+Rog/z
	 FJZnYC/iRfEEw==
Date: Sun, 29 Sep 2024 13:23:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 01/10] dt-bindings: iio: adc: ad7606: Set the correct
 polarity
Message-ID: <20240929132323.662fa5cb@jic23-huawei>
In-Reply-To: <7mk56pxpgnlu637xo7yypzfdienyh3doch3l3fkinpqbwihf33@nu7v35gdw5zn>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-1-0e78782ae7d0@baylibre.com>
	<7mk56pxpgnlu637xo7yypzfdienyh3doch3l3fkinpqbwihf33@nu7v35gdw5zn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Sep 2024 11:11:31 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Guillaume,
>=20
> On Fri, Sep 20, 2024 at 05:33:21PM +0000, Guillaume Stols wrote:
> > According to the datasheet, "Data is clocked in from SDI on the falling
> > edge of SCLK, while data is clocked out on DOUTA on the rising edge of
> > SCLK".
> > Also, even if not stated textually in the datasheet, it is made clear on
> > the diagrams that sclk idles at high.
> >=20
> > So the documentation is erroneously stating that spi-cpha is required, =
and
> > the example is erroneously setting both spi-cpol and spi-cpha. =20
>=20
> I would expect that the communication with the chip is at least
> unreliable if not outright broken with the wrong polarity. So maybe add
> something like:
>=20
> 	On $MyMachine dropping the spi-cpha property reduces IO errors / fixes
> 	measurement readout / improves somehow differently.
>=20
> to the commit log?
>=20
> > Fixes: 416f882c3b40 ("dt-bindings: iio: adc: Migrate AD7606 documentati=
on to yaml")
> > Fixes: 6e33a125df66 ("dt-bindings: iio: adc: Add docs for AD7606 ADC")
> >=20
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com> =20
>=20
> The empty line between Fixes and S-o-b is unusual. Assuming you resend
> anyway, please drop it.

It's also scanned for in linux-next so to reduce chances I forget to fix th=
is
definitely resend.

>=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > index 69408cae3db9..75334a033539 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > @@ -29,8 +29,6 @@ properties:
> >    reg:
> >      maxItems: 1
> > =20
> > -  spi-cpha: true
> > -
> >    spi-cpol: true
> > =20
> >    avcc-supply: true
> > @@ -117,7 +115,7 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - spi-cpha
> > +  - spi-cpol =20
>=20
> Adding cpol seems unrelated to this patch. (And you remove it again in
> patch #2.)
>=20
> >    - avcc-supply
> >    - vdrive-supply
> >    - interrupts =20
>=20
> Best regards
> Uwe


