Return-Path: <linux-pwm+bounces-3022-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4695353E
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 16:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C61F2A078
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEAA1A00E7;
	Thu, 15 Aug 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOgYdI0R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64763D5;
	Thu, 15 Aug 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732540; cv=none; b=R58KhC9wXYILIWqlyateweQ9EtDF5zn7X70KmNRPgzmmPk1OchBhAOTUvYW2hsdkqPU7wvPgOV6Z3y0g39GETItelrJLC6LSfOXEf0k+jAspaZy71Z1vDaY/m3+WLzmrjboZGSlDfJzb4fLReWDBBDAyj/CGxrFki7OvZhy4I4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732540; c=relaxed/simple;
	bh=QTqPFqf58R7qfq3RSaFdp06zQmjhjZVPSRi/viE3tHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfAzFXS2jz8Qr5Twy2xwjeB7Yka6QUMSzJ3L6038fMfqTodSWB1FGmCjP1dfz5j4XcnwsEdf1LbilVmzWZMLAVE8t+f2KJWQDCJcuvwhFUVb0BT539qXNIi0lpRBQTSgN2W/D8lkZoV6kN9ITXFhpMtpXq+NSGgAc0+EfMZioKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOgYdI0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342BAC4AF0C;
	Thu, 15 Aug 2024 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723732540;
	bh=QTqPFqf58R7qfq3RSaFdp06zQmjhjZVPSRi/viE3tHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOgYdI0RtjI3aeU7/fWc4Z2qAIGWelWfGHJN0sznAcAFS9R1aULWtK6eaMMdgTleM
	 V2hZWQjQog596gYVxoMV/zoI7xEwrE38dLpLMGsISS6axy8w+zteSHq0EOqWFuvtM7
	 ZjVuM3XRUj7mNVslAChsuUvIoBQ7LAouYyjf015tKoa7fn48Rj1ber5o+VYm44gH51
	 nEhM/WrXQwEKhyqGPSowU2KXgwwoNmrdYXBbrQXctBXW2Lb+KemvK9d13QwIYMfh4F
	 hxDU0BzqBBjxjvVlBWIh4I3hHo6Ak7bLiU2eMTdG2JSRlJ5AZ88x9YnWFj6NSZYTpc
	 +jbQ6mRmPdNhg==
Date: Thu, 15 Aug 2024 15:35:34 +0100
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
	linux-doc@vger.kernel.org,
	20240705211452.1157967-2-u.kleine-koenig@baylibre.com,
	20240712171821.1470833-2-u.kleine-koenig@baylibre.com,
	cover.1721040875.git.u.kleine-koenig@baylibre.com,
	aardelean@baylibre.com
Subject: Re: [PATCH 1/8] dt-bindings: iio: adc: ad7606: Make corrections on
 spi conditions
Message-ID: <20240815-reword-wildland-1319629f0718@spud>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
 <20240815-ad7606_add_iio_backend_support-v1-1-cea3e11b1aa4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UJJuTW6LWkpDszvK"
Content-Disposition: inline
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-1-cea3e11b1aa4@baylibre.com>


--UJJuTW6LWkpDszvK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:11:55PM +0000, Guillaume Stols wrote:
> The SPI conditions are not always required, because there is also a
> parallel interface. The way used to detect that the SPI interface is
> used is to check if the reg value is between 0 and 256.
> There is also a correction on the spi-cpha that is not required when SPI
> interface is selected, while spi-cpol is.

This feels like it should be two patches, with the first having a Fixes:
tag etc, if the original binding was incorrect.

>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml         | 17 +++++++++++=
+++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 69408cae3db9..c0008d36320f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -117,15 +117,26 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - spi-cpha
>    - avcc-supply
>    - vdrive-supply
>    - interrupts
>    - adi,conversion-start-gpios
> =20
> -allOf:
> -  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +# This checks if reg is a chipselect so the device is on an SPI
> +# bus, the if-clause will fail if reg is a tuple such as for a
> +# platform device.
> +if:
> +  properties:
> +    reg:
> +      minimum: 0
> +      maximum: 256
> +then:
> +  allOf:
> +    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +    - required:
> +        - spi-cpol
> =20
> +allOf:
>    - if:
>        properties:
>          compatible:
>=20
> --=20
> 2.34.1
>=20

--UJJuTW6LWkpDszvK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4SNgAKCRB4tDGHoIJi
0la6AP0Uurd8ttJzgexIAZHCyhGt1quMRRW5eMQXppSCsohCvwEA78I0P+LSV13j
8gxpIkzC5+6L9sEJ0/3AqkQ1PtInWAc=
=xjNl
-----END PGP SIGNATURE-----

--UJJuTW6LWkpDszvK--

