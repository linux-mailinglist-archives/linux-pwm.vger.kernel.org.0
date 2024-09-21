Return-Path: <linux-pwm+bounces-3319-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4336397DF24
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Sep 2024 23:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1F31C20B3B
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Sep 2024 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8713154442;
	Sat, 21 Sep 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgEdkJIP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E37581A;
	Sat, 21 Sep 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726955723; cv=none; b=jWFAGXxoDLjde0Fp15eddkSs7LVIQ3xdrB+GSW/GlHjH1rLyKUaGqIzDOMbrtIsl88sDSjE2oy4SW7t9xrTIj6Xwhd7h4LmVhjHm/JfkkfS/rg7Mm9ESEwBqqL2l7Rgu72qs5vlJoqT+b7p4OovlzLmFPQ+AsC57WJSBfaxisyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726955723; c=relaxed/simple;
	bh=7XS9d2bm31MIgbCRQRhtMz2AwzaZBiZvT13Za+UkIoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkywL2ajtHMXbwFJaXEXe7Q8Q1FU4h16hzsIaTkMS18+Zfd5tI0ui6yVPhH8CaBf9fkM8SQ8hJQF/GCVoowx0286oYhiZmuVtUPoBcjeY9cHKfJFQhTghwoyb9vwi5ekMiAl8q03qv09c/E9AY8DWeJZy9o1CH/fL+6l7SPhf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgEdkJIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11575C4CEC2;
	Sat, 21 Sep 2024 21:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726955723;
	bh=7XS9d2bm31MIgbCRQRhtMz2AwzaZBiZvT13Za+UkIoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgEdkJIPxrf+IsjksNAka5e894adZO2xiw3E4Oi1ItXgDf6zbhW3e3tugNrm8lgej
	 zP7W3Q0LLKRDTCi3FL/sC+TGwRQw2VRtgTU8WDiIpEm1CV+8h1PyHgc69Na5a+tfNx
	 dkHKKNA616KvO+ej3YDMlTFBgGAfnMxmcngiR0Sl3DkpftmZ9hGH4QtPSGlGiidgxo
	 TyDYpWAHZZ4zdY0dtyWAUmXi9lrmsm4LccmKVoCDrvH6Kr7x2iJB3Z/d358Wpr06PT
	 X5s3PqvcMn2oiTd0Hzt+F70+it2VI8cgb1y6434AVSo+Xm+T1M2krDsRCrreZzWMES
	 rPT0kJbNItIlQ==
Date: Sat, 21 Sep 2024 22:55:16 +0100
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
	Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	aardelean@baylibre.com, dlechner@baylibre.com,
	jstephan@baylibre.com
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: adc: ad7606: Make corrections
 on spi conditions
Message-ID: <20240921-playgroup-regally-f26c17be26dc@spud>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-2-0e78782ae7d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MpOwvn7LyuIJqbDl"
Content-Disposition: inline
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-2-0e78782ae7d0@baylibre.com>


--MpOwvn7LyuIJqbDl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 05:33:22PM +0000, Guillaume Stols wrote:
> The SPI conditions are not always required, because there is also a
> parallel interface. The way used to detect that the SPI interface is
> used is to check if the reg value is between 0 and 256.

And, yaknow, not that the bus you're on is a spi bus? I don't think this
comment is relevant to the binding, especially given you have a property
for it.

> There is also a correction on the spi-cpha that is not required when SPI
> interface is selected, while spi-cpol is.

I don't see this change in your patch, there's no cpha in the before.

>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml      | 20 ++++++++++++++=
+++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 75334a033539..12995ebcddc2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -112,18 +112,32 @@ properties:
>        assumed that the pins are hardwired to VDD.
>      type: boolean
> =20
> +  parallel-interface:
> +    description:
> +      If the parallel interface is used, be it directly or through a bac=
kend,
> +      this property must be defined.
> +    type: boolean

The type you would want here is actually "flag", but I'm not sure why a
property is needed. If you're using the parallel interface, why would
you still be on a spi bus? I think I'm a bit confused here as to how
this interface is supposed to be used.

Thanks,
Conor.

> +
>  required:
>    - compatible
>    - reg
> -  - spi-cpol
>    - avcc-supply
>    - vdrive-supply
>    - interrupts
>    - adi,conversion-start-gpios
> =20
> -allOf:
> -  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +oneOf:
> +  - required:
> +      - parallel-interface
> +  - allOf:
> +      - properties:
> +          parallel-interface: false
> +          spi-cpol: true
> +      - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +      - required:
> +          - spi-cpol
> =20
> +allOf:
>    - if:
>        properties:
>          compatible:
>=20
> --=20
> 2.34.1
>=20

--MpOwvn7LyuIJqbDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZu9AxAAKCRB4tDGHoIJi
0szEAQD4Iua6jaPHHboIFBdWnkPMYPyE+5xnMxpdufGnjSD69wEA48k/jKGNfYl5
OXlmWcAd7ECPvIYd92IB0YOa0CDpmgM=
=bMUj
-----END PGP SIGNATURE-----

--MpOwvn7LyuIJqbDl--

